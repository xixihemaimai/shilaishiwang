//
//  RSUserManagementModel.h
//  石来石往
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSUserManagementModel : NSObject

/**
 用户ID    id
 父账号ID    parentId
 角色ID    roleId
 角色名称    roleName
 绑定石来石往账户ID    sysUserId
 用户名称    userName
 用户电话    userPhone
 用户类别    userType
 */


@property (nonatomic,assign)NSInteger userManagementID;

@property (nonatomic,assign)NSInteger parentId;

@property (nonatomic,assign)NSInteger roleId;

@property (nonatomic,assign)NSInteger sysUserId;

@property (nonatomic,strong)NSString * roleName;

@property (nonatomic,strong)NSString * userName;

@property (nonatomic,strong)NSString * userPhone;

@property (nonatomic,strong)NSString * userType;


@end

NS_ASSUME_NONNULL_END
