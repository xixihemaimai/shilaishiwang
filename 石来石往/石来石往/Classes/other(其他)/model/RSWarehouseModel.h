//
//  RSWarehouseModel.h
//  石来石往
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSWarehouseModel : NSObject

//"code":"",
//"createTime":"2019-03-27 20:31:59",
//"createUser":8,
//"id":1,
//"name":"2区4号仓库",
//"pwmsUserId":8,
//"status":1,
//"updateTime":"2019-03-27 20:31:59",
//"updateUser":8,
//"whsType":"SL"

@property (nonatomic,strong)NSString * code;

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * name;


@property (nonatomic,strong)NSString * updateTime;

@property (nonatomic,strong)NSString * whstype;

@property (nonatomic,assign)NSInteger createUser;

@property (nonatomic,assign)NSInteger pwmsUserId;


@property (nonatomic,assign)NSInteger status;

@property (nonatomic,assign)NSInteger updateUser;

//WareHouseID
@property (nonatomic,assign)NSInteger WareHouseID;

@end

NS_ASSUME_NONNULL_END
