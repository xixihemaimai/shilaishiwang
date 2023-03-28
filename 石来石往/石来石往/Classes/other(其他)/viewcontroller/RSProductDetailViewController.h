//
//  RSProductDetailViewController.h
//  石来石往
//
//  Created by mac on 2017/8/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"

@interface RSProductDetailViewController : RSAllViewController

/**产品名称*/
@property (nonatomic,strong)NSString * productNameLabel;

/**是荒料还是大板*/
@property (nonatomic,strong)NSString *WLTYPE;


/**用户的信息*/
@property (nonatomic,strong)RSUserModel * userModel;
@end
