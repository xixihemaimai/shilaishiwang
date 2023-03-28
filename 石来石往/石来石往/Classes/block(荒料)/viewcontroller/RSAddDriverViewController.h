//
//  RSAddDriverViewController.h
//  石来石往
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"


@class RSDriverViewController;
@class RSDirverContact,RSAddDriverViewController;
@protocol RSAddDriverViewControllerDelegate <NSObject>


- (void)transmitConsigneeName:(NSString *)csnName andConsigneePhone:(NSString *)csnPhone;

@end




@interface RSAddDriverViewController : RSAllViewController

@property (nonatomic,strong)NSString *userID;

@property (nonatomic,strong)RSDirverContact *contact;

//@property (nonatomic,strong)RSDriverViewController *driverViewVC;

@property (nonatomic,assign)NSInteger tag;

@property (nonatomic,strong)RSUserModel * userModel;


//出货记录里面的数组
@property (nonatomic,strong)NSMutableArray * chuArray;


@property (nonatomic,strong)NSMutableArray * driverArray;

@property (nonatomic,weak)id<RSAddDriverViewControllerDelegate>deleagate;


@end
