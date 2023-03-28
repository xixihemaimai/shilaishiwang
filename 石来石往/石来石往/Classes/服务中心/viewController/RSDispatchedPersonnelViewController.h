//
//  RSDispatchedPersonnelViewController.h
//  石来石往
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSServiceRightFunctionView.h"

#import "RSServiceChoiceRightView.h"
#import "RSUserModel.h"
@interface RSDispatchedPersonnelViewController : RSAllViewController
@property (nonatomic,strong)RSServiceRightFunctionView * rightview;


@property (nonatomic,strong)RSServiceChoiceRightView * serviceChoiceRightview;


@property (nonatomic,strong)RSUserModel * usermodel;


/**用来判断是从那个界面跳转过来的*/
@property (nonatomic,strong)NSString * jumpStr;
@end
