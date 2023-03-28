//
//  YJFastButton.m
//  BaiSi
//
//  Created by Apple on 16/9/26.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJFastButton.h"

@implementation YJFastButton


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.sd_layout
        .centerXEqualToView(self)
        .widthIs(50)
        .heightIs(50)
        .topSpaceToView(self,0);
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.imageView,0)
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .bottomSpaceToView(self,0);
    
        
       // self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return self;
    
    
}






















@end
