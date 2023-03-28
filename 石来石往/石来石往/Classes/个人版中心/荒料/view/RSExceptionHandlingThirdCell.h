//
//  RSExceptionHandlingThirdCell.h
//  石来石往
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSStoragemanagementModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSExceptionHandlingThirdCell : UITableViewCell

@property (nonatomic,strong)RSStoragemanagementModel * storagemanagementmodel;

@property (nonatomic,strong)UIButton * productEidtBtn;

@property (nonatomic,strong)UIButton * productDeleteBtn;

@end

NS_ASSUME_NONNULL_END
