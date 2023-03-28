//
//  RSMasteMainModel.h
//  石来石往
//
//  Created by mac on 2017/9/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSMasteMainModel : NSObject
/**石种图片列表*/
@property (nonatomic,strong)NSArray * photos;

/**库区*/
@property (nonatomic,strong)NSString * storeArea;

/**总体积/面积*/
@property (nonatomic,strong)NSString * stoneTotalMessage;

/**用户erp代码*/
@property (nonatomic,strong)NSString * erpUserCode;


/**总颗数/匝数*/
@property (nonatomic,strong)NSString * stoneNum;
/**石头的名称*/
@property (nonatomic,strong)NSString * stoneName;

@end
