//
//  RSDetailStoneHouseCell.m
//  石来石往
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDetailStoneHouseCell.h"


@interface RSDetailStoneHouseCell ()


@end


@implementation RSDetailStoneHouseCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        //最外层view
        UIView * showview = [[UIView alloc]init];
        showview.layer.cornerRadius = 4;
        showview.layer.masksToBounds = YES;
        showview.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:showview];
        
        
        //显示仓库的位置
        UILabel * stoneHousePositionLabel = [[UILabel alloc]init];
        stoneHousePositionLabel.text = @"1";
        stoneHousePositionLabel.textColor = [UIColor blackColor];
        stoneHousePositionLabel.font = [UIFont systemFontOfSize:14];
        stoneHousePositionLabel.textAlignment = NSTextAlignmentLeft;
        [showview addSubview:stoneHousePositionLabel];
        _stoneHousePositionLabel = stoneHousePositionLabel;
        
        //片
        UILabel * piLabel = [[UILabel alloc]init];
        piLabel.text = @"1";
        piLabel.textColor = [UIColor blackColor];
        piLabel.font = [UIFont systemFontOfSize:14];
        piLabel.textAlignment = NSTextAlignmentRight;
        [showview addSubview:piLabel];
        _piLabel = piLabel;
        
        
        showview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 1);
        
        
        
        stoneHousePositionLabel.sd_layout
        .leftSpaceToView(showview, 12)
        .centerYEqualToView(showview)
        .topSpaceToView(showview, 2)
        .bottomSpaceToView(showview, 2)
        .widthRatioToView(showview, 0.5);
        
        
        piLabel.sd_layout
        .centerYEqualToView(showview)
        .rightSpaceToView(showview, 12)
        .topEqualToView(stoneHousePositionLabel)
        .bottomEqualToView(stoneHousePositionLabel)
        .leftSpaceToView(stoneHousePositionLabel, 5);
    }
    return self;
}







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
