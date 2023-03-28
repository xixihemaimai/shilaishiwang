//
//  RSMomentButton.m
//  石来石往
//
//  Created by mac on 2018/12/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSMomentButton.h"

@implementation RSMomentButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.sd_layout
        .centerXEqualToView(self)
        .widthIs(45)
        .heightIs(45)
        .topSpaceToView(self,2);
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.imageView,2)
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .bottomSpaceToView(self,0);
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
