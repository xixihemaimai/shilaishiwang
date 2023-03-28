//
//  RSErrorPictureView.m
//  石来石往
//
//  Created by mac on 2017/9/13.
//  Copyright © 2017年 mac. All rights reserved.
//
#define magrin 6
#define ECA 4
#import "RSErrorPictureView.h"





@implementation RSErrorPictureView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat btnW = ((SCW - 20) - (ECA + 1) * magrin) / ECA;
        CGFloat btnH = btnW;
        CGFloat btnY = 0;
        for (int i = 0; i < 4; i++) {
            UIImageView * imageview = [[UIImageView alloc]init];
            imageview.backgroundColor = [UIColor yellowColor];
            CGFloat btnX = magrin + i * (magrin + btnW);
            imageview.frame = CGRectMake(btnX, btnY, btnW, btnH);
            [self addSubview:imageview];
           
            imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"正确%d",i]];
            
            
            
        }
        
        
        
        
    }
    
    return self;
    
}

@end
