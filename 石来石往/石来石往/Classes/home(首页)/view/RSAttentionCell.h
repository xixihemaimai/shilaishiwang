//
//  RSAttentionCell.h
//  石来石往
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAttentionCell : UITableViewCell


/**关注的按键*/
@property (nonatomic,strong)UIButton * attentionBtn ;

/**关注的图片*/
@property (nonatomic,strong)UIImageView * iconImage;
/**关注的名称*/
@property (nonatomic,strong)UILabel * fansLable;

@end
