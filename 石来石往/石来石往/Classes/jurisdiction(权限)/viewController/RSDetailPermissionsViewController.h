//
//  RSDetailPermissionsViewController.h
//  权限
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPermissionsModel.h"
#import "RSUserModel.h"

#import "RSAllViewController.h"


//@protocol RSDetailPermissionsViewControllerDelegate <NSObject>
//
//- (void)saveModelData:(RSPermissionsModel *)perModel;
//
//- (void)deletchModelData:(RSPermissionsModel *)perModel;
//
//- (void)ModifyModeData:(RSPermissionsModel *)perModel;
//
//@end




@interface RSDetailPermissionsViewController : RSAllViewController


//@property (nonatomic,weak)id<RSDetailPermissionsViewControllerDelegate>delegate;



/**模型*/
@property (nonatomic,strong)RSPermissionsModel * perModel;

@property (nonatomic,strong)RSUserModel * userModel;


@end
