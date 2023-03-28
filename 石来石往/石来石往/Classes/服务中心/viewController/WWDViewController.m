//
//  WWDViewController.m
//  MyBleTest2
//
//  Created by maginawin on 14-8-11.
//  Copyright (c) 2014年 mycj.wwd. All rights reserved.
//

#import "WWDViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "Bluetooth.h"


#import "RSPrintModel.h"
#import "RSPrintSecondModel.h"


#import "RSWWMenuView.h"

#define margin 10
#define ECA 2

#import "RSERROExceptTool.h"



@interface WWDViewController ()<RSWWMenuViewdelegate>
{
    UIView * _menview;
}

@property (strong, nonatomic) Bluetooth* bluetooth;
@property (strong, nonatomic) CBPeripheral* peripheral;
@property (strong, nonatomic) NSMutableArray* listDevices;
@property (strong, nonatomic) NSMutableString* listDeviceInfo;


@property (nonatomic,strong)NSMutableArray * printDataArray;


@end

@implementation WWDViewController

- (NSMutableArray *)printDataArray{
    if (_printDataArray == nil) {
        _printDataArray = [NSMutableArray array];
    }
    return _printDataArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"打印";
    
    //    RSNavigationButton  * backItem = [RSNavigationButton buttonWithType:UIButtonTypeCustom];
    //    [backItem setImage:[UIImage imageNamed:@"title_bar_back"] forState:UIControlStateNormal];
    //    [backItem addTarget:self action:@selector(backcenterLeftViewController) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:backItem];
    //    self.navigationItem.leftBarButtonItem = item;
    
    self.listDeviceInfo = [NSMutableString stringWithString:@""];
    self.listDevices = [NSMutableArray array];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.bluetooth = [[Bluetooth alloc]init];
    [self loadPrintData];
}

- (void)loadPrintData{
    [SVProgressHUD showWithStatus:@"正在获取打印内容中.........."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.outStr forKey:@"qrCode"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETPRINTOUTBOUND_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                if (array.count > 0) {
                    for (int i = 0; i < array.count; i++) {
                        RSPrintModel * printmodel = [[RSPrintModel alloc]init];
                        printmodel.outDate = [[array objectAtIndex:i]objectForKey:@"outDate"];
                        printmodel.outType = [[array objectAtIndex:i]objectForKey:@"outType"];
                        printmodel.outbountNo = [[array objectAtIndex:i]objectForKey:@"outbountNo"];
                        printmodel.ownerName = [[array objectAtIndex:i]objectForKey:@"ownerName"];
                        printmodel.pageNum = [[[array objectAtIndex:i]objectForKey:@"pageNum"] integerValue];
                        printmodel.sumVaqty = [[array objectAtIndex:i]objectForKey:@"sumVaqty"];
                        printmodel.totalQty = [[array objectAtIndex:i]objectForKey:@"totalQty"];
                        printmodel.erpOutboundNo = [[array objectAtIndex:i]objectForKey:@"erpOutboundNo"];
                        NSMutableArray * blockTempArray = [NSMutableArray array];
                        blockTempArray = [[array objectAtIndex:i]objectForKey:@"blocks"];
                        for (int j = 0; j < blockTempArray.count; j++) {
                            RSPrintSecondModel * printSecondmodel = [[RSPrintSecondModel alloc]init];
                            printSecondmodel.blockName = [[blockTempArray objectAtIndex:j]objectForKey:@"blockName"];
                            printSecondmodel.blockNo = [[blockTempArray objectAtIndex:j]objectForKey:@"blockNo"];
                            printSecondmodel.blockNum = [[[blockTempArray objectAtIndex:j]objectForKey:@"blockNum"] doubleValue];
                            printSecondmodel.csid = [[blockTempArray objectAtIndex:j]objectForKey:@"csid"];
                            printSecondmodel.locationName = [[blockTempArray objectAtIndex:j]objectForKey:@"locationName"];
                            printSecondmodel.qty = [[[blockTempArray objectAtIndex:j]objectForKey:@"qty"]integerValue];
                            printSecondmodel.slno = [[blockTempArray objectAtIndex:j]objectForKey:@"slno"];
                            printSecondmodel.turnsNo = [[blockTempArray objectAtIndex:j]objectForKey:@"turnsNo"];
                            [printmodel.bolcks addObject:printSecondmodel];
                        }
                        [weakSelf.printDataArray addObject:printmodel];
                    }
                    [SVProgressHUD dismiss];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"没有打印内容"];
                }
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"没有数据"];
        }
    }];
}

- (IBAction)connDevice:(id)sender{
    if(_listDevices != nil){
        _listDevices = nil;
        _listDevices = [NSMutableArray array];
        [_tableView reloadData];
    }
    BLOCK_CALLBACK_SCAN_FIND callback =
    ^( CBPeripheral*peripheral)
    {
        [self.listDevices addObject:peripheral];
        // NSLog(@"scan find: %@",self.listDevices );
        [_tableView reloadData];
    };
    [self.bluetooth scanStart:callback];
    double delayInSeconds = 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds* NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.bluetooth scanStop];
    });
}

//- (void)backcenterLeftViewController{
//    [self.navigationController popViewControllerAnimated:YES];
//}



//tableview的方法,返回section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//tableview的方法,返回rows(行数)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listDevices.count;
}

//tableview的方法,返回cell的view
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //为表格定义一个静态字符串作为标识符
    static NSString* WWDCELLId = @"WWDCELLId";
    //从IndexPath中取当前行的行号
    NSUInteger rowNo = indexPath.row;
    // [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:WWDCELLId];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:WWDCELLId forIndexPath:indexPath];
    // UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:WWDCELLId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WWDCELLId];
    }
    UILabel* labelName = (UILabel*)[cell viewWithTag:1];
    UILabel* labelUUID = (UILabel*)[cell viewWithTag:2];
    labelName.text = [[_listDevices objectAtIndex:rowNo] name];
    NSString* uuid = [NSString stringWithFormat:@"%@", [[_listDevices objectAtIndex:rowNo] identifier]];
    uuid = [uuid substringFromIndex:[uuid length] - 13];///////////////////////mac
    labelUUID.text = uuid;
    return cell;
}

//tableview的方法,点击行时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.peripheral =[_listDevices objectAtIndex:indexPath.row];
    if ([self.peripheral.name containsString:@"HDT"] && self.printDataArray.count > 0) {
        self.write.enabled = YES;
        [self.write setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    }else{
        self.write.enabled = NO;
        [self.write setTitleColor:[UIColor colorWithHexColorStr:@"#d6d6d6"] forState:UIControlStateNormal];
    }
}






//FIXME:打印界面 -- 现在没有用到
- (void)wrapPrintDatas
{
}


- (void)printBLView:(RSPrintModel *)printmodel{
    //荒料打印界面
    [self.bluetooth StartPage:1100 pageHeight:2000];
    [self.bluetooth zp_darwRect:110 top:100 right:710 bottom:1810 width:1];
    
    //打印竖线
    [self.bluetooth zp_drawLine:160 startPiontY:100 endPointX:160 endPointY:1810 width:2];
    [self.bluetooth zp_drawLine:210 startPiontY:100 endPointX:210 endPointY:1810 width:2];
    [self.bluetooth zp_drawLine:260 startPiontY:100 endPointX:260 endPointY:1810 width:2];
    [self.bluetooth zp_drawLine:310 startPiontY:100 endPointX:310 endPointY:1810 width:2];
    [self.bluetooth zp_drawLine:360 startPiontY:100 endPointX:360 endPointY:1810 width:2];
    [self.bluetooth zp_drawLine:410 startPiontY:100 endPointX:410 endPointY:1810 width:2];
    [self.bluetooth zp_drawLine:460 startPiontY:100 endPointX:460 endPointY:1810 width:2];
    [self.bluetooth zp_drawLine:510 startPiontY:100 endPointX:510 endPointY:1810 width:2];
    [self.bluetooth zp_drawLine:560 startPiontY:100 endPointX:560 endPointY:1810 width:2];
    [self.bluetooth zp_drawLine:610 startPiontY:100 endPointX:610 endPointY:1810 width:2];
    [self.bluetooth zp_drawLine:660 startPiontY:100 endPointX:660 endPointY:1810 width:2];
    //打印横线
    [self.bluetooth zp_drawLine:160 startPiontY:500 endPointX:710 endPointY:500 width:2];
    [self.bluetooth zp_drawLine:160 startPiontY:800 endPointX:710 endPointY:800 width:2];
    [self.bluetooth zp_drawLine:160 startPiontY:1100 endPointX:710 endPointY:1100 width:2];
    [self.bluetooth zp_drawLine:160 startPiontY:1450 endPointX:710 endPointY:1450 width:2];
    //打印文字
    [self.bluetooth zp_drawText:700 y:250 text:@"物料名称" font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:700 y:580 text:@"园区荒料号" font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:700 y:880 text:@"客户荒料号" font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:700 y:1230 text:@"立方数" font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:700 y:1600 text:@"储位" font:8 fontsize:0 bold:0 rotate:270];
    NSString * outName = [NSString stringWithFormat:@"商户:%@",printmodel.ownerName];
    [self.bluetooth zp_drawText:740 y:100 text:outName font:8 fontsize:0 bold:0 rotate:270];
    NSString * outBounsNo = [NSString stringWithFormat:@"发货单号:%@",printmodel.outbountNo];
    [self.bluetooth zp_drawText:740 y:800 text:outBounsNo font:8 fontsize:0 bold:0 rotate:270];
    NSString * dateStr = [NSString stringWithFormat:@"打印时间:%@",printmodel.outDate];
    [self.bluetooth zp_drawText:740 y:1350 text:dateStr font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:830 y:800 text:@"海西荒料仓储出货单" font:14 fontsize:2 bold:0 rotate:270];
    //[self.bluetooth zp_drawText:140 y:250 text:@"备注:" font:8 fontsize:0 bold:0 rotate:270];
    NSString * totalStr =  [NSString stringWithFormat:@"总颗数:%@颗",printmodel.totalQty];
    [self.bluetooth zp_drawText:140 y:200 text:totalStr font:8 fontsize:0 bold:0 rotate:270];
    NSString * sumQty = [NSString stringWithFormat:@"总立方数:%@立方米",printmodel.sumVaqty];
    [self.bluetooth zp_drawText:140 y:500 text:sumQty font:8 fontsize:0 bold:0 rotate:270];
    //吊装签字
    [self.bluetooth zp_drawText:140 y:900 text:@"吊装签字:" font:8 fontsize:0 bold:0 rotate:270];
    //仓管签字
    [self.bluetooth zp_drawText:140 y:1300 text:@"仓管签字:" font:8 fontsize:0 bold:0 rotate:270];
    //打印图片
    [self.bluetooth zp_darwlogo:110 y:1740];
    //打印二维码
    [self.bluetooth zp_darwQRCode:720 y:1720 unit_width:3 text:self.outStr];
    for (int j = 0 ; j < printmodel.bolcks.count; j++) {
        RSPrintSecondModel * printsecondmodel = printmodel.bolcks[j];
        if (j == 0) {
            //打印物料名称
            [self.bluetooth zp_drawText:640 y:250 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockName] font:8 fontsize:0 bold:0 rotate:270];
            //打印园区荒料号
            [self.bluetooth zp_drawText:640 y:580 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockNo] font:8 fontsize:0 bold:0 rotate:270];
            //打印客户荒料号
            
            [self.bluetooth zp_drawText:640 y:880 text:[NSString stringWithFormat:@"%@",printsecondmodel.csid] font:8 fontsize:0 bold:0 rotate:270];
            //打印立方数
            [self.bluetooth zp_drawText:640 y:1230 text:[NSString stringWithFormat:@"%lf",printsecondmodel.blockNum] font:8 fontsize:0 bold:0 rotate:270];
            //储位
            [self.bluetooth zp_drawText:640 y:1540 text:[NSString stringWithFormat:@"%@",printsecondmodel.locationName] font:8 fontsize:0 bold:0 rotate:270];
            
        }else if (j == 1){
            
            [self.bluetooth zp_drawText:590 y:250 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockName] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:590 y:580 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockNo] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:590 y:880 text:[NSString stringWithFormat:@"%@",printsecondmodel.csid] font:8 fontsize:0 bold:0 rotate:270];
            
            
            [self.bluetooth zp_drawText:590 y:1230 text:[NSString stringWithFormat:@"%lf",printsecondmodel.blockNum] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:590 y:1540 text:[NSString stringWithFormat:@"%@",printsecondmodel.locationName] font:8 fontsize:0 bold:0 rotate:270];
            
        }else if (j== 2){
            [self.bluetooth zp_drawText:540 y:250 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockName] font:8 fontsize:0 bold:0 rotate:270];
            
            
            [self.bluetooth zp_drawText:540 y:580 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockNo] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:540 y:880 text:[NSString stringWithFormat:@"%@",printsecondmodel.csid] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:540 y:1230 text:[NSString stringWithFormat:@"%lf",printsecondmodel.blockNum] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:540 y:1540 text:[NSString stringWithFormat:@"%@",printsecondmodel.locationName]  font:8 fontsize:0 bold:0 rotate:270];
        }else if (j == 3){
            
            [self.bluetooth zp_drawText:490 y:250 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockName] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:490 y:580 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockNo] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:490 y:880 text:[NSString stringWithFormat:@"%@",printsecondmodel.csid] font:8 fontsize:0 bold:0 rotate:270];
            
            
            [self.bluetooth zp_drawText:490 y:1230 text:[NSString stringWithFormat:@"%lf",printsecondmodel.blockNum] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:490 y:1540 text:[NSString stringWithFormat:@"%@",printsecondmodel.locationName] font:8 fontsize:0 bold:0 rotate:270];
            
        }else if (j == 4){
            
            [self.bluetooth zp_drawText:440 y:250 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockName] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:440 y:580 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockNo] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:440 y:880 text:[NSString stringWithFormat:@"%@",printsecondmodel.csid] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:440 y:1230 text:[NSString stringWithFormat:@"%lf",printsecondmodel.blockNum] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:440 y:1540 text:[NSString stringWithFormat:@"%@",printsecondmodel.locationName] font:8 fontsize:0 bold:0 rotate:270];
            
        }else if (j == 5){
            [self.bluetooth zp_drawText:390 y:250 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockName] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:390 y:580 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockNo] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:390 y:880 text:[NSString stringWithFormat:@"%@",printsecondmodel.csid] font:8 fontsize:0 bold:0 rotate:270];
            
            
            [self.bluetooth zp_drawText:390 y:1230 text:[NSString stringWithFormat:@"%lf",printsecondmodel.blockNum] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:390 y:1540 text:[NSString stringWithFormat:@"%@",printsecondmodel.locationName] font:8 fontsize:0 bold:0 rotate:270];
        }else if (j == 6){
            [self.bluetooth zp_drawText:340 y:250 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockName] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:340 y:580 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockNo] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:340 y:880 text:[NSString stringWithFormat:@"%@",printsecondmodel.csid] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:340 y:1230 text:[NSString stringWithFormat:@"%lf",printsecondmodel.blockNum] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:340 y:1540 text:[NSString stringWithFormat:@"%@",printsecondmodel.locationName] font:8 fontsize:0 bold:0 rotate:270];
        }else if (j == 7){
            [self.bluetooth zp_drawText:290 y:250 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockName] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:290 y:580 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockNo] font:8 fontsize:0 bold:0 rotate:270];
            
            
            [self.bluetooth zp_drawText:290 y:880 text:[NSString stringWithFormat:@"%@",printsecondmodel.csid] font:8 fontsize:0 bold:0 rotate:270];
            
            
            [self.bluetooth zp_drawText:290 y:1230 text:[NSString stringWithFormat:@"%lf",printsecondmodel.blockNum] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:290 y:1540 text:[NSString stringWithFormat:@"%@",printsecondmodel.locationName] font:8 fontsize:0 bold:0 rotate:270];
        }else if (j == 8){
            
            [self.bluetooth zp_drawText:240 y:250 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockName] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:240 y:580 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockNo] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:240 y:880 text:[NSString stringWithFormat:@"%@",printsecondmodel.csid] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:240 y:1230 text:[NSString stringWithFormat:@"%lf",printsecondmodel.blockNum] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:240 y:1540 text:[NSString stringWithFormat:@"%@",printsecondmodel.locationName] font:8 fontsize:0 bold:0 rotate:270];
        }else if (j == 9){
            
            [self.bluetooth zp_drawText:190 y:250 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockName] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:190 y:580 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockNo] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:190 y:880 text:[NSString stringWithFormat:@"%@",printsecondmodel.csid] font:8 fontsize:0 bold:0 rotate:270];
            
            [self.bluetooth zp_drawText:190 y:1230 text:[NSString stringWithFormat:@"%lf",printsecondmodel.blockNum] font:8 fontsize:0 bold:0 rotate:270];
            [self.bluetooth zp_drawText:190 y:1540 text:[NSString stringWithFormat:@"%@",printsecondmodel.locationName] font:8 fontsize:0 bold:0 rotate:270];
        }
    }
    //[self.bluetooth zp_drawText:140 y:1550 text:dateStr font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth end];
}


//#pragma mark ---- 将时间戳转换成时间
//
//- (NSString *)getTimeFromTimestamp{
//
//    //设置时间格式
//    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//    //将时间转换为字符串
//    NSString *timeStr=[formatter stringFromDate:[NSDate date]];
//    return timeStr;
//
//}


- (void)printSLView:(RSPrintModel * )printmodel{
    //大板的输出环境
    [self.bluetooth StartPage:1100 pageHeight:2210];
    [self.bluetooth zp_darwRect:110 top:100 right:710 bottom:2050 width:1];
    // 打印竖线
    [self.bluetooth zp_drawLine:160 startPiontY:100 endPointX:160 endPointY:2050 width:2];
    [self.bluetooth zp_drawLine:210 startPiontY:100 endPointX:210 endPointY:2050 width:2];
    [self.bluetooth zp_drawLine:260 startPiontY:100 endPointX:260 endPointY:2050 width:2];
    [self.bluetooth zp_drawLine:310 startPiontY:100 endPointX:310 endPointY:2050 width:2];
    [self.bluetooth zp_drawLine:360 startPiontY:100 endPointX:360 endPointY:2050 width:2];
    [self.bluetooth zp_drawLine:410 startPiontY:100 endPointX:410 endPointY:2050 width:2];
    [self.bluetooth zp_drawLine:460 startPiontY:100 endPointX:460 endPointY:2050 width:2];
    [self.bluetooth zp_drawLine:510 startPiontY:100 endPointX:510 endPointY:2050 width:2];
    [self.bluetooth zp_drawLine:560 startPiontY:100 endPointX:560 endPointY:2050 width:2];
    [self.bluetooth zp_drawLine:610 startPiontY:100 endPointX:610 endPointY:2050 width:2];
    [self.bluetooth zp_drawLine:660 startPiontY:100 endPointX:660 endPointY:2050 width:2];
    [self.bluetooth zp_drawLine:710 startPiontY:100 endPointX:710 endPointY:2050 width:2];
    
    // 打印横线
    [self.bluetooth zp_drawLine:160 startPiontY:300 endPointX:710 endPointY:300 width:2];
    [self.bluetooth zp_drawLine:160 startPiontY:600 endPointX:710 endPointY:600 width:2];
    [self.bluetooth zp_drawLine:160 startPiontY:800 endPointX:710 endPointY:800 width:2];
    [self.bluetooth zp_drawLine:160 startPiontY:900 endPointX:710 endPointY:900 width:2];
    [self.bluetooth zp_drawLine:160 startPiontY:1000 endPointX:710 endPointY:1000 width:2];
    [self.bluetooth zp_drawLine:160 startPiontY:1150 endPointX:710 endPointY:1150 width:2];
    [self.bluetooth zp_drawLine:160 startPiontY:1710 endPointX:710 endPointY:1710 width:2];
    
    // 打印文字
    [self.bluetooth zp_drawText:700 y:150 text:@"物料名称" font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:700 y:390 text:@"园区荒料号" font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:700 y:630 text:@"客户荒料号" font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:700 y:830 text:@"匝号" font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:700 y:930  text:@"片数" font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:700 y:1040 text:@"平方数" font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:700 y:1410 text:@"板号" font:8 fontsize:0 bold:0 rotate:270];
    [self.bluetooth zp_drawText:700 y:1870 text:@"储位" font:8 fontsize:0 bold:0 rotate:270];
    
    
    NSString * outName = [NSString stringWithFormat:@"商户:%@",printmodel.ownerName];
    [self.bluetooth zp_drawText:740 y:100 text:outName font:8 fontsize:0 bold:0 rotate:270];
    NSString * outBounsNo = [NSString stringWithFormat:@"发货单号:%@",printmodel.outbountNo];
    [self.bluetooth zp_drawText:740 y:800 text:outBounsNo font:8 fontsize:0 bold:0 rotate:270];
    NSString * dateStr = [NSString stringWithFormat:@"打印时间:%@",printmodel.outDate];
    [self.bluetooth zp_drawText:740 y:1550 text:dateStr font:8 fontsize:0 bold:0 rotate:270];
    
    
    [self.bluetooth zp_drawText:830 y:800 text:@"海西大板仓储出货单" font:14 fontsize:2 bold:0 rotate:270];
    
    
    
    
    // [self.bluetooth zp_drawText:140 y:200 text:@"备注" font:8 fontsize:0 bold:0 rotate:270];
    
    [self.bluetooth zp_drawText:140 y:200 text:[NSString stringWithFormat:@"总片数:%@片",printmodel.totalQty] font:14 fontsize:0 bold:0 rotate:270];
    
    NSString * sumQty = [NSString stringWithFormat:@"总平方数:%@平方米",printmodel.sumVaqty];
    [self.bluetooth zp_drawText:140 y:500 text:sumQty font:8 fontsize:0 bold:0 rotate:270];
    
    // [self.bluetooth zp_drawText:140 y:1025 text:@"合计" font:8 fontsize:0 bold:0 rotate:270];
    //吊装签字
    [self.bluetooth zp_drawText:140 y:1000 text:@"吊装签字:" font:8 fontsize:0 bold:0 rotate:270];
    //仓管签字
    [self.bluetooth zp_drawText:140 y:1400 text:@"仓管签字:" font:8 fontsize:0 bold:0 rotate:270];
    //打印图片
    [self.bluetooth zp_darwlogo:110 y:1980];
    //打印二维码
    [self.bluetooth zp_darwQRCode:720 y:1960 unit_width:3 text:self.outStr];
    
    for (int j = 0 ; j < printmodel.bolcks.count; j++) {
        RSPrintSecondModel * printsecondmodel = printmodel.bolcks[j];
        int startX = 0;
        switch (j) {
            case 0:
                startX = 640;
                break;
            case 1:
                startX = 590;
                break;
            case 2:
                startX = 540;
                break;
            case 3:
                startX = 490;
                break;
            case 4:
                startX = 440;
                break;
            case 5:
                startX = 390;
                break;
            case 6:
                startX = 340;
                break;
            case 7:
                startX = 290;
                break;
            case 8:
                startX = 240;
                break;
            case 9:
                startX = 190;
                break;
            default:
                startX = 640;
                break;
        }
//
        //打印物料名称
        [self.bluetooth zp_drawText:startX y:150 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockName] font:8 fontsize:0 bold:0 rotate:270];
        // 打印园区荒料号
        [self.bluetooth zp_drawText:startX y:390 text:[NSString stringWithFormat:@"%@",printsecondmodel.blockNo] font:8 fontsize:0 bold:0 rotate:270];
        // 打印客户荒料号
        [self.bluetooth zp_drawText:startX y:630 text:[NSString stringWithFormat:@"%@",printsecondmodel.csid] font:8 fontsize:0 bold:0 rotate:270];
        // 打印匝号
        [self.bluetooth zp_drawText:startX y:830 text:[NSString stringWithFormat:@"%@",printsecondmodel.turnsNo] font:8 fontsize:0 bold:0 rotate:270];
        //  打印片数
        [self.bluetooth zp_drawText:startX y:940 text:[NSString stringWithFormat:@"%ld",(long)printsecondmodel.qty] font:8 fontsize:0 bold:0 rotate:270];
        //  打印平方数
        [self.bluetooth zp_drawText:startX y:1040 text:[NSString stringWithFormat:@"%.3lf",printsecondmodel.blockNum] font:8 fontsize:0 bold:0 rotate:270];
        // 打印板号
        NSString * str = [NSString stringWithFormat:@"%@",printsecondmodel.slno];
        if (str.length > 40) {
            str = [str substringToIndex:40];
            str = [NSString stringWithFormat:@"%@...",str];
        }
        //1150
        [self.bluetooth zp_drawText:startX y:1160 text:str font:8 fontsize:0 bold:0 rotate:270];
        NSString * locationName = [NSString stringWithFormat:@"%@",printsecondmodel.locationName];
        if (locationName.length > 17) {
            locationName = [locationName substringToIndex:17];
            locationName = [NSString stringWithFormat:@"%@...",locationName];
        }
        //打印储位 1610
        [self.bluetooth zp_drawText:startX y:1720 text:locationName font:8 fontsize:0 bold:0 rotate:270];
    }
    [self.bluetooth end];
}


- (IBAction)print:(id)sender {
    /*Byte byte[2] = {0xa,0x0d};
     NSData *adata = [[NSData alloc] initWithBytes:byte length:2];
     [self.bluetooth open:self.peripheral];
     [self.bluetooth flushRead];
     [self.bluetooth writeData:adata];
     [self.bluetooth close];
     */
    
    UIView * menview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    menview.backgroundColor = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:0.5];
    //    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenMenview)];
    //    menview.userInteractionEnabled = YES;
    //    [menview addGestureRecognizer:tap];
    [self.view addSubview:menview];
    _menview = menview;
    
    
    UIView * choiceView = [[UIView alloc]initWithFrame:CGRectMake(8,(SCH/2)/2, SCW - 16, 227)];
    choiceView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    [menview addSubview:choiceView];
    choiceView.layer.cornerRadius = 5;
    choiceView.layer.masksToBounds = YES;
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(choiceView.frame), 58)];
    topView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [choiceView addSubview:topView];
    
    UILabel * topLabel = [[UILabel alloc]initWithFrame:CGRectMake(topView
                                                                  .yj_width/2 - 100, 21,200 , CGRectGetHeight(topView.frame) - 42)];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.text = @"选择您需要打印的内容";
    topLabel.font = [UIFont systemFontOfSize:16];
    topLabel.textColor = [UIColor colorWithHexColorStr:@"#616161"];
    [topView addSubview:topLabel];
    
    
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(topView
                                 .yj_width - 38, 10, 38, 38);
    [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"]
               forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelMenuAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelBtn];
    
    
    
    //中间View
    RSWWMenuView * wwmenuview = [[RSWWMenuView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + 1, CGRectGetWidth(choiceView.frame),170)];
    wwmenuview.delegate = self;
    // 对自定义菜单view设置数据
    wwmenuview.menus = self.printDataArray;
    [choiceView addSubview:wwmenuview];
    
    
    //WithFrame:CGRectMake(12, (SCH/2) - ((SCH/2)/2)/2, SCW - 24, (SCH/2)/2)]
    // UIView * choiceView = [[UIView alloc]init];
    // choiceView.backgroundColor = [UIColor whiteColor];
    // [menview addSubview:choiceView];
    //WithFrame:CGRectMake(5, 0, SCW - 24, 20)
    //    UILabel * titleLabel = [[UILabel alloc]init];
    //    titleLabel.text = @"请选择你需要打印的票据位置";
    //    titleLabel.textAlignment = NSTextAlignmentCenter;
    //    titleLabel.backgroundColor = [UIColor clearColor];
    //    [choiceView addSubview:titleLabel];
    //    //WithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), SCW - 24, CGRectGetHeight(choiceView.frame) - CGRectGetMaxY(titleLabel.frame))
    //    UIView * printview = [[UIView alloc]init];
    //    printview.backgroundColor = [UIColor whiteColor];
    //    [choiceView addSubview:printview];
    //    CGFloat btnW = ((SCW - 16) - (ECA + 1)*margin)/ECA;
    //    CGFloat btnH = 40;
    //    for (int i = 0 ; i < self.printDataArray.count; i++) {
    //        UIButton * publishBtn = [[UIButton alloc]init];
    //        NSInteger row = i / ECA;
    //        NSInteger colom = i % ECA;
    //        publishBtn.tag = 10000 + i;
    //        CGFloat btnX =  colom * (margin + btnW) + margin;
    //        CGFloat btnY =  row * (margin + btnH) + margin;
    //        publishBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    //        publishBtn.layer.cornerRadius = 4;
    //        publishBtn.layer.masksToBounds = YES;
    //        RSPrintModel * printmodel = self.printDataArray[i];
    //        [publishBtn setTitle:[NSString stringWithFormat:@"erp单号:%@,第%ld页",printmodel.erpOutboundNo,printmodel.pageNum] forState:UIControlStateNormal];
    //        publishBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    //        [publishBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    //        [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    //        [printview addSubview:publishBtn];
    //        [publishBtn addTarget:self action:@selector(selectPublishStyle:) forControlEvents:UIControlEventTouchUpInside];
    //    }
    //
    //    choiceView.sd_layout
    //    .leftSpaceToView(menview, 8)
    //    .rightSpaceToView(menview, 8)
    //    .centerYEqualToView(menview)
    //    //.topSpaceToView(menview, SCH/4)
    //    .heightIs(SCH - 120);
    //    choiceView.layer.cornerRadius = 4;
    //    choiceView.layer.masksToBounds = YES;
    //
    //    titleLabel.sd_layout
    //    .leftSpaceToView(choiceView, 0)
    //    .rightSpaceToView(choiceView, 0)
    //    .topSpaceToView(choiceView, 5)
    //    .heightIs(20);
    //
    //    printview.sd_layout
    //    .topSpaceToView(titleLabel, 10)
    //    .leftSpaceToView(choiceView, 0)
    //    .rightSpaceToView(choiceView, 0)
    //    .bottomSpaceToView(choiceView, 0);
}

- (void)menuBtnClick:(UIButton *)menuBtn{
    [SVProgressHUD showWithStatus:@"正在打印中......"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [NSTimer scheduledTimerWithTimeInterval:12 target:self selector:@selector(closeStatus) userInfo:nil repeats:NO];
    RSPrintModel * printmodel = self.printDataArray[menuBtn.tag - 10000];
    [self.bluetooth reset];
    //[_menview removeFromSuperview];
    [self.bluetooth open:self.peripheral];
    [self.bluetooth flushRead];
    //SL 大板  BL 荒料
    if ([printmodel.outType isEqualToString:@"SL"]) {
        [self printSLView:printmodel];
    }else{
        [self printBLView:printmodel];
    }
    [self sendPrintData];
    [self.bluetooth reset];
    [self.bluetooth close];
}

- (void)closeStatus{
    [SVProgressHUD dismiss];
}


//- (void)selectPublishStyle:(UIButton *)btn{
//    RSPrintModel  * printmodel = self.printDataArray[btn.tag - 10000];
//    [_menview removeFromSuperview];
//      [self.bluetooth open:self.peripheral];
//     [self.bluetooth flushRead];
//    //SL 大板  BL 荒料
//    if ([printmodel.outType isEqualToString:@"SL"]) {
//        [self printSLView:printmodel];
//    }else{
//        [self printBLView:printmodel];
//    }
//    [self sendPrintData];
//    [self.bluetooth reset];
//    [self.bluetooth close];
//}



//- (void)hiddenMenview{
//   // NSLog(@"-------------------");
//    [_menview removeFromSuperview];
//}


- (void)cancelMenuAction:(UIButton *)cancelBtn{
    [_menview removeFromSuperview];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_menview removeFromSuperview];
}


-(void) sendPrintData{
    int r = self.bluetooth.dataLength;
    NSData *data = [self.bluetooth getData:r];
    [self.bluetooth writeData:data];
}

@end
