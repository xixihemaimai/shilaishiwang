//
//  RSNoticeCell.h
//  石来石往
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSMessageModel.h"

@interface RSNoticeCell : UITableViewCell


@property (nonatomic,strong)RSMessageModel * messagemodel;

@property (nonatomic,strong) UILabel * noticeStyle;

@end
