//
//  RSAlreadEvaluationServiceStarView.h
//  石来石往
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHStarRateView.h"
@interface RSAlreadEvaluationServiceStarView : UIView

/**星星的界面*/
@property (nonatomic,strong)XHStarRateView *starRateView3;

/**服务人员的名称，头像*/
@property (nonatomic,strong)UIImageView * servicePeopleImageview;
/**服务人员的名称*/
@property (nonatomic,strong) UILabel * servicePeopleLabel;

@end
