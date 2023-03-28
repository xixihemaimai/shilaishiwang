//
//  RSRecordViewController.h
//  石来石往
//
//  Created by mac on 17/7/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSShipmentModel.h"
@interface RSRecordViewController : UITableViewController


- (YJTopicType)type;




//获取网络的数据
- (void)getNetWorkData;


- (RSUserModel *)usermodel;

@end
