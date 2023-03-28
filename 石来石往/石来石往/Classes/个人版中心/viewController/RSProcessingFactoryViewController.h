//
//  RSProcessingFactoryViewController.h
//  石来石往
//
//  Created by mac on 2019/6/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSPersonalBaseViewController.h"
#import "RSUserModel.h"
#import "RSWarehouseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSProcessingFactoryViewController : RSPersonalBaseViewController

@property (nonatomic,strong)RSUserModel * usermodel;


@property (nonatomic,strong)NSString * selectType;
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;

/**选择的内容*/
@property (nonatomic,strong)NSString * selectName;
/**选择加工厂的ID*/
@property (nonatomic,assign)NSInteger selectID;

@property (nonatomic,strong)void(^select)(BOOL isSelect,RSWarehouseModel * warehousemodel);

@end

NS_ASSUME_NONNULL_END
