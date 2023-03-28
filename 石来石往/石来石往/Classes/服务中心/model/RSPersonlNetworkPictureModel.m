//
//  RSPersonlNetworkPictureModel.m
//  石来石往
//
//  Created by mac on 2018/3/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPersonlNetworkPictureModel.h"

@implementation RSPersonlNetworkPictureModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"imageId" : @"id"
             };
}
@end
