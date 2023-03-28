//
//  RSPictureViewController.h
//  石来石往
//
//  Created by mac on 17/6/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSPictureViewController : UIViewController<UIScrollViewDelegate>{
    CGFloat offset;
}


/**标题的文字*/
@property (nonatomic,strong)NSString * titleStr;

/**传过来的类型*/
@property (nonatomic,strong)NSString * mtypeStr;





@property (nonatomic, retain) UIScrollView *imageScrollView;

- (CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center;

@end
