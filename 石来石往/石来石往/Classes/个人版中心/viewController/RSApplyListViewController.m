//
//  RSApplyListViewController.m
//  石来石往
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSApplyListViewController.h"
#import "RSApplyListCell.h"
#import "RSApplyListModel.h"

#import "RSPersonalPackageViewController.h"
#import "RSSalertView.h"
@interface RSApplyListViewController ()

@property (nonatomic,strong)RSSalertView * alertView;

@property (nonatomic,strong)NSMutableArray * applyArray;

@end

@implementation RSApplyListViewController

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

- (NSMutableArray *)applyArray{
    if (!_applyArray) {
        _applyArray = [NSMutableArray array];
    }
    return _applyArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableview.estimatedRowHeight = 0;
        self.tableview.estimatedSectionFooterHeight = 0;
        self.tableview.estimatedSectionHeaderHeight = 0;
    }
    self.title = @"历史记录";
    
    [self reloadNewData];

}


- (void)reloadNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
     RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_APPLYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            /**
             个人版账户ID    id    Int
             账户名称    userName    String    主账号 账户名称和公司名称相同
             公司名称    companyName    String    主账号 账户名称和公司名称相同
             联系人电话    contactPhone    String    联系人电话
             审核结果备注    notes    String
             状态    status    Int     0 审核中 1 正常
             申请时间    createTime    String
             石来石往账户ID    sysUserId    Int
             */
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.applyArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"];
                for (int i = 0; i < array.count; i++) {
                    RSApplyListModel * applylistmodel = [[RSApplyListModel alloc]init];
                    applylistmodel.applyID = [[[array objectAtIndex:i]objectForKey:@"id"] integerValue];
                    
                    applylistmodel.companyName = [[array objectAtIndex:i]objectForKey:@"companyName"];
                    
                    applylistmodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                    
                    applylistmodel.status = [[[array objectAtIndex:i]objectForKey:@"status"] integerValue];
                    applylistmodel.sysUserId = [[[array objectAtIndex:i]objectForKey:@"sysUserId"] integerValue];
                    applylistmodel.userName = [[array objectAtIndex:i]objectForKey:@"userName"];
                    applylistmodel.contactPhone = [[array objectAtIndex:i]objectForKey:@"contactPhone"];
                     applylistmodel.notes = [[array objectAtIndex:i]objectForKey:@"notes"];
                    applylistmodel.signingMode = [[array objectAtIndex:i]objectForKey:@"signingMode"];
                    
                    [weakSelf.applyArray addObject:applylistmodel];
                }
                [weakSelf.tableview reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.applyArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * APPLYLISTCELL = @"APPLYLISTCELL";
    RSApplyListCell * cell = [tableView dequeueReusableCellWithIdentifier:APPLYLISTCELL];
    if (!cell) {
        cell = [[RSApplyListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:APPLYLISTCELL];
    }
    RSApplyListModel * applylistmodel = self.applyArray[indexPath.row];
    cell.nameFirstlabel.text = [applylistmodel.companyName substringToIndex:0];
    cell.companyLabel.text = applylistmodel.companyName;
    cell.statusBtn.tag = indexPath.row;
    cell.cancelApplyBtn.tag = indexPath.row;
    if (applylistmodel.status == 0) {
        cell.statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FFBB04"];
        [cell.statusBtn setTitle:@"编辑" forState:UIControlStateNormal];
        cell.cancelApplyBtn.hidden = NO;
        [cell.cancelApplyBtn addTarget:self action:@selector(cancelApplyAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.statusBtn addTarget:self action:@selector(editApplyAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.statusLabel.text = @"待审核";
    }else{
        cell.statusLabel.textColor = [UIColor colorWithHexColorStr:@"#BA182C"];
        [cell.statusBtn setTitle:@"重新申请" forState:UIControlStateNormal];
        cell.cancelApplyBtn.hidden = YES;
        [cell.statusBtn addTarget:self action:@selector(editApplyAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.statusLabel.text = @"审核失败";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//编辑
- (void)editApplyAction:(UIButton *)statusBtn{
    RSApplyListModel * applyListmodel = self.applyArray[statusBtn.tag];
    
    self.alertView.materialProductName = applyListmodel.contactPhone;
    self.alertView.materialTypeName = applyListmodel.companyName;
    self.alertView.applyID = applyListmodel.applyID;
    self.alertView.selectFunctionType = @"修改账号";
    [self.alertView showView];
    RSWeakself
    [self.alertView setReload:^(BOOL istrue) {
        [weakSelf reloadNewData];
    }];
    
//    RSPersonalPackageViewController * personalPackageVc = [[RSPersonalPackageViewController alloc]init];
//    personalPackageVc.applylistmodel = applyListmodel;
//    //修改或者编辑
//    personalPackageVc.ModifyStr = @"modify";
//    [self.navigationController pushViewController:personalPackageVc animated:YES];
//    personalPackageVc.reload = ^(BOOL isreload) {
//        if (isreload) {
//         [self reloadNewData];
//        }
//    };
    
}


//撤销
- (void)cancelApplyAction:(UIButton *)cancelApplyBtn{
     RSApplyListModel * applyListmodel = self.applyArray[cancelApplyBtn.tag];
    //URL_UPDATEAPPLYA_IOS
    //企业名    companyName    String    企业名/个人版名义
    //联系人电话    contactPhone    String    联系人电话
    //签约付费方式    signingMode    String    month 包月  year 包年
    //申请用户的ID    pwmsUserId    Int    申请列表里面模型的ID
    //是否取消申请    cancel    Bool    取消申请填 true
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cancelApply:applyListmodel];
    }];
    [alertView addAction:alert];
    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertView addAction:alert1];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                       alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                   }
    [self presentViewController:alertView animated:YES completion:nil];
}



- (void)cancelApply:(RSApplyListModel *)applyListmodel{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:applyListmodel.companyName forKey:@"companyName"];
    [phoneDict setObject:applyListmodel.contactPhone forKey:@"contactPhone"];
    [phoneDict setObject:applyListmodel.signingMode forKey:@"signingMode"];
    [phoneDict setObject:[NSNumber numberWithInteger:applyListmodel.applyID] forKey:@"pwmsUserId"];
    [phoneDict setObject:[NSNumber numberWithBool:true] forKey:@"cancel"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
     RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_UPDATEAPPLYA_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf reloadNewData];
            }else{
               [SVProgressHUD showErrorWithStatus:@"撤销申请失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"撤销申请失败"];
        }
    }];
}

@end
