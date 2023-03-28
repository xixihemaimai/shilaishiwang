//
//  RSLeftViewController.h
//  石来石往
//
//  Created by mac on 17/5/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUserModel.h"

//单利
#import "singerTon.h"





@interface RSLeftViewController : RSAllViewController
/**登录用户的信息*/
//@property (nonatomic,strong)RSUserModel *userModel;

/**判读是不是货主*/
@property (nonatomic,assign)BOOL isOwner;

/**判读有没有登录了*/
//@property (nonatomic,assign)BOOL isLogin;

/**判断是不是普通用户*/
//@property (nonatomic,assign)BOOL isOrdinary;

/**点击登录*/
@property (nonatomic,strong)UIButton *nameBtn;

/**判断是不是修改二级登录密码，利用这个值，来对修改登录密码还是登录二级密码的修改，true就是修改登录密码,false就是修改二级登录密码，这个是一个参数type*/
@property (nonatomic,assign)BOOL isSecondPassword;

/**头像图像*/
@property (nonatomic,strong)UIImageView * iconImage;


//@property (nonatomic,strong)UITableView * leftTableview;


@property (nonatomic,strong)UIView *signOutview;

/**用户的电话号码*/
@property (nonatomic,strong)UIButton * namePhone;


/**tableheader头部的按键*/
@property (nonatomic,strong)UIButton * topBtn;

/**关注按键*/
@property (nonatomic,strong)UIButton * attentionBtn;

/**粉丝按键*/
@property (nonatomic,strong)UIButton * fansBtn;



//获取用户登录情况
//-(void)initUserInfo;
//SingerH(RSLeftViewController);
@end
