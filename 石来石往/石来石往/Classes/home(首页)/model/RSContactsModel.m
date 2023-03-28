//
//  RSContactsModel.m
//  石来石往
//
//  Created by mac on 2019/1/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSContactsModel.h"

@implementation RSContactsModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ContactsId" : @"ID"
             };
}

@end
