//
//  RSTaobaoSearchFunctionScreenView.m
//  石来石往
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 mac. All rights reserved.
//
#define SLIP_WIDTH (268)
#import "RSLeftFunctionScreenView.h"
#import <Accelerate/Accelerate.h>

#import "RSTaobaoSearchFunctionScreenView.h"

@interface RSTaobaoSearchFunctionScreenView()

@end

@implementation RSTaobaoSearchFunctionScreenView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // NSAssert(nil, @"please init with -initWithSender:sender");
    }
    return self;
    
}

- (instancetype)initWithSender:(UIViewController*)sender{
    //CGRect bounds = [UIScreen mainScreen].bounds;
    
    // CGRect frame = CGRectMake(SCW,64,SCW,SCH-64);
    CGFloat Y = 0.0f;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
    }else{
        Y = 64;
    }
    
    //140
    CGRect frame = CGRectMake(SCW,  44, SCW, SCH - Y - 98 - 41);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self buildViews:sender];
    }
    return self;
}
-(void)buildViews:(UIViewController*)sender{
    _sender = sender;
    
    CGFloat Y = 0.0f;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
    }else{
        Y = 64;
    }
    //[UIScreen mainScreen].bounds.size.height
    _blurImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 164,[UIScreen mainScreen].bounds.size.width ,SCH - 41 - Y - 98)];
    _blurImageView.userInteractionEnabled = YES;
    _blurImageView.alpha = 1.0;
    _blurImageView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    //_blurImageView.layer.borderWidth = 5;
    //_blurImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:_blurImageView];
    _lefttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    
    [_blurImageView addGestureRecognizer:_lefttap];
    //[_sender.view addGestureRecognizer:_lefttap];
    
    
    
}

-(void)setContentView:(UIView*)contentView{
    if (contentView) {
        _contentView = contentView;
    }
    //SCW - SLIP_WIDTH 268
    _contentView.frame = CGRectMake(0, 0,SCW, 164);
    [self addSubview:_contentView];
    
}
-(void)show:(BOOL)show{
    //    UIImage *image =  [self imageFromView:_sender.view];
    //    RSHuangDetailAndDaDetailViewController * huangDetailVc = [[RSHuangDetailAndDaDetailViewController alloc]init];
    //    huangDetailVc = _sender;
    //    if (!isOpen) {
    //        _blurImageView.alpha = 1;
    //
    //    }
    //   // _sender.navigationController.navigationBar.hidden = YES;
    //
    //    //[UIScreen mainScreen].bounds.size.width
    //    CGFloat x = show?0:[UIScreen mainScreen].bounds.size.width;
    //    [UIView animateWithDuration:0.3 animations:^{
    //        self.frame = CGRectMake(x, 64, self.frame.size.width, self.frame.size.height);
    //        if(!isOpen){
    //            huangDetailVc.menu.hidden = YES;
    //            _blurImageView.image = image;
    //            _blurImageView.image= [self blurryImage:_blurImageView.image withBlurLevel:0.2];
    //        }
    //    } completion:^(BOOL finished) {
    //        isOpen = show;
    //        if(!isOpen){
    //            huangDetailVc.menu.hidden = NO;
    //           // _sender.navigationController.navigationBar.hidden = NO;
    //            _blurImageView.alpha = 0;
    //            _blurImageView.image = nil;
    //
    //        }
    //
    //    }];
    
    
    UIImage *image =  [self imageFromView:_sender.view];
    if (!isOpen) {
        _blurImageView.alpha = 1;
        
    }
    // _sender.navigationController.navigationBar.hidden = YES;
    
    //[UIScreen mainScreen].bounds.size.width
    
    CGFloat Y = 0.0f;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
    }else{
        Y = 64;
    }
    
    CGFloat x = show?0:[UIScreen mainScreen].bounds.size.width;
    //140
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(x, 44, self.frame.size.width, self.frame.size.height);
        if(!isOpen){
            //  huangDetailVc.menu.hidden = YES;
            _blurImageView.image = image;
            _blurImageView.image= [self blurryImage:_blurImageView.image withBlurLevel:0.2];
        }
    } completion:^(BOOL finished) {
        isOpen = show;
        if(!isOpen){
            //   huangDetailVc.menu.hidden = NO;
            // _sender.navigationController.navigationBar.hidden = NO;
            _blurImageView.alpha = 0;
            _blurImageView.image = nil;
            
        }
        
    }];
    
    
    
}


-(void)switchMenu{
    [self show:!isOpen];
}
-(void)show{
    [self show:YES];
}

-(void)hide {
    
    [self show:NO];
    if ([self.delegate respondsToSelector:@selector(hideSetting)]) {
        [self.delegate hideSetting];
    }
}


#pragma mark - shot
- (UIImage *)imageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma mark - Blur


- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if ((blur < 0.0f) || (blur > 1.0f)) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end
