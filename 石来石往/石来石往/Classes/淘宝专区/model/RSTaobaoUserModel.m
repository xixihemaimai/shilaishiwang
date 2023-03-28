//
//  RSTaobaoUserModel.m
//  石来石往
//
//  Created by mac on 2019/9/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaobaoUserModel.h"

@implementation RSTaobaoUserModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"taoBaoUserID" : @"id"
             };
}

@end
