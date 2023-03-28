//
//  RSServiceChoiceRightView.h
//  石来石往
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RSServiceChoiceRightViewDelegate<NSObject>

/**参数的话
  * 1.起始时间
  * 2.截止时间
  * 3.申请人
  * 4.状态
  */
//这边是重置的方式
@optional
- (void)resetShowChoiceMyServiceStyleStarTime:(NSString *)starTime andEndTime:(NSString *)endTime andApplicant:(NSString *)people andStatus:(NSString *)statusStr andServiceType:(NSString *)serviceType;

//这边是确定的方式
- (void)showChoiceMyServiceStyleStarTime:(NSString *)starTime andEndTime:(NSString *)endTime andApplicant:(NSString *)people andStatus:(NSString *)statusStr andServiceType:(NSString *)serviceType;





@end



@interface RSServiceChoiceRightView : UIView

@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,weak)id<RSServiceChoiceRightViewDelegate>delegate;


/**起始时间*/
@property (nonatomic,strong)NSString * starTime;
/**截止时间*/
@property (nonatomic,strong)NSString * endTime;

/**申请人*/
@property (nonatomic,strong)NSString * people;

/**状态*/
@property (nonatomic,strong)NSString * statusStr;


/**名字*/
@property (nonatomic,strong)NSString * userName;

/**服务类型*/
@property (nonatomic,strong)NSString * serviceType;




@end
