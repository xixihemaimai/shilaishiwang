//
//  RSPwmsAccountCell.m
//  石来石往
//
//  Created by mac on 2019/4/3.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPwmsAccountCell.h"

@implementation RSPwmsAccountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        
        UIImageView * accountImageView = [[UIImageView alloc]init];
        accountImageView.image = [UIImage imageNamed:@"Oval 10"];
        accountImageView.clipsToBounds = YES;
        accountImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:accountImageView];

        //公司名称首个文字
        UILabel * accountNameLabel = [[UILabel alloc]init];
        accountNameLabel.text = @"白";
        accountNameLabel.font = [UIFont systemFontOfSize:19];
        accountNameLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        accountNameLabel.textAlignment = NSTextAlignmentCenter;
        [accountImageView addSubview:accountNameLabel];
        _accountNameLabel = accountNameLabel;
        
        UILabel * accountAllNameLabel = [[UILabel alloc]init];
        accountAllNameLabel.text = @"海西";
        accountAllNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        accountAllNameLabel.font = [UIFont systemFontOfSize:18];
        accountAllNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:accountAllNameLabel];
        _accountAllNameLabel = accountAllNameLabel;
        
        //图片选中
        UIImageView * accountSelectImageView = [[UIImageView alloc]init];
        accountSelectImageView.image = [UIImage imageNamed:@"打勾"];
        accountSelectImageView.clipsToBounds = YES;
        accountSelectImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:accountSelectImageView];
        _accountSelectImageView = accountSelectImageView;
    //底部横线
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomView];
        
        
        
        accountImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .widthIs(40)
        .heightEqualToWidth();
        
       accountNameLabel.sd_layout
        .centerYEqualToView(accountImageView)
        .centerXEqualToView(accountImageView)
        .leftSpaceToView(accountImageView, 0)
        .rightSpaceToView(accountImageView, 0)
        .topSpaceToView(accountImageView, 0)
        .bottomSpaceToView(accountImageView, 0);
        
        accountAllNameLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(accountImageView, 13)
        .heightIs(25)
        .widthRatioToView(self.contentView, 0.5);
        
        
        accountSelectImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 14)
        .widthIs(13)
        .heightIs(9);
        
        bottomView.sd_layout
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
