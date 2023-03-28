//
//  RSAboutWeCell.m
//  石来石往
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAboutWeCell.h"

@implementation RSAboutWeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *  aboutWeLabel = [[UILabel alloc]init];
        aboutWeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        aboutWeLabel.textAlignment = NSTextAlignmentLeft;
        aboutWeLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:aboutWeLabel];
        _aboutWeLabel = aboutWeLabel;
        
        UILabel * bangLabel = [[UILabel alloc]init];
        bangLabel.textColor = [UIColor colorWithHexColorStr:@"#3385FF"];
        bangLabel.textAlignment = NSTextAlignmentRight;
        bangLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:bangLabel];
        _bangLabel = bangLabel;
        
        
        UIImageView * directionImage = [[UIImageView alloc]init];
        directionImage.image = [UIImage imageNamed:@"向右"];
        [self.contentView addSubview:directionImage];
        
        
        UIView * bottomview =[[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [self.contentView addSubview:bottomview];
        
        
        aboutWeLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .heightIs(30)
        .widthRatioToView(self.contentView, 0.5);
        
        
      
        
        
        directionImage.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 12)
        .widthIs(15)
        .heightEqualToWidth();
        
        
        bangLabel.sd_layout
        .rightSpaceToView(directionImage, 12)
        .centerYEqualToView(self.contentView)
        .topEqualToView(aboutWeLabel)
        .bottomEqualToView(aboutWeLabel)
        .widthIs(50);
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomEqualToView(self.contentView)
        .heightIs(1);
        
        

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
