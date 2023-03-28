//
//  RSTypeModel.h
//  石来石往
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTypeModel : NSObject
//"code":"",
//"createTime":"2019-03-27 22:20:31",
//"createUser":8,
//"id":1,
//"name":"白色",
//"status":1,
//"updateTime":"2019-03-27 22:20:31",
//"updateUser":8


@property (nonatomic,strong)NSString * code;

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * name;


@property (nonatomic,strong)NSString * updateTime;

@property (nonatomic,assign)NSInteger createUser;


@property (nonatomic,assign)NSInteger status;

@property (nonatomic,assign)NSInteger updateUser;

//WareHouseID
@property (nonatomic,assign)NSInteger TypeID;








@end

NS_ASSUME_NONNULL_END
