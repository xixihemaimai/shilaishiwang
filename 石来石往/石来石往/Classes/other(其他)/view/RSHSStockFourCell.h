//
//  RSHSStockFourCell.h
//  石来石往
//
//  Created by mac on 2019/1/31.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RSHSStockFourCellDelegate <NSObject>

- (void)jumpCompanyMainWebViewWithIndex:(NSInteger)index;

@end

@interface RSHSStockFourCell : UITableViewCell
@property (nonatomic,strong)NSArray * array;
@property (nonatomic,weak)id<RSHSStockFourCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
