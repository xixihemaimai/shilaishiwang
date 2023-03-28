//
//  RSRePasswordViewController.h
//  石来石往
//
//  Created by mac on 17/6/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAllViewController.h"
#import "RSUserModel.h"

@interface RSRePasswordViewController : RSAllViewController


@property (nonatomic,strong)RSUserModel *userModel;

/**判断是不是修改二级登录密码，利用这个值，来对修改登录密码还是登录二级密码的修改，true就是修改登录密码,false就是修改二级登录密码，这个是一个参数type*/
@property (nonatomic,assign)BOOL isSecondPassword;

@end
