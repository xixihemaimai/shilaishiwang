//
//  RSPwmsUserListModel.h
//  石来石往
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSPwmsUserListModel : NSObject<NSCopying>

/**公司名称主账号 公司名称与用户名称相同*/
@property (nonatomic,strong)NSString * companyName;
/**创建时间createTime*/
@property (nonatomic,strong)NSString * createTime;
/**id*/
@property (nonatomic,assign)NSInteger pwmsUserListID;
/**状态0 待审核 1 正常 2 删除status*/
@property (nonatomic,assign)NSInteger status;
/**所属石来石往用户IDsysUserId*/
@property (nonatomic,assign)NSInteger sysUserId;
/**用户名称userName*/
@property (nonatomic,strong)NSString * userName;


@end

NS_ASSUME_NONNULL_END
