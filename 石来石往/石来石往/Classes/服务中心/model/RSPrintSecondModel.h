//
//  RSPrintSecondModel.h
//  石来石往
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSPrintSecondModel : NSObject
/**园区荒料号*/
@property (nonatomic,strong)NSString * blockNo;
/**石种名称*/
@property (nonatomic,strong)NSString * blockName;
/**客户荒料号*/
@property (nonatomic,strong)NSString * csid;
/**板号*/
@property (nonatomic,strong)NSString * slno;
/**匝号*/
@property (nonatomic,strong)NSString * turnsNo;
/**颗数/片数*/
@property (nonatomic,assign)NSInteger qty;
/**体积/面积*/
@property (nonatomic,assign)double blockNum;

/**储位*/
@property (nonatomic,strong)NSString * locationName;




@end
