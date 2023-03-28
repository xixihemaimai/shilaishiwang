//
//  RSPayMentReusableView.m
//  石来石往
//
//  Created by mac on 2021/4/12.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSPayMentReusableView.h"

@implementation RSPayMentReusableView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //title
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"总费用:";
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLabel];
        //totalmoney
        UILabel * totalMoneyLabel = [[UILabel alloc]init];
        totalMoneyLabel.text = @"2922992929元";
        totalMoneyLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        totalMoneyLabel.font = [UIFont systemFontOfSize:16];
        totalMoneyLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLabel];
        
        titleLabel.sd_layout.leftSpaceToView(self, 15).centerYEqualToView(self).widthIs(100).heightIs(22.5);
        
        totalMoneyLabel.sd_layout.leftSpaceToView(titleLabel, 5).centerYEqualToView(self).topEqualToView(titleLabel).bottomEqualToView(titleLabel).rightSpaceToView(self, 15);
        
        
    }
    return self;
}

@end
