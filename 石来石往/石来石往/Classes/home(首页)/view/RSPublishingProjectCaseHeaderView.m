//
//  RSPublishingProjectCaseHeaderView.m
//  石来石往
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPublishingProjectCaseHeaderView.h"

@implementation RSPublishingProjectCaseHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"案例用料";
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomview];
        
        
        titleLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 1)
        .rightSpaceToView(self.contentView, 0);
        
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
    }
    return self;
}

@end
