//
//  RSAllowView.h
//  石来石往
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAllowView : UIView

/**不同意按键*/
@property (nonatomic,strong)UIButton * noagreeBtn ;
/**同意的按键*/
@property (nonatomic,strong)UIButton * agreenBtn;

/**乙方*/
@property (nonatomic,strong)UILabel * bLabel;

@end
