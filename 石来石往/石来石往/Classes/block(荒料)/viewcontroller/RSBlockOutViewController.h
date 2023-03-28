//
//  RSBlockOutViewController.h
//  石来石往
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
//#import "RSDirverContact.h"
@class RSBlockModel;
@interface RSBlockOutViewController : RSAllViewController

@property (nonatomic,strong)RSBlockModel *blockModel;

/**用来保存我选择的商品，保存在这个数组里面，里面存的都是模型，为后面传值做准备*/
@property (nonatomic,strong)NSMutableArray *shopCarInformationArray;


/**用来接收点击荒料出库中搜索接口需要的userID*/
//@property (nonatomic,strong)NSString * userID;


//@property (nonatomic,strong)RSUserModel *userModel;



//@property (nonatomic,strong)RSDirverContact * contact;

@end
