//
//  RSOsakaModel.h
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSOsakaModel : NSObject

/**荒料号的DID*/
@property (nonatomic,strong)NSString *DID;
/**荒料号的分类*/
@property (nonatomic,strong)NSString * blockClasses;
/**荒料号的ID*/
@property (nonatomic,strong)NSString * blockID;
/**荒料号的规格*/
@property (nonatomic,strong)NSString * blockLWH;
/**荒料号名字*/
@property (nonatomic,strong)NSString * blockName;
/**荒料号的立方*/
@property (nonatomic,strong)NSString * blockVolume;
/**荒料号的erpid*/
@property (nonatomic,strong)NSString * erpid;
/**荒料号的图片*/
@property (nonatomic,strong)NSString * imgpath;
/**荒料号里面片数*/
@property (nonatomic,strong)NSMutableArray * turns;

/***自己设定的*/

/**每个cell的标记*/
@property (nonatomic,assign)NSInteger tag;

/**选择了几片*/
@property (nonatomic,assign)NSInteger count;
/**选择是按匝还是按片*/
@property (nonatomic,assign)NSInteger styleModel;


@end
