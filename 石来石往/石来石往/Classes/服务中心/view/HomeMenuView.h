//
//  HomeMenuView.h
//  08-美团首页九宫格菜单
//
//  Created by Apple on 16/9/7.
//  Copyright © 2016年 yunjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeMenuViewdelegate <NSObject>

// 点击菜单按钮
//- (void)menuBtnClick:(UIButton *)menuBtn andSelectArray:(NSMutableArray *)selectArray;

- (void)selectArray:(NSMutableArray *)selectArray;
@end

@interface HomeMenuView : UIView
/** 模型数组 */
@property (nonatomic,strong) NSArray *menus;

/** 代理 */
@property (nonatomic,weak) id<HomeMenuViewdelegate> delegate;







@end
