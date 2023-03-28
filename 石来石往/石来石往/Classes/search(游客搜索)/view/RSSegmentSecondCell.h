//
//  RSSegmentSecondCell.h
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSCompanyAndStoneModel.h"


@interface RSSegmentSecondCell : UITableViewCell




@property (nonatomic,strong)RSCompanyAndStoneModel * companyAndStoneModel;


/**体积*/
@property (nonatomic,strong)UILabel * secondTiLabel;

/**重量*/
@property (nonatomic,strong)UILabel * secondWightLabel;

/**颗*/
@property (nonatomic,strong)UILabel * secondKeLabel;

@end
