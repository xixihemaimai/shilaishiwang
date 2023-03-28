//
//  RSAlterationOfWasteMaterialViewController.h
//  石来石往
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSStoragemanagementModel.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RSAlterationOfWasteMaterialViewControllerDelegate <NSObject>

- (void)passValueIndexpath:(NSInteger)index andRSStoragemanagementModel:(RSStoragemanagementModel *)storagemanagementmodel andCurrentTitle:(NSString *)currentTitle;


@end




@interface RSAlterationOfWasteMaterialViewController : RSPersonalBaseViewController

@property (nonatomic,strong)NSString * currentTitle;

@property (nonatomic,strong)RSStoragemanagementModel * storagemanagementmodel;

@property (nonatomic,strong)RSUserModel * usermodel;


@property (nonatomic,strong)NSString * selectType;
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;


@property (nonatomic,assign)NSInteger index;

@property (nonatomic,weak)id<RSAlterationOfWasteMaterialViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
