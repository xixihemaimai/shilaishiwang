//
//  RSPermissionsHeaderview.m
//  权限
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSPermissionsHeaderview.h"
#import <SDAutoLayout.h>
#import "UIColor+HexColor.h"


@implementation RSPermissionsHeaderview


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8F8"];
//        UIView  * topView = [[UIView alloc]init];
//        topView.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//        [self.contentView addSubview:topView];
//
//        topView.sd_layout
//        .leftSpaceToView(self.contentView, 0)
//        .rightSpaceToView(self.contentView, 0)
//        .topSpaceToView(self.contentView, 0)
//        .heightIs(125);
//
//        //名字
//        UILabel * nameLabel = [[UILabel alloc]init];
//        _nameLabel = nameLabel;
//        nameLabel.font = [UIFont systemFontOfSize:18];
//        nameLabel.tintColor = [UIColor colorWithHexColorStr:@"#333333"];
//        //nameLabel.text = @"陈小编";
//        [topView addSubview:nameLabel];
//
//        //账号
//        UILabel * accountLabel = [[UILabel alloc]init];
//
//        _accountLabel = accountLabel;
//        accountLabel.font = [UIFont systemFontOfSize:15];
//        accountLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//       // accountLabel.text = @"12545254524";
//        [topView addSubview:accountLabel];
//
//        //头像
//        UIImageView * iconImage = [[UIImageView alloc]init];
//        _iconImage = iconImage;
//        //[iconBtn setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
//
//        [topView addSubview:iconImage];
//
//
//        iconImage.sd_layout
//        .rightSpaceToView(topView, 32)
//        .topSpaceToView(topView, 32)
//        .bottomSpaceToView(topView, 29)
//        .widthIs(65);
//
//        iconImage.layer.cornerRadius = iconImage.yj_width * 0.5;
//        iconImage.layer.masksToBounds = YES;
//
//
//        nameLabel.sd_layout
//        .leftSpaceToView(topView, 25)
//        .topSpaceToView(topView, 42)
//        .heightIs(23)
//        .rightSpaceToView(iconImage, 10);
//
//
//        accountLabel.sd_layout
//        .leftEqualToView(nameLabel)
//        .rightEqualToView(nameLabel)
//        .topSpaceToView(nameLabel, 10)
//        .heightIs(12);
//
//
//
//        UIView * bottomview = [[UIView alloc]init];
//        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
//        [topView addSubview:bottomview];
//        bottomview.sd_layout
//        .leftSpaceToView(topView, 0)
//        .rightSpaceToView(topView, 0)
//        .bottomSpaceToView(topView, 0)
//        .heightIs(1);
        
        
        //添加我的子账号
        UIView * myAccountView = [[UIView alloc]init];
        myAccountView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:myAccountView];
        
        myAccountView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 10)
        .heightIs(51);
        
        //显示我的子账号视图
        UILabel * showLabel = [[UILabel alloc]init];
        showLabel.text = @"我的子账号";
        showLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        showLabel.font = [UIFont systemFontOfSize:18];
        [myAccountView addSubview:showLabel];
        
        
        
        UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:[UIImage imageNamed:@"矢量添加"] forState:UIControlStateNormal];
        [myAccountView addSubview:addBtn];
        _addBtn = addBtn;
        
        
        UIView * myBottomview =  [[UIView alloc]init];
        myBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
        [myAccountView addSubview:myBottomview];
        
        
        
        addBtn.sd_layout
        .centerYEqualToView(myAccountView)
        .rightSpaceToView(myAccountView, 13)
        .heightIs(28)
        .widthIs(27);
        
        
        showLabel.sd_layout
        .centerYEqualToView(myAccountView)
        .leftSpaceToView(myAccountView, 25)
        .heightIs(17)
        .rightSpaceToView(addBtn, 20);
        
        
        myBottomview.sd_layout
        .leftEqualToView(showLabel)
        .rightSpaceToView(myAccountView, 0)
        .bottomSpaceToView(myAccountView, 0)
        .heightIs(1);

    }
    
    
    return self;
}

@end
