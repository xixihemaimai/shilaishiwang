//
//  RSSituationCell.h
//  石来石往
//
//  Created by mac on 17/5/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSituationCell : UITableViewCell

@property (nonatomic,strong)UIImageView *imageview;

@property (nonatomic,strong)UILabel *label;
//匝
@property (nonatomic,strong)UILabel *zaLabel;
//颗
@property (nonatomic,strong)UILabel * keLabel;

//立方
@property (nonatomic,strong)UILabel * liLabel;
//平方
@property (nonatomic,strong)UILabel *piLabel;
// 荒料
@property (nonatomic,strong)UILabel * blockLabel;
// 大板
@property (nonatomic,strong)UILabel *osakaLabel;

@end
