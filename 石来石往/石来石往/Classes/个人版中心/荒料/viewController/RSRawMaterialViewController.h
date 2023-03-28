//
//  RSRawMaterialViewController.h
//  石来石往
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSPersonalBaseViewController.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSRawMaterialViewController : RSPersonalBaseViewController

@property (nonatomic,strong)NSString * selectFunctionType;

@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,assign)NSInteger searchTypeIndex;

@end

NS_ASSUME_NONNULL_END
