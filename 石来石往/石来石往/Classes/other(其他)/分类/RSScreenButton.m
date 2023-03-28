//
//  RSScreenButton.m
//  石来石往
//
//  Created by mac on 2017/7/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSScreenButton.h"

@implementation RSScreenButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        self.titleLabel.sd_layout
//        .leftSpaceToView(self, 20);
        
        
        self.imageView.sd_layout
        .leftSpaceToView(self.titleLabel, 5)
        .centerYEqualToView(self)
        .heightIs(14.5)
        .widthIs(16);
       
       
        
        
        
        
    }
    return self;
    
    
}

@end
