//
//  RSMessageModel.m
//  石来石往
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMessageModel.h"

@implementation RSMessageModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"messageID" : @"id"
             };
}
@end
