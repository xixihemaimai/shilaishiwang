//
//  RSReportDetialCell.h
//  石来石往
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSReportDetialCell : UITableViewCell

@property (nonatomic,strong)UIButton * singlecodeBtn;

/**显示次数*/
@property (nonatomic,strong)UILabel * label;
/**产品名称*/
@property (nonatomic,strong) UILabel * productLabel;

/**颗数*/
@property (nonatomic,strong)UILabel * keLabel;

/**总颗数*/
@property (nonatomic,strong)UILabel * zongKeLabel;

/**立方*/
@property (nonatomic,strong)UILabel * LiLabel;
/**总立方*/
@property (nonatomic,strong)UILabel * zongLiLabel;

/**重量*/
@property (nonatomic,strong)UILabel * weightLabel;
/**总重量*/
@property (nonatomic,strong)UILabel * zongWeightLabel;
/**报表*/
@property (nonatomic,strong)UIButton * reportFormBtn;

@end
