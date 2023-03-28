//
//  RSPwmsUserViewController.m
//  石来石往
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPwmsUserViewController.h"
#import "RSPwmsAccountCell.h"
#import "RSPwmsUserAccountCell.h"
#import "RSPersonalPackageViewController.h"
#import "RSSalertView.h"
#import "RSApplyListViewController.h"

@interface RSPwmsUserViewController ()

@property (nonatomic,strong)RSSalertView * alertView;


@end

@implementation RSPwmsUserViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}



- (RSSalertView *)alertView
{
    if (!_alertView) {
        self.alertView = [[RSSalertView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 139.5, SCW - 66 , 279)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        //self.alertView.delegate = self;
        self.alertView.layer.cornerRadius = 15;
    }
    return _alertView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号管理";

//    UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    editBtn.frame = CGRectMake(0,0,50, 50);
//   // [editBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
//    [editBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//    editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:editBtn];
//    self.navigationItem.rightBarButtonItem = rightitem;
//    [editBtn addTarget:self action:@selector(sureApplyPersonalWmsAction:) forControlEvents:UIControlEventTouchUpInside];

    
   // [self creatBoottomView];
    
}



//- (void)creatBoottomView{
//    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 55)];
//    bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    
//    UIButton * outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    outBtn.frame = CGRectMake(0, 0, SCW, bottomView.yj_height);
//    [outBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
//    [outBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//    outBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//    [bottomView addSubview:outBtn];
//
//    UIView * hengView = [[UIView alloc]initWithFrame:CGRectMake(0, bottomView.yj_height - 1, SCW, 1)];
//    hengView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
//    [bottomView addSubview:hengView];
//    self.tableview.tableFooterView = bottomView;
//}

//这边是个人申请个人版的列表，是没有审核通过的
//- (void)reloadAccountNewData{
//    //URL_APPLYLIST_IOS
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    RSWeakself
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_APPLYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//
//        if (success) {
//        }else{
//        }
//    }];
//}




//确定
- (void)sureApplyPersonalWmsAction:(UIButton *)editBtn{
    //URL_APPLYPERSONALWMS_IOS
    //companyName

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //userType = employee;
    if ([self.usermodel.pwmsUser.userType isEqualToString:@"employee"]) {
        return 1;
    }else{
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
         return self.usermodel.pwmsuserList.count;
    }else if(section == 1){
        return 1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }else if(section == 1){
        return 10;
    }else{
        return 10;
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString * PWMSACCOUNTCELLID = @"PWMSACCOUNTCELLID";
        RSPwmsAccountCell * cell = [tableView dequeueReusableCellWithIdentifier:PWMSACCOUNTCELLID];
        if (!cell) {
            cell = [[RSPwmsAccountCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PWMSACCOUNTCELLID];
        }
        RSPwmsUserListModel * pwmsUserListmodel = self.usermodel.pwmsuserList[indexPath.row];
        if (self.usermodel.pwmsUser.pwmsUserModelID  == pwmsUserListmodel.pwmsUserListID) {
            cell.accountSelectImageView.hidden = NO;
        }else{
            cell.accountSelectImageView.hidden = YES;
        }
        if ([self.usermodel.pwmsUser.userType isEqualToString:@"employee"]) {
            
            cell.accountAllNameLabel.text = pwmsUserListmodel.userName;
              cell.accountNameLabel.text = [NSString stringWithFormat:@"%@",[pwmsUserListmodel.userName substringToIndex:pwmsUserListmodel.userName.length - (pwmsUserListmodel.userName.length - 1)]];
        }else{
            
             cell.accountAllNameLabel.text = pwmsUserListmodel.companyName;
              cell.accountNameLabel.text = [NSString stringWithFormat:@"%@",[pwmsUserListmodel.companyName substringToIndex:pwmsUserListmodel.companyName.length - (pwmsUserListmodel.companyName.length - 1)]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 1){
        static NSString * PWMSUSERACCOUNTSECONDID = @"PWMSUSERACCOUNTSECONDID";
        RSPwmsUserAccountCell * cell = [tableView dequeueReusableCellWithIdentifier:PWMSUSERACCOUNTSECONDID];
        if (!cell) {
            cell = [[RSPwmsUserAccountCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PWMSUSERACCOUNTSECONDID];
        }
        cell.addAccountLabel.text = @"添加公司";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString * PWMSUSERACCOUNTTHIRDID = @"PWMSUSERACCOUNTTHIRDID";
        RSPwmsUserAccountCell * cell = [tableView dequeueReusableCellWithIdentifier:PWMSUSERACCOUNTTHIRDID];
        if (!cell) {
            cell = [[RSPwmsUserAccountCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PWMSUSERACCOUNTTHIRDID];
        }
        cell.accountImageView.hidden = YES;
        cell.accountImageView.sd_layout
        .widthIs(0);
        cell.addAccountLabel.text = @"查看历史";
        cell.addAccountLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        //URL_SWITCHACCOUNT_IOS
        //NSLog(@"切换账号");
         RSPwmsUserListModel * pwmsUserListmodel = self.usermodel.pwmsuserList[indexPath.row];
        [self switchAccount:pwmsUserListmodel.pwmsUserListID];
    }else if(indexPath.section == 1){
        self.alertView.selectFunctionType = @"添加公司";
         [self.alertView showView];
    }else{
        RSApplyListViewController * applylistVc = [[RSApplyListViewController alloc]init];
        [self.navigationController pushViewController:applylistVc animated:YES];
    }
}


- (void)switchAccount:(NSInteger)accountId{
   // NSString * str = @"http://192.168.1.128:8080/slsw/pwms/switchAccount.do";
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSString * user_code = [user objectForKey:@"USER_CODE"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:accountId] forKey:@"userId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SWITCHACCOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    //这边要重新获取一遍个人版的信息
                    [RSInitUserInfoTool registermodelUSER_CODE:user_code andVERIFYKEY:verifyKey andViewController:weakSelf andObtain:^(BOOL isValue) {
                        if (isValue) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"retrievingUserInformation" object:nil];
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"获取失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }];
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
