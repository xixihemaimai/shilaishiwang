//
//  RSNSNotificationMessageViewController.h
//  石来石往
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "RSUserModel.h"


@protocol RSNSNotificationMessageViewControllerDelegate <NSObject>


- (void)messageCount:(NSInteger)selectCount;


@end




@interface RSNSNotificationMessageViewController : RSAllViewController

@property (nonatomic,strong)RSUserModel * userModel;


@property (nonatomic,assign)id<RSNSNotificationMessageViewControllerDelegate>delegate;

@end
