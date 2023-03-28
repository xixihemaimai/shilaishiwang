//
//  RSHeaderReusableView.m
//  石来石往
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSHeaderReusableView.h"

@implementation RSHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {  
        self.backgroundColor = [UIColor whiteColor];
        UILabel * productLabel = [[UILabel alloc]init];
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:productLabel];
        
        _productLabel = productLabel;
        
        productLabel.sd_layout
        .leftSpaceToView(self, 12)
        .rightSpaceToView(self, 12)
        .centerYEqualToView(self)
        .heightIs(16);

    }
    
    return self;
    
}


@end
