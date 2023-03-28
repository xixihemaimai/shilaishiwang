//
//  RSMessageManageController.h
//  石来石往
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
@interface RSMessageManageController : RSAllViewController

/**用户的信息*/
@property (nonatomic,strong)RSUserModel * userModel;



@property (nonatomic,strong)NSString * titleStr;
@end
