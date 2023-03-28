//
//  RSHistoryFeedBackListModel.m
//  石来石往
//
//  Created by mac on 2022/9/16.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSHistoryFeedBackListModel.h"

@implementation RSHistoryFeedBackListModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"historyId" : @"id"
             };
}


+ (NSDictionary *)mj_objectClassInArray {
    
// 表明你products数组存放的将是FKGoodsModelInOrder类的模型
    return @{
             @"imageList" : @"RSImageListModel",
             };
}


- (NSMutableArray *)imageList{
    if (!_imageList){
        _imageList = [NSMutableArray array];
    }
    return _imageList;
}


@end
