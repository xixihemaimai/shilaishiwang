//
//  RSSearchNavigationButton.m
//  石来石往
//
//  Created by mac on 2018/1/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSSearchNavigationButton.h"

@implementation RSSearchNavigationButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.imageView.sd_layout
        .topSpaceToView(self, 15)
        .centerXEqualToView(self)
        .leftSpaceToView(self, 3)
        .widthIs(10)
        .heightIs(20);
        
    }
    return self;
    
}

@end
