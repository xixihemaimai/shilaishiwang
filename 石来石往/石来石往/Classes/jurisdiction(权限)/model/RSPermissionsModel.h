//
//  RSPermissionsModel.h
//  权限
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSAccessModel.h"
@interface RSPermissionsModel : NSObject

/**姓名*/
@property (nonatomic,strong)NSString * userName;
/**身份证*/
@property (nonatomic,strong)NSString * userIdentity;
/**电话号码*/
@property (nonatomic,strong)NSString * mobilePhone;
/**子账号ID*/
@property (nonatomic,strong)NSString * childId;
/**头像*/
@property (nonatomic,strong)NSString * photo;
/**权限管理*/
@property (nonatomic,strong)RSAccessModel * acc;
/**状态*/
@property (nonatomic,assign)NSInteger status;
/**子账号状态*/
@property (nonatomic,assign)NSInteger erpUserStatus;


///**荒料的权限*/
//@property (nonatomic,assign)BOOL isHuangliao;
//
///**大板的权限*/
//@property (nonatomic,assign)BOOL isdaban;
//
///**结算中心*/
//@property (nonatomic,assign)BOOL isjiesuan;
//
///**报表中心*/
//@property (nonatomic,assign)BOOL isbaobiao;
//
///**等级评定*/
//@property (nonatomic,assign)BOOL isdengji;
///**出库记录*/
//@property (nonatomic,assign)BOOL ischuku;



@end
