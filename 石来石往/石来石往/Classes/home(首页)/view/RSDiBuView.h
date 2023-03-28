//
//  RSDiBuView.h
//  石来石往
//
//  Created by Santorini on 2017/9/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSSignOutButton.h"

@interface RSDiBuView : UIView

/** 评论按钮 */
@property (nonatomic,strong)RSSignOutButton *commentBtn;

/** 点赞按钮 */
@property (nonatomic,strong)RSSignOutButton *upvoteBtn;

/** 分享 */
@property (nonatomic,strong)RSSignOutButton *shareBtn;


@end
