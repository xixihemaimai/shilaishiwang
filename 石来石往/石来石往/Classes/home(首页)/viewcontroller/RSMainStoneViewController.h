//
//  RSMainStoneViewController.h
//  石来石往
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSMainStoneViewController : UIViewController

@property (nonatomic,strong)RSUserModel * usermodel;


@property (nonatomic,strong)NSString * stoneName;

@property (nonatomic,strong)NSString * companyName;

@property (nonatomic,strong)NSArray * photos;

@property (nonatomic,strong)NSString * erpCode;

@property (nonatomic,strong)NSString * dataSource;


@end

NS_ASSUME_NONNULL_END
