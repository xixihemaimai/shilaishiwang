//
//  RSTaoBaoVideoAndPictureViewController.h
//  石来石往
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"
#import "RSTaobaoUserModel.h"
#import "RSTaoBaoMangementModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoVideoAndPictureViewController : UIViewController

@property (nonatomic,strong)RSUserModel * usermodel;

/**淘宝用户信息*/
@property (nonatomic,strong) RSTaobaoUserModel *taobaoUsermodel;

@property (nonatomic,strong)RSTaoBaoMangementModel * taobaoManagementmodel;



@end

NS_ASSUME_NONNULL_END
