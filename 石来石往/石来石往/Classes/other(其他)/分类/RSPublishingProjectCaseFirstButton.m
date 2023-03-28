//
//  RSPublishingProjectCaseFirstButton.m
//  石来石往
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPublishingProjectCaseFirstButton.h"

@implementation RSPublishingProjectCaseFirstButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.sd_layout
        .widthIs(23)
        .heightIs(23)
        .centerXEqualToView(self)
        .topSpaceToView(self, 20);
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.imageView, -10)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
