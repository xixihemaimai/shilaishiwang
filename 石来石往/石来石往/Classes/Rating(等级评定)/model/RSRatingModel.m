//
//  RSRatingModel.m
//  石来石往
//
//  Created by mac on 17/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSRatingModel.h"

@implementation RSRatingModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ratingID" : @"id",@"_description":@"description"
             };
}

@end
