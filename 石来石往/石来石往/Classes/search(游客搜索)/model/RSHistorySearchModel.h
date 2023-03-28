//
//  RSHistorySearchModel.h
//  石来石往
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSHistorySearchModel : NSObject

/**
 dataSource = HXSC;
 */

/**搜索出来的内容的值*/
@property (nonatomic,copy)NSString * mtlname;

/**荒料号*/
@property (nonatomic,copy)NSString * type;


@property (nonatomic,copy)NSString * blockId;


@property (nonatomic,copy)NSString * content;

@property (nonatomic,copy)NSString * createTime;

@property (nonatomic,copy)NSString * companyName;

@property (nonatomic,copy)NSString * erpCode;

@property (nonatomic,copy)NSString * friendId;

@property (nonatomic,copy)NSString * imgUrl;

@property (nonatomic,copy)NSString * phone;

@property (nonatomic,copy)NSString * qty;

@property (nonatomic,copy)NSString * stockType;

@property (nonatomic,copy)NSString * stoneId;

@property (nonatomic,copy)NSString * turnsQty;


@property (nonatomic,copy)NSString * vaqty;

@property (nonatomic,copy)NSString * weight;
@property (nonatomic,copy)NSString * dataSource;

@end
