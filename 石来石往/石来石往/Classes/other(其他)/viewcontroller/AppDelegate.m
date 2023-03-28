//
//  AppDelegate.m
//  石来石往
//
//  Created by mac on 17/5/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "RSHomeViewController.h"


#import "RSLeftViewController.h"


//支付宝
//#import <AlipaySDK/AlipaySDK.h>

//友盟统计
//#import <UMAnalytics/MobClick.h>
//#import <UMCommon/UMCommon.h>

//微信登录
//#import <WXApi.h>
#import "WXApi.h"


//微信登录之后返回的数据
#import "RSWeiXiModel.h"

#import "RSWeiXiViewController.h"

#import "RSLoginViewController.h"




#import "RSBootPageViewController.h"


// 用户注册的用户信息模型
#import "RSRegisterModel.h"
#import "MyMD5.h"


#import "RSMainTabBarViewController.h"

#import "Nonetwork.h"

#import "RSADViewController.h"

#import "RSAllHomeViewController.h"
//#import "RSMyLoginViewController.h"
#import "RSHSViewController.h"

#import <CoreTelephony/CTCellularData.h>

//WXApiDelegate
@interface AppDelegate ()<MiPushSDKDelegate,UNUserNotificationCenterDelegate,UITabBarControllerDelegate>
{
    
     UIViewController *tempViewControl;
    
}


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.ERPID = @"0";
    //用来判断业务办理里面界面的授权
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    [user setObject:@"0" forKey:@"showAuthorization"];
    
    if (UIDevice.currentDevice.systemVersion.floatValue <= 10.0) {
        [self networkStatus:application didFinishLaunchingWithOptions:launchOptions];
    }else {
        //2.2已经开启网络权限 监听网络状态
        [self addReachabilityManager:application didFinishLaunchingWithOptions:launchOptions];
    }
    
    
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    //强制手机是暗黑模式，还是常亮 还是跟着系统
//    if(@available(iOS 13.0,*)){
//        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleUnspecified;
//    }
    
    //友盟统计
//    [UMConfigure setLogEnabled:YES];
//    [UMConfigure initWithAppkey:@"5949c5f49f06fd23fc002315" channel:@"App Store"];
//    [MobClick setScenarioType:E_UM_NORMAL];
    //微信登录ID
//    [WXApi registerApp:WXAPPID];
    
    [WXApi registerApp:WXAPPID universalLink:@"https://www.baidu.com/"];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    //设置键盘
    [self settIQKeyMananger];
 //这句话是解决-当我们从含有Tabbar的页面push到子页面后再pop回来的时候，会发现Tabbar的item向上偏移了一下，然后又回到原位置
    //去掉tabbar的透明度
    [[UITabBar appearance] setTranslucent:NO];
    NSUserDefaults * useDef = [NSUserDefaults standardUserDefaults];
    // 使用 NSUserDefaults 读取用户数据
    [SDWebImageManager sharedManager].imageCache.maxMemoryCountLimit = 10000000000;
    if (![useDef boolForKey:@"notFirst"]) {
        // 如果是第一次进入引导页
        self.window.rootViewController = [[RSBootPageViewController alloc] init];
    }
    else{
        RSADViewController * adVc = [[RSADViewController alloc]init];
        self.window.rootViewController = adVc;
        // 否则直接进入应用
//        [[UITabBar appearance]setTintColor:[UIColor colorWithRed:41/255.0 green:51/255.0 blue:65/255.0 alpha:1]];
//        RSMainTabBarViewController * mainTabbarVc = [[RSMainTabBarViewController alloc]init];
//        self.mainTabbarVc = mainTabbarVc;
//        //mainTabbarVc.delegate = self;
//        self.window.rootViewController = mainTabbarVc;
//        mainTabbarVc.delegate = self;
    }
    
    //URL_LOGIN_VALIDITY
    [self.window makeKeyAndVisible];
   
    if ([UserManger isLogin]) {
//        NSString * VERIFYKEY = [useDef objectForKey:@"VERIFYKEY"];
        [RSInitUserInfoTool registermodelUSER_CODE:[UserManger getUserObject].userCode andVERIFYKEY:[UserManger Verifykey] andViewController:nil andObtain:^(BOOL isValue) {
        }];
    }
    
    
    
    //设置网络提醒
    //[self networkInspect];
    
    return YES;
}

/*
 获取网络权限状态
 */
- (void)networkStatus:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //2.根据权限执行相应的交互
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    /*
     此函数会在网络权限改变时再次调用
     */
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
        switch (state) {
            case kCTCellularDataRestricted:
                NSLog(@"Restricted");
                //2.1权限关闭的情况下 再次请求网络数据会弹出设置网络提示
                [self networkSettingAlert];
                break;
            case kCTCellularDataNotRestricted:
                NSLog(@"NotRestricted");
                //2.2已经开启网络权限 监听网络状态
                [self addReachabilityManager:application didFinishLaunchingWithOptions:launchOptions];
                break;
            case kCTCellularDataRestrictedStateUnknown:
                NSLog(@"Unknown");
                [self unknownNetwork];
                break;
            default:
                break;
        }
    };
}

- (void)networkSettingAlert {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您尚未授权“app”访问网络的权限，请前往设置开启网络授权" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }]];
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)unknownNetwork {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未知网络" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}


/**
 实时检查当前网络状态
 */
- (void)addReachabilityManager:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"网络不通：%@",@(status) );
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"网络通过WIFI连接：%@",@(status));
             
                [self getInfo_application:application didFinishLaunchingWithOptions:launchOptions];
             
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"网络通过无线连接：%@",@(status) );
              
                [self getInfo_application:application didFinishLaunchingWithOptions:launchOptions];
            
                break;
            }
            default:
                break;
        }
    }];
    [afNetworkReachabilityManager startMonitoring];  //开启网络监视器；
}


//把以前写在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions里面的一些初始化操作放在该方法
- (void)getInfo_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (@available(iOS 16.0, *)){
        //小米推送
        
        [MiPushSDK registerMiPush:self type:0 connect:YES];
        
        // 点击通知打开app处理逻辑
        NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if(userInfo){
            NSString *messageId = [userInfo objectForKey:@"_id_"];
            if (messageId!=nil) {
                [MiPushSDK openAppNotify:messageId];
            }
        }
        
        
    }else{
        //小米推送
        [MiPushSDK registerMiPush:self type:0 connect:YES];
        // 点击通知打开app处理逻辑
        NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if(userInfo){
            NSString *messageId = [userInfo objectForKey:@"_id_"];
            if (messageId!=nil) {
                [MiPushSDK openAppNotify:messageId];
            }
        }
    }
    
    
}



//FIXME:这边是设置键盘
- (void)settIQKeyMananger{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = NO; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 0.0f; // 输入框距离键盘的距离
}



//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//
//    if ([url.host isEqualToString:@"safepay"]) {
//        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            //NSLog(@"result = %@",resultDic);
//
//            NSInteger orderState=[resultDic[@"resultStatus"] integerValue];
//
//            if (orderState==9000) {
//                //[[NSNotificationCenter defaultCenter]postNotificationName:zhifubao object:self userInfo:resultDic];
//                /*
//                 NSString *allString=resultDic[@"result"];
//                 NSString * FirstSeparateString=@"\"&";
//                 NSString *  SecondSeparateString=@"=\"";
//                 NSMutableDictionary *dic=[self VEComponentsStringToDic:allString withSeparateString:FirstSeparateString AndSeparateString:SecondSeparateString];
//                 NSLog(@"ali=%@",dic);
//                 if ([dic[@"success"]isEqualToString:@"true"]) {
//                 [[NSNotificationCenter defaultCenter]postNotificationName:zhifubao object:self userInfo:resultDic];
//                 }
//                 */
//                [SVProgressHUD showSuccessWithStatus:@"订单成功"];
//
//
//            }else{
//                NSString *returnStr;
//                switch (orderState) {
//                    case 8000:
//                        returnStr=@"订单正在处理中";
//                        break;
//                    case 4000:
//                        returnStr=@"订单支付失败";
//                        break;
//                    case 6001:
//                        returnStr=@"订单取消";
//                        break;
//                    case 6002:
//                        returnStr=@"网络连接出错";
//                        break;
//
//                    default:
//                        break;
//                }
//                [ SVProgressHUD showErrorWithStatus:returnStr];
//                // [HUDTooles removeHUD:4];
//
//            }
//
//
//
//        }];
//    }
//
//    return [WXApi handleOpenURL:url delegate:self];
//}

// NOTE: 9.0以后使用新API接口
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
//{
//    if ([url.host isEqualToString:@"safepay"]) {
//        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            //NSLog(@"result = %@",resultDic);
//
//            NSInteger orderState=[resultDic[@"resultStatus"] integerValue];
//
//            if (orderState==9000) {
//                //[[NSNotificationCenter defaultCenter]postNotificationName:zhifubao object:self userInfo:resultDic];
//                /*
//                 NSString *allString=resultDic[@"result"];
//                 NSString * FirstSeparateString=@"\"&";
//                 NSString *  SecondSeparateString=@"=\"";
//                 NSMutableDictionary *dic=[self VEComponentsStringToDic:allString withSeparateString:FirstSeparateString AndSeparateString:SecondSeparateString];
//                 NSLog(@"ali=%@",dic);
//                 if ([dic[@"success"]isEqualToString:@"true"]) {
//                 [[NSNotificationCenter defaultCenter]postNotificationName:zhifubao object:self userInfo:resultDic];
//                 }
//                 */
//                [SVProgressHUD showSuccessWithStatus:@"订单成功"];
//
//
//            }else{
//                NSString *returnStr;
//                switch (orderState) {
//                    case 8000:
//                        returnStr=@"订单正在处理中";
//                        break;
//                    case 4000:
//                        returnStr=@"订单支付失败";
//                        break;
//                    case 6001:
//                        returnStr=@"订单取消";
//                        break;
//                    case 6002:
//                        returnStr=@"网络连接出错";
//                        break;
//
//                    default:
//                        break;
//                }
//                [ SVProgressHUD showErrorWithStatus:returnStr];
//                // [HUDTooles removeHUD:4];
//            }
//        }];
//    }
//
//    return [WXApi handleOpenURL:url delegate:self];
//}





//-(void)networkInspect
//{
//    __weak typeof(self) weakSelf = self;
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//
//    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//
//        // 当网络状态改变时调用
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:
//                //NSLog(@"未知网络");
//                [weakSelf showNetWorkBar];
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                //NSLog(@"没有网络");
//                //此步意义不明
////                if([[self topViewController]class] ==[ToolNetWorkSolveVC class])
////                {
////                    [self dismissNetWorkBar];
////                    return;
////                }
//               // [self showNetWorkBar];
//
//                [weakSelf showNetWorkBar];
//
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                //NSLog(@"手机自带网络");
//
//
//
//             //   [weakSelf showPhoneNetworkBar];
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                //NSLog(@"WIFI");
//
//
//                //[weakSelf showWIFINetworkBar];
//                break;
//        }
//    }];
//
//    //开始监控
//    [manager startMonitoring];
//}
//
//
//- (void)showNetWorkBar{
//
//    tempViewControl = [self topViewController];
//
//    [self showNotNetworkView:[self topViewController]];
//
//}
//
//
//- (void)showWIFINetworkBar{
//
//    tempViewControl = [self topViewController];
//
//    [self showWifiNetwork:[self topViewController]];
//
//}
//
//
//
//- (void)showPhoneNetworkBar{
//    tempViewControl = [self topViewController];
//
//    [self showYouPhoneNetWork:[self topViewController]];
//}
//
//
////获取当前屏幕显示的viewcontroller
//- (UIViewController*)topViewController
//{
//    return [self topViewControllerWithRootViewController:self.window.rootViewController];
//}
//
//- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
//{
//    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
//        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
//        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
//    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
//        UINavigationController* navigationController = (UINavigationController*)rootViewController;
//        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
//    } else if (rootViewController.presentedViewController) {
//        UIViewController* presentedViewController = rootViewController.presentedViewController;
//        return [self topViewControllerWithRootViewController:presentedViewController];
//    } else {
//        return rootViewController;
//    }
//}
//
//#pragma mark -- 当没有网络的时候
//- (void)showNotNetworkView:(UIViewController *)viewController{
//    Nonetwork *Nonet=[[Nonetwork alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    Nonet.Prompt=@"无法连接服务器，请检查你的网络设置";
//    Nonet.typeDisappear=0;
//    Nonet.Warningicon.image=[UIImage imageNamed:@"internet"];
//    [Nonet popupWarningview];
//    Nonet.returnsAnEventBlock = ^{
//       // NSLog(@"重新加载数据");
//    };
//    [Nonet bringSubviewToFront:viewController.view];
//    [viewController.view addSubview:Nonet];
//}
//
//#pragma mark -- 有WIFT的时候
//- (void)showWifiNetwork:(UIViewController *)viewController{
//    Nonetwork *Nonet=[[Nonetwork alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    Nonet.Prompt=@"已连接WIFI";
//    Nonet.typeDisappear=0;
//    Nonet.Warningicon.image=[UIImage imageNamed:@"WIFI 我fi"];
//    [Nonet popupWarningview];
//    Nonet.returnsAnEventBlock = ^{
//        //NSLog(@"重新加载数据");
//    };
//    [Nonet bringSubviewToFront:viewController.view];
//    [viewController.view addSubview:Nonet];
//}
//
//#pragma mark -- 手机的网络
//- (void)showYouPhoneNetWork:(UIViewController *)viewController{
//    Nonetwork *Nonet=[[Nonetwork alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    Nonet.Prompt=@"已连接手机网络";
//    Nonet.typeDisappear=0;
//    Nonet.Warningicon.image=[UIImage imageNamed:@"4g"];
//    [Nonet popupWarningview];
//    Nonet.returnsAnEventBlock = ^{
//        //NSLog(@"重新加载数据");
//    };
//    [Nonet bringSubviewToFront:viewController.view];
//    [viewController.view addSubview:Nonet];
//}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    return [WXApi handleOpenUniversalLink:userActivity delegate:[WXApiManager sharedManager]];
}


//- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRest
//oring>> * __nullable restorableObjects))restorationHandler {
//    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
//}


    
//- (void)onResp:(BaseResp *)resp{
//    if ([resp isKindOfClass:[SendAuthResp class]]) {
//        SendAuthResp* authResp = (SendAuthResp *)resp;
//        NSString * code = authResp.code;
//        [self getWeiXinOpenId:code];
//    }
//}
//
//
////通过code获取access_token，openid，unionid
//- (void)getWeiXinOpenId:(NSString *)code{
//    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WXAPPID,WXSERECT,code];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL *zoneUrl = [NSURL URLWithString:url];
//        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
//        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (data){
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//               NSString *openID = dic[@"openid"];
//               //NSString *unionid = dic[@"unionid"];
//                NSString *token = dic[@"access_token"];
//                [self getUserInfo:token andOpenID:openID];
//            }
//        });
//    });
//
//}
//
//
////获取用户信息
//-(void)getUserInfo:(NSString *)acces_token andOpenID:(NSString *)openid
//{
//    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
//    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",acces_token,openid];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL *zoneUrl = [NSURL URLWithString:url];
//        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
//        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (data) {
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                /*
//                 {
//                 city = Haidian;
//                 country = CN;
//                 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
//                 language = "zh_CN";
//                 nickname = "xxx";
//                 openid = oyAaTjsDx7pl4xxxxxxx;
//                 privilege =     (
//                 );
//                 province = Beijing;
//                 sex = 1;
//                 unionid = oyAaTjsxxxxxxQ42O3xxxxxxs;
//                 }
//                 */
////                self.nickname.text = [dic objectForKey:@"nickname"];
////                self.wxHeadImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]]];
//                //要保持获取微信返回的的数据的值，保持在本地的地方上面
//                RSWeiXiModel * weixiModel = [[RSWeiXiModel alloc]init];
//                weixiModel.openid = dic[@"openid"];
//                weixiModel.unionid = dic[@"unionid"];
//                weixiModel.nickname = dic[@"nickname"];
//                weixiModel.city = dic[@"city"];
//                weixiModel.country = dic[@"country"];
//                weixiModel.headimgurl = dic[@"headimgurl"];
//                weixiModel.language = dic[@"language"];
//                weixiModel.privilege = dic[@"privilege"];
//                weixiModel.province = dic[@"province"];
//                weixiModel.sex = dic[@"sex"];
//                //这边要对weixiModel进行保存
//                //[GlobaHelper setObject:weixiModel key:@"weiximodel"];
//                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//                [user setObject:weixiModel.openid forKey:@"openid"];
//                [user setObject:weixiModel.unionid forKey:@"unionid"];
//                [user setObject:weixiModel.nickname forKey:@"nickname"];
//                [user setObject:weixiModel.city forKey:@"city"];
//                [user setObject:weixiModel.country forKey:@"country"];
//                [user setObject:weixiModel.headimgurl forKey:@"headimgurl"];
//                [user setObject:weixiModel.language forKey:@"language"];
//                [user setObject:weixiModel.privilege forKey:@"privilege"];
//                [user setObject:weixiModel.province forKey:@"province"];
//                [user setObject:weixiModel.sex forKey:@"sex"];
//                [user synchronize];
//                [SVProgressHUD showWithStatus:@"正在验证中"];
//                NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//                //这边要先获取到微信里面UID;
//                //自己做测试用的
//////                weixiModel.unionid = @"oLUv8jh77JK7qulXqZ7WvgTOO9_Q";
////                NSString *unionid = [NSString stringWithFormat:@"oLUv8jh77JK7qulXqZ7WvgTOO%d_Q",arc4random_uniform(256)];
////                weixiModel.unionid = unionid;
//                if (weixiModel.unionid == nil) {
//                    [phoneDict setObject:@"" forKey:@"WC_UID"];
//                }else{
//                    [phoneDict setObject:weixiModel.unionid forKey:@"WC_UID"];
//                }
//                //二进制数
//                NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//                NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":self.ERPID};
//                //URL_IS_WECHAT_REGISTED_IOS URL_IS_WECHAT_REGISTED
//                XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//                [network getDataWithUrlString:URL_WECHAT_QQ_LOGIN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//                    [SVProgressHUD dismiss];
//                    if (success) {
//                        if(![json[@"MSG_CODE"] isEqualToString:@"U_NOT_EXIST"]){
////                            [[NSNotificationCenter defaultCenter]postNotificationName:@"jumpWeixinViewControler" object:nil];
////                            return;
//                            //这边是已经绑定过了的
////                            NSString * phone = json[@"Data"][@"USER_CODE"];
////                            [self initLogin:phone];
////                            RSRegisterModel *registerMode = [RSRegisterModel yy_modelWithJSON:json[@"Data"]];
////                            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:registerMode];
////                            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
////                            [user setObject:data forKey:@"user"];
////                            [user setObject:registerMode.VERIFYKEY forKey:@"VERIFYKEY"];
////                            [user synchronize];
//
//
//
//
////                            [RSInitUserInfoTool registermodelUSER_CODE:[NSString stringWithFormat:@"%@",json[@"Data"][@"USER_CODE"]] andVERIFYKEY:[NSString stringWithFormat:@"%@",json[@"Data"][@"VERIFYKEY"]] andViewController:nil];
//
//
//                            [RSInitUserInfoTool registermodelUSER_CODE:[NSString stringWithFormat:@"%@",json[@"Data"][@"USER_CODE"]] andVERIFYKEY:[NSString stringWithFormat:@"%@",json[@"Data"][@"VERIFYKEY"]] andViewController:nil andObtain:^(BOOL isValue) {
//
//                                if (isValue) {
//                                     [[NSNotificationCenter defaultCenter]postNotificationName:@"formLoginToHomeViewController" object:nil];
//                                }
//                            }];
//                            //登录信息，获取用户的信息
//                            //[[NSNotificationCenter defaultCenter]postNotificationName:@"loginNSNotificationCenter" object:nil];
//                            //对界面进行判断跳转回去
//                            //从登录的页面跳转到首页面
////                            [[NSNotificationCenter defaultCenter]postNotificationName:@"formLoginToHomeViewController" object:nil];
//                        }else{
//                            //这边要对U_NOT_EXIST这个来进行判断
//                            [[NSNotificationCenter defaultCenter]postNotificationName:@"jumpWeixinViewControler" object:nil];
//                        }
//                    }
//                }];
//            }
//        });
//    });
//}

//- (void)initLogin:(NSString * )phone{
//    [SVProgressHUD showWithStatus:@"正在登录"];
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSMutableDictionary *request = [NSMutableDictionary dictionary];
//    [request setObject:phone forKey:@"USER_CODE"];
//    [request setObject:[user objectForKey:@"PWD"] forKey:@"USER_PASSWORD"];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:request options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode]};
//   // __weak typeof(self) weakSelf = self;
//    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_LOGIN withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//               RSRegisterModel *registerMode = [RSRegisterModel yy_modelWithJSON:json[@"Data"]];
//                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:registerMode];
//                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                [user setObject:data forKey:@"user"];
//                [user setObject:registerMode.VERIFYKEY forKey:@"VERIFYKEY"];
//                [user synchronize];
//                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
//                //登录信息，获取用户的信息
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"loginNSNotificationCenter" object:nil];
//                //对界面进行判断跳转回去
//                //从登录的页面跳转到首页面
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"formLoginToHomeViewController" object:nil];
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"登录失败"];
//            }
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"登录失败"];
//        }
//    }];
//}

#pragma mark -- 这下面都是小米推送获取推送消息ios10.0之前
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    
    //NSLog(@"------------77777777------%@",[NSString stringWithFormat:@"APNS notify: %@", userInfo]);
    
    //NSString *messageId = [userInfo objectForKey:@"_id_"];
    
    
    // 当同时启动APNs与内部长连接时, 把两处收到的消息合并. 通过miPushReceiveNotification返回
    [MiPushSDK handleReceiveRemoteNotification:userInfo];
    
    //[MiPushSDK openAppNotify:messageId];
}

#pragma mark 注册push服务.
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
   // [vMain printLog:[NSString stringWithFormat:@"APNS token: %@", [deviceToken description]]];
    
    //NSLog(@"-----------888888-------%@",[NSString stringWithFormat:@"APNS token: %@", [deviceToken description]]);
    // 注册APNS成功, 注册deviceToken
    [MiPushSDK bindDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    //[vMain printLog:[NSString stringWithFormat:@"APNS error: %@", err]];
    
    // 注册APNS失败.
    // 自行处理.
    NSLog(@"-----9999999-------%@",[NSString stringWithFormat:@"APNS error: %@", err]);
}


// iOS10新加入的回调方法
// 应用在前台收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
       // [vMain printLog:[NSString stringWithFormat:@"APNS notify: %@", userInfo]];
        
        //NSLog(@"--------------10000-----------%@",[NSString stringWithFormat:@"APNS notify: %@", userInfo]);
        
        [MiPushSDK handleReceiveRemoteNotification:userInfo];
    }
        completionHandler(UNNotificationPresentationOptionAlert);
}

// 点击通知进入应用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
       // [vMain printLog:[NSString stringWithFormat:@"APNS notify: %@", userInfo]];
       // NSLog(@"---------------11111111----------%@",[NSString stringWithFormat:@"APNS notify: %@", userInfo]);
        [MiPushSDK handleReceiveRemoteNotification:userInfo];
    }
    completionHandler();
}

#pragma mark MiPushSDKDelegate
- (void)miPushRequestSuccWithSelector:(NSString *)selector data:(NSDictionary *)data
{
    //[vMain printLog:[NSString stringWithFormat:@"command succ(%@): %@", [self getOperateType:selector], data]];
   // NSLog(@"--------------122222222-----------%@",[NSString stringWithFormat:@"command succ(%@): %@", [self getOperateType:selector], data]);
    
    if ([selector isEqualToString:@"registerMiPush:"]) {
        //[vMain setRunState:YES];
    }else if ([selector isEqualToString:@"registerApp"]) {
        // 获取regId
       // NSLog(@"regid = %@", data[@"regid"]);
    }else if ([selector isEqualToString:@"bindDeviceToken:"]) {
      //  [MiPushSDK setAlias:@"1"];
       // [MiPushSDK subscribe:@"2"];
       // [MiPushSDK setAccount:@"8"];
        // 获取regId
        //NSLog(@"regid = %@", data[@"regid"]);
        //[self userModerMessage];
    }else if ([selector isEqualToString:@"unregisterMiPush"]) {
       // [vMain setRunState:NO];
    }
    NSMutableArray * array = [NSMutableArray array];
    array = data[@"list"];
    if (array.count > 0) {
        for (int i = 0; i < array.count; i++) {
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            NSData * data = [user objectForKey:@"oneUserModel"];
            RSUserModel * userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            NSString * str = array[i];
            if ([[NSString stringWithFormat:@"%@",userModel.userID] isEqualToString:str]) {
                //相同
            }else{
               //不同
                NSString * str = array[i];
                [MiPushSDK unsetAccount:[NSString stringWithFormat:@"%@",str]];
            }
        }
    }
}

- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data
{
    // [vMain printLog:[NSString stringWithFormat:@"command error(%d|%@): %@", error, [self getOperateType:selector], data]];
    
  //  NSLog(@"-------------1333333333---------%@",[NSString stringWithFormat:@"command error(%d|%@): %@", error, [self getOperateType:selector], data]);
}

- (void)miPushReceiveNotification:(NSDictionary*)data
{
    // 1.当启动长连接时, 收到消息会回调此处
    // 2.[MiPushSDK handleReceiveRemoteNotification]
    //   当使用此方法后会把APNs消息导入到此
    //[vMain printLog:[NSString stringWithFormat:@"XMPP notify: %@", data]];
}







- (NSString*)getOperateType:(NSString*)selector
{
    NSString *ret = nil;
    if ([selector hasPrefix:@"registerMiPush:"] ) {
        ret = @"客户端注册设备";
    }else if ([selector isEqualToString:@"unregisterMiPush"]) {
        ret = @"客户端设备注销";
    }else if ([selector isEqualToString:@"registerApp"]) {
        ret = @"注册App";
    }else if ([selector isEqualToString:@"bindDeviceToken:"]) {
        ret = @"绑定 PushDeviceToken";
    }else if ([selector isEqualToString:@"setAlias:"]) {
        ret = @"客户端设置别名";
    }else if ([selector isEqualToString:@"unsetAlias:"]) {
        ret = @"客户端取消别名";
    }else if ([selector isEqualToString:@"subscribe:"]) {
        ret = @"客户端设置主题";
    }else if ([selector isEqualToString:@"unsubscribe:"]) {
        ret = @"客户端取消主题";
    }else if ([selector isEqualToString:@"setAccount:"]) {
        ret = @"客户端设置账号";
    }else if ([selector isEqualToString:@"unsetAccount:"]) {
        ret = @"客户端取消账号";
    }else if ([selector isEqualToString:@"openAppNotify:"]) {
        ret = @"统计客户端";
    }else if ([selector isEqualToString:@"getAllAliasAsync"]) {
        ret = @"获取Alias设置信息";
    }else if ([selector isEqualToString:@"getAllTopicAsync"]) {
        ret = @"获取Topic设置信息";
    }

    return ret;
}



- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == true) {   // 如果属性值为YES,仅允许屏幕向左旋转,否则仅允许竖屏
        return UIInterfaceOrientationMaskAll;  // 这里是屏幕要旋转的方向
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}

- (BOOL)shouldAutorotate
{
    if (_allowRotation == true) {
        return YES;
    }
    return NO;
}

#pragma mark -- tabBarControllerDelegate --- 这边修改了
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"isNewData" object:nil];
//    if (tabBarController.selectedIndex == 2) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"PersonalEdition" object:nil];
//    }
}


/*
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.tabBarItem.title isEqualToString:@"荒料"]||[viewController.tabBarItem.title isEqualToString:@"大板"]) {
        //如果用户ID存在的话，说明已登陆
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
        if (verifykey.length > 0) {
            return YES;
        }else{
            RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
            loginVc.hidesBottomBarWhenPushed =YES;
            [((UINavigationController *)tabBarController.selectedViewController)pushViewController:loginVc animated:YES];
            return NO;
        }
    }else {
        return YES;
    }
    return YES;
}
*/



//- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
//    
//}

#pragma mark -- 对推送的显示的次数进行设置
- (void)applicationWillResignActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    [user setObject:@"1" forKey:@"showAuthorization"];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter]postNotificationName:@"isNewData" object:nil];
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * showAuthorization = [user objectForKey:@"showAuthorization"];
//    if ([showAuthorization isEqualToString:@"0"]) {
//         [user setObject:@"0" forKey:@"showAuthorization"];
//    }else{
//         [user setObject:@"1" forKey:@"showAuthorization"];
//    }
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
//    UIViewController * viewController =  [self topViewController];
//    if ([viewController isKindOfClass:[RSAllHomeViewController class]]) {
//         viewController.hidesBottomBarWhenPushed = NO;
//    }else if ([viewController isKindOfClass:[RSHSViewController class]]){
//        viewController.hidesBottomBarWhenPushed = NO;
//    }else if ([viewController isKindOfClass:[RSLeftViewController class]]){
//        viewController.hidesBottomBarWhenPushed = NO;
//    }else if ([viewController isKindOfClass:[RSLoginViewController class]]){
//        viewController.hidesBottomBarWhenPushed = NO;
//    }else{
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   // [[NSNotificationCenter defaultCenter]postNotificationName:@"applicationDidBecomeActive" object:nil];
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    [user setObject:@"0" forKey:@"showAuthorization"];
}


@end
