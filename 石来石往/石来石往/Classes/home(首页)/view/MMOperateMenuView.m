//
//  MMOperateMenuView.m
//  MomentKit
//
//  Created by LEA on 2017/12/15.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MMOperateMenuView.h"
#import <UUButton.h>

@interface MMOperateMenuView ()

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIButton *menuBtn;

@end

@implementation MMOperateMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _show = NO;
        [self setUpUI];
    }
    return self;
}

#pragma mark - 设置UI
- (void)setUpUI
{
    // 菜单容器视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kOperateWidth - kOperateBtnWidth, 0, kOperateWidth, kOperateHeight)];
    view.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:74.0/255.0 blue:75.0/255.0 alpha:1.0];
    view.layer.cornerRadius = 4.0;
    view.layer.masksToBounds = YES;
    //  分享
    _shareBtn = [[UUButton alloc] initWithFrame:CGRectMake(0, 0, 90, kOperateHeight)];
    _shareBtn.backgroundColor = [UIColor clearColor];
    _shareBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _shareBtn.spacing = 3;
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shareBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_shareBtn];
    // 分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_shareBtn.right-5, 8, 0.5, kOperateHeight-16)];
    line.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    [view addSubview:line];
    // 评论
    _commentBtn = [[UUButton alloc] initWithFrame:CGRectMake(line.right, 0, _shareBtn.width, kOperateHeight)];
    _commentBtn.backgroundColor = [UIColor clearColor];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _commentBtn.spacing = 3;
    [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_commentBtn];
    
    //第二个分隔线
    UIView * twoline = [[UIView alloc] initWithFrame:CGRectMake(_commentBtn.right-5, 8, 0.5, kOperateHeight-16)];
    twoline.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    [view addSubview:twoline];
    
    //点赞
    _likeBtn = [[UUButton alloc] initWithFrame:CGRectMake(twoline.right, 0, _commentBtn.width, kOperateHeight)];
    _likeBtn.backgroundColor = [UIColor clearColor];
    _likeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _likeBtn.spacing = 3;
    [_likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
    [_likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_likeBtn setImage:[UIImage imageNamed:@"Path"] forState:UIControlStateNormal];
    [_likeBtn addTarget:self action:@selector(likeClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_likeBtn];

    self.menuView = view;
    [self addSubview:self.menuView];
    // 菜单操作按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kOperateWidth-kOperateBtnWidth, 0, kOperateBtnWidth, kOperateHeight)];
    [button setImage:[UIImage imageNamed:@"moment_operate"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"moment_operate_hl"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(menuClick) forControlEvents:UIControlEventTouchUpInside];
    self.menuBtn = button;
    [self addSubview:self.menuBtn];
}

#pragma mark - 显示/不显示
- (void)setShow:(BOOL)show
{
    _show = show;
    CGFloat menu_left = kOperateWidth-kOperateBtnWidth;
    CGFloat menu_width = 0;
    if (_show) {
        menu_left = 0;
        menu_width = kOperateWidth- kOperateBtnWidth;
    }
    self.menuView.width = menu_width;
    self.menuView.left = menu_left;
}

#pragma mark - 事件
- (void)menuClick
{
    _show = !_show;
    CGFloat menu_left = kOperateWidth-kOperateBtnWidth;
    CGFloat menu_width = 0;
    if (_show) {
        menu_left = 0;
        menu_width = kOperateWidth-kOperateBtnWidth;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.menuView.width = menu_width;
        self.menuView.left = menu_left;
    }];
}

- (void)likeClick
{
    if (self.likeMoment) {
        self.likeMoment();
    }
}

- (void)commentClick
{
    if (self.commentMoment) {
        self.commentMoment();
    }
}



- (void)shareClick{
    if (self.shareMoment) {
        self.shareMoment();
    }
    
}

@end

