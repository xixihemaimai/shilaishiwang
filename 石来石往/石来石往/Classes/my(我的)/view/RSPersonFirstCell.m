//
//  RSPersonFirstCell.m
//  石来石往
//
//  Created by mac on 2017/9/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSPersonFirstCell.h"

@implementation RSPersonFirstCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel * iconLabel = [[UILabel alloc]init];
        iconLabel.text = @"更改头像";
        iconLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        iconLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:iconLabel];
        
        
        
        UIImageView * imageview = [[UIImageView alloc]init];
        
        [self.contentView addSubview:imageview];
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        

        
        _imageview = imageview;
        iconLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(15)
        .widthIs(80);
        
        imageview.sd_layout
        .centerYEqualToView(self.contentView)
        .heightIs(40)
        .widthIs(40)
        .rightSpaceToView(self.contentView, 32);
        
        imageview.layer.cornerRadius = imageview.yj_width * 0.5;
        imageview.layer.masksToBounds = YES;
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
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
