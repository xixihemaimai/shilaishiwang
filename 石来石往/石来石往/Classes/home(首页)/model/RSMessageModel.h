//
//  RSMessageModel.h
//  石来石往
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSMessageModel : NSObject

/**消息类型*/
@property (nonatomic,strong)NSString * messageType;

/**系统信息ID*/
@property (nonatomic,strong)NSString * sysMessageId;

/**创建时间*/
@property (nonatomic,strong)NSString * createTime;


/**消息标题*/
@property (nonatomic,strong)NSString * messageTitle;

/**信息阅读量*/
@property (nonatomic,strong)NSString * messageRead;


/**操作者*/
@property (nonatomic,strong)NSString * operationName;

/**操作者ID*/
@property (nonatomic,strong)NSString * messageUserId;

/**朋友圈ID*/
@property (nonatomic,strong)NSString * friendsId;

/**消息内容*/
@property (nonatomic,strong)NSString * messageContent;

@property (nonatomic,strong)NSString * messageID;

/**图片的*/
@property (nonnull,strong)NSString  * imgUrl;


@end
