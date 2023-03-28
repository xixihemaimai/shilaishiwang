//
//  RSSelectCarViewController.h
//  石来石往
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"


@protocol RSSelectCarViewControllerDelegate <NSObject>


@optional
- (void)recaptureNetworkData;

@end



@interface RSSelectCarViewController : RSAllViewController


/**订单信息*/
@property (nonatomic,strong)NSString * outBoundNo;

@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,weak)id<RSSelectCarViewControllerDelegate>delegate;

@end
