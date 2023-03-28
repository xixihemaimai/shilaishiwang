//
//  RSTaobaoUserModel.h
//  石来石往
//
//  Created by mac on 2019/9/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTaobaoUserModel : NSObject
/**地址*/
@property (nonatomic,strong)NSString * address;
/**ID*/
@property (nonatomic,assign)NSInteger taoBaoUserID;
/**联系电话*/
@property (nonatomic,strong)NSString * phone;
/**店铺logo*/
@property (nonatomic,strong)NSString * shopLogo;
/**店铺名称*/
@property (nonatomic,strong)NSString * shopName;
/**用户类型*/
@property (nonatomic,strong)NSString * userType;
/**申请店铺情况状态*/
//status 0  代表审核中   1 正常    2 审核不通过
@property (nonatomic,assign)NSInteger status;

@end

NS_ASSUME_NONNULL_END
