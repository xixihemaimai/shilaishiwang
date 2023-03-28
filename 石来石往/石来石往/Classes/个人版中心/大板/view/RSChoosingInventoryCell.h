//
//  RSChoosingInventoryCell.h
//  石来石往
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSChoosingInventoryCell : UITableViewCell

@property (nonatomic,strong) UIButton * selectBtn;

@property (nonatomic,strong)UILabel * filmNumberLabel;

@property (nonatomic,strong) UIImageView * iamgeView;

@property (nonatomic,strong)UILabel * longDetailLabel;

@property (nonatomic,strong) UILabel * wideDetialLabel;

@property (nonatomic,strong)UILabel * thickDeitalLabel;

@property (nonatomic,strong) UILabel * originalAreaDetailLabel;

@property (nonatomic,strong)UILabel * deductionAreaDetailLabel;

@property (nonatomic,strong)UILabel * actualAreaDetailLabel;

@property (nonatomic,strong)UIView * blueView ;
@end

NS_ASSUME_NONNULL_END
