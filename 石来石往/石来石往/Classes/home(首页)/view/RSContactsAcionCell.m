//
//  RSContactsAcionCell.m
//  石来石往
//
//  Created by mac on 2019/1/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSContactsAcionCell.h"

@implementation RSContactsAcionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //名字
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        //电话号码
        UILabel * phoneLabel = [[UILabel alloc]init];
        phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        phoneLabel.font = [UIFont systemFontOfSize:12];
        phoneLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:phoneLabel];
        _phoneLabel = phoneLabel;
        
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageNamed:@"打电话"];
        [self.contentView addSubview:imageView];
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomview];
        
        nameLabel.sd_layout
        .leftSpaceToView(self.contentView, 17)
        .rightSpaceToView(self.contentView, 41)
        .heightIs(14)
        .topSpaceToView(self.contentView, 11);
        
        phoneLabel.sd_layout
        .leftEqualToView(nameLabel)
        .rightEqualToView(nameLabel)
        .topSpaceToView(nameLabel, 6)
        .bottomSpaceToView(self.contentView, 11);
        
        
        imageView.sd_layout
        .rightSpaceToView(self.contentView, 11)
        .centerYEqualToView(self.contentView)
        .widthIs(30)
        .heightEqualToWidth();
        
        
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
