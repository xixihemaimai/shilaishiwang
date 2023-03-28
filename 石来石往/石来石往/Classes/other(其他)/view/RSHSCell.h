//
//  RSHSCell.h
//  石来石往
//
//  Created by mac on 17/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSRankModel.h"
@interface RSHSCell : UITableViewCell


@property (nonatomic,strong)RSRankModel *rankModel;

/**前次的图片*/
@property (nonatomic,strong)UIImageView * imageview;
/**排名*/
@property (nonatomic,strong)UILabel *rankLabel;

@end
