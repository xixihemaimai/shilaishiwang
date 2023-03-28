//
//  RSTaoBaoShopManagementCell.h
//  石来石往
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTaoBaoMangementModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTaoBaoShopManagementCell : UITableViewCell

@property (nonatomic,strong)RSTaoBaoMangementModel * taobaomanagementmodel;

@property (nonatomic,strong) UIButton * noShelfBtn;
@property (nonatomic,strong) UIButton * editBtn;
@property (nonatomic,strong) UIButton * deleteBtn;



@end

NS_ASSUME_NONNULL_END
