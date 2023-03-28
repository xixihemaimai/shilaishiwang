//
//  RSUserManagementViewController.m
//  石来石往
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSUserManagementViewController.h"
#import "RSUserManagementCell.h"
#import "RSNewUserManagementViewController.h"
#import "RSUserManagementModel.h"

#import "RSSalertView.h"
#import "RSRoleModel.h"

@interface RSUserManagementViewController ()

@property (nonatomic,strong)NSMutableArray * userArray;

@property (nonatomic,strong)RSSalertView * alertView;

@property (nonatomic,strong)NSMutableArray * userManagementArray;
@end

@implementation RSUserManagementViewController

- (NSMutableArray *)userManagementArray{
    if (!_userManagementArray) {
        _userManagementArray = [NSMutableArray array];
    }
    return _userManagementArray;
}

- (RSSalertView *)alertView
{
    if (!_alertView) {
        self.alertView = [[RSSalertView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 175.5, SCW - 66 , 351)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        //self.alertView.delegate = self;
        self.alertView.layer.cornerRadius = 15;
    }
    return _alertView;
}


- (NSMutableArray *)userArray{
    if (!_userArray) {
        _userArray = [NSMutableArray array];
    }
    return _userArray;
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"用户管理";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.tableview.estimatedRowHeight = 0;
//        self.tableview.estimatedSectionFooterHeight = 0;
//        self.tableview.estimatedSectionHeaderHeight = 0;
//    }

    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addBtn setTitle:@"新增" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    [addBtn addTarget:self action:@selector(addNewUserManagementAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self reloadUserManagementNewData];
    if (self.usermodel.pwmsUser.XTGL_JSGL != 0) {
        [self reloadRoleAllNewDataWithURL:URL_ROLELIST_IOS andType:@"edit" andRoleID:0 andIndex:0];
    }
    [self.tableview setupEmptyDataText:@"暂无数据" tapBlock:^{
        
    }];
    
}



- (void)reloadUserManagementNewData{
    //URL_USERLIST_IOS
    
 
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_USERLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isResult = [json[@"success"] boolValue];
            if (isResult) {
                [weakSelf.userArray removeAllObjects];
                weakSelf.userArray = [RSUserManagementModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                [weakSelf.tableview reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


- (void)addNewUserManagementAction:(UIButton *)addBtn{
    if (self.usermodel.pwmsUser.XTGL_JSGL == 0) {
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"您没有角色管理权限,无法新增，编辑操作" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertView animated:YES completion:nil];

    }else{
        RSNewUserManagementViewController * newUserManagementVc = [[RSNewUserManagementViewController alloc]init];
        newUserManagementVc.selectType = @"list";
        [self.navigationController pushViewController:newUserManagementVc animated:YES];
        newUserManagementVc.reload = ^(BOOL success) {
            [self reloadUserManagementNewData];
        };
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * USERMANAGEMENTCELL = @"USERMANAGEMENTCELL";
    RSUserManagementCell * cell = [tableView dequeueReusableCellWithIdentifier:USERMANAGEMENTCELL];
    if (!cell) {
        cell = [[RSUserManagementCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:USERMANAGEMENTCELL];
    }
    RSUserManagementModel * usermanagementmodel = self.userArray[indexPath.row];
    cell.nameDetialLabel.text = usermanagementmodel.userPhone;
    cell.typeDetialLabel.text = usermanagementmodel.roleName;
    cell.editBtn.tag = indexPath.row;
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(userManagementDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editBtn addTarget:self action:@selector(userManagementDeleteEditAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//删除
- (void)userManagementDeleteAction:(UIButton *)deleteBtn{
    RSUserManagementModel * usermanagementmodel = self.userArray[deleteBtn.tag];
    if (self.usermodel.pwmsUser.pwmsUserModelID  == usermanagementmodel.userManagementID) {
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"不能删除自己的账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertView animated:YES completion:nil];
    }else{
        if (self.usermodel.pwmsUser.XTGL_JSGL == 0) {
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"您没有角色管理权限,无法新增，编辑操作" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertView addAction:alert];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                alertView.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:alertView animated:YES completion:nil];
           
        }else{
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该子账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //URL_DELETEUSER_IOS
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
                NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
                [phoneDict setObject:[NSNumber numberWithInteger:usermanagementmodel.userManagementID] forKey:@"userId"];
                NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
                NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                RSWeakself
                XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                [network getDataWithUrlString:URL_DELETEUSER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                    if (success) {
                        BOOL isresult = [json[@"success"]boolValue];
                        if (isresult) {
                            [weakSelf reloadUserManagementNewData];
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"删除失败"];
                        }
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"删除失败"];
                    }
                }];
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
    }
}




//编辑
- (void)userManagementDeleteEditAction:(UIButton *)editBtn{
    RSUserManagementModel * usermanagementmodel  = self.userArray[editBtn.tag];
    if (self.usermodel.pwmsUser.pwmsUserModelID  == usermanagementmodel.userManagementID) {
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"不能编辑自己的账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertView animated:YES completion:nil];
    }else{
        if (self.usermodel.pwmsUser.XTGL_JSGL == 0) {
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"您没有角色管理权限,无法新增，编辑操作" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertView addAction:alert];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                alertView.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:alertView animated:YES completion:nil];
        }else{
            self.alertView.selectFunctionType = @"用户编辑";
            self.alertView.materialProductName = usermanagementmodel.userPhone;
            self.alertView.materialTypeName = usermanagementmodel.userName;
            self.alertView.typeArray = self.userManagementArray;
            self.alertView.materialColorName = usermanagementmodel.roleName;
            self.alertView.userManagementID = usermanagementmodel.userManagementID;
            self.alertView.index = 0;
            [self.alertView showView];
            RSWeakself
            [self.alertView setReload:^(BOOL istrue) {
                [weakSelf reloadUserManagementNewData];
            }];   
        }
    }
}

- (void)reloadRoleAllNewDataWithURL:(NSString *)URL andType:(NSString *)type andRoleID:(NSInteger)roleId andIndex:(NSInteger)index{
    //URL_ROLELIST_IOS
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL resutl = [json[@"success"]boolValue];
            if (resutl) {
                [weakSelf.userManagementArray removeAllObjects];
                weakSelf.userManagementArray = [RSRoleModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                [weakSelf.tableview reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
        }
    }];
}

@end
