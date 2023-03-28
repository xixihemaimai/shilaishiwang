//
//  RSDetailSegmentViewController.h
//  石来石往
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "RSCompanyAndStoneModel.h"
#import "RSUserModel.h"

@interface RSDetailSegmentViewController : RSAllViewController

/**标题显示的文字*/
@property (nonatomic,strong)NSString * titleStr;




//@property (nonatomic,strong)RSCompanyAndStoneModel * companyAndStoneModel;


@property (nonatomic,strong)NSString * stoneName;

@property (nonatomic,strong)NSString * companyName;


/**判断是大板还是荒料的情况*/
@property (nonatomic,strong)NSString * searchType;

@property (nonatomic,strong)RSUserModel * userModel;


@property (nonatomic,strong)NSString * tempStr1;
@property (nonatomic,strong)NSString * tempStr2;
@property (nonatomic,strong)NSString * tempStr3;

@property (nonatomic,strong)NSString * tempStr4;


/**用来保存按键是大于还是小于还是等于*/
@property (nonatomic,strong)NSString * btnStr1;
@property (nonatomic,strong)NSString * btnStr2;
@property (nonatomic,strong)NSString * btnStr3;
@property (nonatomic,strong)NSString * btnStr4;



@property (nonatomic,strong)NSString * dataSource;

@property (nonatomic,strong)NSString * erpCode;

@property (nonatomic,strong)NSString * weight;

@property (nonatomic,strong)NSString * phone;

@property (nonatomic,strong)NSString * imageUrl;

@property (nonatomic,strong)NSString * shitouName;

@property (nonatomic,strong)NSString * keAndZaStr;

@property (nonatomic,strong)NSString * piAndFangStr;


@end
