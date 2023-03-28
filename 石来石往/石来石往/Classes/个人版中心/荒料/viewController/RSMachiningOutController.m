//
//  RSMachiningOutController.m
//  石来石往
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSMachiningOutController.h"
#import "RSMachiningCell.h"
#import "FloatViewController.h"
//#import "RSReportFormView.h"

#import "RSReportFormMenuView.h"
#import "RSFactoryFromMenuView.h"
#import "RSMachiningOutModel.h"

@interface RSMachiningOutController ()

@property (nonatomic,strong)NSMutableDictionary * blockDict;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)RSReportFormMenuView * menu;

@property (nonatomic,strong)NSMutableArray * machingArray;

@end

@implementation RSMachiningOutController
- (NSMutableArray *)machingArray{
    if (!_machingArray) {
        _machingArray = [NSMutableArray array];
    }
    return _machingArray;
}

- (NSMutableDictionary *)blockDict{
    if (!_blockDict) {
        _blockDict = [NSMutableDictionary dictionary];
    }
    return _blockDict;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加工跟单";
    self.pageNum = 2;
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    UIButton * blockBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [blockBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [blockBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    blockBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:blockBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    [blockBtn addTarget:self action:@selector(machiningAction:) forControlEvents:UIControlEventTouchUpInside];
    
    RSFactoryFromMenuView * reportformView = [[RSFactoryFromMenuView alloc]initWithFrame:CGRectMake(91, 0, [UIScreen mainScreen].bounds.size.width - 91, [UIScreen mainScreen].bounds.size.height)];
    reportformView.menuType = @"1";
    
    
    RSReportFormMenuView *menu = [RSReportFormMenuView MenuViewWithDependencyView:self.view MenuView:reportformView isShowCoverView:YES];
    self.menu = menu;
    
    
    [self.blockDict setObject:@"2019-01-01" forKey:@"dateFrom"];
    [self.blockDict setObject:[self showCurrentTime] forKey:@"dateTo"];
    [self.blockDict setObject:[NSNumber numberWithInteger:-1] forKey:@"factoryId"];
    [self.blockDict setObject:@"" forKey:@"mtlName"];
    [self.blockDict setObject:@"" forKey:@"blockNo"];
    [self.blockDict setObject:@"" forKey:@"whsName"];
    [self.blockDict setObject:@"1" forKey:@"pageNum"];
    [self.blockDict setObject:@"10" forKey:@"pageSize"];
     RSWeakself
     __weak typeof(reportformView) weakReportformview = reportformView;
    reportformView.showSelectMenu = ^(NSString * _Nonnull selectyType, NSString * _Nonnull beginTime, NSString * _Nonnull endTime, NSString * _Nonnull wuliaoTextView, NSString * _Nonnull blockTextView, NSString * _Nonnull wareHouseView, NSInteger wareHouseIndex, NSString * _Nonnull factoryView, NSInteger factoryIndex) {
        
        weakReportformview.wareHouseIndex = wareHouseIndex;
        weakReportformview.factoryIndex = factoryIndex;
        
        
        
        [weakSelf.blockDict setObject:[weakSelf showDisplayTheTime:beginTime] forKey:@"dateFrom"];
        [weakSelf.blockDict setObject:[weakSelf showDisplayTheTime:endTime] forKey:@"dateTo"];
        
        [weakSelf.blockDict setObject:wuliaoTextView forKey:@"mtlName"];
        [weakSelf.blockDict setObject:blockTextView forKey:@"blockNo"];
        
        
        
        
//        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
//        NSMutableArray * warehouseArray = [db getAllContent:@"BL"];
//        RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
//        warehousemodel.code = @"";
//        warehousemodel.createTime = @"";
//        warehousemodel.name = @"请选出所在仓库";
//        warehousemodel.updateTime = @"";
//        warehousemodel.whstype = @"";
//        warehousemodel.createUser = 0;
//        warehousemodel.pwmsUserId = 0;
//        warehousemodel.status = 0;
//        warehousemodel.updateUser = 0;
//        warehousemodel.WareHouseID = 0;
//        [warehouseArray insertObject:warehousemodel atIndex:0];
//        RSWarehouseModel * warehousemodel1 = warehouseArray[wareHouseIndex];
//        if ([warehousemodel1.name isEqualToString:@"请选出所在仓库"]) {
//            //请选出所在仓库
//            [weakSelf.blockDict setObject:@"" forKey:@"whsName"];
//        }else{
//            [weakSelf.blockDict setObject:warehousemodel1.name forKey:@"whsName"];
//        }
        
        RSPersonlPublishDB * db1 = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Factory.sqlite"];
        NSMutableArray * factoryArray = [db1 getAllContent];
        RSWarehouseModel * warehousemodel2 = [[RSWarehouseModel alloc]init];
        warehousemodel2.code = @"";
        warehousemodel2.createTime = @"";
        warehousemodel2.name = @"请选出所在加工厂";
        warehousemodel2.updateTime = @"";
        warehousemodel2.whstype = @"";
        warehousemodel2.createUser = 0;
        warehousemodel2.pwmsUserId = 0;
        warehousemodel2.status = 0;
        warehousemodel2.updateUser = 0;
        warehousemodel2.WareHouseID = 0;
        [factoryArray insertObject:warehousemodel2 atIndex:0];
        RSWarehouseModel * warehousemodel3 = factoryArray[factoryIndex];
        if ([warehousemodel3.name isEqualToString:@"请选出所在加工厂"]) {
            //请选出所在仓库
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:-1] forKey:@"factoryId"];
        }else{
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:warehousemodel3.WareHouseID] forKey:@"factoryId"];
        }
        
        [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [weakSelf reloadMachiningOutNewData];
        [weakSelf.menu hidenWithAnimation];
    };
    [self reloadMachiningOutNewData];
   
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [weakSelf reloadMachiningOutNewData];
    }];
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf reloadMachiningOutNewMoreData];
    }];
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
        [weakSelf reloadMachiningOutNewData];
    }];
    
}

- (void)machiningAction:(UIButton *)blockBtn{
    [self.menu show];
}



- (void)reloadMachiningOutNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.blockDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETPROCESSBLOCKLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.machingArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSMachiningOutModel * balancemodel = [[RSMachiningOutModel alloc]init];
                    balancemodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    balancemodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    balancemodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    balancemodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    balancemodel.factoryName = [[array objectAtIndex:i]objectForKey:@"factoryName"];
                    balancemodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                    balancemodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    balancemodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    balancemodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    balancemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    balancemodel.processName = [[array objectAtIndex:i]objectForKey:@"processName"];
                    balancemodel.processStatus =  [[[array objectAtIndex:i]objectForKey:@"processStatus"] integerValue];
                    [weakSelf.machingArray addObject:balancemodel];
                }
                weakSelf.pageNum = 2;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}


- (void)reloadMachiningOutNewMoreData{
    [self.blockDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.blockDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETPROCESSBLOCKLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                NSMutableArray * tempArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    RSMachiningOutModel * balancemodel = [[RSMachiningOutModel alloc]init];
                    
                    balancemodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    balancemodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    balancemodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    balancemodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    balancemodel.factoryName = [[array objectAtIndex:i]objectForKey:@"factoryName"];
                    balancemodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                    balancemodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    balancemodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    balancemodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    balancemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    balancemodel.processName = [[array objectAtIndex:i]objectForKey:@"processName"];
                    balancemodel.processStatus =  [[[array objectAtIndex:i]objectForKey:@"processStatus"] integerValue];
                    
                    [tempArray addObject:balancemodel];
                }
                [weakSelf.machingArray addObjectsFromArray:tempArray];
                weakSelf.pageNum++;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.machingArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSMachiningOutModel * machiningoutmodel = self.machingArray[indexPath.row];
    if (machiningoutmodel.processStatus == 10) {
        return 107;
    }else{
        return 130;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * MACHININGCELLID = @"MACHININGCELLID";
    RSMachiningCell *cell = [tableView dequeueReusableCellWithIdentifier:MACHININGCELLID];
    if (!cell) {
        cell = [[RSMachiningCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MACHININGCELLID];
    }
    cell.machiningoutmodel = self.machingArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSMachiningOutModel * machiningoutmodel = self.machingArray[indexPath.row];
    FloatViewController * floatVc = [[FloatViewController alloc]init];
    floatVc.billdtlid = machiningoutmodel.billdtlid;
    floatVc.usermodel = self.usermodel;
    floatVc.machiningoutmodel = machiningoutmodel;
    [self.navigationController pushViewController:floatVc animated:YES];
    RSWeakself;
    floatVc.machOutReload = ^{
        [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [weakSelf reloadMachiningOutNewData];
    };
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


- (NSString *)showCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
@end
