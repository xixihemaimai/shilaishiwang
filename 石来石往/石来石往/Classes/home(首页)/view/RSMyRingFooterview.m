//
//  RSMyRingFooterview.m
//  石来石往
//
//  Created by mac on 2017/8/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMyRingFooterview.h"

@implementation RSMyRingFooterview

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        
        view.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        
    }
    
    return self;
    
}

@end
