//
//  RSLeftFunctionScreenView.h
//  石来石往
//
//  Created by mac on 2017/7/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol RSLeftFunctionScreenViewDelegate <NSObject>

-(void)hideSetting;


@end


@interface RSLeftFunctionScreenView : UIView

{
    BOOL isOpen;
    UITapGestureRecognizer *_tap;
    //    UISwipeGestureRecognizer *_leftSwipe, *_rightSwipe;
    
    
    UIViewController *_sender;
    
}
@property (nonatomic,strong)UITapGestureRecognizer * lefttap;
@property (nonatomic,strong)UIImageView *blurImageView;
@property (nonatomic,strong)UIView *contentView;

@property (nonatomic,weak)id<RSLeftFunctionScreenViewDelegate>delegate;


- (instancetype)initWithSender:(UIViewController*)sender;
-(void)show;
-(void)hide;
-(void)switchMenu;
-(void)setContentView:(UIView*)contentView;


-(void)show:(BOOL)show;




@end
