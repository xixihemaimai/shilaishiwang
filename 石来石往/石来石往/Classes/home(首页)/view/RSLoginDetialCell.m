//
//  RSLoginDetialCell.m
//  石来石往
//
//  Created by mac on 17/5/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSLoginDetialCell.h"

@implementation RSLoginDetialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *cellImageview = [[UIImageView alloc]init];
        [self.contentView addSubview:cellImageview];
        _cellImageview = cellImageview;
        UILabel *cellLabel = [[UILabel alloc]init];
        cellLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        cellLabel.font = [UIFont systemFontOfSize:15];
        _cellLabel = cellLabel;
        [self.contentView addSubview:cellLabel];
        
        UILabel *cellDetailLabel = [[UILabel alloc]init];
//        cellDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        cellDetailLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:cellDetailLabel];
        _cellDetailLabel = cellDetailLabel;
        
        UIImageView * arrowImageview = [[UIImageView alloc]init];
        [self.contentView addSubview:arrowImageview];
        _arrowImageview = arrowImageview;
        
        
        UIView *bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
        cellImageview.sd_layout
        .leftSpaceToView(self.contentView,12)
        .widthIs(23)
        .centerYEqualToView(self.contentView)
        .heightIs(23);
        
        cellLabel.sd_layout
        .topEqualToView(cellImageview)
        .bottomEqualToView(cellImageview)
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(cellImageview,10)
        .widthRatioToView(self.contentView,0.5);
        
        
        
        
        /*
         
         leftImage.sd_layout
         .centerYEqualToView(topBtn)
         .heightIs(25)
         .rightSpaceToView(topBtn, 8)
         .widthIs(25);
         
         */
        arrowImageview.sd_layout
        .rightSpaceToView(self.contentView,12)
        .centerYEqualToView(self.contentView)
        .widthIs(22.5)
        .heightIs(22.5);
        
        cellDetailLabel.sd_layout
        .rightSpaceToView(arrowImageview,5)
        .topEqualToView(arrowImageview)
        .leftSpaceToView(cellLabel,0)
        .bottomEqualToView(arrowImageview)
        .widthRatioToView(self.contentView,0.35);
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView,12)
        .rightSpaceToView(self.contentView,12)
        .bottomSpaceToView(self.contentView,0)
        .heightIs(1);
    }
    return self;
    
    
}
@end
