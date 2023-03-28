//
//  RSJumpPlayVideoTool.m
//  石来石往
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSJumpPlayVideoTool.h"
#import "RSVideoScreenViewController.h"

@implementation RSJumpPlayVideoTool
+ (void)canYouSkipThePlaybackVideoInterfaceRSFriendModel:(RSFriendModel *)friendmodel andViewController:(UIViewController *)viewController{
    if ([friendmodel.viewType isEqualToString:@"video"]) {
        //这边判断是不是wifi的环境下
       
        __weak AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            // 当网络状态改变时调用
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    //NSLog(@"未知网络");
                    [SVProgressHUD showErrorWithStatus:@"手机没有连接网络"];
                     [manager stopMonitoring];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    [SVProgressHUD showErrorWithStatus:@"手机没有连接网络"];
                    [manager stopMonitoring];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    //NSLog(@"手机自带网络");
                    [self alertUserOnVideoPlayViewControlerNetwork:friendmodel andViewController:viewController];
                     [manager stopMonitoring];
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [self jumpVideoPlayViewController:friendmodel andViewController:viewController];
                     [manager stopMonitoring];
                    break;
            }
        }];
        //开始监控
        [manager startMonitoring];
    }else{
        [SVProgressHUD showErrorWithStatus:@"不是视频不能播"];
    }
}



+ (void)alertUserOnVideoPlayViewControlerNetwork:(RSFriendModel *)friedmodel andViewController:(UIViewController *)viewController{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * viedoPlayStatus = [user objectForKey:@"viedoPlayStatus"];
    if ([viedoPlayStatus isEqualToString:@"1"]) {
        [user setObject:@"1" forKey:@"viedoPlayStatus"];
        [self jumpVideoPlayViewController:friedmodel andViewController:viewController];
    }else{
        [JHSysAlertUtil presentAlertViewWithTitle:@"你的网络不处于wifi状态播放该视频,将消耗你的手机流量，是否继续播放" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            [user setObject:@"0" forKey:@"viedoPlayStatus"];
        } confirm:^{
            [user setObject:@"1" forKey:@"viedoPlayStatus"];
            [self jumpVideoPlayViewController:friedmodel andViewController:viewController];
        }];
    }
}


+ (void)jumpVideoPlayViewController:(RSFriendModel *)friedmodel andViewController:(UIViewController *)viewController{
    RSVideoScreenViewController * videoScreenVc = [[RSVideoScreenViewController alloc]init];
    videoScreenVc.title = friedmodel.HZName;
    NSURL * url = [NSURL URLWithString:friedmodel.video];
    videoScreenVc.outPutUrl = url;
    [viewController.navigationController pushViewController:videoScreenVc animated:YES];
}


+ (void)canYouSkipThePlaybackVideoInterfaceMoment:(Moment *)moment andViewController:(UIViewController *)viewController{
    
    if ([moment.viewType isEqualToString:@"video"]) {
        //这边判断是不是wifi的环境下
        
        __weak AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            // 当网络状态改变时调用
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    //NSLog(@"未知网络");
                    [SVProgressHUD showErrorWithStatus:@"手机没有连接网络"];
                    [manager stopMonitoring];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    [SVProgressHUD showErrorWithStatus:@"手机没有连接网络"];
                    [manager stopMonitoring];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    //NSLog(@"手机自带网络");
                    [self alertUserOnVideoPlayViewControlerNetworkMoment:moment andViewController:viewController];
                    [manager stopMonitoring];
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [self jumpVideoPlayViewControllerMoment:moment andViewController:viewController];
                    [manager stopMonitoring];
                    break;
            }
        }];
        //开始监控
        [manager startMonitoring];
    }else{
        [SVProgressHUD showErrorWithStatus:@"不是视频不能播"];
    }

}



+ (void)alertUserOnVideoPlayViewControlerNetworkMoment:(Moment *)moment andViewController:(UIViewController *)viewController{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * viedoPlayStatus = [user objectForKey:@"viedoPlayStatus"];
    if ([viedoPlayStatus isEqualToString:@"1"]) {
        [user setObject:@"1" forKey:@"viedoPlayStatus"];
        [self jumpVideoPlayViewControllerMoment:moment andViewController:viewController];
    }else{
        [JHSysAlertUtil presentAlertViewWithTitle:@"你的网络不处于wifi状态播放该视频,将消耗你的手机流量，是否继续播放" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            [user setObject:@"0" forKey:@"viedoPlayStatus"];
        } confirm:^{
            [user setObject:@"1" forKey:@"viedoPlayStatus"];
            [self jumpVideoPlayViewControllerMoment:moment andViewController:viewController];
        }];
    }
}


+ (void)jumpVideoPlayViewControllerMoment:(Moment *)moment andViewController:(UIViewController *)viewController{
    RSVideoScreenViewController * videoScreenVc = [[RSVideoScreenViewController alloc]init];
    videoScreenVc.title = moment.HZName;
    NSURL * url = [NSURL URLWithString:moment.video];
    videoScreenVc.outPutUrl = url;
    [viewController.navigationController pushViewController:videoScreenVc animated:YES];
}


@end
