//
//  TableHeaderView.h
//  SJVideoPlayerProject
//
//  Created by BlueDancer on 2018/2/27.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableHeaderView : UIView

//@property (nonatomic, copy, readwrite, nullable) void(^clickedPlayBtn)(TableHeaderView * view);


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

@property (nonatomic,strong)UIImageView * playView;


@property (nonatomic, strong) UIButton *playBtn;
@end

NS_ASSUME_NONNULL_END
