//
//  RSColorModel.h
//  石来石往
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSColorModel : NSObject
@property (nonatomic,strong)NSString * code;

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * name;


@property (nonatomic,strong)NSString * updateTime;

@property (nonatomic,assign)NSInteger createUser;


@property (nonatomic,assign)NSInteger status;

@property (nonatomic,assign)NSInteger updateUser;

//WareHouseID
@property (nonatomic,assign)NSInteger ColorID;
@end

NS_ASSUME_NONNULL_END
