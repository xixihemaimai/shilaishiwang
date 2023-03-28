//
//  RSFansCell.m
//  石来石往
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFansCell.h"

@implementation RSFansCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView * iconImage = [[UIImageView alloc]init];
        [self.contentView addSubview:iconImage];
        _iconImage = iconImage;
        
        UIButton * fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [fansBtn setTitle:@"加关注" forState:UIControlStateNormal];
        [fansBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FF8200"] forState:UIControlStateNormal];
        fansBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FF8200"].CGColor;
        fansBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        fansBtn.layer.cornerRadius = 12;
        fansBtn.layer.borderWidth = 1;
        fansBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:fansBtn];
        _fansBtn = fansBtn;
        
        UILabel * fansLable = [[UILabel alloc]init];
        //fansLable.text = @"海西石材交易中心";
        fansLable.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        fansLable.textAlignment = NSTextAlignmentLeft;
        fansLable.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:fansLable];
        
        _fansLable = fansLable;
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
        [self.contentView addSubview:bottomview];
        
        
        
        
        iconImage.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 14)
        .bottomSpaceToView(self.contentView, 12)
        .widthIs(40);
        iconImage.layer.cornerRadius = iconImage.yj_width * 0.5;
        iconImage.layer.masksToBounds = YES;
        
        fansBtn.sd_layout
        .rightSpaceToView(self.contentView, 13)
        .centerYEqualToView(self.contentView)
        .widthIs(62)
        .heightIs(23);
        
        fansLable.sd_layout
        .leftSpaceToView(iconImage, 14)
        .topEqualToView(iconImage)
        .bottomEqualToView(iconImage)
        .rightSpaceToView(fansBtn, 10);
        
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
