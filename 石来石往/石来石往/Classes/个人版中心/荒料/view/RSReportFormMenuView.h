//
//  RSReportFormMenuView.h
//  石来石往
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSReportFormMenuView : UIView


+(instancetype)MenuViewWithDependencyView:(UIView *)dependencyView MenuView:(UIView *)leftmenuView isShowCoverView:(BOOL)isCover;

-(instancetype)initWithDependencyView:(UIView *)dependencyView MenuView:(UIView *)leftmenuView isShowCoverView:(BOOL)isCover;


-(void)show;

-(void)hidenWithoutAnimation;
-(void)hidenWithAnimation;




@end

NS_ASSUME_NONNULL_END
