//
//  RSPersonlServiceCompleteCell.h
//  石来石往
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSPersonlServiceCompleteCell : UITableViewCell
//服务详情
@property (nonatomic,strong)UIButton * personlCompleteModifyServiceBtn;
//查看评价
@property (nonatomic,strong)UIButton * personlCompleteEvaluationServiceBtn;
//上传图片
@property (nonatomic,strong)UIButton * personlCompleteUploadPictureBtn;
//服务类型图片
@property (nonatomic,strong)UIImageView * personlCompleteImageView;

//服务类型
@property (nonatomic,strong)UILabel * personlCompleteLabel;
//服务人员商户
@property (nonatomic,strong)UILabel * personlCompleteNameLabel;

//出库单号
@property (nonatomic,strong)UILabel * personlCompleteOutLabel;

//出库数
//@property (nonatomic,strong)UILabel * personlCompleteNumberLabel;

//预约时间
@property (nonatomic,strong)UILabel * personlCompleteTimeLabel;
@end
