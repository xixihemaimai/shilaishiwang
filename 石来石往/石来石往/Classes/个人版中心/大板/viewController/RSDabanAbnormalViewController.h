//
//  RSDabanAbnormalViewController.h
//  石来石往
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSPersonalFunctionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSDabanAbnormalViewController : RSPersonalBaseViewController

@property (nonatomic,strong)NSString * selectType;
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;

@property (nonatomic,strong)NSString * selectShow;

@property (nonatomic,strong)RSUserModel * usermodel;

/**是否是上一个页面传过来的值是new 还是reload*/
@property (nonatomic,strong)NSString * showType;

@property (nonatomic,strong)void(^reload)(BOOL isreload);

@property (nonatomic,strong)RSPersonalFunctionModel * personalFunctionmodel;
@end

NS_ASSUME_NONNULL_END
