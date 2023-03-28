//
//  RSSCCompanyModel.m
//  石来石往
//
//  Created by mac on 2021/12/5.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCCompanyModel.h"

@implementation RSSCCompanyModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"sccompanyId" : @"id"
             };
}
@end
