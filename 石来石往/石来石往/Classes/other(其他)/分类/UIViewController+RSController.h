//
//  UIViewController+RSController.h
//  石来石往
//
//  Created by mac on 2021/10/31.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (RSController)

/**
 跳转到第三方地图APP
 */
-(void)navigationLocationTitle:(NSString *)title latitudeText:(NSString *)latitude longitudeText:(NSString *)longitude;

#pragma mark 字符串高度
- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font;
#pragma mark 计算标签的宽度
- (CGFloat)getWidthLineWithString:(NSString *)string andFont:(float)sizefont;
#pragma mark 改变字符串中具体某字符串的颜色
- (void)messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize;


@end

NS_ASSUME_NONNULL_END
