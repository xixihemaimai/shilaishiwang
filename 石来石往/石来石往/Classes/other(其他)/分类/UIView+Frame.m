//
//  UIView+Frame.m
//  03-MeiTuan(搭建项目环境)
//
//  Created by Apple on 16/9/6.
//  Copyright © 2016年 yunjia. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setYj_x:(CGFloat)yj_x
{
    CGRect frame = self.frame;
    frame.origin.x = yj_x;
    // 设置UIView的x值
    self.frame = frame;
}

- (CGFloat)yj_x
{
    // 返回UIView的x值
    return self.frame.origin.x;
}

- (void)setYj_y:(CGFloat)yj_y
{
    CGRect frame = self.frame;
    frame.origin.y = yj_y;
    self.frame = frame;
}

- (CGFloat)yj_y
{
    return self.frame.origin.y;
}

- (void)setYj_width:(CGFloat)yj_width
{
    CGRect frame = self.frame;
    frame.size.width = yj_width;
    self.frame = frame;
}

- (CGFloat)yj_width
{
    return self.frame.size.width;
}

- (void)setYj_height:(CGFloat)yj_height
{
    CGRect frame = self.frame;
    frame.size.height = yj_height;
    self.frame = frame;
}

- (CGFloat)yj_height
{
    return self.frame.size.height;
}

- (void)setYj_centerX:(CGFloat)yj_centerX
{
    CGPoint center = self.center;
    center.x = yj_centerX;
    self.center = center;
}

- (CGFloat)yj_centerX
{
    return self.center.x;
}

- (void)setYj_centerY:(CGFloat)yj_centerY
{
    CGPoint center = self.center;
    center.y = yj_centerY;
    self.center = center;
}

- (CGFloat)yj_centerY
{
    return self.center.y;
}


- (void)setCircleImage:(UIImage *)image andSize:(CGSize)size andRadious:(CGSize)radious corners:(UIRectCorner)corners andUImageView:(UIImageView *)imageView{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage * circleImage = [self cutCircleImageWithImage:image size:size radious:radious corners:corners];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = circleImage;
        });
    });
}




//4边都倒角---主要针对于图片的切角
- (UIImage *)cutCircleImageWithImage:(UIImage *)image size:(CGSize)size radious:(CGSize)radious corners:(UIRectCorner)corners{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerTopRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerBottomRight;
        corners = tmp;
    }
    // [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radious].CGPath
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                    [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radious].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//按键的图片的倒角
//UIButton 的背景图片，如果是复杂的图片，可以依靠 UI 切图来实现。如果是简单的纯色背景图片，可以利用代码绘制带圆角的图片。
- (UIImage *)pureColorImageWithSize:(CGSize)size color:(UIColor *)color cornRadius:(CGFloat)cornRadius{
  UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
  view.backgroundColor = color;
  view.layer.cornerRadius = cornRadius;
  // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数是屏幕密度
  UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}


//部分倒角
- (UIView *)cutCircleDifferentImageWithBtn:(UIView *)view rect:(CGRect)rect width:(CGFloat)width radious:(CGSize)radious corners:(UIRectCorner)corners{
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerTopRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerBottomRight;
        corners = tmp;
    }
    CGRect oldRect = rect;
    oldRect.size.width = width;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:corners cornerRadii:radious];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = oldRect;
    view.layer.mask = maskLayer;
    return self;
}


//全部倒角
- (UIView *)ls_getViewWithCornerRadius:(CGFloat)cornerRadius{
    CGSize size = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    return self;
}






@end

