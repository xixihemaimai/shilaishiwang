//
//  RSCustomButton.m
//  石来石往
//
//  Created by mac on 17/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSCustomButton.h"

@implementation RSCustomButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.sd_layout
        .rightSpaceToView(self.titleLabel,25)
        .centerYEqualToView(self)
        .widthIs(20)
        .heightIs(20);
        self.titleLabel.sd_layout
        .centerYEqualToView(self)
        .rightSpaceToView(self,10)
        .widthIs(30)
        .heightIs(30);
    }
    return self;
}

@end
