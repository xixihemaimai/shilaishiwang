//
//  RSPersonalPackageViewController.h
//  石来石往
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSApplyListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSPersonalPackageViewController : UIViewController
@property (nonatomic,strong)RSUserModel * usermodel;

//这边要写一个值是新建还是修改,new是新建，modify是修改
@property (nonatomic,strong)NSString * ModifyStr;

@property (nonatomic,strong)RSApplyListModel * applylistmodel;

@property (nonatomic,strong)void(^reload)(BOOL isreload);


@end

NS_ASSUME_NONNULL_END
