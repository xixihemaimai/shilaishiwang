//
//  RSWarehouseManamentCell.h
//  石来石往
//
//  Created by mac on 2019/2/22.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSWarehouseManamentCell : UITableViewCell

@property (nonatomic,strong)UIButton * editBtn;

@property (nonatomic,strong)UIButton * cancelBtn;

@property (nonatomic,strong)UILabel * warehouseLabel;

@property (nonatomic,strong)UILabel * warehouseTyleLabel;

@property (nonatomic,strong)UIImageView * warehouseImageView;
@end

NS_ASSUME_NONNULL_END
