//
//  RSSelectDabanSLModel.h
//  石来石往
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface RSSelectDabanSLModel : NSObject

@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,strong)NSString * mtltypeName;

@property (nonatomic,assign)NSInteger totalQty;

@property (nonatomic,strong)NSDecimalNumber * totalVaQty;

@property (nonatomic,strong)NSString * turnsNo;

@property (nonatomic,strong)NSString * whsName;

@property (nonatomic,strong)NSMutableArray * contentArray;

@end

NS_ASSUME_NONNULL_END
