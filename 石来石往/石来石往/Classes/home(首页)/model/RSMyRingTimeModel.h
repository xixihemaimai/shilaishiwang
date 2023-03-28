//
//  RSMyRingTimeModel.h
//  石来石往
//
//  Created by mac on 2017/8/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSMyRingTimeModel : NSObject


/**头像*/
@property (nonatomic,strong)NSString * HZLogo;
/**昵称*/
@property (nonatomic,strong)NSString * HZName;

/**检查信息*/
@property (nonatomic,strong)NSString * checkMsg;


/**获取评论内容*/
@property (nonatomic,strong)NSString * content;

/**创建时间*/
@property (nonatomic,strong)NSString * create_time;

/**创建用户*/
@property (nonatomic,strong)NSString * create_user;



/**获取天*/
@property (nonatomic,strong)NSString * day;


/**erp_id*/
@property (nonatomic,strong)NSString * erp_id;


/**获取月*/
@property (nonatomic,strong)NSString * month;


/**pagerank*/
@property (nonatomic,strong)NSString * pagerank;



/**获取图片*/
@property (nonatomic,strong)NSArray * photos;

/**状态*/
@property (nonatomic,strong)NSString * status;


/**获取是不是今天，昨天，前天*/
//0代表今天 , 1代表昨天 , 2代表前天....
@property (nonatomic,assign)NSInteger timeMark;

/**获取年*/
//0代表今年 , 1代表去年
@property (nonatomic,assign)NSInteger timeMarkYear;

/**用户的URL*/
@property (nonatomic,strong)NSString * url;







@end
