//
//  RSDetailSegmentHeaderview.h
//  石来石往
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSCompanyAndStoneModel.h"

@interface RSDetailSegmentHeaderview : UITableViewHeaderFooterView


@property (nonatomic,strong)RSCompanyAndStoneModel * companyAndStoneModel;


@property (nonatomic,strong)UIButton * playPhoneBtn;


//公司
@property (nonatomic,strong)UILabel * companyLabel;

//立方
@property (nonatomic,strong)UILabel * tiLabel;

 //颗数
@property (nonatomic,strong)UILabel * keLabel;



//图片
@property (nonatomic,strong)UIImageView * imageview;

//石头名字
@property (nonatomic,strong)UILabel * productLabel;





//重量
@property (nonatomic,strong)UILabel * weightLabel;



//电话号码
@property (nonatomic,strong)UILabel * numberPhoneLabel;

@end
