//
//  RSSelectiveInventoryViewController.h
//  石来石往
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSWarehouseModel.h"


@protocol RSSelectiveInventoryViewControllerDelegate <NSObject>


- (void)selectContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray;

@end


NS_ASSUME_NONNULL_BEGIN

@interface RSSelectiveInventoryViewController : RSPersonalBaseViewController

@property (nonatomic,strong)NSString * selectType;
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;

@property (nonatomic,strong)RSUserModel * usermodel;


//这边只有荒料出库才有，仓库的值
//选择的仓库
@property (nonatomic,strong)RSWarehouseModel * warehousemodel;
/**异常处理选择的按键*/
@property (nonatomic,strong)NSString * currentTitle;
/**选中的数组*/
@property (nonatomic,strong)NSMutableArray * selectionArray;
/**有多料库存*/
@property (nonatomic,strong)NSMutableArray * selectiveArray;
/**选择的时间*/
@property (nonatomic,strong)NSString * dateTo;

@property (nonatomic,weak)id<RSSelectiveInventoryViewControllerDelegate>delegate;

//荒料调拨
@property (nonatomic,strong)NSString * whsName;
@property (nonatomic,assign)NSInteger whsIn;
@property (nonatomic,strong)NSString * whstype;


/**异常处理*/
@property (nonatomic,strong)void(^select)(NSString * selectType,NSString * selectFunctionType,NSString * currentTitle,NSMutableArray * selectArray);

/**其他的类型*/
@property (nonatomic,strong)void(^selectTwo)(NSString * selectType,NSString * selectFunctionType,NSArray * selectArray);

@end

NS_ASSUME_NONNULL_END
