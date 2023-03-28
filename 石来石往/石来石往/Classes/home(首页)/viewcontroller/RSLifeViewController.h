//
//  RSLifeViewController.h
//  石来石往
//
//  Created by mac on 2017/11/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSHomeViewController.h"
#import "RSUserModel.h"
#import "MomentViewController.h"

@interface RSLifeViewController : MomentViewController
@property (nonatomic,strong)RSUserModel * userModel;

///**登录成功之后*/
//@property (nonatomic,assign)BOOL isOwner;
//
///**没有登录和登录失败*/
//@property (nonatomic,assign)BOOL isLogin;

/**选择类型*/
//@property (nonatomic,strong)NSString * tempStyle;
@end
