//
//  RSChoiceMarkterButton.m
//  石来石往
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSChoiceMarkterButton.h"

@implementation RSChoiceMarkterButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        
        self.imageView.sd_layout
        .widthIs(10)
        .heightIs(15)
        .centerXEqualToView(self);
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.imageView, 0)
        .centerXEqualToView(self)
        .bottomSpaceToView(self, 0);
        
        
        
        
        
    }
    return self;
    
}

@end
