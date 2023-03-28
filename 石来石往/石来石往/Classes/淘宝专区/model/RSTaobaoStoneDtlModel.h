//
//  RSTaobaoStoneDtlModel.h
//  石来石往
//
//  Created by mac on 2019/9/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTaobaoStoneDtlModel : NSObject
/**
 {
 blockNo = TYU123;
 height = 50;
 id = 4;
 inventoryId = 123;
 length = 800;
 stoneType = "\U82b1\U5c97\U5ca9";
 volume = 700;
 warehouseName = "\U897f\U5de5\U5382\U4e09\U533a";
 weight = 888;
 width = 300;
 
 */
@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,strong)NSDecimalNumber * height;

@property (nonatomic,assign)NSInteger StoneDtlID;

@property (nonatomic,strong)NSString * inventoryId;

@property (nonatomic,strong)NSDecimalNumber * length;

@property (nonatomic,strong)NSString * stoneType;

@property (nonatomic,strong)NSDecimalNumber * volume;
@property (nonatomic,strong)NSString * warehouseName;
@property (nonatomic,strong)NSDecimalNumber * weight;
@property (nonatomic,strong)NSDecimalNumber * width;
@property (nonatomic,strong)NSDecimalNumber * area;

@property (nonatomic,strong)NSDecimalNumber * dedArea;

@property (nonatomic,strong)NSDecimalNumber * preArea;

@property (nonatomic,strong)NSString * turnNo;

@property (nonatomic,assign)NSInteger turnQty;

@end

NS_ASSUME_NONNULL_END
