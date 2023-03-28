//
//  RSRawMaterialViewController.m
//  石来石往
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSRawMaterialViewController.h"
#import "RSPersonalBalanceCell.h"
#import "RSBalanceModel.h"
#import "RSWarehouseModel.h"
#import "RSReportFormView.h"
#import "RSReportFormMenuView.h"
#import "RSRawDetailNewViewController.h"

#import "RSPersonalWkWebviewViewController.h"

@interface RSRawMaterialViewController ()
{
    
    UIButton * _allBtn;
    UIView * _allView;
    UIButton * _rightBtn;
    UIView * _rightView;
    UILabel * _totalVolmueDetailLabel;
    UILabel * _numberDetailLabel;
}

@property (nonatomic,assign)NSInteger pageNum;
@property (nonatomic,strong)NSMutableDictionary * blockDict;
@property (nonatomic,strong)NSMutableArray * balanceArray;
@property (nonatomic,strong)NSString * type;
@property (nonatomic ,strong) RSReportFormMenuView * menu;
@end

@implementation RSRawMaterialViewController

- (NSMutableArray *)balanceArray{
    if (!_balanceArray) {
        _balanceArray = [NSMutableArray array];
    }
    return _balanceArray;
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
    
    //URL_BLSTORAGEDETAIL_IOS
    self.type = @"SUM";
    self.pageNum = 2;
    RSReportFormView * reportformView = [[RSReportFormView alloc]initWithFrame:CGRectMake(91, 0, [UIScreen mainScreen].bounds.size.width - 91, [UIScreen mainScreen].bounds.size.height)];
    reportformView.longIndex = 0;
    reportformView.withIndex = 0;
    reportformView.wareHouseIndex = 0;
    reportformView.frozenviewIndex = 0;
    reportformView.selectFunctionType = self.selectFunctionType;
    if (self.searchTypeIndex == 1) {
        reportformView.inSelect = @"1";
    }else{
        reportformView.inSelect = @"2";
    }
    RSWeakself
     __weak typeof(reportformView) weakReportformview = reportformView;
    reportformView. reportformCreateUserNameBLSelect = ^(NSString * _Nonnull inSelect, NSString * _Nonnull beginTime, NSString * _Nonnull endTime, NSString * _Nonnull wuliaoTextView, NSString * _Nonnull blockTextView, NSString * _Nonnull longTypeView, NSInteger longIndex, NSString * _Nonnull longTextView, NSString * _Nonnull withTypeView, NSInteger withIndex, NSString * _Nonnull withTextView, NSString * _Nonnull luTypeView, NSString * _Nonnull wareHouseView, NSInteger wareHouseIndex, NSString * _Nonnull frozenView, NSInteger frozenviewIndex, NSString * _Nonnull createUserName) {
        
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
//            weakReportformview.wareHouseIndex = 0;
//        }else{
//            RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
//            NSMutableArray * warehouseArray = [db getAllContent:@"BL"];
//
//
//            weakReportformview.wareHouseIndex =  wareHouseIndex;
//            RSWarehouseModel * warehousemodel = warehouseArray[wareHouseIndex-1];
//
//            [weakSelf.blockDict setObject:warehousemodel.name forKey:@"whsName"];
//            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID] forKey:@"whsId"];
//        }
//
        
        if ([self.selectFunctionType isEqualToString:@"荒料出库明细表"]) {
            if ([luTypeView isEqualToString:@"请选出库类型"]) {
                [weakSelf.blockDict setObject:@"" forKey:@"billType"];
            }else{
                NSString * str = [NSString string];
                if ([luTypeView isEqualToString:@"销售出库"]) {
                    str = @"BILL_BL_XSCK";
                }else if ([luTypeView isEqualToString:@"加工出库"]){
                    str = @"BILL_BL_JGCK";
                }else if ([luTypeView isEqualToString:@"盘亏出库"]){
                    str = @"BILL_BL_PKCK";
                }
                [weakSelf.blockDict setObject:str forKey:@"billType"];
            }
        }else{
            
            if ([luTypeView isEqualToString:@"请选入库类型"]) {
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
        }
        if ([inSelect isEqualToString:@"1"] || [inSelect isEqualToString:@"2"]) {
             [weakSelf.blockDict setObject:[NSNumber numberWithInteger:-1] forKey:@"isFrozen"];
        }
        else{
            if ([frozenView isEqualToString:@"请选择"]) {
                [weakSelf.blockDict setObject:[NSNumber numberWithInteger:-1] forKey:@"isFrozen"];
            }else{
                if (frozenviewIndex == 0) {
                    [weakSelf.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"isFrozen"];
                }else{
                    [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"isFrozen"];
                }
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
        
        
        [weakSelf.blockDict setObject:createUserName forKey:@"createUserName"];
        
        
        
        
        [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [weakSelf reloadPersonalBlockNewData];
        [weakSelf.menu hidenWithAnimation];
    };
    
    
    
    RSReportFormMenuView *menu = [RSReportFormMenuView MenuViewWithDependencyView:self.view MenuView:reportformView isShowCoverView:YES];
    self.menu = menu;
    
    
    UIButton * blockBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [blockBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [blockBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    blockBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:blockBtn];
    [blockBtn addTarget:self action:@selector(balanceScreeningAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    
    
    [self.blockDict setObject:@"2019-01-01" forKey:@"dateFrom"];
    [self.blockDict setObject:[self showCurrentTime] forKey:@"dateTo"];
    [self.blockDict setObject:@"" forKey:@"mtlName"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"mtlId"];
    [self.blockDict setObject:@"" forKey:@"blockNo"];
    [self.blockDict setObject:@"" forKey:@"whsName"];
    
    [self.blockDict setObject:@"" forKey:@"billType"];
    
    [self.blockDict setObject:@"" forKey:@"storageType"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
    
    [self.blockDict setObject:[NSNumber numberWithInteger:-1] forKey:@"isFrozen"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
    [self.blockDict setObject:[NSNumber numberWithInteger:0]  forKey:@"widthType"];
    [self.blockDict setObject:@"" forKey:@"length"];
    [self.blockDict setObject:@"" forKey:@"width"];
    
    [self.blockDict setObject:@"1" forKey:@"pageNum"];
    [self.blockDict setObject:@"10" forKey:@"pageSize"];
    
    [self.blockDict setObject:@"" forKey:@"createUserName"];
    
    
    [self setUICustomTableviewHeaderView];
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableview.estimatedRowHeight = 0;
        self.tableview.estimatedSectionFooterHeight = 0;
        self.tableview.estimatedSectionHeaderHeight = 0;
    }
    
    [self reloadPersonalBlockNewData];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [weakSelf reloadPersonalBlockNewData];
        
    }];
    
    
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf reloadPersonalBlockNewMoreData];
    }];
    
    
    
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
        [weakSelf reloadPersonalBlockNewData];
    }];
    
    [self setUIBottomCustomView];
    
}


- (void)setUICustomTableviewHeaderView{
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 50)];
    headView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    
    //显示俩种类型
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 35)];
    contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headView addSubview:contentView];
    
    //全部按键
    UIButton * allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    allBtn.frame = CGRectMake(0, 0, SCW/2 - 0.5, 34);
    allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [allBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
    [contentView addSubview:allBtn];
    [allBtn addTarget:self action:@selector(changeAllAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _allBtn = allBtn;
    
    NSDictionary *arrtributeDic = @{ NSFontAttributeName : [UIFont systemFontOfSize:14]};
    //b) 通过获取的字体属性，计算content的frame大小
    CGRect frame = [allBtn.currentTitle boundingRectWithSize:CGSizeMake(SCW/2 - 0.5, 34) options:NSStringDrawingUsesLineFragmentOrigin attributes:arrtributeDic context:nil];
    //boundingRectWithSize:CGSizeMake(SCW/2 - 0.5, 34)options:NSStringDrawingUsesLineFragmentOriginattributes:arrtributeDiccontext:nil]
    UIView * allView = [[UIView alloc]init];
    allView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    allView.frame = CGRectMake((SCW/2)/2 - frame.size.width/2,CGRectGetMaxY(allBtn.frame), frame.size.width, 1);
    [contentView addSubview:allView];
    _allView = allView;
    //中间
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(SCW/2 - 0.5, 12, 1, 12)];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#D8D8D8"];
    [contentView addSubview:midView];
    
    //右边专场汇总
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"专场汇总" forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(SCW/2 + 0.5, 0, SCW/2 - 0.5, 34);
    [rightBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [contentView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(changeRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn = rightBtn;
    
    //NSDictionary *arrtributeDic1 = @{ NSFontAttributeName : [UIFont systemFontOfSize:14]};
    //b) 通过获取的字体属性，计算content的frame大小
    //CGRect frame1 = [rightBtn.currentTitle boundingRectWithSize:CGSizeMake(SCW/2 - 0.5, 34) options:NSStringDrawingUsesLineFragmentOrigin attributes:arrtributeDic1 context:nil];
    //boundingRectWithSize:CGSizeMake(SCW/2 - 0.5, 34)options:NSStringDrawingUsesLineFragmentOriginattributes:arrtributeDiccontext:nil]
    
    UIView * rightView = [[UIView alloc]init];
    rightView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    rightView.frame = CGRectMake((SCW/2) + (SCW/2)/2 - 14,CGRectGetMaxY(rightBtn.frame), 28, 1);
    [contentView addSubview:rightView];
    rightView.hidden =  YES;
    _rightView = rightView;
    self.tableview.tableHeaderView = headView;
    
}


//全部
- (void)changeAllAction:(UIButton *)allBtn{
    
    [allBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    self.type = @"SUM";
    _allView.hidden = NO;
    self.pageNum = 2;
    _rightView.hidden = YES;
    [self.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [self reloadPersonalBlockNewData];
}

//专场
- (void)changeRightBtnAction:(UIButton *)rightBtn{
    [_allBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    self.type = @"WHSDETAIL";
    _allView.hidden = YES;
    self.pageNum = 2;
    _rightView.hidden = NO;
    [self.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [self reloadPersonalBlockNewData];
}




//底部视图
- (void)setUIBottomCustomView{
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, SCH - 43, SCW, 43)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:bottomview];
    [bottomview bringSubviewToFront:self.view];
    
    UIButton * totalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [totalBtn setTitle:@"合计" forState:UIControlStateNormal];
    totalBtn.frame = CGRectMake(0, 0, 61, 43);
    [totalBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [totalBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [bottomview addSubview:totalBtn];
    
    //总颗数
    UILabel * numberLabel = [[UILabel alloc]init];
    numberLabel.text = @"总颗数";
    numberLabel.frame = CGRectMake(CGRectGetMaxX(totalBtn.frame) + 9, bottomview.yj_height /2 - 8.5, 37, 17);
    numberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    numberLabel.font = [UIFont systemFontOfSize:12];
    numberLabel.textAlignment = NSTextAlignmentLeft;
    [bottomview addSubview:numberLabel];
    
    //总颗数的内容
    UILabel * numberDetailLabel = [[UILabel alloc]init];
    numberDetailLabel.frame = CGRectMake(CGRectGetMaxX(numberLabel.frame) + 8, bottomview.yj_height /2 - 8.5, 80, 17);
    //numberDetailLabel.text = @"25颗";
    numberDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    numberDetailLabel.font = [UIFont systemFontOfSize:16];
    numberDetailLabel.textAlignment = NSTextAlignmentLeft;
    [bottomview addSubview:numberDetailLabel];
    _numberDetailLabel = numberDetailLabel;
    //总体积
    UILabel * totalVolmueLabel = [[UILabel alloc]init];
    totalVolmueLabel.text = @"总体积";
    totalVolmueLabel.frame = CGRectMake(CGRectGetMaxX(numberDetailLabel.frame) + 9, bottomview.yj_height /2 - 8.5, 37, 17);
    totalVolmueLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    totalVolmueLabel.font = [UIFont systemFontOfSize:12];
    totalVolmueLabel.textAlignment = NSTextAlignmentLeft;
    [bottomview addSubview:totalVolmueLabel];
    //总体积的值
    
    UILabel * totalVolmueDetailLabel = [[UILabel alloc]init];
    totalVolmueDetailLabel.frame = CGRectMake(CGRectGetMaxX(totalVolmueLabel.frame) + 8,  bottomview.yj_height /2 - 8.5,100, 17);
    //totalVolmueDetailLabel.text = @"25.888m³";
    totalVolmueDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    totalVolmueDetailLabel.font = [UIFont systemFontOfSize:16];
    totalVolmueDetailLabel.textAlignment = NSTextAlignmentLeft;
    [bottomview addSubview:totalVolmueDetailLabel];
    _totalVolmueDetailLabel = totalVolmueDetailLabel;
}




//筛选
- (void)balanceScreeningAction:(UIButton *)blockBtn{
    [self.menu show];
}


- (void)reloadPersonalBlockNewData{
    //URL_BLBALANCE_IOS
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.type forKey:@"type"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.searchTypeIndex] forKey:@"searchType"];
    [phoneDict setObject:self.blockDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BLSTORAGEDETAIL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.balanceArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSBalanceModel * balancemodel = [[RSBalanceModel alloc]init];
                    balancemodel.mtlId =  [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    balancemodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    balancemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                    balancemodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    balancemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    balancemodel.whsName = [[array objectAtIndex:i]objectForKey:@"whsName"];
                    balancemodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"] integerValue];
                    [weakSelf.balanceArray addObject:balancemodel];
                }
                
                _numberDetailLabel.text =  [NSString stringWithFormat:@"%ld颗",[json[@"data"][@"total"][@"totalQty"] integerValue] ];
                _totalVolmueDetailLabel.text = [NSString stringWithFormat:@"%0.3lfm³",[json[@"data"][@"total"][@"totalVaQty"] doubleValue]];
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


- (void)reloadPersonalBlockNewMoreData{
    //URL_BLBALANCE_IOS
    [self.blockDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.type forKey:@"type"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.searchTypeIndex] forKey:@"searchType"];
    [phoneDict setObject:self.blockDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BLSTORAGEDETAIL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                NSMutableArray * tempArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    RSBalanceModel * balancemodel = [[RSBalanceModel alloc]init];
                    balancemodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"] integerValue];
                    balancemodel.mtlId =  [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    balancemodel.whsName = [[array objectAtIndex:i]objectForKey:@"whsName"];
                    balancemodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    balancemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                    balancemodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    balancemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    [tempArray addObject:balancemodel];
                }
                [weakSelf.balanceArray addObjectsFromArray:tempArray];
                _numberDetailLabel.text =  [NSString stringWithFormat:@"%ld颗",[json[@"data"][@"total"][@"totalQty"] integerValue] ];
                _totalVolmueDetailLabel.text = [NSString stringWithFormat:@"%0.3lfm³",[json[@"data"][@"total"][@"totalVaQty"] doubleValue]];
                
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.balanceArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 169;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PERSONALBALANCECELLID = @"PERSONALBALANCECELLID";
    RSPersonalBalanceCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSONALBALANCECELLID];
    if (!cell ) {
        cell = [[RSPersonalBalanceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PERSONALBALANCECELLID];
    }
    cell.balancemodel = self.balanceArray[indexPath.row];
    [cell.codeSheetBtn addTarget:self action:@selector(codeSendAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.reportFormBtn addTarget:self action:@selector(reportFromSendAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSRawDetailNewViewController * balanceDetailVc = [[RSRawDetailNewViewController alloc]init];
    RSBalanceModel * balancemodel = self.balanceArray[indexPath.row];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:[self.blockDict objectForKey:@"dateFrom"] forKey:@"dateFrom"];
    [dict setObject:[self.blockDict objectForKey:@"dateTo"] forKey:@"dateTo"];
    [dict setObject:[self.blockDict objectForKey:@"blockNo"] forKey:@"blockNo"];
    [dict setObject:[self.blockDict objectForKey:@"storageType"] forKey:@"storageType"];
    [dict setObject:[self.blockDict objectForKey:@"lengthType"] forKey:@"lengthType"];
    [dict setObject:[self.blockDict objectForKey:@"widthType"] forKey:@"widthType"];
    [dict setObject:[self.blockDict objectForKey:@"isFrozen"] forKey:@"isFrozen"];
    [dict setObject:[self.blockDict objectForKey:@"length"] forKey:@"length"];
    [dict setObject:[self.blockDict objectForKey:@"width"] forKey:@"width"];
    //[self.blockDict setObject:@"" forKey:@"billType"];
    [dict setObject:[self.blockDict objectForKey:@"billType"] forKey:@"billType"];
    [dict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [dict setObject:[self.blockDict objectForKey:@"pageSize"] forKey:@"pageSize"];
    if ([self.type isEqualToString:@"SUM"]) {
        //[self.blockDict setObject:[NSNumber numberWithInteger:balancemodel.mtlId] forKey:@"mtlId"];
        [dict setObject:[NSNumber numberWithInteger:balancemodel.mtlId] forKey:@"mtlId"];
        [dict setObject:[self.blockDict objectForKey:@"whsId"] forKey:@"whsId"];
        [dict setObject:balancemodel.mtlName forKey:@"mtlName"];
        [dict setObject:[self.blockDict objectForKey:@"whsName"] forKey:@"whsName"];
    }else{
        [dict setObject:[NSNumber numberWithInteger:0] forKey:@"mtlId"];
        [dict setObject:[self.blockDict objectForKey:@"mtlName"] forKey:@"mtlName"];
        [dict setObject:balancemodel.whsName forKey:@"whsName"];
        [dict setObject:[NSNumber numberWithInteger:balancemodel.whsId] forKey:@"whsId"];
    }
    balanceDetailVc.blockDict = dict;
    balanceDetailVc.selectFunctionType = self.selectFunctionType;
    balanceDetailVc.usermodel = self.usermodel;
    balanceDetailVc.searchTypeIndex = self.searchTypeIndex;
    [self.navigationController pushViewController:balanceDetailVc animated:YES];
    
}

//码单
- (void)codeSendAction:(UIButton *)codeSheetBtn{
    RSBalanceModel * balancemodel = self.balanceArray[codeSheetBtn.tag];
    RSPersonalWkWebviewViewController * personalWkVc = [[RSPersonalWkWebviewViewController alloc]init];
    personalWkVc.usermodel = self.usermodel;
      personalWkVc.title = self.selectFunctionType;
    personalWkVc.dateFrom = [self.blockDict objectForKey:@"dateFrom"];
    personalWkVc.dateTo = [self.blockDict objectForKey:@"dateTo"];
   // personalWkVc.mtlName = [self.blockDict objectForKey:@"mtlName"];
   // personalWkVc.mtlId = [[self.blockDict objectForKey:@"mtlId"]integerValue];
    personalWkVc.blockNo = [self.blockDict objectForKey:@"blockNo"];
    if (personalWkVc.blockNo == nil) {
        personalWkVc.blockNo = @"";
    }
    
    if ([self.type isEqualToString:@"SUM"]) {
        
        personalWkVc.mtlId = balancemodel.mtlId;
        personalWkVc.whsId = [[self.blockDict objectForKey:@"whsId"] integerValue];
        personalWkVc.mtlName = balancemodel.mtlName;
        personalWkVc.whsName = [self.blockDict objectForKey:@"whsName"];
    }else{
        
        personalWkVc.mtlId = [[self.blockDict objectForKey:@"mtlId"]integerValue];
        personalWkVc.mtlName = [self.blockDict objectForKey:@"mtlName"];
        personalWkVc.whsId = balancemodel.whsId;
        personalWkVc.whsName = balancemodel.whsName;
    }
    
    
    
    //personalWkVc.whsName = [self.blockDict objectForKey:@"whsName"];
    personalWkVc.storageType = [self.blockDict objectForKey:@"storageType"];
    //personalWkVc.whsId = [[self.blockDict objectForKey:@"whsId"] integerValue];
    personalWkVc.isFrozen = [[self.blockDict objectForKey:@"isFrozen"]integerValue];
    personalWkVc.lengthType = [[self.blockDict objectForKey:@"lengthType"] integerValue];
    personalWkVc.widthType = [[self.blockDict objectForKey:@"widthType"]integerValue];
    personalWkVc.length = [self.blockDict objectForKey:@"length"];
    if (personalWkVc.length == nil) {
        personalWkVc.length = @"";
    }
    
    personalWkVc.width = [self.blockDict objectForKey:@"width"];
    if (personalWkVc.width == nil) {
        personalWkVc.width = @"";
    }
    
    personalWkVc.appType = 1;
    if (self.searchTypeIndex == 1) {
         personalWkVc.pageType = 2;
    }else{
         personalWkVc.pageType = 3;
    }
      personalWkVc.typeStr = @"码单分享";
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    personalWkVc.VerifyKey = [user objectForKey:@"VERIFYKEY"];
    personalWkVc.totalQty = balancemodel.qty;
    personalWkVc.totalVaQty = balancemodel.volume;
    
    //personalWkVc.webStr = @"http://117.29.162.206:8888/slsw/pwms/codeList.html";
    personalWkVc.webStr = [NSString stringWithFormat:@"%@slsw/pwms/codeList.html",URL_HEADER_TEXT_IOS];
    
    NSString * reportUrlStr = [NSString stringWithFormat:@"%@?appType=%ld&userId=%@&VerifyKey=%@&pageType=%ld&totalQty=%ld&totalVaQty=%@&dateFrom=%@&dateTo=%@&mtlName=%@&mtlId=%ld&blockNo=%@&whsName=%@&storageType=%@&whsId=%ld&isFrozen=%ld&lengthType=%ld&widthType=%ld&length=%@&width=%@&companyName=%@&pwmsUserId=%ld", personalWkVc.webStr,personalWkVc.appType,self.usermodel.userID,personalWkVc.VerifyKey, personalWkVc.pageType,balancemodel.qty, balancemodel.volume,personalWkVc.dateFrom,personalWkVc.dateTo,personalWkVc.mtlName,personalWkVc.mtlId,personalWkVc.blockNo,personalWkVc.whsName,personalWkVc.storageType,personalWkVc.whsId,personalWkVc.isFrozen,personalWkVc.lengthType,personalWkVc.widthType,personalWkVc.length, personalWkVc.width,self.usermodel.pwmsUser.companyName,self.usermodel.pwmsUser.parentId];
    personalWkVc.ulrStr = reportUrlStr;
    [self.navigationController pushViewController:personalWkVc animated:YES];
}

//报表
- (void)reportFromSendAction:(UIButton *)reportFormBtn{
    RSBalanceModel * balancemodel = self.balanceArray[reportFormBtn.tag];
    RSPersonalWkWebviewViewController * personalWkVc = [[RSPersonalWkWebviewViewController alloc]init];
    personalWkVc.dateFrom = [self.blockDict objectForKey:@"dateFrom"];
    personalWkVc.dateTo = [self.blockDict objectForKey:@"dateTo"];
    personalWkVc.title = self.selectFunctionType;
   
    personalWkVc.blockNo = [self.blockDict objectForKey:@"blockNo"];
    if (personalWkVc.blockNo == nil) {
        personalWkVc.blockNo = @"";
    }
    
      personalWkVc.typeStr = @"报表分享";
    if ([self.type isEqualToString:@"SUM"]) {
        
        personalWkVc.mtlId = balancemodel.mtlId;
        personalWkVc.whsId = [[self.blockDict objectForKey:@"whsId"] integerValue];
        personalWkVc.mtlName = balancemodel.mtlName;
        personalWkVc.whsName = [self.blockDict objectForKey:@"whsName"];
    }else{
        
        personalWkVc.mtlId = [[self.blockDict objectForKey:@"mtlId"]integerValue];
        personalWkVc.mtlName = [self.blockDict objectForKey:@"mtlName"];
        personalWkVc.whsId = balancemodel.whsId;
        personalWkVc.whsName = balancemodel.whsName;
    }
    
    
    
    
    personalWkVc.storageType = [self.blockDict objectForKey:@"storageType"];

    personalWkVc.isFrozen = [[self.blockDict objectForKey:@"isFrozen"]integerValue];
    personalWkVc.lengthType = [[self.blockDict objectForKey:@"lengthType"] integerValue];
    personalWkVc.widthType = [[self.blockDict objectForKey:@"widthType"]integerValue];
    personalWkVc.length = [self.blockDict objectForKey:@"length"];
    if (personalWkVc.length == nil) {
        personalWkVc.length = @"";
    }
    personalWkVc.width = [self.blockDict objectForKey:@"width"];
    if (personalWkVc.width == nil) {
        personalWkVc.width = @"";
    }
    personalWkVc.appType = 1;
    if (self.searchTypeIndex == 1) {
        personalWkVc.pageType = 2;
    }else{
        personalWkVc.pageType = 3;
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    personalWkVc.VerifyKey = [user objectForKey:@"VERIFYKEY"];
    personalWkVc.totalQty = balancemodel.qty;
    personalWkVc.totalVaQty = balancemodel.volume;
    
    //personalWkVc.webStr = @"http://117.29.162.206:8888/slsw/pwms/reportList.html";
    
    personalWkVc.webStr = [NSString stringWithFormat:@"%@slsw/pwms/reportList.html",URL_HEADER_TEXT_IOS];
    
    NSString * reportUrlStr = [NSString stringWithFormat:@"%@?appType=%ld&userId=%@&VerifyKey=%@&pageType=%ld&totalQty=%ld&totalVaQty=%@&dateFrom=%@&dateTo=%@&mtlName=%@&mtlId=%ld&blockNo=%@&whsName=%@&storageType=%@&whsId=%ld&isFrozen=%ld&lengthType=%ld&widthType=%ld&length=%@&width=%@&companyName=%@&pwmsUserId=%ld", personalWkVc.webStr,personalWkVc.appType,self.usermodel.userID,personalWkVc.VerifyKey, personalWkVc.pageType,balancemodel.qty, balancemodel.volume,personalWkVc.dateFrom,personalWkVc.dateTo,personalWkVc.mtlName,personalWkVc.mtlId,personalWkVc.blockNo,personalWkVc.whsName,personalWkVc.storageType,personalWkVc.whsId,personalWkVc.isFrozen,personalWkVc.lengthType,personalWkVc.widthType,personalWkVc.length, personalWkVc.width,self.usermodel.pwmsUser.companyName,self.usermodel.pwmsUser.parentId];
    personalWkVc.ulrStr = reportUrlStr;
    [self.navigationController pushViewController:personalWkVc animated:YES];
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
