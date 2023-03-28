//
//  RSTaobaoInventoryDetModel.h
//  石来石往
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTaobaoInventoryDetModel : NSObject
/**
 Id标识    id    Int    修改明细传正确id  如是新增的明细则不传或者传0
 石种类型    stoneType    String
 荒料号    blockNo    String
 匝号    turnNo    String    如是荒料传“”字符串即可
 片数    turnQty    Int    荒料传1
 长    length    Decimal    1位
 宽    width    Decimal    1位
 高    height    Decimal    2位
 体积    volume    Decimal    3位 大板传 0
 重量    weight    Decimal    3位 大板传0
 原始面积    preArea    Decimal    3位 荒料传0
 扣尺面积    dedArea    Decimal    3位 荒料传0
 */

@property (nonatomic,assign)NSInteger InventoryDetID;


@property (nonatomic,assign)NSInteger inventoryId;

@property (nonatomic,strong)NSString * stoneType;

@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,strong)NSString * turnNo;

@property (nonatomic,assign)NSInteger turnQty;

@property (nonatomic,strong)NSDecimalNumber * length;

@property (nonatomic,strong)NSDecimalNumber * width;


@property (nonatomic,strong)NSDecimalNumber * height;
@property (nonatomic,strong)NSDecimalNumber * volume;
//地址
@property (nonatomic,strong)NSString * warehouseName;

@property (nonatomic,strong)NSDecimalNumber * weight;
@property (nonatomic,strong)NSDecimalNumber * preArea;
@property (nonatomic,strong)NSDecimalNumber * dedArea;
@property (nonatomic,strong)NSDecimalNumber * area;



//自定义的地方判断是否展开或者关闭
@property (nonatomic,assign)BOOL isOpen;


@end

NS_ASSUME_NONNULL_END
