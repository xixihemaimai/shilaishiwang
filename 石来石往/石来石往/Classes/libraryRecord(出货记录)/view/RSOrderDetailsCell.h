//
//  RSOrderDetailsCell.h
//  石来石往
//
//  Created by mac on 2017/9/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSOrderDetailsCell : UITableViewCell


/**出货订单*/
@property (nonatomic,strong)UILabel * detailLibraryLabel;

/**下单时间*/
@property (nonatomic,strong)UILabel * detailDateLabel;

/**状态*/
@property (nonatomic,strong)UILabel * detailStatusLabel;

/**汽车类型*/
@property (nonatomic,strong) UILabel * carTypeLabel;

@end
