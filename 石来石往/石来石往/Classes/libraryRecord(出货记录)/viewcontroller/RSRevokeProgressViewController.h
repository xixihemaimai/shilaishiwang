//
//  RSRevokeProgressViewController.h
//  石来石往
//
//  Created by mac on 2020/4/1.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSRevokeProgressViewController : UIViewController

/**订单信息*/
@property (nonatomic,strong)NSString * outBoundNo;


@property (nonatomic,strong)void(^cancelStatus)(BOOL isstatius);


@end

NS_ASSUME_NONNULL_END
