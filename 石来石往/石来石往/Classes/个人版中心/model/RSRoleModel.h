//
//  RSRoleModel.h
//  石来石往
//
//  Created by mac on 2019/4/3.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSRoleModel : NSObject

/**角色ID*/
@property (nonatomic,assign)NSInteger roleID;
/**所属用户(主账号)*/
@property (nonatomic,assign)NSInteger pwmsUserId;
/**状态*/
@property (nonatomic,assign)NSInteger status;
/**创建人个人版ID*/
@property (nonatomic,assign)NSInteger createUser;
/**修改人个人版ID*/
@property (nonatomic,assign)NSInteger updateUser;
/**创建时间*/
@property (nonatomic,strong)NSString * createTime;
/**角色名称*/
@property (nonatomic,strong)NSString * roleName;
/**修改时间*/
@property (nonatomic,strong)NSString * updateTime;

@end

NS_ASSUME_NONNULL_END
