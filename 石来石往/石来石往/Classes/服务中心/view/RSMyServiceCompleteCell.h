//
//  RSMyServiceCompleteCell.h
//  石来石往
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSMyServiceCompleteCell : UITableViewCell

//服务评价
@property (nonatomic,strong)UIButton * myModifyCompleteServiceBtn;

//服务详情
@property (nonatomic,strong) UIButton * myServiceCompleteDetailBtn;


//服务人员
@property (nonatomic,strong)UIButton * myServicePeopleBtn;


//服务类型图片
@property (nonatomic,strong) UIImageView * myCompleteImageView ;

//服务类型
@property (nonatomic,strong) UILabel * myServiceCompleteLabel;

//出库单号
@property (nonatomic,strong) UILabel * myServiceCompleteOutLabel;
//预约时间
@property (nonatomic,strong) UILabel * myServiceCompleteTimeLabel;

@end
