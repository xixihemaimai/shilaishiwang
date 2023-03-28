//
//  RSStorehouseDetailsViewController.h
//  石来石往
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
@interface RSStorehouseDetailsViewController : RSAllViewController

/**当前登录者*/
@property (nonatomic,strong)RSUserModel * usermodel;

/**服务者的ID*/
@property (nonatomic,strong)NSString * serviceId;
/**服务类型*/
@property (nonatomic,strong)NSString * type;

/**标识*/
@property (nonatomic,strong)NSString * search;

//服务人员 服务状态
@property (nonatomic,strong)NSString * status;


@end
