//
//  RSBMBalanceModel.h
//  石来石往
//
//  Created by mac on 2018/1/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSBMBalanceModel : NSObject

/**石种名称*/
@property (nonatomic,strong)NSString * mtlname;

/**立方数*/
@property (nonatomic,assign)double volume;

/**吨数*/
@property (nonatomic,assign)double weight;

/**颗数*/
@property (nonatomic,assign)NSInteger qty;
/**序号*/
@property (nonatomic,assign)NSInteger n;

@end
