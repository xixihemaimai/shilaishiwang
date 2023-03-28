//
//  Moment.h
//  MomentKit
//
//  Created by LEA on 2017/12/12.
//  Copyright © 2017年 LEA. All rights reserved.
//
//  动态Model
//

#import <Foundation/Foundation.h>

@interface Moment : NSObject
//朋友圈的头像
@property (nonatomic,strong)NSString *HZLogo;
//朋友圈的名字
@property (nonatomic,strong)NSString *HZName;
//朋友圈的所要的评论的内容
@property (nonatomic,strong)NSString *content;
//朋友圈评论的图片---压缩图片
@property (nonatomic,strong)NSArray *photos;
//朋友圈评论的图片---高清图片
@property (nonatomic,strong)NSArray *newphotos;
//朋友圈的网络地址
@property (nonatomic,strong)NSString *url;
/**朋友圈的检测信息*/
@property (nonatomic,strong)NSString * checkMsg;
/**朋友圈的创建时间*/
@property (nonatomic,strong)NSString * create_time;
/**朋友圈创建用户*/
@property (nonatomic,strong)NSString * create_user;
/**朋友圈时间*/
@property (nonatomic,strong)NSString * day;
/**朋友圈的erpcCode*/
@property (nonatomic,strong)NSString * erpCode;
/**朋友圈的erp_id*/
@property (nonatomic,strong)NSString * erp_id;
/**朋友圈的月份*/
@property (nonatomic,strong)NSString * month;
/**朋友圈的范围*/
@property (nonatomic,strong)NSString * pagerank;

@property (nonatomic,strong)NSString * pageranks;
/**类型*/
@property (nonatomic,strong)NSString * type;
/**朋友的状态*/
@property (nonatomic,strong)NSString * status;
/**朋友圈的时间标识*/
@property (nonatomic,strong)NSString * timeMark;
/**朋友圈的年的时间标识*/
@property (nonatomic,strong)NSString * timeMarkYear;
/**朋友圈的friendId*/
@property (nonatomic,strong)NSString * friendId;
/**朋友圈的喜欢次数*/
@property (nonatomic,strong)NSString * likenum;
/**朋友圈的有没有点赞的状态*/
@property (nonatomic,strong)NSString * likestatus;
/**朋友圈的userid*/
@property (nonatomic,strong)NSString * userid;
/**朋友圈的actecomment*/
@property (nonatomic,strong)NSString * actecomment;
/**朋友圈的评论数*/
@property (nonatomic,strong)NSString * actenum;
/**朋友圈的关注*/
@property (nonatomic,strong)NSString * attstatus;
/**朋友圈的主题*/
@property (nonatomic,strong)NSString * theme;
/**朋友圈的类型*/
@property (nonatomic,strong)NSString * userType;
/**是那个一个cell的位置*/
@property (nonatomic,assign)NSInteger index;
/**视频缩略图的高度*/
@property (nonatomic,assign)double coverHeight;
/**视频缩略图的宽度*/
@property (nonatomic,assign)double coverWidth;

// 赞的人[逗号隔开的字符串]
@property (nonatomic,copy) NSString * praiseNameList;
//显示是图片还是视频
@property (nonatomic,strong) NSString * viewType;
/**视频的URL*/
@property (nonatomic,strong)NSString * video;
/**视频显示缩略图*/
@property (nonatomic,strong)NSString * cover;
// 显示'全文'/'收起'
@property (nonatomic,assign) BOOL isFullText;
// 是否已经点赞
@property (nonatomic,assign) BOOL isPraise;
// 评论集合
@property (nonatomic,strong) NSMutableArray * commentList;
// Moment对应cell高度
@property (nonatomic,assign) CGFloat rowHeight;

@property (nonatomic,strong)NSString * sys_user_id;
/**点赞集合*/
@property (nonatomic,strong)NSMutableArray * likeList;


@end
