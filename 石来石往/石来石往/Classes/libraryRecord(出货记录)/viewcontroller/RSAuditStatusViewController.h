//
//  RSAuditStatusViewController.h
//  石来石往
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSUserModel.h"

@interface RSAuditStatusViewController : RSAllViewController

/**订单信息*/
@property (nonatomic,strong)NSString * outBoundNo;


@property (nonatomic,strong)RSUserModel * usermodel;
@end
