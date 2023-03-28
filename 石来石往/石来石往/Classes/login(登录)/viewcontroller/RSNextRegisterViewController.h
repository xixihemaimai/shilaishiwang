//
//  RSNextRegisterViewController.h
//  石来石往
//
//  Created by mac on 17/5/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RSRegisterModel;


//@protocol RSNextRegisterViewControllerDelegate <NSObject>
//
//- (void)sendUserCode:(NSString *)code andPassword:(NSString *)password;
//
//@end

@interface RSNextRegisterViewController : RSAllViewController

/**用来接收用户的手机号*/
@property (nonatomic,strong)NSString * phoneLabel;

/**注册用户返回的数据*/
@property (nonatomic,strong)RSRegisterModel *registerModel;


//@property (nonatomic,weak)id<RSNextRegisterViewControllerDelegate>delegate;

@end
