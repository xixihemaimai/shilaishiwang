//
//  RSRawDetailNewViewController.m
//  石来石往
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSRawDetailNewViewController.h"
#import "RSRawMaterialCell.h"
#import "RSPersonalWkWebviewViewController.h"
@interface RSRawDetailNewViewController ()

{
    
    UILabel * _totalVolmueDetailLabel;
    UILabel * _numberDetailLabel;
}


@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * detialArray;


@property (nonatomic,strong)NSMutableArray * selectArray;

@end

@implementation RSRawDetailNewViewController

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



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.selectFunctionType;
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
    
    [self setUIBottomCustomView];
    
    
    [self selectiveNewData];
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.blockDict setObject:@"1" forKey:@"pageNum"];
        [weakSelf selectiveNewData];
    }];
    
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf selectiveNewMoreData];
    }];
    
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
        [weakSelf selectiveNewData];
    }];
    
    
}


//FIXME:分享
- (void)shareBtnAction:(UIButton *)shareBtn{
    if (self.selectArray.count > 0) {
        NSInteger totalNumber = 0;
        NSDecimalNumber * totalArea;
        double newVolume = 0.0;
        NSMutableString * str = [NSMutableString string];
        for (int i = 0; i < self.selectArray.count; i++) {
            //dids
            RSStoragemanagementModel * storagemanagementmodel = self.selectArray[i];
            newVolume += [storagemanagementmodel.volume doubleValue];
            totalNumber += storagemanagementmodel.qty;
            if (i == 0) {
                [str appendFormat:@"%@",[NSString stringWithFormat:@"%ld",storagemanagementmodel.did]];
                
            }else{
                [str appendFormat:@"%@",[NSString stringWithFormat:@",%ld",storagemanagementmodel.did]];
            }
        }
        
        totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newVolume]];
        
        RSPersonalWkWebviewViewController * personalWkVc = [[RSPersonalWkWebviewViewController alloc]init];
        personalWkVc.typeStr = @"码单分享";
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        personalWkVc.VerifyKey = [user objectForKey:@"VERIFYKEY"];
        personalWkVc.appType = 1;
         personalWkVc.title = self.selectFunctionType;
        if (self.searchTypeIndex == 1) {
             personalWkVc.pageType =2;
            
        }else{
             personalWkVc.pageType = 3;
        }
        
       
        //体积
        //片数
        personalWkVc.dateFrom = [self.blockDict objectForKey:@"dateFrom"];
        personalWkVc.dateTo = [self.blockDict objectForKey:@"dateTo"];
        personalWkVc.mtlName = [self.blockDict objectForKey:@"mtlName"];
        personalWkVc.mtlId = [[self.blockDict objectForKey:@"mtlId"] integerValue];
        personalWkVc.blockNo = [self.blockDict objectForKey:@"blockNo"];
        personalWkVc.whsName = [self.blockDict objectForKey:@"whsName"];
        personalWkVc.storageType = [self.blockDict objectForKey:@"storageType"];
        personalWkVc.whsId = [[self.blockDict objectForKey:@"whsId"] integerValue];
        personalWkVc.isFrozen = [[self.blockDict objectForKey:@"isFrozen"]integerValue];
        personalWkVc.lengthType = [[self.blockDict objectForKey:@"lengthType"]integerValue];
        personalWkVc.widthType = [[self.blockDict objectForKey:@"widthType"]integerValue];
        personalWkVc.length = [self.blockDict objectForKey:@"length"];
        personalWkVc.width = [self.blockDict objectForKey:@"width"];
        
        //personalWkVc.webStr = @"http://117.29.162.206:8888/slsw/pwms/codeList.html";
        
        personalWkVc.webStr = [NSString stringWithFormat:@"%@slsw/pwms/codeList.html",URL_HEADER_TEXT_IOS];
        
        NSString * reportUrlStr = [NSString stringWithFormat:@"%@?appType=%ld&userId=%@&VerifyKey=%@&pageType=%ld&totalQty=%ld&totalVaQty=%@&dateFrom=%@&dateTo=%@&mtlName=%@&mtlId=%ld&blockNo=%@&whsName=%@&storageType=%@&whsId=%ld&isFrozen=%ld&lengthType=%ld&widthType=%ld&length=%@&width=%@&dids=%@&companyName=%@&pwmsUserId=%ld", personalWkVc.webStr,personalWkVc.appType,self.usermodel.userID,personalWkVc.VerifyKey, personalWkVc.pageType,totalNumber, totalArea,personalWkVc.dateFrom,personalWkVc.dateTo,personalWkVc.mtlName,personalWkVc.mtlId,personalWkVc.blockNo,personalWkVc.whsName,personalWkVc.storageType,personalWkVc.whsId,personalWkVc.isFrozen,personalWkVc.lengthType,personalWkVc.widthType,personalWkVc.length, personalWkVc.width,str,self.usermodel.pwmsUser.companyName,self.usermodel.pwmsUser.parentId];
        personalWkVc.ulrStr = reportUrlStr;
        [self.navigationController pushViewController:personalWkVc animated:YES];
        
        
    }else{
        [SVProgressHUD showInfoWithStatus:@"请先去选择你需要分享的内容"];
    }
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



- (void)selectiveNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"DETAIL" forKey:@"type"];
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
                [weakSelf.detialArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"]integerValue];
                    storagemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                    storagemanagementmodel.billType = [[array objectAtIndex:i]objectForKey:@"billType"];
                   // storagemanagementmodel.isfrozen = [[[array objectAtIndex:i]objectForKey:@"isfrozen"]integerValue];
                    storagemanagementmodel.pwmsUserId = [[[array objectAtIndex:i]objectForKey:@"pwmsUserId"]integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"]integerValue];
                    
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    
                   // storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
                    storagemanagementmodel.billDate = [[array objectAtIndex:i]objectForKey:@"billDate"];
                    
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
                    [weakSelf.detialArray addObject:storagemanagementmodel];
                }
                weakSelf.pageNum = 2;
                _numberDetailLabel.text = [NSString stringWithFormat:@"%ld颗",[json[@"data"][@"total"][@"totalQty"]integerValue]];
                _totalVolmueDetailLabel.text = [NSString stringWithFormat:@"%0.3lfm³",[json[@"data"][@"total"][@"totalVaQty"] doubleValue]];
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
                
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
                NSMutableArray * tempArray = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.did = [[[array objectAtIndex:i]objectForKey:@"did"]integerValue];
                    storagemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                    
                    
                     storagemanagementmodel.billType = [[array objectAtIndex:i]objectForKey:@"billType"];
//                    storagemanagementmodel.isfrozen = [[[array objectAtIndex:i]objectForKey:@"isfrozen"]integerValue];
                    storagemanagementmodel.pwmsUserId = [[[array objectAtIndex:i]objectForKey:@"pwmsUserId"]integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"]integerValue];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.storageType = [[array objectAtIndex:i]objectForKey:@"storageType"];
                    
                      storagemanagementmodel.billDate = [[array objectAtIndex:i]objectForKey:@"billDate"];
                  //  storagemanagementmodel.receiptDate = [[array objectAtIndex:i]objectForKey:@"receiptDate"];
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
                    [tempArray addObject:storagemanagementmodel];
                }
                [weakSelf.detialArray addObjectsFromArray:tempArray];
               
                _numberDetailLabel.text = [NSString stringWithFormat:@"%ld颗",[json[@"data"][@"total"][@"totalQty"]integerValue]];
                _totalVolmueDetailLabel.text = [NSString stringWithFormat:@"%0.3lfm³",[json[@"data"][@"total"][@"totalVaQty"] doubleValue]];
                
                 weakSelf.pageNum++;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
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
    return 266;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //self.cell = [tableView dequeueReusableCellWithIdentifier:SELECTIVECELLID];
    RSStoragemanagementModel * storagemanagementmodel = self.detialArray[indexPath.row];
//    if (storagemanagementmodel.isfrozen) {
//        cell.selectBtn.hidden = YES;
//        cell.isfrozenLabel.hidden = NO;
//        cell.selectBtn.enabled = NO;
//    }else{
//        cell.isfrozenLabel.hidden = YES;
//        cell.selectBtn.hidden = NO;
//        cell.selectBtn.enabled = YES;
//    }
//    cell.selectiveLabel.text = storagemanagementmodel.blockNo;
//    cell.selectDetailNameLabel.text = storagemanagementmodel.mtlName;
//    cell.selectDetailTypeLabel.text = storagemanagementmodel.mtltypeName;
//    cell.selectDetailShapeLabel.text = [NSString stringWithFormat:@"%0.1lf|%0.1lf|%0.1lf",[storagemanagementmodel.length doubleValue],[storagemanagementmodel.width doubleValue],[storagemanagementmodel.height doubleValue]];
//    cell.selectDetailAreaLabel.text = [NSString stringWithFormat:@"%0.3lf",[storagemanagementmodel.volume doubleValue]];
//    cell.selectDetailWightLabel.text = [NSString stringWithFormat:@"%0.3lf",[storagemanagementmodel.weight doubleValue]];
//    cell.selectBtn.tag = indexPath.row;
//    [cell.selectBtn addTarget:self action:@selector(selectiveChoiceAction:) forControlEvents:UIControlEventTouchUpInside];
//    if (self.selectArray.count > 0) {
//        for (int i = 0; i < self.selectArray.count; i++) {
//            RSStoragemanagementModel * storagemanagementmodel1 = self.selectArray[i];
//            if (storagemanagementmodel1.did == storagemanagementmodel.did) {
//                cell.selectBtn.selected = YES;
//                break;
//            }else{
//                cell.selectBtn.selected = false;
//            }
//        }
//    }
//    else{
//        cell.selectBtn.selected = false;
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
    
    static NSString * RAWDETAILMATERCELLID = @"RAWDETAILMATERCELLID";
    RSRawMaterialCell * cell = [tableView dequeueReusableCellWithIdentifier:RAWDETAILMATERCELLID];
    if (!cell) {
        cell = [[RSRawMaterialCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RAWDETAILMATERCELLID];
    }
    cell.selectiveLabel.text = storagemanagementmodel.blockNo;
    cell.selectDetailNameLabel.text = storagemanagementmodel.mtlName;
    cell.selectDetailTypeLabel.text = storagemanagementmodel.mtltypeName;
    cell.selectDetailShapeLabel.text = [NSString stringWithFormat:@"%0.1lf|%0.1lf|%0.1lf",[storagemanagementmodel.length doubleValue],[storagemanagementmodel.width doubleValue],[storagemanagementmodel.height doubleValue]];
    cell.selectDetailAreaLabel.text = [NSString stringWithFormat:@"%0.3lf",[storagemanagementmodel.volume doubleValue]];
    cell.selectDetailWightLabel.text = [NSString stringWithFormat:@"%0.3lf",[storagemanagementmodel.weight doubleValue]];
    cell.selectBtn.tag = indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(selectiveChoiceAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.searchTypeIndex == 1) {
        //入库
        cell.timeLabel.text = @"入库日期";
        cell.typeLabel.text = @"入库类型";
        cell.typeLabel.text = @"入库仓库";
        if ([storagemanagementmodel.billType isEqualToString:@"BILL_BL_CGRK"]) {
            cell.typeDetialLabel.text = @"采购入库";
        }else if ([storagemanagementmodel.billType isEqualToString:@"BILL_BL_JGRK"]){
            cell.typeDetialLabel.text = @"加工入库";
        }else{
            cell.typeDetialLabel.text = @"盘盈入库";
        }
    }else{
       //出库
        cell.timeLabel.text = @"出库日期";
        cell.typeLabel.text = @"出库类型";
        cell.wareHouseLabel.text = @"出库仓库";
        if ([storagemanagementmodel.billType isEqualToString:@"BILL_BL_XSCK"]) {
            cell.typeDetialLabel.text = @"销售出库";
        }else if ([storagemanagementmodel.billType isEqualToString:@"BILL_BL_JGCK"]){
            cell.typeDetialLabel.text = @"加工出库";
        }else{
            cell.typeDetialLabel.text = @"盘亏出库";
        }
    }
    cell.timeDetialLabel.text = storagemanagementmodel.billDate;
    cell.wareHouseDetialLabel.text = storagemanagementmodel.whsName;
    if (self.selectArray.count > 0) {
        for (int i = 0; i < self.selectArray.count; i++) {
         RSStoragemanagementModel * storagemanagementmodel1 = self.selectArray[i];
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
        RSStoragemanagementModel * storagemanagementmodel = self.detialArray[selectBtn.tag];
        [self.selectArray addObject:storagemanagementmodel];
    }else{
        RSStoragemanagementModel * storagemanagementmodel = self.detialArray[selectBtn.tag];
        for (int i = 0; i < self.selectArray.count; i++) {
            RSStoragemanagementModel * storagemanagementmodel1 = self.selectArray[i];
            if (storagemanagementmodel1.did == storagemanagementmodel.did) {
                [self.selectArray removeObjectAtIndex:i];
            }
        }
    }
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
