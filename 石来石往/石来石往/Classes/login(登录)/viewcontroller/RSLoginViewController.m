//
//  RSLoginViewController.m
//  石来石往
//
//  Created by mac on 17/5/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSLoginViewController.h"
#import "RSRegisterViewController.h"
#import "RSFogetPasswordViewController.h"
#import "MyMD5.h"
#import "RSLeftViewController.h"
#import "RSHomeViewController.h"
#import "RSWeiXiViewController.h"
//微信
#import "WXApi.h"
//友盟统计
//#import <UMCommon/MobClick.h>
#import "AppDelegate.h"
#import "RSMainTabBarViewController.h"
//微信模型
#import "RSWeiXiModel.h"
//用户协议和隐私政策
#import "RSUserInformationViewController.h"



//#define NUMBERS @"0123456789\n"

@interface RSLoginViewController ()<UITextFieldDelegate,WXApiManagerDelegate>
{
    UIView *_navigationview;
    
    //微信登录的提示文本
    UILabel * _label;
    
    /**注册时候服务器返回的数据模型*/
    RSRegisterModel *registerModel;
}

/**输入账号*/
@property (nonatomic,strong)UITextField *accountTextfield;

/**输入密码*/
@property (nonatomic,strong)UITextField *passwordTextfield;


/**同意的按键*/
@property (nonatomic,strong)UIButton * agreenBtn;


@end

@implementation RSLoginViewController

//SingerM(RSLoginViewController);


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    _accountTextfield.text = @"";
    _passwordTextfield.text = @"";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    //自定义界面视图
    [self addCustomContentview];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(autoLoginAction) name:@"registerSuccessNSNotification" object:nil];
    
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpWeiXinViewController) name:@"jumpWeixinViewControler" object:nil];
    
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpHomeViewController) name:@"formLoginToHomeViewController" object:nil];
    
    
    //左边添加返回导航栏按键
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(back) title:nil];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)addCustomContentview{
        
    UIImageView * iconImageview = [[UIImageView alloc]init];
    iconImageview.image = [UIImage imageNamed:@"iconfont-iconfontyonghutouxiang-拷贝"];
    [self.view addSubview:iconImageview];
    
    UIView * loginContentview = [[UIView alloc]init];
    loginContentview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self.view addSubview:loginContentview];
    
    
    iconImageview.sd_layout
    .centerXEqualToView(self.view)
    .widthIs(60)
    .heightEqualToWidth()
    .topSpaceToView(self.view,70);
    
    
    loginContentview.sd_layout
    .topSpaceToView(iconImageview,30)
    .centerXEqualToView(self.view)
    .widthIs(SCW - 60)
    .heightIs(176);
    
//     if (iPhone6){
//        //这边是用来判断6和7，6s的型号
//
//        loginContentview.sd_layout
//        .topSpaceToView(iconImageview,30)
//        .centerXEqualToView(self.view)
//        .leftSpaceToView(self.view,SCW/8)
//        .rightSpaceToView(self.view,SCW/8)
//        .heightIs(176);
//
//    }else if (iPhone6p){
//        //这边用来判断6p和7P的型号
//
//        iconImageview.sd_layout
//        .centerXEqualToView(self.view)
//        .widthIs(60)
//        .heightIs(60)
//        .topSpaceToView(self.view,124);
//
//
//        loginContentview.sd_layout
//        .topSpaceToView(iconImageview,60)
//        .centerXEqualToView(self.view)
//        .leftSpaceToView(self.view,SCW/8)
//        .rightSpaceToView(self.view,SCW/8)
//        .heightIs(176);
//
//    }else{
//
//        //这边是x的时候没有适配到
//        iconImageview.sd_layout
//        .centerXEqualToView(self.view)
//        .widthIs(60)
//        .heightIs(60)
//        .topSpaceToView(self.view,124);
//
//        loginContentview.sd_layout
//        .topSpaceToView(iconImageview,60)
//        .centerXEqualToView(self.view)
//        .leftSpaceToView(self.view,SCW/8)
//        .rightSpaceToView(self.view,SCW/8)
//        .heightIs(176);
//    }
    
    
    UIView * accountview = [[UIView alloc]init];
    accountview.layer.cornerRadius = 20;
    accountview.layer.masksToBounds = YES;
    accountview.layer.borderWidth = 1;
    accountview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    accountview.layer.borderColor = [UIColor colorWithHexColorStr:@"#3385ff"].CGColor
    ;
    [loginContentview addSubview:accountview];
    
    
    accountview.sd_layout
    .topSpaceToView(loginContentview,0)
    .leftSpaceToView(loginContentview,0)
    .rightSpaceToView(loginContentview,0)
    .heightIs(44);
    
    UIImageView * accountImageview = [[UIImageView alloc]init];
    accountImageview.image = [UIImage imageNamed:@"iconfont-iconfontyonghutouxiang"];
    [accountview addSubview:accountImageview];
    
    accountImageview.sd_layout
    .leftSpaceToView(accountview,20)
    .centerYEqualToView(accountview)
    .topSpaceToView(accountview,12)
    .bottomSpaceToView(accountview,12)
    .widthIs(17);
    /*
     NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
     [placeholderaddAttribute:NSForegroundColorAttributeName
     value:[UIColor redColor]
     range:NSMakeRange(0, holderText.length)];
     [placeholderaddAttribute:NSFontAttributeName
     value:[UIFontboldSystemFontOfSize:16]
     range:NSMakeRange(0, holderText.length)];
     textField.attributedPlaceholder = placeholder;
     */
    
    
    UITextField *accountTextfield = [[UITextField alloc]init];
    NSString * str  = @"账号登录";
    self.accountTextfield = accountTextfield;
    accountTextfield.delegate = self;
    NSMutableAttributedString * placeholderstr = [[NSMutableAttributedString alloc]initWithString:str];
    [placeholderstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#999999"] range:NSMakeRange(0, str.length)];
    [placeholderstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, str.length)];
    
    accountTextfield.attributedPlaceholder = placeholderstr;
    [accountview addSubview:accountTextfield];
    
    accountTextfield.sd_layout
    .leftSpaceToView(accountImageview,15)
    .rightSpaceToView(accountview,0)
    .topSpaceToView(accountview,0)
    .bottomSpaceToView(accountview,0);
    
    
    
    UIView * passwordview = [[UIView alloc]init];
    passwordview.layer.cornerRadius = 20;
    passwordview.layer.masksToBounds = YES;
    passwordview.layer.borderWidth = 1;
    passwordview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    passwordview.layer.borderColor = [UIColor colorWithHexColorStr:@"#3385ff"].CGColor;
    [loginContentview addSubview:passwordview];
    
    passwordview.sd_layout
    .topSpaceToView(accountview,22)
    .leftSpaceToView(loginContentview,0)
    .rightSpaceToView(loginContentview,0)
    .heightIs(44);
    
    
    UIImageView *passwordImageview = [[UIImageView alloc]init];
    passwordImageview.image = [UIImage imageNamed:@"密码"];
    [passwordview addSubview:passwordImageview];
    
    passwordImageview.sd_layout
    .leftSpaceToView(passwordview,20)
    .centerYEqualToView(passwordview)
    .topSpaceToView(passwordview,12)
    .bottomSpaceToView(passwordview,12)
    .widthIs(17);
    
    UITextField *passwordTextfield = [[UITextField alloc]init];
    NSString *str1  = @"请输入密码";
    passwordTextfield.delegate = self;
    self.passwordTextfield =  passwordTextfield;
    NSMutableAttributedString * placeholderstr1 = [[NSMutableAttributedString alloc]initWithString:str1];
    passwordTextfield.secureTextEntry = YES;
//    passwordTextfield.keyboardType = UIKeyboardTypeNumberPad;
    [placeholderstr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#999999"] range:NSMakeRange(0, str1.length)];
    [placeholderstr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Width_Real(15)] range:NSMakeRange(0, str1.length)];
    
    passwordTextfield.attributedPlaceholder = placeholderstr1;
    
    [passwordview addSubview:passwordTextfield];
    
    passwordTextfield.sd_layout
    .leftSpaceToView(passwordImageview,20)
    .rightSpaceToView(passwordview,0)
    .topSpaceToView(passwordview,0)
    .bottomSpaceToView(passwordview,0);
    
    UIButton * loginBtn = [[UIButton alloc]init];
    [loginBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [loginBtn setTintColor:[UIColor whiteColor]];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    loginBtn.layer.cornerRadius = 20;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginData:) forControlEvents:UIControlEventTouchUpInside];
    [loginContentview addSubview:loginBtn];
    
    loginBtn.sd_layout
    .topSpaceToView(passwordview,22)
    .leftSpaceToView(loginContentview,0)
    .bottomSpaceToView(loginContentview,0)
    .rightSpaceToView(loginContentview,0);
    
    
    UIButton * forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeSystem];;
    [forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetPasswordBtn setTintColor:[UIColor colorWithHexColorStr:@"#999999"]];
    [forgetPasswordBtn addTarget:self action:@selector(forgetJumpViewController) forControlEvents:UIControlEventTouchUpInside];
    forgetPasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:forgetPasswordBtn];
    
    
    forgetPasswordBtn.sd_layout
    .topSpaceToView(loginContentview,10)
    .leftEqualToView(loginContentview)
    .widthRatioToView(loginContentview,0.5)
    .heightIs(15);
    
    
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [registerBtn setTintColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [self.view addSubview:registerBtn];
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [registerBtn addTarget:self action:@selector(registerJumpRegisterViewController) forControlEvents:UIControlEventTouchUpInside];
    
    
    registerBtn.sd_layout
    .topSpaceToView(loginContentview,10)
    .rightEqualToView(loginContentview)
    .widthRatioToView(loginContentview,0.5)
    .heightIs(15);
    
    
    UIButton * agreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreenBtn setImage:[UIImage imageNamed:@"未选"] forState:UIControlStateNormal];
    [agreenBtn setImage:[UIImage imageNamed:@"选中一下"] forState:UIControlStateSelected];
    [agreenBtn addTarget:self action:@selector(agreenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreenBtn];
    _agreenBtn = agreenBtn;
    
    
    agreenBtn.sd_layout.leftEqualToView(forgetPasswordBtn).topSpaceToView(forgetPasswordBtn, 14).widthIs(12).heightEqualToWidth();
    
   
    
    UILabel * titlelabel = [[UILabel alloc]init];
    titlelabel.text = @"阅读并同意";
    CGRect disCountrect = [titlelabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    titlelabel.font = [UIFont systemFontOfSize:14];
    titlelabel.textAlignment = NSTextAlignmentLeft;
    titlelabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    label.frame = CGRectMake(Width_Real(24), CGRectGetMaxY(nextBtn.frame), disCountrect.size.width, Height_Real(20));
    [self.view addSubview:titlelabel];
    titlelabel.sd_layout.leftSpaceToView(agreenBtn, 5).widthIs(disCountrect.size.width).topSpaceToView(forgetPasswordBtn, 10).heightIs(20);
    
    
    
    UIButton * userProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userProtocolBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    
    CGRect userProtocol = [userProtocolBtn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    userProtocolBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    userProtocolBtn.tag = 0;
    [userProtocolBtn addTarget:self action:@selector(jumpInformationAction:) forControlEvents:UIControlEventTouchUpInside];
    [userProtocolBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//    userProtocolBtn.frame = CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMaxY(nextBtn.frame) , userProtocol.size.width, Height_Real(20));
    [self.view addSubview:userProtocolBtn];
    userProtocolBtn.sd_layout.leftSpaceToView(titlelabel, 0).topSpaceToView(forgetPasswordBtn, 10).widthIs(userProtocol.size.width).heightIs(20);

    
    UILabel * andLabel = [[UILabel alloc]init];
    andLabel.text = @"和";
    andLabel.textAlignment = NSTextAlignmentCenter;
    andLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    CGRect andLabelRect = [andLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    andLabel.font = [UIFont systemFontOfSize:14];
//    andLabel.frame = CGRectMake(CGRectGetMaxX(userProtocolBtn.frame), CGRectGetMaxY(nextBtn.frame), andLabelRect.size.width, Height_Real(20));
    [self.view addSubview:andLabel];
    andLabel.sd_layout.leftSpaceToView(userProtocolBtn, 0).topSpaceToView(forgetPasswordBtn, 10).widthIs(andLabelRect.size.width).heightIs(20);
    
    UIButton * userPrivacyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userPrivacyBtn setTitle:@"《隐私保护政策》" forState:UIControlStateNormal];
    userPrivacyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    CGRect userPrivacy = [userPrivacyBtn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    userPrivacyBtn.tag = 1;
    [userPrivacyBtn addTarget:self action:@selector(jumpInformationAction:) forControlEvents:UIControlEventTouchUpInside];
    [userPrivacyBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//    userPrivacyBtn.frame = CGRectMake(CGRectGetMaxX(andLabel.frame), CGRectGetMaxY(nextBtn.frame), userPrivacy.size.width, Height_Real(20));
    [self.view addSubview:userPrivacyBtn];
    userPrivacyBtn.sd_layout.leftSpaceToView(andLabel, 0).topSpaceToView(forgetPasswordBtn, 10).widthIs(userPrivacy.size.width).heightIs(20);
    
    
    
    UILabel * label = [[UILabel alloc]init];
    label.text = @"微 信 登 录";
    _label = label;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    label.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
    
    label.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(userPrivacyBtn,60)
    .widthIs(100)
    .heightIs(20);
    
    
    UIButton * wxLoginBtn = [[UIButton alloc]init];
    [wxLoginBtn setImage:[UIImage imageNamed:@"iconfont-weixin"] forState:UIControlStateNormal];
    [self.view addSubview:wxLoginBtn];
    
    [wxLoginBtn addTarget:self action:@selector(wxLogin:) forControlEvents:UIControlEventTouchUpInside];
    wxLoginBtn.sd_layout
    .topSpaceToView(label,30)
    .centerXEqualToView(self.view)
    .widthIs(50)
    .heightEqualToWidth();
    
    
    if ([WXApi isWXAppInstalled]) {
        
        
        wxLoginBtn.hidden = NO;
        _label.hidden = NO;
       // btn.hidden = NO;
        //SendAuthReq * req = [[SendAuthReq alloc]init];
        //req.scope = @"snsapi_userinfo";
        //req.state = @"1";
        
        
        //[WXApi sendReq:req];
    }else{
        _label.hidden = YES;
        wxLoginBtn.hidden = YES;
        //btn.hidden = YES;
        //把微信登录的按钮隐藏掉
        //[self setupAlertController];
    }
}


- (void)agreenAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}


-(void)jumpInformationAction:(UIButton *)jumpBtn{
    NSString * str = [NSString string];
    RSUserInformationViewController * userInformationVc = [[RSUserInformationViewController alloc]init];
    if (jumpBtn.tag == 0) {
        //用户
        str = @"https://www.slsw.link/slsw/UserAgreement.jsp";
        userInformationVc.title = @"用户协议";
    }else{
        //隐私
        str = @"https://www.slsw.link/slsw/agreement.jsp";
        userInformationVc.title = @"隐私保护政策";
    }
    userInformationVc.urlStr = str;
    [self.navigationController pushViewController:userInformationVc animated:YES];
}




- (void)wxSendAuthResponse:(SendAuthResp *)resp{
    RSWeakself(self);
    if (resp.errCode == 0) {
        //获取授权成功
        NSLog(@"获取授权成功");
        NSString * code = resp.code;
        [[WXApiManager sharedManager]getAccessTokenWithCode:code andSuccess:^(NSString * _Nonnull token, NSString * _Nonnull openId, NSString * _Nonnull unionid) {
            [[WXApiManager sharedManager]getUserInfoWithAccessToken:token andOpenId:openId andSuccess:^(NSString * _Nonnull nickname, NSString * _Nonnull openid, NSString * _Nonnull headimgurl, NSString * _Nonnull unionid, NSString * _Nonnull sex, NSString * _Nonnull language, NSString * _Nonnull city, NSString * _Nonnull country, NSString * _Nonnull province,NSArray * _Nonnull privilege) {
                
//                CLog(@"-------------------------------------------------");
                
                
//                RSWeiXiModel * weixiModel = [[RSWeiXiModel alloc]init];
//                weixiModel.openid = openId;
//                weixiModel.unionid = unionid;
//                weixiModel.nickname = nickname;
//                weixiModel.city = city;
//                weixiModel.country = country;
//                weixiModel.headimgurl = headimgurl;
//                weixiModel.language = language;
//                weixiModel.privilege = privilege;
//                weixiModel.province = province;
//                weixiModel.sex = sex;
//                //这边要对weixiModel进行保存
//                //[GlobaHelper setObject:weixiModel key:@"weiximodel"];
//                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//                [user setObject:weixiModel.openid forKey:@"openid"];
//                [user setObject:weixiModel.unionid forKey:@"unionid"];
//                [user setObject:weixiModel.nickname forKey:@"nickname"];
//                [user setObject:weixiModel.city forKey:@"city"];
//                [user setObject:weixiModel.country forKey:@"country"];
//                [user setObject:weixiModel.headimgurl forKey:@"headimgurl"];
//                [user setObject:weixiModel.language forKey:@"language"];
//                [user setObject:weixiModel.privilege forKey:@"privilege"];
//                [user setObject:weixiModel.province forKey:@"province"];
//                [user setObject:weixiModel.sex forKey:@"sex"];
//                [user synchronize];
                [SVProgressHUD showWithStatus:@"正在验证中"];
                NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
                //这边要先获取到微信里面UID;
                //自己做测试用的
                ////                weixiModel.unionid = @"oLUv8jh77JK7qulXqZ7WvgTOO9_Q";
                //                NSString *unionid = [NSString stringWithFormat:@"oLUv8jh77JK7qulXqZ7WvgTOO%d_Q",arc4random_uniform(256)];
                //                weixiModel.unionid = unionid;
                if (unionid == nil) {
                    [phoneDict setObject:@"" forKey:@"WC_UID"];
                }else{
                    [phoneDict setObject:unionid forKey:@"WC_UID"];
                }
                //二进制数
                NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
                NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                //URL_IS_WECHAT_REGISTED_IOS URL_IS_WECHAT_REGISTED
                XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                [network getDataWithUrlString:URL_WECHAT_QQ_LOGIN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                    [SVProgressHUD dismiss];
                    if (success) {
                        if(![json[@"MSG_CODE"] isEqualToString:@"U_NOT_EXIST"]){
                            [RSInitUserInfoTool registermodelUSER_CODE:[NSString stringWithFormat:@"%@",json[@"Data"][@"USER_CODE"]] andVERIFYKEY:[NSString stringWithFormat:@"%@",json[@"Data"][@"VERIFYKEY"]] andViewController:nil andObtain:^(BOOL isValue) {
                                if (isValue) {
                                    
//                                    CLog(@"==21===============12=======================================21");
                                    AppDelegate * app =(AppDelegate *) [UIApplication sharedApplication].delegate;
                                    RSMainTabBarViewController * mainTabbar =(RSMainTabBarViewController *)app.window.rootViewController;
//                                    RSMainTabBarViewController * mainTabbar = (RSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
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
                                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                    
                                    
//                                    RSMainTabBarViewController * mainTabbar = (RSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//                                    RSLeftViewController * leftVc = [[RSLeftViewController alloc]init];
//                                    RSMyNavigationViewController *navi3 = [mainTabbar.viewControllers objectAtIndex:3];
//                                    NSMutableArray * controllers = [NSMutableArray arrayWithArray:navi3.viewControllers];
//                                    controllers[0] = leftVc;
//                                    [navi3 setViewControllers:controllers];
//                                    leftVc.tabBarItem.tag = 3;
//                                    leftVc.tabBarItem.title = @"我的";
//                                    leftVc.tabBarItem.image = [UIImage imageNamed:@"我的-未选中"];
//                                    UIImage * image3 = [UIImage imageNamed:@"我的-选中"];
//                                    UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                                    leftVc.tabBarItem.selectedImage = newImage3;
//                                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
//                                [[NSNotificationCenter defaultCenter]postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];
                                    
//                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"formLoginToHomeViewController" object:nil];
                                    
                                    
                                    
                                }
                            }];
                            //登录信息，获取用户的信息
                            //对界面进行判断跳转回去
                            //从登录的页面跳转到首页面
                        }else{
                            //这边要对U_NOT_EXIST这个来进行判断
//                            [[NSNotificationCenter defaultCenter]postNotificationName:@"jumpWeixinViewControler" object:nil];
//                            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//                            RSWeiXiModel * weiximodel = [[RSWeiXiModel alloc]init];
//                            weiximodel.city = [user objectForKey:@"city"];
//                            weiximodel.country = [user objectForKey:@"country"];
//                            weiximodel.headimgurl = [user objectForKey:@"headimgurl"];
//                            weiximodel.language = [user objectForKey:@"language"];
//                            weiximodel.nickname = [user objectForKey:@"nickname"];
//                            weiximodel.openid = [user objectForKey:@"openid"];
//                            weiximodel.privilege = [user objectForKey:@"privilege"];
//                            weiximodel.province = [user objectForKey:@"province"];
//                            weiximodel.sex = [user objectForKey:@"sex"];
//                            weiximodel.unionid = [user objectForKey:@"unionid"];
                            RSWeiXiViewController * weixiVc = [[RSWeiXiViewController alloc]init];
                            weixiVc.unionid = unionid;
                            weixiVc.headimgurl = headimgurl;
                            weixiVc.nickname = nickname;
                            //    RSWeiXiModel *weixiModel = [GlobaHelper getObjectForKey:@"weiximodel"];
   //                            weixiVc.weixiModel = weiximodel;
                            //通过这句话，就是让左边的登录信息的界面自动返回界面外边
                            [weakSelf.navigationController pushViewController:weixiVc animated:YES];
                        }
                    }
                }];
            }];
        }];
    }
}


#pragma mark -- 微信登录
- (void)wxLogin:(UIButton *)btn{
    //al138173
    if (self.agreenBtn.selected == true){
        //这边要对微信是否登录过的进行验证
        if ([WXApi isWXAppInstalled]) {
            btn.hidden = NO;
            _label.hidden = NO;
            SendAuthReq* req =[[SendAuthReq alloc]init];
            req.scope = @"snsapi_userinfo";
            req.state = @"1";
    //        [WXApi sendReq:req];
            [WXApiManager sharedManager].delegate = self;
            [WXApi sendReq:req completion:nil];
        }else{
            _label.hidden = YES;
            btn.hidden = YES;
            //把微信登录的按钮隐藏掉
            //[self setupAlertController];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请同意并阅读《用户协议》和《隐私保护政策》"];
    }
}




#pragma mark -- 跳转到注册界面控制器
- (void)registerJumpRegisterViewController{
    RSRegisterViewController *registerVc = [[RSRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVc animated:YES];
}


#pragma mark -- 跳转到忘记密码界面
- (void)forgetJumpViewController{
    RSFogetPasswordViewController *forgetPasswordVc = [[RSFogetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetPasswordVc animated:YES];
}


#pragma mark -- 登录
- (void)loginData:(UIButton *)btn{
   
    //账号
    if([self istext:self.accountTextfield])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入账号名"];
        return;
    }
    //密码
    if(![self validatePassword:self.passwordTextfield.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    //密码的位数
    if (self.passwordTextfield.text.length<6)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入6-18位密码"];
        return;
    }
    if (self.passwordTextfield.text.length>18) {
        [SVProgressHUD showErrorWithStatus:@"请输入6-18位密码"];
        return;
    }
    
    if (self.agreenBtn.isSelected == false){
        [SVProgressHUD showErrorWithStatus:@"请同意并阅读《用户协议》和《隐私保护政策》"];
        return;
    }
    
    
//    //密码的字符是不是正确的
//    if(![self isValidPassword:self.passwordTextfield.text])
//    {  //以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~18
//        [SVProgressHUD showErrorWithStatus:@"密码包含无效字符"];
//        return;
//    }
    [self.view endEditing:YES];
    //登录请求
    [self initLogin];
    
    
}

#pragma mark -- 登录请求
- (void)initLogin{
    [SVProgressHUD showWithStatus:@"正在登录"];
    NSMutableDictionary *request = [NSMutableDictionary dictionary];
    [request setObject:self.accountTextfield.text forKey:@"USER_CODE"];
    [request setObject:[MyMD5 md5:self.passwordTextfield.text] forKey:@"USER_PASSWORD"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:request options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    //URL_LOGIN_IOS URL_LOGIN
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_LOGIN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            CLog(@"==================================%@",json);
            if (Result) {
//                registerModel = [RSRegisterModel yy_modelWithJSON:json[@"Data"]];
//                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:registerModel];
//                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                [user setObject:data forKey:@"user"];
//                [user setObject:registerModel.VERIFYKEY forKey:@"VERIFYKEY"];
//                [user synchronize];
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
//               // [[NSNotificationCenter defaultCenter]postNotificationName:@"loginNSNotificationCenter" object:nil];
//                //对界面进行判断跳转回去
//                //RSHomeViewController * homeVc = [[RSHomeViewController alloc]init];
////                [weakSelf.navigationController popViewControllerAnimated:YES];
//               // [weakSelf.navigationController popToViewController:homeVc animated:YES];
//                RSMainTabBarViewController * mainTabbarVc = [[RSMainTabBarViewController alloc]init];
//                mainTabbarVc.selectedIndex = 0;
//                mainTabbarVc.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                [UIApplication sharedApplication].keyWindow.rootViewController = mainTabbarVc;
    
//                 NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                [RSInitUserInfoTool registermodelUSER_CODE:[NSString stringWithFormat:@"%@",json[@"Data"][@"USER_CODE"]] andVERIFYKEY:[NSString stringWithFormat:@"%@",json[@"Data"][@"VERIFYKEY"]] andViewController:weakSelf];
                  
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [user setObject:[NSString stringWithFormat:@"1"] forKey:@"temp"];
//                    [user synchronize];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];
                   // [weakSelf.tabBarController setSelectedIndex:0];
                   // [weakSelf.navigationController popViewControllerAnimated:NO];
//                });
                [RSInitUserInfoTool registermodelUSER_CODE:[NSString stringWithFormat:@"%@",json[@"Data"][@"USER_CODE"]] andVERIFYKEY:[NSString stringWithFormat:@"%@",json[@"Data"][@"VERIFYKEY"]] andViewController:weakSelf andObtain:^(BOOL isValue) {
                     if (isValue) {
//                         RSMainTabBarViewController * mainTabbar = (RSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
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
//                         [navi3.navigationController popToRootViewControllerAnimated:YES];
                         [weakSelf dismissViewControllerAnimated:YES completion:nil];
//                         [user setObject:[NSString stringWithFormat:@"1"] forKey:@"temp"];
//                         [user synchronize];
//                         [[NSNotificationCenter defaultCenter]postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];
                     }
                }];
                //友盟统计
//                [MobClick profileSignInWithPUID:_accountTextfield.text];
            }else{
                [SVProgressHUD showErrorWithStatus:@"用户名或者密码错误"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"用户名或者密码错误"];
        }
    }];
}













#pragma mark -- 这边接收到注册信息的东西,自动登录
- (void)autoLoginAction{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    //这边不知道会不会有问题？
    [dict setObject:[user objectForKey:@"CODE"] forKey:@"USER_CODE"];
    [dict setObject:[user objectForKey:@"PWD"]forKey:@"USER_PASSWORD"] ;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    //__weak typeof(self) weakSelf = self;
    
    //URL_LOGIN_IOS URL_LOGIN
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_LOGIN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
//                registerModel = [RSRegisterModel yy_modelWithJSON:json[@"Data"]];
//                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:registerModel];
//                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                [user setObject:data forKey:@"user"];
//                [user setObject:registerModel.VERIFYKEY forKey:@"VERIFYKEY"];
//                [user synchronize];
                
                
                
                
//                [RSInitUserInfoTool registermodelUSER_CODE:[NSString stringWithFormat:@"%@",json[@"Data"][@"USER_CODE"]] andVERIFYKEY:[NSString stringWithFormat:@"%@",json[@"Data"][@"VERIFYKEY"]] andViewController:weakSelf];
                
                
                [RSInitUserInfoTool registermodelUSER_CODE:[NSString stringWithFormat:@"%@",json[@"Data"][@"USER_CODE"]] andVERIFYKEY:[NSString stringWithFormat:@"%@",json[@"Data"][@"VERIFYKEY"]] andViewController:weakSelf andObtain:^(BOOL isValue) {
                    
                    if (isValue) {
//                        [user setObject:[NSString stringWithFormat:@"1"] forKey:@"temp"];
//                        [user synchronize];
                      
//                        RSMainTabBarViewController * mainTabbar = (RSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                        
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
//                         [navi3.navigationController popToRootViewControllerAnimated:YES];
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                        
//                        [[NSNotificationCenter defaultCenter]postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];
                        
                    }       
                  
                }];
                
                
                
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                    [user setObject:[NSString stringWithFormat:@"1"] forKey:@"temp"];
//                    [user synchronize];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];
                   // [weakSelf.tabBarController setSelectedIndex:0];
                   // [weakSelf.navigationController popViewControllerAnimated:NO];
                    
                    
//                });
                
                
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                
              //  [[NSNotificationCenter defaultCenter]postNotificationName:@"loginNSNotificationCenter" object:nil];
                
                
                //友盟统计
//                [MobClick profileSignInWithPUID:[user objectForKey:@"CODE"]];
                
                
                //RSHomeViewController * homeVc = [[RSHomeViewController alloc]init];
                //对界面进行判断跳转回去
//                 [weakSelf.navigationController popViewControllerAnimated:YES];
                //[weakSelf.navigationController popToViewController:homeVc animated:YES];
                
//                RSMainTabBarViewController * mainTabbarVc = [[RSMainTabBarViewController alloc]init];
//
//
//                mainTabbarVc.selectedIndex = 0;
//
//                 mainTabbarVc.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//
//              [UIApplication sharedApplication].keyWindow.rootViewController = mainTabbarVc;
            }else{
                [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
        }
    }];
}



#pragma mark -- uitextfieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textfield{
    [textfield resignFirstResponder];
    return YES;
}


//#pragma mark -- 限定输入uitextfield的字符
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    NSCharacterSet *cs;
//    
//    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
//    BOOL canChange = [string isEqualToString:filtered];
//    return canChange;
//}



- (void)setupAlertController {
    [JHSysAlertUtil presentAlertViewWithTitle:@"温馨提示" message:@"请先安装微信客户端" confirmTitle:@"确定" handler:nil];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//    [alert addAction:actionConfirm];
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//        alert.modalPresentationStyle = UIModalPresentationFullScreen;
//    }
//    [self presentViewController:alert animated:YES completion:nil];
}



//#pragma mark -- 跳转到微信登录的地方
//- (void)jumpWeiXinViewController{
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    RSWeiXiModel * weiximodel = [[RSWeiXiModel alloc]init];
//    weiximodel.city = [user objectForKey:@"city"];
//    weiximodel.country = [user objectForKey:@"country"];
//    weiximodel.headimgurl = [user objectForKey:@"headimgurl"];
//    weiximodel.language = [user objectForKey:@"language"];
//    weiximodel.nickname = [user objectForKey:@"nickname"];
//    weiximodel.openid = [user objectForKey:@"openid"];
//    weiximodel.privilege = [user objectForKey:@"privilege"];
//    weiximodel.province = [user objectForKey:@"province"];
//    weiximodel.sex = [user objectForKey:@"sex"];
//    weiximodel.unionid = [user objectForKey:@"unionid"];
//    RSWeiXiViewController * weixiVc = [[RSWeiXiViewController alloc]init];
//    //    RSWeiXiModel *weixiModel = [GlobaHelper getObjectForKey:@"weiximodel"];
//    weixiVc.weixiModel = weiximodel;
//    //通过这句话，就是让左边的登录信息的界面自动返回界面外边
//    [self.navigationController pushViewController:weixiVc animated:YES];
//}



//- (void)jumpHomeViewController{
////    RSMainTabBarViewController * maintabarVc = [[RSMainTabBarViewController alloc]init];
////    maintabarVc.selectedIndex = 0;
////    maintabarVc.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
////    [UIApplication sharedApplication].keyWindow.rootViewController = maintabarVc;
//
//
//    //TODO:同一个RSMainTabbarViewController
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"ViewControllerShouldReloadNotification" object:nil];
//        //[self.tabBarController setSelectedIndex:0];
//        //[self.navigationController popViewControllerAnimated:NO];
//    });
//}

//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"isNewData" object:nil];
//}

- (void)dealloc{
   // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"autoLoginAction" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
