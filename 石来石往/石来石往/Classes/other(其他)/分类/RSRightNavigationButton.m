//
//  RSRightNavigationButton.m
//  石来石往
//
//  Created by mac on 2017/10/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSRightNavigationButton.h"

@implementation RSRightNavigationButton



- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.imageView.sd_layout
         //.centerXEqualToView(self)
        .centerYEqualToView(self)
        .rightSpaceToView(self, -5)
        .widthIs(25)
        .heightIs(25);
    }
    return self;
    
}

@end
