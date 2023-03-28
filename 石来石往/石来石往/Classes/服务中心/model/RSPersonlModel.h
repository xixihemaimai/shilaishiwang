//
//  RSPersonlModel.h
//  石来石往
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSPersonlModel : NSObject

/**预约时间*/
@property (nonatomic,strong)NSString * appointTime;
/**商户*/
@property (nonatomic,strong)NSString * orgName;

/**出库单*/
@property (nonatomic,strong)NSString * outBoundNo;
/**服务ID*/
@property (nonatomic,strong)NSString * serviceId;

/**serviceThing服务事情*/
@property (nonatomic,strong)NSString * serviceThing;
/**服务方式*/
@property (nonatomic,strong)NSString * serviceType;
/**服务种类*/
@property (nonatomic,strong)NSString * serviceKind;

/**服务状态*/
@property (nonatomic,strong)NSString * status;

/**服务评价有没有评价*/
@property (nonatomic,strong)NSString * starLevel;






@end
