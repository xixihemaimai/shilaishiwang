//
//  RSServiceSecondEvalModel.h
//  石来石往
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSServiceSecondEvalModel : NSObject

/**服务者ID*/
@property (nonatomic,strong)NSString * serviceUserId;

/**服务者名字*/
@property (nonatomic,strong)NSString * name;

/**服务者的星级水平*/
@property (nonatomic,strong)NSString * starLevel;

/**服务人员的头像*/
@property (nonatomic,strong)NSString * userHead;

@end
