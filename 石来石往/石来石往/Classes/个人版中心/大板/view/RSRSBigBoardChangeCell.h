//
//  RSRSBigBoardChangeCell.h
//  石来石往
//
//  Created by mac on 2019/3/6.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSRSBigBoardChangeCell : UITableViewCell

//长的值
@property (nonatomic,strong)UITextField * longDetailLabel;

//宽的值
@property (nonatomic,strong)UITextField * wideDetialLabel;
//厚的值
@property (nonatomic,strong)UITextField * thickDeitalLabel;

//原生面积的值
@property (nonatomic,strong)UITextField * originalAreaDetailLabel;

//扣尺面积的值
@property (nonatomic,strong)UITextField * deductionAreaDetailLabel;

//实际面积的值
@property (nonatomic,strong)UITextField * actualAreaDetailLabel;

//片号
@property (nonatomic,strong) UITextField * filmNumberTextfield;

@end

NS_ASSUME_NONNULL_END
