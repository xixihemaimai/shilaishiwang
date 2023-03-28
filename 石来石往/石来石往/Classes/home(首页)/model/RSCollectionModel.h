//
//  RSCollectionModel.h
//  石来石往
//
//  Created by mac on 17/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSCollectionModel : NSObject
/**收藏的ID*/
@property (nonatomic,strong)NSString * collectionID;
/**收藏的名字*/
@property (nonatomic,strong)NSString * companyName;
/**收藏的电话号码*/
@property (nonatomic,strong)NSString * phone;
/**收藏的荒料号*/
@property (nonatomic,strong)NSString * stoneId;

/**收藏的规格*/
@property (nonatomic,strong)NSString * stoneMessage;

/**收藏的荒料的名字*/
@property (nonatomic,strong)NSString * stoneName;
/**收藏的荒料的类型*/
@property (nonatomic,assign)NSInteger stoneType;
/**收藏的面积*/
@property (nonatomic,strong)NSString * stoneVolume;
/**收藏的重力*/
@property (nonatomic,strong)NSString * stoneWeight;
/**收藏的荒料的blno*/
@property (nonatomic,strong)NSString * stoneblno;

/**收藏的荒料的slno*/
@property (nonatomic,strong)NSString * stoneslno;
/**收藏的stoneturnsno*/
@property (nonatomic,strong)NSString * stoneturnsno;

/**收藏的storerreaName*/
@property (nonatomic,strong)NSString * storerreaName;;


@end
