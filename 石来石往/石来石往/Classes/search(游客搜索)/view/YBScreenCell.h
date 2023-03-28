//
//  YBScreenCell.h
//  UISegementController
//
//  Created by mac on 2017/7/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSDetailScreenButton.h"

@interface YBScreenCell : UITableViewCell

@property (nonatomic,strong)UILabel * nameLabel;

@property (nonatomic,strong)RSDetailScreenButton * choiceBtn;

@property (nonatomic,strong)UITextField * textfield;




@end
