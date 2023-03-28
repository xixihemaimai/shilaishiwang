//
//  RSRunningAccountOpenCell.h
//  石来石往
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSRunningAccountBaseCell.h"
#import "RSBalanceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSRunningAccountOpenCell : RSRunningAccountBaseCell
//- (void)setView:(NSString *)selectFunctionType;

@property (nonatomic,strong)RSBalanceModel * balancemodel;

@end

NS_ASSUME_NONNULL_END
