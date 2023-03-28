//
//  RSDabanContentFootView.m
//  石来石往
//
//  Created by mac on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSDabanContentFootView.h"

@implementation RSDabanContentFootView


- (instancetype)initWithFrame:(CGRect)frame{
  
    if (self = [super initWithFrame:frame]) {
        
        

        
    }
    return self;
}


- (void)setIsbool:(BOOL)isbool{
    _isbool = isbool;
    
   // CGFloat H = 0.0f;
    if (isbool) {
      //  H = 10;
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW - 24, 10)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self addSubview:view];
        CGRect oldRect = view.bounds;
        oldRect.size.width = SCW - 24;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = maskPath.CGPath;
        maskLayer.frame = oldRect;
        view.layer.mask = maskLayer;
    }
//    else{
//        H = 0;
//    }
   
   
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
