//
//  RSDispatchPersonDataModel.m
//  石来石往
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSDispatchPersonDataModel.h"

@implementation RSDispatchPersonDataModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"dispatchPersonlId" : @"id"
             };
}

@end
