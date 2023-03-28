//
//  RSDetailOfChargesLeftScreenView.h
//  石来石往
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol RSDetailOfChargesLeftScreenViewDelegate <NSObject>


/**
 
 //起始日期
 NSString * _datefrom;
 //截止日期
 NSString * _Dateto;
 //物料名称
 NSString * _mtlname;
 //荒料号
 NSString * _blockno;
 //仓库
 NSString * _whsName;
 //库区
 NSString * _storeareaName;
 //储位名称
 NSString * _locationName;
 
 */

//这边是筛选的东西所要传的值
- (void)selectorDatefrom:(NSString *)datefrom andDateto:(NSString *)Dateto andMtlname:(NSString *)mtlname andBlockno:(NSString *)blockno andWhsName:(NSString *)whsName andStoreareaName:(NSString *)storeareaName andLocationName:(NSString *)locationName andTurnsno:(NSString *)turnsno andLength:(NSString *)length andLengthType:(NSString *)lengthType andWidth:(NSString *)width andWidthType:(NSString *)widthType ;


//这边是费用明细的代理
- (void)selectorDatefrom:(NSString *)datefrom andDateto:(NSString *)Dateto;



@end



@interface RSDetailOfChargesLeftScreenView : UIView


@property (nonatomic,strong)UITableView * tableview;

/**选择的类型*/
@property (nonatomic,strong)NSString * searchType;


@property (nonatomic,weak)id<RSDetailOfChargesLeftScreenViewDelegate> delegate;




@end
