//
//  RSSLRunningDetialViewController.m
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLRunningDetialViewController.h"
#import "RSReportFormView.h"
#import "RSReportFormMenuView.h"
#import "RSWarehouseModel.h"

#import "RSSLRunningDetialModel.h"
#import "RSSLRunOpenCell.h"
#import "RSAccountDetailModel.h"
#import "RSAccountAlertView.h"

@interface RSSLRunningDetialViewController ()<RSSLRunOpenCellDelegate>
{
      UIView * _centerView;
    
    
}

@property (nonatomic,strong)NSString * btnType;
@property (nonatomic,assign)NSInteger pageNum;
@property (nonatomic ,strong)RSReportFormMenuView * menu;

@property (nonatomic,strong)NSMutableArray * runningDetialArray;

@end

@implementation RSSLRunningDetialViewController

- (NSMutableArray *)runningDetialArray{
    if (!_runningDetialArray) {
        _runningDetialArray = [NSMutableArray array];
    }
    return _runningDetialArray;
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
    
    self.pageNum = 2;
    
    
    UIButton * warehouseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [warehouseBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [warehouseBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    warehouseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:warehouseBtn];
    
    [warehouseBtn addTarget:self action:@selector(warehouseRunningAccountAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = rightitem;
    
//    [self.blockDict setObject:@"2019-01-01" forKey:@"dateFrom"];
//    [self.blockDict setObject:[self showCurrentTime] forKey:@"dateTo"];
//    [self.blockDict setObject:@"" forKey:@"mtlName"];
//    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"mtlId"];
//    [self.blockDict setObject:@"" forKey:@"blockNo"];
//    [self.blockDict setObject:@"" forKey:@"whsName"];
//    [self.blockDict setObject:@"" forKey:@"storageType"];
//    [self.blockDict setObject:@"" forKey:@"turnsNo"];
//    [self.blockDict setObject:@"" forKey:@"slNo"];
//    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
//    [self.blockDict setObject:[NSNumber numberWithInteger:-1] forKey:@"isFrozen"];
//    [self.blockDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
//    [self.blockDict setObject:[NSNumber numberWithInteger:0]  forKey:@"widthType"];
//    [self.blockDict setObject:@"" forKey:@"length"];
//    [self.blockDict setObject:@"" forKey:@"width"];
//    [self.blockDict setObject:@"1" forKey:@"pageNum"];
//    [self.blockDict setObject:@"10" forKey:@"pageSize"];
    
    
    
    [self runningReloadNewData];
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
            [weakSelf.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
            [weakSelf runningReloadNewData];
        
    }];
    
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf runningReloadNewMoreData];
    }];
    
    [self showNoNewDataView];
    RSReportFormView * reportformView = [[RSReportFormView alloc]initWithFrame:CGRectMake(91, 0, [UIScreen mainScreen].bounds.size.width - 91, [UIScreen mainScreen].bounds.size.height)];
   
    reportformView.inSelect = @"1";
    reportformView.selectFunctionType = self.selectFunctionType;
    
    
    /**
     
     
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
     
     
     
     */
    
    //self.blockDict
    reportformView.secondType = @"2";
    reportformView.begimTimeStr = [self.blockDict objectForKey:@"dateFrom"];
    reportformView.endTimeStr = [self.blockDict objectForKey:@"dateTo"];
    reportformView.wuStr = [self.blockDict objectForKey:@"mtlName"];
    reportformView.blockStr = [self.blockDict objectForKey:@"blockNo"];
    reportformView.turnsStr = [self.blockDict objectForKey:@"turnsNo"];
    reportformView.slnoStr = [self.blockDict objectForKey:@"slNo"];
    reportformView.lentStr = [NSString stringWithFormat:@"%@",[self.blockDict objectForKey:@"length"]];
    reportformView.withStr =[NSString stringWithFormat:@"%@",[self.blockDict objectForKey:@"width"]];
    NSInteger lengtype = [[self.blockDict objectForKey:@"lengthType"] integerValue];
    if (lengtype == 0) {
        reportformView.lentType = @"请选择类型";
        reportformView.longIndex = 0;
    }else if (lengtype == 1){
        reportformView.lentType = @"大于";
        reportformView.longIndex = 0;
    }else if (lengtype == 2){
        reportformView.lentType = @"等于";
        reportformView.longIndex = 0;
    }else if (lengtype == 3){
        reportformView.lentType = @"小于";
        reportformView.longIndex = 0;
    }
    
    NSInteger widthype = [[self.blockDict objectForKey:@"widthType"] integerValue];
    if (widthype == 0) {
        reportformView.withType = @"请选择类型";
        reportformView.withIndex = 0;
    }else if (widthype == 1){
        reportformView.withType = @"大于";
        reportformView.withIndex = 0;
    }else if (widthype == 2){
        reportformView.withType = @"等于";
        reportformView.withIndex = 0;
    }else if (widthype == 3){
        reportformView.withType = @"小于";
        reportformView.withIndex = 0;
    }
    
    reportformView.luType = [self.blockDict objectForKey:@"storageType"];
    reportformView.wareNameStr = [self.blockDict objectForKey:@"whsName"];
    reportformView.whsId = [[self.blockDict objectForKey:@"whsId"]integerValue];
    reportformView.wareHouseIndex = 0;
    
    
    
    
    reportformView.frozenviewIndex = 0;
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
//        }else{
//            RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
//            NSMutableArray * warehouseArray = [db getAllContent:@"SL"];
//            for (int i = 0; i < warehouseArray.count; i++) {
//                 RSWarehouseModel * warehousemodel = warehouseArray[i];
//                if ([warehousemodel.name isEqualToString:wareHouseView]) {
//                    [weakSelf.blockDict setObject:warehousemodel.name forKey:@"whsName"];
//                    [weakSelf.blockDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID] forKey:@"whsId"];
//                    break;
//                }
//            }
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
    //MenuView *menu = [[MenuView alloc]initWithDependencyView:self.view MenuView:demo isShowCoverView:YES];
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
    return self.runningDetialArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSSLRunningDetialModel * balancemodel = self.runningDetialArray[indexPath.row];
    if (balancemodel.isbool == false){
        return 109;
    }else{
        return 109 + (balancemodel.contentArr.count * 44) + 15;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIdentifier = [NSString stringWithFormat:@"RUNDETAILACCOUNT%ld",(long)indexPath.row];
    RSSLRunOpenCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[RSSLRunOpenCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.tag = indexPath.row;
    cell.delegate = self;
    
    if ([self.btnType isEqualToString:@"new"]) {
        cell.accountOpenImageView.transform = CGAffineTransformIdentity;
        cell.bottomBtn.selected = NO;
    }
    
    //RSBalanceModel * balancemodel = self.runArray[indexPath.row];
    RSSLRunningDetialModel * balancemodel = self.runningDetialArray[indexPath.row];
    cell.balancemodel = balancemodel;
    cell.bottomBtn.tag = indexPath.row;
    [cell.bottomBtn addTarget:self action:@selector(openMemberView:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSMutableArray *)openReloadNewData:(RSSLRunningDetialModel *)balancemodel{
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
    [network getDataWithUrlString:URL_SLFLOWACCOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
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
    RSSLRunningDetialModel * balancemodel = self.runningDetialArray[bottomBtn.tag];
    RSSLRunOpenCell * cell = (RSSLRunOpenCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:bottomBtn.tag inSection:0]];
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



- (void)runningReloadNewData{
    [self.blockDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    self.btnType = @"new";
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"PIECE" forKey:@"type"];
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
                [weakSelf.runningDetialArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSSLRunningDetialModel * slruningdetailModel = [[RSSLRunningDetialModel alloc]init];
                    slruningdetailModel.billCount = [[[array objectAtIndex:i]objectForKey:@"billCount"] integerValue];
                    
                     slruningdetailModel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                     slruningdetailModel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    slruningdetailModel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slruningdetailModel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slruningdetailModel.slNo = [[array objectAtIndex:i]objectForKey:@"slNo"];
                     slruningdetailModel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    slruningdetailModel.isbool = false;
                    [weakSelf.runningDetialArray addObject:slruningdetailModel];
                }
                if (weakSelf.runningDetialArray.count > 0) {
                    _centerView.hidden = YES;
                }else{
                    _centerView.hidden = NO;
                }
                self.pageNum = 2;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                if (weakSelf.runningDetialArray.count > 0) {
                    _centerView.hidden = YES;
                }else{
                    _centerView.hidden = NO;
                }
                
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            if (weakSelf.runningDetialArray.count > 0) {
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
    [phoneDict setObject:@"PIECE" forKey:@"type"];
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
                    RSSLRunningDetialModel * slruningdetailModel = [[RSSLRunningDetialModel alloc]init];
                    slruningdetailModel.billCount = [[[array objectAtIndex:i]objectForKey:@"billCount"] integerValue];
                    
                    slruningdetailModel.did = [[[array objectAtIndex:i]objectForKey:@"did"] integerValue];
                    slruningdetailModel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    slruningdetailModel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slruningdetailModel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slruningdetailModel.slNo = [[array objectAtIndex:i]objectForKey:@"slNo"];
                    slruningdetailModel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    slruningdetailModel.isbool = false;
                    [tempArray addObject:slruningdetailModel];
                }
                
                [weakSelf.runningDetialArray addObjectsFromArray:tempArray];
                if (weakSelf.runningDetialArray.count > 0) {
                    _centerView.hidden = YES;
                }else{
                    _centerView.hidden = NO;
                }
                
                self.pageNum++;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
            }else{
                if (weakSelf.runningDetialArray.count > 0) {
                    _centerView.hidden = YES;
                }else{
                    _centerView.hidden = NO;
                }
                
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            if (weakSelf.runningDetialArray.count > 0) {
                _centerView.hidden = YES;
            }else{
                _centerView.hidden = NO;
            }
            
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
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
    RSSLRunningDetialModel * balancemodel = self.runningDetialArray[cellIndex];
    RSAccountDetailModel * accountdetailmodel = balancemodel.contentArr[index];
    
    RSAccountAlertView * accountAlertView = [[RSAccountAlertView alloc]init];
    accountAlertView.accountDetailmodel = accountdetailmodel;
    //这边要弹窗
    if ([accountdetailmodel.billType isEqualToString:@"BILL_SL_CGRK"] || [accountdetailmodel.billType isEqualToString:@"BILL_SL_JGRK"] || [accountdetailmodel.billType isEqualToString:@"BILL_SL_PYRK"] || [accountdetailmodel.billType isEqualToString:@"BILL_SL_XSCK"] || [accountdetailmodel.billType isEqualToString:@"BILL_SL_JGCK"] || [accountdetailmodel.billType isEqualToString:@"BILL_SL_PKCK"]) {
        accountAlertView.frame = CGRectMake(32, SCH/2 - 170, SCW - 64, 340);
    }else if ([accountdetailmodel.billType isEqualToString:@"BILL_SL_DB"]){
        accountAlertView.frame = CGRectMake(32, SCH/2 - 96.5, SCW - 64, 193);
    }else if ([accountdetailmodel.billType isEqualToString:@"BILL_SL_YCCL"]){
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
