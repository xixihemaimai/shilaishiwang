//
//  RSRSDetailsOfChargesFuntionRightView.h
//  石来石往
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSRSDetailsOfChargesFuntionRightView : UIView
{
    //BOOL isOpen;
    UITapGestureRecognizer *_tap;
    //    UISwipeGestureRecognizer *_leftSwipe, *_rightSwipe;
    
    
    UIViewController *_sender;
    
}

@property (nonatomic,assign)BOOL isOpen;

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
