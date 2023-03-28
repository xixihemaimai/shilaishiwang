//
//  RSRightPitureButton.m
//  石来石往
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSRightPitureButton.h"

@implementation RSRightPitureButton


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.titleLabel.sd_layout
        .centerYEqualToView(self)
        .centerXEqualToView(self);
        
        
        self.imageView.sd_layout
        .leftSpaceToView(self.titleLabel, 4)
        .centerYEqualToView(self)
        .widthIs(12)
        .heightIs(7);
        // self.titleLabel.font = [UIFont systemFontOfSize:14];
       // self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return self;
}

@end
