//
//  RSEntryAndExitModel.h
//  石来石往
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSEntryAndExitModel : NSObject

@property (nonatomic,strong)NSDecimalNumber * area;
@property (nonatomic,strong)NSString * blockNo;
@property (nonatomic,assign)NSInteger mtlId;
@property (nonatomic,strong)NSString * mtlName;
@property (nonatomic,assign)NSInteger qty;
@property (nonatomic,assign)NSInteger turnsQty;

@property (nonatomic,strong)NSString * whsName;
@property (nonatomic,assign)NSInteger whsId;

@end

NS_ASSUME_NONNULL_END
