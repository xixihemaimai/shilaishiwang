//
//  RSWeiXiViewController.m
//  石来石往
//
//  Created by mac on 17/6/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSWeiXiViewController.h"
#import "RSNextRegisterViewController.h"
#import "NSString+RSExtend.h"
#import "Utility.h"

#import "RSRegisterModel.h"

//登录的控制器
#import "RSLeftViewController.h"

//微信登录的时候的加密
#import "MyMD5.h"

//返回到首页
#import "RSHomeViewController.h"
#import "AppDelegate.h"


@interface RSWeiXiViewController ()<UITextFieldDelegate>{
    UIView * _navigationview;
    
    
    //手机号的输入
    UITextField * _phoneTextfield;
    //验证码的输入
    UITextField * _codeTextfield;
    
    //手机检测之后显示的视图
    UILabel * _phoneChangeLabel;
    
    
    //获取验证码按键
    UIButton * _codeBtn;
    
    
    //下一步按键
    UIButton * _nextBtn;
    
    
    //注册的信息
    RSRegisterModel * registerMode;
    
    
    
    
    //接收用户的手机号的状态
    NSString * _tempStr;
    
    
    
    
    //图形验证码输入框
    UITextField * _smsTextField;
    //更改图形验证码
    UIButton * _smsBtn;
    
}


/**用来计算定时器*/
//@property (nonatomic,assign)NSInteger count;

//@property (nonatomic,strong)NSTimer *timer;


@property (nonatomic,copy)NSString * uuid;


@end

@implementation RSWeiXiViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.uuid = [NSString get_uuid];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"微信绑定手机号";
    //定时器之后60秒
//    self.count = 60;
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    
    //添加微信自定义的验证手机号没没有绑定的操作
    
    [self addCustonContentView];
    
}



- (void)addCustonContentView{
    UIView * contentview = [[UIView alloc]init];
    contentview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self.view addSubview:contentview];
//    CGFloat Y = 0.0;
//    if (iPhoneX_All) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
    contentview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(180);
    
    //手机号的view
    UIView * phoneview = [[UIView alloc]init];
    phoneview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [contentview addSubview:phoneview];
    
    phoneview.sd_layout
    .leftSpaceToView(contentview,12)
    .rightSpaceToView(contentview,12)
    .topSpaceToView(contentview,15)
    .heightIs(55);
    
    UITextField * phoneTextfield = [[UITextField alloc]init];
    _phoneTextfield = phoneTextfield;
    NSString *str  = @"请输入手机号";
    NSMutableAttributedString * placeholderstr = [[NSMutableAttributedString alloc]initWithString:str];
    [placeholderstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#333333"] range:NSMakeRange(0, str.length)];
    [placeholderstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, str.length)];
    phoneTextfield.attributedPlaceholder = placeholderstr;
    phoneTextfield.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    phoneTextfield.keyboardType = UIKeyboardTypePhonePad;
    phoneTextfield.borderStyle = UITextBorderStyleNone;
    //phoneTextfield.secureTextEntry = YES;
    [phoneTextfield addTarget:self action:@selector(phoneNumeberSecondIsSure:) forControlEvents:UIControlEventEditingChanged];
    [phoneview addSubview:phoneTextfield];
    
    UILabel * phoneChangeLabel = [[UILabel alloc]init];
    _phoneChangeLabel = phoneChangeLabel;
    //phoneChangeLabel.textColor = [UIColor redColor];
    phoneChangeLabel.hidden = YES;
    [phoneview addSubview:phoneChangeLabel];
    phoneChangeLabel.textAlignment = NSTextAlignmentRight;
    phoneChangeLabel.font = [UIFont systemFontOfSize:14];
    
    UIView *phoneBottomview = [[UIView alloc]init];
    phoneBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eaeaea"];
    [phoneview addSubview:phoneBottomview];
    
    phoneTextfield.sd_layout
    .leftSpaceToView(phoneview,0)
    .widthIs(150)
    .topSpaceToView(phoneview,12)
    .bottomSpaceToView(phoneview, 12);
    
    phoneChangeLabel.sd_layout
    .leftSpaceToView(phoneTextfield,10)
    .rightSpaceToView(phoneview,12)
    .topEqualToView(phoneTextfield)
    .bottomEqualToView(phoneTextfield);
    
    phoneBottomview.sd_layout
    .leftSpaceToView(phoneview,12)
    .rightSpaceToView(phoneview,12)
    .bottomSpaceToView(phoneview,0)
    .heightIs(1);
    
    
    UIView * codePictureview = [[UIView alloc]init];
    codePictureview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [contentview addSubview:codePictureview];
    
    
    UITextField *smsTextField  = [[UITextField alloc]init];
    NSString * smsTextFieldStr  = @"请输入图形验证码";
    smsTextField.delegate = self;
    _smsTextField = smsTextField;
    NSMutableAttributedString *placeStr4 = [[NSMutableAttributedString alloc]initWithString:smsTextFieldStr];
    [placeStr4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#333333"] range:NSMakeRange(0, smsTextFieldStr.length)];
    [placeStr4 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, smsTextFieldStr.length)];
    smsTextField.attributedPlaceholder = placeStr4;
    [codePictureview addSubview:smsTextField];
    
    
    UIButton * smsBtn = [[UIButton alloc]init];
    [smsBtn addTarget:self action:@selector(changCodePitureAction:) forControlEvents:UIControlEventTouchUpInside];
    [codePictureview addSubview:smsBtn];
    
    
    UIView * smsBottomview  =[[UIView alloc]init];
    smsBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e5e5e5"];
    [codePictureview addSubview:smsBottomview];
    
    codePictureview.sd_layout.leftSpaceToView(contentview, 12).rightSpaceToView(contentview, 12).topSpaceToView(phoneview, 0).heightIs(55);
    
    smsTextField.sd_layout.leftSpaceToView(codePictureview, 0).widthIs(SCW - 12-12-10-10-15-12-77.5)
        .centerYEqualToView(codePictureview)
        .topSpaceToView(codePictureview,12)
        .bottomSpaceToView(codePictureview,12);
    
    
    smsBtn.sd_layout.leftSpaceToView(smsTextField,0)
        .rightSpaceToView(codePictureview,10)
        .centerYEqualToView(codePictureview)
        .widthIs(77.5)
        .heightIs(30);
    _smsBtn = smsBtn;
    
    
    smsBottomview.sd_layout.leftSpaceToView(codePictureview, 0).rightSpaceToView(codePictureview, 0).bottomSpaceToView(codePictureview, 0).heightIs(1);
    [_smsBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?key=%@",URL_GET_TEXT_SMS_VERIFY_CODE_IOS,self.uuid]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"背景"]];
    
//    [self reloadPictureCode:smsBtn];
    
    
    //验证码view
    UIView * Codeview = [[UIView alloc]init];
    Codeview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [contentview addSubview:Codeview];
    
    Codeview.sd_layout
    .leftSpaceToView(contentview,12)
    .rightSpaceToView(contentview,12)
    .topSpaceToView(codePictureview,0)
    .heightIs(55);
    
    UITextField * codeTextfield = [[UITextField alloc]init];
    _codeTextfield = codeTextfield;
    NSString *str1  = @"请输入验证码";
    codeTextfield.keyboardType = UIKeyboardTypeNumberPad;
    NSMutableAttributedString * placeholderstr1 = [[NSMutableAttributedString alloc]initWithString:str1];
    [placeholderstr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#333333"] range:NSMakeRange(0, str1.length)];
    [placeholderstr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, str1.length)];
    codeTextfield.attributedPlaceholder = placeholderstr1;
    codeTextfield.borderStyle = UITextBorderStyleNone;
    [codeTextfield addTarget:self action:@selector(createSure:) forControlEvents:UIControlEventEditingChanged];
    [Codeview addSubview:codeTextfield];
    codeTextfield.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    UIButton * codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeBtn setTitle:@"获得验证码" forState:UIControlStateNormal];
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _codeBtn = codeBtn;
    codeBtn.enabled = NO;
    [codeBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [codeBtn  addTarget:self action:@selector(initToSendCode:) forControlEvents:UIControlEventTouchUpInside];
    codeBtn.layer.cornerRadius = 5;
    codeBtn.layer.masksToBounds = YES;
    
    [Codeview addSubview:codeBtn];
    //colorWithHexColorStr:@"#1c98e6"
    
    codeTextfield.sd_layout
    .leftSpaceToView(Codeview,0)
    .widthRatioToView(Codeview,0.5)
    .centerYEqualToView(Codeview)
    .topSpaceToView(Codeview,12)
    .bottomSpaceToView(Codeview,12);
//    .topSpaceToView(codePictureview,11)
//    .bottomSpaceToView(Codeview,0);
    
    codeBtn.sd_layout
    .widthIs(92)
    .rightSpaceToView(Codeview,12)
    .topSpaceToView(Codeview,11)
    .bottomSpaceToView(Codeview,0);
    
    
    UIView *codeBottomview = [[UIView alloc]init];
    codeBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eaeaea"];
    [Codeview addSubview:codeBottomview];
    
    codeBottomview.sd_layout
    .leftSpaceToView(Codeview,12)
    .rightSpaceToView(Codeview,12)
    .bottomSpaceToView(Codeview,0)
    .heightIs(1);
    
    
    UIButton * nextBtn = [[UIButton alloc]init];
    [nextBtn setTitle:@"绑定手机号" forState:UIControlStateNormal];
    [nextBtn setTintColor:[UIColor whiteColor]];
    nextBtn.enabled = NO;
    [nextBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.layer.masksToBounds =  YES;
    _nextBtn = nextBtn;
    [nextBtn addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:nextBtn];
    
    nextBtn.sd_layout
    .topSpaceToView(contentview,10)
    .centerXEqualToView(self.view)
    .widthIs(284)
    .heightIs(44);
}



//更改图片验证码
- (void)changCodePitureAction:(UIButton *)smsBtn{
    [self reloadPictureCode:smsBtn];
}

- (void)reloadPictureCode:(UIButton *)smsBtn{
    _smsTextField.text = @"";
    self.uuid = [NSString get_uuid];
    [_smsBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?key=%@",URL_GET_TEXT_SMS_VERIFY_CODE_IOS,self.uuid]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"背景"]];
}


#pragma mark -- 绑定手机号
- (void)nextView:(UIButton *)btn{
    [_phoneTextfield resignFirstResponder];
    [_codeTextfield resignFirstResponder];
    //这里要对手机号的输入和验证码的输入进行判读是否都是正确的
    //URL_WECHAT_QQ_LOGIN 微信与手机号的登录
    if (_phoneTextfield.text.length == 11 && _codeTextfield.text.length >= 6) {
        if(![self isTrueMobile:_phoneTextfield.text] && _codeTextfield.text.length < 6)
        {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
            return;
        }else{
            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
            //手机号
            [phoneDict setObject:_phoneTextfield.text forKey:@"MOBILEPHONE"];
            //验证码
            [phoneDict setObject:_tempStr forKey:@"MSG_KEY"];
            //微信使用名字  不能为空
            [phoneDict setObject:self.nickname forKey:@"NICKNAME"];
            //微信的使用者的图片 不能为空值
            [phoneDict setObject:self.headimgurl forKey:@"USER_LOGO"];
            //微信的使用者的unionID 不能为空
            if (self.unionid == nil) {
                [phoneDict setObject:@"" forKey:@"WC_UID"];
            }else{
                [phoneDict setObject:self.unionid forKey:@"WC_UID"];
            }
            //微信使用者的QQ  可以为空值
            //[phoneDict setObject:self.weixiModel.openid forKey:@"QQ_OPENID"];
            //微信使用者的INVITE_CODE 可以为空值
            //[phoneDict setObject:[NSString stringWithFormat:@""] forKey:@"INVITE_CODE"];
            //微信使用者的方式
            //[phoneDict setObject:[NSString stringWithFormat:@"WC"] forKey:@"TYPE"];
            //二进制数
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            // NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            //URL_IS_WECHAT_REGISTED_IOS URL_WECHAT_QQ_LOGIN
            RSWeakself
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_IS_WECHAT_REGISTED_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL Result = [json[@"Result"]boolValue];
                    if (Result) {
                        NSString * OK = json[@"Data"][@"MSG_CODE"];
                        if ([OK isEqualToString:@"OK"]  ) {
                            //这边是未绑定手机号的地方
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [SVProgressHUD showSuccessWithStatus:@"成功绑定手机号,初始密码为123456，请尽快前往个人中心修改密码"];
                            });
//                            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                            [RSInitUserInfoTool registermodelUSER_CODE:[NSString stringWithFormat:@"%@",json[@"Data"][@"USER_CODE"]] andVERIFYKEY:[NSString stringWithFormat:@"%@",json[@"Data"][@"VERIFYKEY"]] andViewController:weakSelf andObtain:^(BOOL isValue) {
                                if (isValue) {
//                                    [user setObject:[NSString stringWithFormat:@"1"] forKey:@"temp"];
//                                    [user synchronize];
//                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];
                                    
//                                    RSMainTabBarViewController * mainTabbar = (RSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                                    AppDelegate * app =(AppDelegate *) [UIApplication sharedApplication].delegate;
                                    RSMainTabBarViewController * mainTabbar =(RSMainTabBarViewController *)app.window.rootViewController;
                                    RSLeftViewController * leftVc = [[RSLeftViewController alloc]init];
                                    RSMyNavigationViewController * navi3 = [mainTabbar.viewControllers objectAtIndex:3];
                                    NSMutableArray * controllers = [NSMutableArray arrayWithArray:navi3.viewControllers];
                                    controllers[0] = leftVc;
                                    leftVc.tabBarItem.tag = 3;
                                    leftVc.tabBarItem.title = @"我的";
                                    leftVc.tabBarItem.image = [UIImage imageNamed:@"我的-未选中"];
                                    UIImage * image3 = [UIImage imageNamed:@"我的-选中"];
                                    UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                                    leftVc.tabBarItem.selectedImage = newImage3;
                                    [navi3 setViewControllers:controllers];
                                    [navi3.navigationController popToRootViewControllerAnimated:YES];
                                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                    
                                }
                            }];
                        }
                        if([OK isEqualToString:@"ATTACH_OK"]){
                            //这边是已经绑定手机号了, 换过一架手机之后的事情，要获取到用户的密码。好直接登录
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [SVProgressHUD showSuccessWithStatus:@"已经绑定手机号了"]; //这边的情况是，一种是换了一架手机微信登录返回的密码，一种是当你注册了用户的情况下，这边的密码就你注册时候的密码
                            });
//                            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                            [RSInitUserInfoTool registermodelUSER_CODE:[NSString stringWithFormat:@"%@",json[@"Data"][@"USER_CODE"]] andVERIFYKEY:[NSString stringWithFormat:@"%@",json[@"Data"][@"VERIFYKEY"]] andViewController:weakSelf andObtain:^(BOOL isValue) {
                                if (isValue) {
//                                    [user setObject:[NSString stringWithFormat:@"1"] forKey:@"temp"];
//                                    [user synchronize];
                                    
//                                    RSMainTabBarViewController * mainTabbar = (RSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//                                    RSLeftViewController * leftVc = [[RSLeftViewController alloc]init];
//                                    RSMyNavigationViewController * navi3 = [mainTabbar.viewControllers objectAtIndex:3];
//                                    NSMutableArray * controllers = [NSMutableArray arrayWithArray:navi3.viewControllers];
//                                    controllers[0] = leftVc;
//                                    [navi3 setViewControllers:controllers];
//                                    leftVc.tabBarItem.tag = 3;
//                                    leftVc.tabBarItem.title = @"我的";
//                                    leftVc.tabBarItem.image = [UIImage imageNamed:@"我的-未选中"];
//                                    UIImage * image3 = [UIImage imageNamed:@"我的-选中"];
//                                    UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                                    leftVc.tabBarItem.selectedImage = newImage3;
//                                    [navi3.navigationController popToRootViewControllerAnimated:YES];
//                                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                    
//                                    RSMainTabBarViewController * mainTabbar = (RSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                                    
                                    AppDelegate * app =(AppDelegate *) [UIApplication sharedApplication].delegate;
                                    RSMainTabBarViewController * mainTabbar =(RSMainTabBarViewController *)app.window.rootViewController;
                                    RSLeftViewController * leftVc = [[RSLeftViewController alloc]init];
                                    RSMyNavigationViewController * navi3 = [mainTabbar.viewControllers objectAtIndex:3];
                                    NSMutableArray * controllers = [NSMutableArray arrayWithArray:navi3.viewControllers];
                                    controllers[0] = leftVc;
                                    leftVc.tabBarItem.tag = 3;
                                    leftVc.tabBarItem.title = @"我的";
                                    leftVc.tabBarItem.image = [UIImage imageNamed:@"我的-未选中"];
                                    UIImage * image3 = [UIImage imageNamed:@"我的-选中"];
                                    UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                                    leftVc.tabBarItem.selectedImage = newImage3;
                                    [navi3 setViewControllers:controllers];
                                    [navi3.navigationController popToRootViewControllerAnimated:YES];
                                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                    
                                    
//                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];
                                }
                            }];
                        }
                        //MSG_CODE = INVALID_ACCOUNT  则提示：账号审核中，无法绑定!  不做后续登录和同步数据操作。
                        if([OK isEqualToString:@"INVALID_ACCOUNT"]){
                            [JHSysAlertUtil presentAlertViewWithTitle:@"提示" message:@"账号审核中，无法绑定" cancelTitle:@"确定" defaultTitle:@"取消" distinct:YES cancel:^{
                                [weakSelf.navigationController popViewControllerAnimated:YES];
                            } confirm:^{
                                [weakSelf.navigationController popViewControllerAnimated:YES];
                            }];
//                            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号审核中，无法绑定" preferredStyle:UIAlertControllerStyleAlert];
//                            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                                [weakSelf.navigationController popViewControllerAnimated:YES];
//                            }];
//                            [alertView addAction:alert];
//                            UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                                [weakSelf.navigationController popViewControllerAnimated:YES];
//                            }];
//                            [alertView addAction:alert1];
//                            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//                                alertView.modalPresentationStyle = UIModalPresentationFullScreen;
//                            }
//                            [weakSelf presentViewController:alertView animated:YES completion:nil];
                        }
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"绑定失败"];
                        //返回登录界面
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                }
            }];
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"绑定失败"];
    }
}

#pragma mark -- 已有账号，直接登录
- (void)quliklyLoginAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 验证码的内容
- (void)createSure:(UITextField *)textfield{
    if(textfield.text.length > 5)
    {
        _nextBtn.enabled = YES;
        [_nextBtn setBackgroundColor:[UIColor  colorWithHexColorStr:@"#3385ff"]];
    }
}

#pragma mark -- 发送验证码
//- (void)initToSendCode{
//    //增加定时器
////    [self addSendCodeTimer];
//
//    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//    // [phoneDict setObject:_phoneTextfield.text forKey:@"MOBILEPHONE"];
//    [phoneDict setObject:_phoneTextfield.text forKey:@"mobilePhone"];
//    //二进制数
//    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    //URL_GET_TEXT_VERIFY_UNLOGIN_IOS URL_GET_TEXT_VERIFY_UNLOGIN
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_GET_TEXT_VERIFY_UNLOGIN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue] ;
//            if (Result) {
//                [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
//            }
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"发送验证码失败"];
//        }
//    }];
//}


-(void)initToSendCode:(UIButton *)btn{
    if ([self isTrueMobile:_phoneTextfield.text]) {
        
        
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        // [phoneDict setObject:_phoneTextfield.text forKey:@"MOBILEPHONE"];
        [phoneDict setObject:_phoneTextfield.text forKey:@"mobilePhone"];
        
        
        [phoneDict setObject:self.uuid forKey:@"key"];
        [phoneDict setObject:_smsTextField.text forKey:@"value"];
        
        //二进制数
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //URL_GET_TEXT_VERIFY_UNLOGIN_IOS URL_GET_TEXT_VERIFY_UNLOGIN
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
        //URL_GET_TEXT_VERIFY_UNLOGIN_IOS
        [network getDataWithUrlString:URL_GET_TEXT_SMS_VERIFY_SEND_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue] ;
                if (Result) {
                    //                    [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
                    __block NSInteger time = 59; //倒计时时间
                    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
                    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                    dispatch_source_set_event_handler(_timer, ^{
                        if(time <= 0){ //倒计时结束，关闭
                            dispatch_source_cancel(_timer);
                            dispatch_async(dispatch_get_main_queue(), ^{
                                //设置按钮的样式
                                [btn setTitle:@"重新发送" forState:UIControlStateNormal];
            //                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                btn.userInteractionEnabled = YES;
                                _smsBtn.userInteractionEnabled = YES;

                            });
                        }else{
                            int seconds = time % 60;
                            dispatch_async(dispatch_get_main_queue(), ^{
                                //设置按钮显示读秒效果
                                [btn setTitle:[NSString stringWithFormat:@"%.3d秒", seconds] forState:UIControlStateNormal];
            //                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                btn.userInteractionEnabled = NO;
                                _smsBtn.userInteractionEnabled = NO;
                            });
                            time--;
                        }
                    });
                    dispatch_resume(_timer);
                }else{
                    if ([json[@"MSG_CODE"] isEqualToString:@"MAX_MSG_QTY"]) {
                        [SVProgressHUD showErrorWithStatus:@"短信发送过多"];
                    }else if ([json[@"MSG_CODE"] isEqualToString:@"error_verify_code"]){
                        [SVProgressHUD showErrorWithStatus:@"输入图形验证码错误"];
                        _smsBtn.userInteractionEnabled = YES;
                        [self reloadPictureCode:_smsBtn];
                    }
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"发送验证码失败"];
            }
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"手机号错误"];
    }
}




#pragma mark --- 监测textfield是不是满足电话号码的正则
- (void)phoneNumeberSecondIsSure:(UITextField *)textfield{
    //这边要对手机号进行服务器上面的检测
    if (textfield.text.length == 11) {
        if (![self isTrueMobile:_phoneTextfield.text]) {
            [SVProgressHUD showInfoWithStatus:@"输入手机号码不对"];
            return;
        }else{
            [SVProgressHUD showWithStatus:@"正在验证手机号"];
            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
            [phoneDict setObject:_phoneTextfield.text forKey:@"mobilePhone"];
            // NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            
            //        RSWeiXiModel * weixiModel = [[RSWeiXiModel alloc]init];
            //        weixiModel.unionid = [user objectForKey:@"unionid"];
            //
            //        [user setObject:weixiModel.unionid forKey:@"wxid"];
            //二进制数
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            
            
            //URL_WXVERIFY_IOS URL_VERIFY_MOBILEPHONE_IOS
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_WXVERIFY_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                
                if (success) {
                    BOOL isResult = [json[@"Result"] boolValue];
                    
                    
                    [SVProgressHUD dismiss];
                    
                    if ([json[@"MSG_CODE"]isEqualToString:@"U_PHONE_REPEAT"]) {
                        _phoneChangeLabel.text = @"该手机已经绑定过";
                        _phoneChangeLabel.textColor = [UIColor redColor];
                        _phoneChangeLabel.hidden = NO;
                        [_codeBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
                        _codeBtn.enabled = NO;
                    }
                    
                    
                    if (isResult) {
                        
                        
                        //
                        
                        if ([json[@"Data"][@"MSG_CODE"] isEqualToString:@"CAN_BE_BOUND"]){
                            _phoneChangeLabel.text = @"该手机已经注册过,未绑定";
                            _phoneChangeLabel.textColor = [UIColor greenColor];
                            _phoneChangeLabel.hidden = NO;
                            [_codeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
                            _codeBtn.enabled = YES;
                            _tempStr = @"CAN_BE_BOUND";
                            
                        }else if([json[@"Data"][@"MSG_CODE"] isEqualToString:@"OK"]){
                            
                            _phoneChangeLabel.text = @"该手机未注册";
                            _phoneChangeLabel.textColor = [UIColor greenColor];
                            _phoneChangeLabel.hidden = NO;
                            [_codeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
                            _codeBtn.enabled = YES;
                            _tempStr = @"OK";
                        }
                        _nextBtn.enabled = NO;
                        [_nextBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
                    }
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:@"手机号检测失败"];
                    
                }
            }];
            
        }
        
        
        
    }else{
        _nextBtn.enabled = NO;
        [_nextBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
        
        _phoneChangeLabel.hidden = YES;
        [_codeBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
        _codeBtn.enabled = YES;
        [SVProgressHUD dismiss];
    }
    
}








#pragma mark -- 增加定时器
//- (void)addSendCodeTimer{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdownToTime) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//}
//
//#pragma mark -- 时间的倒计时
//- (void)countdownToTime{
//    self.count--;
//    [_codeBtn setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)self.count] forState:UIControlStateNormal];
//    _codeBtn.enabled = NO;
//    [_codeBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
//
//    if (self.count <= 0) {
//        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//        _codeBtn.enabled = YES;
//        [_codeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
//        [self removeTimer];
//        self.count = 60;
//    }
//
//}


//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    //移除定时器
////    [self removeTimer];
//}


//- (void)removeTimer{
//    [self.timer invalidate];
//    self.timer = nil;
//}



- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _smsTextField){
        NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        textField.text = temp;
    }
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
