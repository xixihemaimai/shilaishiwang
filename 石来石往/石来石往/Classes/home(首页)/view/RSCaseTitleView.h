//
//  RSCaseTitleView.h
//  石来石往
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol RSCaseTitleViewDelegate <NSObject>


/**隐藏蒙版*/
- (void)hiddeMenuView;


- (void)sendCaseTitleString:(NSString *)caseTitleStr;





@end



@interface RSCaseTitleView : UIView

@property (nonatomic,strong) UIView * titleView;
@property (nonatomic,strong)UITextField * textfield;

@property (nonatomic,weak)id<RSCaseTitleViewDelegate>delegate;

@end
