//
//  RSExceptionFootView.h
//  石来石往
//
//  Created by mac on 2019/4/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSStoragemanagementModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSExceptionFootView : UIView

@property (nonatomic,strong)UIButton * productEidtBtn;

@property (nonatomic,strong)UIButton * productDeleteBtn;

@property (nonatomic,strong)RSStoragemanagementModel * storagemanagementmodel;

@end

NS_ASSUME_NONNULL_END
