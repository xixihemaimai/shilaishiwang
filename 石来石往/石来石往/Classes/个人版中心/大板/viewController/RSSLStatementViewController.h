//
//  RSSLStatementViewController.h
//  石来石往
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSPersonalBaseViewController.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSLStatementViewController : RSPersonalBaseViewController

@property (nonatomic,strong)RSUserModel * usermodel;

/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;
@end

NS_ASSUME_NONNULL_END
