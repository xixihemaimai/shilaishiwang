//
//  RSApplyListModel.m
//  石来石往
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSApplyListModel.h"

@implementation RSApplyListModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"applyID" : @"id"
             };
}

@end
