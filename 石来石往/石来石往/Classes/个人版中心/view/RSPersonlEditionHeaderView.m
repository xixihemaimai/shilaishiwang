//
//  RSPersonlEditionHeaderView.m
//  石来石往
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPersonlEditionHeaderView.h"

@implementation RSPersonlEditionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        UILabel * titleLabel = [[UILabel alloc]init];
       // titleLabel.text = @"荒料管理";
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#282D38"];
        UIFont * font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        titleLabel.font = font;
        
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        titleLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 16)
        .rightSpaceToView(self.contentView, 16)
        .heightIs(23);
        
        
    }
    return self;
}

@end
