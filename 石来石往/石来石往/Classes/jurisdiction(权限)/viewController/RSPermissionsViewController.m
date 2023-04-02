//
//  RSPermissionsViewController.m
//  权限
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSPermissionsViewController.h"
#import "UIColor+HexColor.h"
#import <SDAutoLayout.h>
#import "RSPermissionsHeaderview.h"
#import "RSDetailPermissionsViewController.h"
#import "RSPermissionsCell.h"
#import "RSPermissionsModel.h"
//新增的cell
#import "RSPermissUserCell.h"
//#define SCW [UIScreen mainScreen].bounds.size.width
//#define SCH [UIScreen mainScreen].bounds.size.height
//RSDetailPermissionsViewControllerDelegate
@interface RSPermissionsViewController ()
{
    
    
    UIImageView * _contentImage;
    
    UIImageView * _alertImage;
    
}

//@property (nonatomic,strong)UITableView * tableview;

/**添加子账号的数组*/
@property (nonatomic,strong)NSMutableArray * childAccountArray;

/**中间值名字*/
//@property (nonatomic,strong)NSString * tempName;

@end

@implementation RSPermissionsViewController

- (NSMutableArray *)childAccountArray{
    if(_childAccountArray == nil){
        _childAccountArray = [NSMutableArray array];
    }
    return _childAccountArray;
}

static NSString * PERHEADVIEW = @"perheadview";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//     self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deletePermissionsdata) name:@"deletePermissionsdata" object:nil];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.title = @"账号管理";
    if (self.userModel.appManage_qxgl == 1) {
        [self loadPermissionsNetworkData];
    }
    
//    for (int i = 0; i < self.userModel.erpUserList.count; i++) {
//        RSErpUserListModel * erpUserlistmodel = self.userModel.erpUserList[i];
//        if ([erpUserlistmodel.erpUserCode isEqualToString:self.userModel.curErpUserCode] && [erpUserlistmodel.erpUserCode isEqualToString:@"main"]) {
//            _tempName = erpUserlistmodel.erpUserName;
//            break;
//        }
//    }
    
    // 添加tableview
    [self addCustomTableview];
}
#pragma mark -- 获取权限子账号的网络数据
- (void)loadPermissionsNetworkData{
    //URL_CHILDACCOUNT_IOS
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.userModel.userID forKey:@"userId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_CHILDACCOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
             [weakSelf.childAccountArray removeAllObjects];
            if (Result ) {
                weakSelf.childAccountArray = [RSPermissionsModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                    if (weakSelf.childAccountArray.count > 0) {
                        _contentImage.hidden = YES;
                        _alertImage.hidden = YES;
                    }else{
                        _contentImage.hidden = NO;
                        _alertImage.hidden = NO;
                    }
            }else{
                _contentImage.hidden = NO;
                _alertImage.hidden = NO;
            }
            [weakSelf.tableview reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取子账号失败"];
        }
    }];
}
#pragma mark -- 添加tableview
- (void)addCustomTableview{
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCW, SCH - 49) style:UITableViewStylePlain];
//    self.tableview = tableview;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.tableview];
    
    UIImageView * contentImage = [[UIImageView alloc]init];
    contentImage.image = [UIImage imageNamed:@"矢量智能对象3"];
    contentImage.contentMode = UIViewContentModeScaleAspectFill;
    [contentImage bringSubviewToFront:self.view];
    [self.view addSubview:contentImage];
    _contentImage = contentImage;
    
    UIImageView * alertImage = [[UIImageView alloc]init];
    alertImage.image = [UIImage imageNamed:@"形状-6-拷贝-3"];
    [alertImage bringSubviewToFront:self.view];
    [self.view addSubview:alertImage];
    _alertImage = alertImage;
    
    if (JH_isIPhone_IPhoneX_All) {
        contentImage.sd_layout
        .topSpaceToView(self.view, 290)
        .centerXEqualToView(self.view)
        .widthIs(200)
        .heightIs(200);
    }else{
        contentImage.sd_layout
        .topSpaceToView(self.view, 260)
        .centerXEqualToView(self.view)
        .widthIs(200)
        .heightIs(200);
    }
    alertImage.sd_layout
    .topSpaceToView(contentImage, 34)
    .leftEqualToView(contentImage)
    .rightEqualToView(contentImage)
    .heightIs(58);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //return 2;
    if (self.userModel.appManage_qxgl == 1) {
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.userModel.erpUserList.count;
    }else{
        if (self.userModel.appManage_qxgl == 1) {
            return self.childAccountArray.count;
        }else{
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * CELL = @"PERMISSFIRST";
        RSPermissUserCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL];
        if (!cell) {
            cell = [[RSPermissUserCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL];
        }
        RSErpUserListModel * erpUserlistmodel = self.userModel.erpUserList[indexPath.row];
        if ([self.userModel.curErpUserCode isEqualToString:erpUserlistmodel.erpUserCode]) {
            cell.nameImageView.hidden = NO;
        }else{
            
            cell.nameImageView.hidden = YES;
        }
        
        if ([erpUserlistmodel.erpUserType isEqualToString:@"main"]) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@",erpUserlistmodel.erpUserName];
            cell.sonNameLabel.text = [NSString stringWithFormat:@"主账号"];
        }else{
            cell.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",erpUserlistmodel.erpUserName,erpUserlistmodel.subUserName];
            cell.sonNameLabel.text = [NSString stringWithFormat:@"子账号"];
        }
        return cell;
    }else{
         static NSString * CELL = @"PERMISSSECOND";
         RSPermissionsCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL];
         if (!cell) {
             cell = [[RSPermissionsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL];
         }
         RSPermissionsModel * perModel = self.childAccountArray[indexPath.row];
         [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:perModel.photo] placeholderImage:[UIImage imageNamed:@"大板出库"]];
         cell.nameLabel.text = [NSString stringWithFormat:@"%@",perModel.userName];
         cell.accountLabel.text = [NSString stringWithFormat:@"电话:%@",perModel.mobilePhone];
         if (perModel.erpUserStatus == 0) {
             cell.statusLabel.text = @"审核中";
             cell.statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FFB90F"];
         }else if (perModel.erpUserStatus == 1){
             cell.statusLabel.text = @"已启用";
             cell.statusLabel.textColor = [UIColor colorWithHexColorStr:@"#32CD32"];
         }else if (perModel.erpUserStatus == 2){
             cell.statusLabel.text = @"审核失败";
             cell.statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FF0000"];
         }
         return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        RSPermissionsHeaderview * permissionsHeaderview = [[RSPermissionsHeaderview alloc]initWithReuseIdentifier:PERHEADVIEW];
//        permissionsHeaderview.nameLabel.text = self.userModel.userName;
//        permissionsHeaderview.accountLabel.text = self.userModel.userPhone;
//        [permissionsHeaderview.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,self.userModel.userHead]] placeholderImage:[UIImage imageNamed:@"求真像"]];
//        permissionsHeaderview.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
        [permissionsHeaderview.addBtn addTarget:self action:@selector(addChildAccount:) forControlEvents:UIControlEventTouchUpInside];
        return permissionsHeaderview;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 61;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}

#pragma mark -- 跳转到添加自控制器界面
- (void)addChildAccount:(UIButton *)btn{
    RSDetailPermissionsViewController * detailVc = [[RSDetailPermissionsViewController alloc]init];
    //detailVc.delegate = self;
    detailVc.userModel = self.userModel;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.section == 0) {
        //这边更改了账号，需要重新获取用用户信息，并对所有的界面进行刷新的界面
        [self showImageHiddenStatus:indexPath];
//        if (self.selectUser) {
//            self.selectUser();
//        }
    }else{
        
        RSDetailPermissionsViewController * detailVc = [[RSDetailPermissionsViewController alloc]init];
        detailVc.hidesBottomBarWhenPushed = YES;
        RSPermissionsModel * perModel = self.childAccountArray[indexPath.row];
        detailVc.perModel = perModel;
        detailVc.userModel = self.userModel;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

- (void)showImageHiddenStatus:(NSIndexPath *)indexpath{
    //RSPermissUserCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.imageView.hidden = NO;
    //这边要和后台进行交互，获取你选择用户的内容，重新获取用户信息
    RSErpUserListModel * erpUserlistmodel = self.userModel.erpUserList[indexpath.row];
//    _tempName = erpUserlistmodel.erpUserName;
  //  RSPermissUserCell * cell = [self.tableview cellForRowAtIndexPath:indexpath];
//    if (![cell.nameLabel.text isEqualToString:erpUserlistmodel.erpUserName]) {
        //URL_SWITCHERPUSER_IOS
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:self.userModel.userCode forKey:@"USER_CODE"];
        [dict setObject:verifyKey forKey:@"VerifyKey"];
        [dict setObject:erpUserlistmodel.erpUserCode forKey:@"erpUserCode"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_SWITCHERPUSER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"Result"] boolValue];
                if (isresult) {
                    [user removeObjectForKey:@"oneUserModel"];
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
                    
                    //                userModel.userCode = json[@"Data"][@"userCode"];
                    
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
                    
//                    NSLog(@"=--------------------------%ld",erpUserarray.count);
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
//                    NSLog(@"++++++++++++++++++++++++++++++%ld",userModel.erpUserList.count);
                    //[weakSelf.nameBtn setTitle:weakSelf.userModel.userName forState:UIControlStateNormal];
                    // [weakSelf.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,weakSelf.userModel.userHead]] placeholderImage:[UIImage imageNamed:@"求真像"]];
                    // _namePhone.text = [NSString stringWithFormat:@"%@",weakSelf.userModel.userPhone];
                    //[weakSelf.namePhone setTitle:weakSelf.userModel.userPhone forState:UIControlStateNormal];
                    //将usermodel类型变为NSData类型
                    
                    
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userModel];
                    [user setObject:data forKey:@"oneUserModel"];
                    [user setObject:userModel.userCode forKey:@"USER_CODE"];
                    [user setObject:verifyKey forKey:@"VERIFYKEY"];
                    //用来登录判断的方式
                    [user setObject:[NSString stringWithFormat:@"0"] forKey:@"temp"];
                    [user synchronize];
            
                    weakSelf.userModel = userModel;
                    //这边要进行刷新界面和上一个界面的变化，还有就是其他界面的变化
                  
                    if (weakSelf.userModel.appManage_qxgl == 1) {
                        [weakSelf loadPermissionsNetworkData];
                    }
                      [weakSelf.tableview reloadData];
//                    NSLog(@"=========32=======================%@",weakSelf.userModel.userID);
//                    NSLog(@"=========32=======================%@",weakSelf.userModel.userName);
                    if (weakSelf.selectUser) {
                        weakSelf.selectUser(userModel,erpUserlistmodel.erpUserName);
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:@"切换账号失败"];
                }
            }else{
//              NSLog(@"========================%@",json);
                [SVProgressHUD showErrorWithStatus:@"切换账号失败"];
            }
        }];
//    }
}

/*
- (void)jumpDetailPermissionsViewController:(UIButton *)btn{
    RSDetailPermissionsViewController * detailVc = [[RSDetailPermissionsViewController alloc]init];
    detailVc.delegate = self;
    [self.navigationController pushViewController:detailVc animated:YES];
}
*/

//#pragma mark -- RSDetailPermissionsViewControllerDelegate 代理方法
////添加
//- (void)saveModelData:(RSPermissionsModel *)perModel{
//    [self.childAccountArray addObject:perModel];
//    _alertImage.hidden = YES;
//    _contentImage.hidden = YES;
//    [self.tableview reloadData];
//}
//
//
////删除
//- (void)deletchModelData:(RSPermissionsModel *)perModel{
//    
//    
//    
//    for (int i = 0; i < self.childAccountArray.count; i++) {
//        RSPermissionsModel * Model = self.childAccountArray[i];
//        if ( [Model.userName isEqualToString:perModel.userName] && [Model.userIdentity isEqualToString:perModel.userIdentity] && [Model.mobilePhone isEqualToString:perModel.mobilePhone] ) {
//            [self.childAccountArray removeObjectAtIndex:i];
//         
//            if (self.childAccountArray.count == 0) {
//                _alertImage.hidden = NO;
//                _contentImage.hidden = NO;
//            }
//            
//        }
//    }
//     
//     [self.tableview reloadData];
//    
//}
//
////修改
//- (void)ModifyModeData:(RSPermissionsModel *)perModel{
//    
//    for (int i = 0; i < self.childAccountArray.count; i++) {
//        RSPermissionsModel * model = self.childAccountArray[i];
//        
//        if ( [model.userName isEqualToString:perModel.userName] && [model.userIdentity isEqualToString:perModel.userIdentity] && [model.mobilePhone isEqualToString:perModel.mobilePhone] ) {
//           
//            [self.childAccountArray replaceObjectAtIndex:i withObject:perModel];
//            
//        }
//        
//        
//    }
//    [self.tableview reloadData];
//    
//    
//    
//}


- (void)deletePermissionsdata{
    [self loadPermissionsNetworkData];
}



- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
