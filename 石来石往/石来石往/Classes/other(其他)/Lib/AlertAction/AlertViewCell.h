//
//  AlertViewCell.h
//  GGAlertAction
//
//  Created by 吉祥 on 2017/8/21.
//  Copyright © 2017年 jixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertAction.h"

#import "AlertAction.h"

@interface AlertViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *selectImage;

@property (nonatomic,strong)UILabel * detailTitleLabel;


@property (nonatomic,strong)AlertAction * action;

@end
