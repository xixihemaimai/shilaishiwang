//
//  RSTemplateModel.m
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTemplateModel.h"

@implementation RSTemplateModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"tempID" : @"id"
             };
}
@end
