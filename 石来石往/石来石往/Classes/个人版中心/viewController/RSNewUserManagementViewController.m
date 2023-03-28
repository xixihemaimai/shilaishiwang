//
//  RSNewUserManagementViewController.m
//  石来石往
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSNewUserManagementViewController.h"
#import "RSNewManagementThirdHeaderView.h"
#import "RSUserManagementPhoneView.h"
#import "RSUserManagementPhoneSecondView.h"
#import "RSUserManagementFristFootView.h"
#import "RSUserManagementSecondFootView.h"
#import "RSUserManagementThirdFootView.h"
#import "RSRoleModel.h"
#import "RSMaterialDetailsSecondCell.h"
#import "MyMD5.h"

@interface RSNewUserManagementViewController ()<UITextFieldDelegate>

{
    
    UIView * _headerView;
    UIView * _footView;
    
    
    
}

@property (nonatomic,strong)RSUserManagementPhoneView * usermanagementPhoneView;

@property (nonatomic,strong)RSUserManagementPhoneSecondView * usermanagementSecondPhoneView;

@property (nonatomic,strong)RSUserManagementFristFootView * usermanagementFristFootView;

@property (nonatomic,strong)RSUserManagementSecondFootView * usermanagementSecondFootView;

@property (nonatomic,strong)RSUserManagementThirdFootView * usermanagementThirdFootView;


@property (nonatomic,strong)NSMutableArray * userManagementArray;

@property (nonatomic,strong)NSMutableDictionary * openAndCloseDict;

/**中间值来判断显示是选择的角色还是请选择角色*/
@property (nonatomic,strong)RSRoleModel * roleModel;
/**用来保存新建时候的手机的注册情况*/
@property (nonatomic,strong)NSString * phoneStatus;

/**用来计算定时器*/
@property (nonatomic,assign)NSInteger count;

@property (nonatomic,strong)NSTimer *timer;


@end

@implementation RSNewUserManagementViewController

- (RSRoleModel *)roleModel{
    if (!_roleModel) {
        _roleModel = [[RSRoleModel alloc]init];
    }
    return _roleModel;
}


- (NSMutableArray *)userManagementArray{
    if (!_userManagementArray) {
        _userManagementArray = [NSMutableArray array];
    }
    return _userManagementArray;
}

- (NSMutableDictionary *)openAndCloseDict{
    if (!_openAndCloseDict) {
        _openAndCloseDict = [NSMutableDictionary dictionary];
    }
    return _openAndCloseDict;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"新建用户";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    UIButton * saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    [saveBtn addTarget:self action:@selector(saveNewUserManagementAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    //open为0关闭，1为打开
    [self.openAndCloseDict setObject:@"0" forKey:@"open"];
    
   
    self.phoneStatus = @"";
    self.count = 60;
   
    [self creatCustomTableHeaderView];
    
    [self creatCustomTableviewFootView];
    
    if ([self.selectType isEqualToString:@"list"]) {
        [self reloadRoleAllNewDataWithURL:URL_ROLELIST_IOS andType:@"list" andRoleID:0 andIndex:0];
        
    }else{
        [self reloadRoleAllNewDataWithURL:URL_ROLELIST_IOS andType:@"edit" andRoleID:self.usermanagementmodel.userManagementID andIndex:0];
    }
    
}



- (void)creatCustomTableHeaderView{
 
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    _headerView = headerView;
    //第一个输入电话号码
    self.usermanagementPhoneView = [[RSUserManagementPhoneView alloc]initWithFrame:CGRectMake(0, 0, SCW, 50)];
    self.usermanagementPhoneView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:self.usermanagementPhoneView];
    self.usermanagementPhoneView.turePhoneLabel.hidden = YES;
    self.usermanagementPhoneView.textfield.delegate = self;

    
    self.usermanagementSecondPhoneView = [[RSUserManagementPhoneSecondView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.usermanagementPhoneView.frame), SCW, 50)];
    self.usermanagementSecondPhoneView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:self.usermanagementSecondPhoneView];
    [self.usermanagementSecondPhoneView.sendCodeBtn addTarget:self action:@selector(sendUserManagementPhoneCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.usermanagementSecondPhoneView.textfield addTarget:self action:@selector(verificationPhoneCodeAction:) forControlEvents:UIControlEventEditingChanged];
    
    //self.usermanagementSecondPhoneView.sendCodeBtn.enabled = NO;
    
    self.usermanagementSecondPhoneView.textfield.delegate = self;
    
    if ([self.selectType isEqualToString:@"list"]) {
       //验证码
        //self.usermanagementSecondPhoneView.hidden = NO;
        self.usermanagementSecondPhoneView.sd_layout
        .heightIs(50);
        self.usermanagementSecondPhoneView.midView.hidden = NO;
        self.usermanagementSecondPhoneView.sendCodeBtn.hidden = NO;
        
    }else{

        self.usermanagementPhoneView.textfield.text = self.usermanagementmodel.userPhone;
        self.usermanagementPhoneView.textfield.textColor = [UIColor redColor];
        self.usermanagementSecondPhoneView.midView.hidden = YES;
        self.usermanagementSecondPhoneView.sendCodeBtn.hidden = YES;
        self.usermanagementSecondPhoneView.sd_layout
        .heightIs(0);
    }
    [headerView setupAutoHeightWithBottomView:self.usermanagementSecondPhoneView bottomMargin:0];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
}


//发送验证码
- (void)sendUserManagementPhoneCodeAction:(UIButton *)sendCodeBtn{
    if ([self isTrueMobile:self.usermanagementPhoneView.textfield.text]) {
        //URL_SENDTEXT_IOS
        [self addSendCodeTimer];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        //[phoneDict setObject:_phoneTextfield.text forKey:@"MOBILEPHONE"];
        [phoneDict setObject:self.usermanagementPhoneView.textfield.text forKey:@"userPhone"];
        //二进制数
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //URL_GET_TEXT_VERIFY_UNLOGIN
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        
        XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_SENDTEXT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"success"] boolValue] ;
                if (Result) {
                    [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"发送验证码失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"发送验证码失败"];
            }
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请检查你的输入的手机号"];
    }
}

////验证码验证
//- (void)verificationPhoneCodeAction:(UITextField *)textfield{
//    NSString *temp = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    temp = [self delSpaceAndNewline:temp];
//    if ([temp length] > 5) {
//        //这边是有值的时候
//        //URL_CHECKTEXT_IOS
//        //userPhone self.usermanagementPhoneView.textfield.text
//        //code temp
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//        //[phoneDict setObject:_phoneTextfield.text forKey:@"MOBILEPHONE"];
//        [phoneDict setObject:self.usermanagementPhoneView.textfield.text forKey:@"userPhone"];
//        [phoneDict setObject:temp forKey:@"code"];
//        //二进制数
//        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        //URL_GET_TEXT_VERIFY_UNLOGIN
//        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//        RSWeakself
//        XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//        [network getDataWithUrlString:URL_CHECKTEXT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//            if (success) {
//                BOOL Result = [json[@"success"] boolValue] ;
//                if (Result) {
//                    [SVProgressHUD showSuccessWithStatus:@"验证成功"];
//                    weakSelf.navigationItem.rightBarButtonItem.customView.hidden = NO;
//                    [weakSelf.usermanagementSecondPhoneView.sendCodeBtn setTitle:@"验证码成功" forState:UIControlStateNormal];
//                    weakSelf.usermanagementSecondPhoneView.sendCodeBtn.enabled = NO;
//                    weakSelf.usermanagementSecondPhoneView.textfield.enabled = NO;
//                    weakSelf.count = 60;
//                    [weakSelf removeTimer];
//                }
//            }else{
//                weakSelf.navigationItem.rightBarButtonItem.customView.hidden = YES;
//                [SVProgressHUD showErrorWithStatus:@"验证失败"];
//                weakSelf.count = 60;
//                [weakSelf.usermanagementSecondPhoneView.sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                weakSelf.usermanagementSecondPhoneView.sendCodeBtn.enabled = YES;
//            }
//        }];
//    }
//}





- (void)creatCustomTableviewFootView{
    UIView * footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    _footView = footView;
    self.usermanagementFristFootView = [[RSUserManagementFristFootView alloc]initWithFrame:CGRectMake(0, 0, SCW, 50)];
    self.usermanagementFristFootView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [footView addSubview:self.usermanagementFristFootView];
      self.usermanagementFristFootView.textfield.delegate = self;
    self.usermanagementSecondFootView = [[RSUserManagementSecondFootView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.usermanagementFristFootView.frame), SCW, 50)];
    self.usermanagementSecondFootView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [footView addSubview:self.usermanagementSecondFootView];
    self.usermanagementSecondFootView.textfield.delegate = self;
    self.usermanagementThirdFootView = [[RSUserManagementThirdFootView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY( self.usermanagementSecondFootView.frame), SCW, 50)];
    self.usermanagementThirdFootView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [footView addSubview:self.usermanagementThirdFootView];
    self.usermanagementThirdFootView.textfield.delegate = self;
    if ([self.selectType isEqualToString:@"list"]) {
        self.usermanagementSecondFootView.sd_layout
        .topSpaceToView(self.usermanagementFristFootView, 0)
        .heightIs(0);
        self.usermanagementThirdFootView.sd_layout
        .topSpaceToView(self.usermanagementSecondFootView, 0)
        .heightIs(0);
        [footView setupAutoHeightWithBottomView:self.usermanagementThirdFootView bottomMargin:0];
    }
    else{
        self.usermanagementFristFootView.textfield.text = self.usermanagementmodel.userName;
        self.usermanagementSecondFootView.sd_layout
        .topSpaceToView(self.usermanagementFristFootView, 0)
        .heightIs(0);
        self.usermanagementThirdFootView.sd_layout
        .topSpaceToView(self.usermanagementSecondFootView, 0)
        .heightIs(0);
        self.usermanagementFristFootView.textfield.textColor = [UIColor redColor];
        [footView setupAutoHeightWithBottomView: self.usermanagementFristFootView bottomMargin:0];
    }
    
    [footView layoutIfNeeded];
    self.tableview.tableFooterView = footView;
}


- (void)verificationPhoneNameData:(NSString *)phoneName{
    //URL_USERLIST_IOS
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:phoneName forKey:@"userPhone"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_PHONECHECK_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isResult = [json[@"success"] boolValue];
            if (isResult) {
                weakSelf.usermanagementPhoneView.turePhoneLabel.text = json[@"data"][@"msg"];
                weakSelf.usermanagementPhoneView.turePhoneLabel.hidden = NO;
                NSInteger status = [json[@"data"][@"status"] integerValue];
                if (status == 0) {
                    weakSelf.phoneStatus = [NSString stringWithFormat:@"%ld",(long)status];
                     weakSelf.navigationItem.rightBarButtonItem.customView.hidden = NO;
                    weakSelf.usermanagementSecondPhoneView.sendCodeBtn.enabled = YES;
                    weakSelf.usermanagementSecondFootView.sd_layout
                    .heightIs(50);
                    weakSelf.usermanagementThirdFootView.sd_layout
                    .heightIs(50);
                    [_footView setupAutoHeightWithBottomView:self.usermanagementThirdFootView bottomMargin:0];
                }else if (status == 1){
                    weakSelf.navigationItem.rightBarButtonItem.customView.hidden = NO;
                    weakSelf.usermanagementSecondPhoneView.sendCodeBtn.enabled = YES;
                    weakSelf.phoneStatus = [NSString stringWithFormat:@"%ld",(long)status];
                    weakSelf.usermanagementSecondPhoneView.sendCodeBtn.enabled = YES;
                    weakSelf.usermanagementSecondFootView.sd_layout
                    .heightIs(0);
                    weakSelf.usermanagementThirdFootView.sd_layout
                    .heightIs(0);
                    [_footView setupAutoHeightWithBottomView: self.usermanagementFristFootView bottomMargin:0];
                }else{
                    weakSelf.navigationItem.rightBarButtonItem.customView.hidden = YES;
                    weakSelf.usermanagementSecondPhoneView.sendCodeBtn.enabled = NO;
                    weakSelf.phoneStatus = [NSString stringWithFormat:@"%ld",(long)status];
                   
//                    weakSelf.usermanagementSecondPhoneView.midView.hidden = YES;
//                    weakSelf.usermanagementSecondPhoneView.sendCodeBtn.hidden = YES;
                    [_headerView setupAutoHeightWithBottomView:weakSelf.usermanagementPhoneView bottomMargin:0];
                    
                    weakSelf.usermanagementFristFootView.sd_layout
                    .heightIs(0);
                    
//                    RSNewManagementThirdHeaderView * newManagementHeaderView = (RSNewManagementThirdHeaderView *)[self.tableview headerViewForSection:0];
                    //newManagementHeaderView.userInteractionEnabled = NO;
                    weakSelf.usermanagementPhoneView.textfield.textColor = [UIColor redColor];
                   // weakSelf.usermanagementPhoneView.textfield.enabled = YES;
                    weakSelf.usermanagementSecondFootView.sd_layout
                    .heightIs(0);
                    weakSelf.usermanagementThirdFootView.sd_layout
                    .heightIs(0);
                    [_footView setupAutoHeightWithBottomView: self.usermanagementFristFootView bottomMargin:0];
                }
                //0 无石来石往账户,可以添加绑定,添加需要显示密码设置
                //1 有石来石往账户，并且可以绑定，添加无需显示密码设置
                //2 已绑定石来石往账户，无法使用该手机号添加
            }else{
                [SVProgressHUD showErrorWithStatus:@"失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
    }];
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
            //RSRoleModel.h
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




//FIXME:保存
- (void)saveNewUserManagementAction:(UIButton *)saveBtn{
    //URL_ADDPWMSUSER_IOS
    /**
     用户名称    userName    String
     手机号    userPhone    String
     角色ID    roleId    Int
     密码    password    String    可选 注册新石来石往账户时必填MD5
     */
    if ([self.selectType isEqualToString:@"list"]) {
        //这边要看是怎么样的
        if ([self.phoneStatus isEqualToString:@"0"]) {
            //手机号码
            if (![self isTrueMobile:self.usermanagementPhoneView.textfield.text]) {
                [SVProgressHUD showErrorWithStatus:@"手机号错误"];
                return;
            }
            
            //验证码
            if ([self.usermanagementSecondPhoneView.textfield.text length] < 1) {
                [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
                return;
            }
            
            //角色
            RSNewManagementThirdHeaderView * newManagementHeaderView = (RSNewManagementThirdHeaderView *)[self.tableview headerViewForSection:0];
            if ([newManagementHeaderView.titleLabel.text isEqualToString:@"请选择角色"]) {
                [SVProgressHUD showErrorWithStatus:@"没有选择角色"];
                return;
            }
            //用户昵称
            if ([self.usermanagementFristFootView.textfield.text length] < 1) {
                [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
                return;
            }
            
            //设置密码
            if (self.usermanagementSecondFootView.textfield.text.length<6)
            {
                [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
                return;
            }
            if (self.usermanagementSecondFootView.textfield.text.length>20)
            {
                [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
                return;
            }
            //确认密码
            
            if (self.usermanagementThirdFootView.textfield.text.length<6)
            {
                [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
                return;
            }
            if (self.usermanagementThirdFootView.textfield.text.length>20)
            {
                [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
                return;
            }
            
            
            if(![self.usermanagementSecondFootView.textfield.text isEqualToString:self.usermanagementThirdFootView.textfield.text])
            {
                [SVProgressHUD showErrorWithStatus:@"密码不一致"];
                return;
            }
        }else if ([self.phoneStatus isEqualToString:@"1"]){
            //这边是不需要密码
            //手机号码
            if (![self isTrueMobile:self.usermanagementPhoneView.textfield.text]) {
                [SVProgressHUD showErrorWithStatus:@"手机号错误"];
                return;
            }
            
            //验证码
            if ([self.usermanagementSecondPhoneView.textfield.text length] < 1) {
                [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
                return;
            }
            
            //角色
            RSNewManagementThirdHeaderView * newManagementHeaderView = (RSNewManagementThirdHeaderView *)[self.tableview headerViewForSection:0];
            if ([newManagementHeaderView.titleLabel.text isEqualToString:@"请选择角色"]) {
                [SVProgressHUD showErrorWithStatus:@"没有选择角色"];
                return;
            }
            //用户昵称
            if ([self.usermanagementFristFootView.textfield.text length] < 1) {
                [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
                return;
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"该电话号码已经绑定了，无法注册"];
            return;
        }
        
    }else{
        
        //编辑
        
        //手机号码
        if (![self isTrueMobile:self.usermanagementPhoneView.textfield.text]) {
            [SVProgressHUD showErrorWithStatus:@"手机号错误"];
            return;
        }
        
        //角色
        RSNewManagementThirdHeaderView * newManagementHeaderView = (RSNewManagementThirdHeaderView *)[self.tableview headerViewForSection:0];
        if ([newManagementHeaderView.titleLabel.text isEqualToString:@"请选择角色"]) {
            [SVProgressHUD showErrorWithStatus:@"没有选择角色"];
            return;
        }
        //用户昵称
        if ([self.usermanagementFristFootView.textfield.text length] < 1) {
            [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
            return;
        }
    }
    [self.view endEditing:YES];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];

    if ([self.selectType isEqualToString:@"list"]) {
        
       [phoneDict setObject:self.usermanagementFristFootView.textfield.text forKey:@"userName"];
       [phoneDict setObject:self.usermanagementPhoneView.textfield.text forKey:@"userPhone"];
       [phoneDict setObject:[NSNumber numberWithInteger:self.roleModel.roleID] forKey:@"roleId"];
        //这边还要判断手机号码是否是绑定过的
        if ([self.phoneStatus isEqualToString:@"0"]) {
           [phoneDict setObject:[MyMD5 md5:self.usermanagementSecondFootView.textfield.text] forKey:@"password"];
        }else if([self.phoneStatus isEqualToString:@"1"]){
           [phoneDict setObject:@"" forKey:@"password"];
        }
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_ADDPWMSUSER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    
                    if (weakSelf.reload) {
                        weakSelf.reload(true);
                    }
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    [SVProgressHUD showInfoWithStatus:@"创建失败"];
                }
            }else{
                [SVProgressHUD showInfoWithStatus:@"创建失败"];
            }
        }];
        
    }else{
        //编辑
        if ([self.roleModel.roleName length] > 0) {
             [phoneDict setObject:[NSNumber numberWithInteger:self.roleModel.roleID] forKey:@"roleId"];
        }else{
             [phoneDict setObject:[NSNumber numberWithInteger:self.usermanagementmodel.roleId] forKey:@"roleId"];
        }
        /**
         用户id    userId    Int
         角色id    roleId    Int
         */
        [phoneDict setObject:[NSNumber numberWithInteger:self.usermanagementmodel.userManagementID] forKey:@"userId"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_UPDATEUSER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                
                BOOL isresult = [json[@"success"]boolValue];
                
                if (isresult) {
                    if (weakSelf.reload) {
                        weakSelf.reload(true);
                    }
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    [SVProgressHUD showInfoWithStatus:@"修改失败"];
                }
            }else{
                [SVProgressHUD showInfoWithStatus:@"修改失败"];
            }
        }];
        
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString * open = [self.openAndCloseDict objectForKey:@"open"];
    if ([open isEqualToString:@"0"]) {
        return 0;
    }else{
        return self.userManagementArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 59;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * NEWMANAGEMENTHEADERTHIRDVIEW = @"NEWMANAGEMENTHEADERTHIRDVIEW";
    RSNewManagementThirdHeaderView * newManagementHeaderView = [[RSNewManagementThirdHeaderView alloc]initWithReuseIdentifier:NEWMANAGEMENTHEADERTHIRDVIEW];
    [newManagementHeaderView.btn addTarget:self action:@selector(userManagementOpenAndCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    /**
     RSRoleModel * rolemodel = self.userManagementArray[indexPath.row];
     RSNewManagementThirdHeaderView * newManagementHeaderView = (RSNewManagementThirdHeaderView *)[self.tableview headerViewForSection:indexPath.section];
     newManagementHeaderView.titleLabel.text = rolemodel.roleName;
     self.tempStr = rolemodel.roleName;
     */
    if ([self.selectType isEqualToString:@"list"]) {
        if ([self.roleModel.roleName length] > 0) {
             newManagementHeaderView.titleLabel.text = self.roleModel.roleName;
        }else{
             newManagementHeaderView.titleLabel.text = @"请选择角色";
        }
    }else{
        if ([self.roleModel.roleName length] > 0) {
            newManagementHeaderView.titleLabel.text = self.roleModel.roleName;
        }else{
            newManagementHeaderView.titleLabel.text = self.usermanagementmodel.roleName;
        }
    }
    return newManagementHeaderView;
}

//是否展开还是关闭
- (void)userManagementOpenAndCloseAction:(UIButton *)btn{
   // btn.selected = !btn.selected;
//    UIView * v1 = [btn superview];
//    RSNewManagementThirdHeaderView * newManagementHeaderView =(RSNewManagementThirdHeaderView *)[v1 superview];
    NSString * open = [self.openAndCloseDict objectForKey:@"open"];
    if ([open isEqualToString:@"0"]) {
        open = @"1";
    }else{
        open = @"0";
    }
    [self.openAndCloseDict setObject:open forKey:@"open"];
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //RSMaterialDetailsSecondCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
    RSRoleModel * rolemodel = self.userManagementArray[indexPath.row];
    RSNewManagementThirdHeaderView * newManagementHeaderView = (RSNewManagementThirdHeaderView *)[self.tableview headerViewForSection:indexPath.section];
    
    newManagementHeaderView.titleLabel.text = rolemodel.roleName;
    self.roleModel = rolemodel;
   // self.tempStr = rolemodel.roleName;
    [self.openAndCloseDict setObject:@"0" forKey:@"open"];
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if (textField == self.usermanagementPhoneView.textfield) {
        //这边是第一组的电话号码的情况
        if ([temp length] > 0) {
            if ([self.selectType isEqualToString:@"list"]) {
                [self verificationPhoneNameData:temp];
            }else{
                textField.textColor = [UIColor redColor];
            }
        }else{
            //这边是没有值的情况
            self.usermanagementPhoneView.textfield.text = @"";
        }
    }else if (textField == self.usermanagementSecondPhoneView.textfield){
        //验证码的地方
        if ([temp length] > 0) {

            if ([self.selectType isEqualToString:@"list"]) {
                self.usermanagementSecondPhoneView.textfield.text = temp;
            }
        }else{
            self.usermanagementSecondPhoneView.textfield.text = @"";
            //这边是没有值的情况
        }
    }else if (textField == self.usermanagementFristFootView.textfield){
        //昵称
        if ([temp length] > 0) {
            self.usermanagementFristFootView.textfield.text = temp;
        }else{
            //这边是没有值的情况
            self.usermanagementFristFootView.textfield.text = @"";
        }
    }else if (textField == self.usermanagementSecondFootView.textfield){
        //密码设置
        if ([temp length] > 0) {
            self.usermanagementSecondFootView.textfield.text = temp;
        }else{
            //这边是没有值的情况
            self.usermanagementSecondFootView.textfield.text = @"";
        }
    }else{
        //确认密码
        if ([temp length] > 0) {
            self.usermanagementThirdFootView.textfield.text = temp;
        }else{
            //这边是没有值的情况
            self.usermanagementThirdFootView.textfield.text = @"";
        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if (textField == self.usermanagementPhoneView.textfield) {
        //这边是第一组的电话号码的情况
        if ([temp length] > 0) {
            if ([self.selectType isEqualToString:@"list"]) {
                [self verificationPhoneNameData:temp];
            }else{
                textField.textColor = [UIColor redColor];
            }
        }else{
            //这边是没有值的情况
            self.usermanagementPhoneView.textfield.text = @"";
        }
    }else if (textField == self.usermanagementSecondPhoneView.textfield){
        //验证码的地方
        if ([temp length] > 0) {
            
            if ([self.selectType isEqualToString:@"list"]) {
                self.usermanagementSecondPhoneView.textfield.text = temp;
            }
        }else{
            self.usermanagementSecondPhoneView.textfield.text = @"";
            //这边是没有值的情况
        }
    }else if (textField == self.usermanagementFristFootView.textfield){
        //昵称
        if ([temp length] > 0) {
            self.usermanagementFristFootView.textfield.text = temp;
        }else{
            //这边是没有值的情况
            self.usermanagementFristFootView.textfield.text = @"";
        }
    }else if (textField == self.usermanagementSecondFootView.textfield){
        //密码设置
        if ([temp length] > 0) {
            self.usermanagementSecondFootView.textfield.text = temp;
        }else{
            //这边是没有值的情况
            self.usermanagementSecondFootView.textfield.text = @"";
        }
    }else{
        //确认密码
        if ([temp length] > 0) {
            self.usermanagementThirdFootView.textfield.text = temp;
        }else{
            //这边是没有值的情况
            self.usermanagementThirdFootView.textfield.text = @"";
        }
    }
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.selectType isEqualToString:@"list"]) {
//        if ([self.phoneStatus isEqualToString:@"2"]) {
//            //return NO;
//            if (textField == self.usermanagementPhoneView.textfield || textField == self.usermanagementSecondPhoneView.textfield){
//                return NO;
//            }
//        }
    }else{
        if (textField == self.usermanagementFristFootView.textfield || textField == self.usermanagementPhoneView.textfield) {
            return NO;
        }
    }
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * NEWUSERMANAGEMENTCELL = @"NEWUSERMANAGEMENTCELL";
    RSMaterialDetailsSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWUSERMANAGEMENTCELL];
    if (!cell) {
        cell = [[RSMaterialDetailsSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWUSERMANAGEMENTCELL];
    }
    // cell.titleLabel.text = self.titleArray[indexPath.row];
    //cell.materiaTypeLabel.text = self.detailArray[indexPath.row];
    RSRoleModel * rolemodel = self.userManagementArray[indexPath.row];
    cell.nameDetialLabel.text = rolemodel.roleName;
   // cell.editBtn.tag = indexPath.row;
   // cell.deleteBtn.tag = indexPath.row;
    cell.editBtn.hidden = YES;
    cell.deleteBtn.hidden = YES;
    cell.midView.hidden = YES;
  //  [cell.deleteBtn addTarget:self action:@selector(materialDetailsDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
   // [cell.editBtn addTarget:self action:@selector(materialDetailsEditAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//手机号验证
- (BOOL)isTrueMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^1(3|5|7|8|4)\\d{9}";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:mobile];
    
    // NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSString * MOBILE = @"^((13[0-9])|(15[^4])|(18[0-9])|(17[0-8])|(19[8,9])|(166)|(147))\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobile];
    
}

//NSString *temp = [titleTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


#pragma mark -- 增加定时器
- (void)addSendCodeTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdownToTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark -- 时间的倒计时
- (void)countdownToTime{
    self.count--;
    [self.usermanagementSecondPhoneView.sendCodeBtn setTitle:[NSString stringWithFormat:@"%lds",(long)self.count] forState:UIControlStateNormal];
    self.usermanagementSecondPhoneView.sendCodeBtn.enabled = NO;
   // [self.usermanagementSecondPhoneView.sendCodeBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
    
    if (self.count <= 0) {
        [self.usermanagementSecondPhoneView.sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.usermanagementSecondPhoneView.sendCodeBtn.enabled = YES;
        self.count = 60;
       // [self.usermanagementSecondPhoneView.sendCodeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
        [self removeTimer];
    }
}


- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //移除定时器
    [self removeTimer];
}
@end
