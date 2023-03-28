//
//  RSSearchSectionModel.h
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSearchSectionModel : NSObject
@property (nonatomic, copy) NSString *section_id;
@property (nonatomic, copy) NSString *section_title;
@property (nonatomic, copy) NSArray *section_contentArray;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
