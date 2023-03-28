//
//  RSNavigationButton.m
//  石来石往
//
//  Created by mac on 17/6/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNavigationButton.h"

@implementation RSNavigationButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.sd_layout
        .centerYEqualToView(self)
        .centerXEqualToView(self)
        .leftSpaceToView(self,-10)
        .widthIs(30)
        .heightIs(30);
    }
    return self;
}

@end
