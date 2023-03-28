//
//  RSTaoBaoShopViewController.h
//  石来石往
//
//  Created by mac on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//淘宝专区用户
#import "RSTaobaoUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoShopViewController : UIViewController

/**淘宝用户信息*/
@property (nonatomic,strong) RSTaobaoUserModel *taobaoUsermodel;

//商店ID
@property (nonatomic,assign)NSInteger tsUserId;


@end

NS_ASSUME_NONNULL_END
