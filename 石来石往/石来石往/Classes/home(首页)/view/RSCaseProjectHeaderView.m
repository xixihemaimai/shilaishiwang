//
//  RSCaseProjectHeaderView.m
//  石来石往
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCaseProjectHeaderView.h"

@implementation RSCaseProjectHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        UILabel * label = [[UILabel alloc]init];
        label.text = @"案例用料";
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        
        
        
        label.sd_layout
        .centerXEqualToView(self.contentView)
        .centerYEqualToView(self.contentView)
        .topSpaceToView(self.contentView, 15)
        .bottomSpaceToView(self.contentView, 15)
        .widthIs(164);
        label.layer.borderColor = [UIColor colorWithHexColorStr:@"#F0F0F0"].CGColor;
        label.layer.borderWidth = 1;
        
    }
    return self;
}

@end
