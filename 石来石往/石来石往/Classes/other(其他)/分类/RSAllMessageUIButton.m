//
//  RSAllMessageUIButton.m
//  石来石往
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAllMessageUIButton.h"

@implementation RSAllMessageUIButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.imageView.sd_layout
        .leftSpaceToView(self.titleLabel, 5)
        .centerYEqualToView(self)
        .heightIs(4)
        .widthIs(8);
  
    }
    return self;
    
    
}

@end
