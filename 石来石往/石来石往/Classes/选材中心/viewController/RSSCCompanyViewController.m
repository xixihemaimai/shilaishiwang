//
//  RSSCCompanyViewController.m
//  石来石往
//
//  Created by mac on 2021/10/30.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCCompanyViewController.h"
#import "RSSCCompanyHeaderView.h"
#import "RSContactsActionView.h"

#import "RSNewCompanyViewController.h"
#import "RSSCCompanyHeaderModel.h"
#import "RSPublishingProjectCaseFirstButton.h"


@interface RSSCCompanyViewController()<YNPageViewControllerDelegate,YNPageViewControllerDataSource,RSSCCompanyHeaderViewDelegate,RSContactsActionViewDelegate>


@property (nonatomic,assign)NSInteger enterpriseId;

@end

@implementation RSSCCompanyViewController


+ (instancetype)suspendCenterPageVCWithEnterpriseId:(NSInteger)enterpriseId{
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleSuspensionTopPause;
    configration.headerViewCouldScale = YES;
//    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
    configration.showTabbar = NO;
//    configration.showScrollLine = YES;
    configration.showNavigation = YES;
    configration.showGradientColor = true;
    configration.itemFont = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
    configration.selectedItemFont = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightMedium];
    configration.lineLeftAndRightMargin = Width_Real(31);
    configration.lineBottomMargin = Height_Real(8);
    configration.lineHeight = Height_Real(3);
    configration.lineCorner = Width_Real(2);
    configration.normalItemColor = [UIColor colorFromHexString:@"#333333"];
    configration.selectedItemColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    configration.lineColor = [UIColor colorWithHexColorStr:@"#3385ff"];
//    configration.converColor = [UIColor colorFromHexString:@"#3385ff"];
//    configration.scrollViewBackgroundColor = [UIColor colorFromHexString:@"#3385ff"];
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = NO;
    RSSCCompanyViewController * vc = [RSSCCompanyViewController pageViewControllerWithControllers:[self getArrayVCsWithErpCodeStrWithEnterpriseId:enterpriseId]
                                                                                  titles:[self getArrayTitles]
                                                                                  config:configration];
    vc.dataSource = vc;
    vc.delegate = vc;
    
    vc.enterpriseId = enterpriseId;
    
    /// 指定默认选择index 页面
    RSSCCompanyHeaderView * companyHeaderView = [[RSSCCompanyHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCW, Height_Real(712)) withHeight:Height_Real(712) andEnterpriseId:enterpriseId];
    companyHeaderView.delegate = vc;
//    CLog(@"=========999999==================%lf",companyHeaderView.height);
//    [vc.headerView setNeedsLayout];
//    [vc.headerView layoutIfNeeded];
    companyHeaderView.yj_height = companyHeaderView.height;
    vc.headerView = companyHeaderView;
//    CLog(@"=========1111111==================%lf",companyHeaderView.height);
    vc.pageIndex = 0;
    [vc reloadData];
    return vc;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    //导航栏右边添加一个收藏
    
    RSPublishingProjectCaseFirstButton * collectionBtn = [[RSPublishingProjectCaseFirstButton alloc]init];
    collectionBtn.frame = CGRectMake(0, 0, 50, 50);
    [collectionBtn addTarget:self action:@selector(collectionCurrentCompanyAction:) forControlEvents:UIControlEventTouchUpInside];
    collectionBtn.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    [collectionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    [collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectionBtn setImage:[UIImage imageNamed:@"b27_icon_star_yellow"] forState:UIControlStateSelected];
    [collectionBtn setImage:[UIImage imageNamed:@"b27_icon_star_gray"] forState:UIControlStateNormal];
    collectionBtn.imageView.sd_layout.topSpaceToView(collectionBtn, 0).leftSpaceToView(collectionBtn, 62);
    collectionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    collectionBtn.titleLabel.sd_layout.topSpaceToView(collectionBtn.imageView, 0);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:collectionBtn];
}





//+ (void)loadHeadData:(NSInteger)enterpriseId{
////    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
////    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
////    if ([self.dataSoure isEqualToString:@"DZYC"]) {
////         [dict setObject:self.dataSoure forKey:@"dataSource"];
////    }
////    [dict setObject:self.erpCodeStr forKey:@"erpCode"];
////    [dict setObject:self.userIDStr forKey:@"userId"];
//    [dict setObject:[NSString stringWithFormat:@"%ld",enterpriseId] forKey:@"id"];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    RSWeakself
//    CLog(@"========================%@",parameters);
//    //URL_HEADER_MY_QUAN_IOS
//    //NSString * str = @"http://192.168.1.139:8080/slsw/hzpage.do";
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_ENTERPRISE_GET_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            CLog(@"===========================1=======2==========3=================%@",json);
//            BOOL Result = [json[@"success"]boolValue];
//            if (Result) {
//                RSSCCompanyHeaderModel * sccompanyHeaderModel = [RSSCCompanyHeaderModel mj_objectWithKeyValues:json[@"data"]];
//
//
//
//
//            }else{
//                [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
//            }
//        }else{
//            [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
//        }
//    }];
//}


//展开大图
- (void)showPitrueArray:(NSMutableArray *)pictrueArray andTag:(NSInteger)tag{
    NSMutableArray * images = [NSMutableArray array];
    NSMutableArray * miniImages = [NSMutableArray array];
    for (int i = 0; i < pictrueArray.count; i++) {
        RSBusinessLicenseListModel * model = pictrueArray[i];
        NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
        [images addObject:[NSString stringWithFormat:@"%@%@",url,model.urlOrigin]];
        [miniImages addObject:[NSString stringWithFormat:@"%@%@",url,model.url]];
    }
    [XLPhotoBrowser showPhotoBrowserWithImages:images andMiniImage:miniImages currentImageIndex:tag];
}


#pragma mark RSSCCompanyHeaderViewDelegate
- (void)moreCheckBtnSelectStatus:(BOOL)isStatus andHeight:(CGFloat)height isCollection:(NSInteger)collectionState{
//    CLog(@"++++++++++++++++323232++++++++++%lf",height);
    [self.headerView setNeedsLayout];
    [self.headerView layoutIfNeeded];
    self.headerView.yj_height = height;
    NSLog(@"================================%ld",(long)collectionState);
    
    RSPublishingProjectCaseFirstButton * collectionBtn = (RSPublishingProjectCaseFirstButton *)self.navigationItem.rightBarButtonItem.customView;
    collectionBtn.selected = collectionState;
//    CGFloat allHeight = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [self reloadData];
}

- (void)collectionCurrentCompanyAction:(UIButton *)sender{
    [UserManger checkLogin:self successBlock:^{
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSString stringWithFormat:@"%ld",self.enterpriseId] forKey:@"collectionId"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary * parameters = @{@"key":[NSString get_uuid],@"Data":dataStr,@"VerifyKey":[UserManger Verifykey]  == nil ? @"" : [UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
//        NSLog(@"========================%@",parameters);
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        NSString * URL = URL_COLLECTION_ADD;
        if (sender.selected){
            URL = URL_COLLECTION_CANCEL;
        }else{
            URL = URL_COLLECTION_ADD;
        }
        [network getDataWithUrlString:URL withParameters:parameters withBlock:^(id json, BOOL success) {
//            NSLog(@"========================%@",json);
            if ([json[@"success"] boolValue]){
                sender.selected = !sender.selected;
            }
        }];
    }];
}

//跳转地址
- (void)jumpCompanyAddressActionDestination:(NSString *)destination andLat:(NSString *)lat andLon:(NSString *)lon{
    
    [self navigationLocationTitle:destination latitudeText:lat longitudeText:lon];
//    [self navigationLocationTitle:destination latitudeText:@"24.594460" longitudeText:@"118.107920"];
}


//门店显示
- (void)showStoreContentWithArray:(NSMutableArray *)array andType:(nonnull NSString *)type{
    RSContactsActionView * contactsAction = [[RSContactsActionView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
   contactsAction.selectype = type;
   contactsAction.contactsArray = array;
   contactsAction.isCurrent = false;
   contactsAction.delegate = self;
//   contactsAction.usermodel = usermodel;
   [self.view addSubview:contactsAction];
}

- (void)hideCurrentShowView:(RSContactsActionView *)contactsActionView{
    [contactsActionView removeFromSuperview];
}

- (void)selectChangeContactsFuntionIndex:(NSInteger)index andContactsArrayStr:(NSString *)str andRSContactsActionView:(RSContactsActionView *)contactsActionView{
    RSSCCompanyHeaderView * companyHeaderView = (RSSCCompanyHeaderView *)self.headerView;
    [companyHeaderView.storeBtn setTitle:str forState:UIControlStateNormal];
}


+ (NSArray *)getArrayVCsWithErpCodeStrWithEnterpriseId:(NSInteger)enterpriseId{
//    RSCargoEngineeringViewController * view1 = [[RSCargoEngineeringViewController alloc]init];
//    view1.title = @"主要商圈";
    RSNewCompanyViewController * view2 = [[RSNewCompanyViewController alloc]init];
    view2.title = @"新品";
    view2.enterpriseId = enterpriseId;
    RSNewCompanyViewController * view3 = [[RSNewCompanyViewController alloc]init];
    view3.title = @"工程案例";
    view3.enterpriseId = enterpriseId;
    RSNewCompanyViewController * view4 = [[RSNewCompanyViewController alloc]init];
    view4.title = @"主营石材";
    view4.enterpriseId = enterpriseId;
//    return @[view1, view2, view3,view4];
    return @[view2,view3,view4];
}

+ (NSArray *)getArrayTitles {
//    return @[@"主要商圈",@"新品",@"工程案例", @"主营石材"];
    return @[@"新品",@"工程案例",@"主营石材"];
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    UIViewController *vc = pageViewController.controllersM[index];
//    if ([vc isKindOfClass:[RSCargoEngineeringViewController class]]) {
//        return [(RSCargoEngineeringViewController *)vc tableView];
//    }else
//    if ([vc isKindOfClass:[RSGongChenViewController class]]){
//        return [(RSGongChenViewController *)vc tableView];
//    }else
    if ([vc isKindOfClass:[RSNewCompanyViewController class]]){
        return [(RSNewCompanyViewController *)vc collectionview];
    }else{
        return [(UITableViewController *)vc tableView];
    }
}
#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffset
                  progress:(CGFloat)progress {
      //    NSLog(@"--- contentOffset = %f,    progress = %f", contentOffset, progress);
}







@end
