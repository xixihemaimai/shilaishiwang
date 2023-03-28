//
//  RSTaobaoSCButton.m
//  石来石往
//
//  Created by mac on 2019/7/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaobaoSCButton.h"

@implementation RSTaobaoSCButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.sd_layout
        .centerYEqualToView(self)
        .widthIs(8)
        .heightIs(8);
        
        self.titleLabel.sd_layout
        .rightSpaceToView(self.imageView, 2)
        .leftSpaceToView(self, 2)
        .centerYEqualToView(self)
        .widthIs(28)
        .heightIs(15);
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return self;
    
    
}

@end
