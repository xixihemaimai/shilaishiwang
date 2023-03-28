//
//  RSPersonalFunctionCell.h
//  石来石往
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPersonalFunctionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSPersonalFunctionCell : UITableViewCell

@property (nonatomic,strong)UIImageView * showImageView;

@property (nonatomic,strong)UILabel * showLabel;
@property (nonatomic,strong)UILabel * timeLabel;

@property (nonatomic,strong)UILabel * productLabel;

@property (nonatomic,strong)UILabel * numberLabel;


@property (nonatomic,strong)UILabel * areaLabel;

@property (nonatomic,strong)UILabel * statusLabel;

@property (nonatomic,strong) UILabel * abnormalLabel ;


@property (nonatomic,strong)RSPersonalFunctionModel * personalFunctionmodel;

@end

NS_ASSUME_NONNULL_END
