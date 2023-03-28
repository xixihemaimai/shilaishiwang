//
//  RSHomeButtom.m
//  石来石往
//
//  Created by mac on 17/6/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSHomeButtom.h"

@implementation RSHomeButtom

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.imageView.sd_layout
        .centerYEqualToView(self)
        .centerXEqualToView(self)
        .widthIs(30)
        .heightIs(30);
    }
    return self;
}

@end
