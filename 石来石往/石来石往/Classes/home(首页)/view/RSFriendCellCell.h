//
//  RSFriendCellCell.h
//  石来石往
//
//  Created by mac on 17/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSFriendModel.h"
#import "RSFriendView.h"
#import "RSDiBuView.h"


@protocol RSFriendCellCellDelegate <NSObject>

- (void)showVideoPlayIndex:(NSInteger)index;

@end


@interface RSFriendCellCell : UITableViewCell

@property (nonatomic,strong)RSFriendModel *friendModel;

///**显示图片朋友圈的图片*/
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
/**朋友圈的关注*/
@property (nonatomic,strong)UIButton * followBtn;






@property (nonatomic,strong)RSDiBuView * dibuview;

@property (nonatomic,strong)UIView * bottomview;


@property (nonatomic,weak)id<RSFriendCellCellDelegate>delegate;





@end
