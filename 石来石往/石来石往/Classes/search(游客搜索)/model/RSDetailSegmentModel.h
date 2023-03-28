//
//  RSDetailSegmentModel.h
//  石来石往
//
//  Created by mac on 2017/7/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSDetailSegmentModel : NSObject


//收藏ID
@property (nonatomic,strong)NSString * collectionID;
//公司名字
@property (nonatomic,strong)NSString * companyName;

//收藏状态 0（未收藏） 1（已收藏）
@property (nonatomic,assign)BOOL isCollect;

//电话号码
@property (nonatomic,strong)NSString * phone;
//石头ID
@property (nonatomic,strong)NSString * stoneId;

//石头消息
@property (nonatomic,strong)NSString * stoneMessage;

//石头名字
@property (nonatomic,strong)NSString * stoneName;


//石头方式（1，2）
@property (nonatomic,assign)NSInteger stoneType;
//石头体积
@property (nonatomic,strong)NSString * stoneVolume;


//石头重量
@property (nonatomic,strong)NSString * stoneWeight;

//石头荒料
@property (nonatomic,strong)NSString * stoneblno;


//石头匝号
@property (nonatomic,strong)NSString * stoneturnsno;

//石头仓储位置
@property (nonatomic,strong)NSString * storerreaName;



@property (nonatomic,assign)NSInteger status;
@end
