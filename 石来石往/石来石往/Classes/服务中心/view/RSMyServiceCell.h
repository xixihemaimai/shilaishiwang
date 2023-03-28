//
//  RSMyServiceCell.h
//  石来石往
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSMyServiceCell : UITableViewCell

//修改服务
@property (nonatomic,strong)UIButton * myModifyServiceBtn;

//取消服务
@property (nonatomic,strong)UIButton * myCancelServiceBtn;

//服务详情
@property (nonatomic,strong)UIButton * myServiceDetailBtn;


//出库图片
@property (nonatomic,strong)UIImageView * myImageView;

//服务类型
@property (nonatomic,strong)UILabel * myServiceLabel;
//出库单号
@property (nonatomic,strong)UILabel * myServiceOutLabel;
//预约时间
@property (nonatomic,strong)UILabel * myServiceTimeLabel;
//服务处理类型
@property (nonatomic,strong)UIButton * myServiceBtn;



@end


