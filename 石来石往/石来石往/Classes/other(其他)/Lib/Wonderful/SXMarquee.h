//
//  SXMarquee.h
//  Wonderful
//
//  Created by dongshangxian on 15/11/5.
//  Copyright © 2015年 Sankuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SXMarqueeSpeedLevel) {
    SXMarqueeSpeedLevelFast = 2,
    SXMarqueeSpeedLevelMediumFast = 4,
    SXMarqueeSpeedLevelMediumSlow = 6,
    SXMarqueeSpeedLevelSlow = 8,
};

@interface SXMarquee : UIView

/**
 *  style is default, backgroundColor is white,textColor is black;
 *
 *  @param speed you can set 2,4,6,8.  smaller is faster
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame speed:(SXMarqueeSpeedLevel)speed Msg:(NSString *)msg ;
/**
  * 信息
  *
  *
  */
@property(nonatomic,copy)NSString *msg;



/**
  *
  * 速度
  */
@property(nonatomic,assign)SXMarqueeSpeedLevel speedLevel;
/**
 *  style is diy, backgroundColor and textColor can config
 *
 *  @param speed  you can set 2,4,6,8.  smaller is faster
 *  @param bgColor  backgroundColor
 *  @param txtColor textColor
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame speed:(SXMarqueeSpeedLevel)speed Msg:(NSString *)msg bgColor:(UIColor *)bgColor txtColor:(UIColor *)txtColor;

/**
 *  you can change the tapAction show or jump, without this method default is tap to stop
 *
 *  @param action tapAction block code
 */
- (void)changeTapMarqueeAction:(void(^)())action;

/**
 *  you can change marqueeLabel 's font before start
 *
 */
- (void)changeMarqueeLabelFont:(UIFont *)font;

/**
 *  when you set everything what you want,you can use this method to begin animate
 */
- (void)start;

/**
 *  pause
 */
- (void)stop;

/**
 *  will start with the point we stoped.
 */
- (void)restart;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
