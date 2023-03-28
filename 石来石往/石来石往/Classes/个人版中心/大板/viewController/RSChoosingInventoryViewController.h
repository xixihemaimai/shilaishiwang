//
//  RSChoosingInventoryViewController.h
//  石来石往
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSWarehouseModel.h"
NS_ASSUME_NONNULL_BEGIN


@protocol RSChoosingInventoryViewControllerDelegate <NSObject>


- (void)dabanChoosingContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray;

@end

@interface RSChoosingInventoryViewController : RSPersonalBaseViewController

@property (nonatomic,strong)NSString * selectType;
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;

@property (nonatomic,strong)NSString * currentTitle;

@property (nonatomic,strong)RSUserModel * usermodel;



@property (nonatomic,strong)NSString * dateTo;
//大板调拨
@property (nonatomic,strong)NSString * whsName;

@property (nonatomic,assign)NSInteger whsIn;
@property (nonatomic,strong)NSString * whstype;


//这边只有荒料出库才有，仓库的值
//选择的仓库
@property (nonatomic,strong)RSWarehouseModel * warehousemodel;

//选择的cell的数组
@property (nonatomic,strong)NSMutableArray * selectdeContentArray;

//代理
@property (nonatomic,weak)id<RSChoosingInventoryViewControllerDelegate>delegate;

/**异常处理*/
//@property (nonatomic,strong)void(^select)(NSString * selectType,NSString * selectFunctionType,NSString * currentTitle,NSMutableArray * selectArray);

/**其他的类型*/
//@property (nonatomic,strong)void(^selectTwo)(NSString * selectType,NSString * selectFunctionType,NSMutableArray * selectArray);

@end

NS_ASSUME_NONNULL_END
