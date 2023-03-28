//
//  RSSCCompanyHeaderModel.m
//  石来石往
//
//  Created by mac on 2021/12/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCCompanyHeaderModel.h"

@implementation RSSCCompanyHeaderModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"companyHeaderId" : @"id"
             };
}


- (NSMutableArray *)enterpriseManList{
    if (!_enterpriseManList) {
        _enterpriseManList = [NSMutableArray array];
    }
    return _enterpriseManList;
}

- (NSMutableArray *)enterpriseStoreList{
    if (!_enterpriseStoreList) {
        _enterpriseStoreList = [NSMutableArray array];
    }
    return _enterpriseStoreList;
}

@end
