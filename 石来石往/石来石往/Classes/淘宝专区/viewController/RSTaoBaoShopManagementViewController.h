//
//  RSTaoBaoShopManagementViewController.h
//  石来石往
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTaobaoUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoShopManagementViewController : UIViewController
/**淘宝用户信息*/
@property (nonatomic,strong) RSTaobaoUserModel *taobaoUsermodel;
@end

NS_ASSUME_NONNULL_END
