//
//  RSDaSecondViewController.h
//  石来石往
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAllHuangAndDaViewController.h"
#import "RSUserModel.h"

@interface RSDaSecondViewController : RSAllHuangAndDaViewController

@property (nonatomic,strong)RSUserModel * userModel;

/**判断是大板还是荒料的情况*/
@property (nonatomic,strong)NSString * searchType;

///**中间值，用来保存四个textfiled的值*/
//@property (nonatomic,strong)NSString * tempStr1;
//@property (nonatomic,strong)NSString * tempStr2;
//@property (nonatomic,strong)NSString * tempStr3;
//
//@property (nonatomic,strong)NSString * tempStr4;
//
//
///**用来保存按键是大于还是小于还是等于*/
//@property (nonatomic,strong)NSString * btnStr1;
//@property (nonatomic,strong)NSString * btnStr2;
//@property (nonatomic,strong)NSString * btnStr3;
//@property (nonatomic,strong)NSString * btnStr4;
/**搜索的内容*/
@property (nonatomic,strong)NSString * searchStr;

@end
