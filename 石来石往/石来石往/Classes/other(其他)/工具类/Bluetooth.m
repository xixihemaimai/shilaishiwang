#import <Foundation/Foundation.h>
#include "Bluetooth.h"


@interface Bluetooth ()<UIAlertViewDelegate>
- (void)waitUI:(int)ms;


@property (strong, nonatomic) BLOCK_CALLBACK_SCAN_FIND scanFindCallback;
@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) CBPeripheral* peripheral;
@property int connectState;
@property (strong, nonatomic) CBCharacteristic* writeCharacteristic;
@property (strong, nonatomic) CBCharacteristic* readCharacteristic;
@property (strong, nonatomic) NSMutableArray* nServices;
@end

@implementation Bluetooth


static Byte receiveBuffer[1024];
static int receiveLength=0;

//开始查看服务, 蓝牙开启
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state == CBCentralManagerStatePoweredOn) {
      //  NSLog(@"设备开启着");
    }else{
       // NSLog(@"蓝牙设备关着");
        UIAlertView * alerview = [[UIAlertView alloc]initWithTitle:@"亲，请开启蓝牙哦" message:@"只有打开蓝牙才能搜索到设备" delegate:self cancelButtonTitle:@"不开启" otherButtonTitles:@"开启", nil];
        [alerview show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [SVProgressHUD showInfoWithStatus:@"请自己去设置界面开启蓝牙"];

    }
}


- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    //NSLog(@"已发现 peripheral: %@ rssi: %@, advertisementData: %@", peripheral, RSSI, advertisementData);
    self.scanFindCallback(peripheral);
}

//连接外设成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
   // NSLog(@"成功连接 peripheral: %@",peripheral);
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
   // NSLog(@"扫描服务...");
}

//掉线时调用
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    //NSLog(@"periheral has disconnect %@",error);
    self.connectState=-1;
}

//连接外设失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
   // NSLog(@"connect fail %@", error);
    self.connectState=-1;
}


//已发现服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
   // NSLog(@"发现服务!");
    int i = 0;
    for(CBService* s in peripheral.services){
        [self.nServices addObject:s];
    }
    for(CBService* s in peripheral.services){
       // NSLog(@"%d :服务 UUID: %@(%@)", i, s.UUID.data, s.UUID);
        i++;
        [peripheral discoverCharacteristics:nil forService:s];
       // NSLog(@"扫描Characteristics...");
    }
}

//已发现characteristcs49535343-8841-43f4-a8d4-ecbe34729bb3
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    for(CBCharacteristic* c in service.characteristics){
      //  NSLog(@"特征 UUID: %@ (%@)", c.UUID.data, c.UUID);
        if([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]){
            self.writeCharacteristic = c;
            //            [self.myPeripheral setNotifyValue:YES forCharacteristic:c];
            //            [self.myPeripheral readValueForCharacteristic:c];
          //  NSLog(@"找到WRITE : %@", c);
            self.connectState=1;
        }else if([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]){
            self.readCharacteristic = c;
            //            CBDescriptor* description = [self.myPeripheral description];
            //            [description setValue:<#(id)#> forKey:<#(NSString *)#>];
            [self.peripheral setNotifyValue:YES forCharacteristic:c];
            [self.peripheral readValueForCharacteristic:c];
         //   NSLog(@"找到READ : %@", c);
        }
    }
}

//获取外设发来的数据,不论是read和notify,获取数据都从这个方法中读取
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{[peripheral readRSSI];
    if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]){
        NSData* data = characteristic.value;
        if(data!=nil)
        {
            //NSLog(@"didUpdateValueForCharacteristic :%@",data);
            Byte *pData=[data bytes];
            for(int i=0;i<[data length];i++)
            {
                receiveBuffer[receiveLength++]=pData[i];
            }
        }
    }
}

- (void)scanStart:(BLOCK_CALLBACK_SCAN_FIND)callback
{
    self.scanFindCallback=callback;
    if(self.centralManager==nil)
    {
        self.centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil options:nil];
    }
    [self.centralManager stopScan];
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds* NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //NSLog(@"扫描外设...");
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
        if(self.peripheral != nil){
            [self.centralManager cancelPeripheralConnection:self.peripheral];
        }
    });
}

- (void)scanStop
{
    [self.centralManager stopScan];
   // NSLog(@"停止扫描!");
}

- (void)waitUI:(int)ms
{
    CFRunLoopRef currentLoop = CFRunLoopGetCurrent();
    double delayInSeconds = ms/1000.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds* NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        CFRunLoopStop(currentLoop);
    });
    CFRunLoopRun();
}

- (bool)open:(CBPeripheral *)peripheral {
    [self.centralManager stopScan];
    self.peripheral=peripheral;
    self.connectState=0;
    [self.centralManager connectPeripheral: self.peripheral  options:nil];
    while(self.connectState==0)
    {
        [self waitUI:50];
    }
    if(self.connectState!=1)return false;
    receiveLength=0;
    return true;
}

- (void)close
{
    [self waitUI:10000];
    [self.centralManager cancelPeripheralConnection:self.peripheral];
}



- (bool)writeData:(NSData*)data
{
       int sended=0;
       while(sended<data.length)
    {
        int len=data.length-sended;
        if(len>120)len=120;
        NSData *d = [data subdataWithRange:NSMakeRange(sended, len)];
        [self.peripheral writeValue:d forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];
        sended+=len;
    }
    return true;
}

- (void)flushRead
{
    receiveLength=0;
}

- (bool)readBytes:(BytePtr)data len:(int)len timeout:(int)timeout
{
    for(int i=0;i<timeout/10;i++)
    {
        if(receiveLength>=len)break;
        [self waitUI:10];
    }
    if(receiveLength<len)return false;
    for(int i=0;i<len;i++)
    {
        data[i]=receiveBuffer[i];
    }
    for(int i=len;i<receiveLength;i++)
    {
        receiveBuffer[i-len]=receiveBuffer[i];
    }
    receiveLength-=len;
    return true;
    
   
}
/*
 * 绘制打印页面
 */
-(void)StartPage:(int) pageWidth  pageHeight:(int)pageHeight
{

    
    NSString *stringInt = [NSString stringWithFormat:@"%d",pageHeight];
    NSString *pageWidths = [NSString stringWithFormat:@"%d",pageWidth];
    
    
    
    [self addC:@"! 0 200 200 "];
    [self  addC:stringInt];
    [self addC:@" "];
    [self addC:@"1\r\n"];
    [self addC:@"PAGE-WIDTH "];
    [self addC:pageWidths];
    [self addC:@"\r\n"];
    
    [self addC:@"GAP-SENSE "];/////
    
    
    
}

/*
 * 绘制打印页面结束
 */
-(void)end{
    //FORM\r\n
    [  self addC:@"PRINT\r\n"];
}

/*
 * 绘制text  x y为坐标，
 text为内容；
 font为字体，有24点阵和16点阵，24点阵填24，16点阵填55；
 fontsize 放大的倍数，填1表示 1乘以字体大小（等于没变大），所以想变大至少乘以2.
 */

-(void)zp_drawText:(int)x y:(int)y text:(NSString*)text font:(int)font fontsize:(int)fontsize bold:(int)bold rotate:(int) rotate;
{
    NSString *xx = [NSString stringWithFormat:@"%d",x];
    NSString *yy = [NSString stringWithFormat:@"%d",y];
    NSString *_font = [NSString stringWithFormat:@"%d",font];
    NSString *_fontsize = [NSString stringWithFormat:@"%d",fontsize];

    
    [self addC:@"SETMAG "];
    [self addC:_fontsize];
    [self addC:@" "];
    [self addC:_fontsize];
    [self addC:@"\r\n"];
    if (bold==1) {
        [self addC:@"SETBOLD 1\r\n"];
    }
    else{
        [self addC:@"SETBOLD 0\r\n"];
    }
    if(rotate==0)
       [self addC:@"T "];
    if(rotate==90)
        [self addC:@"VT "];
    if(rotate==180)
        [self addC:@"T180 "];
    if(rotate==270)
        [self addC:@"T270 "];
    [self addC:_font];
    [self addC:@" "];
    [self addC:@"0 "];
    [self addC:xx];
    [self addC:@" "];
    [self addC:yy];
    [self addC:@" "];
    [self addC:text];
    [self addC:@"\r\n"];
    
    [self addC:@"SETMAG "];
    [self addC:@"1 "];
    [self addC:@"1 "];
    [self addC:@"\r\n"];
    
}


-(void)zp_drawLine:(int)startPointX startPiontY:(int)startPointY endPointX:(int)endPointX endPointY:(int)endPointY width:(int)width
{
    NSString *strsx = [NSString stringWithFormat:@"%d",startPointX];
    NSString *strsy = [NSString stringWithFormat:@"%d",startPointY];
    NSString *strsex = [NSString stringWithFormat:@"%d",endPointX];
    NSString *strey = [NSString stringWithFormat:@"%d",endPointY];
    NSString *wi = [NSString stringWithFormat:@"%d",width];
    
    
    [self addC:@"LINE "];
    [self addC:strsx];
    [self addC:@" "];
    [self addC:strsy];
    [self addC:@" "];
    [self addC:strsex];
    [self addC:@" "];
    [self addC:strey];
    [self addC:@" "];
    [self addC:wi];
    [self addC:@"\r\n"];
    
}


/*
 *一维条码绘制
 */
-(void)zp_darw1D_barcode:(int)x y:(int)y  height:(int)height text:(NSString*)text
{

    NSString *xx = [NSString stringWithFormat:@"%d",x];
    NSString *yy = [NSString stringWithFormat:@"%d",y];
    NSString *heights = [NSString stringWithFormat:@"%d",height];
    NSString *CODE128 = [NSString stringWithFormat:@"%d",128];
    [self addC:@"B "];
    [self addC:CODE128];
    [self addC:@" "];
    [self addC:@"1 "];
    [self addC:@"1 "];
    [self addC:heights];
    [self addC:@" "];
    [self addC:xx];
    [self addC:@" "];
    [self addC:yy];
    [self addC:@" "];
    [self addC:text];
    [self addC:@"\r\n"];
    
}


/*
 * QRCode
 *
 
 */
-(void) zp_darwQRCode:(int)x y:(int)y unit_width:(int)unit_width  text:(NSString*)text
{

    NSString *xx = [NSString stringWithFormat:@"%d",x];
    NSString *yy = [NSString stringWithFormat:@"%d",y];

    NSString *unit_widthss = [NSString stringWithFormat:@"%d",unit_width];
    [self addC:@"B QR "];
    [self addC:xx];
    [self addC:@" "];
    [self addC:yy];
    [self addC:@" "];
    [self addC:@"M 2"];
    [self addC:@" U "];
    [self addC:unit_widthss];
    [self addC:@"\r\n"];
    [self addC:@"MA,"];
    [self addC:text];
    [self addC:@"\r\n"];
    [self addC:@"ENDQR\r\n"];
}


-(void)zp_darwRect:(int)left top:(int)top right:(int)right bottom:(int)bottom width:(int)width 
{

    NSString *lefts = [NSString stringWithFormat:@"%d",left];
    NSString *tops = [NSString stringWithFormat:@"%d",top];
    NSString *rights = [NSString stringWithFormat:@"%d",right];
    NSString *bottoms = [NSString stringWithFormat:@"%d",bottom];
    NSString *widths = [NSString stringWithFormat:@"%d",width];
    [self addC:@"BOX "];
    [self addC:lefts];
    [self addC:@" "];
    [self addC:tops];
    [self addC:@" "];
    [self addC:rights];
    [self addC:@" "];
    [self addC:bottoms];
    [self addC:@" "];
    [self addC:widths];
    [self addC:@"\r\n"];
}

-(void) zp_darwlogo:(int)x y:(int)y
{
    NSString * str = [NSString stringWithFormat:@"EG 9 72 %d %d ",x,y];
   // [self addC:@"EG 9 72 0 0 "];
    [self addC:str];
    [self addC:@"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1FFFFE7FFFFFEFFFF800000000000F001FF000000000000E040FF01FFFFF00000C0C0FF03FFFFF03FFFC1E0FF83FFFFF03FFFE3E0FF83F2FFF03FFFFFE1FF81E070700FFFFFE3FF81E07038070EFFFFFF81F07038070EFFFFFF80F0703C070FF0FFFF80F0703C070FF0FFFF8070783C0F0EFFFDFF8070781E0F3EFFF1FF8030701E1FFFFFE0FF8038301C1FFFEFF0FFFFFC70380E1EE3F0FFFFFFFFF80000F0F0FFFFFFFFF00000F070FFBFFFFFF00000F878FF800000707FFFFFFCFF000000707FFFFFF8FF0070007013EF9FF8FF80E0007001800038FF80F0007003807838FF81FCC0F00380FE38FF81FFFFF007C7FFF8FF80FFFFF007FFDFF8FF807FFFF003FF01FCFF8000000001FC00F8FF8000000000000030FF0000000000000000FF0000000000000000FF180E01800010C000FF3C1F03800030FC00FF3C0F038000787FE0FFFC0F038000781FF0FFFC0F83D0003C0FF0FFFFFFFFFE003C07F0FFFFFFFFFF7F7F0FFFFF9FFFFFFE7FFFFFFFFF8007E3CC7FFFFFFFFF0007C3C030CFCFDFFF9807C3C030C78783FF3C0FE7C01863FF00FF3C0FC7E01C3FFF00FF1C1FE7F00E1F1FC0FF1C1FF1E00F0F0FE0FF1C0C3CC00383FFFFFF1C0C3CCE01C1FFFFFF1FFC1CFE0CF07FFFFF1FFC08FE1CF83FFFFF1FFC00FC1C3FDFC1FF1FFC00FC383FFFC0FF3C1E1CF0780FFFC0FF3C0E3CC07803FFC0FF3C0E7CC07E003FC0FF3C0FFFC07FE00FC0FF3C0FFFC03FFFFFC0FF3C0FFFE01FFFFFC0FF1C07C7E007FFFFE0FF1C0003E0001FFFC0FF980000C000000F80FFBC0000E020001F99FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"];
    [self addC:@"\r\n"];
}


@synthesize dataLength;
-(id)init{
    self = [super init];
    _offset = 0;
    _sendedDataLength = 0;
    return self;
}

-(void)reset{
    _offset = 0;
    _sendedDataLength = 0;
}

-(int) getDataLength{
    return _offset;
}

-(BOOL) addData:(Byte *)data length:(int)length{
    if (_offset + length > MAX_DATA_SIZE)
        return FALSE;
    memcpy(_buffer + _offset, data, length);
    _offset += length;
    return TRUE;
}

-(BOOL) addByte:(Byte)byte{
    if (_offset + 1 > MAX_DATA_SIZE)
        return FALSE;
    _buffer[_offset++] = byte;
    return TRUE;
}

-(BOOL) addShort:(ushort)data{
    if (_offset + 2 > MAX_DATA_SIZE)
        return FALSE;
    _buffer[_offset++] = (Byte)data;
    _buffer[_offset++] = (Byte)(data>>8);
    return TRUE;
}

-(BOOL) add:(NSString *)text{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* gbk = [text dataUsingEncoding:enc];
    Byte* gbkBytes = (Byte*)[gbk bytes]  ;
    if(![self addData:gbkBytes length:gbk.length])
        return FALSE;
    return [self addByte:0x00];
}

-(BOOL) addC:(NSString *)text{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* gbk = [text dataUsingEncoding:enc];
    Byte* gbkBytes = (Byte*)[gbk bytes]  ;
    if(![self addData:gbkBytes length:gbk.length])
        return FALSE;
    return true;
}

-(NSData*) getData:(int)sendLength{
    NSData *data;
    data = [[NSData alloc]initWithBytes:_buffer+_sendedDataLength length:sendLength];
    //_offset -= sendLength;
   // _sendedDataLength +=sendLength;
    return data;
}


@end


