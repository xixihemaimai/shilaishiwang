//
//  RSBlockModel.h
//  石来石往
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSBlockModel : NSObject


/**荒料DID*/
@property (nonatomic,strong)NSString *DID;
/**荒料的分类*/
@property (nonatomic,strong)NSString * blockClasses;
/**荒料的ID*/
@property (nonatomic,strong)NSString * blockID;
/**荒料的规格*/
@property (nonatomic,strong)NSString * blockLWH;
/**荒料的名称*/
@property (nonatomic,strong)NSString * blockName;
/**荒料的立方*/
@property (nonatomic,strong)NSString * blockVolume;
/**荒料的erpid*/
@property (nonatomic,strong)NSString * erpid;
/**荒料的图片路径*/
@property (nonatomic,strong)NSString * imgpath;
/**荒料的片数*/
@property (nonatomic,strong)NSArray * turns;
/**自己添加的属性*/
@property (nonatomic,assign)BOOL isSelected;

@property (nonatomic,assign)NSInteger tag;


@end
