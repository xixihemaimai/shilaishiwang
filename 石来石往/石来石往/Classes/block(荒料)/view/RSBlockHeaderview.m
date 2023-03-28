//
//  RSBlockHeaderview.m
//  石来石往
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSBlockHeaderview.h"

@implementation RSBlockHeaderview

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"已选";
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:titleLabel];
        
        
        UILabel * zongLiLabel = [[UILabel alloc]init];
        zongLiLabel.textAlignment = NSTextAlignmentCenter;
        //zongLiLabel.textAlignment = NSTextAlignmentLeft;
        zongLiLabel.font = [UIFont systemFontOfSize:15];
        zongLiLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:zongLiLabel];
        _zongLiLabel = zongLiLabel;
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f6f6f6"];
        [self.contentView addSubview:bottomview];
        
        
        
        titleLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(13)
        .widthRatioToView(self.contentView, 0.2);
        
        zongLiLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(titleLabel, 12)
        .rightSpaceToView(self.contentView, 12)
        //.topEqualToView(titleLabel)
       // .bottomEqualToView(titleLabel);
        .topSpaceToView(self.contentView, 12)
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
