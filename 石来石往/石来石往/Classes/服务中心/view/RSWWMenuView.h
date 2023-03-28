//
//  RSWWMenuView.h
//  石来石往
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RSWWMenuViewdelegate <NSObject>

// 点击菜单按钮
- (void)menuBtnClick:(UIButton *)menuBtn;

@end

@interface RSWWMenuView : UIView
/** 模型数组 */
@property (nonatomic,strong) NSArray *menus;

/** 代理 */
@property (nonatomic,weak) id<RSWWMenuViewdelegate> delegate;
@end
