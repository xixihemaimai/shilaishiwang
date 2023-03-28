//
//  RSFriendDetailModel.h
//  石来石往
//
//  Created by rsxx on 2017/9/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSFriendDetailModel : NSObject

/**头像的logo的网址*/
@property (nonatomic,strong)NSString * HZLogo;

/**评论数*/
@property (nonatomic,assign)NSInteger actenum;

/**评论内容*/
@property (nonatomic,strong)NSString * comment;

/**评论的名字*/
@property (nonatomic,strong)NSString * commentName;

/**评论的commentUserId*/
@property (nonatomic,strong)NSString * commentUserId;

/**评论的天*/
@property (nonatomic,strong)NSString * day;

/**评论的月*/
@property (nonatomic,strong)NSString * month;

/**评论的时间*/
@property (nonatomic,strong)NSString * timedate;

/**评论的userId*/
@property (nonatomic,strong)NSString * userId;

/**评论的年*/
@property (nonatomic,strong)NSString * year;

/**评论的者的类型是游客还是货主*/
@property (nonatomic,strong)NSString * userType;





@end
