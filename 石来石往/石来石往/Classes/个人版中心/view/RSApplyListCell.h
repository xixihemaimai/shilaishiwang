//
//  RSApplyListCell.h
//  石来石往
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSApplyListCell : UITableViewCell


@property (nonatomic,strong)UILabel * nameFirstlabel;


@property (nonatomic,strong) UILabel * companyLabel;

@property (nonatomic,strong) UILabel * statusLabel;

@property (nonatomic,strong)UIButton * statusBtn;

@property (nonatomic,strong)UIButton * cancelApplyBtn;

@end

NS_ASSUME_NONNULL_END
