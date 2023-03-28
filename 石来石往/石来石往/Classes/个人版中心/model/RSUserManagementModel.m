//
//  RSUserManagementModel.m
//  石来石往
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSUserManagementModel.h"

@implementation RSUserManagementModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"userManagementID" : @"id"
             };
}

@end
