//
//  MMOperateMenuView.h
//  MomentKit
//
//  Created by LEA on 2017/12/15.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMOperateMenuView : UIView

@property (nonatomic, assign) BOOL show;

// 赞
@property (nonatomic, copy) void (^likeMoment)();
// 评论
@property (nonatomic, copy) void (^commentMoment)();
//分享
@property (nonatomic, copy) void (^shareMoment)();

//分享

@property (nonatomic, strong)UUButton * shareBtn;

//评论

@property (nonatomic, strong)UUButton * commentBtn;

//点赞

@property (nonatomic, strong)UUButton * likeBtn;



@end
