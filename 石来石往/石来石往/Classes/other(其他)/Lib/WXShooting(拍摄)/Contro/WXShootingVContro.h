//
//  WXShootingVContro.h
//  WeChart
//
//  Created by lk06 on 2018/4/26.
//  Copyright © 2018年 lk06. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"


@protocol WXShootingVControDelegate <NSObject>

- (void)sendUrl:(NSURL *)url;

@end


@interface WXShootingVContro : UIViewController

@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,weak)id<WXShootingVControDelegate>delegate;

@end
