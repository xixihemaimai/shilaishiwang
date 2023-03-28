//
//  RSStockViewController.m
//  石来石往
//
//  Created by mac on 17/5/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSStockViewController.h"
#import "RSFirstHeaderSectionView.h"
#import "RSStockSectionView.h"
#import "RSStockCell.h"
#import "RSInformationCell.h"

#import "RSSituationCell.h"
//荒料
#import "RSBlockOutViewController.h"
//大板
#import "RSOsakaViewController.h"

//结算中心
#import "RSSettlementViewController.h"
//等级评定
#import "RSRatingViewController.h"

//出货记录
#import "RSShippingRecordViewController.h"


//模型
#import "RSInformationModel.h"
#import "RSStockModel.h"


//H5页面
#import "RSCompayWebviewViewController.h"
//更多
#import "RSMoreDetailViewController.h"
//报表中心
#import "RSReportFormController.h"

#import "RSAllowView.h"


//服务中心
#import "RSPersonalServiceViewController.h"
#import "RSServiceCentreVViewController.h"
//石种图片上传
#import "RSStonePictureMangerViewController.h"
//工程案例
#import "RSEngineeringCaseViewController.h"
//权限管理
#import "RSPermissionsViewController.h"


//淘宝
#import "RSTaobaoDistrictViewController.h"
//现货搜索
#import "RSHSViewController.h"
//大众云仓
//审核中
#import "RSShowAuditiewController.h"
//审核通过
#import "RSPersonalEditionViewController.h"

//商圈
#import "RSAllHomeViewController.h"
//我的
#import "RSLeftViewController.h"

//银行卡部分
#import "RSPaymentViewController.h"
//市场投诉
#import "RSMarketComplaintViewController.h"


@interface RSStockViewController ()<RSStockCellDelegate,RSInformationCellDelegate>
{
    UIView *_naviBarview;
    //这个是选择按片还是按匝的蒙版
    UIView *_menuview;
    //这个是按片还是按匝的选择view
    UIView *_choiceview;
    //这个是选择等级评定的蒙版
    UIView *_grademenuview;
    //这个是选择等级评定是选择按大板还是荒料
    UIView * _gradechoiceview;
    
}

//@property (nonatomic,strong)UITableView *tableview;
/**第二个库存情况的图片数组*/
@property (nonatomic,strong)NSArray *imageArray;
/**第二个库存情况的图片文字*/
@property (nonatomic,strong)NSArray *titleArray;

@property (nonatomic,strong)NSMutableArray * informationArray;

@property (nonatomic,strong)RSStockModel * stockModel;

@property (nonatomic,strong)RSAllowView * allowview;

@property (nonatomic,strong)RSRightNavigationButton * rightBtn;

@end

@implementation RSStockViewController

- (NSMutableArray *)informationArray{
    if (_informationArray == nil) {
        _informationArray = [NSMutableArray array];
    }
    return _informationArray;
}

- (RSAllowView *)allowview{
    if (_allowview == nil) {
        _allowview = [[RSAllowView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
        _allowview.bLabel.text = [NSString stringWithFormat:@"乙方:%@",[UserManger getUserObject].userName];
//        [self.view addSubview:_allowview];
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_allowview];
    }
    return _allowview;
}


- (NSArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = @[@"img_kucun_all",@"img_kucun_out",@"img_kucun_in"];
    }
    return _imageArray;
}


- (NSArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = @[@"总库存量",@"今日出库",@"今日入库"];
    }
    return _titleArray;
}


static NSString *stockFirstSection = @"stockfirst";
static NSString *stockSectonID = @"stocksection";
static NSString *stockCellID = @"stockcell";
static NSString *firstCellID = @"firstcell";
static NSString * secondCellID = @"secondCellID";
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
////    self.navigationController.navigationBar.hidden = NO;
//    // self.hidesBottomBarWhenPushed = YES;
//    //    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    //    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
//    //    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isAddjust];
    [self.view addSubview:self.tableview];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    
    
    for (int i = 0; i < [UserManger getUserObject].erpUserList.count; i++) {
    RSErpUserListModel * erpUserlistmodel = [UserManger getUserObject].erpUserList[i];
        if ([[UserManger getUserObject].curErpUserCode isEqualToString:erpUserlistmodel.erpUserCode]) {
            self.title = erpUserlistmodel.erpUserName;
        }
    } 
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpMoreViewController:) name:@"jumpMoreViewController" object:nil];
    
    
    //添加了表头视图
//    [self addCustomTableHeaderview];
    
    //获取海西资讯信息
    [self obtainOwnerInformation];
    //获取海西货主出库记录
    [self obtainOwnerStock];
    
    
    
    
    [self.allowview.noagreeBtn addTarget:self action:@selector(noagreeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.allowview.agreenBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    RSRightNavigationButton * rightBtn = [[RSRightNavigationButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightBtn setImage:[UIImage imageNamed:@"石来石往图标设计_42"] forState:UIControlStateNormal];
    UIBarButtonItem * tiem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(jumpQxglAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = tiem;
    _rightBtn = rightBtn;
    
    //这里要判断是否要显示授权的界面
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSDate * oneWeekdate = [user objectForKey:@"showAuthorization"];
    NSDate * currentDate = [NSDate date];
    if ([self oneWeekCompareCurrentTimeDate:currentDate andOneweekData:oneWeekdate] == -1) {
        self.allowview.hidden = YES;
        self.tableview.hidden = NO;
//        if (self.userModel.appManage_qxgl == 1 ) {
//            _rightBtn.hidden = NO;
//        }else{
//            _rightBtn.hidden = YES;
//        }
    }else{
        self.allowview.hidden = NO;
        self.tableview.hidden = YES;
//        _rightBtn.hidden = YES;
    }
    _rightBtn.hidden = NO;
    
    //    if (![[user objectForKey:@"showAuthorization"] isEqual:@"1"]) {
    //        self.allowview.hidden = NO;
    //        self.tableview.hidden = YES;
    //        _rightBtn.hidden = YES;
    //    }else{
    //        self.allowview.hidden = YES;
    //        self.tableview.hidden = NO;
    //        if (self.userModel.appManage_qxgl == 1 ) {
    //            _rightBtn.hidden = NO;
    //        }else{
    //            _rightBtn.hidden = YES;
    //        }
    //    }
}

//权限管理
- (void)jumpQxglAction:(UIButton *)rightBtn{
    RSPermissionsViewController * permissionsVc = [[RSPermissionsViewController alloc]init];
//    NSLog(@"===============================%ld",self.userModel.erpUserList.count);
    permissionsVc.userModel = [UserManger getUserObject];
    RSWeakself
    permissionsVc.selectUser = ^(RSUserModel *usermodel,NSString * titleStr) {
//        weakSelf.userModel = usermodel;
        weakSelf.title = titleStr;
        [weakSelf obtainOwnerStock];
//        AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        RSMainTabBarViewController * mainTabbar = (RSMainTabBarViewController *)app.window.rootViewController;
//        for (int i = 0; i < mainTabbar.viewControllers.count; i++) {
//            RSMyNavigationViewController * myNav = mainTabbar.viewControllers[i];
//            mainTabbar.selectedIndex = i;
//            if (i == 0) {
//                //首页是淘宝
//                RSTaobaoDistrictViewController * taobaoDistrictVc = myNav.viewControllers[0];
////                taobaoDistrictVc.usermodel = usermodel;
////                NSLog(@"==============0000=====%@",taobaoDistrictVc.usermodel.curErpUserCode);
////                if ([taobaoDistrictVc isViewLoaded]) {
////                    for (UIView * view in taobaoDistrictVc.view.subviews) {
////                        [view removeFromSuperview];
////                    }
////                    [taobaoDistrictVc viewDidLoad];
////                }
//            }else if (i == 1){
//                //现货搜索
//                RSHSViewController * hsVc = myNav.viewControllers[0];
////                hsVc.userModel = usermodel;
////                NSLog(@"==============1111=====%@",hsVc.userModel.curErpUserCode);
////                if ([hsVc isViewLoaded]) {
////                    for (UIView * view in hsVc.view.subviews) {
////                        [view removeFromSuperview];
////                    }
////                    [hsVc viewDidLoad];
////                }
//            }else if (i == 2){
//                //大众云仓
//                //  RSTaobaoDistrictViewController * taobaoDistrictVc = myNav.viewControllers[0];
//                if ([[myNav.viewControllers objectAtIndex:0] class] == [RSShowAuditiewController class]) {
//                    RSShowAuditiewController * showAuditiewVc = myNav.viewControllers[0];
////                    showAuditiewVc.usermodel = usermodel;
////                    NSLog(@"==============2222=====%@",showAuditiewVc.usermodel.curErpUserCode);
////                    if ([showAuditiewVc isViewLoaded]) {
////                        for (UIView * view in showAuditiewVc.view.subviews) {
////                            [view removeFromSuperview];
////                        }
////                        [showAuditiewVc viewDidLoad];
////                    }
//                }else{
//                    RSPersonalEditionViewController * personalVc = myNav.viewControllers[0];
////                    personalVc.usermodel = usermodel;
////                    NSLog(@"==============2222=====%@",personalVc.usermodel.curErpUserCode);
////                    if ([personalVc isViewLoaded]) {
////                        for (UIView * view in personalVc.view.subviews) {
////                            [view removeFromSuperview];
////                        }
////                        [personalVc viewDidLoad];
////                    }
//                }
//            }else if (i == 3){
//                //商圈
//                RSAllHomeViewController * allHomeVc = myNav.viewControllers[0];
////                allHomeVc.userModel = usermodel;
////                NSLog(@"==============3333=====%@",allHomeVc.userModel.curErpUserCode);
////                if ([allHomeVc isViewLoaded]) {
////                    for (UIView * view in allHomeVc.view.subviews) {
////                        [view removeFromSuperview];
////                    }
////                    [allHomeVc viewDidLoad];
////                }
//            }else{
//                //我的
//                RSLeftViewController * leftVc = myNav.viewControllers[0];
////                leftVc.userModel = usermodel;
////                NSLog(@"==============4444=====%@",leftVc.userModel.curErpUserCode);
//                if ([leftVc isViewLoaded]) {
//                    for (UIView * view in leftVc.view.subviews) {
//                        [view removeFromSuperview];
//                    }
//                    [leftVc viewDidLoad];
//                }
//            }
//        }
    };
    [self.navigationController pushViewController:permissionsVc animated:YES];
}
#pragma mark -- 不同意
- (void)noagreeAction:(UIButton *)noagreeBtn{
    self.allowview.hidden = YES;
    _rightBtn.hidden = YES;
    //NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [self getCurrentTime];
    // [user setObject:@"0" forKey:@"showAuthorization"];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 同意
- (void)agreeAction:(UIButton *)agreeBtn{
    self.allowview.hidden = YES;
    self.tableview.hidden = NO;
//    if (self.userModel.appManage_qxgl == 1 ) {
        _rightBtn.hidden = NO;
    //}else{
//        _rightBtn.hidden = YES;
//    }
    //NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    //[user setObject:@"1" forKey:@"showAuthorization"];
    [self currentOneWeekTime];
}

#pragma mark -- 获取海西资讯信息接口
//URL_HAIXI_INFORMATION
- (void)obtainOwnerInformation{
    //[SVProgressHUD showWithStatus:@"正在获取海西资讯"];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"1" forKey:@"erpId"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"pageNum"];
    [dict setObject:[NSString stringWithFormat:@"3"] forKey:@"pageSize"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"status"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HAIXI_INFORMATION_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray *array = nil;
                array = json[@"Data"];
                [weakSelf.informationArray removeAllObjects];
                for (int i = 0; i < array.count; i++) {
                    RSInformationModel *informationModel = [[RSInformationModel alloc]init];
                    informationModel.publisher = [[array objectAtIndex:i] objectForKey:@"publisher"];
                    informationModel.publishTime = [[array objectAtIndex:i]objectForKey:@"publishTime"];
                    informationModel.title = [[array objectAtIndex:i]objectForKey:@"title"];
                    informationModel.type = [[array objectAtIndex:i]objectForKey:@"type"];
                    //informationModel.url = [[array objectAtIndex:i]objectForKey:@"url"];
                    informationModel.newsId = [[[array objectAtIndex:i]objectForKey:@"newsId"] integerValue];
                    [weakSelf.informationArray addObject:informationModel];
                }
                [weakSelf.tableview reloadData];
                // [SVProgressHUD dismiss];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取资讯失败"];
                //  [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取资讯失败"];
        }
    }];
}

#pragma mark --- 获取海西货主库存数据
//URL_GET_HAIXI_PERSONAL_DATA
- (void)obtainOwnerStock{
    //  [SVProgressHUD showWithStatus:@"正在获取海西库存数据"];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //[dict setObject:self.userID forKey:@"ERPCODE"];
    [dict setObject:[UserManger getUserObject].userID forKey:@"userId"];
    [dict setObject:@"1" forKey:@"erpId"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    //URL_GET_HAIXI_PERSONAL_DATA_IOS URL_GET_HAIXI_PERSONAL_DATA
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    NSLog(@"======1111===========%@",parameters);
   
    [network getDataWithUrlString:URL_GET_HAIXI_PERSONAL_DATA_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
//             NSLog(@"=++++=+++++++++++++++++++++=%@",json);
            /*
             if ([json[@"MSG_CODE"] isEqualToString:@"U_NOT_LOGIN"]) {
             [SVProgressHUD showErrorWithStatus:@"请重新登录"];
             
             [self.navigationController popViewControllerAnimated:YES];
             [[NSNotificationCenter defaultCenter]postNotificationName:@"backMainHomeViewController" object:nil];
             }
             */
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableDictionary *dict = nil;
                dict = json[@"Data"];
                weakSelf.stockModel = [[RSStockModel alloc]init];
                weakSelf.stockModel .blockInstoreVolume = dict[@"blockInstoreVolume"];
                weakSelf.stockModel .blockNum = [dict[@"blockNum"] integerValue];
                weakSelf.stockModel .blockOutstoreVolume = dict[@"blockOutstoreVolume"];
                weakSelf.stockModel .blockVolume = dict[@"blockVolume"];
                weakSelf.stockModel .plateArea = dict[@"plateArea"];
                weakSelf.stockModel .plateInstoreArea = dict[@"plateInstoreArea"];
                weakSelf.stockModel .plateNum = [dict[@"plateNum"] integerValue];
                weakSelf.stockModel .plateOutstoreArea = dict[@"plateOutstoreArea"];
//                [user setObject:self.userID forKey:@"userID"];
//                [user synchronize];
                [weakSelf.tableview reloadData];
                //     [SVProgressHUD showSuccessWithStatus:@"获取数据成功"];
            }
            else{
                [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
                [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        }
    }];
}

//- (void)addCustomTableHeaderview{
//    CGFloat Y;
//    if (iPhoneX_All) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
//    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Y, SCW, SCH - Y) style:UITableViewStyleGrouped];
//    [self.view addSubview:self.tableview];
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    // self.tableview.scrollEnabled = NO;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    // 设置tableView的内边距
//    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, Y, 0);
//    self.tableview.hidden = YES;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RSInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellID];
        if (!cell) {
            cell = [[RSInformationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:firstCellID];
        }
        //RSInformationModel * informationModel = self.informationArray[indexPath.row];
        //cell.informationModel = informationModel;
        cell.dataArray = self.informationArray;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        RSSituationCell *cell = [tableView dequeueReusableCellWithIdentifier:stockCellID];
        if (!cell) {
            cell = [[RSSituationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stockCellID];
            cell.imageview.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
            //cell.backgroundColor = [UIColor darkGrayColor];
            cell.label.text = self.titleArray[indexPath.row];
        }
        if (indexPath.row == 0) {
            cell.keLabel.text = [NSString stringWithFormat:@"%ld颗",(long)self.stockModel.blockNum];
            CGFloat blockNumber = [[NSString stringWithFormat:@"%@",self.stockModel.blockVolume] floatValue];
            cell.liLabel.text = [NSString stringWithFormat:@"%.3lfm³",blockNumber];
            cell.zaLabel.text = [NSString stringWithFormat:@"%ld匝",(long)self.stockModel.plateNum];
            CGFloat plateNumber = [[NSString stringWithFormat:@"%@",self.stockModel.plateArea] floatValue];
            cell.piLabel.text = [NSString stringWithFormat:@"%.3lfm²",plateNumber];
        }
        if (indexPath.row == 1) {
            cell.keLabel.hidden = YES;
            cell.zaLabel.hidden = YES;
          
            cell.liLabel.sd_layout
            .leftSpaceToView(cell.blockLabel,27.5);
            cell.piLabel.sd_layout
            .leftSpaceToView(cell.osakaLabel,27.5);
            
            cell.liLabel.text = [NSString stringWithFormat:@"%@m³",self.stockModel.blockOutstoreVolume];
            cell.piLabel.text = [NSString stringWithFormat:@"%@m²",self.stockModel.plateOutstoreArea];
        }
        if (indexPath.row == 2) {
            cell.keLabel.hidden = YES;
            cell.zaLabel.hidden = YES;
           
            cell.liLabel.sd_layout
            .leftSpaceToView(cell.blockLabel,27.5);
            cell.piLabel.sd_layout
            .leftSpaceToView(cell.osakaLabel,27.5);
            
            cell.liLabel.text = [NSString stringWithFormat:@"%@m³",self.stockModel.blockInstoreVolume];
            cell.piLabel.text = [NSString stringWithFormat:@"%@m²",self.stockModel.plateInstoreArea];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        RSStockCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellID];
        if (!cell) {
            cell = [[RSStockCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:secondCellID];
        }
        //cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f3f3f3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        RSFirstHeaderSectionView * fistHeaderview = [[RSFirstHeaderSectionView alloc]initWithReuseIdentifier:stockFirstSection];
        fistHeaderview.contentView.backgroundColor = [UIColor whiteColor];
        fistHeaderview.imageview.image = [UIImage imageNamed:@"海西资讯"];
        return  fistHeaderview;
    }else if(section == 1){
        RSStockSectionView * stockSectionview = [[RSStockSectionView alloc]initWithReuseIdentifier:stockSectonID];
        stockSectionview.view.sd_layout
        .heightIs(0.5);
        stockSectionview.contentView.backgroundColor = [UIColor whiteColor];
        stockSectionview.sectionImageview.image = [UIImage imageNamed:@"img_kucun_qingkuang"];
        return stockSectionview;
    }else{
        RSStockSectionView * stockSectionview = [[RSStockSectionView alloc]initWithReuseIdentifier:stockSectonID];
        stockSectionview.view.sd_layout
        .heightIs(0);
        stockSectionview.contentView.backgroundColor = [UIColor whiteColor];
        stockSectionview.sectionImageview.image = [UIImage imageNamed:@"业务办理-拷贝"];
        return stockSectionview;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 34;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 107.5;
    }else if(indexPath.section == 1){
        return 50;
    }else{
        return 400;
    }
}

#pragma mark -- 和H5交互
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        RSInformationModel * informationModel = self.informationArray[indexPath.row];
        RSCompayWebviewViewController * companyVc = [[RSCompayWebviewViewController alloc]init];
        companyVc.showRightBtn = NO;
        companyVc.titleStr = @"海西货主";
        //域名 +  '/slsw/newDetail.html?newId=' + newId
        companyVc.urlStr = [NSString stringWithFormat:@"%@/slsw/newDetail.html?newId=%ld",URL_HEADER_TEXT_IOS,informationModel.newsId];
        //[self presentViewController:companyVc animated:YES completion:nil];
        [self.navigationController pushViewController:companyVc animated:YES];
    }
}


//- (void)sendH5Url:(NSString *)url{
//
//
//    RSCompayWebviewViewController * companyVc = [[RSCompayWebviewViewController alloc]init];
//    companyVc.showRightBtn = NO;
//    companyVc.titleStr = @"海西货主";
//    //companyVc.urlStr = [NSString stringWithFormat:@"%@",url];
//
//      companyVc.urlStr = [NSString stringWithFormat:@"%@/slsw/newDetail.html?newId=%ld",URL_HEADER_TEXT_IOS,informationModel.newsId];
//
//    //[self presentViewController:companyVc animated:YES completion:nil];
//    [self.navigationController pushViewController:companyVc animated:YES];
//
//}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        
//        RSInformationModel * informationModel = self.informationArray[indexPath.row];
//        
//        RSCompayWebviewViewController * companyVc = [[RSCompayWebviewViewController alloc]init];
//        companyVc.showRightBtn = NO;
//        
//        companyVc.titleStr = @"海西货主";
//        companyVc.urlStr = [NSString stringWithFormat:@"%@",informationModel.url];
//        
//        [self presentViewController:companyVc animated:YES completion:nil];
//        
//        
//        
//    }
//    
//    
//    
//}

- (void)choiceNeedButton:(UIButton *)btn{
    if (btn.tag == 10000) {
        //self.userModel.access.appManage_ywbl_hlck == 1
        if ([UserManger getUserObject].appManage_ywbl_hlck == 1) {
            //这边要做一个判断当小于5的时候
            //            if (self.stockModel.blockNum <= 5) {
            //                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"系统检测到你的荒料库存不足5颗，请拨打059526588686，联系海西招商部协商出库事宜" preferredStyle:UIAlertControllerStyleAlert];
            //
            //                //alert.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ff5f04"];
            //                UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            //                [alert addAction:actionConfirm];
            //                [self presentViewController:alert animated:YES completion:nil];
            //
            //            }else{
            //荒料出库的界面
            RSBlockOutViewController *blockOutVc = [[RSBlockOutViewController alloc]init];
            //参数，需要用到
//            blockOutVc.userID = self.userID;
//            blockOutVc.userModel = [UserManger getUserObject];
            [self.navigationController pushViewController:blockOutVc animated:YES];
            //}
        }else{
            [SVProgressHUD showInfoWithStatus:@"货主没有给你这个权限"];
        }
    }else if (btn.tag == 10001){
        //大板出库
        //跳转到大板的界面
        //self.userModel.access.appManage_ywbl_dbck == 1
        if ([UserManger getUserObject].appManage_ywbl_dbck == 1) {
            UIView *menuview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
            menuview.backgroundColor = [[UIColor darkGrayColor]colorWithAlphaComponent:0.5];
            [self.view addSubview:menuview];
            _menuview = menuview;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelChoice)];
            [menuview addGestureRecognizer:tap];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIView * choiceview = [[UIView alloc]init];
                _choiceview = choiceview;
                choiceview.layer.cornerRadius = 5;
                choiceview.layer.masksToBounds = YES;
                choiceview.backgroundColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0];
                [self.view addSubview:choiceview];
                
                choiceview.sd_layout
                .centerYEqualToView(self.view)
                .centerXEqualToView(self.view)
                .leftSpaceToView(self.view,12)
                .rightSpaceToView(self.view,12)
                .heightIs(220);
                
                UILabel * label = [[UILabel alloc]init];
                label.text = @"请选择出库的类型";
                label.font = [UIFont systemFontOfSize:15];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor =[UIColor colorWithHexColorStr:@"#999999"];
                [choiceview addSubview:label];
                
                label.sd_layout
                .centerXEqualToView(choiceview)
                .topSpaceToView(choiceview,20)
                .heightRatioToView(choiceview,0.2)
                .widthIs(SCW);
                
                //按片
                UIButton * sliceBtn = [[UIButton alloc]init];
                [sliceBtn setImage:[UIImage imageNamed:@"img_new_plate"] forState:UIControlStateNormal];
                sliceBtn.layer.cornerRadius = 3;
                sliceBtn.layer.masksToBounds = YES;
                [choiceview addSubview:sliceBtn];
                sliceBtn.tag = 2;
                [sliceBtn addTarget:self action:@selector(choiceShippingMethodWithBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *sliceLabel = [[UILabel alloc]init];
                sliceLabel.text = @"按片";
                sliceLabel.textAlignment = NSTextAlignmentCenter;
                sliceLabel.textColor = [UIColor whiteColor];
                sliceLabel.font = [UIFont systemFontOfSize:14];
                [_choiceview addSubview:sliceLabel];
                
                UIView * midview = [[UIView alloc]init];
                midview.backgroundColor = [UIColor whiteColor];
                [_choiceview addSubview:midview];
                
                midview.sd_layout
                .centerXEqualToView(_choiceview)
                .centerYEqualToView(_choiceview)
                .topSpaceToView(label,10)
                .bottomSpaceToView(_choiceview,30)
                .widthIs(2);
                
                UIButton * turnBtn = [[UIButton alloc]init];
                [turnBtn setImage:[UIImage imageNamed:@"img_new_slab"] forState:UIControlStateNormal];
                turnBtn.layer.cornerRadius = 3;
                turnBtn.layer.masksToBounds = YES;
                [choiceview addSubview:turnBtn];
                turnBtn.tag = 3;
                [turnBtn addTarget:self action:@selector(choiceShippingMethodWithBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * turnLabel = [[UILabel alloc]init];
                turnLabel.text = @"按匝";
                turnLabel.textAlignment = NSTextAlignmentCenter;
                turnLabel.textColor = [UIColor whiteColor];
                turnLabel.font = [UIFont systemFontOfSize:14];
                [_choiceview addSubview:turnLabel];
                
                sliceBtn.sd_layout
                .topSpaceToView(label,10)
                .leftSpaceToView(choiceview,30)
                .widthIs(80)
                .heightIs(80);
                
                turnBtn.sd_layout
                .topEqualToView(sliceBtn)
                .bottomEqualToView(sliceBtn)
                .widthIs(80)
                .rightSpaceToView(choiceview,30);
                
                sliceLabel.sd_layout
                .leftEqualToView(sliceBtn)
                .rightEqualToView(sliceBtn)
                .heightIs(20)
                .topSpaceToView(sliceBtn,5);
                
                turnLabel.sd_layout
                .leftEqualToView(turnBtn)
                .rightEqualToView(turnBtn)
                .heightIs(20)
                .topSpaceToView(turnBtn,5);
            });
        }else{
            [SVProgressHUD showInfoWithStatus:@"货主没有给你这个权限"];
        }
    }else if (btn.tag == 10002){
        //报表中心
        if ([UserManger getUserObject].appManage_ywbl_bbzx == 1) {
            RSReportFormController * reportFormVc = [[RSReportFormController alloc]init];
//            reportFormVc.usermodel = [UserManger getUserObject];
            [self.navigationController pushViewController:reportFormVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"货主没有给你这个权限"];
        }
    }else if(btn.tag == 10003){
        //出货记录
        //self.userModel.access.appManage_ywbl_ckjl == 1
        if ([UserManger getUserObject].appManage_ywbl_ckjl == 1) {
            RSShippingRecordViewController *shippingRecordVc = [[RSShippingRecordViewController alloc]init];
            shippingRecordVc.userID = [UserManger getUserObject].userID;
            shippingRecordVc.usermodel = [UserManger getUserObject];
            [self.navigationController pushViewController:shippingRecordVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"货主没有给你这个权限"];
        }
    }else if (btn.tag == 10004){
        //服务中心
        if ([UserManger getUserObject].appManage_wdfw == 1) {
            //            if ([self.userModel.userType isEqualToString:@"ckfw"] || [self.userModel.userType isEqualToString:@"scfw"]) {
            //                RSPersonalServiceViewController * personalServiceVc = [[RSPersonalServiceViewController alloc]init];
            //                personalServiceVc.usermodel = self.userModel;
            //                //personalServiceVc.hidesBottomBarWhenPushed = YES;
            //                [self.navigationController pushViewController:personalServiceVc animated:YES];
            //            //}else{
            RSServiceCentreVViewController * serviceCentreVc = [[RSServiceCentreVViewController alloc]init];
            serviceCentreVc.usermodel = [UserManger getUserObject];
            //serviceCentreVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:serviceCentreVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"货主没有给你这个权限"];
        }
    }else if (btn.tag == 10005){
        //石种图片上传
        if ([UserManger getUserObject].appManage_tppp == 1) {
            RSStonePictureMangerViewController * stoneVc = [[RSStonePictureMangerViewController alloc]init];
            stoneVc.userModel = [UserManger getUserObject];
            //stoneVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:stoneVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"货主没有给你这个权限"];
        }
    }else if (btn.tag == 10006){
        //工程案例
        if ([UserManger getUserObject].appManage_gcal == 1) {
            RSEngineeringCaseViewController * engineeringCaseVc = [[RSEngineeringCaseViewController alloc]init];
            engineeringCaseVc.usermodel = [UserManger getUserObject];
            //engineeringCaseVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:engineeringCaseVc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"货主没有给你这个权限"];
        }
    }else if (btn.tag == 10007){
        //这边添加一个市场投诉
//        if ([UserManger getUserObject].appManage_gcal == 1) {
            
            
            
        RSMarketComplaintViewController * marketComplaintVc = [[RSMarketComplaintViewController alloc]init];
        marketComplaintVc.isShow = false;
            [self.navigationController pushViewController:marketComplaintVc animated:YES];
            
            
            
//        }else{
//            [SVProgressHUD showInfoWithStatus:@"货主没有给你这个权限"];
//        }
    }
//    else if (btn.tag == 10007){
//        //账单付款
//        RSPaymentViewController * payVc = [[RSPaymentViewController alloc]init];
//        [self.navigationController pushViewController:payVc animated:YES];
//    }
//    else{
//        //财务付款
//        RSPaymentViewController * payVc = [[RSPaymentViewController alloc]init];
//        [self.navigationController pushViewController:payVc animated:YES];
//    }
}

#pragma mark -- 是选择按片还是按匝出货
- (void)choiceShippingMethodWithBtn:(UIButton *)btn{
    if (btn.tag == 2) {
        //这边是按片的方式去选择
        [self jumpChoiceProductWithViewController:btn.tag andUserModel:[UserManger getUserObject]];
    }else if (btn.tag == 3){
        //这边是按匝的方式去选择
        [self jumpChoiceProductWithViewController:btn.tag andUserModel:[UserManger getUserObject]];
    }
}
#pragma mark -- 跳转到选择出货的方式要跳转到其他的界面
- (void)jumpChoiceProductWithViewController:(NSInteger)styleModel andUserModel:(RSUserModel *)userModel{
    //跳转到大板出货商品选择的界面
    RSOsakaViewController *osakaVc = [[RSOsakaViewController alloc]init];
    osakaVc.styleModel = styleModel;
    osakaVc.userModel = [UserManger getUserObject];
    //接口需要的参数，也是货主标识
    osakaVc.userID = [UserManger getUserObject].userID;
    [self.navigationController pushViewController:osakaVc animated:YES];
}
#pragma mark -- 选择跳转到评级等级界面，有按大板还是按荒料
- (void)choiceOsakaBtn:(UIButton *)btn{
    if (btn.tag == 2) {
        //这边是按大板的方式去选择
        [self jumpChoiceRatingViewController:@"daban"];
    }else if (btn.tag == 3){
        //这边是按荒料的方式去选择
        [self jumpChoiceRatingViewController:@"huangliao"];
    }
}
#pragma mark -- 选择跳转到评级等级界面，有按大板还是按荒料
- (void) jumpChoiceRatingViewController:(NSString *)productStyle{
    RSRatingViewController *ratingVc = [[RSRatingViewController alloc]init];
    ratingVc.choiceStyle = productStyle;
    [self.navigationController pushViewController:ratingVc animated:YES];
}
#pragma mark -- 跳转到更多的控制器中
- (void)jumpMoreViewController:(UIButton *)btn{
    //跳转到更多的地方
    RSMoreDetailViewController *moreDetailVc = [[RSMoreDetailViewController alloc]init];
    //把装有模型的数组赋值到更多的控制器中
    // moreDetailVc.modelDataArray = self.informationArray;
    //moreDetailVc.usermodel = [UserManger getUserObject];
    [self.navigationController pushViewController:moreDetailVc animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //要先清除之前选择的出货的方式的界面
    [_menuview removeFromSuperview];
    [_choiceview removeFromSuperview];
    [_grademenuview removeFromSuperview];
    [_gradechoiceview removeFromSuperview];
//    self.navigationController.navigationBar.hidden = NO;
    //[[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark -- 取消选择片数和匝数
- (void)cancelChoice{
    [_menuview removeFromSuperview];
    [_choiceview removeFromSuperview];
    [_gradechoiceview removeFromSuperview];
    [_grademenuview removeFromSuperview];
}
//获取7天之后的时间
- (void)currentOneWeekTime{
    NSDate * currentDate = [NSDate date];
    int days = 15;    // n天后的天数
    NSDate *appointDate;    // 指定日期声明
    NSTimeInterval oneDay = 24 * 60 * 60;  // 一天一共有多少秒
    appointDate = [currentDate initWithTimeIntervalSinceNow: oneDay * days];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    //if (![[user objectForKey:@"showAuthorization"] isEqual:@"1"]
    [user setObject:appointDate forKey:@"showAuthorization"];
    [user synchronize];
}
//得到当前的时间
- (void)getCurrentTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    //    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    //    NSString *dateString = [formatter stringFromDate:date];
    //    NSLog(@"datastring  = %@",dateString);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:date forKey:@"showAuthorization"];
    [user synchronize];
}
//判断7天之后是不是这个时间
- (int)oneWeekCompareCurrentTimeDate:(NSDate * )currentDate andOneweekData:(NSDate *)oneWeekDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *oneDayStr = [dateFormatter stringFromDate:currentDate];
    NSString *anotherDayStr = [dateFormatter stringFromDate:oneWeekDate];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"oneDay : %@, anotherDay : %@", currentDate, oneWeekDate);
    if (result == NSOrderedDescending) {
        //在指定时间前面 过了指定时间 过期
        NSLog(@"oneDay  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //没过指定时间 没过期
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //刚好时间一样.
    //NSLog(@"Both dates are the same");
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
