//
//  RSSecondProcessModel.h
//  石来石往
//
//  Created by mac on 2019/7/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSecondProcessModel : NSObject


/**

 billdtlid = 854967;
 createTime = "2019-07-01 13:05:49";
 createUser = 190;
 id = 3;
  amount = 1;
 money = 1;
 name = 555;
 price = 1;
 */
@property (nonatomic,strong)NSDecimalNumber * money;
@property (nonatomic,strong)NSDecimalNumber * price;
@property (nonatomic,strong)NSDecimalNumber * amount;

@property (nonatomic,assign)NSInteger billdtlid;

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * createUser;

@property (nonatomic,assign)NSInteger processId;

@property (nonatomic,strong)NSString * name;


@end

NS_ASSUME_NONNULL_END
