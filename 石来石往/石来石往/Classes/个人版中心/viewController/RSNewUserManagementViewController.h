//
//  RSNewUserManagementViewController.h
//  石来石往
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSUserManagementModel.h"
//保存中有新建和编辑的俩个方法


NS_ASSUME_NONNULL_BEGIN


@interface RSNewUserManagementViewController : RSPersonalBaseViewController

@property (nonatomic,strong)RSUserManagementModel * usermanagementmodel;

//判断是新建还是编辑
@property (nonatomic,strong)NSString * selectType;

@property (nonatomic,strong)void(^reload)(BOOL success);

@end

NS_ASSUME_NONNULL_END
