//
//  RSServiceLibraryCell.h
//  石来石往
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSServiceLibraryCell : UITableViewCell

/**出单号*/
@property (nonatomic,strong)UILabel * serviceOutLabel;
/**出库的时间*/
@property (nonatomic,strong)UILabel * serviceOutTimeLabel;

/**订单详情*/
@property (nonatomic,strong)UIButton * serviceOrderDetailsBtn;

/**发起服务*/
@property (nonatomic,strong)UIButton * initiatingServiceBtn;
@end
