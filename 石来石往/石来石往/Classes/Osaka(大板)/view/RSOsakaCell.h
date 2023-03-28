//
//  RSOsakaCell.h
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSOsakaModel.h"
@interface RSOsakaCell : UITableViewCell

/**面积*/
@property (nonatomic,strong)UILabel * areaLabel;
/**名称*/
@property (nonatomic,strong)UILabel *productLabel;

/**荒料号*/
@property (nonatomic,strong)UILabel * numberlabel;

/**是否选中*/
@property (nonatomic,strong)UILabel *choicelabel;

@property (nonatomic,strong)RSOsakaModel *osakaModel;
@end
