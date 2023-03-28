//
//  RSFireworksView.h
//  石来石往
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSFireworksView : UIView
@property (nonatomic, strong) UIImage *particleImage;
@property (nonatomic, assign) CGFloat particleScale;
@property (nonatomic, assign) CGFloat particleScaleRange;
- (void)animate;

@end
