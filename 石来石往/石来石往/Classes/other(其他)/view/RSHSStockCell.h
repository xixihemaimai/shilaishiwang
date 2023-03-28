//
//  RSHSStockCell.h
//  石来石往
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSHotStoneModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RSHSStockCellDelegate <NSObject>

- (void)jumpSearchAndDabanViewControllerIndex:(NSInteger)index;

@end

@interface RSHSStockCell : UITableViewCell

@property (nonatomic,strong)NSArray * array;


@property (nonatomic,weak)id<RSHSStockCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
