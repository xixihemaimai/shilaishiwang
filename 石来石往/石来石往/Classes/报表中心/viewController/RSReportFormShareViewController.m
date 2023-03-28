//
//  RSReportFormShareViewController.m
//  石来石往
//
//  Created by mac on 2020/2/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSReportFormShareViewController.h"
#import "RSPersonalWkWebviewViewController.h"
#import "RSRSBalanceDetialCell.h"


#import "RSReportFormShareBLModel.h"

@interface RSReportFormShareViewController ()
{
    
    UILabel * _totalVolmueDetailLabel;
    UILabel * _numberDetailLabel;
}


@property (nonatomic,assign)NSInteger pageNum;


@property (nonatomic,strong)NSMutableArray * detialArray;


@property (nonatomic,strong)NSMutableArray * selectArray;



@end

@implementation RSReportFormShareViewController
- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}


- (NSMutableArray *)detialArray{
    if (!_detialArray) {
        _detialArray = [NSMutableArray array];
    }
    return _detialArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}
static NSString * BALANCEdETAILCELL = @"REPORTMCELL";
- (void)viewDidLoad {
    [super viewDidLoad];
    

       self.pageNum = 2;
       UIButton * shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
       [shareBtn setTitle:@"分享预览" forState:UIControlStateNormal];
       [shareBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
       shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
       UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
       
       [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
       self.navigationItem.rightBarButtonItem = rightitem;
       
       if (@available(iOS 11.0, *)) {
           self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
           self.tableview.estimatedRowHeight = 0;
           self.tableview.estimatedSectionFooterHeight = 0;
           self.tableview.estimatedSectionHeaderHeight = 0;
       }
       
       
      // [self.tableview registerClass:[RSSelectiveInventoryCell class] forCellReuseIdentifier:BALANCEdETAILCELL];
       self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar - 43);
       self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#E6E6E6"];
       [self setUIBottomCustomView];
       
       
        [self selectiveNewData];
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      //  [weakSelf.blockDict setObject:@"1" forKey:@"pageNum"];
        [weakSelf selectiveNewData];
    }];
    
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf selectiveNewMoreData];
    }];
    
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf selectiveNewData];
//    }];
}

//FIXME:分享
- (void)shareBtnAction:(UIButton *)shareBtn{
    if (self.selectArray.count > 0) {
//        NSInteger totalNumber = 0;
//        NSDecimalNumber * totalArea;
//        double newVolume = 0.0;
//        NSMutableString * str = [NSMutableString string];
//        for (int i = 0; i < self.selectArray.count; i++) {
//            RSStoragemanagementModel * storagemanagementmodel = self.selectArray[i];
//            newVolume += [storagemanagementmodel.volume doubleValue];
//            totalNumber += storagemanagementmodel.qty;
//            if (i == 0) {
//                [str appendFormat:@"%@",[NSString stringWithFormat:@"%ld",storagemanagementmodel.did]];
//
//            }else{
//                [str appendFormat:@"%@",[NSString stringWithFormat:@",%ld",storagemanagementmodel.did]];
//            }
//
//        }
//        totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newVolume]];
        
        RSPersonalWkWebviewViewController * personalWkVc = [[RSPersonalWkWebviewViewController alloc]init];
        
        if ([self.title isEqualToString:@"荒料库存"]) {
             personalWkVc.pageType = 1;
        }else if ([self.title isEqualToString:@"荒料入库明细"]){
             personalWkVc.pageType = 3;
        }else{
            personalWkVc.pageType = 2;
        }
        personalWkVc.typeStr = self.title;
       // personalWkVc.title = self.selectFunctionType;
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        personalWkVc.VerifyKey = [user objectForKey:@"VERIFYKEY"];
        personalWkVc.appType = 1;
//        personalWkVc.webStr = @"http://117.29.162.206:8888/slsw/codeList.html";
        personalWkVc.webStr = [NSString stringWithFormat:@"%@slsw/codeList.html",URL_HEADER_TEXT_IOS];
        NSString * reportUrlStr = [NSString stringWithFormat:@"%@?appType=%ld&pageType=%ld", personalWkVc.webStr,personalWkVc.appType,personalWkVc.pageType];
        personalWkVc.ulrStr = reportUrlStr;
        personalWkVc.showT = 1;
        personalWkVc.selectArray = self.selectArray;
        
        [self.navigationController pushViewController:personalWkVc animated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请先去选择你需要分享的内容"];
    }
}


//底部视图
- (void)setUIBottomCustomView{
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, SCH - Height_NavBar - 43, SCW, 43)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:bottomview];
    [bottomview bringSubviewToFront:self.view];
    
    UIButton * totalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [totalBtn setTitle:@"合计" forState:UIControlStateNormal];
    totalBtn.frame = CGRectMake(0, 0, 61, 43);
    [totalBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FDAF1C"]];
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



- (void)selectiveNewData{
    NSString * urlTpye = [NSString string];
    if ([self.title isEqualToString:@"荒料库存"]) {
        urlTpye = URL_BMBALANCEDTL_IOS;
    }else if ([self.title isEqualToString:@"荒料入库明细"]){
        urlTpye = URL_BMINDTL_IOS;
    }else{
        urlTpye = URL_BMOUTDTL_IOS;
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setValue:self.usermodel.userID forKey:@"id"];
    [phoneDict setValue:[NSNumber numberWithInteger:1] forKey:@"nowpage"];
    [phoneDict setValue:[NSString stringWithFormat:@"10"] forKey:@"pagesize"];
//    [phoneDict setValue:applegate.ERPID forKey:@"erpId"];
    [phoneDict setValue:self.blockno forKey:@"blockno"];
    [phoneDict setValue:[NSNumber numberWithInteger:self.length] forKey:@"length"];
    [phoneDict setValue:[NSNumber numberWithInteger:self.lengthType] forKey:@"lengthType"];
    [phoneDict setValue:[NSNumber numberWithInteger:self.width] forKey:@"width"];
    [phoneDict setValue:[NSNumber numberWithInteger:self.widthType] forKey:@"widthType"];
    [phoneDict setValue:self.mtlname forKey:@"mtlname"];
    [phoneDict setValue:self.mtlnames forKey:@"mtlnames"];
    [phoneDict setValue:self.whsName forKey:@"whsName"];
    [phoneDict setValue:self.storeareaName forKey:@"storeareaName"];
    [phoneDict setValue:self.locationName forKey:@"locationName"];
    if ([self.title isEqualToString:@"荒料入库明细"] || [self.title isEqualToString:@"荒料出库明细"]) {
        [phoneDict setValue:self.datefrom forKey:@"datefrom"];
        [phoneDict setValue:self.Dateto forKey:@"dateto"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:urlTpye withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"Result"]boolValue];
            if (isresult) {
                [weakSelf.detialArray removeAllObjects];
                //NSMutableArray * array = [NSMutableArray array];
                weakSelf.detialArray = [RSReportFormShareBLModel mj_objectArrayWithKeyValuesArray:json[@"Data"][@"list"]];
                //array = json[@"data"][@"list"];
                //for (int i = 0; i < array.count; i++) {
                    // RSSelectiveInventoryModel  * selectiveinventorymodel = [[RSSelectiveInventoryModel alloc]init];
//                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
//                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"]integerValue];
//                    storagemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
//                    storagemanagementmodel.isfrozen = [[[array objectAtIndex:i]objectForKey:@"isfrozen"]integerValue];
//                    storagemanagementmodel.pwmsUserId = [[[array objectAtIndex:i]objectForKey:@"pwmsUserId"]integerValue];
//                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
//                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
//                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"]integerValue];
//                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
//                    storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
//                    storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
//                    storagemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"]integerValue];
//                    storagemanagementmodel.whsName = [[array objectAtIndex:i]objectForKey:@"whsName"];
//                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
//                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
//                    storagemanagementmodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
//                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
//                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
//                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
//                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
//                    storagemanagementmodel.selectedStutas = 0;
//                    [weakSelf.detialArray addObject:storagemanagementmodel];
//                }
                self.pageNum = 2;
                _numberDetailLabel.text = [NSString stringWithFormat:@"%ld颗",[json[@"Data"][@"sumlist"][@"totalqty"]integerValue]];
                _totalVolmueDetailLabel.text = [NSString stringWithFormat:@"%0.3lfm³",[json[@"Data"][@"sumlist"][@"totalvolume"] doubleValue]];
                
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview reloadData];
            }else{
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"MSG_CODE"]] preferredStyle:UIAlertControllerStyleAlert];
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
    NSString * urlTpye = [NSString string];
       if ([self.title isEqualToString:@"荒料库存"]) {
              urlTpye = URL_BMBALANCEDTL_IOS;
          }else if ([self.title isEqualToString:@"荒料入库明细"]){
              urlTpye = URL_BMINDTL_IOS;
          }else{
              urlTpye = URL_BMOUTDTL_IOS;
          }
       
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
     [phoneDict setValue:self.usermodel.userID forKey:@"id"];
        [phoneDict setValue:[NSNumber numberWithInteger:self.pageNum] forKey:@"nowpage"];
        [phoneDict setValue:[NSString stringWithFormat:@"10"] forKey:@"pagesize"];
    //    [phoneDict setValue:applegate.ERPID forKey:@"erpId"];
        [phoneDict setValue:self.blockno forKey:@"blockno"];
        [phoneDict setValue:[NSNumber numberWithInteger:self.length] forKey:@"length"];
        [phoneDict setValue:[NSNumber numberWithInteger:self.lengthType] forKey:@"lengthType"];
        [phoneDict setValue:[NSNumber numberWithInteger:self.width] forKey:@"width"];
        [phoneDict setValue:[NSNumber numberWithInteger:self.widthType] forKey:@"widthType"];
        [phoneDict setValue:self.mtlname forKey:@"mtlname"];
        [phoneDict setValue:self.mtlnames forKey:@"mtlnames"];
        [phoneDict setValue:self.whsName forKey:@"whsName"];
        [phoneDict setValue:self.storeareaName forKey:@"storeareaName"];
        [phoneDict setValue:self.locationName forKey:@"locationName"];
        if ([self.title isEqualToString:@"荒料入库明细"] || [self.title isEqualToString:@"荒料出库明细"]) {
            [phoneDict setValue:self.datefrom forKey:@"datefrom"];
            [phoneDict setValue:self.Dateto forKey:@"dateto"];
        }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:urlTpye withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"Result"]boolValue];
            if (isresult) {
                NSMutableArray * array = [NSMutableArray array];
//                NSMutableArray * tempArray = [NSMutableArray array];
                array = [RSReportFormShareBLModel mj_objectArrayWithKeyValuesArray:json[@"Data"][@"list"]];
                //array = json[@"data"][@"list"];
//                for (int i = 0; i < array.count; i++) {
//                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
//                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"]integerValue];
//                    storagemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
//                    storagemanagementmodel.isfrozen = [[[array objectAtIndex:i]objectForKey:@"isfrozen"]integerValue];
//                    storagemanagementmodel.pwmsUserId = [[[array objectAtIndex:i]objectForKey:@"pwmsUserId"]integerValue];
//                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
//                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
//                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"]integerValue];
//                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
//                    storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
//                    storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
//                    storagemanagementmodel.whsId = [[[array objectAtIndex:i]objectForKey:@"whsId"]integerValue];
//                    storagemanagementmodel.whsName = [[array objectAtIndex:i]objectForKey:@"whsName"];
//                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
//                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
//                    storagemanagementmodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
//                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
//                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
//                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
//                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
//                    storagemanagementmodel.selectedStutas = 0;
//                    [tempArray addObject:storagemanagementmodel];
//                }
                [weakSelf.detialArray addObjectsFromArray:array];
                self.pageNum++;
                _numberDetailLabel.text = [NSString stringWithFormat:@"%ld颗",[json[@"Data"][@"sumlist"][@"totalqty"] integerValue]];
                _totalVolmueDetailLabel.text = [NSString stringWithFormat:@"%0.3lfm³",[json[@"Data"][@"sumlist"][@"totalvolume"] doubleValue]];
               
                [weakSelf.tableview reloadData];
                 [weakSelf.tableview.mj_footer endRefreshing];
            }else{
                
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"MSG_CODE"]] preferredStyle:UIAlertControllerStyleAlert];
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




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detialArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 194;
    
    if ([self.title isEqualToString:@"荒料入库明细"] || [self.title isEqualToString:@"荒料出库明细"]){
        return 266;
    }else{
        return 194;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //self.cell = [tableView dequeueReusableCellWithIdentifier:SELECTIVECELLID];
    RSReportFormShareBLModel * reportFormShareBLmodel = self.detialArray[indexPath.row];
    RSRSBalanceDetialCell * cell = [tableView dequeueReusableCellWithIdentifier:BALANCEdETAILCELL];
    if (!cell) {
        cell = [[RSRSBalanceDetialCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:BALANCEdETAILCELL];
    }
//    if (storagemanagementmodel.isfrozen) {
//        cell.isfrozenImageView.hidden = NO;
//    }else{
        cell.isfrozenImageView.hidden = YES;
//    }
    [cell.selectBtn setImage:[UIImage imageNamed:@"选中3"] forState:UIControlStateSelected];
    cell.selectiveLabel.text = reportFormShareBLmodel.msid;
    CGSize size = [reportFormShareBLmodel.msid sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    cell.selectiveLabel.sd_layout
    .widthIs(size.width);
    cell.selectDetailNameLabel.text = reportFormShareBLmodel.mtlname;
    cell.selectDetailTypeLabel.text = reportFormShareBLmodel.materialtype;
    cell.selectDetailShapeLabel.text = [NSString stringWithFormat:@"%ld|%ld|%ld",reportFormShareBLmodel.lenght,reportFormShareBLmodel.width ,reportFormShareBLmodel.height];
    cell.selectDetailAreaLabel.text = [NSString stringWithFormat:@"%0.3lf",[reportFormShareBLmodel.volume doubleValue]];
    cell.selectDetailWightLabel.text = [NSString stringWithFormat:@"%0.3lf",[reportFormShareBLmodel.weight doubleValue]];
    
    if ([self.title isEqualToString:@"荒料入库明细"] || [self.title isEqualToString:@"荒料出库明细"]){
        if ([self.title isEqualToString:@"荒料出库明细"]){
            cell.storageTypeLabel.text = reportFormShareBLmodel.storageOutType;
            cell.billdateNameLabel.text = @"出库时间:";
            cell.storageTypeNameLabel.text = @"出库类型:";
            cell.whsnameNameLabel.text = @"出库仓库:";
        }else{
            cell.billdateNameLabel.text = @"入库时间:";
            cell.storageTypeNameLabel.text = @"入库类型:";
            cell.whsnameNameLabel.text = @"入库仓库:";
            cell.storageTypeLabel.text = reportFormShareBLmodel.storageType;
        }
        cell.billdateTimeLabel.text = [reportFormShareBLmodel.billdate substringToIndex:10];
        cell.whsnameLabel.text = reportFormShareBLmodel.whsname;
        cell.billdateNameLabel.hidden = false;
        cell.storageTypeNameLabel.hidden = false;
        cell.whsnameNameLabel.hidden = false;
        cell.billdateTimeLabel.hidden = false;
        cell.storageTypeLabel.hidden = false;
        cell.whsnameLabel.hidden = false;
    }else{
        cell.billdateNameLabel.hidden = true;
        cell.storageTypeNameLabel.hidden = true;
        cell.whsnameNameLabel.hidden = true;
        cell.billdateTimeLabel.hidden = true;
        cell.storageTypeLabel.hidden = true;
        cell.whsnameLabel.hidden = true;
    }
    cell.selectBtn.tag = indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(selectiveChoiceAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.selectArray.count > 0) {
        for (int i = 0; i < self.selectArray.count; i++) {
            RSReportFormShareBLModel * reportFormShareBLmodel1 = self.selectArray[i];
            if (reportFormShareBLmodel1.did == reportFormShareBLmodel.did) {
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
        RSReportFormShareBLModel * reportFormShareBLmodel = self.detialArray[selectBtn.tag];
        [self.selectArray addObject:reportFormShareBLmodel];
    }else{
        RSReportFormShareBLModel * reportFormShareBLmodel = self.detialArray[selectBtn.tag];
        for (int i = 0; i < self.selectArray.count; i++) {
            RSReportFormShareBLModel * reportFormShareBLmodel1 = self.selectArray[i];
            if (reportFormShareBLmodel1.did == reportFormShareBLmodel.did) {
                [self.selectArray removeObjectAtIndex:i];
            }
        }
    }
}


@end
