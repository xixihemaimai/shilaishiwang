//
//  RSShopCarCell.h
//  石来石往
//
//  Created by mac on 17/5/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RSShopCarCellDelegate <NSObject>

- (void)removeDetailTableviewCell:(NSInteger )tag;

@end


@class RSBlockModel;
@interface RSShopCarCell : UITableViewCell




/**规格*/
@property (nonatomic,strong)UILabel * psLabel;
/**名称*/
@property (nonatomic,strong)UILabel *productLabel;

/**荒料号*/
@property (nonatomic,strong)UILabel * numberlabel;
/**删除按键*/
@property (nonatomic,strong)UIButton *removeBtn;

@property (nonatomic,strong)RSBlockModel *blockmodel;

/**体积*/
@property (nonatomic,strong) UILabel * tiDetailLabel;

@property (nonatomic,weak)id<RSShopCarCellDelegate>delegate;
@end
