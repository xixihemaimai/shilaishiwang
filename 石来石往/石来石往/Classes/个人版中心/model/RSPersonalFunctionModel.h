//
//  RSPersonalFunctionModel.h
//  石来石往
//
//  Created by mac on 2019/4/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSPersonalFunctionModel : NSObject


/**单据时间*/
@property (nonatomic,strong)NSString * billDate;
/**单据编号*/
@property (nonatomic,strong)NSString * billNo;
/**单据类型*/
@property (nonatomic,strong)NSString * billType;
/**单据ID*/
@property (nonatomic,assign)NSInteger billid;
/**业务处理如异常处理类型*/
@property (nonatomic,strong)NSString * busType;
/**物料名称*/
@property (nonatomic,strong)NSString * mtlNames;
/**单据状态*/
@property (nonatomic,assign)NSInteger status;
/**总面积*/
@property (nonatomic,strong)NSDecimalNumber * totalArea;
/**总颗数*/
@property (nonatomic,assign)NSInteger totalQty;
/**总匝数*/
@property (nonatomic,assign)NSInteger totalTurns;
/**总体积*/
@property (nonatomic,strong)NSDecimalNumber *  totalVolume;
/**总吨数*/
@property (nonatomic,strong)NSDecimalNumber *  totalWeight;
/**仓库名称*/
@property (nonatomic,strong)NSString * warehouse;

//新增的
//abType
@property (nonatomic,strong)NSString * abType;

//荒料调拨
@property (nonatomic,strong)NSString * warehouseIn;


@end

NS_ASSUME_NONNULL_END
