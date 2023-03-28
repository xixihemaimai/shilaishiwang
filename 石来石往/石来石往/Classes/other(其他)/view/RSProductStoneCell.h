//
//  RSProductStoneCell.h
//  石来石往
//
//  Created by mac on 2017/8/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPicturePathModel.h"

@interface RSProductStoneCell : UITableViewCell

@property (nonatomic,strong)UIButton * playPhoneBtn;


@property (nonatomic,strong)RSPicturePathModel * picturepathmodel;

@property (nonatomic,strong)UILabel * numLabel;

@property (nonatomic,strong)UIImageView * imageview;

@end
