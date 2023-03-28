//
//  RSErpUserListModel.h
//  石来石往
//
//  Created by mac on 2020/4/16.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSErpUserListModel : NSObject <NSCopying>

//erpUserCode = 130026;
//erpUserName = "\U5468\U7d20\U7f8e";
//erpUserType = mian;
//parentId = 8;
//subUserIdentity = "";
//subUserName = "";
//sysUserId = 8;

/*
 货主代码    erpUserCode    String    唯一标识
 货主名称(主账号)    erpUserName    String
 用户类型
     erpUserType    String    main 主账号
 sub 子账号
 父账号石来石往ID    parentId        子账号字段
 子账号身份证号码    subUserIdentity    String    子账号字段+
 子账号名称    subUserName    String    子账号字段
 关联石来石往账户ID    sysUserId    Int    即当前用户ID
 */
/**货主代码*/
@property (nonatomic,strong)NSString * erpUserCode;
/**货主名称(主账号)*/
@property (nonatomic,strong)NSString * erpUserName;
/**用户类型*/
@property (nonatomic,strong)NSString * erpUserType;
/**父账号石来石往ID*/
@property (nonatomic,assign)NSInteger parentId;
/**子账号身份证号码*/
@property (nonatomic,strong)NSString * subUserIdentity;
/**子账号名称*/
@property (nonatomic,strong)NSString * subUserName;
/**关联石来石往账户ID*/
@property (nonatomic,assign)NSInteger sysUserId;


@end

NS_ASSUME_NONNULL_END
