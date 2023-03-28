//
//  RSDetailScreenButton.m
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDetailScreenButton.h"

@implementation RSDetailScreenButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        
        self.titleLabel.sd_layout
        .leftSpaceToView(self, 7)
        .centerYEqualToView(self)
        .widthIs(30)
        .heightIs(25);
        
        
        self.imageView.sd_layout
        .leftSpaceToView(self.titleLabel, 0)
        .centerYEqualToView(self)
        .widthIs(10)
        .heightIs(10);
        
        
    }
    
    return self;
    
}

@end
