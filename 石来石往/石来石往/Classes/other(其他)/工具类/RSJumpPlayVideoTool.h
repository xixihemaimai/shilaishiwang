//
//  RSJumpPlayVideoTool.h
//  石来石往
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RSFriendModel.h"
#import "Moment.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSJumpPlayVideoTool : NSObject

+ (void)canYouSkipThePlaybackVideoInterfaceRSFriendModel:(RSFriendModel *)friendmodel andViewController:(UIViewController *)viewController;
+ (void)canYouSkipThePlaybackVideoInterfaceMoment:(Moment *)moment andViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
