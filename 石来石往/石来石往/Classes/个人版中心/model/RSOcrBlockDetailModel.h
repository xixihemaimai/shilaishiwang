//
//  RSOcrBlockDetailModel.h
//  石来石往
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSOcrBlockDetailModel : NSObject


/*
 单据ID    billid    Int    关联表头
 明细ID    billdtlid    Int    唯一标识
 物料ID    mtlId    Int
 库区ID    storeareaId    Int
 物料名称    mtlName    String
 物料类别ID    mtltypeId    Int
 物料类别名称    mtltypeName    String
 库区名称    storeareaName    String
 荒料编号    blockNo    String
 数量    qty    Int    默认1
 长    length    Decimal    1 位
 宽    width    Decimal    1 位
 厚    height    Decimal    2 位
 立方数    volume    Decimal    3位
 吨数    weight    Decimal    3位
 */


// 石种名称
@property (nonatomic,strong)NSString * stoneName;

// 石种类别
@property (nonatomic,strong)NSString * stoneType;

// 荒料号
@property (nonatomic,strong)NSString * stoneNo;

// 匝号
@property (nonatomic,strong)NSString * turnsNo;

// 板号
@property (nonatomic,strong)NSString * slNo;


// 长
@property (nonatomic,assign)double length;

// 宽
@property (nonatomic,assign)double width;

// 高/厚
@property (nonatomic,assign)double height;

// 数量
@property (nonatomic,assign)NSInteger qty;

// 原始 平方数/立方数
@property (nonatomic,assign)double preVaqty;

// 原始 平方数/立方数
@property (nonatomic,assign)double dedVaqty;

// 实际 平方数/立方数
@property (nonatomic,assign)double vaqty;

// 重量
@property (nonatomic,assign)double weight;

//原始石种名称
@property (nonatomic,strong)NSString * originalStoneName;
//原始石种类别
@property (nonatomic,strong)NSString * originalStoneType;
//原始石种荒料号
@property (nonatomic,strong)NSString * originalStoneNo;
//原始匝号
@property (nonatomic,strong)NSString * originalTurnsNo;
//原始板号
@property (nonatomic,strong)NSString * originalSlNo;
//原始长
@property (nonatomic,assign)double originalLength;
//原始宽
@property (nonatomic,assign)double originalWidth;
//原始高和厚
@property (nonatomic,assign)double originalHeight;
//原始数量
@property (nonatomic,assign)double originalQty;
//原始平方数/立方数
@property (nonatomic,assign)double originalPreVaqty;
// 原始 平方数/立方数
@property (nonatomic,assign)double originalDedVaqty;
//原始实际平方数/立方数
@property (nonatomic,assign)double originalVaqty;
//原始重量
@property (nonatomic,assign)double originalWeight;

//物料数据库字典里面的name
@property (nonatomic,strong)NSString * name;
//物料数据库字典里面的id
@property (nonatomic,assign)NSInteger materialId;

@end

NS_ASSUME_NONNULL_END
