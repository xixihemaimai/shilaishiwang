//
//  RSSegmentCell.h
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSHuangAndDaModel.h"



@interface RSSegmentCell : UITableViewCell

/**图片*/
@property (nonatomic,strong)UIImageView * imageview;
/**名字*/
@property (nonatomic,strong)UILabel * nameLabel;
/**颗*/
@property (nonatomic,strong)UILabel * keLabel;
/**体积*/
@property (nonatomic,strong)UILabel * tiLabel;



/**体重*/
@property (nonatomic,strong)UILabel * weightLabel;



@property (nonatomic,strong)RSHuangAndDaModel * huangAndDamodel;







@end
