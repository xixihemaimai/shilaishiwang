//
//  RSStockCell.h
//  石来石往
//
//  Created by mac on 17/5/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RSStockCellDelegate <NSObject>

- (void)choiceNeedButton:(UIButton *)btn;

@end

@interface RSStockCell : UITableViewCell

@property (nonatomic,strong)UIView *view;

@property (nonatomic,weak)id<RSStockCellDelegate>delegate;
@end
