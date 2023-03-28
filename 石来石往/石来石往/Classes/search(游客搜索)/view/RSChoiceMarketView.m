//
//  RSChoiceMarketView.m
//  石来石往
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSChoiceMarketView.h"

@implementation RSChoiceMarketView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {

        self.userInteractionEnabled = YES;
        
        //总的数字
        UILabel * numeberLabel = [[UILabel alloc]init];
        numeberLabel.userInteractionEnabled = YES;
        numeberLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        numeberLabel.font = [UIFont systemFontOfSize:18];
        numeberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numeberLabel];
        _numeberLabel = numeberLabel;
        
        //市场
        UILabel * marketLabel = [[UILabel alloc]init];
        marketLabel.userInteractionEnabled = YES;
       
        marketLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        marketLabel.font = [UIFont systemFontOfSize:12];
        marketLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:marketLabel];
        
        _marketLabel = marketLabel;
        //当前的市场
        RSChoiceMarkterButton * currentMartketBtn = [[RSChoiceMarkterButton alloc]init];
        [currentMartketBtn setTitle:@"当前" forState:UIControlStateNormal];
        [currentMartketBtn setImage:[UIImage imageNamed:@"地址-白"] forState:UIControlStateNormal];
        [currentMartketBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]
                                forState:UIControlStateNormal];
        currentMartketBtn.titleLabel.font = [UIFont systemFontOfSize:7];
        [self addSubview:currentMartketBtn];
        _currentMartketBtn = currentMartketBtn;
        
        
        UIButton * choiceBtn = [[UIButton alloc]init];
        [self addSubview:choiceBtn];
        [choiceBtn bringSubviewToFront:self];
        _choiceBtn = choiceBtn;
        
        
        
        numeberLabel.sd_layout
        .topSpaceToView(self, 8)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(20)
        .centerXEqualToView(self);
        
        
        marketLabel.sd_layout
        .topSpaceToView(numeberLabel, 3)
        .centerXEqualToView(self)
        .widthIs(90)
        .heightIs(18);
        
        
        currentMartketBtn.sd_layout
        .rightSpaceToView(self, 0)
        .bottomSpaceToView(self, 6)
        .widthIs(35)
        .heightIs(35);
        
        
        choiceBtn.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        
        
        
    }
    return self;
}

@end
