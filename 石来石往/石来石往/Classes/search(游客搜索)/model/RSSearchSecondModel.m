//
//  RSSearchSecondModel.m
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSearchSecondModel.h"
#define FAST_DirectoryModel_SET_VALUE_FOR_STRING(dictname,value) dictionary[dictname]!= nil &&dictionary[dictname]!=[NSNull null]? dictionary[dictname] : value;
@implementation RSSearchSecondModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.content_name = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"content_name", @"");
    }
    return self;
}

@end
