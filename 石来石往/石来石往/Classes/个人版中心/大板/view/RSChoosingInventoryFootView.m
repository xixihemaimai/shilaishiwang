//
//  RSChoosingInventoryFootView.m
//  石来石往
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSChoosingInventoryFootView.h"

@implementation RSChoosingInventoryFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCW - 24, 10)];
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:view];
        CGRect oldRect = view.bounds;
        oldRect.size.width = SCW - 24;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = maskPath.CGPath;
        maskLayer.frame = oldRect;
        view.layer.mask = maskLayer;
        
        
    }
    return self;
}

@end
