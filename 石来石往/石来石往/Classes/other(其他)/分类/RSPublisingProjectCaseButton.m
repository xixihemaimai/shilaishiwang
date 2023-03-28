//
//  RSPublisingProjectCaseButton.m
//  石来石往
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPublisingProjectCaseButton.h"

@implementation RSPublisingProjectCaseButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        
        
        self.titleLabel.sd_layout
        .centerXEqualToView(self)
        .centerYEqualToView(self);
        
        
        self.imageView.sd_layout
        .widthIs(16)
        .heightIs(16)
       // .rightSpaceToView(self.titleLabel, 2)
        .centerYEqualToView(self);
        
        
    }
    return self;
}

@end
