//
//  AppDelegate.h
//  石来石往
//
//  Created by mac on 17/5/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow * window;

@property(nonatomic,assign)BOOL allowRotation;//是否允许转向


@property (nonatomic,strong)NSString * ERPID;//市场的值

@property (nonatomic,strong) RSMainTabBarViewController * mainTabbarVc;

@end

