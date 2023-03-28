//
//  RSTaoBaoTool.h
//  石来石往
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSTaobaoUserModel.h"
#import "YBPopupMenu.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoTool : NSObject

//添加一个判断要显示那种类型的数组，添加一个控制器，也需要返回一个用户的模型
- (void)showMenuContentType:(NSString *)type andOnView:(UIView *)view andViewController:(UIViewController *)viewController andBlock:(void(^)(RSTaobaoUserModel *taobaoUsermodel))block;


- (void)loadTaoBaoUserInformation:(void(^)(BOOL isResult,RSTaobaoUserModel * taobaoUsermodel))block;

//针对于陶石专区首页的方法
- (void)showMenuContentType:(NSString *)type andOnView:(nonnull UIView *)view  andViewController:(UIViewController *)viewController andUserModel:(RSTaobaoUserModel *) taobaoUsermodel;





@end

NS_ASSUME_NONNULL_END
