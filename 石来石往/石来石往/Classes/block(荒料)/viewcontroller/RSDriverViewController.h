//
//  RSDriverViewController.h
//  石来石往
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSDirverContact.h"
#import "RSUserModel.h"
//#import "singerTon.h"

@protocol RSDriverViewControllerDelegate <NSObject>



- (void)modifyConsigneeName:(NSString *)csnName andConsigneePhone:(NSString *)csnPhone;

@end





@interface RSDriverViewController : RSAllViewController

/**这个是数组是从购物车里面传过来的数据*/
@property (nonatomic,strong)NSMutableArray *shopCarNumberArray;


/**用这个erpcode是网络请求的参数需要用到*/
@property (nonatomic,strong)NSString *userID;



@property (nonatomic,strong)RSDirverContact *contact;

/**这个数组是从添加司机信息页面返回的数据*/
@property (nonatomic,strong)NSMutableArray *driverArray;


//SingerH(RSDriverViewController);
@property (nonatomic,strong)RSUserModel *userModel;


/**类型*/
@property (nonatomic,strong)NSString * outStyle;



@property (nonatomic,weak)id<RSDriverViewControllerDelegate>delegate;

@end


