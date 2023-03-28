//
//  RSNSNotCell.m
//  石来石往
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNSNotCell.h"

@implementation RSNSNotCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //图片
        UIImageView * nsnotImage = [[UIImageView alloc]init];
        [self.contentView addSubview:nsnotImage];
        _nsnotImage = nsnotImage;
        
        //内容
        UILabel * nsnotLabel = [[UILabel alloc]init];
        nsnotLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nsnotLabel.textAlignment = NSTextAlignmentLeft;
        nsnotLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:nsnotLabel];
        _nsnotLabel = nsnotLabel;
        
        //通知的次数
        UILabel * nsnotNumberLabel = [[UILabel alloc]init];
        nsnotNumberLabel.textColor = [UIColor whiteColor];
        nsnotNumberLabel.textAlignment = NSTextAlignmentCenter;
        nsnotNumberLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ff5f04"];
        nsnotNumberLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:nsnotNumberLabel];
        _nsnotNumberLabel = nsnotNumberLabel;
        
        //向右的图标
       // UIImageView * nsnotRightImage = [[UIImageView alloc]init];
        //nsnotRightImage.image = [UIImage imageNamed:@""];
        //[self.contentView addSubview:nsnotRightImage];
        
        
        
        //底下的视图
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
        [self.contentView addSubview:bottomview];
        
        
        
        nsnotImage.sd_layout
        .leftSpaceToView(self.contentView, 13)
        .topSpaceToView(self.contentView, 8)
        .bottomSpaceToView(self.contentView, 7)
        .widthIs(45);
        
        nsnotLabel.sd_layout
        .leftSpaceToView(nsnotImage, 15)
        .centerYEqualToView(self.contentView)
        .heightIs(15)
        .widthRatioToView(self.contentView, 0.3);
        
        
        nsnotNumberLabel.sd_layout
        .rightSpaceToView(self.contentView, 25)
        .topSpaceToView(self.contentView, 22)
        .bottomSpaceToView(self.contentView, 20)
        .widthIs(18);
        
        
        nsnotNumberLabel.layer.cornerRadius = nsnotNumberLabel.yj_width * 0.5;
        nsnotNumberLabel.layer.masksToBounds = YES;
        
        
        
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
