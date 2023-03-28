//
//  RSCLSelectCenterCell.h
//  石来石往
//
//  Created by mac on 2022/8/17.
//  Copyright © 2022 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSCLSelectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSCLSelectCenterCell : UITableViewCell

@property (nonatomic,strong)RSCLSelectionModel * model;

@property (nonatomic,strong)UIButton * deleteBtn;

@end

NS_ASSUME_NONNULL_END
