//
//  Comment.h
//  MomentKit
//
//  Created by LEA on 2017/12/12.
//  Copyright © 2017年 LEA. All rights reserved.
//
//  评论Model
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

/**commentHZLogo评论的logo*/
@property (nonatomic,strong)NSString * commentHZLogo;
/**评论的ID*/
@property (nonatomic,strong)NSString * relUserId;
/**天*/
@property (nonatomic,strong)NSString * day;
/**月*/
@property (nonatomic,strong)NSString *  month;
/**年*/
@property (nonatomic,strong)NSString *  year;
/**时间*/
@property (nonatomic,strong)NSString * timedate;
/**评论的正文*/
@property (nonatomic,copy) NSString * comment;
// 发布者名字
@property (nonatomic,copy) NSString * commentName;
// 关联动态的PK
@property (nonatomic,assign) int commentmod;
//回复谁的内容
@property (nonatomic,strong) NSString * relUser;

@property (nonatomic,strong)NSString * commentUserId;

@property (nonatomic,strong)NSString * commentId;


/**评论人*/
@property (nonatomic,strong)NSString * commentUserType;
/**被评论人*/
@property (nonatomic,strong)NSString *  relUserType;

@end
