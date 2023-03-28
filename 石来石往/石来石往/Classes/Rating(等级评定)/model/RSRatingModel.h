//
//  RSRatingModel.h
//  石来石往
//
//  Created by mac on 17/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSRatingModel : NSObject
/**石材ID*/
@property (nonatomic,strong)NSString * ratingID;
/**石材的荒料号*/
@property (nonatomic,strong)NSString * stoneId;
/**石材的水平*/
@property (nonatomic,assign)NSInteger stoneLevel;
/**石材的信息*/
@property (nonatomic,strong)NSString * stoneMessage;
/**石材的名称*/
@property (nonatomic,strong)NSString * stoneName;
/**石材的方式*/
@property (nonatomic,strong)NSString * stoneType;

/**石材的平方*/
@property (nonatomic,strong)NSString * stoneVolume;
/**石材的重量*/
@property (nonatomic,strong)NSString * stoneWeight;
/**石材的stoneblno*/
@property (nonatomic,strong)NSString * stoneblno;
/**石材的stoneturnsno*/
@property (nonatomic,strong)NSString * stoneturnsno;

/**选择的之后的Status*/
@property (nonatomic,assign)NSInteger status;



@end
