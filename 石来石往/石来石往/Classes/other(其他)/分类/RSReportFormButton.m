//
//  RSReportFormButton.m
//  石来石往
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSReportFormButton.h"

@implementation RSReportFormButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.imageView.sd_layout
        .rightSpaceToView(self, 14)
        .heightIs(5)
        .widthIs(11)
        .centerYEqualToView(self);
        
        self.titleLabel.sd_layout
        .leftSpaceToView(self , 35);
        
        
    }
    return self;
}

@end
