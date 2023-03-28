//
//  NSString+RSErrerResutl.m
//  石来石往
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NSString+RSErrerResutl.h"
#import "RSLeftViewController.h"
#import "RSLoginViewController.h"
#import "RSHomeViewController.h"
#import "AppDelegate.h"
#import "MiPushSDK.h"



@implementation NSString (RSErrerResutl)




- (void)stringErrerResult:(NSString *)Message  andViewController:(UIViewController *)viewVc{
//    CLog(@"==========2323================");
    if ([Message isEqualToString:@"U_NOT_LOGIN"]) {
        //用户未登录的情况
       // [SVProgressHUD showErrorWithStatus:@"用户未登录"];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        //这边要对微信注册
//        NSData * data = [user objectForKey:@"oneUserModel"];
//        RSUserModel * userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        RSUserModel * userModel = [UserManger getUserObject];
        [MiPushSDK unsetAccount:[NSString stringWithFormat:@"%@",userModel.userID]];
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateTime=[formatter stringFromDate:[NSDate date]];
        NSDate *date = [formatter dateFromString:dateTime];
        [user setObject:date forKey:@"showAuthorization"];
//        [user removeObjectForKey:@"oneUserModel"];
        [UserManger logoOut];
        [user removeObjectForKey:@"VERIFYKEY"];
//        [user removeObjectForKey:@"USER_CODE"];
//        [user setObject:[NSString stringWithFormat:@"2"] forKey:@"temp"];
//        [user synchronize];
//        RSMainTabBarViewController * mainTabbarVc = [[RSMainTabBarViewController alloc]init];
        
        
        
        AppDelegate *applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        applegate.ERPID = @"0";
            // 必须先把根控制器modal出来的控制器dismiss掉再重设根控制器 不然之前的根控制器会释放不掉
        [applegate.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
        applegate.window.rootViewController = nil;
        RSMainTabBarViewController * mainTabbarVc = [[RSMainTabBarViewController alloc]init];
//        JJTabbarViewController *vc = [[JJTabbarViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        applegate.window.rootViewController = mainTabbarVc;
        
        
        
        
        
        
//        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        applegate.ERPID = @"0";
//        RSMainTabBarViewController * mainTabbarVc = (RSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//        RSMyNavigationViewController * nav3 = mainTabbarVc.childViewControllers[3];
//        NSMutableArray * controllers = [NSMutableArray arrayWithArray:nav3.viewControllers];
//        [controllers removeAllObjects];
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//        controllers[0] = loginVc;
//        [nav3 setViewControllers:controllers];
//        loginVc.tabBarItem.tag = 3;
//        loginVc.tabBarItem.title = @"我的";
//        loginVc.tabBarItem.image = [UIImage imageNamed:@"我的-未选中"];
//        UIImage * image3 = [UIImage imageNamed:@"我的-选中"];
//        UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        loginVc.tabBarItem.selectedImage = newImage3;
//        [viewVc.navigationController popToRootViewControllerAnimated:false];
//
        
//        if ([viewVc isKindOfClass:[RSLeftViewController class]]) {
//            RSLeftViewController * leftVc = [[RSLeftViewController alloc]init];
//            leftVc = viewVc;
//           // NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//           // [user removeObjectForKey:@"user"];
//            [leftVc.nameBtn setTitle:@"点击登录" forState:UIControlStateNormal];
//            [leftVc.fansBtn setTitle:@"粉丝" forState:UIControlStateNormal];
//            [leftVc.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
//            leftVc.nameBtn.enabled = YES;
//            leftVc.isLogin = true;
//           // leftVc.isOrdinary = false;
//            leftVc.isOwner = false;
//            leftVc.signOutview.hidden = YES;
//            leftVc.namePhone.enabled = YES;
//            [leftVc.namePhone setTitle:@"" forState:UIControlStateNormal];
//            leftVc.userModel = nil;
//            //leftVc.topBtn.enabled = NO;
//            leftVc.iconImage.image = [UIImage imageNamed:@"求真像"];
//            [leftVc.leftTableview reloadData];
//        }
        //显示登录界面
        mainTabbarVc.selectedIndex = 0;
        [JHSysAlertUtil presentAlertViewWithTitle:@"下线通知" message:@"登录已失效，请重新登录." confirmTitle:@"确定" handler:^{
           
        }];
        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下线通知" message:@"登录已失效，请重新登录." preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//          //  mainTabbarVc.selectedIndex = 0;
//            //显示登录界面
//        }];
//        [alert addAction:action];
//        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//            alert.modalPresentationStyle = UIModalPresentationFullScreen;
//        }
//        [viewVc presentViewController:alert animated:YES completion:nil];
       
  
        /*
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下线通知" message:@"您的账号已经在其他的设备上登录！如非本人操作，则密码可能已经泄露，您可以前往个人信息页面重新设置密码或者前往登录页使用手机找回密码!" preferredStyle:UIAlertControllerStyleAlert];
        
       UIAlertAction * action = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
           RSHomeViewController * homeVc = [[RSHomeViewController alloc]init];
           homeVc.isSecondLogin = NO;
           
           
           RSLeftViewController * leftVc = [[RSLeftViewController alloc]init];
           leftVc.isOrdinary = 0;
           leftVc.isLogin = 1;
           leftVc.isOwner = 0;
           leftVc.userModel = nil;
           leftVc.nameBtn.enabled = YES;
           [leftVc.nameBtn setTitle:@"点击登录" forState:UIControlStateNormal];
           
           [leftVc.tableView reloadData];
           //显示登录界面
           //RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
           [viewVc.navigationController popToViewController:homeVc animated:YES];
       }];
        [alert addAction:action];
        
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            RSHomeViewController * homeVc = [[RSHomeViewController alloc]init];
            homeVc.isSecondLogin = NO;
            
            RSLeftViewController * leftVc = [[RSLeftViewController alloc]init];
            leftVc.isOrdinary = 0;
            leftVc.isLogin = 1;
            leftVc.isOwner = 0;
            leftVc.userModel = nil;
            leftVc.nameBtn.enabled = YES;
            [leftVc.nameBtn setTitle:@"点击登录" forState:UIControlStateNormal];
            
            [leftVc.tableView reloadData];
            //显示登录界面
            
            [viewVc.navigationController popToViewController:homeVc animated:YES];
            
            
            
            
        }];
        
        [alert addAction:action1];
        
        [viewVc presentViewController:alert animated:YES completion:nil];
        
        */
       //[[NSNotificationCenter defaultCenter]postNotificationName:@"PersonalEdition" object:nil];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"用户信息不完全"];
    }
    
}


- (void)stringModelErrerResult:(NSString *)message andViewController:(UIViewController *)viewVc{
//    CLog(@"==========================");
    if ([message isEqualToString:@"U_NOT_LOGIN"]) {
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        //这边要对微信注册
//        NSData * data = [user objectForKey:@"oneUserModel"];
//        RSUserModel * userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        RSUserModel * userModel = [UserManger getUserObject];
        [MiPushSDK unsetAccount:[NSString stringWithFormat:@"%@",userModel.userID]];
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateTime=[formatter stringFromDate:[NSDate date]];
        NSDate *date = [formatter dateFromString:dateTime];
        [user setObject:date forKey:@"showAuthorization"];
        [UserManger logoOut];
        [user removeObjectForKey:@"VERIFYKEY"];
//        [user synchronize];
        
        AppDelegate *applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        applegate.ERPID = @"0";
            // 必须先把根控制器modal出来的控制器dismiss掉再重设根控制器 不然之前的根控制器会释放不掉
        [applegate.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
        applegate.window.rootViewController = nil;
        RSMainTabBarViewController * mainTabbarVc = [[RSMainTabBarViewController alloc]init];
//        JJTabbarViewController *vc = [[JJTabbarViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        applegate.window.rootViewController = mainTabbarVc;
        
        
        
        
//        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        applegate.ERPID = @"0";
//
//        //用户未登录的情况
////        RSMainTabBarViewController * mainTabbarVc = [[RSMainTabBarViewController alloc]init];
//        RSMainTabBarViewController * mainTabbarVc = (RSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
////        [UIApplication sharedApplication].keyWindow.rootViewController = mainTabbarVc;
////        UINavigationController * nav3 = mainTabbarVc.childViewControllers[3];
////        UIViewController * viewVc = nav3.childViewControllers[0];
//
//        RSMyNavigationViewController * navi3 = mainTabbarVc.viewControllers[3];
//        [navi3 popToRootViewControllerAnimated:false];
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//
//
//        NSMutableArray * controllers = [NSMutableArray arrayWithArray:navi3.viewControllers];
//        controllers[0] = loginVc;
//        [navi3 setViewControllers:controllers];
//
//
//
//        loginVc.tabBarItem.tag = 3;
//        loginVc.tabBarItem.title = @"我的";
//        loginVc.tabBarItem.image = [UIImage imageNamed:@"我的-未选中"];
//        UIImage * image3 = [UIImage imageNamed:@"我的-选中"];
//        UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        loginVc.tabBarItem.selectedImage = newImage3;
//        [navi3.navigationController popToRootViewControllerAnimated:YES];
        
        
//        if ([viewVc isKindOfClass:[RSLeftViewController class]]) {
//            RSLeftViewController * leftVc = nil;
//            leftVc = viewVc;
//            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//            [user removeObjectForKey:@"user"];
//            [user removeObjectForKey:@"VERIFYKEY"];
//            [user synchronize];
//            [leftVc.nameBtn setTitle:@"点击登录" forState:UIControlStateNormal];
//            leftVc.nameBtn.enabled = YES;
//            leftVc.isLogin = true;
//         //   leftVc.isOrdinary = false;
//            leftVc.isOwner = false;
//            leftVc.signOutview.hidden = YES;
//            leftVc.namePhone.enabled = YES;
//            [leftVc.namePhone setTitle:@"" forState:UIControlStateNormal];
//            leftVc.userModel = nil;
//            [leftVc.fansBtn setTitle:@"粉丝" forState:UIControlStateNormal];
//            [leftVc.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
//            //leftVc.topBtn.enabled = NO;
//            leftVc.iconImage.image = [UIImage imageNamed:@"求真像"];
//            [leftVc.leftTableview reloadData];
//        }
//        //显示登录界面
//        if ([viewVc respondsToSelector:@selector(presentingViewController)]) {
//             [viewVc.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//        }
        //显示登录界面
        mainTabbarVc.selectedIndex = 0;
        [JHSysAlertUtil presentAlertViewWithTitle:@"下线通知" message:@"登录已失效，请重新登录." cancelTitle:@"重新登录" defaultTitle:@"确定" distinct:YES cancel:^{
           
        } confirm:^{
                    
        }];
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下线通知" message:@"登录已失效，请重新登录." preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction * action = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        }];
//        [alert addAction:action];
//        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//        [alert addAction:action1];
//        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//           alert.modalPresentationStyle = UIModalPresentationFullScreen;
//        }
//        [viewVc presentViewController:alert animated:YES completion:nil];
    }else{
        [SVProgressHUD showErrorWithStatus:@"用户信息不完全"];
    }
}


@end
