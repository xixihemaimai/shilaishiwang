//
//  RSRegisterModel.h
//  石来石往
//
//  Created by mac on 17/5/31.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>
@interface RSRegisterModel : NSObject<NSCoding>

/**时间措*/
@property (nonatomic,strong)NSString * DATETIME;
/**用户的USER_CODE*/
@property (nonatomic,strong)NSString * USER_CODE;

/**使用者的VERIFYKEY，相当于TOKEN值*/
@property (nonatomic,strong)NSString * VERIFYKEY;

@end
