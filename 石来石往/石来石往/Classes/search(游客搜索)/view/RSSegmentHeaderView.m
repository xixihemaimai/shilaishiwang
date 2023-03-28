//
//  RSSegmentHeaderView.m
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSegmentHeaderView.h"

@implementation RSSegmentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        //self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
        UILabel * conmpanyLabel = [[UILabel alloc]init];
        conmpanyLabel.textColor = [UIColor blackColor];
        conmpanyLabel.textAlignment = NSTextAlignmentLeft;
        conmpanyLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:conmpanyLabel];
        _conmpanyLabel = conmpanyLabel;
        
        conmpanyLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 4)
        .bottomSpaceToView(self.contentView, 4)
        .rightSpaceToView(self.contentView, 12);
        
        
        UIView * bottomview = [[UIView alloc]init];
        _bottomview = bottomview;
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
    }
    
    return self;
}

@end
