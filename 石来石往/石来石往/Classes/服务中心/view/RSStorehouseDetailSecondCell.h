//
//  RSStorehouseDetailSecondCell.h
//  石来石往
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSStorehouseDetailSecondCell : UITableViewCell

//出货单
@property (nonatomic,strong) UILabel * outNameLabel;

//颗数
@property (nonatomic,strong)UILabel * outNumber;


//预约时间
@property (nonatomic,strong)UILabel * outTimeLabel;


//汽车类型
@property (nonatomic,strong)UILabel * carTypeLabel;

@end
