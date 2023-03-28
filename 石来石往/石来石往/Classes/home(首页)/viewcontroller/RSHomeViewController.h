//
//  RSHomeViewController.h
//  石来石往
//
//  Created by mac on 17/5/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "RSFriendModel.h"

#import "RSLeftViewController.h"

#import "LXActivity.h"
#import "RSUserModel.h"



@protocol RSHomeViewControllerDelegate <NSObject>


//这边是对俩个点赞的地方进行代理
- (void)reloadArrayDataRSFriendModel:(RSFriendModel *)friendmodel andFriendArray:(NSMutableArray *)friendArray andshowType:(NSString *)showType;

//这边是对关注的地方进行代理
- (void)changAttatitionDataRSFriendModel:(RSFriendModel *)friendmodel andShowType:(NSString *)showType;

//对于显示有没有最新消息的地方进行代理代理返回
- (void)changRedBadValueAttSize:(NSInteger)attSize andFriendRed:(BOOL)friendRed andShowType:(NSString *)showType;


//下拉刷新的时候要做的处理
- (void)hideRedBadValueTitle:(NSString *)title;



@end


@interface RSHomeViewController : RSAllViewController<LXActivityDelegate>

//@property (nonatomic,strong)RSFriendModel *friendModel;
/**是否是第二次登录了*/
//@property (nonatomic,assign)BOOL isSecondLogin;




#pragma mark -- 用来对个界面网络请求的参数

/**看的是石圈还是关注的界面*/
@property (nonatomic,strong)NSString * showType;

- (RSUserModel *)userModel;

/**当前屏幕下面的tableview*/
@property (nonatomic,strong)UITableView *informationTableview;

/**朋友圈有多少次*/
@property (nonatomic,strong)NSMutableArray *friendArray;


@property (nonatomic,weak)id<RSHomeViewControllerDelegate>deleagate;




@end
