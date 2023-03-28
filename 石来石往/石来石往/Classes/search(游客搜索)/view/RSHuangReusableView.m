//
//  RSHuangReusableView.m
//  石来石往
//
//  Created by mac on 2018/7/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSHuangReusableView.h"

@implementation RSHuangReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        //重置
        UIButton * resetBtn = [[UIButton alloc]init];
        [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [resetBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
        resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [resetBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#DEDEDE"]];
        [self addSubview:resetBtn];
        _resetBtn = resetBtn;
        //确定
        UIButton * sureBtn = [[UIButton alloc]init];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
        [self addSubview:sureBtn];
        _sureBtn = sureBtn;
        
        
        
        
        resetBtn.sd_layout
        .widthIs(64)
        .heightIs(26)
        .leftSpaceToView(self, SCW/2 - 64 - 12)
        .centerYEqualToView(self);
        
        resetBtn.layer.cornerRadius = 13;
        resetBtn.layer.masksToBounds = YES;
        
        
        sureBtn.sd_layout
        .widthIs(64)
        .heightIs(26)
        .centerYEqualToView(self)
        .leftSpaceToView(self, SCW/2 + 24);
        sureBtn.layer.cornerRadius = 13;
        sureBtn.layer.masksToBounds = YES;
        
        
    }
    return self;
}



@end
