//
//  RSExceptionHandlingSecondDetailCell.h
//  石来石往
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSStoragemanagementModel.h"
//#import "RSSelectiveInventoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSExceptionHandlingSecondDetailCell : UITableViewCell

@property (nonatomic,strong)UIButton * productDeleteBtn;

@property (nonatomic,strong) UIButton * productEidtBtn;

@property (nonatomic,strong)RSStoragemanagementModel * storagemaanagementmodel;

//@property (nonatomic,strong)RSSelectiveInventoryModel * selectiveInventorymodel;

@end

NS_ASSUME_NONNULL_END
