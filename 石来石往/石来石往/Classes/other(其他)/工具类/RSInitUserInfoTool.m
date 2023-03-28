//
//  RSInitUserInfoTool.m
//  石来石往
//
//  Created by rsxx on 2018/2/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSInitUserInfoTool.h"
#import "RSUserModel.h"
#import "MiPushSDK.h"

@implementation RSInitUserInfoTool

+ (void)registermodelUSER_CODE:(NSString *)USER_CODE andVERIFYKEY:(NSString *)VERIFYKEY andViewController:(UIViewController *)weakSelf andObtain:(Obtain)obtain{
    NSMutableDictionary *request = [NSMutableDictionary dictionary];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults]; 
   [request setObject:USER_CODE forKey:@"USER_CODE"];
   NSData *dataJson = [NSJSONSerialization dataWithJSONObject:request options:0 error:nil];
   NSString *dataStr = [[NSString alloc]initWithData:dataJson encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
   NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":VERIFYKEY,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GET_SINGLE_USER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        CLog(@"============111111111================%@",json);
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
//                [user removeObjectForKey:@"oneUserModel"];
                [UserManger logoOut];
                RSUserModel * userModel = [[RSUserModel alloc]init];
                
                
                userModel.accType = json[@"Data"][@"accType"];
                userModel.createUser = json[@"Data"][@"createUser"];
                userModel.emUid = json[@"Data"][@"emUid"];
                userModel.erploginKey = json[@"Data"][@"erploginKey"];
                userModel.erppassWord = json[@"Data"][@"erppassWord"];
                userModel.userID = json[@"Data"][@"id"];
                userModel.identityId = json[@"Data"][@"identityId"];
                userModel.inviteCode = json[@"Data"][@"inviteCode"];
                userModel.level = json[@"Data"][@"level"];
                userModel.loginKey = json[@"Data"][@"loginKey"];
                
                userModel.parentId = [json[@"Data"][@"parentId"] integerValue];
                
                userModel.passWord = json[@"Data"][@"passWord"];
                
                userModel.qqUid = json[@"Data"][@"qqUid"];
                
                userModel.roleId = json[@"Data"][@"roleId"];
                
                userModel.status = json[@"Data"][@"status"];
                
                userModel.updateUser = json[@"Data"][@"updateUser"];
                
                userModel.userCode = json[@"Data"][@"userCode"];
                
                userModel.userHead = json[@"Data"][@"userHead"];
                
                userModel.userName = json[@"Data"][@"userName"];
                
                userModel.userPhone = json[@"Data"][@"userPhone"];
                
                userModel.userType = json[@"Data"][@"userType"];
                
                userModel.wcUid = json[@"Data"][@"wcUid"];
                
                
                userModel.lastErpId = json[@"Data"][@"lastErpId"];
                
                userModel.orgName = json[@"Data"][@"orgName"];
        
                userModel.SysManage = [json[@"Data"][@"access"][@"SysManage"] boolValue];
                
                userModel.appManage = [json[@"Data"][@"access"][@"appManage"] boolValue];
                
                userModel.webManage = [json[@"Data"][@"access"][@"webManage"] boolValue];
                
                userModel.appManage_qxgl = [json[@"Data"][@"access"][@"appManage_qxgl"] boolValue];
                
                userModel.appManage_sc = [json[@"Data"][@"access"][@"appManage_sc"] boolValue];
                
                userModel.appManage_sq = [json[@"Data"][@"access"][@"appManage_sq"] boolValue];
                
                userModel.appManage_tppp = [json[@"Data"][@"access"][@"appManage_tppp"] boolValue];
                
                userModel.appManage_ywbl = [json[@"Data"][@"access"][@"appManage_ywbl"] boolValue];
                
                userModel.appManage_ywbl_bbzx = [json[@"Data"][@"access"][@"appManage_ywbl_bbzx"] boolValue];
                
                userModel.appManage_ywbl_dbck = [json[@"Data"][@"access"][@"appManage_ywbl_dbck"] boolValue];
               
                
                
                userModel.appManage_ywbl_hlck = [json[@"Data"][@"access"][@"appManage_ywbl_hlck"] boolValue];
                
                userModel.appManage_grzx = [json[@"Data"][@"access"][@"appManage_grzx"] boolValue];
                
                userModel.publicAccess = [json[@"Data"][@"access"][@"publicAccess"] boolValue];
                
                userModel.appManage_ywbl_ckjl = [json[@"Data"][@"access"][@"appManage_ywbl_ckjl"] boolValue];
                
                userModel.appManage_ywbl_djpd = [json[@"Data"][@"access"][@"appManage_ywbl_djpd"] boolValue];
                
                userModel.appManage_ywbl_jszx = [json[@"Data"][@"access"][@"appManage_ywbl_jszx"] boolValue];
                
                userModel.appManage_gcal = [json[@"Data"][@"access"][@"appManage_gcal"] boolValue];
                userModel.appManage_fwfp = [json[@"Data"][@"access"][@"appManage_fwfp"] boolValue];

                userModel.appManage_wdfw = [json[@"Data"][@"access"][@"appManage_wdfw"] boolValue];
                
                
                
                userModel.pwmsUserId = [json[@"Data"][@"pwmsUserId"] integerValue];
                
                userModel.curErpUserCode = json[@"Data"][@"curErpUserCode"];
                
                
                
                RSPwmsUserModel * pwmsUserModel = [[RSPwmsUserModel alloc]init];
                pwmsUserModel.DBGL =  [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL"] boolValue];
                
                pwmsUserModel.DBGL_BBZX =  [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_BBZX"] boolValue];
                pwmsUserModel.DBGL_BBZX_CKMX = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_BBZX_CKMX"] boolValue];
                pwmsUserModel.DBGL_BBZX_KCLS = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_BBZX_KCLS"] boolValue];
                
                 pwmsUserModel.DBGL_BBZX_KCYE = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_BBZX_KCYE"] boolValue];
                pwmsUserModel.DBGL_BBZX_RKMX = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_BBZX_RKMX"] boolValue];
                pwmsUserModel.DBGL_DBCK = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_DBCK"] boolValue];
                
                pwmsUserModel.DBGL_DBCK_JGCK = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_DBCK_JGCK"] boolValue];
                
                pwmsUserModel.DBGL_DBCK_PKCK = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_DBCK_PKCK"] boolValue];
                
                 pwmsUserModel.DBGL_DBCK_XSCK = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_DBCK_XSCK"] boolValue];
                
                  pwmsUserModel.DBGL_DBRK = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_DBRK"] boolValue];
                
                pwmsUserModel.DBGL_DBRK_CGRK = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_DBRK_CGRK"] boolValue];
                
                pwmsUserModel.DBGL_DBRK_JGRK = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_DBRK_JGRK"] boolValue];
                
                pwmsUserModel.DBGL_DBRK_PYRK = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_DBRK_PYRK"] boolValue];
                
                pwmsUserModel.DBGL_KCGL = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_KCGL"] boolValue];
                pwmsUserModel.DBGL_KCGL_DB = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_KCGL_DB"] boolValue];
                pwmsUserModel.DBGL_KCGL_YCCL = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_KCGL_YCCL"] boolValue];
                
                pwmsUserModel.HLGL = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL"] boolValue];
                pwmsUserModel.HLGL_BBZX = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_BBZX"] boolValue];
                 pwmsUserModel.HLGL_BBZX_CKMX = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_BBZX_CKMX"] boolValue];
                pwmsUserModel.HLGL_BBZX_KCLS = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_BBZX_KCLS"] boolValue];
                pwmsUserModel.HLGL_BBZX_KCYE = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_BBZX_KCYE"] boolValue];
                pwmsUserModel.HLGL_BBZX_RKMX = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_BBZX_RKMX"] boolValue];
                pwmsUserModel.HLGL_HLCK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLCK"] boolValue];
                pwmsUserModel.HLGL_HLCK_JGCK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLCK_JGCK"] boolValue];
                pwmsUserModel.HLGL_HLCK_PKCK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLCK_PKCK"] boolValue];
                pwmsUserModel.HLGL_HLCK_XSCK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLCK_XSCK"] boolValue];
                pwmsUserModel.HLGL_HLRK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLRK"] boolValue];
                pwmsUserModel.HLGL_HLCK_JGCK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLCK_JGCK"] boolValue];
                pwmsUserModel.HLGL_HLCK_PKCK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLCK_PKCK"] boolValue];
                pwmsUserModel.HLGL_HLCK_XSCK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLCK_XSCK"] boolValue];
                pwmsUserModel.HLGL_HLRK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLRK"] boolValue];
                pwmsUserModel.HLGL_HLRK_CGRK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLRK_CGRK"] boolValue];
                pwmsUserModel.HLGL_HLRK_JGRK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLRK_JGRK"] boolValue];
                pwmsUserModel.HLGL_HLRK_PYRK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_HLRK_PYRK"] boolValue];
                pwmsUserModel.HLGL_KCGL = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_KCGL"] boolValue];
                pwmsUserModel.HLGL_KCGL_DB = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_KCGL_DB"] boolValue];
                pwmsUserModel.HLGL_KCGL_YCCL = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_KCGL_YCCL"] boolValue];
                pwmsUserModel.JCSJ = [json[@"Data"][@"pwmsUser"][@"access"][@"JCSJ"] boolValue];
                pwmsUserModel.JCSJ_CKGL = [json[@"Data"][@"pwmsUser"][@"access"][@"JCSJ_CKGL"] boolValue];
                 pwmsUserModel.JCSJ_WLZD = [json[@"Data"][@"pwmsUser"][@"access"][@"JCSJ_WLZD"] boolValue];
                
                 pwmsUserModel.TYQX = [json[@"Data"][@"pwmsUser"][@"access"][@"TYQX"] boolValue];
                
                pwmsUserModel.XTGL = [json[@"Data"][@"pwmsUser"][@"access"][@"XTGL"] boolValue];
                pwmsUserModel.XTGL_JSGL = [json[@"Data"][@"pwmsUser"][@"access"][@"XTGL_JSGL"] boolValue];
                
                pwmsUserModel.XTGL_YHGL = [json[@"Data"][@"pwmsUser"][@"access"][@"XTGL_YHGL"] boolValue];
                pwmsUserModel.XTGL_MBGL = [json[@"Data"][@"pwmsUser"][@"access"][@"XTGL_MBGL"] boolValue];
                
                
                pwmsUserModel.JCSJ_JGC = [json[@"Data"][@"pwmsUser"][@"access"][@"JCSJ_JGC"] boolValue];
                
                pwmsUserModel.HLGL_BBZX_JGGDCZ = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_BBZX_JGGDCZ"] boolValue];
                pwmsUserModel.HLGL_BBZX_JGGDCK = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_BBZX_JGGDCK"] boolValue];
                pwmsUserModel.HLGL_KCGL_XHZS = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_KCGL_XHZS"] boolValue];
                pwmsUserModel.DBGL_KCGL_XHZS = [json[@"Data"][@"pwmsUser"][@"access"][@"DBGL_KCGL_XHZS"] boolValue];
                pwmsUserModel.HLGL_BBZX_CCL = [json[@"Data"][@"pwmsUser"][@"access"][@"HLGL_BBZX_CCL"] boolValue];
                
                pwmsUserModel.companyName = json[@"Data"][@"pwmsUser"][@"companyName"];
                pwmsUserModel.pwmsUserModelID = [json[@"Data"][@"pwmsUser"][@"id"] integerValue];
                pwmsUserModel.parentId = [json[@"Data"][@"pwmsUser"][@"parentId"]integerValue];
                pwmsUserModel.roleId = [json[@"Data"][@"pwmsUser"][@"roleId"] integerValue];
                pwmsUserModel.sysUserId = [json[@"Data"][@"pwmsUser"][@"sysUserId"]integerValue];
                pwmsUserModel.userName = json[@"Data"][@"pwmsUser"][@"userName"];
                pwmsUserModel.userType = json[@"Data"][@"pwmsUser"][@"userType"];
                
                userModel.pwmsUser = pwmsUserModel;
                
                NSMutableArray * array = [NSMutableArray array];
                NSMutableArray * tempArray = [NSMutableArray array];
                array = json[@"Data"][@"pwmsuserList"];
                for (int i = 0; i < array.count; i++) {
                    RSPwmsUserListModel * pwmsUserListModel = [[RSPwmsUserListModel alloc]init];
                    pwmsUserListModel.companyName = [[array objectAtIndex:i]objectForKey:@"companyName"];
                    pwmsUserListModel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                    pwmsUserListModel.pwmsUserListID =  [[[array objectAtIndex:i]objectForKey:@"id"] integerValue];
                    pwmsUserListModel.status =  [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
                    pwmsUserListModel.sysUserId = [[[array objectAtIndex:i]objectForKey:@"sysUserId"]integerValue];
                    pwmsUserListModel.userName = [[array objectAtIndex:i]objectForKey:@"userName"];
                    [tempArray addObject:pwmsUserListModel];
                 
                }
                userModel.pwmsuserList = tempArray;
                
                NSMutableArray * erpUserarray = [NSMutableArray array];
                NSMutableArray * erpUsertempArray = [NSMutableArray array];
                erpUserarray = json[@"Data"][@"erpUserList"];

                for (int j = 0; j < erpUserarray.count; j++) {
                    RSErpUserListModel * erpUserlistmodel = [[RSErpUserListModel alloc]init];
                    erpUserlistmodel.erpUserCode = [[erpUserarray objectAtIndex:j]objectForKey:@"erpUserCode"];
                    erpUserlistmodel.erpUserName = [[erpUserarray objectAtIndex:j]objectForKey:@"erpUserName"];
                    erpUserlistmodel.erpUserType = [[erpUserarray objectAtIndex:j]objectForKey:@"erpUserType"];
                    erpUserlistmodel.parentId =  [[[erpUserarray objectAtIndex:j]objectForKey:@"parentId"] integerValue];
                    erpUserlistmodel.subUserIdentity = [[erpUserarray objectAtIndex:j]objectForKey:@"subUserIdentity"];
                    erpUserlistmodel.subUserName = [[erpUserarray objectAtIndex:j]objectForKey:@"subUserName"];
                    erpUserlistmodel.sysUserId = [[[erpUserarray objectAtIndex:j]objectForKey:@"sysUserId"]integerValue];
                    [erpUsertempArray addObject:erpUserlistmodel];
                }
                userModel.erpUserList = erpUsertempArray;
                
                
                
                //[weakSelf.nameBtn setTitle:weakSelf.userModel.userName forState:UIControlStateNormal];
                // [weakSelf.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,weakSelf.userModel.userHead]] placeholderImage:[UIImage imageNamed:@"求真像"]];
                // _namePhone.text = [NSString stringWithFormat:@"%@",weakSelf.userModel.userPhone];
                //[weakSelf.namePhone setTitle:weakSelf.userModel.userPhone forState:UIControlStateNormal];
                
                
                
                //将usermodel类型变为NSData类型
                [MiPushSDK setAccount:[NSString stringWithFormat:@"%@",userModel.userID]];
                [MiPushSDK getAllAccountAsync];
                
                
                
//                NSData * data = [NSKeyedArchiver archivedDataWithRootObject:userModel];
//                [user setObject:data forKey:@"oneUserModel"];
                
                //保存用户信息
                [UserManger saveUserObject:userModel];
                
                applegate.ERPID = userModel.lastErpId;
//                [user setObject:USER_CODE forKey:@"USER_CODE"];
                [user setObject:VERIFYKEY forKey:@"VERIFYKEY"];
                //用来登录判断的方式
//                [user setObject:[NSString stringWithFormat:@"0"] forKey:@"temp"];
//                [user synchronize];
                obtain(true);
                
                //[SVProgressHUD showSuccessWithStatus:@"登录成功"];
            }else{
                
                obtain(false);
                if ([json[@"MSG_CODE"] isEqualToString:@"U_CHECK_NO_PERMISION"]) {
//                    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                    NSData * data = [user objectForKey:@"oneUserModel"];
                    RSUserModel * userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                    applegate.ERPID = userModel.lastErpId;
                    [SVProgressHUD showInfoWithStatus:@"无该市场权限"];
                }
//                else if ([json[@"MSG_CODE"] isEqualToString:@"U_NOT_LOGIN"]){
//                    if (weakSelf != nil) {
//                        if ([weakSelf isKindOfClass:[RSMainTabBarViewController class]]) {
//                        }else{
//                            [weakSelf.navigationController popViewControllerAnimated:YES];
//                        }
//                    }
//                    applegate.ERPID = @"0";
//                }
                else{
                    applegate.ERPID = @"0";
//                      [user removeObjectForKey:@"oneUserModel"];
                    [UserManger logoOut];
                    [user removeObjectForKey:@"VERIFYKEY"];
//                    [user removeObjectForKey:@"USER_CODE"];
//                    [user setObject:[NSString stringWithFormat:@"2"] forKey:@"temp"];
//                    [user synchronize];
//                    if (weakSelf != nil) {
//                        if ([weakSelf isKindOfClass:[RSMainTabBarViewController class]]) {
//                        }else{
//                            [weakSelf.navigationController popViewControllerAnimated:YES];
//                        }
//                    }
                }
            }
        }else{
            
            obtain(false);
//            [user removeObjectForKey:@"oneUserModel"];
            [UserManger logoOut];
            [user removeObjectForKey:@"VERIFYKEY"];
//            [user removeObjectForKey:@"USER_CODE"];
//            [user setObject:[NSString stringWithFormat:@"2"] forKey:@"temp"];
//            [user synchronize];
            applegate.ERPID = @"0";
//            if (weakSelf != nil) {
//                if ([weakSelf isKindOfClass:[RSMainTabBarViewController class]]) {
//                }else{
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                }
//            }
        }
    }];
}
@end
