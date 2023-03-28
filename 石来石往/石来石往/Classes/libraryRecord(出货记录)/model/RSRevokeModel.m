//
//  RSRevokeModel.m
//  石来石往
//
//  Created by mac on 2020/4/1.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSRevokeModel.h"

@implementation RSRevokeModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"revokeId" : @"id"
             };
}
@end
