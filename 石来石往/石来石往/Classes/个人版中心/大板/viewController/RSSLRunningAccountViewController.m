//
//  RSSLRunningAccountViewController.m
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLRunningAccountViewController.h"
#import "RSRunningAccountCloseCell.h"
#import "RSReportFormView.h"
#import "RSReportFormMenuView.h"
#import "RSWarehouseModel.h"
#import "RSSLRunningCell.h"
#import "RSSLRunningModel.h"
#import "RSSLRunningDetialViewController.h"

@interface RSSLRunningAccountViewController ()
{
  UIView * _centerView;
}

@property (nonatomic,strong)NSMutableDictionary * blockDict;

@property (nonatomic,assign)NSInteger pageNum;

//有多少cell没有展开的数组
@property (nonatomic,strong)NSMutableArray * runArray;


@property (nonatomic ,strong)RSReportFormMenuView * menu;

@property (nonatomic,strong)NSString * btnType;
@end

@implementation RSSLRunningAccountViewController
- (NSMutableDictionary *)blockDict{
    if (!_blockDict) {
        _blockDict = [NSMutableDictionary dictionary];
    }
    return _blockDict;
}


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
    [self.blockDict setObject:@"" forKey:@"turnsNo"];
    [self.blockDict setObject:@"" forKey:@"slNo"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
    [self.blockDict setObject:[NSNumber numberWithInteger:-1] forKey:@"isFrozen"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0]  forKey:@"widthType"];
    [self.blockDict setObject:@"" forKey:@"length"];
    [self.blockDict setObject:@"" forKey:@"width"];
    [self.blockDict setObject:@"1" forKey:@"pageNum"];
    [self.blockDict setObject:@"10" forKey:@"pageSize"];
    
    
    RSWeakself
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
    RSReportFormView * reportformView = [[RSReportFormView alloc]initWithFrame:CGRectMake(91, 0, [UIScreen mainScreen].bounds.size.width - 91, [UIScreen mainScreen].bounds.size.height)];
    reportformView.longIndex = 0;
    reportformView.withIndex = 0;
    reportformView.wareHouseIndex = 0;
    reportformView.frozenviewIndex = 0;
    reportformView.inSelect = @"1";
    reportformView.selectFunctionType = self.selectFunctionType;
    __weak typeof(reportformView) weakReportformview = reportformView;
    reportformView.reportformSLSelect = ^(NSString * _Nonnull inSelect, NSString * _Nonnull beginTime, NSString * _Nonnull endTime, NSString * _Nonnull wuliaoTextView, NSString * _Nonnull blockTextView, NSString * _Nonnull longTypeView, NSInteger longIndex, NSString * _Nonnull longTextView, NSString * _Nonnull withTypeView, NSInteger withIndex, NSString * _Nonnull withTextView, NSString * _Nonnull luTypeView, NSString * _Nonnull wareHouseView, NSInteger wareHouseIndex, NSString * _Nonnull frozenView, NSInteger frozenviewIndex, NSString * _Nonnull turnNoStr, NSString * _Nonnull slNoStr) {
        [weakSelf.blockDict setObject:[weakSelf showDisplayTheTime:beginTime] forKey:@"dateFrom"];
        [weakSelf.blockDict setObject:[weakSelf showDisplayTheTime:endTime] forKey:@"dateTo"];
        [weakSelf.blockDict setObject:wuliaoTextView forKey:@"mtlName"];
        [weakSelf.blockDict setObject:blockTextView forKey:@"blockNo"];
        
        
        
        
        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
        NSMutableArray * warehouseArray = [db getAllContent:@"SL"];
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
//            weakReportformview.wareHouseIndex = 0;
//        }else{
//            RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
//            NSMutableArray * warehouseArray = [db getAllContent:@"SL"];
//            weakReportformview.wareHouseIndex =  wareHouseIndex;
//            RSWarehouseModel * warehousemodel = warehouseArray[wareHouseIndex-1];
//
//            [weakSelf.blockDict setObject:warehousemodel.name forKey:@"whsName"];
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID] forKey:@"whsId"];
//        }
        
        
        
        
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
        
        
        
        if ([turnNoStr isEqualToString:@""]) {
            
            [self.blockDict setObject:@"" forKey:@"turnsNo"];
        }else{
            [self.blockDict setObject:turnNoStr forKey:@"turnsNo"];
        }
        
        if ([slNoStr isEqualToString:@""]) {
            
            [self.blockDict setObject:@"" forKey:@"slNo"];
        }else{
            [self.blockDict setObject:slNoStr forKey:@"slNo"];
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
  return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIdentifier = [NSString stringWithFormat:@"RUNACCOUNT%ld",(long)indexPath.row];
    RSSLRunningCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[RSSLRunningCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.runningBtn.tag = indexPath.row;
    RSSLRunningModel * slrunningmodel = self.runArray[indexPath.row];
    cell.runningNameLabel.text = slrunningmodel.mtlName;
    cell.turnNameLabel.text = slrunningmodel.turnsNo;
    cell.blockNameLabel.text = slrunningmodel.blockNo;
    [cell.runningBtn addTarget:self action:@selector(jumpPIECEAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)jumpPIECEAction:(UIButton *)runningBtn{
    RSSLRunningModel * slrunningmodel = self.runArray[runningBtn.tag];
    RSSLRunningDetialViewController * slRunningDetailVc = [[RSSLRunningDetialViewController alloc]init];
    slRunningDetailVc.usermodel = self.usermodel;
    slRunningDetailVc.title = @"流水账详情";
    slRunningDetailVc.selectFunctionType = self.selectFunctionType;
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    /**
     [self.blockDict setObject:[NSNumber numberWithInteger:-1] forKey:@"isFrozen"];
     */
    [dict setObject:[self.blockDict objectForKey:@"dateFrom"] forKey:@"dateFrom"];
    [dict setObject:[self.blockDict objectForKey:@"dateTo"] forKey:@"dateTo"];
    [dict setObject:[self.blockDict objectForKey:@"isFrozen"] forKey:@"isFrozen"];
    [dict setObject:slrunningmodel.blockNo forKey:@"blockNo"];
    [dict setObject:slrunningmodel.mtlName forKey:@"mtlName"];
    [dict setObject:[NSNumber numberWithInteger:slrunningmodel.mtlId] forKey:@"mtlId"];
    [dict setObject:slrunningmodel.turnsNo forKey:@"turnsNo"];
    [dict setObject:[self.blockDict objectForKey:@"slNo"] forKey:@"slNo"];
    [dict setObject:[self.blockDict objectForKey:@"whsId"] forKey:@"whsId"];
    [dict setObject:[self.blockDict objectForKey:@"whsName"] forKey:@"whsName"];
    [dict setObject:[self.blockDict objectForKey:@"storageType"] forKey:@"storageType"];
    [dict setObject:[self.blockDict objectForKey:@"lengthType"] forKey:@"lengthType"];
    [dict setObject:[self.blockDict objectForKey:@"widthType"] forKey:@"widthType"];
    [dict setObject:[self.blockDict objectForKey:@"length"] forKey:@"length"];
    [dict setObject:[self.blockDict objectForKey:@"width"] forKey:@"width"];
    [dict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [dict setObject:[self.blockDict objectForKey:@"pageSize"] forKey:@"pageSize"];
    slRunningDetailVc.blockDict = dict;
    [self.navigationController pushViewController:slRunningDetailVc animated:YES];
}




- (void)runningReloadNewData{
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
    [network getDataWithUrlString:URL_SLFLOWACCOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.runArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSSLRunningModel * balancemodel = [[RSSLRunningModel alloc]init];
                    balancemodel.mtlId =  [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    balancemodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    //荒料流水账
                    balancemodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    balancemodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    //balancemodel.billCount = [[[array objectAtIndex:i]objectForKey:@"billCount"] integerValue];
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
    [network getDataWithUrlString:URL_SLFLOWACCOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                NSMutableArray * tempArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    RSSLRunningModel * balancemodel = [[RSSLRunningModel alloc]init];
                    balancemodel.mtlId =  [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    balancemodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    //荒料流水账
                    balancemodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    balancemodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    //balancemodel.billCount = [[[array objectAtIndex:i]objectForKey:@"billCount"] integerValue];
                    [tempArray addObject:balancemodel];
                }
                [weakSelf.runArray addObjectsFromArray:tempArray];
                if (weakSelf.runArray.count > 0) {
                    _centerView.hidden = YES;
                }else{
                    _centerView.hidden = NO;
                }
                weakSelf.pageNum++;
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

- (NSString *)Tw0showDisplayTheTime:(NSString *)time{
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate * date = [dateFormatter dateFromString:time];
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    return currentDateString;
}


@end
