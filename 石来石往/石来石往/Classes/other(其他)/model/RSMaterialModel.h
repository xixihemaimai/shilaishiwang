//
//  RSMaterialModel.h
//  石来石往
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSMaterialModel : NSObject

//"code":"",
//"colorId":1,
//"createTime":"2019-03-28 19:06:55",
//"createUser":8,
//"id":3,
//"name":"莎安娜",
//"pwmsUserId":8,
//"status":1,
//"typeId":2,
//"updateTime":"2019-03-28 19:06:55",
//"updateUser":8


@property (nonatomic,strong)NSString * code;

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * name;

@property (nonatomic,strong)NSString * color;

@property (nonatomic,strong)NSString * type;

@property (nonatomic,strong)NSString * updateTime;

@property (nonatomic,assign)NSInteger createUser;

@property (nonatomic,assign)NSInteger pwmsUserId;


@property (nonatomic,assign)NSInteger status;

@property (nonatomic,assign)NSInteger updateUser;

//WareHouseID
@property (nonatomic,assign)NSInteger MAterialID;

//colorId
@property (nonatomic,assign)NSInteger colorId;

//typeid
@property (nonatomic,assign)NSInteger typeId;


@end

NS_ASSUME_NONNULL_END
