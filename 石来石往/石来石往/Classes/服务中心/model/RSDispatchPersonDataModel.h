//
//  RSDispatchPersonDataModel.h
//  石来石往
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSDispatchPersonDataModel : NSObject


/**
 appointtime = "2018-04-17 15:23:59";
 id = 201;
 serviceadd = 4343;
 servicething = 3232323;
 servicetype = scfw;
 status = 1;
 updatetime = "2018-04-17 15:24:14";
 userId = 8;
 "user_name" = "\U5929\U4e00";
 
 */


@property (nonatomic,strong)NSString *  dispatchPersonlId;


@property (nonatomic,strong)NSString * appointtime;


@property (nonatomic,strong)NSString * serviceadd;

@property (nonatomic,strong)NSString * servicething;

@property (nonatomic,strong)NSString * servicetype;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)NSString * updatetime;

@property (nonatomic,strong)NSString * userId;

@property (nonatomic,strong)NSString * user_name;

@property (nonatomic,strong)NSString * outBoundNo;

@property (nonatomic,strong)NSString * servicekind;

@property (nonatomic,strong)NSString * comment;


@end
