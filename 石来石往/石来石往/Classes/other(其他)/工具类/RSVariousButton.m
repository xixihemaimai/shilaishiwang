//
//  RSVariousButton.m
//  石来石往
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSVariousButton.h"

@implementation RSVariousButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        self.imageView.sd_layout
        .centerXEqualToView(self)
        .widthIs(40)
        .heightIs(40)
        .topSpaceToView(self,28);
    
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.imageView,2)
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .bottomSpaceToView(self,0);
        
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return self;
}

@end
