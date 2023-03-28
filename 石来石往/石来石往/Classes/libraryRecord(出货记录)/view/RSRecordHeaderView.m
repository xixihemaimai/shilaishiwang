//
//  RSRecordHeaderView.m
//  石来石往
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSRecordHeaderView.h"

@implementation RSRecordHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        UILabel * productLabel = [[UILabel alloc]init];
        //productLabel.text = @"货物信息";
        _productLabel = productLabel;
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productLabel.font = [UIFont systemFontOfSize:15];
        productLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:productLabel];
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eeeeee"];
        [self.contentView addSubview:bottomview];
        
        
        
        
        productLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(15);
        
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
    }
    return self;
    
}

@end
