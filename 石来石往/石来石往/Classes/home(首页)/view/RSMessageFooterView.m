//
//  RSMessageFooterView.m
//  石来石往
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMessageFooterView.h"

@implementation RSMessageFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        
        
        UILabel * label = [[UILabel alloc]init];
        label.text = @"没有更多消息了.....";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:label];
        
        
        
        label.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        
    }
    return self;
}

@end
