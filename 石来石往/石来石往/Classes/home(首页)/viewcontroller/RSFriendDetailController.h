//
//  RSFriendDetailController.h
//  石来石往
//
//  Created by rsxx on 2017/9/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "LXActivity.h"

/**视频*/
#import <Masonry.h>
#import "Moment.h"
#import "Comment.h"


@protocol RSFriendDetailControllerDelegate <NSObject>


- (void)replaceMoment:(Moment *)moment andIndex:(NSInteger)index andType:(NSString *)type;

@end


@interface RSFriendDetailController : RSAllViewController<LXActivityDelegate>

//位置信息
@property (nonatomic,assign)NSInteger index;


/**用户的信息*/
@property (nonatomic,strong)RSUserModel * userModel;

/**是石圈还是关注*/
@property (nonatomic,strong)NSString * titleStyle;


@property (nonatomic,strong)NSString * friendID;


/**选择是全部，还是其他的类型*/
@property (nonatomic,strong)NSString * selectStr;


@property (nonatomic,weak)id<RSFriendDetailControllerDelegate>delegate;

@end
