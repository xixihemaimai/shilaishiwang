//
//  RSAlreadEvaluationServiceStarView.m
//  石来石往
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAlreadEvaluationServiceStarView.h"

@implementation RSAlreadEvaluationServiceStarView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        UIView * evaluateStarTotalView = [[UIView alloc]init];
        evaluateStarTotalView.backgroundColor =[UIColor whiteColor];
        [self addSubview:evaluateStarTotalView];
        
        
        //服务人员view
        UIView * servicePeopleView = [[UIView alloc]init];
        servicePeopleView.backgroundColor = [UIColor clearColor];
        [evaluateStarTotalView addSubview:servicePeopleView];
        
        
        
        //服务人员的名称，头像
        UIImageView * servicePeopleImageview = [[UIImageView alloc]init];
        [servicePeopleView addSubview:servicePeopleImageview];
        
        _servicePeopleImageview = servicePeopleImageview;
        
        
        
        
        //服务人员的名称
        UILabel * servicePeopleLabel = [[UILabel alloc]init];
        servicePeopleLabel.textAlignment = NSTextAlignmentLeft;
        // servicePeopleLabel.text = @"服务人员";
        servicePeopleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        servicePeopleLabel.font = [UIFont systemFontOfSize:16];
        [servicePeopleView addSubview:servicePeopleLabel];
        _servicePeopleLabel = servicePeopleLabel;
        
        
        //对您的评价
        UILabel * serviceLabel = [[UILabel alloc]init];
        serviceLabel.textAlignment = NSTextAlignmentLeft;
        serviceLabel.text = @"对您的评价";
        serviceLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        serviceLabel.font = [UIFont systemFontOfSize:14];
        [servicePeopleView addSubview:serviceLabel];
        
        
        
        
        //服务人员间隔
        UIView * servicePeopleBottomView = [[UIView alloc]init];
        servicePeopleBottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
        [servicePeopleView addSubview:servicePeopleBottomView];
        
        
        
        //评星
        UIView * evaluateStarView = [[UIView alloc]init];
        evaluateStarView.backgroundColor = [UIColor clearColor];
        [evaluateStarTotalView addSubview:evaluateStarView];
        
        
        evaluateStarTotalView.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        
        
        servicePeopleView.sd_layout
        .leftSpaceToView(evaluateStarTotalView, 0)
        .topSpaceToView(evaluateStarTotalView, 0)
        .rightSpaceToView(evaluateStarTotalView, 0)
        .heightIs(70);
        
        
        
        servicePeopleImageview.sd_layout
        .leftSpaceToView(servicePeopleView, 12)
        .centerYEqualToView(servicePeopleView)
        .heightIs(40)
        .widthIs(40);
        
        
        servicePeopleImageview.layer.cornerRadius = servicePeopleImageview.yj_width * 0.5;
        servicePeopleImageview.layer.masksToBounds = YES;
        
        
        
        
        servicePeopleLabel.sd_layout
        .leftSpaceToView(servicePeopleImageview, 10)
        .topEqualToView(servicePeopleImageview)
        .heightIs(16)
        .rightSpaceToView(servicePeopleView, 12);
        
        
        
        serviceLabel.sd_layout
        .leftEqualToView(servicePeopleLabel)
        .rightEqualToView(servicePeopleLabel)
        .topSpaceToView(servicePeopleLabel, 7)
        .bottomEqualToView(servicePeopleImageview);
        
        
        servicePeopleBottomView.sd_layout
        .leftSpaceToView(servicePeopleView, 12)
        .rightSpaceToView(servicePeopleView, 12)
        .bottomSpaceToView(servicePeopleView, 0)
        .heightIs(1);
        
        evaluateStarView.sd_layout
        .leftSpaceToView(evaluateStarTotalView, 0)
        .rightSpaceToView(evaluateStarTotalView, 0)
        .topSpaceToView(servicePeopleView, 0)
        .heightIs(70);
        
        
        
        XHStarRateView *starRateView3 = [[XHStarRateView alloc] initWithFrame:CGRectMake(50,evaluateStarView.yj_y + 10,SCW - 100, evaluateStarView.yj_height - 20) finish:^(CGFloat currentScore) {
            
        }];
        _starRateView3 = starRateView3;
        starRateView3.isAnimation = YES;
        [evaluateStarView addSubview:starRateView3];
        
        
    }
    return self;
}

@end
