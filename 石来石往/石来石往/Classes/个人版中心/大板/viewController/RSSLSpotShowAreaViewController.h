//
//  RSSLSpotShowAreaViewController.h
//  石来石往
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSPersonalBaseViewController.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN


@protocol RSSLSpotShowAreaViewControllerDelegate <NSObject>

- (void)showSLBlockNoNewData;

@end


@interface RSSLSpotShowAreaViewController : UIViewController

/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;

/**选择要处理的类型*/
@property (nonatomic,strong)NSString * selectType;


@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)NSMutableDictionary * BLSpotDict;

@property (nonatomic,strong)NSString * type;
/**选中的数组*/
@property (nonatomic,strong)NSMutableArray * selectArray;

@property (nonatomic,strong)UIButton * allBtn;

/**全选的状态*/
@property (nonatomic,assign)BOOL isAllSelect;

/**反选的状态*/
@property (nonatomic,assign)BOOL isReSelect;

@property (nonatomic,weak)id<RSSLSpotShowAreaViewControllerDelegate>delegate;


- (void)reloadSLSpotNewData;
@end

NS_ASSUME_NONNULL_END
