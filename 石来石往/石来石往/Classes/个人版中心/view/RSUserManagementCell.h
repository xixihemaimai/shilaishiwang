//
//  RSUserManagementCell.h
//  石来石往
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSUserManagementCell : UITableViewCell

@property (nonatomic,strong)UILabel * nameDetialLabel;

@property (nonatomic,strong)UILabel * typeDetialLabel;
@property (nonatomic,strong)UIButton * editBtn;


@property (nonatomic,strong)UIButton * deleteBtn;

@end

NS_ASSUME_NONNULL_END
