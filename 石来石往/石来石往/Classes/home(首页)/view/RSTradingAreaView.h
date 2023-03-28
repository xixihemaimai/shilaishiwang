//
//  RSTradingAreaView.h
//  石来石往
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import "RSLike.h"
#import "Moment.h"
#import "MomentCell.h"
#import "RSUserModel.h"
@protocol RSTradingAreaViewDelegate <NSObject>



- (void)searchcontextTitle:(NSString *)title andFriendID:(NSString *)friendID andSelectStr:(NSString *)selectStr;

- (void)cancelBtnAction;


/**点击用户名称和头像*/
- (void)didShowFriendsCell:(MomentCell *)cell;

/**点击用户的分享*/
- (void)didShowFriendShareCell:(MomentCell *)cell;

/**点视频的*/
- (void)didShowFriendsVideoMoment:(Moment *)moment;

/**点击点赞里面的内容*/
- (void)didShowFriendsLikeContentLike:(RSLike *)like;

/**点击评论，点赞，评论的评论,删除评论*/
- (void)didShowFriendsFuntion:(Moment *)moment andType:(NSString *)type;

/**跳转到游客商圈(点击的高亮文字是否是当前登录者)*/
- (void)didShowFriendsYKFriend:(Comment *)currentComment;

/**跳转到游客商圈(点击的高亮文字是否是要恢复的人)*/
- (void)didShowFriendYKFriendReUser:(Comment *)currentComment;



@end



@interface RSTradingAreaView : UIView
//搜索内容
@property (nonatomic,strong)UITextField * searchTextfield;

@property (nonatomic,weak)id<RSTradingAreaViewDelegate>delegate;

@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,strong)NSMutableArray * searchDataArray;

@property (nonatomic,strong)RSUserModel * usermodel;
@end
