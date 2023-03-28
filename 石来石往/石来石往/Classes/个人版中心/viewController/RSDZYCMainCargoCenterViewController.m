//
//  RSDZYCMainCargoCenterViewController.m
//  石来石往
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 mac. All rights reserved.
//


#import "RSDZYCMainCargoCenterViewController.h"
#import "RSCargoMainCampViewController.h"
#import "RSWasteMaterialViewController.h"
#import "RSLeftViewController.h"
//#import "AlertAction.h"
//#import "AlertView.h"
#import "RSContactsViewController.h"
#import "RSContactsActionView.h"


#import "RSCargoEngineeringViewController.h"
#import "RSGongChenViewController.h"

@interface RSDZYCMainCargoCenterViewController ()<YNPageViewControllerDataSource,YNPageViewControllerDelegate,RSCargoHeaderViewDelegate,RSContactsActionViewDelegate>
{
    //用来区分是背景的图片还是点击头像的图片
    NSInteger _selectIndex;
    UIImageView * _showImage;
}

@end

@implementation RSDZYCMainCargoCenterViewController
+ (instancetype)suspendCenterPageVCUserModel:(RSUserModel *)usermodel andErpCodeStr:(NSString *)erpCodeStr andCreat_userIDStr:(NSString *)creat_userIDStr andUserIDStr:(NSString *)userIDStr{
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleSuspensionCenter;
    configration.headerViewCouldScale = YES;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
    configration.showTabbar = NO;
    configration.showNavigation = NO;
    configration.normalItemColor = [UIColor colorFromHexString:@"#333333"];
    configration.selectedItemColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    configration.lineColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = NO;
    RSDZYCMainCargoCenterViewController *vc = [RSDZYCMainCargoCenterViewController pageViewControllerWithControllers:[self getArrayVCs:usermodel andErpCodeStr:erpCodeStr andCreat_userIDStr:creat_userIDStr andUserIDStr:userIDStr]
                                                                                                              titles:[self getArrayTitles]
                                                                                                              config:configration];
    vc.dataSource = vc;
    vc.delegate = vc;
    
    
    /// 轮播图
    RSCargoHeaderView * autoScrollview = [[RSCargoHeaderView alloc]initWithErpCodeStr:erpCodeStr andUserIDStr:creat_userIDStr andUserModel:usermodel];
    autoScrollview.cargodelegate = vc;
    //524
    autoScrollview.frame = CGRectMake(0, 0, SCW, 500);
    autoScrollview.userInteractionEnabled = YES;
    autoScrollview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    vc.headerView = autoScrollview;
    /// 指定默认选择index 页面
    vc.pageIndex = 0;
    return vc;
}


+(instancetype)suspendCenterPageVCUserModel:(RSUserModel *)usermodel andErpCodeStr:(NSString *)erpCodeStr andCreat_userIDStr:(NSString *)creat_userIDStr andUserIDStr:(NSString *)userIDStr andDataSoure:(NSString *)dataSoure{
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    
    configration.pageStyle = YNPageStyleSuspensionCenter;
    configration.headerViewCouldScale = YES;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
    configration.showTabbar = NO;
    configration.showNavigation = NO;
    configration.normalItemColor = [UIColor colorFromHexString:@"#333333"];
    configration.selectedItemColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    configration.lineColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = NO;
    //[self getArrayVCs:usermodel andErpCodeStr:erpCodeStr andCreat_userIDStr:creat_userIDStr andUserIDStr:userIDStr]
    RSDZYCMainCargoCenterViewController *vc = [RSDZYCMainCargoCenterViewController pageViewControllerWithControllers:[self getArrayVCs:usermodel andErpCodeStr:erpCodeStr andCreat_userIDStr:creat_userIDStr andUserIDStr:userIDStr andDataSoure:dataSoure]
                                                                                                              titles:[self getArrayTitles]
                                                                                                              config:configration];
    vc.dataSource = vc;
    vc.delegate = vc;
    
    
    /// 轮播图
//    RSCargoHeaderView * autoScrollview = [[RSCargoHeaderView alloc]initWithErpCodeStr:erpCodeStr andUserIDStr:creat_userIDStr andUserModel:usermodel];
    
    RSCargoHeaderView * autoScrollview = [[RSCargoHeaderView alloc]initWithErpCodeStr:erpCodeStr andUserIDStr:creat_userIDStr andUserModel:usermodel andDataSoure:dataSoure];
    autoScrollview.cargodelegate = vc;
    //524
    if ([dataSoure isEqualToString:@"DZYC"]) {
        //460
       autoScrollview.frame = CGRectMake(0, 0, SCW, 588.5);
    }else{
        //500
       autoScrollview.frame = CGRectMake(0, 0, SCW, 628.5);
    }
    autoScrollview.userInteractionEnabled = YES;
    autoScrollview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    vc.headerView = autoScrollview;
    /// 指定默认选择index 页面
    vc.pageIndex = 0;
    return vc;
}




+ (NSArray *)getArrayVCs:(RSUserModel *)usermodel andErpCodeStr:(NSString *)erpCodeStr andCreat_userIDStr:(NSString *)creat_userIDStr andUserIDStr:(NSString *)userIDStr{
    
//    RSCargoEngineeringViewController *vc_1 = [[RSCargoEngineeringViewController alloc] init];
//    vc_1.cellTitle = @"商圈";
//    vc_1.erpCodeStr = erpCodeStr;
//    vc_1.creat_userIDStr = creat_userIDStr;
//    vc_1.userIDStr = userIDStr;
//    vc_1.usermodel = usermodel;
//
//
//    RSGongChenViewController * vc_2 = [[RSGongChenViewController alloc]init];
//    vc_2.cellTitle = @"工程案例";
//    vc_2.usermodel = usermodel;
//    vc_2.erpCodeStr = erpCodeStr;
//    vc_2.creat_userIDStr = creat_userIDStr;
//    vc_2.userIDStr = userIDStr;
    
    
    RSCargoMainCampViewController *vc_3 = [[RSCargoMainCampViewController alloc] init];
    vc_3.usermodel = usermodel;
    vc_3.erpCodeStr = erpCodeStr;
    vc_3.userIDStr = userIDStr;
    
   // return @[vc_1, vc_2, vc_3];
    return @[vc_3];
}

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



+ (NSArray *)getArrayVCs:(RSUserModel *)usermodel andErpCodeStr:(NSString *)erpCodeStr andCreat_userIDStr:(NSString *)creat_userIDStr andUserIDStr:(NSString *)userIDStr andDataSoure:(NSString *)dataSoure{
    
    //    RSCargoEngineeringViewController *vc_1 = [[RSCargoEngineeringViewController alloc] init];
    //    vc_1.cellTitle = @"商圈";
    //    vc_1.erpCodeStr = erpCodeStr;
    //    vc_1.creat_userIDStr = creat_userIDStr;
    //    vc_1.userIDStr = userIDStr;
    //    vc_1.usermodel = usermodel;
    //
    //
    //    RSGongChenViewController * vc_2 = [[RSGongChenViewController alloc]init];
    //    vc_2.cellTitle = @"工程案例";
    //    vc_2.usermodel = usermodel;
    //    vc_2.erpCodeStr = erpCodeStr;
    //    vc_2.creat_userIDStr = creat_userIDStr;
    //    vc_2.userIDStr = userIDStr;
    
    
    RSCargoMainCampViewController *vc_3 = [[RSCargoMainCampViewController alloc] init];
    vc_3.usermodel = usermodel;
    vc_3.erpCodeStr = erpCodeStr;
    vc_3.userIDStr = userIDStr;
    vc_3.dataSoure = dataSoure;
    // return @[vc_1, vc_2, vc_3];
    return @[vc_3];
}


+ (NSArray *)getArrayTitles {
   // return @[@"商圈", @"工程案例", @"主营石材"];
    return @[@"主营石材"];
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    UIViewController *vc = pageViewController.controllersM[index];
    if([vc isKindOfClass:[RSCargoEngineeringViewController class]]) {
        return [(RSCargoEngineeringViewController *)vc tableView];
    }else if ([vc isKindOfClass:[RSGongChenViewController class]]){
        return [(RSGongChenViewController *)vc tableview];
    }else{
        return [(RSCargoMainCampViewController *)vc collectionView];
    }
}
#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffset
                  progress:(CGFloat)progress {
    //    NSLog(@"--- contentOffset = %f,    progress = %f", contentOffset, progress);
}

- (void)backUp{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideCurrentShowView:(RSContactsActionView *)contactsActionView{
    
    [contactsActionView removeFromSuperview];
}


//点击联系电话
- (void)jumpAddressAndMyRingModel:(RSMyRingModel *)mymodel andSelectype:(NSString *)type andUsermodel:(RSUserModel *)usermodel{
    RSContactsActionView * contactsAction = [[RSContactsActionView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    if ([type isEqualToString:@"1"]) {
        contactsAction.contactsArray = mymodel.ownerLinkMan;
    }else{
        contactsAction.contactsArray = mymodel.ownerAdress;
    }
    contactsAction.selectype = type;
    if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[RSLeftViewController class]]) {
        contactsAction.isCurrent = true;
    }else{
        contactsAction.isCurrent = false;
    }
    contactsAction.delegate = self;
    contactsAction.usermodel = usermodel;
    [self.view addSubview:contactsAction];
}



- (void)selectChangeContactsFuntionSelectype:(NSString *)selectype andRSContactsActionView:(RSContactsActionView *)contactsActionView{
    RSContactsViewController * contactsVc = [[RSContactsViewController alloc]init];
    contactsVc.usermodel = contactsActionView.usermodel;
    contactsVc.selectype = contactsActionView.selectype;
    [self.navigationController pushViewController:contactsVc animated:YES];
}


//大众云仓荒料和大板的跳转
- (void)jumpDabanTitleNameLabel:(NSString *)titleNameLabel andTyle:(NSString *)tyle andErpCodeStr:(NSString *)erpCodeStr andUserModel:(RSUserModel *)usermodel andDataSoure:(NSString *)dataSource{
    RSWasteMaterialViewController * wasteMaterialVc = [[RSWasteMaterialViewController alloc]init];
    wasteMaterialVc.titleNameLabel = titleNameLabel;
    wasteMaterialVc.tyle = tyle;
    wasteMaterialVc.erpCodeStr = erpCodeStr;
    wasteMaterialVc.userModel = usermodel;
    wasteMaterialVc.dataSource = dataSource;
//    wasteMaterialVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wasteMaterialVc animated:YES];
}


- (void)jumpHuangTitleNameLabel:(NSString *)titleNameLabel andTyle:(NSString *)tyle andErpCodeStr:(NSString *)erpCodeStr andUserModel:(RSUserModel *)usermodel andDataSoure:(NSString *)dataSource{
    RSWasteMaterialViewController * wasteMaterialVc = [[RSWasteMaterialViewController alloc]init];
    wasteMaterialVc.titleNameLabel = titleNameLabel;
    wasteMaterialVc.tyle = tyle;
    wasteMaterialVc.dataSource = dataSource;
    wasteMaterialVc.erpCodeStr = erpCodeStr;
    wasteMaterialVc.userModel = usermodel;
//    wasteMaterialVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wasteMaterialVc animated:YES];
}




//荒料
//- (void)jumpHuangTitleNameLabel:(NSString *)titleNameLabel andTyle:(NSString *)tyle andErpCodeStr:(NSString *)erpCodeStr andUserModel:(RSUserModel *)usermodel{
//    RSWasteMaterialViewController * wasteMaterialVc = [[RSWasteMaterialViewController alloc]init];
//    wasteMaterialVc.titleNameLabel = titleNameLabel;
//    wasteMaterialVc.tyle = tyle;
//    wasteMaterialVc.erpCodeStr = erpCodeStr;
//    wasteMaterialVc.userModel = usermodel;
//    wasteMaterialVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:wasteMaterialVc animated:YES];
//}



//大板
//- (void)jumpDabanTitleNameLabel:(NSString *)titleNameLabel andTyle:(NSString *)tyle andErpCodeStr:(NSString *)erpCodeStr andUserModel:(RSUserModel *)usermodel{
//    RSWasteMaterialViewController * wasteMaterialVc = [[RSWasteMaterialViewController alloc]init];
//    wasteMaterialVc.titleNameLabel = titleNameLabel;
//    wasteMaterialVc.tyle = tyle;
//    wasteMaterialVc.erpCodeStr = erpCodeStr;
//    wasteMaterialVc.userModel = usermodel;
//    wasteMaterialVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:wasteMaterialVc animated:YES];
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
}

- (void)changBackgroundImageUserModel:(RSUserModel *)usermodel andRSMyRingModel:(RSMyRingModel *)mymodel andTag:(NSInteger)selectIndex andUImageView:(UIImageView *)backgroundImage{
    _selectIndex = selectIndex;
    self.usermodel = usermodel;
    [self openPhotoAlbumAndOpenCamera:usermodel andRSMyRingModel:mymodel andUImageView:backgroundImage];
    _showImage = backgroundImage;
}

- (void)changeTouImageUserModel:(RSUserModel *)usermodel andRSMyRingModel:(RSMyRingModel *)mymodel andTag:(NSInteger)selectIndex andUImageView:(UIImageView *)touImage{
    _selectIndex = selectIndex;
    self.usermodel = usermodel;
    [self openPhotoAlbumAndOpenCamera:usermodel andRSMyRingModel:mymodel andUImageView:touImage];
    _showImage = touImage;
}


- (void)openPhotoAlbumAndOpenCamera:(RSUserModel *)usermodel andRSMyRingModel:(RSMyRingModel *)mymodel andUImageView:(UIImageView *)imageView{
    if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]){
        if ([mymodel.ownerName isEqualToString:usermodel.userName]) {
            RSSelectNeedImageTool * selectTool = [[RSSelectNeedImageTool alloc]init];
            [selectTool openPhotoAlbumAndOpenCameraViewController:self];
            selectTool.returnData = ^(XPhotoUploaderContentEntity * _Nonnull photoEntityWillUpload) {
                _photoEntityWillUpload = photoEntityWillUpload;
                [self uploadUserHead];
            };
        }else{
            if (_selectIndex == 0) {
                //背景图片
                NSMutableArray * array = [NSMutableArray array];
                [array addObject:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,mymodel.backgroundImgUrl]];
                [HUPhotoBrowser showFromImageView:imageView withURLStrings:array atIndex:0];
                
            }else{
                
                NSMutableArray * array = [NSMutableArray array];
                [array addObject:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,mymodel.ownerLogo]];
                [HUPhotoBrowser showFromImageView:imageView withURLStrings:array atIndex:0];
            }
        }
    }else{
        if (_selectIndex == 0) {
            //  背景图片
            NSMutableArray * array = [NSMutableArray array];
            [array addObject: [NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,mymodel.backgroundImgUrl]];
            [HUPhotoBrowser showFromImageView:imageView withURLStrings:array atIndex:0];
            
            
            
        }else{
            
            NSMutableArray * array = [NSMutableArray array];
            [array addObject:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,mymodel.ownerLogo]];
            [HUPhotoBrowser showFromImageView:imageView withURLStrings:array atIndex:0];
        }
    }
}


#pragma mark -- 进行上传图片
- (void)uploadUserHead
{
    [SVProgressHUD showWithStatus:@"正在上传中....."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userPhone forKey:@"mobilePhone"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
    NSArray *avatarArray = [NSArray arrayWithObject:_photoEntityWillUpload.image];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSData *imageData;
    for (UIImage *avatar in avatarArray)
    {
        imageData = UIImageJPEGRepresentation(avatar, 1);
        [dataArray addObject:imageData];
    }
    NSString * urlStr = nil;
    if (_selectIndex == 0) {
        urlStr = URL_HEADER_SINGEPICTURE_BACKIMAGE;
    }else{
        urlStr =  URL_HEADER_SINGEPICTURE;
    }
    XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
    [netWork getImageDataWithUrlString:urlStr withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD dismiss];
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                if (_selectIndex == 0) {
                    //这边是背景图片
                    [_showImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",URL_HEADER_IMAGEURL_PING_IOS,json[@"path"],json[@"fileName"]]] placeholderImage:[UIImage imageNamed:@"beijing"]];
                }else{
                    //这边是头像
                    [_showImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",URL_HEADER_IMAGEURL_PING_IOS,json[@"path"],json[@"fileName"]]] placeholderImage:[UIImage imageNamed:@"iconfont-照相机"]];
                }
                [SVProgressHUD showSuccessWithStatus:@"上传图片成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"上传图片不能超过1M"];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
        }
    }];
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
