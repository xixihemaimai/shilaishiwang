//
//  RSTaobaoDistrictViewController.h
//  石来石往
//
//  Created by mac on 2019/7/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
//淘宝专区用户
#import "RSTaobaoUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTaobaoDistrictViewController : UIViewController

@property (nonatomic,strong)RSUserModel * usermodel;

/**淘宝用户信息*/
@property (nonatomic,strong) RSTaobaoUserModel *taobaoUsermodel;
@end

NS_ASSUME_NONNULL_END
