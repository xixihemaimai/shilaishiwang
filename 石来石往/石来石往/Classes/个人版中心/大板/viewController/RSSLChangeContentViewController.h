//
//  RSSLChangeContentViewController.h
//  石来石往
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSPersonalBaseViewController.h"
#import "RSSLStoragemanagementModel.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSLChangeContentViewController : RSPersonalBaseViewController


@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)NSString * currentTitle;

/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;


@property (nonatomic,strong)NSString * selectType;

//确定是那个位置的模型
@property (nonatomic,assign)NSInteger index;


@property (nonatomic,strong)NSMutableArray * contentArray;


//保存返回的数组
@property (nonatomic,strong)void(^newSaveData)(NSMutableArray * contentArray,NSInteger index);



@end

NS_ASSUME_NONNULL_END
