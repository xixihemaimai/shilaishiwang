//
//  RSContactsViewController.h
//  石来石往
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSContactsViewController : UIViewController

@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)NSString * selectype;
@end

NS_ASSUME_NONNULL_END
