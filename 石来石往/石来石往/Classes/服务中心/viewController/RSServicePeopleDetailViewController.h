//
//  RSServicePeopleDetailViewController.h
//  石来石往
//
//  Created by mac on 2018/4/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSUserModel.h"
@interface RSServicePeopleDetailViewController : RSAllViewController

/**登录者的信息*/
@property (nonatomic,strong)RSUserModel * usermodel;

/**类型*/
@property (nonatomic,strong)NSString * type;

/**服务者的ID*/
@property (nonatomic,strong)NSString * serviceId;



@end
