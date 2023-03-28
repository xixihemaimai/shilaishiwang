//
//  RSDBHandle.h
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSDBHandle : NSObject
/**
 *  根据参数去取数据
 *
 *  
 *
 */
+ (NSDictionary *)statusesWithParams:(NSDictionary *)params;

/**
 *  存储服务器数据到沙盒中
 *
 *  @param statuses 需要存储的数据
 */
+ (void)saveStatuses:(NSDictionary *)statuses andParam:(NSDictionary *)ParamDict;



+ (BOOL)delect:(NSString *)searchModel_idstr;


//+ (void)deleteSearchModelName:(NSArray *)array;

@end
