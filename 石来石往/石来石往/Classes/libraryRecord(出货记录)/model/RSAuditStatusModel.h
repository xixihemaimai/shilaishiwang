//
//  RSAuditStatusModel.h
//  石来石往
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAuditStatusModel : NSObject
/**开始时间*/
@property (nonatomic,strong)NSString * createTime;

/**开始工作的节点*/
@property (nonatomic,strong)NSString * workItemName;

/**完成时间*/
@property (nonatomic,strong)NSString * finishTime;

/**同意的名称*/
@property (nonatomic,strong)NSString * userName;
/**同意的电话号码*/
@property (nonatomic,strong)NSString * userPhone;
/**同意的原因*/
@property (nonatomic,strong)NSString * userInfo;

/**结果*/
@property (nonatomic,strong)NSString * resultInfo;

/**工作的ID*/
@property (nonatomic,strong)NSString * workItemId;


@end
