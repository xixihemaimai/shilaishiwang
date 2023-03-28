//
//  RSGoodOutController.h
//  石来石往
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSDirverContact.h"
@interface RSGoodOutController : RSAllViewController


/**接收货主的标识，也是接口参数*/
@property (nonatomic,strong)NSString * userID;


/**接收司机的信息的模型*/
@property (nonatomic,strong)RSDirverContact * contact;
/**接收购物车中的数组*/
@property (nonatomic,strong)NSMutableArray *shopNumberCountArray;
/**购物车里面的模型数据*/
//@property (nonatomic,strong)RSBlockModel *blockmodel;

@property (nonatomic,strong)RSUserModel * userModel;

/**是大板还是荒料的出货方式*/
@property (nonatomic,strong)NSString * outStyle;



@end

