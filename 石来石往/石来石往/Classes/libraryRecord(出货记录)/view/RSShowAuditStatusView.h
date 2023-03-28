//
//  RSShowAuditStatusView.h
//  石来石往
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSAuditStatusLabelView.h"

@interface RSShowAuditStatusView : UIView

@property (nonatomic,strong)RSAuditStatusLabelView * auditStatusLabelview;


@property (nonatomic,strong)UIView * centerView;


@property (nonatomic,strong)UILabel * secondLabel;


@property (nonatomic,strong)UILabel * firstLabel;

@property (nonatomic,strong)UILabel * thirdLabel;

@property (nonatomic,strong) UIView * firstView;

@property (nonatomic,strong)UIView * secondView;


@property (nonatomic,strong) UIView * thirdView;

@end

