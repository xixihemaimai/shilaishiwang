//
//  RSSelectCollectionReusableView.h
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RSSelectCollectionReusableView;
@protocol UICollectionReusableViewButtonDelegate<NSObject>
- (void)delectData:(RSSelectCollectionReusableView *)view;
@end


@interface RSSelectCollectionReusableView : UICollectionReusableView


@property (weak,nonatomic) UIButton *delectButton;

@property (weak, nonatomic) id<UICollectionReusableViewButtonDelegate> delectDelegate;

- (void) setText:(NSString*)text;

- (void) setImage:(NSString *)image;



@end
