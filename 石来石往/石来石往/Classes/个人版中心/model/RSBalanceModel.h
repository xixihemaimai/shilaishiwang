//
//  RSBalanceModel.h
//  石来石往
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSBalanceModel : NSObject

/**物料名称*/
@property (nonatomic,strong)NSString * mtlName;


@property (nonatomic,assign)NSInteger qty;

@property (nonatomic,strong)NSDecimalNumber * volume;

@property (nonatomic,strong)NSDecimalNumber * weight;
/**物料ID*/
@property (nonatomic,assign)NSInteger mtlId;

@property (nonatomic,strong)NSString * whsName;

@property (nonatomic,assign)NSInteger whsId;


//荒料流水账新增需要
/**荒料号*/
@property (nonatomic,strong)NSString * blockNo;
/**单据数量*/
@property (nonatomic,assign)NSInteger billCount;

@property (nonatomic,assign)BOOL isbool;

@property (nonatomic,strong)NSMutableArray * contentArr;

@property (nonatomic,assign)NSInteger did;

//大板余额表新增
@property (nonatomic,strong)NSDecimalNumber * totalVaQty;

@property (nonatomic,strong)NSDecimalNumber * totalTurnsQty;

@property (nonatomic,assign)NSInteger totalQty;

//@property (nonatomic,strong)NSString * turnsNo;

@end

NS_ASSUME_NONNULL_END
