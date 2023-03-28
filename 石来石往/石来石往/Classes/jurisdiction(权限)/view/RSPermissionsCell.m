//
//  RSPermissionsCell.m
//  权限
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSPermissionsCell.h"



#import "UIColor+HexColor.h"
#import <SDAutoLayout.h>

@implementation RSPermissionsCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //头像图片
        UIImageView * iconImage = [[UIImageView alloc]init];
        [self.contentView addSubview:iconImage];
        _iconImage = iconImage;
        //名字
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:nameLabel];
        
        _nameLabel = nameLabel;
        //账号
        UILabel * accountLabel = [[UILabel alloc]init];
        accountLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        accountLabel.font = [UIFont systemFontOfSize:12];
        accountLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:accountLabel];
        _accountLabel = accountLabel;
        
        
        UIButton * goBtn = [[UIButton alloc]init];
        [goBtn setImage:[UIImage imageNamed:@"ra"] forState:UIControlStateNormal];
        [self.contentView addSubview:goBtn];
        _goBtn = goBtn;
        
        
        
        
        UILabel * statusLabel = [[UILabel alloc]init];
        statusLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:statusLabel];
        _statusLabel = statusLabel;
        
        

        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
        [self.contentView addSubview:bottomview];
        
        
        iconImage.sd_layout
        .leftSpaceToView(self.contentView, 28)
        .topSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 11)
        .widthIs(30);
        
        nameLabel.sd_layout
        .leftSpaceToView(iconImage, 10)
        .topSpaceToView(self.contentView, 8)
        .heightIs(16)
        .widthRatioToView(self.contentView, 0.7);
        
        accountLabel.sd_layout
        .leftEqualToView(nameLabel)
        .topSpaceToView(nameLabel, 7)
        .bottomEqualToView(iconImage)
        .rightEqualToView(nameLabel);
        
        
        
        goBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 21)
        .bottomSpaceToView(self.contentView, 19)
        .widthIs(7);
        
    
        statusLabel.sd_layout
        .rightSpaceToView(goBtn, 10)
        .centerYEqualToView(self.contentView)
        .topEqualToView(iconImage)
        .bottomEqualToView(iconImage)
        .widthIs(70);
        
        
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 25)
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
