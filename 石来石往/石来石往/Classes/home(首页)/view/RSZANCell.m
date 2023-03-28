//
//  RSZANCell.m
//  石来石往
//
//  Created by mac on 2018/1/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSZANCell.h"

@implementation RSZANCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        //分割线
        UIView * topview = [[UIView alloc]init];
        topview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
        [self.contentView addSubview:topview];
        
        
        //头像
        UIImageView * touImage = [[UIImageView alloc]init];
        [self.contentView addSubview:touImage];
        _touImage = touImage;
        
        
        
        
        //货主的类型
        UIImageView * touImages = [[UIImageView alloc]init];
        // touImage.image = [UIImage imageNamed:@"货主头像框"];
        [self.contentView addSubview:touImages];
        _touImages = touImages;
        
        
        
        
        //名字
        UILabel * touLabel = [[UILabel alloc]init];
        touLabel.font = [UIFont systemFontOfSize:16];
        touLabel.textColor = [UIColor blackColor];
        touLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:touLabel];
        _touLabel = touLabel;
        //关注按键
        UIButton * touBtn = [[UIButton alloc]init];
        touBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [touBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        [touBtn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
        [touBtn setTitle:@"关注" forState:UIControlStateNormal];
        [touBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCFCFC"]];
        touBtn.layer.cornerRadius = 2;
        touBtn.layer.borderWidth = 1;
        touBtn.imageEdgeInsets = UIEdgeInsetsMake(9, 5, 9, 5);
        
        touBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        touBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
        touBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:touBtn];
        _touBtn = touBtn;
        
        
        topview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
        touImage.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5)
        .widthIs(50);
        
        
        
        touImages.sd_layout
        .leftSpaceToView(touImage, 10)
        .centerYEqualToView(self.contentView)
        .widthIs(20)
        .heightIs(20);
        
        
        
        touLabel.sd_layout
        .leftSpaceToView(touImages, 10)
        .centerYEqualToView(self.contentView)
        .heightIs(15)
        .widthRatioToView(self.contentView, 0.6);
        
        
        touBtn.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .widthIs(60)
        .heightIs(30);
        
        
        
        
        
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
