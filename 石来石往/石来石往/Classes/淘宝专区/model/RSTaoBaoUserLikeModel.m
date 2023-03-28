//
//  RSTaoBaoUserLikeModel.m
//  石来石往
//
//  Created by mac on 2019/9/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoUserLikeModel.h"

@implementation RSTaoBaoUserLikeModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"userLikeID" : @"id"
             };
}

- (NSMutableArray *)imageList{
    if (!_imageList) {
        _imageList = [NSMutableArray array];
    }
  return _imageList;
}
- (NSMutableArray *)stoneDtlList{
    if (!_stoneDtlList) {
        _stoneDtlList = [NSMutableArray array];
    }
    return _stoneDtlList;
}

@end
