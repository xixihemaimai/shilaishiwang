//
//  RSHuangThirdDetailViewController.h
//  石来石往
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOPDropDownMenu.h"
#import "RSAllMessageUIButton.h"
#import "RSLeftScreenView.h"
#import "RSLeftFunctionScreenView.h"
#import "RSUserModel.h"


@protocol RSHuangThirdDetailViewControllerDelegate <NSObject>

- (void)selectKeywordContentTitle:(NSString *)currentTitle andType:(NSInteger)type;

@end


@interface RSHuangThirdDetailViewController : UIViewController
@property (nonatomic, weak) DOPDropDownMenu *menu;


@property (nonatomic,strong)RSLeftFunctionScreenView * leftview;


@property (nonatomic,strong)RSLeftScreenView *showRightview;



@property (nonatomic,strong)NSString * tempStr1;
@property (nonatomic,strong)NSString * tempStr2;
@property (nonatomic,strong)NSString * tempStr3;

@property (nonatomic,strong)NSString * tempStr4;


/**用来保存按键是大于还是小于还是等于*/
@property (nonatomic,strong)NSString * btnStr1;
@property (nonatomic,strong)NSString * btnStr2;
@property (nonatomic,strong)NSString * btnStr3;
@property (nonatomic,strong)NSString * btnStr4;
//类型
@property (nonatomic,strong)NSString * show_type;
/**搜索的内容*/
@property (nonatomic,strong)NSString * searchStr;
/**是荒料还是大板*/
//@property (nonatomic,strong)NSString * searchType;


@property (nonatomic,strong)RSUserModel * userModel;


- (void)loadDabanMoreMarketNewData;

- (void)loadDabanDetailAndDaDetailNewData;

@property (nonatomic,weak)id<RSHuangThirdDetailViewControllerDelegate>delegate;


@end
