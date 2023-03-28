//
//  MomentViewController.h
//  MomentKit
//
//  Created by LEA on 2017/12/12.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAllViewController.h"
#import "LXActivity.h"

#import "RSUserModel.h"

#import "Moment.h"
#import "Comment.h"


@protocol MomentViewControllerDelegate <NSObject>

//这边是对俩个点赞的地方进行代理
- (void)reloadArrayDataMoment:(Moment *)moment andMomentList:(NSMutableArray *)momentList andshowType:(NSString *)showType;
//这边是对关注的地方进行代理
- (void)changAttatitionDataMoment:(Moment *)moment andShowType:(NSString *)showType;
//对于显示有没有最新消息的地方进行代理代理返回
- (void)changRedBadValueAttSize:(NSInteger)attSize andFriendRed:(BOOL)friendRed andShowType:(NSString *)showType;
//下拉刷新的时候要做的处理
- (void)hideRedBadValueTitle:(NSString *)title;

@end

@interface MomentViewController : RSAllViewController<LXActivityDelegate>
/**看的是石圈还是关注的界面*/
@property (nonatomic,strong)NSString * showType;
@property (nonatomic, strong) NSMutableArray *momentList;

@property (nonatomic,weak)id<MomentViewControllerDelegate>delegate;
@property (nonatomic, strong) UITableView *tableView;

- (RSUserModel *)userModel;

@end
