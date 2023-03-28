//
//  RSRecordDetailViewController.h
//  石来石往
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RSShipmentModel.h"

#import "RSUserModel.h"

@interface RSRecordDetailViewController : RSAllViewController

/**订单信息*/
@property (nonatomic,strong)NSString * outBoundNo;


@property (nonatomic,strong)RSUserModel * usermodel;

//显示是否提醒用户撤销的状态
@property (nonatomic,strong)NSString * cancelStatus;

@end
