//
//  RSRankModel.h
//  石来石往
//
//  Created by mac on 17/6/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSRankModel : NSObject
/**体积*/
@property (nonatomic,assign)CGFloat VAQty;
/**排名*/
@property (nonatomic,assign)NSInteger monthRank;
/**公司ID*/
@property (nonatomic,strong)NSString *mtlCode;
/**排名名称*/
@property (nonatomic,strong)NSString *mtlName;
/**排名的方式*/
@property (nonatomic,assign)NSInteger mtlType;

@property (nonatomic,strong)NSString *period;

@property (nonatomic,strong)NSString *deaCode;

@property (nonatomic,strong)NSString *deaName;



@end
