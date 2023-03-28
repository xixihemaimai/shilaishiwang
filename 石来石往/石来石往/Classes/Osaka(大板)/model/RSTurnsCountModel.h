//
//  RSTurnsCountModel.h
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSTurnsCountModel : NSObject

/**有多少个片的个数*/
@property (nonatomic,strong)NSMutableArray *pieces;

/**匝数的显示*/
@property (nonatomic,strong)NSString * turnsID;



//自己添加的属性

@property (nonatomic,assign)NSInteger turnsStatus;






@end
