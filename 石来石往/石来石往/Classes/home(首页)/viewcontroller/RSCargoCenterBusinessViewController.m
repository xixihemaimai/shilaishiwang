//
//  RSCargoCenterBusinessViewController.m
//  石来石往
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCargoCenterBusinessViewController.h"
#import "RSCargoMainCampViewController.h"
#import "RSCargoEngineeringViewController.h"
#import "RSWasteMaterialViewController.h"
#import "RSLeftViewController.h"
//#import "AlertAction.h"
//#import "AlertView.h"

#import "RSContactsViewController.h"
#import "RSContactsActionView.h"
#import "RSGongChenViewController.h"

//,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AlertViewDelegate
@interface RSCargoCenterBusinessViewController ()<YNPageViewControllerDataSource,YNPageViewControllerDelegate,RSCargoHeaderViewDelegate,RSContactsActionViewDelegate>
{
    //用来区分是背景的图片还是点击头像的图片
    NSInteger _selectIndex;
    UIImageView * _showImage;
}
@end

@implementation RSCargoCenterBusinessViewController
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
    RSCargoCenterBusinessViewController *vc = [RSCargoCenterBusinessViewController pageViewControllerWithControllers:[self getArrayVCs:usermodel andErpCodeStr:erpCodeStr andCreat_userIDStr:creat_userIDStr andUserIDStr:userIDStr]
                                                                                  titles:[self getArrayTitles]
                                                                                  config:configration];
    vc.dataSource = vc;
    vc.delegate = vc;
    
    /// 轮播图
    RSCargoHeaderView * autoScrollview = [[RSCargoHeaderView alloc]initWithErpCodeStr:erpCodeStr andUserIDStr:creat_userIDStr andUserModel:usermodel];
    autoScrollview.cargodelegate = vc;
    //524
    autoScrollview.frame = CGRectMake(0, 0, SCW, 628.5);
    autoScrollview.userInteractionEnabled = YES;
    autoScrollview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    vc.headerView = autoScrollview;
    /// 指定默认选择index 页面
    vc.pageIndex = 0;
    return vc;
}




+ (NSArray *)getArrayVCs:(RSUserModel *)usermodel andErpCodeStr:(NSString *)erpCodeStr andCreat_userIDStr:(NSString *)creat_userIDStr andUserIDStr:(NSString *)userIDStr{
    
    RSCargoEngineeringViewController *vc_1 = [[RSCargoEngineeringViewController alloc] init];
    vc_1.cellTitle = @"商圈";
    vc_1.erpCodeStr = erpCodeStr;
    vc_1.creat_userIDStr = creat_userIDStr;
    vc_1.userIDStr = userIDStr;
    vc_1.usermodel = usermodel;

    
    RSGongChenViewController * vc_2 = [[RSGongChenViewController alloc]init];
    vc_2.cellTitle = @"工程案例";
    vc_2.usermodel = usermodel;
    vc_2.erpCodeStr = erpCodeStr;
    vc_2.creat_userIDStr = creat_userIDStr;
    vc_2.userIDStr = userIDStr;
    

    
    RSCargoMainCampViewController *vc_3 = [[RSCargoMainCampViewController alloc] init];
    vc_3.usermodel = usermodel;
    vc_3.erpCodeStr = erpCodeStr;
    vc_3.userIDStr = userIDStr;
    
    return @[vc_1, vc_2, vc_3];
}

+ (NSArray *)getArrayTitles {
    return @[@"商圈", @"工程案例", @"主营石材"];
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    UIViewController *vc = pageViewController.controllersM[index];
    if ([vc isKindOfClass:[RSCargoEngineeringViewController class]]) {
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
    
//    if ([type isEqualToString:@"1"]) {
//        AlertView * alertView = [AlertView popoverView];
//        alertView.backgroundColor = [UIColor clearColor];
//        alertView.selectype = @"1";
//        alertView.usermodel = usermodel;
//        alertView.showShade = YES; // 显示阴影背景
//       // [alertView showWithActions:[self QQActions]];
//        alertView.delegate = self;
//
//        if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[RSLeftViewController class]]) {
//
//            alertView.isCurrent = true;
//        }else{
//            alertView.isCurrent = false;
//        }
//
//        [alertView showWithActions:[self QQActionsRSMyRingModel:mymodel andType:type]];
//    }else{
//        AlertView * alertView = [AlertView popoverView];
//        alertView.backgroundColor = [UIColor clearColor];
//        alertView.selectype = @"2";
//        alertView.usermodel = usermodel;
//        alertView.showShade = YES; // 显示阴影背景
//        alertView.delegate = self;
//        if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[RSLeftViewController class]]) {
//
//            alertView.isCurrent = true;
//        }else{
//            alertView.isCurrent = false;
//        }
//        //[alertView showWithActions:[self QQActions]];
//        [alertView showWithActions:[self QQActionsRSMyRingModel:mymodel andType:type]];
//    }
}



- (void)selectChangeContactsFuntionSelectype:(NSString *)selectype andRSContactsActionView:(RSContactsActionView *)contactsActionView{
    RSContactsViewController * contactsVc = [[RSContactsViewController alloc]init];
    contactsVc.usermodel = contactsActionView.usermodel;
    contactsVc.selectype = contactsActionView.selectype;
    [self.navigationController pushViewController:contactsVc animated:YES];
}


- (void)hideCurrentShowView:(RSContactsActionView *)contactsActionView{
    [contactsActionView removeFromSuperview];
}



//- (void)selectChangeContactsFuntionSelectype:(NSString *)selectype andAlertView:(AlertView *)alertView{
//    [alertView hide];
//    RSContactsViewController * contactsVc = [[RSContactsViewController alloc]init];
//    contactsVc.usermodel = alertView.usermodel;
//    contactsVc.selectype = alertView.selectype;
//    [self.navigationController pushViewController:contactsVc animated:YES];
//}

//
//- (NSMutableArray<AlertAction *> *)QQActionsRSMyRingModel:(RSMyRingModel *)mymodel andType:(NSString *)type{
//     NSMutableArray * actionArr = [NSMutableArray array];
//    if ([type isEqualToString:@"1"]) {
//        AlertAction *multichatAction = [AlertAction actionWithImage:[UIImage imageNamed:@"打电话"] title:mymodel.ownerName andDetailTitle:mymodel.ownerPhone andType:@"1" handler:^(AlertAction *action) {
//            if (action.detailTitle.length > 0) {
//                NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", action.detailTitle];
//                if ([UIDevice currentDevice].systemVersion.floatValue > 10.0) {
//                    /// 大于等于10.0系统使用此openURL方法
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
//                } else {
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
//                }
//            }
//        }];
//        [actionArr addObject:multichatAction];
//    }else{
//        AlertAction *multichatAction = [AlertAction actionWithImage:[UIImage imageNamed:@"导航"] title:mymodel.ownerAdress andDetailTitle:nil andType:@"2" handler:^(AlertAction *action) {
//            if (action.title.length > 0) {
//
//            }
//        }];
//        [actionArr addObject:multichatAction];
//    }
//    return actionArr;
//}
//

//荒料
- (void)jumpHuangTitleNameLabel:(NSString *)titleNameLabel andTyle:(NSString *)tyle andErpCodeStr:(NSString *)erpCodeStr andUserModel:(RSUserModel *)usermodel{
    
    RSWasteMaterialViewController * wasteMaterialVc = [[RSWasteMaterialViewController alloc]init];
    wasteMaterialVc.titleNameLabel = titleNameLabel;
    wasteMaterialVc.tyle = tyle;
    wasteMaterialVc.erpCodeStr = erpCodeStr;
    wasteMaterialVc.userModel = usermodel;
//    wasteMaterialVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wasteMaterialVc animated:YES];
}


//大板
- (void)jumpDabanTitleNameLabel:(NSString *)titleNameLabel andTyle:(NSString *)tyle andErpCodeStr:(NSString *)erpCodeStr andUserModel:(RSUserModel *)usermodel{
     //self.hidesBottomBarWhenPushed = YES;
     RSWasteMaterialViewController * wasteMaterialVc = [[RSWasteMaterialViewController alloc]init];
     wasteMaterialVc.titleNameLabel = titleNameLabel;
     wasteMaterialVc.tyle = tyle;
     wasteMaterialVc.erpCodeStr = erpCodeStr;
     wasteMaterialVc.userModel = usermodel;
//     wasteMaterialVc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:wasteMaterialVc animated:YES];
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

//#pragma mark -- 调用相机还是相册
//- (void)callTheCamera:(UITapGestureRecognizer *)tap{
//    switch (tap.view.tag) {
//        case 0:
//            selectIndex = 0;
//            break;
//        case 1:
//            selectIndex = 1;
//            break;
//    }
//    [self openPhotoAlbumAndOpenCamera];
//}

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

//#pragma mark -- 使用系统的方式打开相册
//- (void)openPhotoAlbum{
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.delegate = self;
//    //设置选择后的图片可被编辑
//    picker.allowsEditing = YES;
//    [self presentViewController:picker animated:YES completion:nil];
//}
//
//#pragma mark -- 使用系统的方式打开相机
//- (void)openCamera{
//    //调用系统的相机的功能
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        picker.delegate = self;
//        //设置拍照后的图片可被编辑
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        //先检查相机可用是否
//        BOOL cameraIsAvailable = [self checkCamera];
//        if (YES == cameraIsAvailable) {
//            [self presentViewController:picker animated:YES completion:nil];
//        }else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
//            [alert show];
//        }
//
//    }
//
//}
//
//
//#pragma mark -- 检查相机是否可用
//- (BOOL)checkCamera
//{
//    NSString *mediaType = AVMediaTypeVideo;
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//    if(AVAuthorizationStatusRestricted == authStatus ||
//       AVAuthorizationStatusDenied == authStatus)
//    {
//        //相机不可用
//        return NO;
//    }
//    //相机可用
//    return YES;
//}
//
//
//#pragma mark -- 当用户选取完成后调用
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
//
//        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//        NSDictionary *mediaMetadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
//        if (mediaMetadata)
//        {
//
//        } else {
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            __block NSDictionary *blockMediaMetadata = mediaMetadata;
//            __block UIImage *blockImage = pickedImage;
//            [library
//             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
//             resultBlock: ^ (ALAsset *asset) {
//                 ALAssetRepresentation *representation = [asset defaultRepresentation];
//                 blockMediaMetadata = [representation metadata];
//                 [picker dismissViewControllerAnimated:YES completion:nil];
//                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
//             }
//             failureBlock: ^ (NSError *error) {
//
//             }];
//        }
//
//        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//        {
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            __block NSDictionary *blockMediaMetadata = mediaMetadata;
//            __block UIImage *blockImage = pickedImage;
//            [library
//             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
//             resultBlock: ^ (ALAsset *asset) {
//                 ALAssetRepresentation *representation = [asset defaultRepresentation];
//                 blockMediaMetadata = [representation metadata];
//                 [picker dismissViewControllerAnimated:YES completion:nil];
//                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
//             }
//             failureBlock: ^ (NSError *error) {
//
//             }];
//            [picker dismissViewControllerAnimated:YES completion:nil];
//
//        } else {
//
//        }
//    }
//}
//
//- (void)processingPickedImage:(UIImage *)pickedImage mediaMetadata:(NSDictionary *)mediaMetadata
//{
//    //[[RSMessageView shareMessageView] showMessageWithType:@"努力加载中" messageType:kRSMessageTypeIndicator];
//    __weak typeof(self) weakSelf = self;
//    [PhotoUploadHelper
//     processPickedUIImage:[self scaleToSize:pickedImage ]
//     withMediaMetadata:mediaMetadata
//     completeBlock:^(XPhotoUploaderContentEntity *photo) {
//
//         _photoEntityWillUpload = photo;
//
//         [weakSelf uploadUserHead];
//     }
//     failedBlock:^(NSDictionary *errorInfo) {
//
//     }];
//}



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

//#pragma mark -- 对图片进行压缩
//- (UIImage *)scaleToSize:(UIImage *)img {
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    CGSize size = CGSizeMake(img.size.width*0.65, img.size.height*0.65);
//
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    //返回新的改变大小后的图片
//    return scaledImage;
//}

- (void)viewDidLoad{
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:true animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = true;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.navigationController.navigationBar.hidden = false;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
