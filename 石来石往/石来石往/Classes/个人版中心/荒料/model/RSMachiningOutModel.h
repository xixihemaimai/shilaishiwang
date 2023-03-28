//
//  RSMachiningOutModel.h
//  石来石往
//
//  Created by mac on 2019/6/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSMachiningOutModel : NSObject

/**出库明细唯一标识*/
@property (nonatomic,assign)NSInteger billdtlid;
/**物料名称*/
@property (nonatomic,strong)NSString * mtlName;
/**物料类别名称*/
@property (nonatomic,strong)NSString * mtltypeName;
/**荒料号*/
@property (nonatomic,strong)NSString * blockNo;
/**加工厂名称*/
@property (nonatomic,strong)NSString * factoryName;
/**长(cm)*/
@property (nonatomic,strong)NSDecimalNumber * length;
/**宽（cm）*/
@property (nonatomic,strong)NSDecimalNumber * width;
/**高（cm）*/
@property (nonatomic,strong)NSDecimalNumber * height;
/**体积(m³)*/
@property (nonatomic,strong)NSDecimalNumber * volume;
/**重量(t)*/
@property (nonatomic,strong)NSDecimalNumber * weight;
/**工序名称*/
@property (nonatomic,strong)NSString * processName;
/**状态值*/
@property (nonatomic,assign)NSInteger processStatus;




@end

NS_ASSUME_NONNULL_END
