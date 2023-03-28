//
//  RSMyServiceModel.h
//  石来石往
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSMyServiceModel : NSObject
@property (nonatomic,strong)NSString *outBoundNo;

@property (nonatomic,strong)NSString * serviceThing;

@property (nonatomic,strong)NSString * serviceType;

@property (nonatomic,strong)NSString * status;

@property (nonatomic,strong)NSString * appointTime;

//服务ID
@property (nonatomic,strong)NSString * serviceId;

//服务种类
@property (nonatomic,strong)NSString * serviceKind;


/**服务评价*/
@property (nonatomic,strong)NSString * serviceComment;

/**评星*/
@property (nonatomic,assign)NSInteger starLevel;
@end
