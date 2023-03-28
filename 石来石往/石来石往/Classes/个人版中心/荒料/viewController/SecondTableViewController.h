//
//  SecondTableViewController.h
//  TableViewFloat
//
//  Created by 李雪阳 on 2018/8/28.
//  Copyright © 2018年 singularity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "ParentClassScrollViewController.h"
#import "RSMachiningOutModel.h"
@interface SecondTableViewController : ParentClassScrollViewController
@property (nonatomic,strong)RSUserModel * usermodel;
@property (nonatomic,assign)NSInteger billdtlid;
@property (nonatomic,strong)RSMachiningOutModel * machiningoutmodel;
@end
