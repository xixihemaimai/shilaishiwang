//
//  RSLocationModel.m
//  石来石往
//
//  Created by mac on 2021/12/5.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSLocationModel.h"

@implementation RSLocationModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"locationId" : @"id"
             };
}
@end
