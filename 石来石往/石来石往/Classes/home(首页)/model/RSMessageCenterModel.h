//
//  RSMessageCenterModel.h
//  石来石往
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSMessageCenterModel : NSObject

/**时间*/
@property (nonatomic,strong)NSString * createTime;

/**朋友圈的ID*/
@property (nonatomic,strong)NSString * friendsId;

/**图片*/
@property (nonatomic,strong)NSString * imgUrl;

/**信息内容*/
@property (nonatomic,strong)NSString * messageContent;

/**信息读取*/
@property (nonatomic,strong)NSString * messageRead;

/**信息标题*/
@property (nonatomic,strong)NSString * messageTitle;

/**信息方式*/
@property (nonatomic,strong)NSString * messageType;

/**信息使用ID*/
@property (nonatomic,strong)NSString * messageUserId;

/**系统信息ID*/
@property (nonatomic,strong)NSString * sysMessageId;

/**内容名字*/
@property (nonatomic,strong)NSString * userName;

/**id*/
@property (nonatomic,strong)NSString * messageCenterID;










@end
