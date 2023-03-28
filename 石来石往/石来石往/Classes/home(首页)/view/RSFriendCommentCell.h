//
//  RSFriendCommentCell.h
//  石来石往
//
//  Created by rsxx on 2017/9/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSFriendDetailModel.h"

@interface RSFriendCommentCell : UITableViewCell

/**评论者头像*/
@property (nonatomic,strong)UIImageView * icomImage;

/**评论者的名字*/
@property (nonatomic,strong)UILabel * hznameLabel;

/**评论者的内容*/
@property (nonatomic,strong)UILabel * commentLabel;

/**评论者的时间*/
@property (nonatomic,strong)UILabel * dateLabel;

/**模型*/
@property (nonatomic,strong)RSFriendDetailModel *friendDetailmodel;


/**货主头像框*/
@property (nonatomic,strong)UIImageView * touImage;


@end
