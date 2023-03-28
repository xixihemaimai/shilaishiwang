//
//  RSChoosingInventoryViewController.m
//  石来石往
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSChoosingInventoryViewController.h"

#import "RSChoosingInventoryHeaderView.h"
#import "RSChoosingInventoryFootView.h"
#import "RSChoosingInventoryCell.h"

#import "RSSalertView.h"

//模型
#import "RSChoosingInventoryModel.h"
#import "RSChoosingSliceModel.h"

#import "RSSelectDabanSLModel.h"


#import "RSSLStoragemanagementModel.h"

//<UITableViewDelegate,UITableViewDataSource>
@interface RSChoosingInventoryViewController ()<RSSalertViewDelegate>

//@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,strong)NSMutableArray * choosingArray;

@property (nonatomic, strong)NSMutableArray *expendArray;//记录打开的分组

//@property (nonatomic, strong)NSMutableArray *selectArray;//记录选择的所有选项

@property (nonatomic,strong)RSSalertView * alertView;

@property (nonatomic,strong)NSMutableDictionary * blockDict;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * cancelArray;


@end

@implementation RSChoosingInventoryViewController




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

- (NSMutableArray *)choosingArray{
    if (!_choosingArray) {
        _choosingArray = [NSMutableArray array];
    }
    return _choosingArray;
}


- (NSMutableArray *)selectdeContentArray{
    if (!_selectdeContentArray) {
        _selectdeContentArray = [NSMutableArray array];
    }
    return _selectdeContentArray;
}


//- (NSMutableArray *)selectArray {
//    if (!_selectArray) {
//        _selectArray = [NSMutableArray arrayWithCapacity:0];
//    }
//    return _selectArray;
//}


- (NSMutableArray *)cancelArray{
    if (!_cancelArray) {
        _cancelArray = [NSMutableArray array];
    }
    return _cancelArray;
}


- (NSMutableDictionary *)blockDict{
    if (!_blockDict) {
        _blockDict = [NSMutableDictionary dictionary];
    }
    return _blockDict;
}

- (NSMutableArray *)expendArray {
    if (!_expendArray) {
        _expendArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _expendArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

//static NSString * CHOOSINGINVENTORYHEADERVIEW = @"CHOOSINGINVENTORYHEADERVIEW";
//static NSString * CHOOSINGINVENTORYFOOTVIEW = @"CHOOSINGINVENTORYFOOTVIEW";
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//
//    CGFloat H;
//    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
//        H = 88;
//    }else{
//        H = 64;
//    }
//    
//    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, H, SCW, SCH - H) style:UITableViewStyleGrouped];
//    self.tableview.estimatedRowHeight = 0;
//    self.tableview.estimatedSectionFooterHeight = 0;
//    self.tableview.estimatedSectionHeaderHeight = 0;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableview];
//    
//    
    
    
    self.title = self.currentTitle;
    self.pageNum = 2;
    UIButton * screenBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    [screenBtn addTarget:self action:@selector(choosingInvertoryViewAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    
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
    
    
    
    /**
     
     冻结状态    isFrozen    Int    展示全部传-1 传0或者不传 返回未冻结
     传1 返回冻结
     长度筛选类别    lengthType    Int    1 大于 2 等于 3小于 不传或者其他值 不过滤
     宽度筛选类别    widthType    Int    1 大于 2 等于 3小于 不传或者其他值 不过滤
     长度筛选值    length    Decimal    1位小数
     宽度筛选值    width    Decimal    1位小数
     */
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"isFrozen"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"widthType"];
    [self.blockDict setObject:@"0" forKey:@"length"];
    [self.blockDict setObject:@"0" forKey:@"width"];
    [self.blockDict setObject:@"1" forKey:@"pageNum"];
    [self.blockDict setObject:@"10" forKey:@"pageSize"];
    
    
    
    
    [self reloadData];
    [self setUIBottomView];
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //[weakSelf newSelectiveInventNewData];
        [weakSelf.blockDict setObject:@"1" forKey:@"pageNum"];
        [weakSelf reloadData];
    }];
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf reloadNewMoreData];
    }];
    [self.tableview setupEmptyDataText:@"无获取数据" tapBlock:^{
        //[weakSelf reloadData];
    }];
    
    
}

- (void)choosingInvertoryViewAction:(UIButton *)screenBtn{
    
    if ([self.selectFunctionType isEqualToString:@"异常处理"]) {
        self.alertView.wareHouseTypeName = @"请选择仓库";
        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
        NSMutableArray * warehouseArray = [db getAllContent:@"SL"];
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
    
   // self.alertView.selectFunctionType = @"库存筛选";
    [self.alertView showView];
}


//荒料异常处理的代理
- (void)abnormalFunctionWithWarehouseName:(NSString *)wareHouseName andIndex:(NSInteger)index andName:(NSString *)name andBlockNo:(NSString *)blockNo{
    if ([wareHouseName isEqualToString:@"请选择仓库"]) {
        [self.blockDict setObject:@"" forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
    }else{
        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
        NSMutableArray * warehouseArray = [db getAllContent:@"SL"];
        RSWarehouseModel * warehousemodel = warehouseArray[index];
        [self.blockDict setObject:warehousemodel.name forKey:@"whsName"];
        [self.blockDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID] forKey:@"whsId"];
    }
    [self.blockDict setObject:blockNo forKey:@"blockNo"];
    [self.blockDict setObject:name forKey:@"mtlName"];
     [self.blockDict setObject:@"1" forKey:@"pageNum"];
    [self reloadData];
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
    [self.blockDict setObject:@"1" forKey:@"pageNum"];
    [self reloadData];
}



- (void)reloadData{
    //URL_SLBALANACE_IOS
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
    [network getDataWithUrlString:URL_SLBALANACE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.choosingArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                NSMutableArray * tempArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    RSSelectDabanSLModel * selectDabanslmodel = [[RSSelectDabanSLModel alloc]init];
                    selectDabanslmodel.blockNo = [[array objectAtIndex:i] objectForKey:@"blockNo"];
                    selectDabanslmodel.mtlName = [[array objectAtIndex:i] objectForKey:@"mtlName"];
                    selectDabanslmodel.mtltypeName = [[array objectAtIndex:i] objectForKey:@"mtltypeName"];
                    selectDabanslmodel.totalVaQty = [[array objectAtIndex:i] objectForKey:@"totalVaQty"];
                    selectDabanslmodel.turnsNo = [[array objectAtIndex:i] objectForKey:@"turnsNo"];
                    
                    selectDabanslmodel.whsName = [[array objectAtIndex:i] objectForKey:@"whsName"];
                    
                      selectDabanslmodel.totalQty = [[[array objectAtIndex:i] objectForKey:@"totalQty"] integerValue];
                    
                    tempArray = [[array objectAtIndex:i] objectForKey:@"slBalance"];
                    for (int j = 0; j < tempArray.count; j++) {
                        RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                        slstoragemanagementmodel.area = [[tempArray objectAtIndex:j] objectForKey:@"area"];
                        slstoragemanagementmodel.blockNo = [[tempArray objectAtIndex:j] objectForKey:@"blockNo"];
                        slstoragemanagementmodel.dedArea = [[tempArray objectAtIndex:j] objectForKey:@"dedArea"];
                        slstoragemanagementmodel.did = [[[tempArray objectAtIndex:j] objectForKey:@"did"] integerValue];
                        slstoragemanagementmodel.height = [[tempArray objectAtIndex:j] objectForKey:@"height"];
                        slstoragemanagementmodel.isfrozen = [[[tempArray objectAtIndex:j] objectForKey:@"isfrozen"] integerValue];
                        slstoragemanagementmodel.length = [[tempArray objectAtIndex:j] objectForKey:@"length"];
                        slstoragemanagementmodel.mtlId = [[[tempArray objectAtIndex:j] objectForKey:@"mtlId"] integerValue];
                        slstoragemanagementmodel.mtlName = [[tempArray objectAtIndex:j] objectForKey:@"mtlName"];
                        slstoragemanagementmodel.storeareaName = @"";
                        slstoragemanagementmodel.dedLengthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedWidthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedLengthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedWidthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedLengthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        
                        slstoragemanagementmodel.dedWidthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedLengthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedWidthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        
                        slstoragemanagementmodel.mtltypeId = [[[tempArray objectAtIndex:j] objectForKey:@"mtltypeId"] integerValue];
                      slstoragemanagementmodel.mtltypeName = [[tempArray objectAtIndex:j] objectForKey:@"mtltypeName"];
                         slstoragemanagementmodel.preArea = [[tempArray objectAtIndex:j] objectForKey:@"preArea"];
                         slstoragemanagementmodel.qty = [[[tempArray objectAtIndex:j] objectForKey:@"qty"] integerValue];
                         slstoragemanagementmodel.receiptDate = [[tempArray objectAtIndex:j] objectForKey:@"receiptDate"];
                         slstoragemanagementmodel.slNo = [[tempArray objectAtIndex:j] objectForKey:@"slNo"];
                         slstoragemanagementmodel.storageType = [[tempArray objectAtIndex:j] objectForKey:@"storageType"];
                         slstoragemanagementmodel.storeareaId = [[[tempArray objectAtIndex:j] objectForKey:@"storeareaId"] integerValue];
                         slstoragemanagementmodel.turnsNo = [[tempArray objectAtIndex:j] objectForKey:@"turnsNo"];
                         slstoragemanagementmodel.whsId = [[[tempArray objectAtIndex:j] objectForKey:@"whsId"] integerValue];
                         slstoragemanagementmodel.whsName = [[tempArray objectAtIndex:j] objectForKey:@"whsName"];
                        slstoragemanagementmodel.width = [[tempArray objectAtIndex:j] objectForKey:@"width"];
                        slstoragemanagementmodel.isSelect = false;
                        [selectDabanslmodel.contentArray addObject:slstoragemanagementmodel];
                    }
                    [weakSelf.choosingArray addObject:selectDabanslmodel];
                }
                weakSelf.pageNum = 2;
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
//            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [self.navigationController popViewControllerAnimated:YES];
//            }];
//            [alertView addAction:alert];
//            [self presentViewController:alertView animated:YES completion:nil];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)reloadNewMoreData{
    //URL_SLBALANACE_IOS
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
    [network getDataWithUrlString:URL_SLBALANACE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                NSMutableArray * tempArray = [NSMutableArray array];
                NSMutableArray * contentArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    RSSelectDabanSLModel * selectDabanslmodel = [[RSSelectDabanSLModel alloc]init];
                    selectDabanslmodel.blockNo = [[array objectAtIndex:i] objectForKey:@"blockNo"];
                    selectDabanslmodel.mtlName = [[array objectAtIndex:i] objectForKey:@"mtlName"];
                    selectDabanslmodel.mtltypeName = [[array objectAtIndex:i] objectForKey:@"mtltypeName"];
                    selectDabanslmodel.totalVaQty = [[array objectAtIndex:i] objectForKey:@"totalVaQty"];
                    selectDabanslmodel.turnsNo = [[array objectAtIndex:i] objectForKey:@"turnsNo"];
                    
                    selectDabanslmodel.whsName = [[array objectAtIndex:i] objectForKey:@"whsName"];
                    
                    selectDabanslmodel.totalQty = [[[array objectAtIndex:i] objectForKey:@"totalQty"] integerValue];
                    
                    tempArray = [[array objectAtIndex:i] objectForKey:@"slBalance"];
                    for (int j = 0; j < tempArray.count; j++) {
                        RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                        slstoragemanagementmodel.area = [[tempArray objectAtIndex:j] objectForKey:@"area"];
                        slstoragemanagementmodel.blockNo = [[tempArray objectAtIndex:j] objectForKey:@"blockNo"];
                        slstoragemanagementmodel.dedArea = [[tempArray objectAtIndex:j] objectForKey:@"dedArea"];
                        slstoragemanagementmodel.did = [[[tempArray objectAtIndex:j] objectForKey:@"did"] integerValue];
                        slstoragemanagementmodel.height = [[tempArray objectAtIndex:j] objectForKey:@"height"];
                        slstoragemanagementmodel.isfrozen = [[[tempArray objectAtIndex:j] objectForKey:@"isfrozen"] integerValue];
                        slstoragemanagementmodel.length = [[tempArray objectAtIndex:j] objectForKey:@"length"];
                        slstoragemanagementmodel.mtlId = [[[tempArray objectAtIndex:j] objectForKey:@"mtlId"] integerValue];
                        slstoragemanagementmodel.mtlName = [[tempArray objectAtIndex:j] objectForKey:@"mtlName"];
                        slstoragemanagementmodel.storeareaName = @"";
                        slstoragemanagementmodel.dedLengthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedWidthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedLengthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedWidthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedLengthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        
                        slstoragemanagementmodel.dedWidthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedLengthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        slstoragemanagementmodel.dedWidthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        
                        slstoragemanagementmodel.mtltypeId = [[[tempArray objectAtIndex:j] objectForKey:@"mtltypeId"] integerValue];
                        slstoragemanagementmodel.mtltypeName = [[tempArray objectAtIndex:j] objectForKey:@"mtltypeName"];
                        slstoragemanagementmodel.preArea = [[tempArray objectAtIndex:j] objectForKey:@"preArea"];
                        slstoragemanagementmodel.qty = [[[tempArray objectAtIndex:j] objectForKey:@"qty"] integerValue];
                        slstoragemanagementmodel.receiptDate = [[tempArray objectAtIndex:j] objectForKey:@"receiptDate"];
                        slstoragemanagementmodel.slNo = [[tempArray objectAtIndex:j] objectForKey:@"slNo"];
                        slstoragemanagementmodel.storageType = [[tempArray objectAtIndex:j] objectForKey:@"storageType"];
                        slstoragemanagementmodel.storeareaId = [[[tempArray objectAtIndex:j] objectForKey:@"storeareaId"] integerValue];
                        slstoragemanagementmodel.turnsNo = [[tempArray objectAtIndex:j] objectForKey:@"turnsNo"];
                        slstoragemanagementmodel.whsId = [[[tempArray objectAtIndex:j] objectForKey:@"whsId"] integerValue];
                        slstoragemanagementmodel.whsName = [[tempArray objectAtIndex:j] objectForKey:@"whsName"];
                        slstoragemanagementmodel.width = [[tempArray objectAtIndex:j] objectForKey:@"width"];
                        slstoragemanagementmodel.isSelect = false;
                        [selectDabanslmodel.contentArray addObject:slstoragemanagementmodel];
                    }
                    [contentArray addObject:selectDabanslmodel];
                }
                [weakSelf.choosingArray addObjectsFromArray:contentArray];
                weakSelf.pageNum++;
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



- (void)setUIBottomView{
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     [sureBtn addTarget:self action:@selector(sureChoosingInventoryAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}

//确定
- (void)sureChoosingInventoryAction:(UIButton *)sureBtn{
    
//    for (int i = 0; i < self.choosingArray.count; i++) {
//        RSSelectDabanSLModel * selectdabanslmodel = self.choosingArray[i];
//        for (int j = 0; j < selectdabanslmodel.contentArray.count; j++) {
//            RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[j];
//            if (slstoragemanagementmodel.isSelect) {
//                [self.selectdeContentArray addObject:slstoragemanagementmodel];
//            }
//        }
//    }
    
    //这边只有大板
    if (self.selectdeContentArray.count < 1) {
        [SVProgressHUD showInfoWithStatus:@"请选择你需要的板号"];
    }else{
        if ([self.delegate respondsToSelector:@selector(dabanChoosingContentArray:andCancelArray:)]) {
            [self.delegate dabanChoosingContentArray:self.selectdeContentArray andCancelArray:self.cancelArray];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 165;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSSelectDabanSLModel * selectdabanslmodel = self.choosingArray[section];
    NSString *identifier = [NSString stringWithFormat:@"CHOOSINGINVENTORYHEADERVIEW%ld",(long)section];
    RSChoosingInventoryHeaderView * choosingInventoryHeaderView = [[RSChoosingInventoryHeaderView alloc]initWithReuseIdentifier:identifier];
    choosingInventoryHeaderView.selectBtn.tag = section;
    choosingInventoryHeaderView.tag = section;
    choosingInventoryHeaderView.tap.view.tag = section;
    choosingInventoryHeaderView.choosingNumberLabel.text =[NSString stringWithFormat:@"荒料号:%@",selectdabanslmodel.blockNo];
    choosingInventoryHeaderView.choosingProductNameLabel.text =[NSString stringWithFormat:@"物料名称:%@",selectdabanslmodel.mtlName];
    choosingInventoryHeaderView.choosingProductTypeLabel.text = [NSString stringWithFormat:@"物料类型:%@",selectdabanslmodel.mtltypeName];
    choosingInventoryHeaderView.choosingAreaLabel.text = [NSString stringWithFormat:@"总实际面积:%0.3lf(m²)",[selectdabanslmodel.totalVaQty doubleValue]];
    choosingInventoryHeaderView.choosingWarehouseLabel.text = [NSString stringWithFormat:@"匝号:%@ %ld片",selectdabanslmodel.turnsNo,(long)selectdabanslmodel.totalQty];
    
    
    if (self.selectdeContentArray.count > 0) {
        for (int j = 0; j < self.selectdeContentArray.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = self.selectdeContentArray[j];
            for (int i = 0; i < selectdabanslmodel.contentArray.count; i++) {
                 RSSLStoragemanagementModel * slstoragemanagementmodel1 = selectdabanslmodel.contentArray[i];
                if (slstoragemanagementmodel.did == slstoragemanagementmodel1.did) {
                    if (!slstoragemanagementmodel.isSelect) {
                        slstoragemanagementmodel1.isSelect = false;
                    }else{
                        slstoragemanagementmodel1.isSelect = true;
                    }
                }
            }
        }
        BOOL selectAll = YES;
        for (int i = 0; i < selectdabanslmodel.contentArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[i];
            if (!slstoragemanagementmodel.isSelect) {
                selectAll = NO;
                break;
            }
        }
        choosingInventoryHeaderView.selectBtn.selected = selectAll;
    }else{
        BOOL selectAll = YES;
        for (int i = 0; i < selectdabanslmodel.contentArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[i];
            if (!slstoragemanagementmodel.isSelect) {
                selectAll = NO;
                break;
            }
        }
         choosingInventoryHeaderView.selectBtn.selected = selectAll;
    }
    
    if ([self.expendArray containsObject:@(section)]) {
        choosingInventoryHeaderView.choosingDirectionImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }else {
        choosingInventoryHeaderView.choosingDirectionImageView.transform = CGAffineTransformIdentity;
    }
    [choosingInventoryHeaderView.selectBtn addTarget:self action:@selector(headerButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [choosingInventoryHeaderView.tap addTarget:self action:@selector(headerTap:)];
    
    return choosingInventoryHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    NSString *identifier = [NSString stringWithFormat:@"CHOOSINGINVENTORYFOOTVIEW%ld",(long)section];
    RSChoosingInventoryFootView * choosingInventoryFootView = [[RSChoosingInventoryFootView alloc]initWithReuseIdentifier:identifier];
    return choosingInventoryFootView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.choosingArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    RSSelectDabanSLModel * selectddabanslmodel = self.choosingArray[section];
    if ([self.expendArray containsObject:@(section)]) {
        return selectddabanslmodel.contentArray.count;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSSelectDabanSLModel * selectdabanslmodel = self.choosingArray[indexPath.section];
    RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[indexPath.row];
     NSString *identifier = [NSString stringWithFormat:@"CHOOSINGINVENTORYCELLID%ld%ld",(long)indexPath.section,(long)indexPath.row];
    RSChoosingInventoryCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RSChoosingInventoryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.iamgeView.hidden = YES;
    cell.tag = indexPath.section;
    cell.selectBtn.tag = indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(showAndHideSelectContentAction:) forControlEvents:UIControlEventTouchUpInside];
   cell.filmNumberLabel.text = [NSString stringWithFormat:@"板号:%@",slstoragemanagementmodel.slNo];
    cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]];
    
    CGSize  size1 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.longDetailLabel.sd_layout
    .widthIs(size1.width);
    
    
    cell.wideDetialLabel.text =  [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]];
    
    CGSize size2 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.wideDetialLabel.sd_layout
    .widthIs(size2.width);

     cell.thickDeitalLabel.text =  [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]];
    CGSize size3 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.thickDeitalLabel.sd_layout
    .widthIs(size3.width);
    
    cell.originalAreaDetailLabel.text =  [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]];
    CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.originalAreaDetailLabel.sd_layout
    .widthIs(size4.width);
    
    cell.deductionAreaDetailLabel.text =  [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]];
    CGSize size5 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.deductionAreaDetailLabel.sd_layout
    .widthIs(size5.width);
    cell.actualAreaDetailLabel.text =  [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]];
    CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.actualAreaDetailLabel.sd_layout
    .widthIs(size6.width);
    if (self.selectdeContentArray.count > 0) {
        for (int i = 0; i < self.selectdeContentArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel1 = self.selectdeContentArray[i];
            if (slstoragemanagementmodel1.did == slstoragemanagementmodel.did) {
                cell.selectBtn.selected = true;
                slstoragemanagementmodel.isSelect = true;
                break;
            }else{
                cell.selectBtn.selected = false;
                slstoragemanagementmodel.isSelect = false;
            }
        }
        if (slstoragemanagementmodel.isSelect) {
            cell.selectBtn.selected = true;
        }else{
            cell.selectBtn.selected = false;
        }
    }else{
        if (slstoragemanagementmodel.isSelect) {
            cell.selectBtn.selected = true;
        }else{
            cell.selectBtn.selected = false;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGSize)obtainLabelTextSize:(NSString *)text andFont:(UIFont *)font{
    CGSize size = [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil].size;
    return size;
}

- (void)showAndHideSelectContentAction:(UIButton *)selectBtn{
  //  [self.selectdeContentArray removeAllObjects];
    UIView *v = [selectBtn superview];//获取父类view
    UIView *v1 = [v superview];
    RSChoosingInventoryCell *cell = (RSChoosingInventoryCell *)[v1 superview];
    RSSelectDabanSLModel * selectdabanslmodel = self.choosingArray[cell.tag];
    RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[selectBtn.tag];
    selectBtn.selected = !selectBtn.selected;
    if (selectBtn.selected) {
        slstoragemanagementmodel.isSelect = true;
        [self.selectdeContentArray addObject:slstoragemanagementmodel];
    }else{
        [self.cancelArray addObject:@(slstoragemanagementmodel.did)];
        slstoragemanagementmodel.isSelect = false;
        for (int i = 0; i < self.selectdeContentArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemangementmodel1 = self.selectdeContentArray[i];
            if (slstoragemangementmodel1.did == slstoragemanagementmodel.did) {
                [self.selectdeContentArray removeObjectAtIndex:i];
                break;
            }
        }
    }
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:cell.tag] withRowAnimation:UITableViewRowAnimationNone];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    RSSelectDabanSLModel * selectdabanslmodel = self.choosingArray[indexPath.section];
//
//    RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[indexPath.row];
//
//    if ([self.selectdeContentArray containsObject:@(slstoragemanagementmodel.did)]) {
//        [self.selectdeContentArray removeObject:slstoragemanagementmodel];
//        [self.cancelArray addObject:@(slstoragemanagementmodel.did)];
//    }else{
//        [self.selectdeContentArray addObject:slstoragemanagementmodel];
//    }
//    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
//}


- (void)headerButtonOnClick:(UIButton *)button {
    //[self.selectdeContentArray removeAllObjects];
     RSSelectDabanSLModel * selectdabanslmodel = self.choosingArray[button.tag];
     button.selected = !button.selected;
    if (button.selected) {
        for (int i = 0; i < selectdabanslmodel.contentArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[i];
            if (slstoragemanagementmodel.isSelect) {
                slstoragemanagementmodel.isSelect = true;
            }else{
                [self.selectdeContentArray addObject:slstoragemanagementmodel];
                slstoragemanagementmodel.isSelect = true;
            }
        }
    }else {
        for (int i = 0; i < selectdabanslmodel.contentArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[i];
            slstoragemanagementmodel.isSelect = false;
            [self.cancelArray addObject:@(slstoragemanagementmodel.did)];
        }
        
        for (int i = 0; i < self.selectdeContentArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemangementmodel1 = self.selectdeContentArray[i];
            for (int j = 0; j < selectdabanslmodel.contentArray.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[j];
                if (slstoragemanagementmodel.did == slstoragemangementmodel1.did) {
                    [self.selectdeContentArray removeObjectAtIndex:i];
                    i--;
                    break;
                }
            }
        }
    }
    [self.tableview reloadData];
//    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:button.tag] withRowAnimation:UITableViewRowAnimationNone];
}







- (void)headerTap:(UITapGestureRecognizer *)tap {
    RSChoosingInventoryHeaderView * view = (RSChoosingInventoryHeaderView *)tap.view;
    //RSSelectDabanSLModel * selectdabanslmodel = self.choosingArray[view.tag];
   // RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[0];
    if ([self.expendArray containsObject:@(view.tag)]) {
        [self.expendArray removeObject:@(view.tag)];
        [UIView animateWithDuration:0.1 animations:^{
            view.choosingDirectionImageView.transform = CGAffineTransformIdentity;
        }];
    }else {
        [self.expendArray addObject:@(view.tag)];
        [UIView animateWithDuration:0.1 animations:^{
            view.choosingDirectionImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
    //[self.tableview reloadSections:[NSIndexSet indexSetWithIndex:view.tag] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableview reloadData];
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
