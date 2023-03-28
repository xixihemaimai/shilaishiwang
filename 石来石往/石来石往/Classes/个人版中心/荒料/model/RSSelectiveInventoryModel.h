//
//  RSSelectiveInventoryModel.h
//  石来石往
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSelectiveInventoryModel : NSObject

/*
库存唯一标识    did    int
数量    qty    int
是否冻结    isfrozen    Int
所属用户ID    pwmsUserId    int
物料ID    mtlId    int
物料名称    mtlName    String
物料类别ID    mtltypeId    int
物料类别名称    mtltypeName    String
库存类别    storageType    String
入库日期    receiptDate    Date
仓库ID    whsId    Int
仓库名称    whsName    String
库区ID    storeareaId    Int
荒料号    blockNo    String
长    length    Decimal
宽    width    Decimal
厚    height    Decimal
体积    volume    Decimal
重量    weight    Decimal
*/


/**
 billdtlid = 70392;
 billid = 70391;
 blockNo = asd;
 did = 53290;
 height = "12.22";
 length = "12.2";
 mtlId = 113;
 mtlName = "\U9ed1\U91d1\U82b1";
 mtltypeId = 3;
 mtltypeName = "\U5927\U7406\U77f3";
 qty = 1;
 receiptDate = "2019-04-18";
 storageType = CGRK;
 storeareaId = 0;
 storeareaName = "";
 volume = "0.002";
 weight = "12.588";
 width = "12.2";
 */


@property (nonatomic,assign)NSInteger did;

@property (nonatomic,assign)NSInteger qty;

@property (nonatomic,assign)NSInteger isfrozen;

@property (nonatomic,assign)NSInteger pwmsUserId;

@property (nonatomic,assign)NSInteger mtlId;

@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,assign)NSInteger mtltypeId;
@property (nonatomic,strong)NSString * mtltypeName;
@property (nonatomic,strong)NSString * storageType;

@property (nonatomic,strong)NSDate * receiptDate;

@property (nonatomic,assign)NSInteger whsId;
@property (nonatomic,strong)NSString * whsName;
@property (nonatomic,assign)NSInteger storeareaId;
@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,strong)NSDecimalNumber * length;
@property (nonatomic,strong)NSDecimalNumber * width;
@property (nonatomic,strong)NSDecimalNumber * height;
@property (nonatomic,strong)NSDecimalNumber * volume;
@property (nonatomic,strong)NSDecimalNumber * weight;


//自己加的
@property (nonatomic,assign)NSInteger selectedStutas;



@end

NS_ASSUME_NONNULL_END
