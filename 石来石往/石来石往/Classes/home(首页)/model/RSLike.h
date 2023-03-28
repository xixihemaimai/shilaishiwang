//
//  RSLike.h
//  石来石往
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSLike : NSObject
//"SYS_USER_ID":"3032",
//"USER_NAME":"许新龙",
//"ID":"5399"
@property (nonatomic,strong)NSString * SYS_USER_ID;

@property (nonatomic,strong)NSString * USER_NAME;

@property (nonatomic,strong)NSString * likeID;

@property (nonatomic,strong)NSString * USER_TYPE;

@end

NS_ASSUME_NONNULL_END
