//
//  RSCargoEngineeringViewController.h
//  石来石往
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
@interface RSCargoEngineeringViewController : UIViewController
@property (nonatomic, copy) NSString *cellTitle;

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) RSUserModel * usermodel;


/**要的上半部分的接口的参数*/
@property (nonatomic,strong)NSString * erpCodeStr;


/**要的上半部分的接口参数*/
@property (nonatomic,strong)NSString * userIDStr;

/**朋友圈的数据*/
@property (nonatomic,strong)NSString * creat_userIDStr;

- (void)addTableViewRefresh;
@end
