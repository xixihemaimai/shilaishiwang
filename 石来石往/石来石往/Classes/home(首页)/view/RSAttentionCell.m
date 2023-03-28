//
//  RSAttentionCell.m
//  石来石往
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAttentionCell.h"

@implementation RSAttentionCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView * iconImage = [[UIImageView alloc]init];
        [self.contentView addSubview:iconImage];
        
        _iconImage = iconImage;
        
        UIButton * attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [attentionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#747474"] forState:UIControlStateNormal];
        attentionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        attentionBtn.layer.cornerRadius = 12;
        attentionBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#747474"].CGColor;
        attentionBtn.layer.borderWidth = 1;
        attentionBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:attentionBtn];
        _attentionBtn = attentionBtn;
        
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
        
        
        attentionBtn.sd_layout
        .rightSpaceToView(self.contentView, 13)
        .centerYEqualToView(self.contentView)
        .widthIs(62)
        .heightIs(23);
        
        fansLable.sd_layout
        .leftSpaceToView(iconImage, 14)
        .topEqualToView(iconImage)
        .bottomEqualToView(iconImage)
        .rightSpaceToView(attentionBtn, 10);
        
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
