//
//  RSBlocksNumberViewController.h
//  石来石往
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"



@interface RSBlocksNumberViewController : UIViewController

/**用户的信息*/
@property (nonatomic,strong)RSUserModel * userModel;

/**搜索的信息*/
@property (nonatomic,strong)NSString * searchStr;


/**更多的类型分类*/
@property (nonatomic,strong)NSString * classifyStr;


/**是荒料还是大板*/
@property (nonatomic,assign)NSInteger searchType;


@end
