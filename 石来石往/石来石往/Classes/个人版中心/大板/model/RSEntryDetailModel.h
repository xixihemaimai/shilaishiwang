//
//  RSEntryDetailModel.h
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSEntryDetailModel : NSObject
@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,assign)NSInteger mtlId;
@property (nonatomic,assign)NSInteger qty;
@property (nonatomic,strong)NSDecimalNumber * area;

@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,strong)NSString * mtltypeName;
@property (nonatomic,strong)NSString * turnsNo;

@property (nonatomic,strong)NSMutableArray * contentArray;

@end

NS_ASSUME_NONNULL_END
