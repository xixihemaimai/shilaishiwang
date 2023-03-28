//
//  RSEvaluate.m
//  石来石往
//
//  Created by mac on 2018/3/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSEvaluate.h"

@implementation RSEvaluate

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        
        self.imageView.sd_layout
        .centerXEqualToView(self)
        .widthIs(60)
        .heightIs(60)
        .topSpaceToView(self,2);
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.imageView,0)
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .bottomSpaceToView(self,0);
        
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return self;
    
    
}

@end
