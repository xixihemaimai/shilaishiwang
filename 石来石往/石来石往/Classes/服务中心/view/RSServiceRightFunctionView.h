//
//  RSServiceRightFunctionView.h
//  石来石往
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSServiceRightFunctionView : UIView


{
    BOOL isOpen;
    UITapGestureRecognizer *_tap;
    //    UISwipeGestureRecognizer *_leftSwipe, *_rightSwipe;
    
    
    UIViewController *_sender;
    
}
@property (nonatomic,strong)UITapGestureRecognizer * lefttap;
@property (nonatomic,strong)UIImageView *blurImageView;
@property (nonatomic,strong)UIView *contentView;
- (instancetype)initWithSender:(UIViewController*)sender;
-(void)show;
-(void)hide;
-(void)switchMenu;
-(void)setContentView:(UIView*)contentView;


-(void)show:(BOOL)show;



@end
