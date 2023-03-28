//
//  RSMyRingHeaderview.h
//  石来石往
//
//  Created by mac on 2017/8/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSMyRingModel.h"
#import "RSMyRingTimeModel.h"
#import "RSMyRingCustomView.h"
#import "RSFriendModel.h"


@protocol RSMyRingHeaderviewDelegate <NSObject>

- (void)myRingPlaySelectVideoIndex:(NSInteger)index;


@end

@interface RSMyRingHeaderview : UITableViewHeaderFooterView


@property (nonatomic,strong)RSMyRingModel * myModel;


@property (nonatomic,strong)RSFriendModel * friendmodel;
//月
@property (nonatomic,strong)UILabel * monthTimeLabel;

//日
@property (nonatomic,strong)UILabel * dayTimeLabel;


@property (nonatomic,strong)RSMyRingTimeModel * myTimeModel;

//自定义view,用来确定有多少图片
@property (nonatomic,strong)RSMyRingCustomView * view;

@property (nonatomic,strong) UIImageView * weiImage;
@property (nonatomic,weak)id<RSMyRingHeaderviewDelegate>delegate;

@end
