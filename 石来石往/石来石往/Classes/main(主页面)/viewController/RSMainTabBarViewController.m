//
//  RSMainTabBarViewController.m
//  石来石往
//
//  Created by rsxx on 2017/9/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMainTabBarViewController.h"

//淘宝专区
#import "RSTaobaoDistrictViewController.h"
//选材中心
#import "RSSelectionCenterViewController.h"
//商圈
#import "RSShopBusinessViewController.h"
//海西商户
#import "RSHaixiMerchantsViewController.h"




//首页朋友圈
#import "RSHomeViewController.h"
#import "RSAllHomeViewController.h"
//荒料和大板
#import "RSHSViewController.h"
#import "RSLeftViewController.h"
#import "RSLoginViewController.h"
#import "RSMyLoginViewController.h"
#import "RSHSViewController.h"
#import "RSUserModel.h"
#import "RSPersonalEditionViewController.h"
#import "RSPwmsUserViewController.h"
//申请个人版
#import "RSApplyPersonalViewController.h"
#import "RSApplyListModel.h"
#import "RSShowAuditiewController.h"

@interface RSMainTabBarViewController ()

@property (nonatomic,strong)RSUserModel * userModel;


@property (nonatomic,strong)void(^isownData)(BOOL isown,NSMutableArray * temp);

@end

@implementation RSMainTabBarViewController

+ (void)load{
//    UITabBarItem *item = nil;
//    if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
//        item = [UITabBarItem appearanceWhenContainedIn:[self class], nil];
//    }else{
    UITabBarItem * item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];// iOS9.0
//    }
    //富文本：带属性的字符串
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    //设置字体颜色
    attrDict[NSForegroundColorAttributeName] =  [UIColor colorWithHexColorStr:@"#3385FF"];
    //设置标题的富文本
    [item setTitleTextAttributes:attrDict forState:UIControlStateSelected];
    // 设置富文本属性
    NSMutableDictionary *attrNormal = [NSMutableDictionary dictionary];
    // 设置文字大小的属性
    attrNormal[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    // 设置按钮文字的大小属性
    [item setTitleTextAttributes:attrNormal forState:UIControlStateNormal];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeLoginData) name:@"SignOutLogin" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadDisplay) name:@"ViewControllerShouldReloadNotification" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(personalEditionIsAgreen) name:@"PersonalEdition" object:nil];
}

//- (void)personalEditionIsAgreen{
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
//    if (VERIFYKEY.length > 0) {
////        if (self.selectedIndex == 2) {
//            if (self.userModel.pwmsuserList.count > 0 && self.userModel.pwmsUser.companyName.length > 0) {
//                //这边是登录了，并开通了
//                RSMyNavigationViewController * navi3 = self.viewControllers[2];
//                RSPersonalEditionViewController * personalEditionVc = navi3.viewControllers[0];
//                [navi3 setViewControllers:@[personalEditionVc] animated:YES];
//               // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PersonalEdition" object:nil];
//            }else{
//                [self reloadNewData];
//                RSWeakself
//                self.isownData = ^(BOOL isown, NSMutableArray *temp) {
//                    if (isown == true && temp.count > 0) {
//                        //审核中......
//                        //RSMyNavigationViewController * navi3 =
//                        RSShowAuditiewController * showAudioVc = [[RSShowAuditiewController alloc]init];
//                        RSMyNavigationViewController * navi2 = [[RSMyNavigationViewController alloc]initWithRootViewController:showAudioVc];
//                       navi2 = weakSelf.childViewControllers[2];
//                      // showAudioVc = (RSShowAuditiewController *)navi3.viewControllers[0];
//                        RSApplyListModel * applyListModel = temp[0];
//                        showAudioVc.applyylistmodel = applyListModel;
//                        showAudioVc.tabBarItem.tag = 2;
//                        showAudioVc.usermodel = weakSelf.userModel;
//                        showAudioVc.tabBarItem.title = @"大众云仓";
//                        showAudioVc.tabBarItem.image =  [UIImage imageNamed:@" 补充切图 copy 36"];
//                        UIImage * image2 = [UIImage imageNamed:@" 补充切图 copy 37"];
//                        UIImage * newImage2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                        showAudioVc.tabBarItem.selectedImage = newImage2;
//                        [navi2 setViewControllers:@[showAudioVc] animated:NO];
//                       // [[NSNotificationCenter defaultCenter]removeObserver:weakSelf name:@"PersonalEdition" object:nil];
//                    }else{
//                        //这边是登录了,但是还没有开通
//                        RSMyNavigationViewController * navi2 = weakSelf.childViewControllers[2];
//                        RSApplyPersonalViewController * pwmsUserVc = navi2.viewControllers[0];
//                        [navi2 setViewControllers:@[pwmsUserVc] animated:NO];
//                    }
//                };
//            }
////        }
////            else{
////          //这边是没有登录，也没有开通
////            RSMyNavigationViewController * navi3 = self.childViewControllers[2];
////            RSLoginViewController * pwmsUserVc = navi3.viewControllers[0];
////            [navi3 setViewControllers:@[pwmsUserVc] animated:YES];
////        }
//    }else{
//      //这边是没有登录的情况
//        RSMyNavigationViewController * navi2 = self.childViewControllers[2];
//        RSMyLoginViewController * pwmsUserVc = navi2.viewControllers[0];
//        pwmsUserVc.tabBarItem.title = @"大众云仓";
//        [navi2 setViewControllers:@[pwmsUserVc] animated:NO];
//    }
//}

//- (void)reloadNewData{
//    NSMutableArray * temp = [NSMutableArray array];
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
////    RSWeakself
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_APPLYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            /**
//             个人版账户ID    id    Int
//             账户名称    userName    String    主账号 账户名称和公司名称相同
//             公司名称    companyName    String    主账号 账户名称和公司名称相同
//             联系人电话    contactPhone    String    联系人电话
//             审核结果备注    notes    String
//             状态    status    Int     0 审核中 1 正常
//             申请时间    createTime    String
//             石来石往账户ID    sysUserId    Int
//             */
//            BOOL isresult = [json[@"success"]boolValue];
//            if (isresult) {
//                NSMutableArray * array = [RSApplyListModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
//                [temp addObject:array];
//                if (self.isownData) {
//                    self.isownData(true,temp);
//                }
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"获取失败"];
//                if (self.isownData) {
//                    self.isownData(false,temp);
//                }
//            }
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"获取失败"];
//            if (self.isownData) {
//                self.isownData(false,temp);
//            }
//        }
//    }];
//}

//- (void)reloadDisplay{
//    [self viewDidLoad];
//}

//#pragma mark -- 移除登录的的内容
//- (void)removeLoginData{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
//    NSDate *date = [formatter dateFromString:dateTime];
//    [user setObject:date forKey:@"showAuthorization"];
//    [user removeObjectForKey:@"USER_CODE"];
//    [user removeObjectForKey:@"oneUserModel"];
//    [user removeObjectForKey:@"VERIFYKEY"];
//    [user synchronize];
//    RSMyNavigationViewController * navi2 = self.childViewControllers[2];
//    if ([user objectForKey:@"VERIFYKEY"]) {
//
//        RSPersonalEditionViewController * personalEditionVc = navi2.viewControllers[0];
//        personalEditionVc.tabBarItem.tag = 2;
//        //navi3.tabBarItem.title = @"大众云仓";
//        personalEditionVc.tabBarItem.title = @"大众云仓";
//        //补充切图 copy 36
//        personalEditionVc.tabBarItem.image = [UIImage imageNamed:@" 补充切图 copy 36"];
//        //补充切图 copy 37
//        UIImage * image3 = [UIImage imageNamed:@" 补充切图 copy 37"];
//        UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        personalEditionVc.tabBarItem.selectedImage = newImage3;
//        [navi2 setViewControllers:@[personalEditionVc] animated:NO];
//
//    }else{
//
//        RSMyLoginViewController * pwmsUserVc = [[RSMyLoginViewController alloc]init];
//        pwmsUserVc.tabBarItem.tag = 2;
//        //navi3.tabBarItem.title = @"大众云仓";
//        pwmsUserVc.tabBarItem.title = @"大众云仓";
//        //补充切图 copy 36
//        pwmsUserVc.tabBarItem.image = [UIImage imageNamed:@" 补充切图 copy 36"];
//        //补充切图 copy 37
//        UIImage * image3 = [UIImage imageNamed:@" 补充切图 copy 37"];
//        UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        pwmsUserVc.tabBarItem.selectedImage = newImage3;
//        [navi2 setViewControllers:@[pwmsUserVc] animated:NO];
//    }
//    //tabbaritem最后一个显示的界面
//    RSMyNavigationViewController * navi5 = self.childViewControllers[4];
//    if ([user objectForKey:@"VERIFYKEY"]) {
//     RSLeftViewController * leftVc = navi5.viewControllers[0];
//     leftVc.tabBarItem.tag = 3;
//     leftVc.tabBarItem.title = @"我的";
//     leftVc.tabBarItem.image = [UIImage imageNamed:@"我的-未选中"];
//     UIImage * image4 = [UIImage imageNamed:@"我的-选中"];
//     UIImage * newImage4 = [image4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//     leftVc.tabBarItem.selectedImage = newImage4;
//     [navi5 setViewControllers:@[leftVc] animated:NO];
//    }else{
//     RSMyLoginViewController * loginVc = [[RSMyLoginViewController alloc]init];
//     loginVc.tabBarItem.tag = 3;
//     loginVc.tabBarItem.title = @"我的";
//     loginVc.tabBarItem.image = [UIImage imageNamed:@"我的-未选中"];
//     UIImage * image4 = [UIImage imageNamed:@"我的-选中"];
//     UIImage * newImage4 = [image4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//     loginVc.tabBarItem.selectedImage = newImage4;
//     [navi5 setViewControllers:@[loginVc] animated:NO];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //可以防止延迟时间大于0.2秒的时候显示为黑屏的界面
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.tabBar setTintColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    //去除tabbar上方的横线
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setTranslucent:false];
    [self addSubCtrls];
    
    
    
//    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    [UITabBar appearance].translucent = NO; //这句表示取消tabBar的透明效果。
    
    
    
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * user_code = [user objectForKey:@"USER_CODE"];
//    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
//    NSString * temp = [user objectForKey:@"temp"];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    if ([temp isEqualToString:@"1"]) {
//        //这边是点击登录之后的动作
//        if (VERIFYKEY.length > 0 && user_code.length > 0) {
//            NSData * data = [user objectForKey:@"oneUserModel"];
//            RSUserModel * userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            self.userModel = userModel;
//            applegate.ERPID = self.userModel.lastErpId;
//            [self addSubCtrls];
//            [user setObject:[NSString stringWithFormat:@"0"] forKey:@"temp"];
//        }else{
//            [user removeObjectForKey:@"VERIFYKEY"];
//             applegate.ERPID = @"0";
//            [user setObject:[NSString stringWithFormat:@"2"] forKey:@"temp"];
//            [self addSubCtrls];
//        }
//    }else if ([temp isEqualToString:@"0"]){
//        //这边是登录之后第二次进入的时候,要先去获取用户的信息，去更新用户的信息
//        if (VERIFYKEY.length > 0 && user_code.length > 0) {
//            [RSInitUserInfoTool registermodelUSER_CODE:user_code andVERIFYKEY:VERIFYKEY andViewController:self andObtain:^(BOOL isValue) {
//                if (isValue) {
//                    NSData * data = [user objectForKey:@"oneUserModel"];
//                    RSUserModel * userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//                    self.userModel = userModel;
//                    applegate.ERPID = self.userModel.lastErpId;
//                    [self addSubCtrls];
//                    [user setObject:[NSString stringWithFormat:@"0"] forKey:@"temp"];
//                }else{
//                    applegate.ERPID = @"0";
//                    [user removeObjectForKey:@"VERIFYKEY"];
//                    [user setObject:[NSString stringWithFormat:@"2"] forKey:@"temp"];
//                    [self addSubCtrls];
//                }
//            }];
//        }else{
//            applegate.ERPID = @"0";
//            [user removeObjectForKey:@"VERIFYKEY"];
//            [user setObject:[NSString stringWithFormat:@"2"] forKey:@"temp"];
//            [self addSubCtrls];
//        }
//    }else{
//        //这边是没有登录的时候
//        applegate.ERPID = @"0";
//        [user removeObjectForKey:@"VERIFYKEY"];
//        [user setObject:[NSString stringWithFormat:@"2"] forKey:@"temp"];
//        [self addSubCtrls];
//    }
}

//- (void)changeLineOfTabbarColor {
//    CGRect rect = CGRectMake(0.0f, 0.0f, SCW, 0.2);
//    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
//    CGContextRef context =UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor colorWithHexColorStr:@"#ffffff"].CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.tabBar setShadowImage:image];
//    [self.tabBar setBackgroundImage:[UIImage new]];
//}
//
//- (void)changeTabbarColor {
//    CGRect frame;
//    UIView *tabBarView = [[UIView alloc] init];
//    tabBarView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
//    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
//        frame = CGRectMake(0, 0, SCW, 83);
//    }else {
//        frame = self.tabBar.bounds;
//    }
//    tabBarView.frame = frame;
//    [self.tabBar addSubview:tabBarView];
//}
//
//- (void)changeNoLineOfTabbarColor {
//    CGRect rect = CGRectMake(0.0f, 0.0f, SCW, 0.0005);
//    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
//    CGContextRef context =UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor colorWithHexColorStr:@"#ffffff"].CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.tabBar setShadowImage:image];
//    [self.tabBar setBackgroundImage:[UIImage new]];
//}

- (void)addSubCtrls {
    
    //选材中心
    RSSelectionCenterViewController * selectionCenterVc = [[RSSelectionCenterViewController alloc]init];
    selectionCenterVc.tabBarItem.tag = 0;
    selectionCenterVc.tabBarItem.image = [UIImage imageNamed:@"选材中心-未选中"];
    UIImage * image0 = [UIImage imageNamed:@"选材中心-选中"];
    UIImage * newImage0 = [image0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectionCenterVc.tabBarItem.selectedImage = newImage0;
    selectionCenterVc.tabBarItem.title = @"选材中心";
    RSMyNavigationViewController *navi0 = [[RSMyNavigationViewController alloc]initWithRootViewController:selectionCenterVc];
//    [navi0 setNavigationBarHidden:YES];
    
    //商圈
    RSShopBusinessViewController * shopBusinessVc = [[RSShopBusinessViewController alloc]init];
    shopBusinessVc.tabBarItem.tag = 1;
//    homePage.userModel = self.userModel;
    shopBusinessVc.tabBarItem.title = @"商圈";
    shopBusinessVc.tabBarItem.image =  [UIImage imageNamed:@"商圈-未选中"];
    UIImage * image1 = [UIImage imageNamed:@"商圈-选中"];
    UIImage * newImage1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shopBusinessVc.tabBarItem.selectedImage = newImage1;
    RSMyNavigationViewController *navi1 = [[RSMyNavigationViewController alloc]initWithRootViewController:shopBusinessVc];
//    [navi1 setNavigationBarHidden:YES];
    
    //海西商户
    RSHaixiMerchantsViewController * haixiMerchantsVc = [[RSHaixiMerchantsViewController alloc]init];
    haixiMerchantsVc.tabBarItem.tag = 2;
    haixiMerchantsVc.tabBarItem.title = @"海西商户";
    haixiMerchantsVc.tabBarItem.image = [UIImage imageNamed:@"海西商户-未选中"];
    UIImage * image2 = [UIImage imageNamed:@"海西商户-选中"];
    UIImage * newImage2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    haixiMerchantsVc.tabBarItem.selectedImage = newImage2;
    RSMyNavigationViewController * navi2 = [[RSMyNavigationViewController alloc]initWithRootViewController:haixiMerchantsVc];
//    [navi2 setNavigationBarHidden:YES];
    
    //我的
    
    
//    RSTaobaoDistrictViewController * taoBaoDistrictVc = [[RSTaobaoDistrictViewController alloc]init];
//    taoBaoDistrictVc.tabBarItem.tag = 0;
//    taoBaoDistrictVc.usermodel = self.userModel;
//    taoBaoDistrictVc.tabBarItem.title = @"淘石专区";
//    taoBaoDistrictVc.tabBarItem.image =  [UIImage imageNamed:@" 补充切图 copy 36复制"];
//    UIImage * image0 = [UIImage imageNamed:@" 补充切图 copy 36复制 3"];
//    UIImage * newImage0 = [image0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    taoBaoDistrictVc.tabBarItem.selectedImage = newImage0;
//    RSMyNavigationViewController *navi1 = [[RSMyNavigationViewController alloc]initWithRootViewController:taoBaoDistrictVc];

//    RSHSViewController * hsVc = [[RSHSViewController alloc]init];
//    hsVc.tabBarItem.tag = 2;
////    hsVc.userModel = self.userModel;
//    hsVc.WLTYPE = @"huangliao";
//    //hsVc.title = @"现货搜索";
//    hsVc.tabBarItem.image = [UIImage imageNamed:@"海西商户-未选中"];
//    UIImage * image2 = [UIImage imageNamed:@"海西商户-选中"];
//    UIImage * newImage2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    hsVc.tabBarItem.selectedImage = newImage2;
//    hsVc.tabBarItem.title = @"海西商户";
//    RSMyNavigationViewController *navi2 = [[RSMyNavigationViewController alloc]initWithRootViewController:hsVc];
    
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    [user objectForKey:@"VERIFYKEY"]
    if ([UserManger isLogin]) {
//        if (self.userModel.pwmsuserList.count > 0) {
//            RSPersonalEditionViewController * personalEditionVc = [[RSPersonalEditionViewController alloc]init];
//            personalEditionVc.tabBarItem.tag = 2;
//            personalEditionVc.usermodel = self.userModel;
//            personalEditionVc.tabBarItem.title = @"大众云仓";
//            personalEditionVc.tabBarItem.image =  [UIImage imageNamed:@" 补充切图 copy 36"];
//            UIImage * image3 = [UIImage imageNamed:@" 补充切图 copy 37"];
//            UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            personalEditionVc.tabBarItem.selectedImage = newImage3;
//            RSMyNavigationViewController *navi3 = [[RSMyNavigationViewController alloc]initWithRootViewController:personalEditionVc];
           // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PersonalEdition" object:nil];
            
            
//            RSAllHomeViewController *homePage = [[RSAllHomeViewController alloc]init];
//            homePage.tabBarItem.tag = 3;
//            homePage.userModel = self.userModel;
//            homePage.tabBarItem.title = @"商圈";
//            homePage.tabBarItem.image =  [UIImage imageNamed:@"22"];
//            UIImage * image1 = [UIImage imageNamed:@"62"];
//            UIImage * newImage1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            homePage.tabBarItem.selectedImage = newImage1;
//            RSMyNavigationViewController *navi4 = [[RSMyNavigationViewController alloc]initWithRootViewController:homePage];
             
         
            RSLeftViewController * leftVc = [[RSLeftViewController alloc]init];
            leftVc.title = @"我的";
            leftVc.tabBarItem.tag = 3;
            leftVc.tabBarItem.title = @"我的";
//            leftVc.userModel = self.userModel;
            leftVc.tabBarItem.image = [UIImage imageNamed:@"我的-未选中"];
            UIImage * image3 = [UIImage imageNamed:@"我的-选中"];
            UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            leftVc.tabBarItem.selectedImage = newImage3;
            RSMyNavigationViewController *navi3 = [[RSMyNavigationViewController alloc]initWithRootViewController:leftVc];
            self.viewControllers = @[navi0,navi1,navi2,navi3];
//            self.viewControllers = @[navi1,navi2,navi3,navi4,navi5];
        }else{
            
            
            RSMyLoginViewController * pwmsUserVc = [[RSMyLoginViewController alloc]init];
            pwmsUserVc.tabBarItem.tag = 3;
            pwmsUserVc.tabBarItem.title = @"我的";
            pwmsUserVc.tabBarItem.image = [UIImage imageNamed:@"我的-未选中"];
            UIImage * image3 = [UIImage imageNamed:@"我的-选中"];
            UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            pwmsUserVc.tabBarItem.selectedImage = newImage3;
            RSMyNavigationViewController *navi3 = [[RSMyNavigationViewController alloc]initWithRootViewController:pwmsUserVc];
//            [navi3 setNavigationBarHidden:YES];
            self.viewControllers = @[navi0,navi1,navi2,navi3];
            
        }
        
        
        
//        else{
//            //这边是登录的情况,没有开通
//               [self reloadNewData];
//            RSWeakself
//            self.isownData = ^(BOOL isown, NSMutableArray *temp) {
//                if (isown == true && temp.count > 0) {
//                    //审核中......
//                    RSShowAuditiewController * pwmsUserVc = [[RSShowAuditiewController alloc]init];
//                    pwmsUserVc.tabBarItem.tag = 2;
//                    pwmsUserVc.usermodel = weakSelf.userModel;
//                    pwmsUserVc.applyylistmodel = temp[0];
//                    pwmsUserVc.tabBarItem.title = @"大众云仓";
//                    pwmsUserVc.tabBarItem.image =  [UIImage imageNamed:@" 补充切图 copy 36"];
//                    UIImage * image3 = [UIImage imageNamed:@" 补充切图 copy 37"];
//                    UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                    pwmsUserVc.tabBarItem.selectedImage = newImage3;
//                    RSMyNavigationViewController * navi3 = [[RSMyNavigationViewController alloc]initWithRootViewController:pwmsUserVc];
//
//                   // [[NSNotificationCenter defaultCenter]removeObserver:weakSelf name:@"PersonalEdition" object:nil];
//
//
//
//                    RSAllHomeViewController *homePage = [[RSAllHomeViewController alloc]init];
//                    homePage.tabBarItem.tag = 3;
//                    homePage.userModel = weakSelf.userModel;
//                    homePage.tabBarItem.title = @"商圈";
//                    homePage.tabBarItem.image =  [UIImage imageNamed:@"22"];
//                    UIImage * image1 = [UIImage imageNamed:@"62"];
//                    UIImage * newImage1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                    homePage.tabBarItem.selectedImage = newImage1;
//                    RSMyNavigationViewController *navi4 = [[RSMyNavigationViewController alloc]initWithRootViewController:homePage];
//
//
//
//
//
//                    // [self changeLineOfTabbarColor];
//                    RSLeftViewController * leftVc = [[RSLeftViewController alloc]init];
//                    leftVc.title = @"我的";
//                    leftVc.tabBarItem.tag = 4;
//                    leftVc.tabBarItem.title = @"我的";
//                    leftVc.userModel = weakSelf.userModel;
//                    leftVc.tabBarItem.image = [UIImage imageNamed:@"28"];
//                    UIImage * image4 = [UIImage imageNamed:@"65"];
//                    UIImage * newImage4 = [image4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                    leftVc.tabBarItem.selectedImage = newImage4;
//                    RSMyNavigationViewController *navi5 = [[RSMyNavigationViewController alloc]initWithRootViewController:leftVc];
//
//
//                    weakSelf.viewControllers = @[navi1,navi2,navi3,navi4,navi5];
//                }else{
//                    //这边是登录了,但是还没有开通
//                    RSApplyPersonalViewController * pwmsUserVc = [[RSApplyPersonalViewController alloc]init];
//                    pwmsUserVc.tabBarItem.tag = 2;
//                    pwmsUserVc.usermodel = weakSelf.userModel;
//                    pwmsUserVc.tabBarItem.title = @"大众云仓";
//                    pwmsUserVc.tabBarItem.image =  [UIImage imageNamed:@" 补充切图 copy 36"];
//                    UIImage * image3 = [UIImage imageNamed:@" 补充切图 copy 37"];
//                    UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                    pwmsUserVc.tabBarItem.selectedImage = newImage3;
//                    RSMyNavigationViewController *navi3 = [[RSMyNavigationViewController alloc]initWithRootViewController:pwmsUserVc];
//
//
//
//                    RSAllHomeViewController *homePage = [[RSAllHomeViewController alloc]init];
//                    homePage.tabBarItem.tag = 3;
//                    homePage.userModel = weakSelf.userModel;
//                    homePage.tabBarItem.title = @"商圈";
//                    homePage.tabBarItem.image =  [UIImage imageNamed:@"22"];
//                    UIImage * image1 = [UIImage imageNamed:@"62"];
//                    UIImage * newImage1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                    homePage.tabBarItem.selectedImage = newImage1;
//                    RSMyNavigationViewController *navi4 = [[RSMyNavigationViewController alloc]initWithRootViewController:homePage];
//
//
//                    // [self changeLineOfTabbarColor];
//                    RSLeftViewController * leftVc = [[RSLeftViewController alloc]init];
//                    leftVc.title = @"我的";
//                    leftVc.tabBarItem.tag = 4;
//                    leftVc.tabBarItem.title = @"我的";
//                    leftVc.userModel = weakSelf.userModel;
//                    leftVc.tabBarItem.image = [UIImage imageNamed:@"28"];
//                    UIImage * image4 = [UIImage imageNamed:@"65"];
//                    UIImage * newImage4 = [image4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                    leftVc.tabBarItem.selectedImage = newImage4;
//                    RSMyNavigationViewController *navi5 = [[RSMyNavigationViewController alloc]initWithRootViewController:leftVc];
//
//
//                    weakSelf.viewControllers = @[navi1,navi2,navi3,navi4,navi5];
//                }
//            };
//        }
//    }else{
//
//        //这边是没有登录的情况
//        RSMyLoginViewController * pwmsUserVc = [[RSMyLoginViewController alloc]init];
//        pwmsUserVc.tabBarItem.tag = 2;
//        pwmsUserVc.tabBarItem.title = @"大众云仓";
//        pwmsUserVc.tabBarItem.image =  [UIImage imageNamed:@" 补充切图 copy 36"];
//        UIImage * image3 = [UIImage imageNamed:@" 补充切图 copy 37"];
//        UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        pwmsUserVc.tabBarItem.selectedImage = newImage3;
//        RSMyNavigationViewController *navi3 = [[RSMyNavigationViewController alloc]initWithRootViewController:pwmsUserVc];
//
//
//        RSAllHomeViewController *homePage = [[RSAllHomeViewController alloc]init];
//        homePage.tabBarItem.tag = 3;
//        homePage.userModel = self.userModel;
//        homePage.tabBarItem.title = @"商圈";
//        homePage.tabBarItem.image =  [UIImage imageNamed:@"22"];
//        UIImage * image1 = [UIImage imageNamed:@"62"];
//        UIImage * newImage1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        homePage.tabBarItem.selectedImage = newImage1;
//        RSMyNavigationViewController *navi4 = [[RSMyNavigationViewController alloc]initWithRootViewController:homePage];
//
//
//        RSMyLoginViewController * myLogin = [[RSMyLoginViewController alloc]init];
//        myLogin.title = @"我的";
//        myLogin.tabBarItem.title = @"我的";
//        myLogin.tabBarItem.tag = 4;
//        myLogin.tabBarItem.image = [UIImage imageNamed:@"28"];
//        UIImage * image4 = [UIImage imageNamed:@"64"];
//        UIImage * newImage4 = [image4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        myLogin.tabBarItem.selectedImage = newImage4;
//        RSMyNavigationViewController * navi5 = [[RSMyNavigationViewController alloc]initWithRootViewController:myLogin];
//
//
//
//        self.viewControllers = @[navi1,navi2,navi3,navi4,navi5];
//    }
    
    

}





- (void)dealloc{
//     [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
