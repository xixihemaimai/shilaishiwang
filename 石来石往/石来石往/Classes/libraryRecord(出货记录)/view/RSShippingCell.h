//
//  RSShippingCell.h
//  石来石往
//
//  Created by mac on 17/6/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RSShippingCell : UITableViewCell


/**出货订单*/
@property (nonatomic,strong)UILabel * detailLibraryLabel;

/**下单时间*/
@property (nonatomic,strong)UILabel * detailDateLabel;

/**状态*/
@property (nonatomic,strong)UILabel * detailStatusLabel;

//模型
//@property (nonatomic,strong)RSShipmentModel * shipModel;

@property (nonatomic,strong)UIButton * cancelBtn;


@end
