//
//  RSSecondScreenButton.m
//  石来石往
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSecondScreenButton.h"

@implementation RSSecondScreenButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
     
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.sd_layout
        .widthIs(40)
        .heightIs(21)
        .leftSpaceToView(self, 32)
        .rightSpaceToView(self, 20);
        
        
        self.imageView.sd_layout
        .leftSpaceToView(self.titleLabel, 3)
        .centerYEqualToView(self)
        .heightIs(4)
        .widthIs(8);
    }
    return self;
}

@end
