//
//  RSNewRoleViewController.h
//  石来石往
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSRoleModel.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN


typedef void(^Reload)(BOOL success);

@interface RSNewRoleViewController : RSPersonalBaseViewController

@property (nonatomic,strong)RSRoleModel * rolemodel;

/**新建还是编辑的类型*/
@property (nonatomic,strong)NSString * selectType;

@property (nonatomic,strong)Reload reload;

@property (nonatomic,strong)RSUserModel * usermodel;

@end

NS_ASSUME_NONNULL_END
