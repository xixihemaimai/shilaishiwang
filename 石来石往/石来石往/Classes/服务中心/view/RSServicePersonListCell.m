//
//  RSServicePersonListCell.m
//  石来石往
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServicePersonListCell.h"

@implementation RSServicePersonListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UIImageView * touImage = [[UIImageView alloc]init];
        [self.contentView addSubview:touImage];
        _touImage = touImage;
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        UILabel * phoneLabel = [[UILabel alloc]init];
        phoneLabel.textColor = [UIColor blackColor];
        phoneLabel.font = [UIFont systemFontOfSize:15];
        phoneLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:phoneLabel];
        _phoneLabel = phoneLabel;
        UIView * separateView = [[UIView alloc]init];
        separateView.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
        [self.contentView addSubview:separateView];
        
        
        
        touImage.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .widthIs(40)
        .heightIs(40);
        touImage.layer.cornerRadius = touImage.yj_width * 0.5;
        touImage.layer.masksToBounds = YES;
          
        nameLabel.sd_layout
        .topEqualToView(touImage)
        .leftSpaceToView(touImage, 12)
        .heightIs(15)
        .rightSpaceToView(self.contentView, 12);
        
        
        phoneLabel.sd_layout
        .leftEqualToView(nameLabel)
        .rightEqualToView(nameLabel)
        .heightIs(15)
        .bottomEqualToView(touImage);
        
        
        separateView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(1)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        
        
        
        
        
        
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
