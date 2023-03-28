//
//  RSSLEnterDetailViewController.m
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLEnterDetailViewController.h"

#import "RSSLStoragemanagementModel.h"
#import "RSChoosingInventoryHeaderView.h"
#import "RSChoosingInventoryFootView.h"
#import "RSChoosingInventoryCell.h"

#import "RSEntryDetailModel.h"
#import "RSPersonalWkWebviewViewController.h"

@interface RSSLEnterDetailViewController ()
{
    UILabel * _totalVolmueDetailLabel;
    UILabel * _numberDetailLabel;
}
@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * detialArray;


@property (nonatomic,strong)NSMutableArray * selectArray;

@property (nonatomic, strong)NSMutableArray *expendArray;
@end

@implementation RSSLEnterDetailViewController
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

- (NSMutableArray *)expendArray {
    if (!_expendArray) {
        _expendArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _expendArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.searchTypeIndex == 1) {
       self.title = @"大板入库明细表";
    }else{
       self.title = @"大板出库明细表";
        
    }
    
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
    
    
    [self reloadData];
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.blockDict setObject:@"1" forKey:@"pageNum"];
        [weakSelf reloadData];
        
    }];
    
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf reloadNewMoreData];
    }];
    
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
        [weakSelf reloadData];
    }];
    
}


//FIXME:分享
- (void)shareBtnAction:(UIButton *)shareBtn{
    if (self.selectArray.count > 0) {
        NSInteger totalNumber = 0;
        NSDecimalNumber * totalArea;
        double newArea = 0.0;
        NSMutableString * str = [NSMutableString string];
        for (int i = 0; i < self.selectArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemangementmodel1 = self.selectArray[i];
            newArea += [slstoragemangementmodel1.area doubleValue];
            totalNumber += slstoragemangementmodel1.qty;
            if (i == 0) {
                [str appendFormat:@"%@",[NSString stringWithFormat:@"%ld",slstoragemangementmodel1.did]];
            }else{
                [str appendFormat:@"%@",[NSString stringWithFormat:@",%ld",slstoragemangementmodel1.did]];
            }
        }
        totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
        
        
        RSPersonalWkWebviewViewController * personalWkVc = [[RSPersonalWkWebviewViewController alloc]init];
        personalWkVc.typeStr = @"码单分享";
        
        personalWkVc.title = self.selectFunctionType;
        
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        personalWkVc.VerifyKey = [user objectForKey:@"VERIFYKEY"];
        personalWkVc.appType = 1;
        
        if (self.searchTypeIndex == 1) {
            personalWkVc.pageType = 5;
        }else{
            personalWkVc.pageType = 6;
        }
        
        
        
        //体积
        //片数
        personalWkVc.dateFrom = [self.blockDict objectForKey:@"dateFrom"];
        personalWkVc.dateTo = [self.blockDict objectForKey:@"dateTo"];
        personalWkVc.mtlName = [self.blockDict objectForKey:@"mtlName"];
        personalWkVc.mtlId = [[self.blockDict objectForKey:@"mtlId"] integerValue];
        personalWkVc.blockNo = [self.blockDict objectForKey:@"blockNo"];
        personalWkVc.whsName = [self.blockDict objectForKey:@"whsName"];
        personalWkVc.turnsNo = [self.blockDict objectForKey:@"turnsNo"];
        personalWkVc.slNo = [self.blockDict objectForKey:@"slNo"];
        personalWkVc.storageType = [self.blockDict objectForKey:@"storageType"];
        personalWkVc.whsId = [[self.blockDict objectForKey:@"whsId"] integerValue];
        personalWkVc.isFrozen = [[self.blockDict objectForKey:@"isFrozen"]integerValue];
        personalWkVc.lengthType = [[self.blockDict objectForKey:@"lengthType"]integerValue];
        personalWkVc.widthType = [[self.blockDict objectForKey:@"widthType"]integerValue];
        personalWkVc.length = [self.blockDict objectForKey:@"length"];
        personalWkVc.width = [self.blockDict objectForKey:@"width"];
        
        //personalWkVc.webStr = @"http://117.29.162.206:8888/slsw/pwms/codeList.html";
        
         personalWkVc.webStr = [NSString stringWithFormat:@"%@slsw/pwms/codeList.html",URL_HEADER_TEXT_IOS];
        
        NSString * reportUrlStr = [NSString stringWithFormat:@"%@?appType=%ld&userId=%@&VerifyKey=%@&pageType=%ld&totalVaQty=%@&totalQty=%ld&dateFrom=%@&dateTo=%@&mtlName=%@&mtlId=%ld&blockNo=%@&whsName=%@&storageType=%@&whsId=%ld&isFrozen=%ld&lengthType=%ld&widthType=%ld&length=%@&width=%@&turnsNo=%@&slNo=%@&dids=%@&companyName=%@&pwmsUserId=%ld", personalWkVc.webStr,personalWkVc.appType,self.usermodel.userID,personalWkVc.VerifyKey, personalWkVc.pageType, totalArea,totalNumber,personalWkVc.dateFrom,personalWkVc.dateTo,personalWkVc.mtlName,personalWkVc.mtlId,personalWkVc.blockNo,personalWkVc.whsName,personalWkVc.storageType,personalWkVc.whsId,personalWkVc.isFrozen,personalWkVc.lengthType,personalWkVc.widthType,personalWkVc.length, personalWkVc.width,personalWkVc.turnsNo,personalWkVc.slNo,str,self.usermodel.pwmsUser.companyName,self.usermodel.pwmsUser.parentId];
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
    numberLabel.text = @"总匝数";
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
    totalVolmueLabel.text = @"总面积";
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


- (void)reloadData{
    //URL_SLBALANACE_IOS
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"DETAIL" forKey:@"type"];
    [phoneDict setObject:self.blockDict forKey:@"billViewFilter"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.searchTypeIndex] forKey:@"searchType"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SLSTORAGEDETAIL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.detialArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                NSMutableArray * tempArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    RSEntryDetailModel * entrydetilmodel = [[RSEntryDetailModel alloc]init];
                    entrydetilmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                     entrydetilmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    
                    entrydetilmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                    entrydetilmodel.qty =  [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                    entrydetilmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    
                    entrydetilmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    entrydetilmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    tempArray = [[array objectAtIndex:i] objectForKey:@"billDetailVos"];
                    for (int j = 0; j < tempArray.count; j++) {
                        RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                        
                        /**
                         billDate = "2019-05-12";
                         billName = "\U5927\U677f\U52a0\U5de5\U5165\U5e93\U5355";
                         billNo = "SL_JGRK201905120001";
                         billType = "BILL_SL_JGRK";
                         pwmsUserId = 190;
                         */
                        slstoragemanagementmodel.area = [[tempArray objectAtIndex:j] objectForKey:@"area"];
                        slstoragemanagementmodel.whsName = [[tempArray objectAtIndex:j]objectForKey:@"whsName"];
                        slstoragemanagementmodel.width = [[tempArray objectAtIndex:j]objectForKey:@"width"];
                        
                        slstoragemanagementmodel.blockNo = [[tempArray objectAtIndex:j] objectForKey:@"blockNo"];
                        slstoragemanagementmodel.dedArea = [[tempArray objectAtIndex:j] objectForKey:@"dedArea"];
                        slstoragemanagementmodel.did = [[[tempArray objectAtIndex:j] objectForKey:@"did"] integerValue];
                        slstoragemanagementmodel.height = [[tempArray objectAtIndex:j] objectForKey:@"height"];
                        //slstoragemanagementmodel.isfrozen = [[[tempArray objectAtIndex:j] objectForKey:@"isfrozen"] integerValue];
                        slstoragemanagementmodel.length = [[tempArray objectAtIndex:j] objectForKey:@"length"];
                        slstoragemanagementmodel.mtlId = [[[tempArray objectAtIndex:j] objectForKey:@"mtlId"] integerValue];
                        slstoragemanagementmodel.mtlName = [[tempArray objectAtIndex:j] objectForKey:@"mtlName"];
                       // slstoragemanagementmodel.storeareaName = @"";
//                        slstoragemanagementmodel.dedLengthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        slstoragemanagementmodel.dedWidthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        slstoragemanagementmodel.dedLengthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        slstoragemanagementmodel.dedWidthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        slstoragemanagementmodel.dedLengthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//
//                        slstoragemanagementmodel.dedWidthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        slstoragemanagementmodel.dedLengthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        slstoragemanagementmodel.dedWidthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        
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
                        [entrydetilmodel.contentArray addObject:slstoragemanagementmodel];
                    }
                    [weakSelf.detialArray addObject:entrydetilmodel];
                }
                _numberDetailLabel.text = [NSString stringWithFormat:@"%@匝",json[@"data"][@"total"][@"totalTurnsQty"]];
                
                _totalVolmueDetailLabel.text = [NSString stringWithFormat:@"%0.3lfm²",[json[@"data"][@"total"][@"totalVaQty"]doubleValue]];
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
                    RSEntryDetailModel * entrydetilmodel = [[RSEntryDetailModel alloc]init];
                    entrydetilmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    
                    entrydetilmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    entrydetilmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                    entrydetilmodel.qty =  [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                    entrydetilmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    
                    entrydetilmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    entrydetilmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    
                  
                    
                    tempArray = [[array objectAtIndex:i] objectForKey:@"billDetailVos"];
                    for (int j = 0; j < tempArray.count; j++) {
                        RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                        slstoragemanagementmodel.area = [[tempArray objectAtIndex:j] objectForKey:@"area"];
                        slstoragemanagementmodel.whsName = [[tempArray objectAtIndex:j]objectForKey:@"whsName"];
                        slstoragemanagementmodel.width = [[tempArray objectAtIndex:j]objectForKey:@"width"];
                        
                        slstoragemanagementmodel.blockNo = [[tempArray objectAtIndex:j] objectForKey:@"blockNo"];
                        slstoragemanagementmodel.dedArea = [[tempArray objectAtIndex:j] objectForKey:@"dedArea"];
                        slstoragemanagementmodel.did = [[[tempArray objectAtIndex:j] objectForKey:@"did"] integerValue];
                        slstoragemanagementmodel.height = [[tempArray objectAtIndex:j] objectForKey:@"height"];
                        //slstoragemanagementmodel.isfrozen = [[[tempArray objectAtIndex:j] objectForKey:@"isfrozen"] integerValue];
                        slstoragemanagementmodel.length = [[tempArray objectAtIndex:j] objectForKey:@"length"];
                        slstoragemanagementmodel.mtlId = [[[tempArray objectAtIndex:j] objectForKey:@"mtlId"] integerValue];
                        slstoragemanagementmodel.mtlName = [[tempArray objectAtIndex:j] objectForKey:@"mtlName"];
                        // slstoragemanagementmodel.storeareaName = @"";
                        //                        slstoragemanagementmodel.dedLengthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        //                        slstoragemanagementmodel.dedWidthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        //                        slstoragemanagementmodel.dedLengthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        //                        slstoragemanagementmodel.dedWidthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        //                        slstoragemanagementmodel.dedLengthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        //
                        //                        slstoragemanagementmodel.dedWidthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        //                        slstoragemanagementmodel.dedLengthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        //                        slstoragemanagementmodel.dedWidthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                        
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
                        [entrydetilmodel.contentArray addObject:slstoragemanagementmodel];
                    }
                    [contentArray addObject:entrydetilmodel];
                }
                _numberDetailLabel.text = [NSString stringWithFormat:@"%@匝",json[@"data"][@"total"][@"totalTurnsQty"]];
                
                _totalVolmueDetailLabel.text = [NSString stringWithFormat:@"%0.3lfm²",[json[@"data"][@"total"][@"totalVaQty"]doubleValue]];
                [weakSelf.detialArray addObjectsFromArray:contentArray];
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



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 165;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSEntryDetailModel * selectdabanslmodel = self.detialArray[section];
    NSString *identifier = [NSString stringWithFormat:@"SLDETAILSTATEMENTHEADER%ld",(long)section];
    RSChoosingInventoryHeaderView * choosingInventoryHeaderView = [[RSChoosingInventoryHeaderView alloc]initWithReuseIdentifier:identifier];
    choosingInventoryHeaderView.selectBtn.tag = section;
    choosingInventoryHeaderView.tag = section;
    choosingInventoryHeaderView.tap.view.tag = section;
    choosingInventoryHeaderView.choosingNumberLabel.text =[NSString stringWithFormat:@"荒料号:%@",selectdabanslmodel.blockNo];
    choosingInventoryHeaderView.choosingProductNameLabel.text =[NSString stringWithFormat:@"物料名称:%@",selectdabanslmodel.mtlName];
    choosingInventoryHeaderView.choosingProductTypeLabel.text = [NSString stringWithFormat:@"物料类型:%@",selectdabanslmodel.mtltypeName];
    choosingInventoryHeaderView.choosingAreaLabel.text = [NSString stringWithFormat:@"总实际面积:%0.3lf(m²)",[selectdabanslmodel.area doubleValue]];
    choosingInventoryHeaderView.choosingWarehouseLabel.text = [NSString stringWithFormat:@"匝号:%@ %ld片",selectdabanslmodel.turnsNo,(long)selectdabanslmodel.qty];
    
    BOOL selectAll = YES;
    for (int i = 0; i < selectdabanslmodel.contentArray.count; i++) {
        RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[i];
        if (!slstoragemanagementmodel.isSelect) {
            selectAll = NO;
            break;
        }
    }
    choosingInventoryHeaderView.selectBtn.selected = selectAll;
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
    
    NSString *identifier = [NSString stringWithFormat:@"SLDETAILSTATEMENTFOOT%ld",(long)section];
    RSChoosingInventoryFootView * choosingInventoryFootView = [[RSChoosingInventoryFootView alloc]initWithReuseIdentifier:identifier];
    return choosingInventoryFootView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.detialArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    RSEntryDetailModel * selectddabanslmodel = self.detialArray[section];
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
    RSEntryDetailModel * selectdabanslmodel = self.detialArray[indexPath.section];
    RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[indexPath.row];
    NSString *identifier = [NSString stringWithFormat:@"SLDETAILSTATEMENTCELLID%ld%ld",(long)indexPath.section,(long)indexPath.row];
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
    if (slstoragemanagementmodel.isSelect) {
        cell.selectBtn.selected = true;
    }else{
        cell.selectBtn.selected = false;
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
    UIView *v = [selectBtn superview];//获取父类view
    UIView *v1 = [v superview];
    RSChoosingInventoryCell *cell = (RSChoosingInventoryCell *)[v1 superview];
    RSEntryDetailModel * selectdabanslmodel = self.detialArray[cell.tag];
    RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[selectBtn.tag];
    selectBtn.selected = !selectBtn.selected;
    if (selectBtn.selected) {
        slstoragemanagementmodel.isSelect = true;
         [self.selectArray addObject:slstoragemanagementmodel];
    }else{
        slstoragemanagementmodel.isSelect = false;
        for (int i = 0; i < self.selectArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemangementmodel1 = self.selectArray[i];
            if (slstoragemangementmodel1.did == slstoragemanagementmodel.did) {
                [self.selectArray removeObjectAtIndex:i];
                break;
            }
        }
    }
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:cell.tag] withRowAnimation:UITableViewRowAnimationNone];
}



- (void)headerButtonOnClick:(UIButton *)button {
    RSEntryDetailModel * selectdabanslmodel = self.detialArray[button.tag];
    button.selected = !button.selected;
    if (button.selected) {
        for (int i = 0; i < selectdabanslmodel.contentArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[i];
            if(slstoragemanagementmodel.isSelect) {
                slstoragemanagementmodel.isSelect = true;
            }else{
                [self.selectArray addObject:slstoragemanagementmodel];
                slstoragemanagementmodel.isSelect = true;
            }
        }
    }else {
        for (int i = 0; i < selectdabanslmodel.contentArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[i];
            slstoragemanagementmodel.isSelect = false;
            // [self.selectArray addObject:@(slstoragemanagementmodel.did)];
        }
        
        for (int i = 0; i < self.selectArray.count; i++) {
            RSSLStoragemanagementModel * slstoragemangementmodel1 = self.selectArray[i];
            for (int j = 0; j < selectdabanslmodel.contentArray.count; j++) {
                RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[j];
                if (slstoragemanagementmodel.did == slstoragemangementmodel1.did) {
                    [self.selectArray removeObjectAtIndex:i];
                    i--;
                    break;
                }
            }
        }
    }
    [self.tableview reloadData];
}


- (void)headerTap:(UITapGestureRecognizer *)tap {
    RSChoosingInventoryHeaderView * view = (RSChoosingInventoryHeaderView *)tap.view;
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
    [self.tableview reloadData];
}


@end
