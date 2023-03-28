//
//  RSHuangDetailAndDaDetailViewController.h
//  石来石往
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"

#import "RSLeftScreenView.h"
#import "RSLeftFunctionScreenView.h"
#import "DOPDropDownMenu.h"

@interface RSHuangDetailAndDaDetailViewController : UIViewController


//- (NSString *)tempStr1;
//- (NSString *)tempStr2;
//- (NSString *)tempStr3;
//
//- (NSString *)tempStr4;
//
//
///*用来保存按键是大于还是小于还是等于*/
//- (NSString *) btnStr1;
//- (NSString *) btnStr2;
//- (NSString *) btnStr3;
//- (NSString *) btnStr4;
//
//
//- (NSString *)searchStr;
//
//- (NSString *)searchType;
//
//
//
//- (RSUserModel *)userModel;

/**中间值，用来保存四个textfiled的值*/



@property (nonatomic,strong)RSLeftFunctionScreenView * leftview;


@property (nonatomic,strong)RSLeftScreenView *showRightview;

@property (nonatomic, weak) DOPDropDownMenu *menu;


@property (nonatomic,strong)NSString * tempStr1;
@property (nonatomic,strong)NSString * tempStr2;
@property (nonatomic,strong)NSString * tempStr3;

@property (nonatomic,strong)NSString * tempStr4;


/**用来保存按键是大于还是小于还是等于*/
@property (nonatomic,strong)NSString * btnStr1;
@property (nonatomic,strong)NSString * btnStr2;
@property (nonatomic,strong)NSString * btnStr3;
@property (nonatomic,strong)NSString * btnStr4;



@property (nonatomic,strong)NSString * searchStr;

@property (nonatomic,strong)NSString * searchType;


@property (nonatomic,strong)RSUserModel * userModel;


@end
