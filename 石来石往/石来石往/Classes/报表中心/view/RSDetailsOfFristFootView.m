//
//  RSDetailsOfFristFootView.m
//  石来石往
//
//  Created by mac on 2018/1/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSDetailsOfFristFootView.h"

@implementation RSDetailsOfFristFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"当前时间没有相关信息";
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:16];
        [self addSubview:label];
        
        
        label.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        
        
        
    }
    return self;
}

@end
