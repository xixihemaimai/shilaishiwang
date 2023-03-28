//
//  RSUserModel.m
//  石来石往
//
//  Created by mac on 17/6/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSUserModel.h"

#import "RSLoginViewController.h"

@implementation RSUserModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    //[self yy_modelEncodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.accType forKey:@"accType"];
    [aCoder encodeObject:self.createUser forKey:@"createUser"];
    [aCoder encodeObject:self.emUid forKey:@"emUid"];
    [aCoder encodeObject:self.erploginKey forKey:@"erploginKey"];
    [aCoder encodeObject:self.erppassWord forKey:@"erppassWord"];
    
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.inviteCode forKey:@"inviteCode"];
    [aCoder encodeObject:self.identityId forKey:@"identityId"];
    [aCoder encodeObject:self.level forKey:@"level"];
    [aCoder encodeObject:self.loginKey forKey:@"loginKey"];
    
    
    
    [aCoder encodeObject:self.qqUid forKey:@"qqUid"];
    [aCoder encodeInteger:self.parentId forKey:@"parentId"];
    [aCoder encodeObject:self.passWord forKey:@"passWord"];
    [aCoder encodeObject:self.roleId forKey:@"roleId"];
    
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.updateUser forKey:@"updateUser"];
    [aCoder encodeObject:self.userCode forKey:@"userCode"];
    [aCoder encodeObject:self.userHead forKey:@"userHead"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    
    [aCoder encodeObject:self.userPhone forKey:@"userPhone"];
    [aCoder encodeObject:self.userType forKey:@"userType"];
    [aCoder encodeObject:self.wcUid forKey:@"wcUid"];
    [aCoder encodeObject:self.orgName forKey:@"orgName"];
    
    
    
    
    
    [aCoder encodeBool:self.SysManage forKey:@"SysManage"];
    [aCoder encodeBool:self.webManage forKey:@"webManage"];
    [aCoder encodeBool:self.appManage forKey:@"appManage"];
    [aCoder encodeObject:self.lastErpId forKey:@"lastErpId"];
    
    
    [aCoder encodeBool:self.appManage_qxgl forKey:@"appManage_qxgl"];
    [aCoder encodeBool:self.appManage_sc forKey:@"appManage_sc"];
    [aCoder encodeBool:self.appManage_tppp forKey:@"appManage_tppp"];
    [aCoder encodeBool:self.appManage_sq forKey:@"appManage_sq"];
    
    [aCoder encodeBool:self.appManage_ywbl forKey:@"appManage_ywbl"];
    [aCoder encodeBool:self.appManage_ywbl_bbzx forKey:@"appManage_ywbl_bbzx"];
    [aCoder encodeBool:self.appManage_ywbl_dbck forKey:@"appManage_ywbl_dbck"];
    [aCoder encodeBool:self.appManage_ywbl_hlck forKey:@"appManage_ywbl_hlck"];
    [aCoder encodeBool:self.appManage_grzx forKey:@"appManage_grzx"];
    [aCoder encodeBool:self.appManage_ywbl_ckjl forKey:@"appManage_ywbl_ckjl"];
    [aCoder encodeBool:self.appManage_ywbl_djpd forKey:@"appManage_ywbl_djpd"];
    [aCoder encodeBool:self.appManage_ywbl_jszx forKey:@"appManage_ywbl_jszx"];
    [aCoder encodeBool:self.appManage_wdfw forKey:@"appManage_wdfw"];
    [aCoder encodeBool:self.appManage_fwfp forKey:@"appManage_fwfp"];
    [aCoder encodeBool:self.appManage_gcal forKey:@"appManage_gcal"];
    [aCoder encodeBool:self.publicAccess forKey:@"publicAccess"];
    
    [aCoder encodeInteger:self.pwmsUserId forKey:@"pwmsUserId"];
    [aCoder encodeObject:self.pwmsUser forKey:@"pwmsUser"];
    [aCoder encodeObject:self.pwmsuserList forKey:@"pwmsuserList"];
    [aCoder encodeObject:self.erpUserList forKey:@"erpUserList"];
    [aCoder encodeObject:self.curErpUserCode forKey:@"curErpUserCode"];
    
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.accType= [aDecoder decodeObjectForKey:@"accType"];
        self.createUser = [aDecoder decodeObjectForKey:@"createUser"];
        self.emUid = [aDecoder decodeObjectForKey:@"emUid"];
        self.erploginKey = [aDecoder decodeObjectForKey:@"erploginKey"];
        self.erppassWord = [aDecoder decodeObjectForKey:@"erppassWord"];
        
        
        
        self.userID= [aDecoder decodeObjectForKey:@"userID"];
        self.inviteCode = [aDecoder decodeObjectForKey:@"inviteCode"];
        self.identityId = [aDecoder decodeObjectForKey:@"identityId"];
        self.level = [aDecoder decodeObjectForKey:@"level"];
        self.loginKey = [aDecoder decodeObjectForKey:@"loginKey"];
        
        self.qqUid = [aDecoder decodeObjectForKey:@"qqUid"];
        self.parentId = [aDecoder decodeIntegerForKey:@"parentId"];
        self.passWord = [aDecoder decodeObjectForKey:@"passWord"];
        self.roleId = [aDecoder decodeObjectForKey:@"roleId"];
        
        
        
        self.status= [aDecoder decodeObjectForKey:@"status"];
        self.updateUser = [aDecoder decodeObjectForKey:@"updateUser"];
        self.userCode = [aDecoder decodeObjectForKey:@"userCode"];
        self.userHead = [aDecoder decodeObjectForKey:@"userHead"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.userPhone = [aDecoder decodeObjectForKey:@"userPhone"];
        self.userType = [aDecoder decodeObjectForKey:@"userType"];
        self.wcUid = [aDecoder decodeObjectForKey:@"wcUid"];
        self.orgName = [aDecoder decodeObjectForKey:@"orgName"];
        
        self.lastErpId = [aDecoder decodeObjectForKey:@"lastErpId"];
        
        self.SysManage= [aDecoder decodeBoolForKey:@"SysManage"];
        self.appManage = [aDecoder decodeBoolForKey:@"appManage"];
        self.webManage = [aDecoder decodeBoolForKey:@"webManage"];
        self.appManage_qxgl = [aDecoder decodeBoolForKey:@"appManage_qxgl"];
        self.appManage_sc = [aDecoder decodeBoolForKey:@"appManage_sc"];
        
        self.appManage_tppp = [aDecoder decodeBoolForKey:@"appManage_tppp"];
        self.appManage_sq = [aDecoder decodeBoolForKey:@"appManage_sq"];
        self.appManage_ywbl = [aDecoder decodeBoolForKey:@"appManage_ywbl"];
        
        
        self.appManage_ywbl_bbzx = [aDecoder decodeBoolForKey:@"appManage_ywbl_bbzx"];
        self.appManage_ywbl_dbck = [aDecoder decodeBoolForKey:@"appManage_ywbl_dbck"];
        self.appManage_ywbl_hlck = [aDecoder decodeBoolForKey:@"appManage_ywbl_hlck"];
        self.appManage_grzx = [aDecoder decodeBoolForKey:@"appManage_grzx"];
        self.appManage_ywbl_ckjl = [aDecoder decodeBoolForKey:@"appManage_ywbl_ckjl"];
        self.appManage_ywbl_djpd = [aDecoder decodeBoolForKey:@"appManage_ywbl_djpd"];
        self.appManage_ywbl_jszx = [aDecoder decodeBoolForKey:@"appManage_ywbl_jszx"];
        self.appManage_gcal = [aDecoder decodeBoolForKey:@"appManage_gcal"];
        self.appManage_wdfw = [aDecoder decodeBoolForKey:@"appManage_wdfw"];
        self.appManage_fwfp = [aDecoder decodeBoolForKey:@"appManage_fwfp"];
        
        self.publicAccess = [aDecoder decodeBoolForKey:@"publicAccess"];
        
        self.pwmsUserId = [aDecoder decodeIntegerForKey:@"pwmsUserId"];
        self.pwmsUser = [aDecoder decodeObjectForKey:@"pwmsUser"];
        self.pwmsuserList = [aDecoder decodeObjectForKey:@"pwmsuserList"];
        self.curErpUserCode = [aDecoder decodeObjectForKey:@"curErpUserCode"];
        self.erpUserList = [aDecoder decodeObjectForKey:@"erpUserList"];
    }
    return self;
}




+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"userID" : @"id"
             };
}

@end

@implementation UserManger

//创建用户数据的单利
+(instancetype)sharedManager{
    static UserManger * usermanger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        usermanger = [[UserManger alloc]init];
    });
    return usermanger;
}
//创建这个获取用户信息
- (instancetype)init{
    if (self = [super init]) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData * data = [userDefault objectForKey:@"oneUserModel"];
        RSUserModel * userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (userModel != nil) {
            self.userModel = userModel;
        }
    }
    return self;
}
//判断是否是登录状态
+ (BOOL)isLogin{
    BOOL loginState;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefault objectForKey:@"oneUserModel"];
    if (data.length > 0) {
        loginState = YES;
    }else{
        loginState = NO;
    }
    return loginState;
}
//储存用户信息
+(void)saveUserObject:(RSUserModel *)userModel{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userModel];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:data forKey:[NSString stringWithFormat:@"oneUserModel"]];
}
//获取用户基本信息
+(RSUserModel *)getUserObject{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefault objectForKey:@"oneUserModel"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data ];
}
//退出登录，清除用户信息
+(void)logoOut{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oneUserModel"];
}

//获取的token;
+ (NSString *)Verifykey{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString * Verifykey = [userDefault objectForKey:@"VERIFYKEY"];
//    RSUserModel * userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return Verifykey;
}

/**
 检查是否有登录
 
 @param viewVC 当前控制器
 @param block 登录成功执行代码
 */
+ (BOOL)checkLogin:(UIViewController *)viewVC successBlock:(loginSuccess)block{
    if (![UserManger isLogin]) {
//        UINavigationController *loginNav = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        RSMyNavigationViewController * navi = [[RSMyNavigationViewController alloc]initWithRootViewController:loginVc];
        
//        LoginMenuViewController *loginVC = loginNav.viewControllers.firstObject;
//        if (loginVC != nil) {
//            loginVC.needLogin = YES;
//            [loginVC loginSuccessAction:block];
//        }
        navi.modalPresentationStyle = 0;
        [viewVC presentViewController:navi animated:YES completion:nil];
        return NO;
    }else{
        block();
        return YES;
    }
}

@end


