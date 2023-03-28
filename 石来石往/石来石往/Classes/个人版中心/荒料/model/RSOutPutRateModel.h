//
//  RSOutPutRateModel.h
//  石来石往
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSOutPutRateModel : NSObject

/**
 物料名称    mtlName    String
 荒料号    blockNo    String
 长    length    Decimal
 宽    width    Decimal
 高    height    Decimal
 吨数    weight    Decimal
 完工面积    area    Decimal
 出材率%    rate    Decimal
 */

@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,strong)NSDecimalNumber * length;

@property (nonatomic,strong)NSDecimalNumber * width;
@property (nonatomic,strong)NSDecimalNumber * height;
@property (nonatomic,strong)NSDecimalNumber * weight;
@property (nonatomic,strong)NSDecimalNumber * area;
@property (nonatomic,strong)NSDecimalNumber * rate;
@end

NS_ASSUME_NONNULL_END
