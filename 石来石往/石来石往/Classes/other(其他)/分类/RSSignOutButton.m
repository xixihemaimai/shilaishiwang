//
//  RSSignOutButton.m
//  石来石往
//
//  Created by mac on 17/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSignOutButton.h"
#import "RSFireworksView.h"

@interface RSSignOutButton()


@property (nonatomic, strong) RSFireworksView *fireworksView;

@end


@implementation RSSignOutButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (iPhone4 || iPhone5) {
            self.imageView.sd_layout
            //.centerYEqualToView(self)
            .topSpaceToView(self, 10)
            .widthIs(20)
            .heightIs(20);
            self.titleLabel.sd_layout
            //.centerYEqualToView(self)
            .topSpaceToView(self, 10)
            .rightSpaceToView(self,10)
            .leftSpaceToView(self.imageView,10)
            .widthIs(45)
            .heightIs(20);
        }else{
            self.imageView.sd_layout
            //.centerYEqualToView(self)
            .topSpaceToView(self, 10)
            .widthIs(20)
            .heightIs(20);
            
            self.titleLabel.sd_layout
            //.centerYEqualToView(self)
            .topSpaceToView(self, 10)
            .rightSpaceToView(self,10)
            .leftSpaceToView(self.imageView,5)
            .widthIs(55)
            .heightIs(20);
        }
        
        
        [self setup];
        
    }
    return self;
}


- (void)setup {
    self.clipsToBounds = NO;
    _fireworksView = [[RSFireworksView alloc] init];
    [self insertSubview:_fireworksView atIndex:0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.fireworksView.frame = self.bounds;
    [self insertSubview:self.fireworksView atIndex:0];
}

#pragma mark - Methods
- (void)animate {
    [self.fireworksView animate];
}


//弹出
- (void)popOutsideWithDuration:(NSTimeInterval)duration {
    
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(2.0f, 2.0f); // 放大
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(0.8f, 0.8f); // 放小
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f); //恢复原样
        }];
    } completion:nil];
}
//弹进
- (void)popInsideWithDuration:(NSTimeInterval)duration {
    
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(2.0f, 2.0f); // 放大
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(0.8f, 0.8f); // 放小
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f); //恢复原样
        }];
    } completion:nil];
//    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
//        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 2.0 animations: ^{
//            self.transform = CGAffineTransformMakeScale(0.7f, 0.7f); // 放小
//        }];
//        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations: ^{
//            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f); //恢复原样
//        }];
//    } completion:nil];
}

#pragma mark - Properties
//获取粒子图像
- (UIImage *)particleImage {
    return self.fireworksView.particleImage;
}

//设置粒子图像
- (void)setParticleImage:(UIImage *)particleImage {
    self.fireworksView.particleImage = particleImage;
}
//获取缩放
- (CGFloat)particleScale {
    return self.fireworksView.particleScale;
}
//设置缩放
- (void)setParticleScale:(CGFloat)particleScale {
    self.fireworksView.particleScale = particleScale;
}
//获取缩放范围
- (CGFloat)particleScaleRange {
    return self.fireworksView.particleScaleRange;
}
//设置缩放范围
- (void)setParticleScaleRange:(CGFloat)particleScaleRange {
    self.fireworksView.particleScaleRange = particleScaleRange;
}


@end
