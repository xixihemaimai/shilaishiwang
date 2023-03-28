//
//  RSRunningAccountViewController.m
//  石来石往
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSRunningAccountViewController.h"
//#import "RSRunningAccountBaseCell.h"
#import "RSRunningAccountCloseCell.h"
//#import "RSRunningAccountOpenCell.h"
//#import "RSSalertView.h"
#import "RSReportFormView.h"
#import "RSReportFormMenuView.h"
//模型
#import "RSBalanceModel.h"
#import "RSAccountDetailModel.h"
#import "RSWarehouseModel.h"
#import "RSAccountAlertView.h"


@interface RSRunningAccountViewController ()<RSRunningAccountCloseCellDelegate>
{
    UIView * _centerView;
}
@property (nonatomic,assign) NSInteger isOpen;

@property (nonatomic,assign) NSInteger cellIndex;
//有多少cell没有展开的数组
@property (nonatomic,strong)NSMutableArray * runArray;

@property (nonatomic,strong)NSMutableDictionary * blockDict;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)RSAccountAlertView * accountAlertView;

@property (nonatomic ,strong)RSReportFormMenuView * menu;

@property (nonatomic,strong)NSString * btnType;

@end

@implementation RSRunningAccountViewController

- (NSMutableDictionary *)blockDict{
    if (!_blockDict) {
        _blockDict = [NSMutableDictionary dictionary];
    }
    return _blockDict;
}


//- (RSAccountAlertView *)accountAlertView{
//
//    if (!_accountAlertView) {
//        _accountAlertView = [[RSAccountAlertView alloc]init];
//        _accountAlertView.backgroundColor = [UIColor whiteColor];
//    }
//
//    return _accountAlertView;
//}
//

- (NSMutableArray *)runArray{
    if (!_runArray) {
        _runArray = [NSMutableArray array];
    }
    return _runArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.type = @"SUM";
    self.pageNum = 2;
    
    UIButton * warehouseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [warehouseBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [warehouseBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    warehouseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:warehouseBtn];
    
    [warehouseBtn addTarget:self action:@selector(warehouseRunningAccountAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = rightitem;

    
    
    [self.blockDict setObject:@"2019-01-01" forKey:@"dateFrom"];
    [self.blockDict setObject:[self showCurrentTime] forKey:@"dateTo"];
    [self.blockDict setObject:@"" forKey:@"mtlName"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"mtlId"];
    [self.blockDict setObject:@"" forKey:@"blockNo"];
    [self.blockDict setObject:@"" forKey:@"whsName"];
    [self.blockDict setObject:@"" forKey:@"storageType"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
    
    [self.blockDict setObject:[NSNumber numberWithInteger:-1] forKey:@"isFrozen"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0]  forKey:@"widthType"];
    [self.blockDict setObject:@"" forKey:@"length"];
    [self.blockDict setObject:@"" forKey:@"width"];
    
    [self.blockDict setObject:@"1" forKey:@"pageNum"];
    [self.blockDict setObject:@"10" forKey:@"pageSize"];
    
    
    
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableview.estimatedRowHeight = 0;
        self.tableview.estimatedSectionFooterHeight = 0;
        self.tableview.estimatedSectionHeaderHeight = 0;
    }
    
    
    RSWeakself
   // [self runningReloadNewData];

    
    
    
    
    
   
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.runArray.count > 0) {
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
            [weakSelf runningReloadNewData];
        }
    }];
   
    
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        if (weakSelf.runArray.count > 0) {
        [weakSelf runningReloadNewMoreData];
        }
    }];
    
   
    
    
    [self showNoNewDataView];
    
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf runningReloadNewData];
//    }];
    
    RSReportFormView * reportformView = [[RSReportFormView alloc]initWithFrame:CGRectMake(91, 0, [UIScreen mainScreen].bounds.size.width - 91, [UIScreen mainScreen].bounds.size.height)];
    reportformView.longIndex = 0;
    reportformView.withIndex = 0;
    reportformView.wareHouseIndex = 0;
    reportformView.frozenviewIndex = 0;
    reportformView.inSelect = @"1";
    reportformView.selectFunctionType = self.selectFunctionType;
    __weak typeof(reportformView) weakReportformview = reportformView;
    reportformView.reportformSelect = ^(NSString * _Nonnull inSelect,NSString * _Nonnull beginTime, NSString * _Nonnull endTime, NSString * _Nonnull wuliaoTextView, NSString * _Nonnull blockTextView, NSString * _Nonnull longTypeView, NSInteger longIndex, NSString * _Nonnull longTextView, NSString * _Nonnull withTypeView, NSInteger withIndex, NSString * _Nonnull withTextView, NSString * _Nonnull luTypeView, NSString * _Nonnull wareHouseView, NSInteger wareHouseIndex, NSString * _Nonnull frozenView, NSInteger frozenviewIndex) {
        [weakSelf.blockDict setObject:[weakSelf showDisplayTheTime:beginTime] forKey:@"dateFrom"];
        [weakSelf.blockDict setObject:[weakSelf showDisplayTheTime:endTime] forKey:@"dateTo"];
        [weakSelf.blockDict setObject:wuliaoTextView forKey:@"mtlName"];
        [weakSelf.blockDict setObject:blockTextView forKey:@"blockNo"];
        
        weakReportformview.wareHouseIndex = wareHouseIndex;
        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
        NSMutableArray * warehouseArray = [db getAllContent:@"BL"];
        RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
        warehousemodel.code = @"";
        warehousemodel.createTime = @"";
        warehousemodel.name = @"请选出所在仓库";
        warehousemodel.updateTime = @"";
        warehousemodel.whstype = @"";
        warehousemodel.createUser = 0;
        warehousemodel.pwmsUserId = 0;
        warehousemodel.status = 0;
        warehousemodel.updateUser = 0;
        warehousemodel.WareHouseID = 0;
        [warehouseArray insertObject:warehousemodel atIndex:0];
 
        RSWarehouseModel * warehousemodel1 = warehouseArray[wareHouseIndex];
        if ([warehousemodel1.name isEqualToString:@"请选出所在仓库"]) {
           
            //请选出所在仓库
            [weakSelf.blockDict setObject:@"" forKey:@"whsName"];
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
        }else{
          
            [weakSelf.blockDict setObject:warehousemodel1.name forKey:@"whsName"];
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:warehousemodel1.WareHouseID] forKey:@"whsId"];
        }
        
        
//        if ([wareHouseView isEqualToString:@"请选出所在仓库"]) {
//            [weakSelf.blockDict setObject:@"" forKey:@"whsName"];
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
//            weakReportformview.wareHouseIndex  = 0;
//        }else{
//            RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
//            NSMutableArray * warehouseArray = [db getAllContent:@"BL"];
//
//
//            weakReportformview.wareHouseIndex =  wareHouseIndex;
//            RSWarehouseModel * warehousemodel = warehouseArray[wareHouseIndex-1];
//            [weakSelf.blockDict setObject:warehousemodel.name forKey:@"whsName"];
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID] forKey:@"whsId"];
//        }
//
        
        
        
        
        if ([luTypeView isEqualToString:@"请选出入库类型"]) {
            [weakSelf.blockDict setObject:@"" forKey:@"storageType"];
        }else{
            NSString * str = [NSString string];
            if ([luTypeView isEqualToString:@"采购入库"]) {
                str = @"CGRK";
            }else if ([luTypeView isEqualToString:@"加工入库"]){
                str = @"JGRK";
            }else if ([luTypeView isEqualToString:@"盘盈入库"]){
                str = @"PYRK";
            }
            [weakSelf.blockDict setObject:str forKey:@"storageType"];
        }
        //不需要
        if ([frozenView isEqualToString:@"请选择"]) {
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:-1] forKey:@"isFrozen"];
        }else{
            if ([frozenView isEqualToString:@"未冻结"]) {
                [weakSelf.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"isFrozen"];
                
            }else{
                [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"isFrozen"];
            }
        }
        if ([longTypeView isEqualToString:@"请选择类型"]) {
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
        }else if ([longTypeView isEqualToString:@"大于"]){
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"lengthType"];
        }else if ([longTypeView isEqualToString:@"等于"]){
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:2] forKey:@"lengthType"];
        }else{
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:3] forKey:@"lengthType"];
        }
        if ([withTypeView isEqualToString:@"请选择类型"]) {
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"widthType"];
        }else if ([longTypeView isEqualToString:@"大于"]){
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"lengthType"];
        }else if ([longTypeView isEqualToString:@"等于"]){
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:2] forKey:@"lengthType"];
        }else{
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:3] forKey:@"lengthType"];
        }
        
//        if ([longTypeView isEqualToString:@"请选择类型"]) {
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
//        }else{
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:longIndex] forKey:@"lengthType"];
//        }
//
//        if ([withTypeView isEqualToString:@"请选择类型"]) {
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"widthType"];
//        }else{
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:withIndex] forKey:@"widthType"];
//        }
        
        if ([longTextView isEqualToString:@""]) {
            [weakSelf.blockDict setObject:@"" forKey:@"length"];
        }else{
            [weakSelf.blockDict setObject:[NSDecimalNumber decimalNumberWithString:longTextView] forKey:@"length"];
        }
        if ([withTextView isEqualToString:@""]) {
            [weakSelf.blockDict setObject:@"" forKey:@"width"];
        }else{
            [weakSelf.blockDict setObject:[NSDecimalNumber decimalNumberWithString:withTextView] forKey:@"width"];
        }
        
        
//        if ([longTypeView isEqualToString:@"请选择类型"]) {
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
//        }else{
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:longIndex] forKey:@"lengthType"];
//        }
//        if ([withTypeView isEqualToString:@"请选择类型"]) {
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"widthType"];
//        }else{
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:longIndex] forKey:@"widthType"];
//        }
//
     //   [weakSelf.blockDict setObject:[NSNumber numberWithDouble:[[NSString stringWithFormat:@"%@",longTextView]doubleValue]] forKey:@"length"];
     //   [weakSelf.blockDict setObject:[NSNumber numberWithDouble:[[NSString stringWithFormat:@"%@",withTextView]doubleValue]] forKey:@"width"];
        [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [weakSelf runningReloadNewData];
        [weakSelf.menu hidenWithAnimation];
    };
    RSReportFormMenuView *menu = [RSReportFormMenuView MenuViewWithDependencyView:self.view MenuView:reportformView isShowCoverView:YES];
    //    MenuView *menu = [[MenuView alloc]initWithDependencyView:self.view MenuView:demo isShowCoverView:YES];
    self.menu = menu;
}


- (void)showNoNewDataView{
    
    UIView * centerView = [[UIView alloc]initWithFrame:CGRectMake(SCW/2 - 80, SCH/2 - 135, 160, 270)];
    centerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:centerView];
    _centerView = centerView;
    [centerView bringSubviewToFront:self.view];
    //图片
    UIImageView * centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 190,160)];
    centerImageView.image = [UIImage imageNamed:@"Group 63"];
    centerImageView.clipsToBounds = YES;
    centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [centerView addSubview:centerImageView];
    
    
    //文字
    UILabel * centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(centerImageView.frame) + 25, 160, 25)];
    centerLabel.text = @"暂无模板";
    centerLabel.font = [UIFont systemFontOfSize:18];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [centerView addSubview:centerLabel];
    
    //按键
    UIButton * centerBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(centerLabel.frame) + 25, 110, 35)];
    [centerBtn setTitle:@"去筛选" forState:UIControlStateNormal];
    [centerBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [centerBtn addTarget:self action:@selector(warehouseRunningAccountAction:) forControlEvents:UIControlEventTouchUpInside];
    [centerBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [centerView addSubview:centerBtn];
    centerBtn.layer.cornerRadius = 15;
}



- (void)runningReloadNewData{
    //URL_BLFLOWACCOUNT_IOS
    [self.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    self.btnType = @"new";
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"SUM" forKey:@"type"];
    [phoneDict setObject:self.blockDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BLFLOWACCOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.runArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSBalanceModel * balancemodel = [[RSBalanceModel alloc]init];
                   // balancemodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"] integerValue];
                    balancemodel.mtlId =  [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                   // balancemodel.whsName = [[array objectAtIndex:i]objectForKey:@"whsName"];
                    balancemodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                   // balancemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                  //  balancemodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                  //  balancemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    
                    //荒料流水账
                    balancemodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    balancemodel.billCount = [[[array objectAtIndex:i]objectForKey:@"billCount"] integerValue];
                    balancemodel.did = [[[array objectAtIndex:i]objectForKey:@"did"]integerValue];
                    balancemodel.isbool = false;
                    [weakSelf.runArray addObject:balancemodel];
                }
                
                if (weakSelf.runArray.count > 0) {
                    _centerView.hidden = YES;
                }else{
                    _centerView.hidden = NO;
                }
                self.pageNum = 2;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                if (weakSelf.runArray.count > 0) {
                    _centerView.hidden = YES;
                }else{
                    _centerView.hidden = NO;
                }
                
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            if (weakSelf.runArray.count > 0) {
                _centerView.hidden = YES;
            }else{
                _centerView.hidden = NO;
            }
            
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}



- (void)runningReloadNewMoreData{
    [self.blockDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [self.blockDict setObject:@"5" forKey:@"pageSize"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"SUM" forKey:@"type"];
    [phoneDict setObject:self.blockDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BLFLOWACCOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                NSMutableArray * tempArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    RSBalanceModel * balancemodel = [[RSBalanceModel alloc]init];
                  //  balancemodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"] integerValue];
                    balancemodel.mtlId =  [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                   // balancemodel.whsName = [[array objectAtIndex:i]objectForKey:@"whsName"];
                    balancemodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                  //  balancemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                  //  balancemodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                  //  balancemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    //荒料流水账
                    balancemodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    balancemodel.billCount = [[[array objectAtIndex:i]objectForKey:@"billCount"] integerValue];
                    balancemodel.did = [[[array objectAtIndex:i]objectForKey:@"did"]integerValue];
                    balancemodel.isbool = false;
                    [tempArray addObject:balancemodel];
                }
              
                [weakSelf.runArray addObjectsFromArray:tempArray];
                
                if (weakSelf.runArray.count > 0) {
                       _centerView.hidden = YES;
                }else{
                       _centerView.hidden = NO;
                }
                
                self.pageNum++;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
            }else{
                if (weakSelf.runArray.count > 0) {
                    _centerView.hidden = YES;
                }else{
                    _centerView.hidden = NO;
                }
                
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            if (weakSelf.runArray.count > 0) {
                _centerView.hidden = YES;
            }else{
                _centerView.hidden = NO;
            }
            
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}


//FIXME:筛选
- (void)warehouseRunningAccountAction:(UIButton *)warehouseBtn{
     [self.menu show];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.runArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   // NSString *row = [NSString stringWithFormat:@"%ld",indexPath.row];
   // BOOL isbool = [self.StatusArray containsObject: row];
    //RSRunningAccountCloseCell * cell = (RSRunningAccountCloseCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    RSBalanceModel * balancemodel = self.runArray[indexPath.row];
    if (balancemodel.isbool == false){
        return 109;
    }else{
        return 109 + (balancemodel.contentArr.count * 44) + 15;
    }
//    return indexPath.row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString * cellIdentifier = [NSString stringWithFormat:@"RUNACCOUNT%ld",(long)indexPath.row];
    RSRunningAccountCloseCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[RSRunningAccountCloseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.tag = indexPath.row;
    cell.delegate = self;
    
    if ([self.btnType isEqualToString:@"new"]) {
        cell.accountOpenImageView.transform = CGAffineTransformIdentity;
        cell.bottomBtn.selected = NO;
    }

    RSBalanceModel * balancemodel = self.runArray[indexPath.row];
    cell.balancemodel = balancemodel;
    cell.bottomBtn.tag = indexPath.row;
    [cell.bottomBtn addTarget:self action:@selector(openMemberView:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)clickOpenDetialContentCurrentCellIndex:(NSInteger)cellIndex andContentArrIndex:(NSInteger)index{
    //BILL_BL_CGRK 采购入库  BILL_BL_JGRK 加工入库 BILL_BL_PYRK 盘盈入库
    //BILL_BL_XSCK 销售出库  BILL_BL_JGCK 加工出库 BILL_BL_PKCK 盘亏出库
    //BILL_BL_YCCL 异常处理
    //BILL_BL_DB 调拨
    
    //BILL_SL_CGRK 大板采购入库 BILL_SL_JGRK 大板加工出库 BILL_SL_PYRK 大板盘盈入库
    //BILL_SL_XSCK 大板销售出库 BILL_SL_JGCK 大板加工出库 BILL_SL_PKCK 大板盘亏出库
    //BILL_SL_YCCL 大板异常处理
    //BILL_SL_DB 大板调拨
    RSBalanceModel * balancemodel = self.runArray[cellIndex];
    RSAccountDetailModel * accountdetailmodel = balancemodel.contentArr[index];
    RSAccountAlertView * accountAlertView = [[RSAccountAlertView alloc]init];
    accountAlertView.accountDetailmodel = accountdetailmodel;
    //这边要弹窗
    if ([accountdetailmodel.billType isEqualToString:@"BILL_BL_CGRK"] || [accountdetailmodel.billType isEqualToString:@"BILL_BL_JGRK"] || [accountdetailmodel.billType isEqualToString:@"BILL_BL_PYRK"] || [accountdetailmodel.billType isEqualToString:@"BILL_BL_XSCK"] || [accountdetailmodel.billType isEqualToString:@"BILL_BL_JGCK"] || [accountdetailmodel.billType isEqualToString:@"BILL_BL_PKCK"]) {
         accountAlertView.frame = CGRectMake(32, SCH/2 - 170, SCW - 64, 340);
    }else if ([accountdetailmodel.billType isEqualToString:@"BILL_BL_DB"]){
        accountAlertView.frame = CGRectMake(32, SCH/2 - 96.5, SCW - 64, 193);
    }else if ([accountdetailmodel.billType isEqualToString:@"BILL_BL_YCCL"]){
        if ([accountdetailmodel.abType isEqualToString:@"dlcl"]) {
             accountAlertView.frame = CGRectMake(32, SCH/2 - 229.5, SCW - 64, 439);
        }else if ([accountdetailmodel.abType isEqualToString:@"ccbg"]){
             accountAlertView.frame = CGRectMake(32, SCH/2 - 123.5, SCW - 64, 247);
        }else{
             accountAlertView.frame = CGRectMake(32, SCH/2 - 92, SCW - 64, 184);
        }
    }
    //self.accountAlertView.accountDetailmodel = accountdetailmodel;
    [accountAlertView showView];
}





- (NSMutableArray *)openReloadNewData:(RSBalanceModel *)balancemodel{
    NSMutableArray * tempArray = [NSMutableArray array];
    NSMutableDictionary * twoDict = [NSMutableDictionary dictionary];
    [twoDict setObject:[self.blockDict objectForKey:@"dateFrom"] forKey:@"dateFrom"];
    [twoDict setObject:[self.blockDict objectForKey:@"dateTo"] forKey:@"dateTo"];
    [twoDict setObject:[self.blockDict objectForKey:@"storageType"] forKey:@"storageType"];
    [twoDict setObject:[self.blockDict objectForKey:@"lengthType"] forKey:@"lengthType"];
    [twoDict setObject:[self.blockDict objectForKey:@"widthType"] forKey:@"widthType"];
    [twoDict setObject:[self.blockDict objectForKey:@"isFrozen"] forKey:@"isFrozen"];
    [twoDict setObject:[self.blockDict objectForKey:@"length"] forKey:@"length"];
    [twoDict setObject:[self.blockDict objectForKey:@"width"] forKey:@"width"];
    [twoDict setObject:[NSNumber numberWithInteger:balancemodel.did] forKey:@"did"];
    [twoDict setObject:[NSNumber numberWithInteger:balancemodel.mtlId] forKey:@"mtlId"];
    [twoDict setObject:balancemodel.blockNo forKey:@"blockNo"];
    [twoDict setObject:@"1" forKey:@"pageNum"];
    [twoDict setObject:@"10000" forKey:@"pageSize"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"DETAIL" forKey:@"type"];
    [phoneDict setObject:twoDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    //RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BLFLOWACCOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0 ; i < array.count; i++) {
                    RSAccountDetailModel * accountdetialmodel = [[RSAccountDetailModel alloc]init];
                    accountdetialmodel.billDate = [[array objectAtIndex:i]objectForKey:@"billDate"];
                    accountdetialmodel.billName = [[array objectAtIndex:i]objectForKey:@"billName"];
                    accountdetialmodel.billNo = [[array objectAtIndex:i]objectForKey:@"billNo"];
                    accountdetialmodel.billType = [[array objectAtIndex:i]objectForKey:@"billType"];
                    accountdetialmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    accountdetialmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    accountdetialmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlInName"];
                    accountdetialmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    accountdetialmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    accountdetialmodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                    accountdetialmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    accountdetialmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    accountdetialmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    accountdetialmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    accountdetialmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"lengthIn"];
                    accountdetialmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"widthIn"];
                    accountdetialmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                    accountdetialmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"heightIn"];
                    accountdetialmodel.volumeIn = [[array objectAtIndex:i]objectForKey:@"volumeIn"];
                    accountdetialmodel.weightIn = [[array objectAtIndex:i]objectForKey:@"weightIn"];
                    accountdetialmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    accountdetialmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    accountdetialmodel.whsName = [[array objectAtIndex:i]objectForKey:@"whsName"];
                    accountdetialmodel.abType = [[array objectAtIndex:i]objectForKey:@"abType"];
                    accountdetialmodel.whsInName = [[array objectAtIndex:i]objectForKey:@"whsInName"];
                    accountdetialmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    accountdetialmodel.mtlInId = [[[array objectAtIndex:i]objectForKey:@"mtlInId"] integerValue];
                    accountdetialmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    accountdetialmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"] integerValue];
                    accountdetialmodel.whsInId = [[[array objectAtIndex:i]objectForKey:@"whsInId"] integerValue];
                    NSMutableArray * twoArray = [NSMutableArray array];
                    twoArray = [[array objectAtIndex:i]objectForKey:@"billDetailVos"];
                    for (int j = 0; j < twoArray.count; j++) {
                        RSAccountDetailModel * accountdetialmodel1 = [[RSAccountDetailModel alloc]init];
                        accountdetialmodel1.mtlId = [[[twoArray objectAtIndex:j]objectForKey:@"mtlId"] integerValue];
                        accountdetialmodel1.mtltypeId = [[[twoArray objectAtIndex:j]objectForKey:@"mtltypeId"] integerValue];
                        accountdetialmodel1.qty  = [[[twoArray objectAtIndex:j]objectForKey:@"qty"] integerValue];
                        accountdetialmodel1.storeareaId = [[[twoArray objectAtIndex:j]objectForKey:@"storeareaId"] integerValue];
                        accountdetialmodel1.whsId = [[[twoArray objectAtIndex:j]objectForKey:@"whsId"] integerValue];
                        accountdetialmodel1.billid = [[[twoArray objectAtIndex:j]objectForKey:@"billid"] integerValue];
                        accountdetialmodel1.did = [[[twoArray objectAtIndex:j]objectForKey:@"did"] integerValue];
                        accountdetialmodel1.mtlName = [[twoArray objectAtIndex:j]objectForKey:@"mtlName"];
                        accountdetialmodel1.mtltypeName = [[twoArray objectAtIndex:j]objectForKey:@"mtltypeName"];
                        accountdetialmodel1.blockNo = [[twoArray objectAtIndex:j]objectForKey:@"blockNo"];
                        accountdetialmodel1.length = [[twoArray objectAtIndex:j]objectForKey:@"length"];
                        accountdetialmodel1.width = [[twoArray objectAtIndex:j]objectForKey:@"width"];
                        accountdetialmodel1.height = [[twoArray objectAtIndex:j]objectForKey:@"height"];
                        accountdetialmodel1.volume = [[twoArray objectAtIndex:j]objectForKey:@"volume"];
                        accountdetialmodel1.weight = [[twoArray objectAtIndex:j]objectForKey:@"weight"];
                        accountdetialmodel1.storageType = [[twoArray objectAtIndex:j]objectForKey:@"storageType"];
                        accountdetialmodel1.receiptDate = [[twoArray objectAtIndex:j]objectForKey:@"receiptDate"];
                        accountdetialmodel1.whsName = [[twoArray objectAtIndex:j]objectForKey:@"whsName"];
                        accountdetialmodel1.abType = [[twoArray objectAtIndex:j]objectForKey:@"abType"];
                        accountdetialmodel1.whsInName = [[twoArray objectAtIndex:j]objectForKey:@"whsInName"];
                        [accountdetialmodel.billDetailVos addObject:accountdetialmodel1];
                    }
                    [tempArray addObject:accountdetialmodel];
                }
                [self.tableview reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
    return tempArray;
}






- (void)openMemberView:(UIButton *)bottomBtn{
    bottomBtn.selected = !bottomBtn.selected;
    self.btnType = @"change";
    RSBalanceModel * balancemodel = self.runArray[bottomBtn.tag];
    RSRunningAccountCloseCell * cell = (RSRunningAccountCloseCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:bottomBtn.tag inSection:0]];
    if (bottomBtn.selected) {
        balancemodel.isbool = true;
        balancemodel.contentArr = [self openReloadNewData:balancemodel];
       // cell.accountOpenImageView.transform = CGAffineTransformRotate(cell.accountOpenImageView.transform, M_PI);
        cell.accountOpenImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }else{
        balancemodel.isbool = false;
        [balancemodel.contentArr removeAllObjects];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             cell.accountOpenImageView.transform = CGAffineTransformIdentity;
//        cell.accountOpenImageView.transform = CGAffineTransformRotate(cell.accountOpenImageView.transform, -M_PI);
        [self.tableview reloadData];
        });
    }
}



/**
 卡片上按钮的点击事件
 
 @param baseCell 点击的cell
 @param btnType 按钮的状态
 @param index 点的是哪一个按钮
 */
//- (void)baseCell:(RSRunningAccountBaseCell *)baseCell btnType:(BtnType)btnType WithIndex:(int)index withArr:(nonnull NSMutableArray *)array{
//    self.isOpen = btnType;
//    self.cellIndex = index;
//    self.StatusArray = array;
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
//    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
//}

- (NSString *)showCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

- (NSString *)showDisplayTheTime:(NSString *)time{
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [dateFormatter dateFromString:time];
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    return currentDateString;
}


@end
