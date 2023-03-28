//
//  HEMenuC.m
//  YHMenu
//
//  Created by Boris on 2018/5/10.
//  Copyright © 2018年 Boris. All rights reserved.
//

#import "HEMenu.h"
#import "MenuView.h"

@interface HEMenu ()

@property (nonatomic, strong) MenuView *menuView;

@end

@implementation HEMenu


+ (HEMenu *) shareManager {
    static HEMenu *menu = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menu = [[HEMenu alloc]init];
    });
    return menu;
}

- (void) showPopMenuSelecteWithFrameWidth:(CGFloat)width
                                   height:(CGFloat)height
                                    point:(CGPoint)point
                                     item:(NSArray *)item
                                imgSource:(NSArray *)imgSource
                                   andText:(NSString *)text
                                   andSelectType:(NSString *)selectType
                                   andWhsId:(NSInteger)whsId
                                   action:(void (^)(NSInteger index))action hideBlock:(void(^)(BOOL ishide))hideBlock{
    __weak __typeof(&*self)weakSelf = self;
    if (self.menuView != nil) {
        hideBlock(YES);
        [weakSelf hideMenu];
    }
    hideBlock(NO);
    UIWindow * window = [UIApplication sharedApplication].keyWindow;

    self.menuView = [[MenuView alloc]initWithFrame:window.bounds
                                         menuWidth:width height:height point:point items:item imgSource:imgSource andText:text andSelectType:selectType
                                             andWhsId:whsId
                                            action:^(NSInteger index) {
                                             action(index);
                                             [weakSelf hideMenu];
                                         }];
    _menuView.touchBlock = ^{
        [weakSelf hideMenu];
        hideBlock(YES);
    };
    
   // self.menuView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    self.menuView.backgroundColor = [UIColor clearColor];
    [window addSubview:self.menuView];

    
    
}

- (void) hideMenu {
        [self.menuView removeFromSuperview];
        self.menuView = nil;
}



@end
