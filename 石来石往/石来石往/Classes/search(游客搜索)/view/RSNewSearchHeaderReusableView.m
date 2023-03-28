//
//  RSNewSearchHeaderReusableView.m
//  石来石往
//
//  Created by mac on 2018/12/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSNewSearchHeaderReusableView.h"

@implementation RSNewSearchHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
     
        self.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"搜索历史";
        
        UIFont * font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        titleLabel.font = font;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        UIButton * allDeleteBtn = [[UIButton alloc]init];
        [allDeleteBtn setImage:[UIImage imageNamed:@"垃圾桶"] forState:UIControlStateNormal];
        [self addSubview:allDeleteBtn];
        _allDeleteBtn = allDeleteBtn;
        
        
        titleLabel.sd_layout
        .leftSpaceToView(self, 17)
        .centerYEqualToView(self)
        .heightIs(30)
        .widthRatioToView(self, 0.6);
        
        
    }
    return self;
}


@end
