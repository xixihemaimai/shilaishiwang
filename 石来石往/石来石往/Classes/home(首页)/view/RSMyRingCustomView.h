//
//  RSMyRingCustomView.h
//  石来石往
//
//  Created by mac on 2017/8/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RSMyRingCustomViewDelegate <NSObject>

- (void)playSelectVideo:(NSInteger)index;

@end


@interface RSMyRingCustomView : UIView


/**添加图片进去*/
- (void)addPictureAndNSArray:(NSArray * )array andContentStr:(NSString *)contentStr;

//这边是视频的地方
- (void)addVideoURL:(NSString *)cover andViewType:(NSString *)viewType;


@property (nonatomic,weak)id<RSMyRingCustomViewDelegate>delegate;
@end
