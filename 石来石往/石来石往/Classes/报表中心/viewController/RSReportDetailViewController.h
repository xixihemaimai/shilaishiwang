//
//  RSReportDetailViewController.h
//  石来石往
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSRSDetailsOfChargesFuntionRightView.h"
#import "RSDetailOfChargesLeftScreenView.h"
#import "RSUserModel.h"
#import "RSSumLiistModel.h"
@interface RSReportDetailViewController : RSAllViewController


@property (nonatomic,strong)RSRSDetailsOfChargesFuntionRightView * leftview;

@property (nonatomic,strong)RSDetailOfChargesLeftScreenView * detailsOfChargesLeftScreenview;

//@property (nonatomic,strong)RSUserModel * usermodel;

@property (nonatomic,strong)RSSumLiistModel * sumListmodel;

@end
