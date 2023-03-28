//
//  RSViewProgressLine.m
//  石来石往
//
//  Created by mac on 17/6/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSViewProgressLine.h"

@implementation RSViewProgressLine

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.hidden = YES;
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        
        
    }
    return self;
    
    
    
}


-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.backgroundColor = _lineColor;
}

-(void)startLoadingAnimation{
    self.hidden = NO;
    self.width = 0.0;
    
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.width = SCW * 0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.width = SCW * 0.8;
        }];
    }];
    
    
}

-(void)endLoadingAnimation{
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.width = SCW;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}




@end
