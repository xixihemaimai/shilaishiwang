//
//  RSBigBoardChangeViewController.h
//  石来石往
//
//  Created by mac on 2019/3/6.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSChoosingInventoryModel.h"
//#import "RSChoosingSliceModel.h"
#import "RSSLStoragemanagementModel.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSBigBoardChangeViewController : RSPersonalBaseViewController

@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)NSString * currentTitle;

/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;


@property (nonatomic,strong)NSString * selectType;

//@property (nonatomic,strong)RSChoosingInventoryModel * choosingInventorymodel;
//确定是那个位置的模型
@property (nonatomic,assign)NSInteger index;


@property (nonatomic,strong)NSMutableArray * contentArray;

//做俩个block
//1.恢复
@property (nonatomic,strong)void(^recoveryData)(NSInteger index,RSChoosingInventoryModel * choosingInventorymodel,NSString * currentTitle);

//2.保存
@property (nonatomic,strong)void(^saveData)(NSInteger index,RSChoosingInventoryModel * choosingInventorymodel,NSString * currentTitle);



//保存返回的数组
@property (nonatomic,strong)void(^newSaveData)(NSMutableArray * contentArray,NSInteger index);




@end

NS_ASSUME_NONNULL_END
