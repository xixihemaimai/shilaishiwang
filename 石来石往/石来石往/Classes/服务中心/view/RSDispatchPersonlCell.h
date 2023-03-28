//
//  RSDispatchPersonlCell.h
//  石来石往
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSDispatchPersonlCell : UITableViewCell

/**出库服务图片还是市场服务图片*/
@property (nonatomic,strong) UIImageView * dispatchPersonlImageView;

/**出库服务还是市场服务*/
@property (nonatomic,strong)UILabel * dispatchPersonlLabel;


//商户
@property (nonatomic,strong)UILabel * dispatchPersonlShowLabel;


/**出货单*/
@property (nonatomic,strong)UILabel * dispatchPersonlOutLabel;

/**预约时间*/
@property (nonatomic,strong)UILabel * dispatchPersonlTimeLabel;

/**服务状态*/
@property (nonatomic,strong)UIButton * dispatchPersonlServiceBtn;

/**服务类型*/
@property (nonatomic,strong)UIButton * dispatchPersonlDetailBtn;

/**是管理人员还是派遣服务人员*/
@property (nonatomic,strong)UIButton * dispatchPersonlmyServiceBtn;

@end

