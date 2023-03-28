//
//  RSTaobaoComplaintViewController.h
//  石来石往
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSTaobaoUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSTaobaoComplaintViewController : UIViewController



/**淘宝用户信息*/
@property (nonatomic,strong) RSTaobaoUserModel *taobaoUsermodel;



//商品ID
@property (nonatomic,assign)NSInteger tsUserId;

//商品货物ID
@property (nonatomic,assign)NSInteger productid;


@end

NS_ASSUME_NONNULL_END
