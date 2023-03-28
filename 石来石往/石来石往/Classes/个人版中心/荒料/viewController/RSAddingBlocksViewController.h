//
//  RSAddingBlocksViewController.h
//  石来石往
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSStoragemanagementModel.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSAddingBlocksViewController : RSPersonalBaseViewController

@property (nonatomic,strong)RSStoragemanagementModel * storagemanagementmodel;

@property (nonatomic,strong)void(^newModel)(RSStoragemanagementModel * storagemanagementmodel,NSString * entryType,NSInteger index,NSString * newreload);

@property (nonatomic,assign)NSInteger index;

@property (nonatomic,strong)NSString * selectType;
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;


//判断是新增还是修改
@property (nonatomic,strong)NSString * entryType;

@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)NSString * newreload;

@end

NS_ASSUME_NONNULL_END
