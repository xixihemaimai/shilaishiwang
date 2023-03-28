//
//  RSMarketUploadImageModel.m
//  石来石往
//
//  Created by mac on 2022/9/16.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSMarketUploadImageModel.h"

@implementation RSMarketUploadImageModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"operatorId" : @"operator",
             @"uploadImageId" : @"id"
             };
}



@end
