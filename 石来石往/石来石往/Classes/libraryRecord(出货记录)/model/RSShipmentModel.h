//
//  RSShipmentModel.h
//  石来石往
//
//  Created by mac on 17/6/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    YJTopicTypehandle = -1, // 处理中
    YJTopicTypeverify = 2, //审核中
    YJTopicTypeshipment = 3, //代发货
    YJTopicTypepartial = 4, // 部分发货
    YJTopicTypecomplete = 0, //已完成
    YJTopicTypeAll = 5 //全部
} YJTopicType;






@interface RSShipmentModel : NSObject


/**时间*/
@property (nonatomic,strong)NSString * outstoreDate;
/**ID*/
@property (nonatomic,strong)NSString * outstoreId;
/**状态*/
@property (nonatomic,assign)NSInteger outstoreStatus;
/**判断是否”已经提交了撤销出库申请” 0 未提交 1 已经提交*/
@property (nonatomic,assign)BOOL isCancel;
/**联系人*/
@property (nonatomic,strong)NSString * csnName;
/**联系人的电话*/
@property (nonatomic,strong)NSString * csnPhone;
/**是否可以发起服务 1已发起服务 0未发起服务*/
@property (nonatomic,assign)NSInteger serviceStatus;
/**撤销的状态*/
@property (nonatomic,strong)NSString * cancelStatus;







@end
