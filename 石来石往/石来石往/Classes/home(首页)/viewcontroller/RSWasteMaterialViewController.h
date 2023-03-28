//
//  RSWasteMaterialViewController.h
//  石来石往
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"


@interface RSWasteMaterialViewController : RSAllViewController

/**货主名字*/
@property (nonatomic,strong)NSString * titleNameLabel;


/**是选择荒料还是大板*/
@property (nonatomic,strong)NSString * tyle;

/**网络请求的参数erpCode*/
@property (nonatomic,strong)NSString * erpCodeStr;


/**用户的信息*/
@property (nonatomic,strong)RSUserModel * userModel;


@property (nonatomic,strong)NSString * dataSource;



@end
