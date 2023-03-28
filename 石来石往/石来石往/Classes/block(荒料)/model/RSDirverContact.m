//
//  RSDirverContact.m
//  石来石往
//
//  Created by mac on 17/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDirverContact.h"

@implementation RSDirverContact

// 提供快速创建对象的类方法
//+ (instancetype)contactWithDriverName:(NSString *)name andaphonNumber:(NSString *)phoneNumbebr andIdentity:(NSString *)identity andCarCord:(NSString *)carCord{
//    RSDirverContact *contact = [[RSDirverContact alloc] init];
//    contact.driverName = name;
//    contact.phoneNumber = phoneNumbebr;
//    contact.identity = identity;
//    contact.carCord = carCord;
//    return contact;
//}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"driverID" : @"id"
             };
}


@end
