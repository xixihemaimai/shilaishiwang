//
//  RSReportFormSLShareViewController.m
//  石来石往
//
//  Created by mac on 2020/2/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSReportFormSLShareViewController.h"


#import "RSChoosingInventoryHeaderView.h"
#import "RSChoosingInventoryFootView.h"
#import "RSChoosingInventoryCell.h"


#import "RSSLStoragemanagementModel.h"
#import "RSEntryDetailModel.h"

#import "RSPersonalWkWebviewViewController.h"

#import "RSReportFormShareSLModel.h"
#import "RSReportFormShareSLPiecesModel.h"


@interface RSReportFormSLShareViewController ()
{
    UILabel * _totalVolmueDetailLabel;
    UILabel * _numberDetailLabel;
}
@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * detialArray;


@property (nonatomic,strong)NSMutableArray * selectArray;

@property (nonatomic, strong)NSMutableArray *expendArray;


@end

@implementation RSReportFormSLShareViewController

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
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar - 43);
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self setUIBottomCustomView];
    [self reloadData];
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //[weakSelf.blockDict setObject:@"1" forKey:@"pageNum"];
        [weakSelf reloadData];
    }];
    
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf reloadNewMoreData];
    }];
    
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf reloadData];
//    }];
    
}

//FIXME:分享
- (void)shareBtnAction:(UIButton *)shareBtn{
    NSMutableArray * array = [self changeArrayRule:self.selectArray];
    for (int i = 0; i < array.count; i++) {
           RSReportFormShareSLModel * reportFormShareSLmodel = array[i];
        for (int j = 0; j < reportFormShareSLmodel.pieces.count; j++) {
           RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel = reportFormShareSLmodel.pieces[j];
        }
    }
    
    
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
              if ([self.title isEqualToString:@"大板库存"]) {
                   personalWkVc.pageType = 4;
              }else if ([self.title isEqualToString:@"大板入库明细"]){
                   personalWkVc.pageType = 6;
              }else{
                  personalWkVc.pageType = 5;
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
              personalWkVc.selectArray = array;
              
              [self.navigationController pushViewController:personalWkVc animated:YES];
          }else{
              [SVProgressHUD showInfoWithStatus:@"请先去选择你需要分享的内容"];
          }
    
//    if (self.selectArray.count > 0) {
//        NSInteger totalNumber = 0;
//        NSDecimalNumber * totalArea;
//        double newArea = 0.0;
//        NSMutableString * str = [NSMutableString string];
//        for (int i = 0; i < self.selectArray.count; i++) {
//            RSSLStoragemanagementModel * slstoragemangementmodel1 = self.selectArray[i];
//            newArea += [slstoragemangementmodel1.area doubleValue];
//            totalNumber += slstoragemangementmodel1.qty;
//            if (i == 0) {
//                [str appendFormat:@"%@",[NSString stringWithFormat:@"%ld",slstoragemangementmodel1.did]];
//            }else{
//                [str appendFormat:@"%@",[NSString stringWithFormat:@",%ld",slstoragemangementmodel1.did]];
//            }
//        }
//        totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
//
//
//        RSPersonalWkWebviewViewController * personalWkVc = [[RSPersonalWkWebviewViewController alloc]init];
//        personalWkVc.typeStr = @"码单分享";
//
//        //personalWkVc.title = self.selectFunctionType;
//
//
//        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//        personalWkVc.VerifyKey = [user objectForKey:@"VERIFYKEY"];
//        personalWkVc.appType = 1;
//
//        if (self.searchTypeIndex == 1) {
//            personalWkVc.pageType = 5;
//        }else{
//            personalWkVc.pageType = 6;
//        }
        
        
        
        //体积
//        //片数
//        personalWkVc.dateFrom = [self.blockDict objectForKey:@"dateFrom"];
//        personalWkVc.dateTo = [self.blockDict objectForKey:@"dateTo"];
//        personalWkVc.mtlName = [self.blockDict objectForKey:@"mtlName"];
//        personalWkVc.mtlId = [[self.blockDict objectForKey:@"mtlId"] integerValue];
//        personalWkVc.blockNo = [self.blockDict objectForKey:@"blockNo"];
//        personalWkVc.whsName = [self.blockDict objectForKey:@"whsName"];
//        personalWkVc.turnsNo = [self.blockDict objectForKey:@"turnsNo"];
//        personalWkVc.slNo = [self.blockDict objectForKey:@"slNo"];
//        personalWkVc.storageType = [self.blockDict objectForKey:@"storageType"];
//        personalWkVc.whsId = [[self.blockDict objectForKey:@"whsId"] integerValue];
//        personalWkVc.isFrozen = [[self.blockDict objectForKey:@"isFrozen"]integerValue];
//        personalWkVc.lengthType = [[self.blockDict objectForKey:@"lengthType"]integerValue];
//        personalWkVc.widthType = [[self.blockDict objectForKey:@"widthType"]integerValue];
//        personalWkVc.length = [self.blockDict objectForKey:@"length"];
//        personalWkVc.width = [self.blockDict objectForKey:@"width"];
//
//        //personalWkVc.webStr = @"http://117.29.162.206:8888/slsw/pwms/codeList.html";
//
//        personalWkVc.webStr = [NSString stringWithFormat:@"%@slsw/pwms/codeList.html",URL_HEADER_TEXT_IOS];
//
//        NSString * reportUrlStr = [NSString stringWithFormat:@"%@?appType=%ld&userId=%@&VerifyKey=%@&pageType=%ld&totalVaQty=%@&totalQty=%ld&dateFrom=%@&dateTo=%@&mtlName=%@&mtlId=%ld&blockNo=%@&whsName=%@&storageType=%@&whsId=%ld&isFrozen=%ld&lengthType=%ld&widthType=%ld&length=%@&width=%@&turnsNo=%@&slNo=%@&dids=%@&companyName=%@&pwmsUserId=%ld", personalWkVc.webStr,personalWkVc.appType,self.usermodel.userID,personalWkVc.VerifyKey, personalWkVc.pageType, totalArea,totalNumber,personalWkVc.dateFrom,personalWkVc.dateTo,personalWkVc.mtlName,personalWkVc.mtlId,personalWkVc.blockNo,personalWkVc.whsName,personalWkVc.storageType,personalWkVc.whsId,personalWkVc.isFrozen,personalWkVc.lengthType,personalWkVc.widthType,personalWkVc.length, personalWkVc.width,personalWkVc.turnsNo,personalWkVc.slNo,str,self.usermodel.pwmsUser.companyName,self.usermodel.pwmsUser.parentId];
//        personalWkVc.ulrStr = reportUrlStr;
//        [self.navigationController pushViewController:personalWkVc animated:YES];
//
//    }else{
//        [SVProgressHUD showInfoWithStatus:@"请先去选择你需要分享的内容"];
//    }
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
    NSString * urlTpye = [NSString string];
    if ([self.title isEqualToString:@"大板库存"]){
           
           urlTpye = URL_MTLSLBALANCE_IOS;
       }else if ([self.title isEqualToString:@"大板入库明细"]){
           urlTpye = URL_SLIN_IOS;
       }else{
           urlTpye = URL_SLOUT_IOS;
       }
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [phoneDict setValue:self.usermodel.userID forKey:@"id"];
       [phoneDict setValue:[NSNumber numberWithInteger:1] forKey:@"nowpage"];
       [phoneDict setValue:[NSNumber numberWithInteger:10] forKey:@"pagesize"];
       [phoneDict setValue:applegate.ERPID forKey:@"erpId"];
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
    [phoneDict setValue:self.blocknos forKey:@"blocknos"];
    [phoneDict setValue:self.turnsno forKey:@"turnsno"];
    if ([self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"]) {
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
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"][@"list"];
                NSMutableArray * tempArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    
                    RSReportFormShareSLModel * reportFormShareSLmodel = [[RSReportFormShareSLModel alloc]init];
                    reportFormShareSLmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    reportFormShareSLmodel.csid = [[array objectAtIndex:i]objectForKey:@"csid"];
                    reportFormShareSLmodel.deaName = [[array objectAtIndex:i]objectForKey:@"deaName"];
                    reportFormShareSLmodel.materialtype = [[array objectAtIndex:i]objectForKey:@"materialtype"];
                    reportFormShareSLmodel.msid = [[array objectAtIndex:i]objectForKey:@"msid"];
                    reportFormShareSLmodel.mtlname = [[array objectAtIndex:i]objectForKey:@"mtlname"];
                    reportFormShareSLmodel.turnsno = [[array objectAtIndex:i]objectForKey:@"turnsno"];
                    reportFormShareSLmodel.n = [[[array objectAtIndex:i]objectForKey:@"n"] integerValue];
                    reportFormShareSLmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    
//                    RSEntryDetailModel * entrydetilmodel = [[RSEntryDetailModel alloc]init];
//                    entrydetilmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
//                    entrydetilmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
//
//                    entrydetilmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
//                    entrydetilmodel.qty =  [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
//                    entrydetilmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
//
//                    entrydetilmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
//                    entrydetilmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    tempArray = [[array objectAtIndex:i] objectForKey:@"pieces"];
                    for (int j = 0; j < tempArray.count; j++) {
                        RSReportFormShareSLPiecesModel *  reportFormShareSLPiecesmodel = [[RSReportFormShareSLPiecesModel alloc]init];
                        reportFormShareSLPiecesmodel.area = [[tempArray objectAtIndex:j]objectForKey:@"area"];
                        reportFormShareSLPiecesmodel.csid = [[tempArray objectAtIndex:j]objectForKey:@"csid"];
                        reportFormShareSLPiecesmodel.deaName = [[tempArray objectAtIndex:j]objectForKey:@"deaName"];
                        reportFormShareSLPiecesmodel.deacode = [[tempArray objectAtIndex:j]objectForKey:@"deacode"];
                        
                        reportFormShareSLPiecesmodel.ded_length_four = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_four"];
//                        reportFormShareSLPiecesmodel.area = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_four"];
                        reportFormShareSLPiecesmodel.ded_length_one = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_one"];
//                        reportFormShareSLPiecesmodel.area = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_one"];
                        reportFormShareSLPiecesmodel.ded_length_three = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_three"];
                        reportFormShareSLPiecesmodel.ded_length_two = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_two"];
                        
                        reportFormShareSLPiecesmodel.ded_wide_four = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_four"];
                        reportFormShareSLPiecesmodel.ded_wide_one = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_one"];
                        reportFormShareSLPiecesmodel.ded_wide_three = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_three"];
                        reportFormShareSLPiecesmodel.ded_wide_two = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_two"];
                        
                        reportFormShareSLPiecesmodel.dedarea = [[tempArray objectAtIndex:j]objectForKey:@"dedarea"];
                        reportFormShareSLPiecesmodel.did = [[[tempArray objectAtIndex:j]objectForKey:@"did"] integerValue];
                        reportFormShareSLPiecesmodel.height = [[[tempArray objectAtIndex:j]objectForKey:@"height"] integerValue];
                        reportFormShareSLPiecesmodel.lenght = [[[tempArray objectAtIndex:j]objectForKey:@"lenght"] integerValue];
                        
                        
                        
                        reportFormShareSLPiecesmodel.locationname = [[tempArray objectAtIndex:j]objectForKey:@"locationname"];
                        reportFormShareSLPiecesmodel.materialtype = [[tempArray objectAtIndex:j]objectForKey:@"materialtype"];
                        reportFormShareSLPiecesmodel.msid = [[tempArray objectAtIndex:j]objectForKey:@"msid"];
                        reportFormShareSLPiecesmodel.mtlcode = [[tempArray objectAtIndex:j]objectForKey:@"mtlcode"];
                        
                        
                         reportFormShareSLPiecesmodel.mtlname = [[tempArray objectAtIndex:j]objectForKey:@"mtlname"];
                        reportFormShareSLPiecesmodel.n = [[[tempArray objectAtIndex:j]objectForKey:@"n"] integerValue];
                        
                        reportFormShareSLPiecesmodel.prearea = [[tempArray objectAtIndex:j]objectForKey:@"prearea"];
                        reportFormShareSLPiecesmodel.qty = [[[tempArray objectAtIndex:j]objectForKey:@"qty"] integerValue];
                        
                        reportFormShareSLPiecesmodel.slno = [[tempArray objectAtIndex:j]objectForKey:@"slno"];
                        reportFormShareSLPiecesmodel.storeareaname = [[tempArray objectAtIndex:j]objectForKey:@"storeareaname"];
                        reportFormShareSLPiecesmodel.turnsno = [[tempArray objectAtIndex:j]objectForKey:@"turnsno"];
                        reportFormShareSLPiecesmodel.whsname = [[tempArray objectAtIndex:j]objectForKey:@"whsname"];
                         reportFormShareSLPiecesmodel.width = [[[tempArray objectAtIndex:j]objectForKey:@"width"] integerValue];
                        
                        
                        reportFormShareSLPiecesmodel.isSelect = false;
                        
                        
                        
//                        RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
//                        /**
//                         billDate = "2019-05-12";
//                         billName = "\U5927\U677f\U52a0\U5de5\U5165\U5e93\U5355";
//                         billNo = "SL_JGRK201905120001";
//                         billType = "BILL_SL_JGRK";
//                         pwmsUserId = 190;
//                         */
//                        slstoragemanagementmodel.area = [[tempArray objectAtIndex:j] objectForKey:@"area"];
//                        slstoragemanagementmodel.whsName = [[tempArray objectAtIndex:j]objectForKey:@"whsName"];
//                        slstoragemanagementmodel.width = [[tempArray objectAtIndex:j]objectForKey:@"width"];
//
//                        slstoragemanagementmodel.blockNo = [[tempArray objectAtIndex:j] objectForKey:@"blockNo"];
//                        slstoragemanagementmodel.dedArea = [[tempArray objectAtIndex:j] objectForKey:@"dedArea"];
//                        slstoragemanagementmodel.did = [[[tempArray objectAtIndex:j] objectForKey:@"did"] integerValue];
//                        slstoragemanagementmodel.height = [[tempArray objectAtIndex:j] objectForKey:@"height"];
//                        //slstoragemanagementmodel.isfrozen = [[[tempArray objectAtIndex:j] objectForKey:@"isfrozen"] integerValue];
//                        slstoragemanagementmodel.length = [[tempArray objectAtIndex:j] objectForKey:@"length"];
//                        slstoragemanagementmodel.mtlId = [[[tempArray objectAtIndex:j] objectForKey:@"mtlId"] integerValue];
//                        slstoragemanagementmodel.mtlName = [[tempArray objectAtIndex:j] objectForKey:@"mtlName"];
//                        // slstoragemanagementmodel.storeareaName = @"";
//                        //                        slstoragemanagementmodel.dedLengthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedWidthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedLengthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedWidthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedLengthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //
//                        //                        slstoragemanagementmodel.dedWidthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedLengthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedWidthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//
//                        slstoragemanagementmodel.mtltypeId = [[[tempArray objectAtIndex:j] objectForKey:@"mtltypeId"] integerValue];
//                        slstoragemanagementmodel.mtltypeName = [[tempArray objectAtIndex:j] objectForKey:@"mtltypeName"];
//                        slstoragemanagementmodel.preArea = [[tempArray objectAtIndex:j] objectForKey:@"preArea"];
//                        slstoragemanagementmodel.qty = [[[tempArray objectAtIndex:j] objectForKey:@"qty"] integerValue];
//                        slstoragemanagementmodel.receiptDate = [[tempArray objectAtIndex:j] objectForKey:@"receiptDate"];
//                        slstoragemanagementmodel.slNo = [[tempArray objectAtIndex:j] objectForKey:@"slNo"];
//                        slstoragemanagementmodel.storageType = [[tempArray objectAtIndex:j] objectForKey:@"storageType"];
//                        slstoragemanagementmodel.storeareaId = [[[tempArray objectAtIndex:j] objectForKey:@"storeareaId"] integerValue];
//                        slstoragemanagementmodel.turnsNo = [[tempArray objectAtIndex:j] objectForKey:@"turnsNo"];
//                        slstoragemanagementmodel.whsId = [[[tempArray objectAtIndex:j] objectForKey:@"whsId"] integerValue];
//                        slstoragemanagementmodel.whsName = [[tempArray objectAtIndex:j] objectForKey:@"whsName"];
//                        slstoragemanagementmodel.width = [[tempArray objectAtIndex:j] objectForKey:@"width"];
//                        slstoragemanagementmodel.isSelect = false;
//                        [entrydetilmodel.contentArray addObject:slstoragemanagementmodel];
                        
                        [reportFormShareSLmodel.pieces addObject:reportFormShareSLPiecesmodel];
                        
                    }
                    [weakSelf.detialArray addObject:reportFormShareSLmodel];
                }
                _numberDetailLabel.text = [NSString stringWithFormat:@"%@匝",json[@"Data"][@"sumlist"][@"datasize"]];
                
                _totalVolmueDetailLabel.text = [NSString stringWithFormat:@"%0.3lfm²",[json[@"Data"][@"sumlist"][@"totalarea"]doubleValue]];
                weakSelf.pageNum = 2;
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

- (void)reloadNewMoreData{
    NSString * urlTpye = [NSString string];
    if ([self.title isEqualToString:@"大板库存"]){
             urlTpye = URL_MTLSLBALANCE_IOS;
         }else if ([self.title isEqualToString:@"大板入库明细"]){
             urlTpye = URL_SLIN_IOS;
         }else{
             urlTpye = URL_SLOUT_IOS;
         }
    //URL_SLBALANACE_IOS
//    [self.blockDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    
    
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [phoneDict setValue:self.usermodel.userID forKey:@"id"];
       [phoneDict setValue:[NSNumber numberWithInteger:self.pageNum] forKey:@"nowpage"];
       [phoneDict setValue:[NSNumber numberWithInteger:10] forKey:@"pagesize"];
       [phoneDict setValue:applegate.ERPID forKey:@"erpId"];
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
       [phoneDict setValue:self.turnsno forKey:@"turnsno"];
       [phoneDict setValue:self.blocknos forKey:@"blocknos"];
    if ([self.title isEqualToString:@"大板入库明细"] || [self.title isEqualToString:@"大板出库明细"]) {
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
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"][@"list"];
                NSMutableArray * tempArray = [NSMutableArray array];
                NSMutableArray * contentArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                                    
                                    RSReportFormShareSLModel * reportFormShareSLmodel = [[RSReportFormShareSLModel alloc]init];
                                    reportFormShareSLmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                                    reportFormShareSLmodel.csid = [[array objectAtIndex:i]objectForKey:@"csid"];
                                    reportFormShareSLmodel.deaName = [[array objectAtIndex:i]objectForKey:@"deaName"];
                                    reportFormShareSLmodel.materialtype = [[array objectAtIndex:i]objectForKey:@"materialtype"];
                                    reportFormShareSLmodel.msid = [[array objectAtIndex:i]objectForKey:@"msid"];
                                    reportFormShareSLmodel.mtlname = [[array objectAtIndex:i]objectForKey:@"mtlname"];
                                    reportFormShareSLmodel.turnsno = [[array objectAtIndex:i]objectForKey:@"turnsno"];
                                    reportFormShareSLmodel.n = [[[array objectAtIndex:i]objectForKey:@"n"] integerValue];
                                    reportFormShareSLmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                                    
                //                    RSEntryDetailModel * entrydetilmodel = [[RSEntryDetailModel alloc]init];
                //                    entrydetilmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                //                    entrydetilmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                //
                //                    entrydetilmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
                //                    entrydetilmodel.qty =  [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
                //                    entrydetilmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                //
                //                    entrydetilmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                //                    entrydetilmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                                    tempArray = [[array objectAtIndex:i] objectForKey:@"pieces"];
                                    for (int j = 0; j < tempArray.count; j++) {
                                        RSReportFormShareSLPiecesModel *  reportFormShareSLPiecesmodel = [[RSReportFormShareSLPiecesModel alloc]init];
                                        reportFormShareSLPiecesmodel.area = [[tempArray objectAtIndex:j]objectForKey:@"area"];
                                        reportFormShareSLPiecesmodel.csid = [[tempArray objectAtIndex:j]objectForKey:@"csid"];
                                        reportFormShareSLPiecesmodel.deaName = [[tempArray objectAtIndex:j]objectForKey:@"deaName"];
                                        reportFormShareSLPiecesmodel.deacode = [[tempArray objectAtIndex:j]objectForKey:@"deacode"];
                                        
                                        reportFormShareSLPiecesmodel.ded_length_four = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_four"];
                                        
//                                        reportFormShareSLPiecesmodel.area = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_four"];
                                        reportFormShareSLPiecesmodel.ded_length_one = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_one"];
//                                        reportFormShareSLPiecesmodel.area = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_one"];
                                        reportFormShareSLPiecesmodel.ded_length_three = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_three"];
                                        reportFormShareSLPiecesmodel.ded_length_two = [[tempArray objectAtIndex:j]objectForKey:@"ded_length_two"];
                                        
                                        reportFormShareSLPiecesmodel.ded_wide_four = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_four"];
                                        reportFormShareSLPiecesmodel.ded_wide_one = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_one"];
                                        reportFormShareSLPiecesmodel.ded_wide_three = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_three"];
                                        reportFormShareSLPiecesmodel.ded_wide_two = [[tempArray objectAtIndex:j]objectForKey:@"ded_wide_two"];
                                        
                                        reportFormShareSLPiecesmodel.dedarea = [[tempArray objectAtIndex:j]objectForKey:@"dedarea"];
                                        reportFormShareSLPiecesmodel.did = [[[tempArray objectAtIndex:j]objectForKey:@"did"] integerValue];
                                        reportFormShareSLPiecesmodel.height = [[[tempArray objectAtIndex:j]objectForKey:@"height"] integerValue];
                                        reportFormShareSLPiecesmodel.lenght = [[[tempArray objectAtIndex:j]objectForKey:@"lenght"] integerValue];
                                        
                                        
                                        
                                        reportFormShareSLPiecesmodel.locationname = [[tempArray objectAtIndex:j]objectForKey:@"locationname"];
                                        reportFormShareSLPiecesmodel.materialtype = [[tempArray objectAtIndex:j]objectForKey:@"materialtype"];
                                        reportFormShareSLPiecesmodel.msid = [[tempArray objectAtIndex:j]objectForKey:@"msid"];
                                        reportFormShareSLPiecesmodel.mtlcode = [[tempArray objectAtIndex:j]objectForKey:@"mtlcode"];
                                        
                                        
                                         reportFormShareSLPiecesmodel.mtlname = [[tempArray objectAtIndex:j]objectForKey:@"mtlname"];
                                        reportFormShareSLPiecesmodel.n = [[[tempArray objectAtIndex:j]objectForKey:@"n"] integerValue];
                                        
                                        reportFormShareSLPiecesmodel.prearea = [[tempArray objectAtIndex:j]objectForKey:@"prearea"];
                                        reportFormShareSLPiecesmodel.qty = [[[tempArray objectAtIndex:j]objectForKey:@"qty"] integerValue];
                                        
                                        reportFormShareSLPiecesmodel.slno = [[tempArray objectAtIndex:j]objectForKey:@"slno"];
                                        reportFormShareSLPiecesmodel.storeareaname = [[tempArray objectAtIndex:j]objectForKey:@"storeareaname"];
                                        reportFormShareSLPiecesmodel.turnsno = [[tempArray objectAtIndex:j]objectForKey:@"turnsno"];
                                        reportFormShareSLPiecesmodel.whsname = [[tempArray objectAtIndex:j]objectForKey:@"whsname"];
                                         reportFormShareSLPiecesmodel.width = [[[tempArray objectAtIndex:j]objectForKey:@"width"] integerValue];
                                        
                                        
                                        reportFormShareSLPiecesmodel.isSelect = false;
                                        
                                        
                                        
                //                        RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                //
                //                        /**
                //                         billDate = "2019-05-12";
                //                         billName = "\U5927\U677f\U52a0\U5de5\U5165\U5e93\U5355";
                //                         billNo = "SL_JGRK201905120001";
                //                         billType = "BILL_SL_JGRK";
                //                         pwmsUserId = 190;
                //                         */
                //                        slstoragemanagementmodel.area = [[tempArray objectAtIndex:j] objectForKey:@"area"];
                //                        slstoragemanagementmodel.whsName = [[tempArray objectAtIndex:j]objectForKey:@"whsName"];
                //                        slstoragemanagementmodel.width = [[tempArray objectAtIndex:j]objectForKey:@"width"];
                //
                //                        slstoragemanagementmodel.blockNo = [[tempArray objectAtIndex:j] objectForKey:@"blockNo"];
                //                        slstoragemanagementmodel.dedArea = [[tempArray objectAtIndex:j] objectForKey:@"dedArea"];
                //                        slstoragemanagementmodel.did = [[[tempArray objectAtIndex:j] objectForKey:@"did"] integerValue];
                //                        slstoragemanagementmodel.height = [[tempArray objectAtIndex:j] objectForKey:@"height"];
                //                        //slstoragemanagementmodel.isfrozen = [[[tempArray objectAtIndex:j] objectForKey:@"isfrozen"] integerValue];
                //                        slstoragemanagementmodel.length = [[tempArray objectAtIndex:j] objectForKey:@"length"];
                //                        slstoragemanagementmodel.mtlId = [[[tempArray objectAtIndex:j] objectForKey:@"mtlId"] integerValue];
                //                        slstoragemanagementmodel.mtlName = [[tempArray objectAtIndex:j] objectForKey:@"mtlName"];
                //                        // slstoragemanagementmodel.storeareaName = @"";
                //                        //                        slstoragemanagementmodel.dedLengthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                //                        //                        slstoragemanagementmodel.dedWidthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                //                        //                        slstoragemanagementmodel.dedLengthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                //                        //                        slstoragemanagementmodel.dedWidthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                //                        //                        slstoragemanagementmodel.dedLengthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                //                        //
                //                        //                        slstoragemanagementmodel.dedWidthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                //                        //                        slstoragemanagementmodel.dedLengthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                //                        //                        slstoragemanagementmodel.dedWidthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
                //
                //                        slstoragemanagementmodel.mtltypeId = [[[tempArray objectAtIndex:j] objectForKey:@"mtltypeId"] integerValue];
                //                        slstoragemanagementmodel.mtltypeName = [[tempArray objectAtIndex:j] objectForKey:@"mtltypeName"];
                //                        slstoragemanagementmodel.preArea = [[tempArray objectAtIndex:j] objectForKey:@"preArea"];
                //                        slstoragemanagementmodel.qty = [[[tempArray objectAtIndex:j] objectForKey:@"qty"] integerValue];
                //                        slstoragemanagementmodel.receiptDate = [[tempArray objectAtIndex:j] objectForKey:@"receiptDate"];
                //                        slstoragemanagementmodel.slNo = [[tempArray objectAtIndex:j] objectForKey:@"slNo"];
                //                        slstoragemanagementmodel.storageType = [[tempArray objectAtIndex:j] objectForKey:@"storageType"];
                //                        slstoragemanagementmodel.storeareaId = [[[tempArray objectAtIndex:j] objectForKey:@"storeareaId"] integerValue];
                //                        slstoragemanagementmodel.turnsNo = [[tempArray objectAtIndex:j] objectForKey:@"turnsNo"];
                //                        slstoragemanagementmodel.whsId = [[[tempArray objectAtIndex:j] objectForKey:@"whsId"] integerValue];
                //                        slstoragemanagementmodel.whsName = [[tempArray objectAtIndex:j] objectForKey:@"whsName"];
                //                        slstoragemanagementmodel.width = [[tempArray objectAtIndex:j] objectForKey:@"width"];
                //                        slstoragemanagementmodel.isSelect = false;
                //                        [entrydetilmodel.contentArray addObject:slstoragemanagementmodel];
                                        
                                        [reportFormShareSLmodel.pieces addObject:reportFormShareSLPiecesmodel];
                                    }
                    [contentArray addObject:reportFormShareSLmodel];
                }
                
                
                
//                for (int i = 0; i < array.count; i++) {
//                    RSEntryDetailModel * entrydetilmodel = [[RSEntryDetailModel alloc]init];
//                    entrydetilmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
//
//                    entrydetilmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
//                    entrydetilmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"]integerValue];
//                    entrydetilmodel.qty =  [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
//                    entrydetilmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
//
//                    entrydetilmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
//                    entrydetilmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
//
//
//
//                    tempArray = [[array objectAtIndex:i] objectForKey:@"billDetailVos"];
//                    for (int j = 0; j < tempArray.count; j++) {
//                        RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
//                        slstoragemanagementmodel.area = [[tempArray objectAtIndex:j] objectForKey:@"area"];
//                        slstoragemanagementmodel.whsName = [[tempArray objectAtIndex:j]objectForKey:@"whsName"];
//                        slstoragemanagementmodel.width = [[tempArray objectAtIndex:j]objectForKey:@"width"];
//
//                        slstoragemanagementmodel.blockNo = [[tempArray objectAtIndex:j] objectForKey:@"blockNo"];
//                        slstoragemanagementmodel.dedArea = [[tempArray objectAtIndex:j] objectForKey:@"dedArea"];
//                        slstoragemanagementmodel.did = [[[tempArray objectAtIndex:j] objectForKey:@"did"] integerValue];
//                        slstoragemanagementmodel.height = [[tempArray objectAtIndex:j] objectForKey:@"height"];
//                        //slstoragemanagementmodel.isfrozen = [[[tempArray objectAtIndex:j] objectForKey:@"isfrozen"] integerValue];
//                        slstoragemanagementmodel.length = [[tempArray objectAtIndex:j] objectForKey:@"length"];
//                        slstoragemanagementmodel.mtlId = [[[tempArray objectAtIndex:j] objectForKey:@"mtlId"] integerValue];
//                        slstoragemanagementmodel.mtlName = [[tempArray objectAtIndex:j] objectForKey:@"mtlName"];
//                        // slstoragemanagementmodel.storeareaName = @"";
//                        //                        slstoragemanagementmodel.dedLengthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedWidthOne = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedLengthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedWidthTwo = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedLengthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //
//                        //                        slstoragemanagementmodel.dedWidthThree = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedLengthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//                        //                        slstoragemanagementmodel.dedWidthFour = [NSDecimalNumber decimalNumberWithString:@"0.000"];
//
//                        slstoragemanagementmodel.mtltypeId = [[[tempArray objectAtIndex:j] objectForKey:@"mtltypeId"] integerValue];
//                        slstoragemanagementmodel.mtltypeName = [[tempArray objectAtIndex:j] objectForKey:@"mtltypeName"];
//                        slstoragemanagementmodel.preArea = [[tempArray objectAtIndex:j] objectForKey:@"preArea"];
//                        slstoragemanagementmodel.qty = [[[tempArray objectAtIndex:j] objectForKey:@"qty"] integerValue];
//                        slstoragemanagementmodel.receiptDate = [[tempArray objectAtIndex:j] objectForKey:@"receiptDate"];
//                        slstoragemanagementmodel.slNo = [[tempArray objectAtIndex:j] objectForKey:@"slNo"];
//                        slstoragemanagementmodel.storageType = [[tempArray objectAtIndex:j] objectForKey:@"storageType"];
//                        slstoragemanagementmodel.storeareaId = [[[tempArray objectAtIndex:j] objectForKey:@"storeareaId"] integerValue];
//                        slstoragemanagementmodel.turnsNo = [[tempArray objectAtIndex:j] objectForKey:@"turnsNo"];
//                        slstoragemanagementmodel.whsId = [[[tempArray objectAtIndex:j] objectForKey:@"whsId"] integerValue];
//                        slstoragemanagementmodel.whsName = [[tempArray objectAtIndex:j] objectForKey:@"whsName"];
//                        slstoragemanagementmodel.width = [[tempArray objectAtIndex:j] objectForKey:@"width"];
//                        slstoragemanagementmodel.isSelect = false;
//                        [entrydetilmodel.contentArray addObject:slstoragemanagementmodel];
//                    }
//                    [contentArray addObject:entrydetilmodel];
//                }
                _numberDetailLabel.text = [NSString stringWithFormat:@"%@匝",json[@"Data"][@"sumlist"][@"datasize"]];
                
                _totalVolmueDetailLabel.text = [NSString stringWithFormat:@"%0.3lfm²",[json[@"Data"][@"sumlist"][@"totalarea"] doubleValue]];
                [weakSelf.detialArray addObjectsFromArray:contentArray];
                weakSelf.pageNum++;
                [weakSelf.tableview.mj_footer endRefreshing];
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
//    RSEntryDetailModel * selectdabanslmodel = self.detialArray[section];
    RSReportFormShareSLModel * reportFormShareSLmodel = self.detialArray[section];
    NSString *identifier = [NSString stringWithFormat:@"SLDETAILSTATEMENTHEADER%ld",(long)section];
    RSChoosingInventoryHeaderView * choosingInventoryHeaderView = [[RSChoosingInventoryHeaderView alloc]initWithReuseIdentifier:identifier];
    choosingInventoryHeaderView.selectBtn.tag = section;
    [choosingInventoryHeaderView.selectBtn setImage:[UIImage imageNamed:@"选中3"] forState:UIControlStateSelected];
    choosingInventoryHeaderView.tag = section;
    choosingInventoryHeaderView.tap.view.tag = section;
    choosingInventoryHeaderView.choosingNumberLabel.text =[NSString stringWithFormat:@"荒料号:%@",reportFormShareSLmodel.msid];
    choosingInventoryHeaderView.choosingProductNameLabel.text =[NSString stringWithFormat:@"物料名称:%@",reportFormShareSLmodel.mtlname];
    choosingInventoryHeaderView.choosingProductTypeLabel.text = [NSString stringWithFormat:@"物料类型:%@",reportFormShareSLmodel.materialtype];
    choosingInventoryHeaderView.choosingAreaLabel.text = [NSString stringWithFormat:@"总实际面积:%0.3lf(m²)",[reportFormShareSLmodel.area doubleValue]];
    choosingInventoryHeaderView.choosingWarehouseLabel.text = [NSString stringWithFormat:@"匝号:%@ %ld片",reportFormShareSLmodel.turnsno,(long)reportFormShareSLmodel.qty];
    BOOL selectAll = YES;
    for (int i = 0; i < reportFormShareSLmodel.pieces.count; i++) {
      //  RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[i];
         RSReportFormShareSLPiecesModel * reportFormShareSLPiecesmodel = reportFormShareSLmodel.pieces[i];
        if (!reportFormShareSLPiecesmodel.isSelect) {
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
    //RSEntryDetailModel * selectddabanslmodel = self.detialArray[section];
    RSReportFormShareSLModel * reportFormShareSLmodel = self.detialArray[section];
    if ([self.expendArray containsObject:@(section)]) {
        return reportFormShareSLmodel.pieces.count;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    RSEntryDetailModel * selectdabanslmodel = self.detialArray[indexPath.section];
    RSReportFormShareSLModel * reportFormShareSLmodel = self.detialArray[indexPath.section];
    RSReportFormShareSLPiecesModel * reportFormShareSLPiecesmodel = reportFormShareSLmodel.pieces[indexPath.row];
  //  RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[indexPath.row];
    NSString *identifier = [NSString stringWithFormat:@"SLDETAILSTATEMENTCELLID%ld%ld",(long)indexPath.section,(long)indexPath.row];
    RSChoosingInventoryCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RSChoosingInventoryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.iamgeView.hidden = YES;
    cell.tag = indexPath.section;
    cell.selectBtn.tag = indexPath.row;
    cell.blueView.backgroundColor = [UIColor colorWithHexColorStr:@"#FDAF1C"];
    [cell.selectBtn setImage:[UIImage imageNamed:@"选中3"] forState:UIControlStateSelected];
    [cell.selectBtn addTarget:self action:@selector(showAndHideSelectContentAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.filmNumberLabel.text = [NSString stringWithFormat:@"板号:%@",reportFormShareSLPiecesmodel.slno];
    cell.longDetailLabel.text = [NSString stringWithFormat:@"%ld",reportFormShareSLPiecesmodel.lenght];
    
    CGSize  size1 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%ld",reportFormShareSLPiecesmodel.lenght] andFont:[UIFont systemFontOfSize:14]];
    cell.longDetailLabel.sd_layout
    .widthIs(size1.width);
    
    
    cell.wideDetialLabel.text =  [NSString stringWithFormat:@"%ld",reportFormShareSLPiecesmodel.width];
    
    CGSize size2 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%ld",reportFormShareSLPiecesmodel.width] andFont:[UIFont systemFontOfSize:14]];
    cell.wideDetialLabel.sd_layout
    .widthIs(size2.width);
    
    cell.thickDeitalLabel.text =  [NSString stringWithFormat:@"%ld",reportFormShareSLPiecesmodel.height];
    CGSize size3 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%ld",reportFormShareSLPiecesmodel.height] andFont:[UIFont systemFontOfSize:14]];
    cell.thickDeitalLabel.sd_layout
    .widthIs(size3.width);
    
    cell.originalAreaDetailLabel.text =  [NSString stringWithFormat:@"%0.3lf",[reportFormShareSLPiecesmodel.prearea doubleValue]];
    CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[reportFormShareSLPiecesmodel.prearea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.originalAreaDetailLabel.sd_layout
    .widthIs(size4.width);
    
    cell.deductionAreaDetailLabel.text =  [NSString stringWithFormat:@"%0.3lf",[reportFormShareSLPiecesmodel.dedarea doubleValue]];
    CGSize size5 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[reportFormShareSLPiecesmodel.dedarea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.deductionAreaDetailLabel.sd_layout
    .widthIs(size5.width);
    cell.actualAreaDetailLabel.text =  [NSString stringWithFormat:@"%0.3lf",[reportFormShareSLPiecesmodel.area doubleValue]];
    CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[reportFormShareSLPiecesmodel.area doubleValue]] andFont:[UIFont systemFontOfSize:14]];
    cell.actualAreaDetailLabel.sd_layout
    .widthIs(size6.width);
    if (reportFormShareSLPiecesmodel.isSelect) {
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
    
    RSReportFormShareSLModel * reportFormShareSLmodel = self.detialArray[cell.tag];
    RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel = reportFormShareSLmodel.pieces[selectBtn.tag];
    
   // RSEntryDetailModel * selectdabanslmodel = self.detialArray[cell.tag];
   // RSSLStoragemanagementModel * slstoragemanagementmodel = selectdabanslmodel.contentArray[selectBtn.tag];
    selectBtn.selected = !selectBtn.selected;
    if (selectBtn.selected) {
        reportFormShareSLPiecesModel.isSelect = true;
        [self.selectArray addObject:reportFormShareSLPiecesModel];
    }else{
        reportFormShareSLPiecesModel.isSelect = false;
        for (int i = 0; i < self.selectArray.count; i++) {
            RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel1 = self.selectArray[i];
            if (reportFormShareSLPiecesModel1.did == reportFormShareSLPiecesModel.did) {
                [self.selectArray removeObjectAtIndex:i];
                break;
            }
        }
    }
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:cell.tag] withRowAnimation:UITableViewRowAnimationNone];
}



- (void)headerButtonOnClick:(UIButton *)button {
//    RSEntryDetailModel * selectdabanslmodel = self.detialArray[button.tag];
    RSReportFormShareSLModel * reportFormShareSLmodel = self.detialArray[button.tag];
  //  RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel = reportFormShareSLmodel.pieces[selectBtn.tag];
    button.selected = !button.selected;
    if (button.selected) {
        for (int i = 0; i < reportFormShareSLmodel.pieces.count; i++) {
            RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel = reportFormShareSLmodel.pieces[i];
            if(reportFormShareSLPiecesModel.isSelect) {
                reportFormShareSLPiecesModel.isSelect = true;
            }else{
                [self.selectArray addObject:reportFormShareSLPiecesModel];
                reportFormShareSLPiecesModel.isSelect = true;
            }
        }
    }else {
        for (int i = 0; i < reportFormShareSLmodel.pieces.count; i++) {
            RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel = reportFormShareSLmodel.pieces[i];
            reportFormShareSLPiecesModel.isSelect = false;
            //[self.selectArray addObject:@(slstoragemanagementmodel.did)];
        }
        for (int i = 0; i < self.selectArray.count; i++) {
            RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel1 = self.selectArray[i];
            for (int j = 0; j < reportFormShareSLmodel.pieces.count; j++) {
                 RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel = reportFormShareSLmodel.pieces[j];
                if (reportFormShareSLPiecesModel1.did == reportFormShareSLPiecesModel.did) {
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

/**
 RSReportFormShareSLModel * reportFormShareSLmodel = [[RSReportFormShareSLModel alloc]init];
                reportFormShareSLmodel.csid = reportFormShareSLPiecesModel1.csid;
                reportFormShareSLmodel.deaName = reportFormShareSLPiecesModel1.deaName;
                reportFormShareSLmodel.materialtype = reportFormShareSLPiecesModel1.materialtype;
                reportFormShareSLmodel.msid = reportFormShareSLPiecesModel1.msid;
                reportFormShareSLmodel.mtlname = reportFormShareSLPiecesModel1.mtlname;
                reportFormShareSLmodel.n = 1;
                //reportFormShareSLmodel.qty = 1;
                reportFormShareSLmodel.turnsno = reportFormShareSLPiecesModel1.turnsno;
                [reportFormShareSLmodel.pieces addObject:reportFormShareSLPiecesModel1];
 
*/

- (NSMutableArray *)changeArrayRule:(NSArray *)contentarray{
    NSMutableArray *dateMutablearray = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray arrayWithArray:contentarray];
    for (int i = 0; i < array.count; i ++) {
        //NSString *string = array[i];
        RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel = array[i];
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObject:reportFormShareSLPiecesModel];
        for (int j = i+1;j < array.count; j ++) {
            RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel1 = array[j];
            if([reportFormShareSLPiecesModel1.turnsno isEqualToString:reportFormShareSLPiecesModel.turnsno]){
                [tempArray addObject:reportFormShareSLPiecesModel1];
                [array removeObjectAtIndex:j];
                j = j - 1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    
    NSMutableArray * resultArray = [NSMutableArray array];
    for (int i = 0; i < dateMutablearray.count; i++) {
        RSReportFormShareSLModel * reportFormShareSLmodel = [[RSReportFormShareSLModel alloc]init];
        NSMutableArray * array = dateMutablearray[i];
        RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel = array[0];
        reportFormShareSLmodel.csid = reportFormShareSLPiecesModel.csid;
        reportFormShareSLmodel.deaName = reportFormShareSLPiecesModel.deaName;
        reportFormShareSLmodel.materialtype = reportFormShareSLPiecesModel.materialtype;
        reportFormShareSLmodel.msid = reportFormShareSLPiecesModel.msid;
        reportFormShareSLmodel.mtlname = reportFormShareSLPiecesModel.mtlname;
        reportFormShareSLmodel.n = 1;
        //reportFormShareSLmodel.qty = 1;
        reportFormShareSLmodel.turnsno = reportFormShareSLPiecesModel.turnsno;
        [reportFormShareSLmodel.pieces addObjectsFromArray:array];
        reportFormShareSLmodel.qty = array.count;
        double newArea = 0.0;
        for (int j = 0; j < array.count; j++) {
            RSReportFormShareSLPiecesModel * reportFormShareSLPiecesModel = array[j];
            newArea += [reportFormShareSLPiecesModel.prearea doubleValue];
        }
        //reportFormShareSLmodel.area = [self number:newArea preciseDecimal:3];
       // NSString * area = [self number:newArea preciseDecimal:3];
       
        NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
          NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:newArea];
          NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
        reportFormShareSLmodel.area = roundedOunces;
        [resultArray addObject:reportFormShareSLmodel];
    }
    return resultArray;
}


- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
}



//- (NSString *)number:(double)x preciseDecimal:(NSUInteger)p {
//    //    四舍五入
//    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:p raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
//    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:x];
//    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
//    //    生成需要精确的小数点格式，
//    //    比如精确到小数点第3位，格式为“0.000”；精确到小数点第4位，格式为“0.0000”；
//    //    也就是说精确到第几位，小数点后面就有几个“0”
//    NSMutableString *formatterString = [NSMutableString stringWithString:@"0."];
//    for (NSInteger i = 0; i < p; ++i) {
//        [formatterString appendString:@"0"];
//    }
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    //    设置生成好的格式，
//    [formatter setPositiveFormat:formatterString];
//    //    然后把这个number 对象格式化成我们需要的格式，
//    //    最后以string 类型返回结果。
//    return [formatter stringFromNumber:roundedOunces];
//}




// - (NSMutableArray *)changeArrayRule:(NSArray *)contentarray{
//     NSMutableArray *dateMutablearray = [NSMutableArray array];
//     NSMutableArray *array = [NSMutableArray arrayWithArray:contentarray];
//     for (int i = 0; i < array.count; i ++) {
//         //NSString *string = array[i];
//         RSSLStoragemanagementModel * slstoragemanagementmodel = array[i];
//         NSMutableArray *tempArray = [NSMutableArray array];
//         [tempArray addObject:slstoragemanagementmodel];
//         for (int j = i+1;j < array.count; j ++) {
//             RSSLStoragemanagementModel * slstoragemanagementmodel1 = array[j];
//             if([slstoragemanagementmodel1.mtlName isEqualToString:slstoragemanagementmodel.mtlName] && [slstoragemanagementmodel1.turnsNo isEqualToString:slstoragemanagementmodel.turnsNo] && [slstoragemanagementmodel1.blockNo isEqualToString:slstoragemanagementmodel.blockNo]){
//                 [tempArray addObject:slstoragemanagementmodel1];
//                 [array removeObjectAtIndex:j];
//                 j = j - 1;
//             }
//         }
//         [dateMutablearray addObject:tempArray];
//     }
//     return dateMutablearray;
// }



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
