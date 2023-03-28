//
//  RSServiceEvalModel.h
//  石来石往
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSServiceEvalModel : NSObject


/**服务ID*/
@property (nonatomic,strong)NSString * serviceId;

/**当前登录者的ID*/
@property (nonatomic,strong)NSString * userId;
/**服务人员的名字*/
@property (nonatomic,strong)NSString * userName;

/**服务的里面满意度和星级*/
@property (nonatomic,strong)NSMutableArray * serviceUserEvalList;


/**服务满意度*/
@property (nonatomic,strong)NSString * serviceEvalLevel;


/**服务评论内容*/
@property (nonatomic,strong)NSString * serviceComment;

@end
