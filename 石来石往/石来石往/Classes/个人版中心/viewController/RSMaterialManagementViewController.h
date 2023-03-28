//
//  RSMaterialManagementViewController.h
//  石来石往
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSMaterialModel.h"
#import "RSTypeModel.h"
#import "RSColorModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSMaterialManagementViewController : RSPersonalBaseViewController

@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)void(^selectIndexPathMatermodel)(RSMaterialModel * materialmodel);

//是那个模块
@property (nonatomic,strong)NSString * selectType;
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;
//判断有没有使用--用什么来判断呢
//是那个功能传递的
@property (nonatomic,strong)NSString * equallyStr;


@end

NS_ASSUME_NONNULL_END
