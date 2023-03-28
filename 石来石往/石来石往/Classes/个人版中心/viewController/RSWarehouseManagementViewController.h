//
//  RSWarehouseManagementViewController.h
//  石来石往
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSWarehouseModel.h"
#import "RSBillHeadModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSWarehouseManagementViewController : RSPersonalBaseViewController

@property (nonatomic,strong)NSString * selectType;
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;


@property (nonatomic,strong)RSUserModel * usermodel;



/**区分调入还是调出*/
@property (nonatomic,strong)NSString * inputAndOutStr;



@property (nonatomic,strong)NSString * selectName;


//这边是库存管理，调拨
@property (nonatomic,strong)NSString * whsName;

@property (nonatomic,strong)NSString * whsInName;




@property (nonatomic,strong)void(^select)(BOOL isSelect,RSWarehouseModel * warehousemodel);

@property (nonatomic,strong)void(^inputAndOutselect)(NSString * inputAndOutStr,RSWarehouseModel * warehousemodel);
@end

NS_ASSUME_NONNULL_END
