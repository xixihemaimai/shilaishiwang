//
//  RSServiceChoiceCustomButton.m
//  石来石往
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServiceChoiceCustomButton.h"

@implementation RSServiceChoiceCustomButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
     
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.sd_layout
        .centerYEqualToView(self)
        .leftSpaceToView(self, 15)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .widthRatioToView(self, 0.5);
        
        
        self.imageView.sd_layout
        .rightSpaceToView(self, 15)
        .centerYEqualToView(self)
        .heightIs(4)
        .widthIs(8);
        
    }
    return self;
}

@end
