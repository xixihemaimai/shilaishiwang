//
//  RSSLSpotShowCompleteViewController.h
//  石来石往
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RSSLSpotShowCompleteViewControllerDelegate <NSObject>

- (void)cancelSLShowBlockNewData;

@end


@interface RSSLSpotShowCompleteViewController : UIViewController
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;

/**选择要处理的类型*/
@property (nonatomic,strong)NSString * selectType;


@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)NSMutableDictionary * BLSpotDict;


@property (nonatomic,strong)NSString * type;

@property (nonatomic,assign)UIButton * allBtn;
/**选中的数组*/
@property (nonatomic,strong)NSMutableArray * selectArray;

/**全选的状态*/
@property (nonatomic,assign)BOOL isAllSelect;

/**反选的状态*/
@property (nonatomic,assign)BOOL isReSelect;


@property (nonatomic,weak)id<RSSLSpotShowCompleteViewControllerDelegate>delegate;

- (void)reloadSLCompleteSpotNewData;
@end

NS_ASSUME_NONNULL_END
