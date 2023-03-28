//
//  RSFootReusableView.m
//  石来石往
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFootReusableView.h"

@implementation RSFootReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#f3f3f3"];
        [self addSubview:view];
        
       view.sd_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .rightSpaceToView(self, 0);
        
     
    }
    return self;
}

@end
