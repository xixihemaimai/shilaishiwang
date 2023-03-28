//
//  RSChoosingInventoryModel.h
//  石来石往
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSChoosingInventoryModel : NSObject

/**确定有多少个cell*/
@property (nonatomic,strong)NSMutableArray * cellArray;

/**有多少片*/
@property (nonatomic,strong)NSMutableArray * sliceArray;

/**确定组头是展开还是闭合*/
@property (nonatomic,assign)BOOL isBool;
/**物料名称*/
@property (nonatomic,strong)NSString * productName;
/**原始物料名称*/
@property (nonatomic,strong)NSString * originalProductName;


/**物料号*/
@property (nonatomic,strong)NSString * productNumber;
/**初始物料号*/
@property (nonatomic,strong)NSString * originalProductNumber;

/**物料类型*/
@property (nonatomic,strong)NSString * productType;
/**原始物料类型*/
@property (nonatomic,strong)NSString * originalProductType;
/**匝号*/
@property (nonatomic,strong)NSString * turnNumber;
/**原始匝号*/
@property (nonatomic,strong)NSString * originalTurnNumber;

/**选择多少片的数组*/
@property (nonatomic,strong)NSMutableArray * selectArray;
/**cell的展会和闭合的标志*/
@property (nonatomic,assign)BOOL newIsBool;

@end

NS_ASSUME_NONNULL_END
