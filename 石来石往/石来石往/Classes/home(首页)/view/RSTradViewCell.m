//
//  RSTradViewCell.m
//  石来石往
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSTradViewCell.h"

@implementation RSTradViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //图片
        UIImageView * imageview = [[UIImageView alloc]init];
        [self.contentView addSubview:imageview];
        _imageview = imageview;
        
        //内容
        UILabel * contentLabel = [[UILabel alloc]init];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
        [self.contentView addSubview:bottomview];
        
        imageview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5)
        .widthIs(40);
        
        contentLabel.sd_layout
        .leftSpaceToView(imageview, 10)
        .rightSpaceToView(self.contentView, 12)
        .topEqualToView(imageview)
        .bottomEqualToView(imageview);
        
        
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
