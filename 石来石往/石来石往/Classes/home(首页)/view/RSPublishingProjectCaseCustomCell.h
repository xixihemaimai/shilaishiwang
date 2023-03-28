//
//  RSPublishingProjectCaseCustomCell.h
//  石来石往
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPublisingProjectCaseButton.h"


#import "RSPublishingProjectCaseFirstButton.h"

@interface RSPublishingProjectCaseCustomCell : UITableViewCell
@property (nonatomic,strong)UIButton * stoneNameBtn;

@property (nonatomic,strong)RSPublishingProjectCaseFirstButton * indexpathBtn;


@property (nonatomic,strong) UIButton * deleteBtn;


@end
