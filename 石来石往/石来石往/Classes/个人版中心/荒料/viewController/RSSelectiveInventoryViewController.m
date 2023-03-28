//
//  RSSelectiveInventoryViewController.m
//  石来石往
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSSelectiveInventoryViewController.h"

#import "RSSalertView.h"
#import "RSSelectiveInventoryCell.h"
#import "RSSelectiveInventoryModel.h"
#import "RSWarehouseModel.h"
#import "RSStoragemanagementModel.h"

@interface RSSelectiveInventoryViewController ()<RSSalertViewDelegate>

@property (nonatomic,strong)NSMutableDictionary * blockDict;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)RSSalertView * alertView;


@property (nonatomic,strong)NSMutableArray * cancelArray;

@end

@implementation RSSelectiveInventoryViewController

- (NSMutableDictionary *)blockDict{
    if (!_blockDict) {
        _blockDict = [NSMutableDictionary dictionary];
    }
    return _blockDict;
}


- (NSMutableArray *)cancelArray{
    if (!_cancelArray) {
        _cancelArray = [NSMutableArray array];
    }
    return _cancelArray;
}


- (RSSalertView *)alertView
{
    if (!_alertView) {
        self.alertView = [[RSSalertView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 175.5, SCW - 66 , 351)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.delegate = self;
        self.alertView.layer.cornerRadius = 15;
    }
    return _alertView;
}

- (NSMutableArray *)selectionArray{
    if (!_selectionArray) {
        _selectionArray = [NSMutableArray array];
    }
    return _selectionArray;
}

- (NSMutableArray *)selectiveArray{
    if (!_selectiveArray) {
        _selectiveArray = [NSMutableArray array];
    }
    return _selectiveArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

static NSString * SELECTIVECELLID = @"SELECTIVECELLID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 2;
    [self.blockDict setObject:@"2019-01-01" forKey:@"dateFrom"];
    [self.blockDict setObject:self.dateTo forKey:@"dateTo"];
    [self.blockDict setObject:@"" forKey:@"mtlName"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"mtlId"];
    [self.blockDict setObject:@"" forKey:@"blockNo"];
    if ([self.selectFunctionType isEqualToString:@"异常处理"]) {
        [self.blockDict setObject:@"" forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
    }else if ([self.selectFunctionType isEqualToString:@"调拨"]){
        //调出
        [self.blockDict setObject:self.whsName forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:self.whsIn] forKey:@"whsId"];
    }else{
        [self.blockDict setObject:self.warehousemodel.name forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:self.warehousemodel.WareHouseID] forKey:@"whsId"];
    }
    [self.blockDict setObject:@"1" forKey:@"pageNum"];
    [self.blockDict setObject:@"5" forKey:@"pageSize"];
    [self selectiveNewData];
    UIButton * screenBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    [screenBtn addTarget:self action:@selector(selectviewInvertoryViewAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;
   // [self.view addSubview:self.tableview];
    //huangliaochuku荒料出库
    self.title = self.selectFunctionType;
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableview.estimatedRowHeight = 0;
        self.tableview.estimatedSectionFooterHeight = 0;
        self.tableview.estimatedSectionHeaderHeight = 0;
    }
    [self.tableview registerClass:[RSSelectiveInventoryCell class] forCellReuseIdentifier:SELECTIVECELLID];
    [self setUIBottomView];
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf newSelectiveInventNewData];
    }];
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf selectiveNewMoreData];
    }];
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
        [weakSelf newSelectiveInventNewData];
    }];
}

- (void)newSelectiveInventNewData{
    self.pageNum = 2;
    [self.blockDict setObject:@"2019-01-01" forKey:@"dateFrom"];
    [self.blockDict setObject:self.dateTo forKey:@"dateTo"];
    [self.blockDict setObject:@"" forKey:@"mtlName"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"mtlId"];
    [self.blockDict setObject:@"" forKey:@"blockNo"];
    if ([self.selectFunctionType isEqualToString:@"异常处理"]) {
        [self.blockDict setObject:@"" forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
    }else if ([self.selectFunctionType isEqualToString:@"调拨"]){
        //调出
        [self.blockDict setObject:self.whsName forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:self.whsIn] forKey:@"whsId"];
    }else{
        [self.blockDict setObject:self.warehousemodel.name forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:self.warehousemodel.WareHouseID] forKey:@"whsId"];
    }
//    [self.blockDict setObject:self.warehousemodel.name forKey:@"whsName"];
//    [self.blockDict setObject:[NSNumber numberWithInteger:self.warehousemodel.WareHouseID] forKey:@"whsId"];
    [self.blockDict setObject:@"1" forKey:@"pageNum"];
    [self.blockDict setObject:@"5" forKey:@"pageSize"];
    [self selectiveNewData];
}

- (void)selectiveNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"DETAIL" forKey:@"type"];
    [phoneDict setObject:self.blockDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BLBALANCE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.selectiveArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                   // RSSelectiveInventoryModel  * selectiveinventorymodel = [[RSSelectiveInventoryModel alloc]init];
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"]integerValue];
                    storagemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                    storagemanagementmodel.isfrozen = [[[array objectAtIndex:i]objectForKey:@"isfrozen"]integerValue];
                    storagemanagementmodel.pwmsUserId = [[[array objectAtIndex:i]objectForKey:@"pwmsUserId"]integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"]integerValue];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                     storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    storagemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                     storagemanagementmodel.whsName = [[array objectAtIndex:i]objectForKey:@"whsName"];
                     storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                     storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                     storagemanagementmodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                     storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                     storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                     storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    storagemanagementmodel.selectedStutas = 0;
                    if ([weakSelf.selectFunctionType isEqualToString:@"异常处理"]) {
                         storagemanagementmodel.blockInNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                        storagemanagementmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                        storagemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                        storagemanagementmodel.mtlInId =  [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                        storagemanagementmodel.mtltypeInId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"]integerValue];
                        storagemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"length"];
                        storagemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"width"];
                        storagemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"height"];
                        storagemanagementmodel.volumeIn = [[array objectAtIndex:i]objectForKey:@"volume"];
                        storagemanagementmodel.weightIn = [[array objectAtIndex:i]objectForKey:@"weight"];
                    }
                    [weakSelf.selectiveArray addObject:storagemanagementmodel];
                }
                self.pageNum = 2;
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview reloadData];
            }else{
                
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
             [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)selectiveNewMoreData{
    [self.blockDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"DETAIL" forKey:@"type"];
    [phoneDict setObject:self.blockDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BLBALANCE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableArray * array = [NSMutableArray array];
                NSMutableArray * tempArray = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"]integerValue];
                    storagemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                    storagemanagementmodel.isfrozen = [[[array objectAtIndex:i]objectForKey:@"isfrozen"]integerValue];
                    storagemanagementmodel.pwmsUserId = [[[array objectAtIndex:i]objectForKey:@"pwmsUserId"]integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"]integerValue];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    storagemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"]integerValue];
                    storagemanagementmodel.whsName = [[array objectAtIndex:i]objectForKey:@"whsName"];
                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    storagemanagementmodel.selectedStutas = 0;
                    if ([weakSelf.selectFunctionType isEqualToString:@"异常处理"]) {
                         storagemanagementmodel.blockInNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                        storagemanagementmodel.mtlInName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                        storagemanagementmodel.mtltypeInName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                        storagemanagementmodel.mtlInId =  [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                        storagemanagementmodel.mtltypeInId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"]integerValue];
                        storagemanagementmodel.lengthIn = [[array objectAtIndex:i]objectForKey:@"length"];
                        storagemanagementmodel.widthIn = [[array objectAtIndex:i]objectForKey:@"width"];
                        storagemanagementmodel.heightIn = [[array objectAtIndex:i]objectForKey:@"height"];
                        storagemanagementmodel.volumeIn = [[array objectAtIndex:i]objectForKey:@"volume"];
                        storagemanagementmodel.weightIn = [[array objectAtIndex:i]objectForKey:@"weight"];
                    }
                    [tempArray addObject:storagemanagementmodel];
                }
                [weakSelf.selectiveArray addObjectsFromArray:tempArray];
                self.pageNum++;
              
                [weakSelf.tableview.mj_footer endRefreshing];
                [weakSelf.tableview reloadData];
            }else{
                
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}

//筛选
- (void)selectviewInvertoryViewAction:(UIButton *)screenBtn{
    if ([self.selectFunctionType isEqualToString:@"异常处理"]) {
        self.alertView.wareHouseTypeName = @"请选择仓库";
        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
        NSMutableArray * warehouseArray = [db getAllContent:@"BL"];
        self.alertView.typeArray = warehouseArray;
        self.alertView.selectFunctionType = @"荒料库存筛选";
        self.alertView.index = 0;
    }else if ([self.selectFunctionType isEqualToString:@"调拨"]){
        //调出
        self.alertView.selectFunctionType = @"库存筛选";
        self.alertView.wareHouseTypeName = self.whsName;
//        if ([self.whstype isEqualToString:@"BL"]) {
//            self.alertView.wareHouseTypeName = @"荒料仓";
//        }else{
//            self.alertView.wareHouseTypeName = @"大板仓";
//        }
    }else{
        self.alertView.selectFunctionType = @"库存筛选";
        self.alertView.wareHouseTypeName = self.warehousemodel.name;
//        if ([self.warehousemodel.whstype isEqualToString:@"BL"]) {
//            self.alertView.wareHouseTypeName = @"荒料仓";
//        }else{
//            self.alertView.wareHouseTypeName = @"大板仓";
//        }
    }
    [self.alertView showView];
}


//荒料异常处理的代理
- (void)abnormalFunctionWithWarehouseName:(NSString *)wareHouseName andIndex:(NSInteger)index andName:(NSString *)name andBlockNo:(NSString *)blockNo{
    if ([wareHouseName isEqualToString:@"请选择仓库"]) {
        [self.blockDict setObject:@"" forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
    }else{
        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
        NSMutableArray * warehouseArray = [db getAllContent:@"BL"];
        RSWarehouseModel * warehousemodel = warehouseArray[index];
        [self.blockDict setObject:warehousemodel.name forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID] forKey:@"whsId"];
    }
    [self.blockDict setObject:blockNo forKey:@"blockNo"];
    [self.blockDict setObject:name forKey:@"mtlName"];
    [self selectiveNewData];
}




- (void)blockFunctionWithWareHouseName:(NSString *)wareHouseName andName:(NSString *)name andBlockNo:(NSString *)blockNo{
    if ([self.selectFunctionType isEqualToString:@"调拨"]) {
        [self.blockDict setObject:self.whsName forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:self.whsIn] forKey:@"whsId"];
    }else{
        [self.blockDict setObject:self.warehousemodel.name forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:self.warehousemodel.WareHouseID] forKey:@"whsId"];
    }
    [self.blockDict setObject:blockNo forKey:@"blockNo"];
    [self.blockDict setObject:name forKey:@"mtlName"];
    [self selectiveNewData];
}



//- (void)blockFunctionWithWareHouseName:(NSString *)wareHouseName andIndex:(NSInteger)index andName:(NSString *)name andBlockNo:(NSString *)blockNo{
//    if ([wareHouseName isEqualToString:@"请选择仓库"]) {
//        [self.blockDict setObject:@"" forKey:@"whsName"];
//        [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
//    }else{
//        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
//        NSMutableArray * warehouseArray = [db getAllContent:@"BL"];
//        RSWarehouseModel * warehousemodel = warehouseArray[index];
//        [self.blockDict setObject:warehousemodel.name forKey:@"whsName"];
//        [self.blockDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID] forKey:@"whsId"];
//    }
//    [self.blockDict setObject:blockNo forKey:@"blockNo"];
//    [self.blockDict setObject:name forKey:@"mtlName"];
//    [self selectiveNewData];
//}





- (void)setUIBottomView{
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn addTarget:self action:@selector(sureSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectiveArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 194;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     //self.cell = [tableView dequeueReusableCellWithIdentifier:SELECTIVECELLID];
    RSStoragemanagementModel * storagemanagementmodel = self.selectiveArray[indexPath.row];
    
    RSSelectiveInventoryCell * cell = [tableView dequeueReusableCellWithIdentifier:SELECTIVECELLID];
    
    if (storagemanagementmodel.isfrozen) {
        cell.selectBtn.hidden = YES;
        cell.isfrozenLabel.hidden = NO;
        cell.selectBtn.enabled = NO;
    }else{
        cell.isfrozenLabel.hidden = YES;
        cell.selectBtn.hidden = NO;
        cell.selectBtn.enabled = YES;
    }
    cell.selectiveLabel.text = storagemanagementmodel.blockNo;
    cell.selectDetailNameLabel.text = storagemanagementmodel.mtlName;
    cell.selectDetailTypeLabel.text = storagemanagementmodel.mtltypeName;
    cell.selectDetailShapeLabel.text = [NSString stringWithFormat:@"%0.1lf|%0.1lf|%0.1lf",[storagemanagementmodel.length doubleValue],[storagemanagementmodel.width doubleValue],[storagemanagementmodel.height doubleValue]];
    cell.selectDetailAreaLabel.text = [NSString stringWithFormat:@"%0.3lf",[storagemanagementmodel.volume doubleValue]];
    cell.selectDetailWightLabel.text = [NSString stringWithFormat:@"%0.3lf",[storagemanagementmodel.weight doubleValue]];
    cell.selectBtn.tag = indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(selectiveChoiceAction:) forControlEvents:UIControlEventTouchUpInside];
//    if (self.selectionArray.count > 0) {
//        //当再次选择搜索的时候
////        for (int j = 0; j < self.selectionArray.count; j++) {
////           RSStoragemanagementModel * storagemanagementmodel1 = self.selectionArray[j];
////           if (storagemanagementmodel1.did == storagemanagementmodel.did) {
////               cell.selectBtn.selected = YES;
////               storagemanagementmodel.selectedStutas = YES;
////
////               break;
////          }else{
////            storagemanagementmodel.selectedStutas = NO;
////            cell.selectBtn.selected = false;
////          }
////        }
//    }else{
    
//    if (storagemanagementmodel.selectedStutas == true) {
//        cell.selectBtn.selected = true;
//    }else{
//        cell.selectBtn.selected = false;
//    }
    //    }
    if (self.selectionArray.count > 0) {
         for (int i = 0; i < self.selectionArray.count; i++) {
         RSStoragemanagementModel * storagemanagementmodel1 = self.selectionArray[i];
            if (storagemanagementmodel1.did == storagemanagementmodel.did) {
                cell.selectBtn.selected = YES;
                break;
            }else{
                cell.selectBtn.selected = false;
            }
        }
    }
    else{
        cell.selectBtn.selected = false;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)selectiveChoiceAction:(UIButton *)selectBtn{
    selectBtn.selected = !selectBtn.selected;
    if (selectBtn.selected) {
//        if (self.selectionArray.count < 1) {
        RSStoragemanagementModel * storagemanagementmodel = self.selectiveArray[selectBtn.tag];
        [self.selectionArray addObject:storagemanagementmodel];
//        }else{
//            for (int i = 0; i < self.selectionArray.count; i++) {
//                RSStoragemanagementModel * storagemanagementmodel = self.selectiveArray[selectBtn.tag];
//                RSStoragemanagementModel * storagemanagementmodel1 = self.selectionArray[i];
//                if (storagemanagementmodel1.did != storagemanagementmodel.did) {
//                 [self.selectionArray addObject:storagemanagementmodel];
//                }
//            }
//        }
    }else{
        RSStoragemanagementModel * storagemanagementmodel = self.selectiveArray[selectBtn.tag];
        for (int i = 0; i < self.selectionArray.count; i++) {
            RSStoragemanagementModel * storagemanagementmodel1 = self.selectionArray[i];
            if (storagemanagementmodel1.did == storagemanagementmodel.did) {
                [self.selectionArray removeObjectAtIndex:i];
                [self.cancelArray addObject:@(storagemanagementmodel.did)];
        }
     }
  }
}


    
//确定
- (void)sureSelectAction:(UIButton *)sureBtn{
    //[self.selectionArray removeAllObjects];
//    for (int i = 0 ; i < self.selectiveArray.count; i++) {
//         RSStoragemanagementModel * storagemanagementmodel = self.selectiveArray[i];
//        if (storagemanagementmodel.selectedStutas == true) {
//            storagemanagementmodel.selectedStutas = YES;
//            [self.selectionArray addObject:storagemanagementmodel];
//        }else{
//            RSStoragemanagementModel * storagemanagementmodel = self.selectiveArray[i];
//            storagemanagementmodel.selectedStutas = NO;
//        }
//    }
    if (self.selectionArray.count > 0) {
        if ([self.delegate respondsToSelector:@selector(selectContentArray:andCancelArray:)]) {
            [self.delegate selectContentArray:self.selectionArray andCancelArray:self.cancelArray];
        }
//        if (self.selectTwo) {
//            self.selectTwo(self.selectType, self.selectFunctionType, self.selectionArray);
//        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请选择你要的内容"];
    }
    
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
