//
//  RSStockModel.h
//  石来石往
//
//  Created by mac on 17/6/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSStockModel : NSObject

/**荒料今日入库*/
@property (nonatomic,strong)NSString *blockInstoreVolume;

/**荒料的数量*/
@property (nonatomic,assign)NSInteger blockNum;

/**荒料的今日出库*/
@property (nonatomic,strong)NSString * blockOutstoreVolume;

/**荒料的立方*/
@property (nonatomic,strong)NSString * blockVolume;

/**大板的数量*/
@property (nonatomic,assign)NSInteger plateNum;

/**大板的今日入库*/
@property (nonatomic,strong)NSString *plateInstoreArea;
/**大板的今日出库*/
@property (nonatomic,strong)NSString *plateOutstoreArea;

/**大板的平方*/
@property (nonatomic,strong)NSString *plateArea;



@end
