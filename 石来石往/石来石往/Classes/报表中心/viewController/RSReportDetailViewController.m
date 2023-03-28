//
//  RSReportDetailViewController.m
//  石来石往
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSReportDetailViewController.h"

#import "RSScreenButton.h"

#import "RSReportDetialCell.h"

#import "RSStoneExhibitionWebViewViewController.h"
#import "RSSLBalanceModel.h"
#import "RSBMBalanceModel.h"
//#import "RSReportFootView.h"


//荒料的分享的报表中心
#import "RSReportFormShareViewController.h"
//大板的分享的报表中心
#import "RSReportFormSLShareViewController.h"


//荒料码单的模型
#import "RSReportFormShareBLModel.h"
//大板码单饿模型
#import "RSReportFormShareSLModel.h"
#import "RSReportFormShareSLPiecesModel.h"


//H5页面
#import "RSPersonalWkWebviewViewController.h"

@interface RSReportDetailViewController ()<RSDetailOfChargesLeftScreenViewDelegate>

{
    
    NSInteger  _selectorIndex;
    
    
    
}




//@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,strong)NSMutableArray * maDanArray;

/**页数*/
@property (nonatomic,assign)NSInteger pageNum;
/**起始日期*/
@property (nonatomic,strong)NSString * datefrom;
/**截止日期*/
@property (nonatomic,strong)NSString * dateto;
/** 物料名称*/
@property (nonatomic,strong)NSString * mtlname;
/**荒料号*/
@property (nonatomic,strong)NSString * blockno;
/**仓库*/
@property (nonatomic,strong)NSString * whsName;
/**库区*/
@property (nonatomic,strong)NSString * storeareaName;
/**储位名称*/
@property (nonatomic,strong)NSString * locationName;
/**匝号*/
@property (nonatomic,strong)NSString * turnsno;
//长
@property (nonatomic,assign)NSInteger  length;

@property (nonatomic,assign)NSInteger lengthType;
//宽
@property (nonatomic,assign)NSInteger width;

@property (nonatomic,assign)NSInteger widthType;

@property (nonatomic,strong)NSMutableArray * detialArray;

@end

@implementation RSReportDetailViewController

- (NSMutableArray *)maDanArray{
    if (_maDanArray == nil) {
        _maDanArray = [NSMutableArray array];
    }
    return _maDanArray;
}

- (NSMutableArray *)detialArray{
    if (!_detialArray) {
        _detialArray = [NSMutableArray array];
    }
    return _detialArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
}

static NSString * FOOTID = @"FOOTID";
- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self addReportCustomNavigation];
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    //self.title = @"荒料库存";
    self.pageNum = 2;
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:currentDate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:-1];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    
    if ([self.title isEqualToString:@"大板库存"]) {
        _selectorIndex = 4;
        self.datefrom = currentDateString;
    }else if ([self.title isEqualToString:@"荒料库存"]){
        _selectorIndex = 1;
        self.datefrom = currentDateString;
    }else if ([self.title isEqualToString:@"大板入库明细"]){
        _selectorIndex = 6;
        self.datefrom = beforDate;
    }else if ([self.title isEqualToString:@"大板出库明细"]){
        _selectorIndex = 5;
        self.datefrom = beforDate;
    }else if ([self.title isEqualToString:@"荒料入库明细"]){
        _selectorIndex = 3;
        self.datefrom = beforDate;
    }else if ([self.title isEqualToString:@"荒料出库明细"]){
        _selectorIndex = 2;
        self.datefrom = beforDate;
    }
    
    self.dateto = currentDateString;
    self.mtlname = @"";
    self.blockno = @"";
    self.whsName = @"";
    self.storeareaName = @"";
    self.locationName = @"";
    self.turnsno = @"";
    self.length = 0;
    self.width = 0;
    self.lengthType = -1;
    self.widthType = -1;
    
    [self isAddjust];
    [self addReportCustomTableview];
    [self DetailOfChargesData];
}

- (void)addReportCustomTableview{
//    CGFloat Y = 0.0;
//    CGFloat bottomH = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//        bottomH = 34;
//    }else{
//        Y = 64;
//        bottomH = 0.0;
//    }
//    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Y, SCW, SCH - Y - bottomH) style:UITableViewStylePlain];
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.estimatedRowHeight = 0;
//    self.tableview.estimatedSectionFooterHeight = 0;
//    self.tableview.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableview];
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar - 50);
    RSWeakself
    //向下刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf DetailOfChargesData];
    }];
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf DetailOfChargesMoreNewData];
    }];
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf DetailOfChargesData];
//    }];
    _leftview = [[RSRSDetailsOfChargesFuntionRightView alloc]initWithSender:self];
    _leftview.backgroundColor = [UIColor whiteColor];
    //_leftview.lefttap.delegate = self;
    [self.view addSubview:_leftview];
    _detailsOfChargesLeftScreenview = [[RSDetailOfChargesLeftScreenView alloc]initWithFrame:CGRectMake(0, 0, 269, SCH)];
    _detailsOfChargesLeftScreenview.searchType = self.title;
    [_leftview setContentView:_detailsOfChargesLeftScreenview];
    _detailsOfChargesLeftScreenview.delegate = self;
    [_leftview bringSubviewToFront:self.view];
    [_detailsOfChargesLeftScreenview bringSubviewToFront:_leftview];
}

#pragma mark -- 添加自定义导航栏
- (void)addReportCustomNavigation{
    RSScreenButton * screenBtn = [[RSScreenButton alloc]init];
    screenBtn.frame = CGRectMake(0, 0, 100, 40);
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    //  [screenBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F9F9"]];
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    screenBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //  [screenBtn setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
    [screenBtn addTarget:self action:@selector(showBlockScreenView:) forControlEvents:UIControlEventTouchUpInside];
    // [screenBtn bringSubviewToFront:self.view];
    // [self.view addSubview:screenBtn];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    //    if ([self.title isEqualToString:@"大板库存"] || [self.title isEqualToString:@"荒料库存"]) {
    //        screenBtn.hidden = YES;
    //        screenBtn.enabled = NO;
    //    }else{
    //        screenBtn.hidden = NO;
    //        screenBtn.enabled = YES;
    //    }
}

#pragma mark -- 荒料筛选
- (void)showBlockScreenView:(RSScreenButton *)screenBtn{
    [_leftview switchMenu];
}

#pragma mark -- 网络数据
- (void)DetailOfChargesData{
    NSString * usr = [NSString string];
    if ([self.title isEqualToString:@"大板库存"]) {
        usr = URL_GETBLOCKSLBALANCE_IOS;
    }else if ([self.title isEqualToString:@"荒料库存"]){
        usr = URL_GETMTLBMBALANCE_IOS;
    }else if ([self.title isEqualToString:@"大板入库明细"]){
        usr = URL_GETSLINSUM_IOS;
    }else if ([self.title isEqualToString:@"大板出库明细"]){
        usr = URL_GETSLOUTSUM_IOS;
    }else if ([self.title isEqualToString:@"荒料入库明细"]){
        usr = URL_GETBMIN_IOS;
    }else{
        usr = URL_GETBMOUT_IOS;
    }
    [SVProgressHUD showInfoWithStatus:@"正在加载中........................."];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    if ([self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"] || [self.title isEqualToString:@"大板库存"] ) {
        [phoneDict setObject:_turnsno forKey:@"turnsno"];
    }
    if ([self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"] || [self.title isEqualToString:@"荒料入库明细"] || [self.title isEqualToString:@"荒料出库明细"]) {
        [phoneDict setObject:_datefrom forKey:@"datefrom"];
        [phoneDict setObject:_dateto forKey:@"dateto"];
    }
    [phoneDict setObject:_blockno forKey:@"blockno"];
    [phoneDict setObject:_mtlname forKey:@"mtlname"];
    [phoneDict setObject:_whsName forKey:@"whsName"];
    [phoneDict setObject:_storeareaName forKey:@"storeareaName"];
    [phoneDict setObject:_locationName forKey:@"locationName"];
    [phoneDict setObject:[NSNumber numberWithInt:1] forKey:@"nowpage"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"pagesize"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.length] forKey:@"length"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.width] forKey:@"width"];
    [phoneDict setObject:[NSNumber numberWithInteger:_lengthType] forKey:@"lengthType"];
    [phoneDict setObject:[NSNumber numberWithInteger:_widthType] forKey:@"widthType"];
    //[phoneDict setObject:@"" forKey:@"mtlnames"];
    [phoneDict setObject:[UserManger getUserObject].userID forKey:@"userId"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    RSWeakself
    [network getDataWithUrlString:usr withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [weakSelf.maDanArray removeAllObjects];
                weakSelf.sumListmodel = nil;
                if ([self.title isEqualToString:@"大板库存"] || [self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"]) {
                    weakSelf.maDanArray = [RSSLBalanceModel mj_objectArrayWithKeyValuesArray:json[@"Data"][@"list"]];
                    weakSelf.sumListmodel = [RSSumLiistModel mj_objectWithKeyValues:json[@"Data"][@"sumlist"]];
                }else{
                    weakSelf.maDanArray = [RSBMBalanceModel mj_objectArrayWithKeyValuesArray:json[@"Data"][@"list"]];
                    weakSelf.sumListmodel = [RSSumLiistModel mj_objectWithKeyValues:json[@"Data"][@"sumlist"]];
                }
                weakSelf.pageNum = 2;
                [weakSelf setBottomViewContent];
                [SVProgressHUD dismiss];
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [SVProgressHUD dismiss];
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            [SVProgressHUD dismiss];
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)DetailOfChargesMoreNewData{
    NSString * usr = [NSString string];
    if ([self.title isEqualToString:@"大板库存"]) {
        usr = URL_GETBLOCKSLBALANCE_IOS;
    }else if ([self.title isEqualToString:@"荒料库存"]){
        usr = URL_GETMTLBMBALANCE_IOS;
    }else if ([self.title isEqualToString:@"大板入库明细"]){
        usr = URL_GETSLINSUM_IOS;
    }else if ([self.title isEqualToString:@"大板出库明细"]){
        usr = URL_GETSLOUTSUM_IOS;
    }else if ([self.title isEqualToString:@"荒料入库明细"]){
        usr = URL_GETBMIN_IOS;
    }else{
        usr = URL_GETBMOUT_IOS;
    }
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    if ([self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"] || [self.title isEqualToString:@"大板库存"] ) {
        [phoneDict setObject:_turnsno forKey:@"turnsno"];
    }
    if ([self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"] || [self.title isEqualToString:@"荒料入库明细"] || [self.title isEqualToString:@"荒料出库明细"]) {
        [phoneDict setObject:_datefrom forKey:@"datefrom"];
        [phoneDict setObject:_dateto forKey:@"dateto"];
    }
    [phoneDict setObject:_blockno forKey:@"blockno"];
    [phoneDict setObject:_mtlname forKey:@"mtlname"];
    [phoneDict setObject:_whsName forKey:@"whsName"];
    [phoneDict setObject:_storeareaName forKey:@"storeareaName"];
    [phoneDict setObject:_locationName forKey:@"locationName"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"nowpage"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"pagesize"];
    [phoneDict setObject:[UserManger getUserObject].userID forKey:@"userId"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.length] forKey:@"length"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.width] forKey:@"width"];
    [phoneDict setObject:[NSNumber numberWithInteger:_lengthType] forKey:@"lengthType"];
    [phoneDict setObject:[NSNumber numberWithInteger:_widthType] forKey:@"widthType"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    RSWeakself
    [network getDataWithUrlString:usr withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Resutl = [json[@"Result"] boolValue];
            if (Resutl) {
                NSMutableArray * tempArray = [NSMutableArray array];
                if ([self.title isEqualToString:@"大板库存"] || [self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"]) {
                    tempArray = [RSSLBalanceModel mj_objectArrayWithKeyValuesArray:json[@"Data"][@"list"]];
                    weakSelf.sumListmodel = [RSSumLiistModel mj_objectWithKeyValues:json[@"Data"][@"sumlist"]];
                }else{
                    tempArray = [RSBMBalanceModel mj_objectArrayWithKeyValuesArray:json[@"Data"][@"list"]];
                    weakSelf.sumListmodel = [RSSumLiistModel mj_objectWithKeyValues:json[@"Data"][@"sumlist"]];
                }
                [weakSelf.maDanArray addObjectsFromArray:tempArray];
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
                weakSelf.pageNum++;
            }else{
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}

#pragma mark -- RSDetailOfChargesLeftScreenViewDelegate
- (void)selectorDatefrom:(NSString *)datefrom andDateto:(NSString *)Dateto andMtlname:(NSString *)mtlname andBlockno:(NSString *)blockno andWhsName:(NSString *)whsName andStoreareaName:(NSString *)storeareaName andLocationName:(NSString *)locationName andTurnsno:(NSString *)turnsno andLength:(NSString *)length andLengthType:(NSString *)lengthType andWidth:(NSString *)width andWidthType:(NSString *)widthType{
    [_leftview hide];
    _datefrom = datefrom;
    _dateto = Dateto;
    _mtlname = mtlname;
    _blockno = blockno;
    _whsName = whsName;
    _storeareaName = storeareaName;
    _locationName = locationName;
    _turnsno = turnsno;
    _length = [length integerValue];
    _width = [width integerValue];
    if ([lengthType isEqualToString:@"大于"]) {
        _lengthType = 1;
    }else if ([lengthType isEqualToString:@"等于"]){
        _lengthType = 2;
    }else if ([lengthType isEqualToString:@"小于"]){
        _lengthType = 3;
    }
    if ([widthType isEqualToString:@"大于"]) {
        _widthType = 1;
    }else if ([widthType isEqualToString:@"等于"]){
        _widthType = 2;
    }else if ([widthType isEqualToString:@"小于"]){
        _widthType = 3;
    }
    //重新获取网络数据
    [self DetailOfChargesData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.maDanArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * REPORTFORMDETAILID = @"reportformdetailid";
    RSReportDetialCell * cell = [tableView dequeueReusableCellWithIdentifier:REPORTFORMDETAILID];
    if (!cell) {
        cell = [[RSReportDetialCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:REPORTFORMDETAILID];
    }
    if ([self.title isEqualToString:@"大板库存"] || [self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"]) {
        RSSLBalanceModel * slbalancemodel = self.maDanArray[indexPath.row];
        cell.productLabel.text = [NSString stringWithFormat:@"%@ %@/%@",slbalancemodel.mtlname,slbalancemodel.msid,slbalancemodel.csid];
        cell.keLabel.text = [NSString stringWithFormat:@"%ld",slbalancemodel.turnsqty];
        cell.zongKeLabel.text = @"总匝数";
        cell.LiLabel.text = [NSString stringWithFormat:@"%ld",slbalancemodel.qty];
        cell.zongLiLabel.text = @"总片数";
        cell.weightLabel.text = [NSString stringWithFormat:@"%.3lfm²",slbalancemodel.area];
        cell.zongWeightLabel.text = @"总面积";
        cell.label.text = [NSString stringWithFormat:@"%ld",slbalancemodel.n];
    }else{
        RSBMBalanceModel  * bmbalancemodel = self.maDanArray[indexPath.row];
        cell.zongKeLabel.text = @"总颗数";
        cell.zongWeightLabel.text = @"总重量";
        cell.zongLiLabel.text = @"总体积";
        cell.productLabel.text = [NSString stringWithFormat:@"%@",bmbalancemodel.mtlname];
        cell.keLabel.text = [NSString stringWithFormat:@"%ld",bmbalancemodel.qty];
        cell.LiLabel.text = [NSString stringWithFormat:@"%.3lfm³",bmbalancemodel.volume];
        cell.weightLabel.text = [NSString stringWithFormat:@"%.lf吨",bmbalancemodel.weight];
        cell.label.text = [NSString stringWithFormat:@"%ld",bmbalancemodel.n];
    }
    cell.singlecodeBtn.tag = indexPath.row + 10000000;
    [cell.singlecodeBtn addTarget:self action:@selector(selectorMaDanReport:) forControlEvents:UIControlEventTouchUpInside];
    cell.reportFormBtn.tag = indexPath.row + 10000000;
    [cell.reportFormBtn addTarget:self action:@selector(reportFormAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.title isEqualToString:@"大板库存"] || [self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"]) {
        RSReportFormSLShareViewController * reportFormSLShareVc = [[RSReportFormSLShareViewController alloc]init];
        reportFormSLShareVc.title = self.title;
        reportFormSLShareVc.usermodel = [UserManger getUserObject];
        RSSLBalanceModel  * slbalancemodel = self.maDanArray[indexPath.row];
        reportFormSLShareVc.blockno = _blockno;
        reportFormSLShareVc.blocknos = slbalancemodel.msid;
        reportFormSLShareVc.mtlname = @"";
        reportFormSLShareVc.mtlnames = slbalancemodel.mtlname;;
        reportFormSLShareVc.whsName = _whsName;
        reportFormSLShareVc.storeareaName = _storeareaName;
        reportFormSLShareVc.locationName = _locationName;
        reportFormSLShareVc.length = _length;
        reportFormSLShareVc.width = _width;
        reportFormSLShareVc.lengthType = _lengthType;
        reportFormSLShareVc.widthType = _widthType;
        reportFormSLShareVc.turnsno = _turnsno;
        if ([self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"]){
            reportFormSLShareVc.datefrom = _datefrom;
            reportFormSLShareVc.Dateto = _dateto;
        }
        [self.navigationController pushViewController:reportFormSLShareVc animated:YES];
    }else{
        RSReportFormShareViewController * reportFormShareVc = [[RSReportFormShareViewController alloc]init];
        reportFormShareVc.title = self.title;
        reportFormShareVc.usermodel = [UserManger getUserObject];
        RSBMBalanceModel  * bmbalancemodel = self.maDanArray[indexPath.row];
        reportFormShareVc.blockno = _blockno;
        reportFormShareVc.mtlname = @"";
        reportFormShareVc.mtlnames = bmbalancemodel.mtlname;
        reportFormShareVc.whsName = _whsName;
        reportFormShareVc.storeareaName = _storeareaName;
        reportFormShareVc.locationName = _locationName;
        reportFormShareVc.length = _length;
        reportFormShareVc.width = _width;
        reportFormShareVc.lengthType = _lengthType;
        reportFormShareVc.widthType = _widthType;
        if ([self.title isEqualToString:@"荒料入库明细"] || [self.title isEqualToString:@"荒料出库明细"]){
            reportFormShareVc.datefrom = _datefrom;
            reportFormShareVc.Dateto = _dateto;
        }
        [self.navigationController pushViewController:reportFormShareVc animated:YES];
    }
}


- (void)setBottomViewContent{
    
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    bottomView.frame = CGRectMake(0, SCH - Height_NavBar - 50, SCW, 50);
    [self.view addSubview:bottomView];
    [bottomView bringSubviewToFront:self.view];
    
    UILabel * totalLabel = [[UILabel alloc]init];
    totalLabel.text = @"合计";
    totalLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FDAF1C"];
    totalLabel.font = [UIFont systemFontOfSize:14];
    totalLabel.textAlignment = NSTextAlignmentCenter;
    totalLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    totalLabel.frame = CGRectMake(0, 0, 70, 50);
    [bottomView addSubview:totalLabel];
    
    UILabel * totalNumberLabel = [[UILabel alloc]init];
    totalNumberLabel.frame = CGRectMake(CGRectGetMaxX(totalLabel.frame) + 10, 0, 60, 50);
   
    totalNumberLabel.textAlignment = NSTextAlignmentLeft;
    totalNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#555555"];
    totalNumberLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:totalNumberLabel];
    
    UILabel * totalDetailNumberLabel = [[UILabel alloc]init];
    totalDetailNumberLabel.frame = CGRectMake(CGRectGetMaxX(totalNumberLabel.frame), 0, 60, 50);
    
    totalDetailNumberLabel.textAlignment = NSTextAlignmentLeft;
    totalDetailNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    totalDetailNumberLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:totalDetailNumberLabel];
    
    UILabel * totalVomlmeAndAreaLabel = [[UILabel alloc]init];
    totalVomlmeAndAreaLabel.frame = CGRectMake(CGRectGetMaxX(totalDetailNumberLabel.frame), 0, 60, 50);
    totalVomlmeAndAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#555555"];
    totalVomlmeAndAreaLabel.font = [UIFont systemFontOfSize:14];
    totalVomlmeAndAreaLabel.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:totalVomlmeAndAreaLabel];
    
    UILabel * totalDetailVomlmeAndAreaLabel = [[UILabel alloc]init];
    totalDetailVomlmeAndAreaLabel.frame = CGRectMake(CGRectGetMaxX(totalVomlmeAndAreaLabel.frame), 0, 100, 50);
    
    totalDetailVomlmeAndAreaLabel.textAlignment = NSTextAlignmentLeft;
    totalDetailVomlmeAndAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    totalDetailVomlmeAndAreaLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:totalDetailVomlmeAndAreaLabel];

    if ([self.title isEqualToString:@"大板库存"] || [self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"]) {
         totalNumberLabel.text = @"总匝数";
        totalVomlmeAndAreaLabel.text = @"总面积";
        totalDetailNumberLabel.text = [NSString stringWithFormat:@"%ld匝",self.sumListmodel.totalturnsqty];
        totalDetailVomlmeAndAreaLabel.text = [NSString stringWithFormat:@"%0.3lfm²",self.sumListmodel.totalarea];
    }else{
        totalNumberLabel.text = @"总颗数";
        totalVomlmeAndAreaLabel.text = @"总体积";
        totalDetailNumberLabel.text = [NSString stringWithFormat:@"%ld颗",self.sumListmodel.sumqty];
        totalDetailVomlmeAndAreaLabel.text = [NSString stringWithFormat:@"%0.3lfm³",self.sumListmodel.sumvolume ];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 117;
}

//FIXME:点击报表
- (void)reportFormAction:(UIButton *)reportFormBtn{
    RSStoneExhibitionWebViewViewController * stoneExhibitionVc = [[RSStoneExhibitionWebViewViewController alloc]init];
    /**
     // pageType： 1   （1：荒料库存码单  2：荒料出库码单 3：荒料入库码单 4：大板库存码单 5：大板出库码单 6：大板入库码单）
     // appType：1   （1：ios  2：安卓）
     //  userId：xxx   （当前用户的id）具体的键值由后台定
     //  mtlCode：ESB000295/DH-539  （当前荒料号）大板有俩个值拼接 荒料咩有这个俩个值
     // totalSheetSun：xxx   （大板该码单的总片数）
     // totalVol：xxx    （大板该码单的总面积）
     selectedkeyArr：xxx,xxx,xxx   （selectedkey  list，多个匝的selectedkey用逗号分割）
     // mtlName：xxx   （荒料名称  筛选字段）
     // blockno：xxx    （荒料号  筛选字段）
     // turnsno：xxx    （匝号  筛选字段）
     // datefrom：xxx   （开始日期  筛选字段）
     // dateto：xxx     （结束日期  筛选字段）
     // whsname：xxx   （仓库  筛选字段）
     // storeareaname：xxx  （库区  筛选字段）
     // locationname：xxx   （储位  筛选字段）
     // length （长）
     // lengthType 长的类型
     // width (宽)
     // widthType 宽的类型
     */
    stoneExhibitionVc.title = self.title;
    if ([self.title isEqualToString:@"大板库存"] || [self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"]) {
        RSSLBalanceModel * slbalancemodel = self.maDanArray[reportFormBtn.tag - 10000000];
        //TODO:大板
        stoneExhibitionVc.mtlName = slbalancemodel.mtlname;
        stoneExhibitionVc.totalSheetSun = slbalancemodel.qty;
        stoneExhibitionVc.totalVol = slbalancemodel.area;
        stoneExhibitionVc.selectedkeyArr = slbalancemodel.selectedKey;
        stoneExhibitionVc.mtlCode = [NSString stringWithFormat:@"%@/%@",slbalancemodel.msid,slbalancemodel.csid];
        stoneExhibitionVc.turnsno = self.turnsno;
    }else{
        //TODO:荒料
        RSBMBalanceModel  * bmbalancemodel = self.maDanArray[reportFormBtn.tag - 10000000];
        stoneExhibitionVc.mtlName = bmbalancemodel.mtlname;
        stoneExhibitionVc.totalSheetSun = bmbalancemodel.qty;
        stoneExhibitionVc.totalVol = bmbalancemodel.volume;
        stoneExhibitionVc.mtlCode = bmbalancemodel.mtlname;
        stoneExhibitionVc.turnsno = self.turnsno;
    }
    //userId：xxx
    //appType 1
    //_selectorIndex
    stoneExhibitionVc.webStr = @"slsw/reportList.html";
    stoneExhibitionVc.whsname = self.whsName;
    stoneExhibitionVc.storeareaname = self.storeareaName;
    stoneExhibitionVc.locationname = self.locationName;
    stoneExhibitionVc.blockno = self.blockno;
    stoneExhibitionVc.datefrom = self.datefrom;
    stoneExhibitionVc.dateto = self.dateto;
    stoneExhibitionVc.pageType = _selectorIndex;
    stoneExhibitionVc.appType = 1;
    stoneExhibitionVc.usermodel = [UserManger getUserObject];
    stoneExhibitionVc.length = self.length;
    stoneExhibitionVc.width = self.width;
    stoneExhibitionVc.lengthType = self.lengthType;
    stoneExhibitionVc.widthType = self.widthType;
    [self.navigationController pushViewController:stoneExhibitionVc animated:YES];
}


#pragma mark -- 点击码单
- (void)selectorMaDanReport:(UIButton *)singlecodeBtn{
    [self shareCodeSheetNewData:singlecodeBtn.tag - 10000000 andBlock:^(BOOL result, NSMutableArray *resultArray) {
        if (resultArray.count > 0) {
            RSPersonalWkWebviewViewController * personalWkVc = [[RSPersonalWkWebviewViewController alloc]init];
            if ([self.title isEqualToString:@"荒料库存"]) {
                personalWkVc.pageType = 1;
            }else if ([self.title isEqualToString:@"荒料入库明细"]){
                personalWkVc.pageType = 3;
            }else if ([self.title isEqualToString:@"荒料出库明细"]){
                personalWkVc.pageType = 2;
            }else if ([self.title isEqualToString:@"大板库存"]) {
                personalWkVc.pageType = 4;
            }else if ([self.title isEqualToString:@"大板入库明细"]){
                personalWkVc.pageType = 6;
            }else if ([self.title isEqualToString:@"大板出库明细"]){
                personalWkVc.pageType = 5;
            }
            personalWkVc.typeStr = self.title;
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            personalWkVc.VerifyKey = [user objectForKey:@"VERIFYKEY"];
            personalWkVc.appType = 1;
            personalWkVc.showT = 1;
            personalWkVc.webStr = [NSString stringWithFormat:@"%@slsw/codeList.html",URL_HEADER_TEXT_IOS];
            NSString * reportUrlStr = [NSString stringWithFormat:@"%@?appType=%ld&pageType=%ld", personalWkVc.webStr,personalWkVc.appType,personalWkVc.pageType];
            personalWkVc.ulrStr = reportUrlStr;
            personalWkVc.selectArray = resultArray;
            [self.navigationController pushViewController:personalWkVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"请先去选择你需要分享的内容"];
        }
    }];
    //    RSStoneExhibitionWebViewViewController * stoneExhibitionVc = [[RSStoneExhibitionWebViewViewController alloc]init];
    //    /**
    //     // pageType： 1   （1：荒料库存码单  2：荒料出库码单 3：荒料入库码单 4：大板库存码单 5：大板出库码单 6：大板入库码单）
    //     // appType：1   （1：ios  2：安卓）
    //     //  userId：xxx   （当前用户的id）具体的键值由后台定
    //     //  mtlCode：ESB000295/DH-539  （当前荒料号）大板有俩个值拼接 荒料咩有这个俩个值
    //     // totalSheetSun：xxx   （大板该码单的总片数）
    //     // totalVol：xxx    （大板该码单的总面积）
    //     selectedkeyArr：xxx,xxx,xxx   （selectedkey  list，多个匝的selectedkey用逗号分割）
    //     // mtlName：xxx   （荒料名称  筛选字段）
    //     // blockno：xxx    （荒料号  筛选字段）
    //     // turnsno：xxx    （匝号  筛选字段）
    //     // datefrom：xxx   （开始日期  筛选字段）
    //     // dateto：xxx     （结束日期  筛选字段）
    //     // whsname：xxx   （仓库  筛选字段）
    //     // storeareaname：xxx  （库区  筛选字段）
    //     // locationname：xxx   （储位  筛选字段）
    //     // length （长）
    //     // lengthType 长的类型
    //     // width (宽)
    //     // widthType 宽的类型
    //     */
    //     //http://117.29.162.206:8888/slsw/codeList.html  码单页面 app 拼接的url，参数和以前的报表是一样传
    //    stoneExhibitionVc.title = self.title;
    //    if ([self.title isEqualToString:@"大板库存码单"] || [self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"]) {
    //        RSSLBalanceModel * slbalancemodel = self.maDanArray[singlecodeBtn.tag - 10000000];
    //        //TODO:大板
    //        stoneExhibitionVc.mtlName = slbalancemodel.mtlname;
    //        stoneExhibitionVc.totalSheetSun = slbalancemodel.qty;
    //        stoneExhibitionVc.totalVol = slbalancemodel.area;
    //        stoneExhibitionVc.selectedkeyArr = slbalancemodel.selectedKey;
    //        stoneExhibitionVc.mtlCode = [NSString stringWithFormat:@"%@/%@",slbalancemodel.msid,slbalancemodel.csid];
    //        stoneExhibitionVc.turnsno = self.turnsno;
    //    }else{
    //        //TODO:荒料
    //        RSBMBalanceModel  * bmbalancemodel = self.maDanArray[singlecodeBtn.tag - 10000000];
    //        stoneExhibitionVc.mtlName = bmbalancemodel.mtlname;
    //        stoneExhibitionVc.totalSheetSun = bmbalancemodel.qty;
    //        stoneExhibitionVc.totalVol = bmbalancemodel.volume;
    //        stoneExhibitionVc.mtlCode = bmbalancemodel.mtlname;
    //        stoneExhibitionVc.turnsno = self.turnsno;
    //    }
    //    //userId：xxx
    //    //appType 1
    //    //_selectorIndex
    //    stoneExhibitionVc.webStr = @"slsw/codeList.html";
    //    stoneExhibitionVc.whsname = self.whsName;
    //    stoneExhibitionVc.storeareaname = self.storeareaName;
    //    stoneExhibitionVc.locationname = self.locationName;
    //    stoneExhibitionVc.blockno = self.blockno;
    //    stoneExhibitionVc.datefrom = self.datefrom;
    //    stoneExhibitionVc.dateto = self.dateto;
    //    stoneExhibitionVc.pageType = _selectorIndex;
    //    stoneExhibitionVc.appType = 1;
    //    stoneExhibitionVc.usermodel = self.usermodel;
    //    stoneExhibitionVc.length = self.length;
    //    stoneExhibitionVc.width = self.width;
    //    stoneExhibitionVc.lengthType = self.lengthType;
    //    stoneExhibitionVc.widthType = self.widthType;
    //    [self.navigationController pushViewController:stoneExhibitionVc animated:YES];
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)shareCodeSheetNewData:(NSInteger)index andBlock:(void(^)(BOOL result,NSMutableArray * resultArray))share{
    NSString * usr = [NSString string];
    if ([self.title isEqualToString:@"大板库存"]) {
        usr = URL_MTLSLBALANCE_IOS;
    }else if ([self.title isEqualToString:@"荒料库存"]){
        usr = URL_BMBALANCEDTL_IOS;
    }else if ([self.title isEqualToString:@"大板入库明细"]){
        usr = URL_SLIN_IOS;
    }else if ([self.title isEqualToString:@"大板出库明细"]){
        usr = URL_SLOUT_IOS;
    }else if ([self.title isEqualToString:@"荒料入库明细"]){
        usr = URL_BMINDTL_IOS;
    }else if ([self.title isEqualToString:@"荒料出库明细"]){
        usr = URL_BMOUTDTL_IOS;
    }
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setValue:[UserManger getUserObject].userID forKey:@"id"];
    [phoneDict setValue:[NSNumber numberWithInteger:1] forKey:@"nowpage"];
    [phoneDict setValue:[NSString stringWithFormat:@"100000000"] forKey:@"pagesize"];
    //    [phoneDict setValue:applegate.ERPID forKey:@"erpId"];
    [phoneDict setValue:self.blockno forKey:@"blockno"];
    [phoneDict setValue:[NSNumber numberWithInteger:self.length] forKey:@"length"];
    [phoneDict setValue:[NSNumber numberWithInteger:self.lengthType] forKey:@"lengthType"];
    [phoneDict setValue:[NSNumber numberWithInteger:self.width] forKey:@"width"];
    [phoneDict setValue:[NSNumber numberWithInteger:self.widthType] forKey:@"widthType"];
    [phoneDict setValue:@"" forKey:@"mtlname"];
    if ([self.title isEqualToString:@"大板库存"] || [self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"]) {
        RSSLBalanceModel * slbalancemodel = self.maDanArray[index];
        [phoneDict setValue:slbalancemodel.mtlname forKey:@"mtlnames"];
        [phoneDict setValue:slbalancemodel.msid forKey:@"blocknos"];
        [phoneDict setValue:self.turnsno forKey:@"turnsno"];
    }else{
        RSBMBalanceModel  * bmbalancemodel = self.maDanArray[index];
        [phoneDict setValue:bmbalancemodel.mtlname forKey:@"mtlnames"];
    }
    [phoneDict setValue:self.whsName forKey:@"whsName"];
    [phoneDict setValue:self.storeareaName forKey:@"storeareaName"];
    [phoneDict setValue:self.locationName forKey:@"locationName"];
    if ([self.title isEqualToString:@"荒料入库明细"] || [self.title isEqualToString:@"荒料出库明细"] || [self.title isEqualToString:@"大板出库明细"] || [self.title isEqualToString:@"大板入库明细"]) {
        [phoneDict setValue:_datefrom forKey:@"datefrom"];
        [phoneDict setValue:_dateto forKey:@"dateto"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:usr withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"Result"]boolValue];
            if (isresult) {
                [weakSelf.detialArray removeAllObjects];
                if ([self.title isEqualToString:@"荒料库存"] || [self.title isEqualToString:@"荒料入库明细"] || [self.title isEqualToString:@"荒料出库明细"]) {
                    weakSelf.detialArray = [RSReportFormShareBLModel mj_objectArrayWithKeyValuesArray:json[@"Data"][@"list"]];
                }else{
                    NSMutableArray * array = [NSMutableArray array];
                    array = json[@"Data"][@"list"];
                    NSMutableArray * tempArray = [NSMutableArray array];
                    for (int i = 0; i < array.count; i++) {
                        RSReportFormShareSLModel * reportFormShareSLmodel = [[RSReportFormShareSLModel alloc]init];
                        reportFormShareSLmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                        reportFormShareSLmodel.csid = [[array objectAtIndex:i]objectForKey:@"csid"];
                        reportFormShareSLmodel.deaName = [[array objectAtIndex:i]objectForKey:@"deaName"];
                        reportFormShareSLmodel.materialtype = [[array objectAtIndex:i]objectForKey:@"materialtype"];
                        reportFormShareSLmodel.msid = [[array objectAtIndex:i]objectForKey:@"msid"];
                        reportFormShareSLmodel.mtlname = [[array objectAtIndex:i]objectForKey:@"mtlname"];
                        reportFormShareSLmodel.turnsno = [[array objectAtIndex:i]objectForKey:@"turnsno"];
                        reportFormShareSLmodel.n = [[[array objectAtIndex:i]objectForKey:@"n"] integerValue];
                        reportFormShareSLmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                        tempArray = [[array objectAtIndex:i] objectForKey:@"pieces"];
                        for (int j = 0; j < tempArray.count; j++) {
                            RSReportFormShareSLPiecesModel *  reportFormShareSLPiecesmodel = [[RSReportFormShareSLPiecesModel alloc]init];
                            reportFormShareSLPiecesmodel.csid = [[tempArray objectAtIndex:j]objectForKey:@"csid"];
                            reportFormShareSLPiecesmodel.deaName = [[tempArray objectAtIndex:j]objectForKey:@"deaName"];
                            reportFormShareSLPiecesmodel.deacode = [[tempArray objectAtIndex:j]objectForKey:@"deacode"];
                            //reportFormShareSLPiecesmodel.ded_length_four = [[tempArray objectAtIndex:j]objectForKey:@"area"];
                            //reportFormShareSLPiecesmodel.area = [[tempArray objectAtIndex:j]objectForKey:@"area"];
                            reportFormShareSLPiecesmodel.area = [[tempArray objectAtIndex:j]objectForKey:@"area"];
                            reportFormShareSLPiecesmodel.ded_length_four = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_four"];
                            reportFormShareSLPiecesmodel.ded_length_one = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_one"];
                            reportFormShareSLPiecesmodel.ded_length_three = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_three"];
                            reportFormShareSLPiecesmodel.ded_length_two = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_two"];
                            reportFormShareSLPiecesmodel.ded_wide_four = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_four"];
                            reportFormShareSLPiecesmodel.ded_wide_one = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_one"];
                            reportFormShareSLPiecesmodel.ded_wide_three = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_three"];
                            reportFormShareSLPiecesmodel.ded_wide_two = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_two"];
                            reportFormShareSLPiecesmodel.dedarea = [[tempArray objectAtIndex:j]objectForKey:@"dedarea"];
                            reportFormShareSLPiecesmodel.did = [[[tempArray objectAtIndex:j]objectForKey:@"did"] integerValue];
                            reportFormShareSLPiecesmodel.height = [[[tempArray objectAtIndex:j]objectForKey:@"height"] integerValue];
                            reportFormShareSLPiecesmodel.lenght = [[[tempArray objectAtIndex:j]objectForKey:@"lenght"] integerValue];
                            reportFormShareSLPiecesmodel.locationname = [[tempArray objectAtIndex:j]objectForKey:@"locationname"];
                            reportFormShareSLPiecesmodel.materialtype = [[tempArray objectAtIndex:j]objectForKey:@"materialtype"];
                            reportFormShareSLPiecesmodel.msid = [[tempArray objectAtIndex:j]objectForKey:@"msid"];
                            reportFormShareSLPiecesmodel.mtlcode = [[tempArray objectAtIndex:j]objectForKey:@"mtlcode"];
                            reportFormShareSLPiecesmodel.mtlname = [[tempArray objectAtIndex:j]objectForKey:@"mtlname"];
                            reportFormShareSLPiecesmodel.n = [[[tempArray objectAtIndex:j]objectForKey:@"n"] integerValue];
                            reportFormShareSLPiecesmodel.prearea = [[tempArray objectAtIndex:j]objectForKey:@"prearea"];
                            reportFormShareSLPiecesmodel.qty = [[[tempArray objectAtIndex:j]objectForKey:@"qty"] integerValue];
                            reportFormShareSLPiecesmodel.slno = [[tempArray objectAtIndex:j]objectForKey:@"slno"];
                            reportFormShareSLPiecesmodel.storeareaname = [[tempArray objectAtIndex:j]objectForKey:@"storeareaname"];
                            reportFormShareSLPiecesmodel.turnsno = [[tempArray objectAtIndex:j]objectForKey:@"turnsno"];
                            reportFormShareSLPiecesmodel.whsname = [[tempArray objectAtIndex:j]objectForKey:@"whsname"];
                            reportFormShareSLPiecesmodel.width = [[[tempArray objectAtIndex:j]objectForKey:@"width"] integerValue];
                            reportFormShareSLPiecesmodel.isSelect = false;
                            [reportFormShareSLmodel.pieces addObject:reportFormShareSLPiecesmodel];
                        }
                        [weakSelf.detialArray addObject:reportFormShareSLmodel];
                    }
                }
                if (share) {
                    share(false,weakSelf.detialArray);
                }
            }else{
                [JHSysAlertUtil presentAlertViewWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"MSG_CODE"]] confirmTitle:@"确定" handler:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
//                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"MSG_CODE"]] preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                }];
//                [alertView addAction:alert];
//                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
//                }
//                [weakSelf presentViewController:alertView animated:YES completion:nil];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
