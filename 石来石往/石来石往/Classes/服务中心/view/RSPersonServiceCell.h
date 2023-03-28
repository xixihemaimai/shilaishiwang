//
//  RSPersonServiceCell.h
//  石来石往
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSPersonServiceCell : UITableViewCell

//服务详情
@property (nonatomic,strong)UIButton * personlServiceModifyServiceBtn;
//接受服务
@property (nonatomic,strong)UIButton * personlServiceStartServiceBtn;

//上传图片
@property (nonatomic,strong)UIButton * personlUploadPictureBtn;


//服务类型图片
@property (nonatomic,strong)UIImageView * personlServiceImageView;

//服务类型
@property (nonatomic,strong)UILabel * personlServiceLabel;

//服务人员商户
@property (nonatomic,strong)UILabel * personlServiceNameLabel;

//出库单号
@property (nonatomic,strong)UILabel * personlServiceOutLabel;

//预约时间
@property (nonatomic,strong)UILabel * personlServiceTimeLabel;



//服务处理类型
@property (nonatomic,strong)UIButton * myServiceBtn;


@end
