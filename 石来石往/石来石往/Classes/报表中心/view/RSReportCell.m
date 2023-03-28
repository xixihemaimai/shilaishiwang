//
//  RSReportCell.m
//  石来石往
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSReportCell.h"

@implementation RSReportCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        //图片
        UIImageView * imageStyle = [[UIImageView alloc]init];
        [self.contentView addSubview:imageStyle];
        _imageStyle = imageStyle;
        
        //文字
        UILabel * labelStyle = [[UILabel alloc]init];
        labelStyle.font = [UIFont systemFontOfSize:16];
        labelStyle.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:labelStyle];
        _labelStyle = labelStyle;
        
        UIView * bottomview  =[[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomview];
        
        
        imageStyle.sd_layout
        .leftSpaceToView(self.contentView, 14)
        .centerYEqualToView(self.contentView)
        .widthIs(25)
        .heightEqualToWidth();
        
        
        labelStyle.sd_layout
        .leftSpaceToView(imageStyle, 11)
        .widthRatioToView(self.contentView, 0.5)
        .centerYEqualToView(self.contentView)
        .bottomSpaceToView(self.contentView, 1);
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
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
