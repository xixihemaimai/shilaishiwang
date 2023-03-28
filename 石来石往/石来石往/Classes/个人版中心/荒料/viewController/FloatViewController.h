//
//  FloatViewController.h
//  TableViewFloat
//
//  Created by 李雪阳 on 2018/8/28.
//  Copyright © 2018年 singularity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSMachiningOutModel.h"
@interface FloatViewController : UIViewController

@property (nonatomic,strong)RSUserModel * usermodel;

/**出库明细唯一标识    billdtlid*/
@property (nonatomic,assign)NSInteger billdtlid;

@property (nonatomic,strong)RSMachiningOutModel * machiningoutmodel;

@property (nonatomic,strong)void(^machOutReload)();

@end
