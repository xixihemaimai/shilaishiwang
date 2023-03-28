//
//  RSTaoBaoContentViewController.h
//  石来石往
//
//  Created by mac on 2019/7/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//淘宝专区用户
#import "RSTaobaoUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoContentViewController : UIViewController
/**淘宝用户信息*/
@property (nonatomic,strong) RSTaobaoUserModel *taobaoUsermodel;

//店铺ID(这边是店铺需要的数据)
@property (nonatomic,assign)NSInteger tsUserId;

@property (nonatomic,assign)NSInteger pageNum;

- (void)reloadShopInformationNewData:(NSString *)stoneName;

@end

NS_ASSUME_NONNULL_END
