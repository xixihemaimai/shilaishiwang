//
//  RSWasteMaterialCell.h
//  石来石往
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSMasteMainModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSWasteMaterialCell : UITableViewCell

@property (nonatomic,strong)RSMasteMainModel * masteMainModel;

@property (nonatomic,strong)UILabel * areaLabel;

@property (nonatomic,strong)UILabel * numberLabel;
@end

NS_ASSUME_NONNULL_END
