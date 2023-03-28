//
//  RSTaobaoSearchFunctionScreenView.h
//  石来石往
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol RSTaobaoSearchFunctionScreenViewDelegate <NSObject>

-(void)hideSetting;


@end


@interface RSTaobaoSearchFunctionScreenView : UIView

{
    BOOL isOpen;
    UITapGestureRecognizer *_tap;
    //    UISwipeGestureRecognizer *_leftSwipe, *_rightSwipe;
    
    
    UIViewController *_sender;
    
}
@property (nonatomic,strong)UITapGestureRecognizer * lefttap;
@property (nonatomic,strong)UIImageView *blurImageView;
@property (nonatomic,strong)UIView *contentView;

@property (nonatomic,weak)id<RSTaobaoSearchFunctionScreenViewDelegate>delegate;


- (instancetype)initWithSender:(UIViewController*)sender;
-(void)show;
-(void)hide;
-(void)switchMenu;
-(void)setContentView:(UIView*)contentView;


-(void)show:(BOOL)show;
@end

NS_ASSUME_NONNULL_END
