//
//  RSUserModel.h
//  石来石往
//
//  Created by mac on 17/6/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSPwmsUserModel.h"
#import "RSPwmsUserListModel.h"
#import "RSErpUserListModel.h"


//#import "RSAccessModel.h"
@interface RSUserModel : NSObject<NSCopying>
/**用户的ERP唯一标识*/
//@property (nonatomic,strong)NSString *ERPCODE;
/**用户的ERP方货主默认公司名字*/
//@property (nonatomic,strong)NSString *ERPNAME;
/**用户的二级密码*/
//@property (nonatomic,strong)NSString *ERPPASSWORD;
/**用户的ERP状态信息*/
//@property (nonatomic,assign)NSInteger *ERPSTATUS;
/**用户的ERP方绑定手机*/
//@property (nonatomic,strong)NSString * ERPTEL;
/**用户的昵称*/
//@property (nonatomic,strong)NSString *USER_CODE;
/**用户的名字*/
//@property (nonatomic,strong)NSString *USER_NAME;
/**用户的货主应支付的海西费用*/
//@property (nonatomic,strong)NSString * ERPFEE;
/**判读是不是货主*/
//@property (nonatomic,strong)NSString * ISERPUSER;
/**用户的方式*/
//@property (nonatomic,strong)NSString *USER_TYPE;
/**重复登录的时间*/
//@property (nonatomic,strong)NSString *RECENT_TIME;
/**用户的密码*/
//@property (nonatomic,strong)NSString *PASSWORD;
/** 用户的ID*/
//@property (nonatomic,strong)NSString *SYS_USER_ID;
/**用户返回的结果信息*/
//@property (nonatomic,assign)NSInteger Result;
/**用户的手机号*/
//@property (nonatomic,strong)NSString *MOBILEPHONE;
/**创建的用户*/
//@property (nonatomic,strong)NSString * CREATE_USER;
/**创建用户的时间*/
//@property (nonatomic,strong)NSString *CREATE_TIME;
/**最后更新的时间*/
//@property (nonatomic,strong)NSString *LastUpDataTime;
/**石材在线的数据用户的格式*/
//@property (nonatomic,strong)NSString *OFFICE_CODE;
/**石材在线的数据用户的名字格式*/
//@property (nonatomic,strong)NSString *OFFICE_NAME;
/**更新用户时间*/
//@property (nonatomic,strong)NSString *UPDATE_TIME;
/**更新用户的使用者*/
//@property (nonatomic,strong)NSString *UPDATE_USER;
/**用户的方式*/
@property (nonatomic,strong)NSString * accType;
/**用户的创建时间*/
//@property (nonatomic,strong)NSString * createTime;
/**用户创建使用者*/
@property (nonatomic,strong)NSString * createUser;
/**用户的信息*/
@property (nonatomic,strong)NSString * emUid;
/**用户的信息*/
@property (nonatomic,strong)NSString * erploginKey;
/**用户的信息*/
//@property (nonatomic,strong)NSString * erploginTime;
/**用户的erppassWord*/
@property (nonatomic,strong)NSString * erppassWord;
/**用户的ID*/
@property (nonatomic,strong)NSString * userID;
/**用户的职位*/
@property (nonatomic,strong)NSString * inviteCode;
/**用户信息*/
@property (nonatomic,strong)NSString * identityId;
/**用户的水平*/
@property (nonatomic,strong)NSString * level;
/**用户登录的KEY*/
@property (nonatomic,strong)NSString * loginKey;
/**用户登录的时间*/
//@property (nonatomic,strong)NSString * loginTime;
/**用户的QQID*/
@property (nonatomic,strong)NSString * qqUid;
/**用户关系的ID*/
@property (nonatomic,assign)NSInteger parentId;
/**用户的密码*/
@property (nonatomic,strong)NSString * passWord;
/**用户的roleId*/
@property (nonatomic,strong)NSString * roleId;
/**用户的状态*/
@property (nonatomic,strong)NSString * status;
/**用户的同步时间*/
//@property (nonatomic,strong)NSString * syncTime;
/**用户更新的时间*/
//@property (nonatomic,strong)NSString * updateTime;
/**用户更新的用户*/
@property (nonatomic,strong)NSString * updateUser;
/**用户的userCode*/
@property (nonatomic,strong)NSString * userCode;
/**用户的头像图片*/
@property (nonatomic,strong)NSString * userHead;
/**用户的名字*/
@property (nonatomic,strong)NSString * userName;
/**用户的手机号码*/
@property (nonatomic,strong)NSString * userPhone;
/**用户的身份*/
@property (nonatomic,strong)NSString * userType;
/**用户微信的*/
@property (nonatomic,strong)NSString * wcUid;
/**用户的公司名称*/
@property (nonatomic,strong)NSString * orgName;
/**用户的权限表*/
//@property (nonatomic,strong)RSAccessModel * access;
/**系统管理*/
@property (nonatomic,assign)BOOL SysManage;
/**移动管理*/
@property (nonatomic,assign)BOOL appManage;
/**前端管理*/
@property (nonatomic,assign)BOOL webManage;
/**移动权限管理*/
@property (nonatomic,assign)BOOL appManage_qxgl;
/**移动我的收藏*/
@property (nonatomic,assign)BOOL appManage_sc;
/**移动石种图片上传*/
@property (nonatomic,assign)BOOL appManage_tppp;
/**移动商圈*/
@property (nonatomic,assign)BOOL appManage_sq;
/**移动业务管理*/
@property (nonatomic,assign)BOOL appManage_ywbl;
/**移动报表中心*/
@property (nonatomic,assign)BOOL appManage_ywbl_bbzx;
/**移动大板出库*/
@property (nonatomic,assign)BOOL appManage_ywbl_dbck;
/**移动荒料出库*/
@property (nonatomic,assign)BOOL appManage_ywbl_hlck;
/**个人中心*/
@property (nonatomic,assign)BOOL appManage_grzx;
/**移动出库记录*/
@property (nonatomic,assign)BOOL appManage_ywbl_ckjl;
/**移动等级评定*/
@property (nonatomic,assign)BOOL appManage_ywbl_djpd;
/**移动结算中心*/
@property (nonatomic,assign)BOOL appManage_ywbl_jszx;
/**工程案例*/
@property (nonatomic,assign)BOOL appManage_gcal;
/**我的服务（货主以及服务人员）*/
@property (nonatomic,assign)BOOL appManage_wdfw;
/**服务分配 （服务分配人员）*/
@property (nonatomic,assign)BOOL appManage_fwfp;
/**用户登录的ERPID的*/
@property (nonatomic,strong)NSString * lastErpId;

@property (nonatomic,assign)BOOL publicAccess;
/**当前登录的个人版用户ID*/
@property (nonatomic,assign)NSInteger pwmsUserId;
/**当前登录的个人版用户详细信息*/
@property (nonatomic,strong)RSPwmsUserModel * pwmsUser;

@property (nonatomic,strong)NSArray<RSPwmsUserListModel *> * pwmsuserList;
/**当前登陆货主标识    curErpUserCode    String    非货主用户为空字符串””*/
@property (nonatomic,strong)NSString * curErpUserCode;
/**货主用户列表    erpUserList    List<ErpUser>    非货主用户为空列表*/
@property (nonatomic,strong)NSArray<RSErpUserListModel *> * erpUserList;


@end

typedef void(^loginSuccess)(void);
@interface UserManger : NSObject

@property (nonatomic, strong) RSUserModel * userModel;

//创建用户数据的单利
+(instancetype)sharedManager;
//判断是否是登录状态
+(BOOL)isLogin;
//储存用户信息
+(void)saveUserObject:(RSUserModel *)userModel;
//获取用户基本信息
+(RSUserModel *)getUserObject;
//退出登录，清除用户信息
+(void)logoOut;
//获取的Verifykey;
+ (NSString *)Verifykey;

/**
 检查是否有登录
 
 @param viewVC 当前控制器
 @param block 登录成功执行代码
 */
+ (BOOL)checkLogin:(UIViewController *)viewVC successBlock:(loginSuccess)block;
@end
