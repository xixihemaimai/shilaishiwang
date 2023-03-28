//
//  RSPermissUserCell.m
//  石来石往
//
//  Created by mac on 2020/4/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSPermissUserCell.h"

@implementation RSPermissUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
     
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        
        UILabel * sonNameLabel = [[UILabel alloc]init];
        sonNameLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        sonNameLabel.textAlignment = NSTextAlignmentLeft;
        sonNameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:sonNameLabel];
        _sonNameLabel = sonNameLabel;
        
        UIImageView * nameImageView = [[UIImageView alloc]init];
        nameImageView.image = [UIImage imageNamed:@"对象"];
        [self.contentView addSubview:nameImageView];
        _nameImageView = nameImageView;
        
        
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [self.contentView addSubview:bottomView];
        
        
        
        nameLabel.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 13)
        .heightIs(16)
        .rightSpaceToView(self.contentView, 100);
        
        sonNameLabel.sd_layout
        .topSpaceToView(nameLabel, 5)
        .leftEqualToView(nameLabel)
        .rightEqualToView(nameLabel)
        .heightIs(16);
        
        
        
        
        nameImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 13)
        .widthIs(16)
        .heightIs(13.5);
        
        
        bottomView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
    }
    return self;
}


@end
