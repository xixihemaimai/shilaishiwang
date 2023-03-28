//
//  RSSLRunningAccountViewController.h
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSPersonalBaseViewController.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSLRunningAccountViewController : RSPersonalBaseViewController
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;

@property (nonatomic,strong)RSUserModel * usermodel;
@end

NS_ASSUME_NONNULL_END
