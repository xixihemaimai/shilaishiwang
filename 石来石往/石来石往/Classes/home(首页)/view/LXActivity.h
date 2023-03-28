//
//  LXActivity.h
//  LXActivityDemo
//
//  Created by lixiang on 14-3-17.
//  Copyright (c) 2014年 lcolco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSFriendModel.h"
#import "RSCodeSheetModel.h"
#import "Moment.h"
#import "RSTaoBaoUserLikeModel.h"
@protocol LXActivityDelegate <NSObject>

@optional
- (void)didClickOnImageIndex:(NSInteger *)imageIndex andRSFriendModel:(RSFriendModel *)friendmodel;
- (void)didClickOnImageIndex:(NSInteger *)imageIndex andRSCodeSheetModel:(RSCodeSheetModel *)codeSheetModel;
- (void)didClickOnCancelButton;
- (void)didClickOnImageIndex:(NSInteger *)imageIndex andMoment:(Moment *)moment;

- (void)didClickOnmageIndex:(NSInteger *)imageIndex andTaobaoShare:(RSTaoBaoUserLikeModel *)taobaoUserlistmodel;
@end

@interface LXActivity : UIView


@property (nonatomic,strong)RSFriendModel * friendmodel;

@property (nonatomic,strong)RSCodeSheetModel * codeSheetModel;


@property (nonatomic,strong)Moment * moment;


@property (nonatomic,strong)RSTaoBaoUserLikeModel * taobaoUserListmodel;

- (id)initWithTitle:(NSString *)title delegate:(id<LXActivityDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray andRSFriend:(RSFriendModel *)friendmodel;

- (void)showInView:(UIView *)view;


- (id)initWithTitle:(NSString *)title delegate:(id<LXActivityDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray andRSCodeSheetModel:(RSCodeSheetModel *)codeSheetModel;

- (id)initWithTitle:(NSString *)title delegate:(id<LXActivityDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray andMoment:(Moment *)moment;


- (id)initWithTitle:(NSString *)title delegate:(id<LXActivityDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray andTaobaoUserListModel:(RSTaoBaoUserLikeModel *)taobaoUserListmodel;
@end
