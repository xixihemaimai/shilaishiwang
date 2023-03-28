//
//  RSChoiceMarketView.h
//  石来石往
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSChoiceMarkterButton.h"
@interface RSChoiceMarketView : UIView

@property (nonatomic,strong)RSChoiceMarkterButton * currentMartketBtn;

@property (nonatomic,strong)UIButton * choiceBtn;


@property (nonatomic,strong) UILabel * numeberLabel;

@property (nonatomic,strong)UILabel * marketLabel;

@end
