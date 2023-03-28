//
//  TSVideoPlayback.h
//  avplayer
//
//  Created by Feng on 2018/7/1.
//  Copyright © 2018年 Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSVideoScreenViewController.h"
#import "RSTaoBaoProductDetailsViewController.h"

@class TSVideoPlayback;
typedef enum : NSUInteger {
    TSDETAILTYPEVIDEO,//视屏
    TSDETAILTYPEIMAGE,//图片
} TSDETAILTYPE;

@protocol TSVideoPlaybackDelegate <NSObject>

//点击图片索引
-(void)videoView:(TSVideoPlayback *)view didSelectItemAtIndexPath:(NSInteger)index andTap:(UITapGestureRecognizer *)tap;

@end

@interface TSVideoPlayback : UIView

@property (nonatomic,weak) id<TSVideoPlaybackDelegate> delegate;
@property (nonatomic,assign) TSDETAILTYPE type;
@property (nonatomic,strong) UIImageView *placeholderImg;//占位图img

/*
 * isVideo  是否带视屏链接
 * array    数据
 */
-(void)setWithIsVideo:(TSDETAILTYPE)type andDataArray:(NSArray *)array;

//清除缓存（必须写）
-(void)clearCache;

@end
