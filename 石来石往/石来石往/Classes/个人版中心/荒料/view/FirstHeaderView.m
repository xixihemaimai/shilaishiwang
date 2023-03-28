//
//  FirstHeaderView.m
//  石来石往
//
//  Created by mac on 2019/6/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FirstHeaderView.h"

@implementation FirstHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
     
//        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 47)];
        self.contentView.backgroundColor = [UIColor colorFromHexString:@"#ffffff"];
        
        //内容视图
        UIView * secondHeaderView = [[UIView alloc]init];
        secondHeaderView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
        [self.contentView addSubview:secondHeaderView];
        
        
        //名称
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.text = @"名称";
        [secondHeaderView addSubview:nameLabel];
        
        //单价
        UILabel * priceLabel = [[UILabel alloc]init];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        priceLabel.font = [UIFont systemFontOfSize:15];
        priceLabel.text = @"单价";
        [secondHeaderView addSubview:priceLabel];
        
        //数量
        UILabel * numberLabel = [[UILabel alloc]init];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        numberLabel.font = [UIFont systemFontOfSize:15];
        numberLabel.text = @"数量";
        [secondHeaderView addSubview:numberLabel];
        
        //金额
        UILabel * moneyLabel = [[UILabel alloc]init];
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        moneyLabel.font = [UIFont systemFontOfSize:15];
        moneyLabel.text = @"金额";
        [secondHeaderView addSubview:moneyLabel];
        
        
        secondHeaderView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .bottomSpaceToView(self.contentView, 0);
        
        nameLabel.sd_layout
        .leftSpaceToView(secondHeaderView, 15)
        .centerYEqualToView(secondHeaderView)
        .heightIs(21)
        .widthRatioToView(secondHeaderView, 0.4);
        
        priceLabel.sd_layout
        .centerYEqualToView(secondHeaderView)
        .centerXEqualToView(secondHeaderView)
        .heightIs(21)
        .widthIs(31);
        
        numberLabel.sd_layout
        .leftSpaceToView(priceLabel, 29)
        .centerYEqualToView(secondHeaderView)
        .heightIs(21)
        .widthIs(31);
        
        moneyLabel.sd_layout
        .leftSpaceToView(numberLabel, 29)
        .centerYEqualToView(secondHeaderView)
        .heightIs(21)
        .widthIs(31);
        
    }
    return self;
}

@end
