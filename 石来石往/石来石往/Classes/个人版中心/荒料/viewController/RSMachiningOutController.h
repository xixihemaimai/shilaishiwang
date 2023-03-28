//
//  RSMachiningOutController.h
//  石来石往
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSMachiningOutController : RSPersonalBaseViewController

@property (nonatomic,strong)RSUserModel * usermodel;
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;

/**选择要处理的类型*/
@property (nonatomic,strong)NSString * selectType;

@end

NS_ASSUME_NONNULL_END
