//
//  RSPermissionsViewController.h
//  权限
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
@interface RSPermissionsViewController : RSAllViewController

@property (nonatomic,strong)RSUserModel * userModel;

@property (nonatomic,strong)void(^selectUser)(RSUserModel * usermodel,NSString * titleStr);

@end
