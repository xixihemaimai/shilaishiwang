//
//  RSNewManagementThirdHeaderView.m
//  石来石往
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSNewManagementThirdHeaderView.h"

@implementation RSNewManagementThirdHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [self.contentView addSubview:btn];
        _btn = btn;
        
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"请选择角色";
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        UIImageView * imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@"三角形 copy 2"];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.clipsToBounds = YES;
        [btn addSubview:imageview];
        
       
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [btn addSubview:bottomview];
        
    
        btn.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0);
        
        
        
        titleLabel.sd_layout
        .leftSpaceToView(btn, 12)
        .centerYEqualToView(btn)
        .heightIs(23)
        .rightSpaceToView(btn, 100);
        
        imageview.sd_layout
        .rightSpaceToView(btn, 19)
        .centerYEqualToView(btn)
        .heightIs(5)
        .widthIs(11);
        
        
        
        bottomview.sd_layout
        .leftSpaceToView(btn, 0)
        .rightSpaceToView(btn, 0)
        .bottomSpaceToView(btn, 0)
        .heightIs(1);
        
        
        
        
        
        
    }
    return self;
}


@end
