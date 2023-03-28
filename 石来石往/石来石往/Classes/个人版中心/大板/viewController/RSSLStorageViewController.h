//
//  RSSLStorageViewController.h
//  石来石往
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSPersonalBaseViewController.h"
#import "RSUserModel.h"
#import "RSPersonalFunctionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSLStorageViewController : RSPersonalBaseViewController

@property (nonatomic,strong)NSString * selectType;
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;

@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)NSString * selectShow;

@property (nonatomic,strong)RSPersonalFunctionModel * personalFunctionmodel;

/**是否是上一个页面传过来的值是new 还是reload*/
@property (nonatomic,strong)NSString * showType;

@property (nonatomic,strong)void(^reload)(BOOL isreload);

@end

NS_ASSUME_NONNULL_END
