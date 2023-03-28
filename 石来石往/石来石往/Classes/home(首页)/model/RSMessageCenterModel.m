//
//  RSMessageCenterModel.m
//  石来石往
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMessageCenterModel.h"

@implementation RSMessageCenterModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"messageCenterID" : @"id"
             };
}
@end
