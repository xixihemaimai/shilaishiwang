//
//  RSFriendView.h
//  石来石往
//
//  Created by mac on 17/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSFriendModel.h"


@protocol RSFriendViewDelegate <NSObject>

- (void)choiceVideoIndex:(NSInteger)index;

@end

@interface RSFriendView : UIView


- (void)addImageArrayAndVideoImageArray:(NSArray *)imageArray andFriendModel:(RSFriendModel *)friendmodel;


/**接收图片数组*/
@property (nonatomic,strong)NSArray * imageArray;


@property (nonatomic,weak)id<RSFriendViewDelegate>delegate;

@end
