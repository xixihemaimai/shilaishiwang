//
//  RSPersonalEditionViewController.h
//  石来石往
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSPersonalEditionViewController : UIViewController

@property (nonatomic,strong)RSUserModel * usermodel;
/**选择的类型*/
@property (nonatomic,strong)NSString * selectType;

@end

NS_ASSUME_NONNULL_END
