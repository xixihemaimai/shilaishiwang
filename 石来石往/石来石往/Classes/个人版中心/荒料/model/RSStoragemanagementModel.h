//
//  RSStoragemanagementModel.h
//  石来石往
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSStoragemanagementModel : NSObject

@property (nonatomic,assign)NSInteger billdtlid;

@property (nonatomic,assign)NSInteger billid;

@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,strong)NSString * storeareaName;


// 匝号
@property (nonatomic,strong)NSString * turnsNo;

// 板号
@property (nonatomic,strong)NSString * slNo;
// 原始 平方数/立方数
@property (nonatomic,strong)NSDecimalNumber * preVaqty;

// 原始 平方数/立方数
@property (nonatomic,strong)NSDecimalNumber * dedVaqty;

// 实际 平方数/立方数
@property (nonatomic,strong)NSDecimalNumber * vaqty;
//物料数据库字典里面的name
@property (nonatomic,strong)NSString * name;
//物料数据库字典里面的id
@property (nonatomic,assign)NSInteger materialId;


@property (nonatomic,strong)NSDecimalNumber * length;

@property (nonatomic,strong)NSDecimalNumber * width;

@property (nonatomic,strong)NSDecimalNumber * height;

@property (nonatomic,assign)NSInteger qty;

@property (nonatomic,strong)NSDecimalNumber * weight;

@property (nonatomic,assign)NSInteger mtlId;

@property (nonatomic,assign)NSInteger storeareaId;

@property (nonatomic,strong)NSDecimalNumber * volume;

@property (nonatomic,strong)NSString * mtltypeName;

@property (nonatomic,assign)NSInteger mtltypeId;

//荒料出库 -- 销售出库 ，加工出库，盘亏出库
/**唯一标示号*/
@property (nonatomic,assign)NSInteger did;

@property (nonatomic,strong)NSDate * receiptDate;

@property (nonatomic,strong)NSString * storageType;

@property (nonatomic,assign)NSInteger isfrozen;

@property (nonatomic,assign)NSInteger whsId;

@property (nonatomic,strong)NSString * whsName;

@property (nonatomic,assign)NSInteger pwmsUserId;

@property (nonatomic,assign)NSInteger selectedStutas;

//荒料异常

@property (nonatomic,strong)NSString * mtlInName;

@property (nonatomic,strong)NSString * mtltypeInName;

@property (nonatomic,assign)NSInteger mtlInId;

@property (nonatomic,assign)NSInteger mtltypeInId;

@property (nonatomic,strong)NSString * blockInNo;

@property (nonatomic,strong)NSDecimalNumber * lengthIn;

@property (nonatomic,strong)NSDecimalNumber * widthIn;

@property (nonatomic,strong)NSDecimalNumber * heightIn;

@property (nonatomic,strong)NSDecimalNumber * volumeIn;

@property (nonatomic,strong)NSDecimalNumber * weightIn;

//调拨

@property (nonatomic,assign)NSInteger storeareaInId;

@property (nonatomic,strong)NSString * storeareaInName;


//荒料出库表和荒料入库明细表
@property (nonatomic,strong)NSString * billType;

@property (nonatomic,strong)NSString * billDate;






@end

NS_ASSUME_NONNULL_END
