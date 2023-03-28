//
//  RSNewSearchHeaderview.m
//  石来石往
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNewSearchHeaderview.h"

@implementation RSNewSearchHeaderview

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel * headerlabel = [[UILabel alloc]init];
        headerlabel.font = [UIFont systemFontOfSize:14];
        headerlabel.backgroundColor = [UIColor clearColor];
        headerlabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        headerlabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:headerlabel];
        _headerlabel = headerlabel;
        
        
        
        
        UIView * bottomview = [[UIView alloc]init];
        
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
        
        
        headerlabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(bottomview, 0);
        
        
        
        
        
        
        
        
    }
    return self;
}

@end
