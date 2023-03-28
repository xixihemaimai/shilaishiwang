//
//  RSBLAllSelectSegmentViewController.h
//  石来石往
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSReportFormMenuView.h"
#import "RSReportFormView.h"
#import "RSUserModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface RSBLAllSelectSegmentViewController : UIViewController
/**选择要做的功能*/
@property (nonatomic,strong)NSString * selectFunctionType;

/**选择要处理的类型*/
@property (nonatomic,strong)NSString * selectType;

@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)NSMutableDictionary * BLSpotDict;



@end

NS_ASSUME_NONNULL_END
