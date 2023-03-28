//
//  RSRecordDetailViewController.m
//  石来石往
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSRecordDetailViewController.h"
#import "RSRecordCell.h"
#import "RSShippingCell.h"


#import "RSRecordSecondCell.h"
#import "RSRecordHeaderView.h"

#import "RSOrderDetailsCell.h"


#import "RSRecordOwnerCell.h"

#import "RSOutRecordModel.h"
#import "RSOutRecordDetailModel.h"


#import "RSDriverViewController.h"


//#import "CustomMyPickerView.h"
//,CustomMyPickerViewDelegate
#import "RSSelectCarViewController.h"



#import "RSAuditStatusViewController.h"

@interface RSRecordDetailViewController ()<RSDriverViewControllerDelegate,RSSelectCarViewControllerDelegate,UIGestureRecognizerDelegate>
{
    //蒙版
    UIView * _menview;
    //发起服务
    UIButton * _sendServiceBtn;
}
//@property (nonatomic,strong)CustomMyPickerView *customVC;
//@property (nonatomic,strong)UITableView * tableview;

@property (weak, nonatomic)UIImageView *qrImageView;

@property (nonatomic,strong)NSMutableArray * detailArray;

@property (nonatomic,strong)RSRightNavigationButton * progressBtn;

@property (nonatomic,strong)RSRightNavigationButton * showQRBtn;

@end

@implementation RSRecordDetailViewController

- (NSMutableArray *)detailArray{
    if (_detailArray == nil) {
        _detailArray = [NSMutableArray array];
    }
    return _detailArray;
}

static NSString * recordFirstCellID = @"recordFirstCellID";
static NSString * recordCellID = @"recordcellid";
static NSString * recordSecondCellID = @"recordSecondCellID";
static NSString * recordOwerCellID = @"recordOwerCellID";
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

static NSString * RECORDDETAILHEADERID = @"RecordDetailHeaderid";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.title = @"订单详情";
    [self isAddjust];
//    if (@available(iOS 11.0, *)) {
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
//        UITableView.appearance.estimatedRowHeight = 0;
//        UITableView.appearance.estimatedSectionFooterHeight = 0;
//        UITableView.appearance.estimatedSectionHeaderHeight = 0;
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    [self loadRecordDetailData];

    
//    if ([self.cancelStatus isEqualToString:@"申请撤销"]) {
//        [SVProgressHUD showInfoWithStatus:@"无法发起服务"];
//    }
    if ([self.usermodel.userType isEqualToString:@"hxhz"]) {
        RSRightNavigationButton * progressBtn = [[RSRightNavigationButton alloc]initWithFrame:CGRectMake(0, 0, 55, 35)];
        [progressBtn setTitle:@"进度详情" forState:UIControlStateNormal];
        progressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        progressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - 5);
        progressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [progressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [progressBtn addTarget:self action:@selector(detailsOfProgress) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * progressItem = [[UIBarButtonItem alloc]initWithCustomView:progressBtn];
        _progressBtn = progressBtn;
        
        RSRightNavigationButton * showQRBtn = [[RSRightNavigationButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        //showQRBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        [showQRBtn setImage:[UIImage imageNamed:@"展示二维码"] forState:UIControlStateNormal];
        [showQRBtn addTarget:self action:@selector(showQRCode) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:showQRBtn];
        //self.navigationItem.rightBarButtonItem = rightitem;
        _showQRBtn = showQRBtn;
        self.navigationItem.rightBarButtonItems = @[rightitem,progressItem];
    }
     
}

//FIXME:进度详情
- (void)detailsOfProgress{
    RSAuditStatusViewController * auditstatusVc = [[RSAuditStatusViewController alloc]init];
    //订单号
    auditstatusVc.outBoundNo = self.outBoundNo;
    //用户
    auditstatusVc.usermodel = self.usermodel;
    [self.navigationController pushViewController:auditstatusVc animated:YES];
}

//- (NSString *)currentTime{
//
//    NSDate *detaildate=[NSDate date];
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
//    return currentDateStr;
//}

//- (void)compareTime:(NSString *)titleTimeStr{
//    NSMutableArray * timeArray = [NSMutableArray array];
//    timeArray = [self recaptureTime:titleTimeStr];
//    _customVC.componentArray = timeArray;
//    RSWeakself
//    _customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
//       // NSLog(@"zhelicom is = %@   title = %@",compoentString,titileString);
//        if ([compoentString isEqualToString:@"立刻送"]) {
//            compoentString = [weakSelf getCurrentTime];
//        }else{
//            compoentString = [NSString stringWithFormat:@"%@:00",compoentString];
//        }
//        NSString * appointTime = [NSString stringWithFormat:@"%@ %@",titileString,compoentString];
//
//        [weakSelf addService:weakSelf.shipmentmodel andAppointTime:appointTime];
//
//    };
//
//    [_customVC.picerView reloadAllComponents];
//}
//
//
//
//
//
////重新获取时间
//- (NSMutableArray *)recaptureTime:(NSString *)titleString{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH"];
//    NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
//    [formatter1 setDateFormat:@"mm"];
//    NSString * dateTime = [formatter stringFromDate:[NSDate date]];
//    NSString * minute = [formatter1 stringFromDate:[NSDate date]];
//    NSString * reloadYear = [self currentTime];
//    NSString * time = [NSString stringWithFormat:@"%@:%@",dateTime,minute];
//    NSMutableArray * timeArray = [NSMutableArray array];
//    NSArray * choiceTimeArray = @[@"00:00",@"00:30",@"01:00",@"01:30",@"02:00",@"02:30",@"03:00",@"03:30",@"04:00",@"04:30",@"05:00",@"05:30",@"06:00",@"06:30",@"07:00",@"07:30",@"08:00",@"08:30",@"09:00",@"09:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",@"21:30",@"22:00",@"22:30",@"23:00",@"23:30"];
//    NSString * rightNowStr = @"立刻送";
//    [timeArray removeAllObjects];
//    for (int i = 0; i < choiceTimeArray.count; i++) {
//        NSString * timeStr = choiceTimeArray[i];
//        BOOL resultYear = [titleString compare:reloadYear] == NSOrderedSame;
//        if (resultYear) {
//            BOOL result = [timeStr compare:time] == NSOrderedDescending;
//            if (result == 1){
//                [timeArray addObject:choiceTimeArray[i]];
//            }
//        }else{
//            [timeArray addObject:choiceTimeArray[i]];
//        }
//    }
//    [timeArray insertObject:rightNowStr atIndex:0];
//    return timeArray;
//}


#pragma mark -- 发起服务
- (void)fristSendService:(UIButton * )sendServiceBtn{
    
    if ([self.cancelStatus isEqualToString:@"申请撤销"]) {
        [SVProgressHUD showErrorWithStatus:@"无法发起服务"];
    }else{
        
        RSSelectCarViewController * selectvc = [[RSSelectCarViewController alloc]init];
        selectvc.usermodel = self.usermodel;
        selectvc.outBoundNo = self.outBoundNo;
        selectvc.delegate = self;
        [self.navigationController pushViewController:selectvc animated:YES];
    }
    
    
//    NSMutableArray * timeArray = [NSMutableArray array];
//    timeArray = [self recaptureTime:[self currentTime]];
//    RSWeakself
//    CustomMyPickerView *customVC  = [[CustomMyPickerView alloc] initWithComponentDataArray:timeArray titleDataArray:nil];
//    customVC.delegate = self;
//    customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
//       // NSLog(@"zhelicom is = %@   title = %@",compoentString,titileString);
//        if ([compoentString isEqualToString:@"立刻送"]) {
//            compoentString = [weakSelf getCurrentTime];
//        }else{
//            compoentString = [NSString stringWithFormat:@"%@:00",compoentString];
//        }
//
//        NSString * appointTime = [NSString stringWithFormat:@"%@ %@",titileString,compoentString];
//
//        [weakSelf addService:weakSelf.shipmentmodel andAppointTime:appointTime];
//
//    };
//    _customVC = customVC;
//    [self.view addSubview:customVC];

}

#pragma mark -- RSSelectCarViewControllerDelegate

- (void)recaptureNetworkData{
    
    _sendServiceBtn.enabled = NO;
    [self loadRecordDetailData];
    
}




//#pragma mark -- 获取当前时间
//- (NSString *)getCurrentTime {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH:mm:ss"];
//    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
//    return dateTime;
//}


////发起服务
//- (void)addService:(NSString *)outboundNo andAppointTime:(NSString *)appointTime{
//    [SVProgressHUD showWithStatus:@"发起服务中......."];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:self.usermodel.userID forKey:@"sendUserId"];
//    [dict setObject:outboundNo forKey:@"outBoundNo"];
//    [dict setObject:appointTime forKey:@"appointTime"];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":ERPID};
//    //RSWeakself
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_STARTADDSERVICE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//                [SVProgressHUD showSuccessWithStatus:@"发起服务成功"];
//            }else{
//                 [SVProgressHUD showErrorWithStatus:@"发起服务失败"];
//            }
//        }else{
//               [SVProgressHUD showErrorWithStatus:@"发起服务失败"];
//        }
//    }];
//}


#pragma mark -- 获取数据
- (void)loadRecordDetailData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.outBoundNo forKey:@"outBoundNo"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    //URL_OUTSTORE_HISTORY_IOS URL_OUTSTORE_HISTORY
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_OUTSTORE_HISTORY_DETAIL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
//                CLog(@"=================================%@",json);
                NSMutableArray  * array = nil;
                [weakSelf.detailArray removeAllObjects];
                array = json[@"Data"];
                if (array.count > 0) {
                    for (int n = 0; n < array.count; n++) {
                        RSOutRecordModel * outRecordmodel = [[RSOutRecordModel alloc]init];
                        outRecordmodel.outstoreDate = [[array objectAtIndex:n]objectForKey:@"outstoreDate"];
                        outRecordmodel.OUT_TYPE = [[array objectAtIndex:n]objectForKey:@"OUT_TYPE"];
                        outRecordmodel.outstoreId = [[array objectAtIndex:n]objectForKey:@"outstoreId"];
                        outRecordmodel.outstoreStatus = [[array objectAtIndex:n]objectForKey:@"outstoreStatus"];
                        outRecordmodel.csnName = [[array objectAtIndex:n]objectForKey:@"csnName"];
                        outRecordmodel.csnPhone = [[array objectAtIndex:n]objectForKey:@"csnPhone"];
                        outRecordmodel.servicestatus = [[array objectAtIndex:n]objectForKey:@"servicestatus"];
                        outRecordmodel.qrCode = [[array objectAtIndex:n]objectForKey:@"qrCode"];
                        outRecordmodel.scnStatus = [[array objectAtIndex:n]objectForKey:@"scnStatus"];
                        outRecordmodel.carType = [[array objectAtIndex:n]objectForKey:@"carType"];
                        NSMutableArray * tempArray = nil;
                        tempArray = [[array objectAtIndex:n]objectForKey:@"bolcks"];
                        NSMutableArray * blockArray = [NSMutableArray array];
                        for (int j = 0; j < tempArray.count; j++) {
                            RSOutRecordDetailModel * outRecordDetailmodel = [[RSOutRecordDetailModel alloc]init];
                            outRecordDetailmodel.blockName = [[tempArray objectAtIndex:j]objectForKey:@"blockName"];
                            outRecordDetailmodel.blockNo = [[tempArray objectAtIndex:j]objectForKey:@"blockNo"];
                            outRecordDetailmodel.blockNum = [[tempArray objectAtIndex:j]objectForKey:@"blockNum"];
                            outRecordDetailmodel.blockTurns = [[tempArray objectAtIndex:j]objectForKey:@"blockTurns"];
                            [blockArray addObject:outRecordDetailmodel];
                            outRecordDetailmodel.turnsNo = [[tempArray objectAtIndex:j]objectForKey:@"turnsNo"];
                            outRecordDetailmodel.locationName = [[tempArray objectAtIndex:j]objectForKey:@"locationName"];
                        }
                        outRecordmodel.bolcks = blockArray;
                        [weakSelf.detailArray addObject:outRecordmodel];
                        if ([self.usermodel.userType isEqualToString:@"hxhz"] && [outRecordmodel.qrCode length] > 0){
                            weakSelf.showQRBtn.hidden = NO;
                        }else{
                            weakSelf.showQRBtn.hidden = YES;
                        }
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                     [self addRecordCustomTableview];
                 [weakSelf.tableview reloadData];
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}



- (void)addRecordCustomTableview{
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - Height_NavBar - Height_Real(34)) style:UITableViewStylePlain];
//    tableview.delegate = self;
//    tableview.dataSource = self;
//    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview = tableview;
    [self.view addSubview:self.tableview];
    
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar - 40);
    UIButton * sendServiceBtn = [[UIButton alloc]init];
    [sendServiceBtn setTitle:@"发起服务" forState:UIControlStateNormal];
    sendServiceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sendServiceBtn];
    _sendServiceBtn = sendServiceBtn;
    [sendServiceBtn bringSubviewToFront:self.view];
    RSOutRecordModel * outrecordmodel = self.detailArray[0];
    //增加一个判断条件是不是大板
    if ([outrecordmodel.servicestatus isEqualToString:@"1"] && [outrecordmodel.OUT_TYPE isEqualToString:@"SL"]) {
        sendServiceBtn.enabled = YES;
        [sendServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
        [sendServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    }else{
        sendServiceBtn.enabled = NO;
        [sendServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
        [sendServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
    }
    [sendServiceBtn addTarget:self action:@selector(fristSendService:) forControlEvents:UIControlEventTouchUpInside];
    sendServiceBtn.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.tableview, 0)
    .bottomSpaceToView(self.view, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else{
       RSOutRecordModel * outrecordmodel = self.detailArray[0];
       return outrecordmodel.bolcks.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     RSOutRecordModel * outrecordmodel = self.detailArray[0];
    RSOutRecordDetailModel * outrecordDetailmodel = [[RSOutRecordDetailModel alloc]init];
    if (outrecordmodel.bolcks.count > 0) {
          outrecordDetailmodel = outrecordmodel.bolcks[indexPath.row];
    }
    if (indexPath.section == 0) {
        //RSShippingCell * shipcell = [tableView dequeueReusableCellWithIdentifier:recordCellID];
        RSOrderDetailsCell * shipcell = [tableView dequeueReusableCellWithIdentifier:recordFirstCellID];
        if (!shipcell) {
            shipcell = [[RSOrderDetailsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:recordFirstCellID];
        }
        shipcell.detailLibraryLabel.text = outrecordmodel.outstoreId;
        shipcell.detailDateLabel.text = outrecordmodel.outstoreDate;
        if ([outrecordmodel.carType isEqualToString:@"dt"]) {
            shipcell.carTypeLabel.text = [NSString stringWithFormat:@"短途车"];
        }else if ([outrecordmodel.carType isEqualToString:@"ct"]){
            shipcell.carTypeLabel.text = [NSString stringWithFormat:@"长途车"];
        }else if ([outrecordmodel.carType isEqualToString:@"hg"]){
            shipcell.carTypeLabel.text = [NSString stringWithFormat:@"货柜"];
        }else if ([outrecordmodel.carType isEqualToString:@"qt"]){
            shipcell.carTypeLabel.text = [NSString stringWithFormat:@"其他"];
        }
        if ([outrecordmodel.outstoreStatus isEqualToString:@"0"]) {
            shipcell.detailStatusLabel.text = @"已完成";
            shipcell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#e52c32"];
             _progressBtn.hidden = NO;
        }
        if ([outrecordmodel.outstoreStatus isEqualToString:@"2"]) {
            shipcell.detailStatusLabel.text = @"审核中";
            shipcell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#fbc376"];
             _progressBtn.hidden = NO;
        }
        if ([outrecordmodel.outstoreStatus isEqualToString:@"3"]) {
            shipcell.detailStatusLabel.text = @"待发货";
            shipcell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#afd9ff"];
             _progressBtn.hidden = NO;
        }
        if ([outrecordmodel.outstoreStatus isEqualToString:@"4"]) {
            shipcell.detailStatusLabel.text = @"部分发货";
            shipcell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#a4d4c8"];
            _progressBtn.hidden = NO;
        }
        
        if ([outrecordmodel.outstoreStatus isEqualToString:@"-1"]) {
            shipcell.detailStatusLabel.text = @"已失效";
            shipcell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#afd450"];
            _progressBtn.hidden = YES;
        }
        
        shipcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return shipcell;
    }else if (indexPath.section == 1){
      //  RSOutRecordModel * outrecordmodel = self.detailArray[0];
        //recordOwerCellID
        RSRecordOwnerCell * cell = [tableView dequeueReusableCellWithIdentifier:recordOwerCellID];
        if (!cell) {
            cell = [[RSRecordOwnerCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:recordOwerCellID];
        }
        
        cell.owerNameLabel.text = [NSString stringWithFormat:@"%@",outrecordmodel.csnName];
        
        [cell.owerPhoneBtn setTitle:[NSString stringWithFormat:@"%@",outrecordmodel.csnPhone] forState:UIControlStateNormal];
        
        [cell.owerPhoneBtn addTarget:self action:@selector(playPhone:) forControlEvents:UIControlEventTouchUpInside];
        cell.owerPhoneBtn.tag = indexPath.row + 10000;
        if ([outrecordmodel.scnStatus isEqualToString:@"1"] && [self.usermodel.userType isEqualToString:@"hxhz"]) {
            cell.owerBtn.enabled = YES;
            [cell.owerBtn setTitleColor:[UIColor colorWithHexColorStr:@"3385ff"] forState:UIControlStateNormal];
            [cell.owerBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f0f0f0"]];
        }else{
            cell.owerBtn.enabled = NO;
            [cell.owerBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
            [cell.owerBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
        }
        
        [cell.owerBtn addTarget:self action:@selector(modifyOwer:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
       
        
        //荒料
        if ([outrecordmodel.OUT_TYPE isEqualToString:@"BL"]) {
            RSRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:recordCellID];
            if (!cell) {
                cell = [[RSRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:recordCellID];
            }
            cell.detailNameLabel.text = [NSString stringWithFormat:@"%@",outrecordDetailmodel.blockName];
            cell.detailHuangliaoLabel.text = [NSString stringWithFormat:@"%@",outrecordDetailmodel.blockNo];
            cell.detailTiLabel.text = [NSString stringWithFormat:@"%@m³",outrecordDetailmodel.blockNum];
            [cell.paiBtn setTitle:[NSString stringWithFormat:@"%ld",indexPath.row+1] forState:UIControlStateNormal];
            cell.locationDetailLabel.text = [NSString stringWithFormat:@"%@",outrecordDetailmodel.locationName];
            if (cell.paiBtn.currentTitle.length == 1) {
                cell.paiBtn.sd_layout
                .widthIs(17)
                .heightIs(17);
            }else if (cell.paiBtn.currentTitle.length == 2){
                cell.paiBtn.sd_layout
                .widthIs(30)
                .heightIs(17);
                
            }else if (cell.paiBtn.currentTitle.length == 3){
                cell.paiBtn.sd_layout
                .widthIs(50)
                .heightIs(17);
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            RSRecordSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:recordSecondCellID];
            if (!cell) {
                cell = [[RSRecordSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:recordSecondCellID];
            }
            cell.detailNameLabel.text = [NSString stringWithFormat:@"%@",outrecordDetailmodel.blockName];
            cell.detailHuangliaoLabel.text = [NSString stringWithFormat:@"%@",outrecordDetailmodel.blockNo];
            cell.detailZaLabel.text = [NSString stringWithFormat:@"%@片",outrecordDetailmodel.blockTurns];
            cell.detailAreaLabel.text = [NSString stringWithFormat:@"%@m²",outrecordDetailmodel.blockNum];
            [cell.paiBtn setTitle:[NSString stringWithFormat:@"%ld",indexPath.row+1] forState:UIControlStateNormal];
            
            cell.locationDetailLabel.text = [NSString stringWithFormat:@"%@",outrecordDetailmodel.locationName];
            cell.turnDetailLabel.text = [NSString stringWithFormat:@"%@",outrecordDetailmodel.turnsNo];
            
            if (cell.paiBtn.currentTitle.length == 1) {
                cell.paiBtn.sd_layout
                .widthIs(17)
                .heightIs(17);
            }else if (cell.paiBtn.currentTitle.length == 2){
                cell.paiBtn.sd_layout
                .widthIs(30)
                .heightIs(17);
                
            }else if (cell.paiBtn.currentTitle.length == 3){
                cell.paiBtn.sd_layout
                .widthIs(50)
                .heightIs(17);
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}


- (void)modifyOwer:(UIButton *)owerBtn{
    RSOutRecordModel * outrecordmodel = self.detailArray[0];
   // if ([outrecordmodel.outstoreStatus  isEqualToString:@"2"] || [outrecordmodel.outstoreStatus isEqualToString:@"3"]) {
        NSString * str = [NSString string];
        if ([outrecordmodel.OUT_TYPE isEqualToString:@"BL"]) {
            str = @"huangliao";
        }else{
            str = @"daban";
        }
        RSDriverViewController *driverVc = [[RSDriverViewController alloc]init];
        driverVc.shopCarNumberArray = self.detailArray;
        driverVc.userID = self.usermodel.userID;
        driverVc.userModel = self.usermodel;
        driverVc.outStyle = str;
        driverVc.delegate = self;
        [self.navigationController pushViewController:driverVc animated:YES];
//    }else{
//        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"你要的商品已经在准备发货中,没有办法修改提货人" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [alert addAction:action];
//        [self presentViewController:alert animated:YES completion:nil];
//    }
}

#pragma mark -- 代理
- (void)modifyConsigneeName:(NSString *)csnName andConsigneePhone:(NSString *)csnPhone{
    //self.shipmentmodel.csnName = csnName;
    //self.shipmentmodel.csnPhone = csnPhone;
    RSOutRecordModel * outrecordmodel = self.detailArray[0];
    outrecordmodel.csnName = csnName;
    outrecordmodel.csnPhone = csnPhone;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
    [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 104;
    }else if (indexPath.section == 1){
        return 70;
    }else{
        RSOutRecordModel * outrecordmodel = self.detailArray[0];
        if ([outrecordmodel.OUT_TYPE isEqualToString:@"BL"]) {
            return 96;
        }else{
            return 136;
        }
    }
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    RSAuditStatusViewController * auditstatusVc = [[RSAuditStatusViewController alloc]init];
//    //订单号
//    auditstatusVc.outBoundNo = self.outBoundNo;
//    //用户
//    auditstatusVc.usermodel = self.usermodel;
//
//    [self.navigationController pushViewController:auditstatusVc animated:YES];
//
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSRecordHeaderView * headerview = [[RSRecordHeaderView alloc]initWithReuseIdentifier:RECORDDETAILHEADERID];
    if (section == 0) {
        headerview.productLabel.text = @"订单详情";
    }else if (section == 1){
        headerview.productLabel.text = @"提货人信息";
    }else{
        headerview.productLabel.text = @"货物信息";
    }
    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark -- 二维码
- (void)showQRCode{
    self.navigationController.navigationBar.hidden = YES;
    if (self.detailArray.count > 0) {
        
         RSOutRecordModel * outrecordmodel = self.detailArray[0];
        if ([outrecordmodel.qrCode isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"还没有获取数据"];
//             self.navigationController.navigationBar.hidden = NO;
        }else{
            UIView * menview = [[UIView alloc]init];
            //    menview.backgroundColor = [UIColor colorWithHexColorStr:@"#000000"];
            menview.backgroundColor = [UIColor colorWithHexColorStr:@"#000000" alpha:0.5];
            //menview.alpha = 0.5;
            [self.view addSubview:menview];
            
            [menview bringSubviewToFront:self.view];
            menview.userInteractionEnabled = YES;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelShowQRView:)];
            
            [menview addGestureRecognizer:tap];
            
            _menview = menview;
            
            //二维码
            
            UIView * qrView = [[UIView alloc]init];
            qrView.backgroundColor = [UIColor whiteColor];
            [menview addSubview:qrView];
            
            
            //里面的view
            UIView * liView = [[UIView alloc]init];
            liView.backgroundColor = [UIColor clearColor];
            liView.layer.borderColor = [UIColor colorWithHexColorStr:@"#EEEEEE"].CGColor;
            liView.layer.borderWidth = 1;
            [qrView addSubview:liView];
            

            //二维码的图片
            UIImageView * qrImageview = [[UIImageView alloc]init];
            [liView addSubview:qrImageview];
            _qrImageView = qrImageview;
            
            //    UILabel * qrLabel = [[UILabel alloc]init];
            //    qrLabel.text = [NSString stringWithFormat:@"出货单:%@",outrecordmodel.qrCode];
            //    qrLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
            //    qrLabel.font = [UIFont systemFontOfSize:15];
            //    qrLabel.textAlignment = NSTextAlignmentCenter;
            //    [qrView addSubview:qrLabel];
            
            NSString * temp = [NSString stringWithFormat:@"%@",outrecordmodel.qrCode];
            
            UIImage * image = [MMScanViewController createQRImageWithString:temp QRSize:CGSizeMake(250, 250) QRColor:[UIColor blackColor] bkColor:[UIColor whiteColor]];

            menview.sd_layout
            .leftSpaceToView(self.view, 0)
            .rightSpaceToView(self.view, 0)
            .topSpaceToView(self.view, 0)
            .bottomSpaceToView(self.view, 0);
            
            
            
            
            qrView.sd_layout
            .centerXEqualToView(menview)
            .centerYEqualToView(menview)
            //    .leftSpaceToView(menview, 35)
            //    .rightSpaceToView(menview, 35)
            .widthIs(300)
            .heightIs(300);
            
            
            
            liView.sd_layout
            .centerYEqualToView(qrView)
            .centerXEqualToView(qrView)
            .heightIs(230)
            .widthIs(230);
            
            
            qrImageview.sd_layout
            .centerYEqualToView(liView)
            .centerXEqualToView(liView)
            .topSpaceToView(liView, 25)
            .bottomSpaceToView(liView, 25)
            .leftSpaceToView(liView, 25)
            .rightSpaceToView(liView, 25);
            
            [qrImageview setImage:image];
            
            UILongPressGestureRecognizer * Tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
            qrImageview.userInteractionEnabled = YES;
            [qrImageview addGestureRecognizer:Tap];
            //    qrLabel.sd_layout
            //    .leftSpaceToView(qrView, 12)
            //    .rightSpaceToView(qrView, 12)
            //    .topSpaceToView(liView, 7.5)
            //    .bottomSpaceToView(qrView, 15);
        }
    }else{
//         self.navigationController.navigationBar.hidden = NO;
        [SVProgressHUD showInfoWithStatus:@"获取失败"];
    }
}

- (void)cancelShowQRView:(UITapGestureRecognizer *)tap{
    [_menview removeFromSuperview];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_menview removeFromSuperview];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)dealloc{
    [_menview removeFromSuperview];
    self.navigationController.navigationBar.hidden = NO;
}


#pragma mark -- 长按保存二维码图片到相册里面
- (void)TapAction:(UILongPressGestureRecognizer *)longTap{
    if(_qrImageView.image) {
        if (longTap.state == UIGestureRecognizerStateBegan) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否保存图片？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            //UIAlertActionStyleDefault
            UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
                    UIImageWriteToSavedPhotosAlbum(_qrImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
            }];
            [alert addAction:actionConfirm];
            UIAlertAction *cancelConfirm = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancelConfirm];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                alert.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:alert animated:YES completion:nil];
        }  
    } else {
        [self showInfo:@"请先生成二维码"];
    }
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if(error) {
        [self showInfo:[NSString stringWithFormat:@"error: %@",error]];
    } else {
        [self showInfo:@"保存成功"];
        self.navigationController.navigationBar.hidden = NO;
        [_menview removeFromSuperview];
    }
}

#pragma mark - Error handle
- (void)showInfo:(NSString*)str {
    [self showInfo:str andTitle:@"提示"];
}

- (void)showInfo:(NSString*)str andTitle:(NSString *)title
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = ({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:NULL];
        action;
    });
    [alert addAction:action1];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        alert.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:alert animated:YES completion:NULL];
}


#pragma mark -- 打电话
- (void)playPhone:(UIButton *)btn{
    RSOutRecordModel * outrecordmodel = self.detailArray[btn.tag - 10000];
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",outrecordmodel.csnPhone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
