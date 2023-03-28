//
//  RSSCContentModel.m
//  石来石往
//
//  Created by mac on 2021/12/5.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCContentModel.h"

@implementation RSSCContentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"sccontentId" : @"id"
             };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    //为了解决json字符串先赋值给oc字典后，类型转换crash问题，如:
    //json->oldValue:0
    //model中值为NSString类型
    //如果先将json转为dic，dic中对应value值为NSNumber类型，则向oldValue发送isEqualToString消息会crash
    id tempValue = oldValue;
    if ([property.type.code isEqualToString:@"NSString"]) {
        tempValue = [NSString stringWithFormat:@"%@", tempValue];
        if ([tempValue isKindOfClass:[NSNull class]] || tempValue == nil || [tempValue isEqual:[NSNull null]] ||  [tempValue isEqualToString:@"(null)"] ||  [tempValue isEqualToString:@"(\n)"] ) {
            return @"";
        }
    }
    if ([property.type.code isEqualToString:@"NSNumber"]) {
//        tempValue = [NSNumber numberWithFloat:[tempValue floatValue]];
        if ([tempValue isKindOfClass:[NSNull class]] || tempValue == nil || [tempValue isEqual:[NSNull null]] ||  [tempValue isEqualToString:@"(null)"] ||  [tempValue isEqualToString:@"(\n)"] ) {
            return @0;
        }
    }
    return tempValue;
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
