//
//  RSOsakaHeaderview.m
//  石来石往
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSOsakaHeaderview.h"

@implementation RSOsakaHeaderview

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"已选";
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:titleLabel];
        
        
        UILabel * zongPiLabel = [[UILabel alloc]init];
        zongPiLabel.textAlignment = NSTextAlignmentCenter;
        //zongPiLabel.textAlignment = NSTextAlignmentLeft;
        zongPiLabel.font = [UIFont systemFontOfSize:15];
        zongPiLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:zongPiLabel];
        _zongPiLabel = zongPiLabel;
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f6f6f6"];
        [self.contentView addSubview:bottomview];
        
        
        
        titleLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(13)
        .widthRatioToView(self.contentView, 0.2);
        
        zongPiLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(titleLabel, 12)
        .rightSpaceToView(self.contentView, 12)
        //.topEqualToView(titleLabel)
        .topSpaceToView(self.contentView, 12)
        //.bottomEqualToView(titleLabel);
        .bottomSpaceToView(self.contentView, 12);
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
    }
    return self;
}

@end
