//
//  RSStoreHouseDetailModel.h
//  石来石往
//
//  Created by mac on 2018/3/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSStoreHouseDetailModel : NSObject

/**时间*/
@property (nonatomic,strong)NSString * appointTime;

/**评论时间*/
@property (nonatomic,strong)NSString * commentTime;
/**提货人身份证*/
@property (nonatomic,strong)NSString * csnIden;
/**提货人名字*/
@property (nonatomic,strong)NSString * csnName;
/**提货人电话号码*/
@property (nonatomic,strong)NSString * csnPhone;
/**dispatchTime*/
@property (nonatomic,strong)NSString * dispatchTime;
/**结束时间*/
@property (nonatomic,strong)NSString * endTime;

/**图片*/
@property (nonatomic,strong)NSArray * img;

/**服务公司*/
@property (nonatomic,strong)NSString * orgName;
/**服务公司电话*/
@property (nonatomic,strong)NSString * phone;
/**出货单*/
@property (nonatomic,strong)NSString * outBoundNo;
/**发送的时间*/
@property (nonatomic,strong)NSString * sendTime;
/**发送评论的内容*/
@property (nonatomic,strong)NSString * serviceComment;
/**服务ID*/
@property (nonatomic,strong)NSString * serviceId;
/**serviceKind服务种类*/
@property (nonatomic,strong)NSString * serviceKind;
/**serviceThing服务事情*/
@property (nonatomic,strong)NSString * serviceThing;
/**服务时间*/
@property (nonatomic,strong)NSString * serviceTime;
/**服务满意程度*/
@property (nonatomic,strong)NSString * starLevel;
/**出库的货品*/
@property (nonatomic,strong)NSArray *  bolcks;

/**类型*/
@property (nonatomic,strong)NSString * outType;
/**汽车类型*/
@property (nonatomic,strong)NSString * carType;

@end
