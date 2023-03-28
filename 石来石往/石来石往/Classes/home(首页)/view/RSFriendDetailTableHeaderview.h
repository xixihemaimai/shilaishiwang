//
//  RSFriendDetailTableHeaderview.h
//  石来石往
//
//  Created by rsxx on 2017/9/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSFriendModel.h"
#import "RSFriendView.h"




@protocol RSFriendDetailTableHeaderviewDelegate <NSObject>

- (void)showFriendHeaderVideoIndex:(NSInteger)index;

@end


@interface RSFriendDetailTableHeaderview : UIView


@property (nonatomic,strong)RSFriendModel * friendmodel;



/**显示图片朋友圈的图片*/
@property (nonatomic,strong)RSFriendView *friendview;



/**货主头像框*/
@property (nonatomic,strong)UIImageView * touImage;

/**朋友圈的图片*/
@property (nonatomic,strong)UIImageView * HZLogo;
/**朋友圈的名字*/
@property (nonatomic,strong)UILabel * HZName;
/**朋友圈的时间*/
@property (nonatomic,strong)UILabel * HZtimeLabel;
/**朋友圈的内容*/
@property (nonatomic,strong) TTTAttributedLabel * content;


/**关注的按键*/
@property (nonatomic,strong)UIButton * followBtn ;

@property (nonatomic,weak)id<RSFriendDetailTableHeaderviewDelegate>delegate;

@end
