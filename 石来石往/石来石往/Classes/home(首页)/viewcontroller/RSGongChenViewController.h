//
//  RSGongChenViewController.h
//  石来石往
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSGongChenViewController : RSAllViewController

@property (nonatomic, copy) NSString *cellTitle;
//@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RSUserModel * usermodel;
/**要的上半部分的接口的参数*/
@property (nonatomic,strong)NSString * erpCodeStr;


/**要的上半部分的接口参数*/
@property (nonatomic,strong)NSString * userIDStr;

/**朋友圈的数据*/
@property (nonatomic,strong)NSString * creat_userIDStr;

//- (void)addTableViewRefresh;

@end

NS_ASSUME_NONNULL_END
