//
//  RSWarehouseSecondViewController.h
//  石来石往
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSLeftViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSWarehouseSecondViewController : RSAllViewController
/**是荒料还是大板*/
@property (nonatomic,strong)NSString *WLTYPE;

@property (nonatomic,strong)RSUserModel * userModel;
@end

NS_ASSUME_NONNULL_END
