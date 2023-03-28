//
//  ThirdTableViewController.h
//  TableViewFloat
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 singularity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentClassScrollViewController.h"
#import "RSUserModel.h"
#import "RSMachiningOutModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ThirdTableViewController : ParentClassScrollViewController
@property (nonatomic,strong)RSUserModel * usermodel;
@property (nonatomic,assign)NSInteger billdtlid;
@property (nonatomic,strong)RSMachiningOutModel * machiningoutmodel;
@end

NS_ASSUME_NONNULL_END
