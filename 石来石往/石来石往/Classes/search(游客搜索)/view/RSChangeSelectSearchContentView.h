//
//  RSChangeSelectSearchContentView.h
//  石来石往
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RSChangeSelectSearchContentViewDelegate <NSObject>

- (void)selectNeedSearchContent:(NSInteger)tag;

- (void)hideSelectSearchContentView;

@end


@interface RSChangeSelectSearchContentView : UIView


@property (nonatomic,weak)id<RSChangeSelectSearchContentViewDelegate>delegate;


- (void)showMenView;
- (void)hideMenView;

@end

NS_ASSUME_NONNULL_END
