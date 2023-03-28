//
//  SpecialAlertView.m
//  自定义弹框
//
//  Created by Mrjia on 2018/7/4.
//  Copyright © 2018年 Mrjia. All rights reserved.
//
#define ALERTVIEW_HEIGHT [UIScreen mainScreen].bounds.size.height/3
#define ALERTVIEW_WIDTH  [UIScreen mainScreen].bounds.size.width-50
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define MARGIN  20

#import "SpecialAlertView.h"

@interface SpecialAlertView()

@property(nonatomic,strong)UIView *alertView;

@end

@implementation SpecialAlertView


-(instancetype) initWithTitleImage:(NSString *)backImage messageTitle:(NSString *)titleStr messageString:(NSString *)contentStr sureBtnTitle:(NSString *)titleString sureBtnColor:(UIColor *)BtnColor andTag:(NSInteger)tag{

    self = [super init];
    if (self) {

        self.frame = [UIScreen mainScreen].bounds;
        self.alertView = [[UIView alloc]initWithFrame:CGRectMake(44, HEIGHT/2-ALERTVIEW_HEIGHT/2, WIDTH - 88, ALERTVIEW_HEIGHT+40)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius=5.0;
        self.alertView.layer.masksToBounds=YES;
        self.alertView.userInteractionEnabled=YES;
        [self addSubview:self.alertView];

        //if (backImage) {
            UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.alertView.frame.size.width/2)-42.5, 15, 85, 85)];
            titleImage.image = [UIImage imageNamed:backImage];
            [self.alertView addSubview:titleImage];
//        }
//        if (titleStr) {
            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(MARGIN, CGRectGetMaxY(titleImage.frame) + 13, self.alertView.frame.size.width - 40, 30)];
            titleLab.text = titleStr;
            titleLab.font = [UIFont systemFontOfSize:17];
            titleLab.textAlignment = NSTextAlignmentCenter;
            [self.alertView addSubview:titleLab];
//        }
//        if (contentStr) {
            UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(MARGIN, CGRectGetMaxY(titleLab.frame) + 8, self.alertView.frame.size.width - 40, 70)];
            contentLab.text = contentStr;
            contentLab.font = [UIFont systemFontOfSize:15];
            contentLab.numberOfLines = 0;
            contentLab.textAlignment = NSTextAlignmentCenter;
        
            [self.alertView addSubview:contentLab];
//        }
        if (tag == 0) {
            contentLab.textColor = [UIColor lightGrayColor];
        }else{
            contentLab.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            
        }

        
        
        
        
        
        //        if (titleString) {
        UIButton *sureBtn= [[UIButton alloc]init];
        [sureBtn setTitle:titleString forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:BtnColor];
        sureBtn.layer.cornerRadius=3.0;
        sureBtn.layer.masksToBounds=YES;
        [sureBtn addTarget:self action:@selector(SureClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:sureBtn];
        //        }
        if (tag == 0) {
            
            sureBtn.frame = CGRectMake(25, ALERTVIEW_HEIGHT-15, self.alertView.frame.size.width-50, 40);
            [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
            
        }else{
            
            UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(contentLab.frame) - 4, self.alertView.frame.size.width, 1)];
            bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#E5E5E5"];
            [self.alertView addSubview:bottomView];
            
            sureBtn.frame = CGRectMake(25, CGRectGetMaxY(bottomView.frame), self.alertView.frame.size.width-50, 40);
            
            [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FF4B33"] forState:UIControlStateNormal];
            UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cancelBtn setImage:[UIImage imageNamed:@"删除-(3)"] forState:UIControlStateNormal];
            cancelBtn.frame = CGRectMake(self.alertView.frame.size.width - 50, 10, 40, 40);
            [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:cancelBtn];
        }
    }
    [self showAnimation];
    return self;
}

-(void)showAnimation{
    
    self.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);

    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {

    }];
}

-(void)SureClick:(UIButton *)sender{

    if (self.sureClick) {
        self.sureClick(nil);
    }

    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)withSureClick:(sureBlock)block{
    _sureClick = block;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];

}


- (void)cancelAction:(UIButton *)cancelBtn{
//    if (self.sureClick) {
//        self.sureClick(nil);
//    }
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}





@end
