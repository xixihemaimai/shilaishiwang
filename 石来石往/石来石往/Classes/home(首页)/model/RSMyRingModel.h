//
//  RSMyRingModel.h
//  石来石往
//
//  Created by mac on 2017/8/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSMyRingTimeModel.h"
#import "RSOwerLinkManModel.h"

@interface RSMyRingModel : NSObject


/**获取联系人*/
@property (nonatomic,strong)NSString * ownerName;
/**获取电话号码*/
@property (nonatomic,strong)NSString * ownerPhone;
/**获取地址*/
@property (nonatomic,strong)NSArray * ownerAdress;

/**获取LOGO图片*/
@property (nonatomic,strong)NSString * ownerLogo;

/**ownerLinkMan*/
@property (nonatomic,strong)NSMutableArray * ownerLinkMan;


/**获取我的荒料*/
@property (nonatomic,assign)double blockNum;

/**获取我的大板*/
@property (nonatomic,assign)double slabNum;


@property (nonatomic,strong)NSString * ERP_USER_CODE;

/**背景图片*/
@property (nonatomic,strong)NSString * backgroundImgUrl;






@end
