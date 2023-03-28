//
//  RSRecordSecondCell.h
//  石来石往
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSRecordSecondCell : UITableViewCell



/**位置*/
@property (nonatomic,strong)UIButton * paiBtn;

/**荒料号*/
@property (nonatomic,strong)UILabel * detailHuangliaoLabel ;

/**产品名称*/
@property (nonatomic,strong)UILabel * detailNameLabel;

/**片 数*/
@property (nonatomic,strong)UILabel * detailZaLabel;

/**面积*/
@property (nonatomic,strong)UILabel * detailAreaLabel;

/**储位号*/
@property (nonatomic,strong)UILabel * locationDetailLabel;

/**匝位*/
@property (nonatomic,strong)UILabel * turnDetailLabel;


@end
