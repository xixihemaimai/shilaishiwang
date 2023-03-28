//
//  RSBillHeadModel.h
//  石来石往
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSBillHeadModel : NSObject
/**
billDate = "2019-04-15";
billNo = 201904150007;
billType = "BILL_BL_CGRK";
billid = 5149;
blockNos = "HXAG004511,HXAG004512,HXAG004513,HXAG004514,HXAG004515,HXAG004516,HXAG004517,HXAG004518,";
createTime = "2019-04-15 14:30:42";
createUser = 96;
mtlNames = "\U77f3,";
pwmsUserId = 96;
status = 0;
storageType = CGRK;
totalVolume = "63.722";
totalWeight = 0;
updateTime = "2019-04-15 14:30:42";
updateUser = 96;
whsId = 52;

*/

@property (nonatomic,strong)NSString * billDate;

@property (nonatomic,strong)NSString * billNo;

@property (nonatomic,strong)NSString * billType;

@property (nonatomic,strong)NSString * blockNos;

@property (nonatomic,assign)NSInteger billid;

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * mtlNames;


@property (nonatomic,assign)NSInteger createUser;

@property (nonatomic,assign)NSInteger pwmsUserId;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)NSString * storageType;
@property (nonatomic,strong)NSString * updateTime;

@property (nonatomic,assign)NSInteger updateUser;
@property (nonatomic,assign)NSInteger whsId;
@property (nonatomic,assign)NSInteger totalQty;
@property (nonatomic,strong)NSDecimalNumber * totalVolume;
@property (nonatomic,assign)NSDecimalNumber * totalWeight;
@property (nonatomic,strong)NSString * whsName;

// 荒料出库新增
@property (nonatomic,assign)NSInteger factoryId;

@property (nonatomic,strong)NSString * factoryName;


//荒料异常
@property (nonatomic,strong)NSString * abType;
//荒料调拨
//调入仓库ID    whsInId    Int
//调入仓库名称    whsInName    Sting
@property (nonatomic,assign)NSInteger whsInId;

@property (nonatomic,strong)NSString * whsInName;
@property (nonatomic,strong)NSString * whstype;

@property (nonatomic,strong)NSString * whsIntype;


//大板入库新增的4个值
/**大板总匝数*/
@property (nonatomic,assign)NSInteger totalTurnsQty;
/**总原始面积*/
@property (nonatomic,strong)NSDecimalNumber * totalPreArea;
/**总扣尺面积*/
@property (nonatomic,strong)NSDecimalNumber * totalDedArea;
/**总实际面积*/
@property (nonatomic,strong)NSDecimalNumber * totalArea;

@end

NS_ASSUME_NONNULL_END
