//
//  RSSearchSectionModel.m
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSearchSectionModel.h"
#import "RSSearchSecondModel.h"
#define FAST_DirectoryModel_SET_VALUE_FOR_STRING(dictname,value) dictionary[dictname]!= nil &&dictionary[dictname]!=[NSNull null]? dictionary[dictname] : value;

@interface RSSearchSectionModel()
@property (nonatomic, strong)NSMutableArray *content_Array;

@end

@implementation RSSearchSectionModel

-(NSMutableArray *)content_Array
{
    if (_content_Array == nil) {
        _content_Array = [NSMutableArray array];
    }
    return _content_Array;
}
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.section_id = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"section_id", @"0");
        self.section_title = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"section_title", @"");
        NSArray *emp = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"section_content",@[]);
        if (emp.count > 0) {
            for (NSDictionary *content_dict in emp) {
                RSSearchSecondModel *model = [[RSSearchSecondModel alloc] initWithDictionary:content_dict];
                [self.content_Array addObject:model];
            }
            self.section_contentArray = self.content_Array;
        }
    }
    return self;
}
@end
