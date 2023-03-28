//
//  RSServiceMyServiceController.h
//  石来石往
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "RSUserModel.h"

@interface RSServiceMyServiceController : RSAllViewController

@property (nonatomic,strong)RSUserModel * usermodel;


/**用来判断是从那个界面跳转过来的*/
@property (nonatomic,strong)NSString * jumpStr;

@end
