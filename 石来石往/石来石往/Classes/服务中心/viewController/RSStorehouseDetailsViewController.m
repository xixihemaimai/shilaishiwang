//
//  RSStorehouseDetailsViewController.m
//  石来石往
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSStorehouseDetailsViewController.h"
#import "RSRecordHeaderView.h"

#import "RSStorehouseDetailFirstCell.h"
#import "RSStorehouseDetailSecondCell.h"
#import "RSStorehouseDetailThirdCell.h"
#import "RSRecordSecondCell.h"
#import "RSRecordCell.h"
//模型
#import "RSStoreHouseDetailModel.h"
#import "RSStorehouseDetailBolocksModel.h"


#import "RSPersonalServiceViewController.h"


@interface RSStorehouseDetailsViewController ()

//@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,strong)NSMutableArray * allArray;

@end

@implementation RSStorehouseDetailsViewController

- (NSMutableArray *)allArray{
    
    if (_allArray == nil) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"出库服务";
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self isAddjust];
///    if ([[self.navigationController.viewControllers objectAtIndex:1]class] == [RSPersonalServiceViewController class]) {
    [self loadPersonlServiceOutData];
//    }else{
//        [self loadStoreHouseDetailsData];
//    }
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//        UITableView.appearance.estimatedRowHeight = 0;
//        UITableView.appearance.estimatedSectionFooterHeight = 0;
//        UITableView.appearance.estimatedSectionHeaderHeight = 0;
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}


- (void)addStorehouseDetailCustomTableview{
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStyleGrouped];
//    self.tableview = tableview;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    self.tableview.showsHorizontalScrollIndicator = NO;
//    self.tableview.showsVerticalScrollIndicator = NO;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar);
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, Height_NavBar, 0);
   
    
    
    RSWeakself
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        if ([[weakSelf.navigationController.viewControllers objectAtIndex:1]class] == [RSPersonalServiceViewController class]) {
            [weakSelf loadPersonlServiceOutData];
//        }else{
//            [weakSelf loadStoreHouseDetailsData];
//        }
    }];
    
    
}



- (void)loadStoreHouseDetailsData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    [dict setObject:self.serviceId forKey:@"serviceId"];
    [dict setObject:self.type forKey:@"type"];
    [dict setObject:self.search forKey:@"search"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SERVICESEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = [NSMutableArray array];
                [weakSelf.allArray removeAllObjects];
                array = json[@"Data"];
                for (int i = 0; i < array.count; i++) {
                    RSStoreHouseDetailModel * storeHouseDetailmodel = [[RSStoreHouseDetailModel alloc]init];
                    storeHouseDetailmodel.appointTime = [[array objectAtIndex:i]objectForKey:@"appointTime"];
                    storeHouseDetailmodel.commentTime = [[array objectAtIndex:i]objectForKey:@"commentTime"];
                    storeHouseDetailmodel.csnIden = [[array objectAtIndex:i]objectForKey:@"csnIden"];
                    storeHouseDetailmodel.outType = [[array objectAtIndex:i]objectForKey:@"outType"];
                    storeHouseDetailmodel.csnName = [[array objectAtIndex:i]objectForKey:@"csnName"];
                    storeHouseDetailmodel.csnPhone = [[array objectAtIndex:i]objectForKey:@"csnPhone"];
                    storeHouseDetailmodel.dispatchTime = [[array objectAtIndex:i]objectForKey:@"dispatchTime"];
                    storeHouseDetailmodel.endTime = [[array objectAtIndex:i]objectForKey:@"endTime"];
                    storeHouseDetailmodel.orgName = [[array objectAtIndex:i]objectForKey:@"orgName"];
                    storeHouseDetailmodel.outBoundNo = [[array objectAtIndex:i]objectForKey:@"outBoundNo"];
                    storeHouseDetailmodel.carType = [[array objectAtIndex:i]objectForKey:@"carType"];
                    storeHouseDetailmodel.phone = [[array objectAtIndex:i]objectForKey:@"phone"];
                    storeHouseDetailmodel.sendTime = [[array objectAtIndex:i]objectForKey:@"sendTime"];
                    storeHouseDetailmodel.serviceComment = [[array objectAtIndex:i]objectForKey:@"serviceComment"];
                    storeHouseDetailmodel.serviceId = [[array objectAtIndex:i]objectForKey:@"serviceId"];
                    storeHouseDetailmodel.serviceKind = [[array objectAtIndex:i]objectForKey:@"serviceKind"];
                    storeHouseDetailmodel.serviceThing = [[array objectAtIndex:i]objectForKey:@"serviceThing"];
                    storeHouseDetailmodel.serviceTime = [[array objectAtIndex:i]objectForKey:@"serviceTime"];
                    storeHouseDetailmodel.starLevel = [[array objectAtIndex:i]objectForKey:@"starLevel"];
                    NSMutableArray * bolocksTempArray = [NSMutableArray array];
                    bolocksTempArray = [[array objectAtIndex:i]objectForKey:@"bolcks"];
                    NSMutableArray * bolocksArray = [NSMutableArray array];
                    storeHouseDetailmodel.img = [[array objectAtIndex:i]objectForKey:@"img"];
                    for ( int j = 0; j < bolocksTempArray.count; j++) {
                        RSStorehouseDetailBolocksModel * storehouseDetailBolocksmodel = [[RSStorehouseDetailBolocksModel alloc]init];
                        storehouseDetailBolocksmodel.blockNo = [[bolocksTempArray objectAtIndex:j]objectForKey:@"blockNo"];
                        storehouseDetailBolocksmodel.blockName = [[bolocksTempArray objectAtIndex:j]objectForKey:@"blockName"];
                        storehouseDetailBolocksmodel.blockNum = [[bolocksTempArray objectAtIndex:j]objectForKey:@"blockNum"];
                        storehouseDetailBolocksmodel.blockTurns = [[bolocksTempArray objectAtIndex:j]objectForKey:@"blockTurns"];
                        [bolocksArray addObject:storehouseDetailBolocksmodel];
                    }
                    storeHouseDetailmodel.bolcks = bolocksArray;
                    [weakSelf.allArray addObject:storeHouseDetailmodel];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addStorehouseDetailCustomTableview];
                    [weakSelf.tableview reloadData];
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"加载失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
}

- (void)loadPersonlServiceOutData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.status forKey:@"status"];
    [dict setObject:self.serviceId forKey:@"serviceId"];
    [dict setObject:self.type forKey:@"type"];
    [dict setObject:self.search forKey:@"search"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_PERSONLSEARCHSERVICEFORWAITER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
             
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = [NSMutableArray array];
                [weakSelf.allArray removeAllObjects];
                array = json[@"Data"];
                
               
                for (int i = 0; i < array.count; i++) {
                    RSStoreHouseDetailModel * storeHouseDetailmodel = [[RSStoreHouseDetailModel alloc]init];
                    storeHouseDetailmodel.appointTime = [[array objectAtIndex:i]objectForKey:@"appointTime"];
                    storeHouseDetailmodel.commentTime = [[array objectAtIndex:i]objectForKey:@"commentTime"];
                    storeHouseDetailmodel.csnIden = [[array objectAtIndex:i]objectForKey:@"csnIden"];
                    storeHouseDetailmodel.csnName = [[array objectAtIndex:i]objectForKey:@"csnName"];
                    storeHouseDetailmodel.csnPhone = [[array objectAtIndex:i]objectForKey:@"csnPhone"];
                    storeHouseDetailmodel.carType = [[array objectAtIndex:i]objectForKey:@"carType"];
                    storeHouseDetailmodel.dispatchTime = [[array objectAtIndex:i]objectForKey:@"dispatchTime"];
                    storeHouseDetailmodel.endTime = [[array objectAtIndex:i]objectForKey:@"endTime"];
                    storeHouseDetailmodel.orgName = [[array objectAtIndex:i]objectForKey:@"orgName"];
                    storeHouseDetailmodel.outBoundNo = [[array objectAtIndex:i]objectForKey:@"outBoundNo"];
                    storeHouseDetailmodel.phone = [[array objectAtIndex:i]objectForKey:@"phone"];
                    storeHouseDetailmodel.sendTime = [[array objectAtIndex:i]objectForKey:@"sendTime"];
                    storeHouseDetailmodel.serviceComment = [[array objectAtIndex:i]objectForKey:@"serviceComment"];
                    storeHouseDetailmodel.serviceId = [[array objectAtIndex:i]objectForKey:@"serviceId"];
                    storeHouseDetailmodel.serviceKind = [[array objectAtIndex:i]objectForKey:@"serviceKind"];
                    storeHouseDetailmodel.serviceThing = [[array objectAtIndex:i]objectForKey:@"serviceThing"];
                    storeHouseDetailmodel.serviceTime = [[array objectAtIndex:i]objectForKey:@"serviceTime"];
                    storeHouseDetailmodel.starLevel = [[array objectAtIndex:i]objectForKey:@"starLevel"];
                    storeHouseDetailmodel.outType = [[array objectAtIndex:i]objectForKey:@"outType"];
                    NSMutableArray * bolocksTempArray = [NSMutableArray array];
                    bolocksTempArray = [[array objectAtIndex:i]objectForKey:@"bolcks"];
                    NSMutableArray * bolocksArray = [NSMutableArray array];
                    storeHouseDetailmodel.img = [[array objectAtIndex:i]objectForKey:@"img"];
                    for ( int j = 0; j < bolocksTempArray.count; j++) {
                        RSStorehouseDetailBolocksModel * storehouseDetailBolocksmodel = [[RSStorehouseDetailBolocksModel alloc]init];
                        storehouseDetailBolocksmodel.blockNo = [[bolocksTempArray objectAtIndex:j]objectForKey:@"blockNo"];
                        storehouseDetailBolocksmodel.blockName = [[bolocksTempArray objectAtIndex:j]objectForKey:@"blockName"];
                        storehouseDetailBolocksmodel.blockNum = [[bolocksTempArray objectAtIndex:j]objectForKey:@"blockNum"];
                        storehouseDetailBolocksmodel.blockTurns = [[bolocksTempArray objectAtIndex:j]objectForKey:@"blockTurns"];
                        storehouseDetailBolocksmodel.locationName = [[bolocksTempArray objectAtIndex:j]objectForKey:@"locationName"];
                        storehouseDetailBolocksmodel.turnsNo = [[bolocksTempArray objectAtIndex:j]objectForKey:@"turnsNo"];
                        [bolocksArray addObject:storehouseDetailBolocksmodel];
                    }
                    storeHouseDetailmodel.bolcks = bolocksArray;
                    [weakSelf.allArray addObject:storeHouseDetailmodel];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addStorehouseDetailCustomTableview];
                    [weakSelf.tableview reloadData];
                });
            }else{
                 [SVProgressHUD showErrorWithStatus:@"加载失败"];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else{
        RSStoreHouseDetailModel * storeHouseDetailmodel = self.allArray[0];
        return storeHouseDetailmodel.bolcks.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RSStoreHouseDetailModel * storeHouseDetailmodel = self.allArray[0];
    RSStorehouseDetailBolocksModel *  storehouseDetailBolocksmodel = storeHouseDetailmodel.bolcks[indexPath.row];
    if (indexPath.section == 0) {
        static NSString * STOREHOUSEDETAILFIRSTID = @"STOREHOUSEDETAILFIRSTID";
        RSStorehouseDetailFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:STOREHOUSEDETAILFIRSTID];
        if (!cell) {
            cell = [[RSStorehouseDetailFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:STOREHOUSEDETAILFIRSTID];
        }
        cell.companyName.text = [NSString stringWithFormat:@"名称:%@",storeHouseDetailmodel.orgName];
      //  cell.companyPhoneNam.text = [NSString stringWithFormat:@"电话号码:%@",storeHouseDetailmodel.phone];
        
       // cell.companyPhoneBtn.tag = indexPath.row + 10000000;
        [cell.companyPhoneBtn setTitle:[NSString stringWithFormat:@"电话号码:%@",storeHouseDetailmodel.phone] forState:UIControlStateNormal];
        [cell.companyPhoneBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        [cell.companyPhoneBtn addTarget:self action:@selector(choicePlayPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        static NSString * STOREHOUSEDETAILSECONDID = @"STOREHOUSEDETAILSECONDID";
        RSStorehouseDetailSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:STOREHOUSEDETAILSECONDID];
        if (!cell) {
            cell = [[RSStorehouseDetailSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:STOREHOUSEDETAILSECONDID];
        }
        
        cell.outNameLabel.text = [NSString stringWithFormat:@"出单号:%@",storeHouseDetailmodel.outBoundNo];
         cell.outNumber.text = [NSString stringWithFormat:@"颗数:%ld颗",(long)storeHouseDetailmodel.bolcks.count];
        cell.outTimeLabel.text = [NSString stringWithFormat:@"预约时间:%@",storeHouseDetailmodel.appointTime];
        
        
        
        if ([storeHouseDetailmodel.carType  isEqualToString:@"dt"]) {
            cell.carTypeLabel.text = [NSString stringWithFormat:@"汽车类型:短途车"];
        }else if ([storeHouseDetailmodel.carType isEqualToString:@"ct"]){
            cell.carTypeLabel.text = [NSString stringWithFormat:@"汽车类型:长途车"];
        }else if ([storeHouseDetailmodel.carType isEqualToString:@"hg"]){
             cell.carTypeLabel.text = [NSString stringWithFormat:@"汽车类型:货柜"];
        }else if ([storeHouseDetailmodel.carType isEqualToString:@"qt"]){
             cell.carTypeLabel.text = [NSString stringWithFormat:@"汽车类型:其他"];
        }
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (indexPath.section == 2){
        static NSString * STOREHOUSEDETAILTHIRDID = @"STOREHOUSEDETAILTHIRDID";
        RSStorehouseDetailThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:STOREHOUSEDETAILTHIRDID];
        if (!cell) {
            cell = [[RSStorehouseDetailThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:STOREHOUSEDETAILTHIRDID];
        }
        cell.personLabel.text = [NSString stringWithFormat:@"名字:%@",storeHouseDetailmodel.csnName];
        
        [cell.personPhoneBtn setTitle:[NSString stringWithFormat:@"电话号码:%@",storeHouseDetailmodel.csnPhone] forState:UIControlStateNormal];
        
        cell.personPhoneBtn.tag = 10000+ indexPath.row;
        [cell.personPhoneBtn addTarget:self action:@selector(servicePlayPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
//        if ([[self.navigationController.viewControllers objectAtIndex:1]class] == [RSPersonalServiceViewController class]){
//
//
//        }else{
//            cell.personCardLabel.text = [NSString stringWithFormat:@"身份证号:%@",storeHouseDetailmodel.csnIden];
//        }
//
        
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        //荒料
        if ([storeHouseDetailmodel.outType isEqualToString:@"BL"]) {
            static NSString * BLSTOREHOUSEDETAILRECORDID = @"BLSTOREHOUSEDETAILRECORDID";
            RSRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:BLSTOREHOUSEDETAILRECORDID];
            if (!cell) {
                cell = [[RSRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:BLSTOREHOUSEDETAILRECORDID];
            }
            cell.detailNameLabel.text = [NSString stringWithFormat:@"%@",storehouseDetailBolocksmodel.blockName];
            cell.detailHuangliaoLabel.text = [NSString stringWithFormat:@"%@",storehouseDetailBolocksmodel.blockNo];
            cell.detailTiLabel.text = [NSString stringWithFormat:@"%@m³",storehouseDetailBolocksmodel.blockNum];
            [cell.paiBtn setTitle:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1] forState:UIControlStateNormal];
            
            cell.locationDetailLabel.text = [NSString stringWithFormat:@"%@",storehouseDetailBolocksmodel.locationName];
         
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
            static NSString * STOREHOUSEDETAILRECORDID = @"STOREHOUSEDETAILRECORDID";
            RSRecordSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:STOREHOUSEDETAILRECORDID];
            if (!cell) {
                cell = [[RSRecordSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:STOREHOUSEDETAILRECORDID];
            }
            cell.detailNameLabel.text = [NSString stringWithFormat:@"%@",storehouseDetailBolocksmodel.blockName];
            cell.detailHuangliaoLabel.text = [NSString stringWithFormat:@"%@",storehouseDetailBolocksmodel.blockNo];
            cell.detailZaLabel.text = [NSString stringWithFormat:@"%@片",storehouseDetailBolocksmodel.blockTurns];
            cell.detailAreaLabel.text = [NSString stringWithFormat:@"%@m²",storehouseDetailBolocksmodel.blockNum];
            [cell.paiBtn setTitle:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1] forState:UIControlStateNormal];
            cell.locationDetailLabel.text = [NSString stringWithFormat:@"%@",storehouseDetailBolocksmodel.locationName];
            cell.turnDetailLabel.text = [NSString stringWithFormat:@"%@",storehouseDetailBolocksmodel.turnsNo];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else if (indexPath.section == 1){
        return 105;
    }else if (indexPath.section == 2){
//        if ([[self.navigationController.viewControllers objectAtIndex:1]class] == [RSPersonalServiceViewController class]){
            return 60;
//        }else{
//            return 80;
//        }
    }else{
        RSStoreHouseDetailModel * storeHouseDetailmodel = self.allArray[0];
        if ([storeHouseDetailmodel.outType isEqualToString:@"BL"]) {
            return 96;
        }else{
            return 131;
        }
    }
}


static NSString * STOREHOUSEDETAILID = @"STOREHOUSEDETAILID";
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSRecordHeaderView * headerview = [[RSRecordHeaderView alloc]initWithReuseIdentifier:STOREHOUSEDETAILID];
    if (section == 0) {
        headerview.productLabel.text = @"服务公司";
    }else if (section == 1){
        headerview.productLabel.text = @"订单详情";
    }else if (section == 2){
        headerview.productLabel.text = @"提货人";
    }else{
        headerview.productLabel.text = @"货物详情";
    }
    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)servicePlayPhoneAction:(UIButton *)btn{
    RSStoreHouseDetailModel * storeHouseDetailmodel = self.allArray[btn.tag - 10000];
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",storeHouseDetailmodel.csnPhone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}


#pragma mark --- 组一要打电话
- (void)choicePlayPhoneAction:(UIButton *)playBtn{
    
    RSStoreHouseDetailModel * storeHouseDetailmodel = self.allArray[0];
//    RSStorehouseDetailBolocksModel *  storehouseDetailBolocksmodel = storeHouseDetailmodel.bolcks[playBtn.tag - 10000000];
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",storeHouseDetailmodel.phone];
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
