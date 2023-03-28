//
//  RSShopCircleCell.h
//  石来石往
//
//  Created by mac on 2021/11/1.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMImageListView.h"
#import "Moment.h"
#import "Comment.h"

NS_ASSUME_NONNULL_BEGIN


@protocol RSShopCircleCellDelegate;
@interface RSShopCircleCell : UITableViewCell<MLLinkLabelDelegate>
// 头像
@property (nonatomic, strong) UIImageView * headImageView;
//会员
@property (nonatomic, strong) UIImageView * memberImageView;
// 名称
@property (nonatomic, strong) UILabel * nameLab;
//关注
@property (nonatomic, strong) UUButton * attentionBtn;
// 时间
//@property (nonatomic, strong) UILabel * timeLab;
// 全文
@property (nonatomic, strong) UIButton * showAllBtn;
// 内容
@property (nonatomic, strong) MLLinkLabel * shopLinkLabel;
// 图片和视频
@property (nonatomic, strong) MMImageListView * imageListView;
// 赞和评论视图
@property (nonatomic, strong) UIView * commentView;
// 赞和评论视图背景
//@property (nonatomic, strong) UIImageView * bgImageView;
// 操作视图
//@property (nonatomic, strong) MMOperateMenuView * menuView;
// 动态
@property (nonatomic, strong) Moment * moment;
// 代理
@property (nonatomic, weak) id<RSShopCircleCellDelegate> delegate;

//点赞
@property (nonatomic,strong)UUButton * goodBtn;




@end

@protocol RSShopCircleCellDelegate <NSObject>

@optional

// 点击用户头像
- (void)didClickProfile:(RSShopCircleCell *)cell;

//点击用户名称
- (void)didClickName:(RSShopCircleCell *)cell;

// 点赞
- (void)didShopCircleLikeMoment:(RSShopCircleCell *)cell;
// 评论
- (void)didShopCircleAddComment:(RSShopCircleCell *)cell;
//分享
- (void)didShopCircleShareMoment:(RSShopCircleCell *)cell;
// 查看全文/收起
- (void)didShopCircleSelectFullText:(RSShopCircleCell *)cell;
//关注
- (void)didShopCircleAttentionMoment:(RSShopCircleCell *)cell;
// 选择评论
- (void)didShopCircleSelectComment:(Comment *)comment andMomentCell:(RSShopCircleCell *)cell;
// 点击高亮文字
- (void)didShopCircleClickLink:(MLLink *)link linkText:(NSString *)linkText andCell:(RSShopCircleCell *)cell;
//点击评论高亮内容
- (void)didShopCircleClickLink:(MLLink *)link linkText:(NSString *)linkText andComment:(Comment *)comment andCell:(RSShopCircleCell *)cell;

//点击视频的动作
- (void)didCurrentCellVideoUrl:(Moment *)moment;

//- (void)didLikeContentTitleLike:(RSLike *)like;
//查看图片
- (void)didCurrentShowImageView;


@end





//#### 评论
@interface CommentShopLabel : UIView <MLLinkLabelDelegate>

// 内容Label
@property (nonatomic,strong) MLLinkLabel * commentLinkLabel;
// 评论
@property (nonatomic,strong) Comment * comment;
// 点击评论高亮内容
@property (nonatomic, copy) void (^didClickLinkText)(MLLink *link , NSString *linkText,Comment * comment);
// 点击评论
@property (nonatomic, copy) void (^didClickText)(Comment *comment);

@end

NS_ASSUME_NONNULL_END
