//
//  RSNextRegisterViewController.m
//  石来石往
//
//  Created by mac on 17/5/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNextRegisterViewController.h"
#import "RSRegisterModel.h"
#define BCOLOR [UIColor colorWithHexColorStr:@"#f9f9f9"]
#import "RSHomeViewController.h"
#import <YYModel.h>
#import "MyMD5.h"
//#define NUMBERS @"0123456789\n"
@interface RSNextRegisterViewController ()<UITextFieldDelegate>
{
    UIView *_navigationview;
    
    /**输入昵称*/
    UITextField *_nameTextField;
    
    /**输入密码*/
    UITextField *_passwordTextField;
    /**再次输入密码*/
    UITextField *_againpasswordTextField;
    /**请输入公司的名称*/
    UITextField *_companyNameTextField;
    /**请输入公司所在的职位*/
    UITextField *_positionTextfield;
    
    /**注册按键*/
    UIButton * _registerBtn;
}
@end

@implementation RSNextRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = BCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"注册";
    
    [self addCustomContentview];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 添加本控制器里面内容
- (void)addCustomContentview{
    
    UIView * contentview = [[UIView alloc]init];
    contentview.backgroundColor = BCOLOR;
    [self.view addSubview:contentview];
    contentview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(275);
    
    
    //输入昵称
    UIView * nameview = [[UIView alloc]init];
    nameview.backgroundColor = BCOLOR;
    [contentview addSubview:nameview];
    
    UITextField *nameTextField = [[UITextField alloc]init];
    NSString *nameStr = @"请输入昵称";
    NSMutableAttributedString *placeStr = [[NSMutableAttributedString alloc]initWithString:nameStr];
    _nameTextField = nameTextField;
    _nameTextField.delegate = self;
    [placeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#333333"] range:NSMakeRange(0, nameStr.length)];
    [placeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, nameStr.length)];
    nameTextField.attributedPlaceholder = placeStr;
    [nameview addSubview:nameTextField];
    
    UIView *nameBottomview = [[UIView alloc]init];
    nameBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eaeaea"];
    [nameview addSubview:nameBottomview];
    
    nameview.sd_layout
    .topSpaceToView(contentview,0)
    .leftSpaceToView(contentview,12)
    .rightSpaceToView(contentview,12)
    .heightIs(55);
    
    
    nameTextField.sd_layout
    .leftSpaceToView(nameview,8)
    .rightSpaceToView(nameview,8)
    .topSpaceToView(nameview,11)
    .bottomSpaceToView(nameview,0);
    
    
    
    nameBottomview.sd_layout
    .rightSpaceToView(nameview,0)
    .leftSpaceToView(nameview,0)
    .bottomSpaceToView(nameview,0)
    .heightIs(1);
    
    
    
    //输入密码
    UIView * passwordview = [[UIView alloc]init];
    passwordview.backgroundColor = BCOLOR;
    [contentview addSubview:passwordview];
    
    UITextField *passwordTextField = [[UITextField alloc]init];
    NSString *passwordStr = @"请输入6-18位密码";
    passwordTextField.delegate = self;
    passwordTextField.secureTextEntry = YES;
    _passwordTextField = passwordTextField;
//    passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    NSMutableAttributedString *placeStr1 = [[NSMutableAttributedString alloc]initWithString:passwordStr];
    [placeStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#333333"] range:NSMakeRange(0, passwordStr.length)];
    [placeStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, passwordStr.length)];
    passwordTextField.attributedPlaceholder = placeStr1;
    [passwordview addSubview:passwordTextField];
    
    UIView *passwordBottomview = [[UIView alloc]init];
    passwordBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eaeaea"];
    [passwordview addSubview:passwordBottomview];
    
    passwordview.sd_layout
    .topSpaceToView(nameview,0)
    .leftSpaceToView(contentview,12)
    .rightSpaceToView(contentview,12)
    .heightIs(55);
    
    
    passwordTextField.sd_layout
    .leftSpaceToView(passwordview,8)
    .rightSpaceToView(passwordview,8)
    .topSpaceToView(passwordview,11)
    .bottomSpaceToView(passwordview,0);
    
    
    
    passwordBottomview.sd_layout
    .rightSpaceToView(passwordview,0)
    .leftSpaceToView(passwordview,0)
    .bottomSpaceToView(passwordview,0)
    .heightIs(1);
    
    
    //再次输入密码
    
    UIView * againpasswordview = [[UIView alloc]init];
    againpasswordview.backgroundColor = BCOLOR;
    [contentview addSubview:againpasswordview];
    
    UITextField *againpasswordTextField = [[UITextField alloc]init];
    NSString *againpasswordStr = @"请再次输入6-18位密码";
    againpasswordTextField.delegate = self;
//    againpasswordTextField.keyboardType = UIKeyboardTypeNumberPad;
    againpasswordTextField.secureTextEntry = YES;
    _againpasswordTextField = againpasswordTextField;
    NSMutableAttributedString *placeStr2 = [[NSMutableAttributedString alloc]initWithString:againpasswordStr];
    [placeStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#333333"] range:NSMakeRange(0, againpasswordStr.length)];
    [placeStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, againpasswordStr.length)];
    againpasswordTextField.attributedPlaceholder = placeStr2;
    [againpasswordview addSubview:againpasswordTextField];
    
    UIView *againpasswordBottomview = [[UIView alloc]init];
    againpasswordBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eaeaea"];
    [againpasswordview addSubview:againpasswordBottomview];
    
    againpasswordview.sd_layout
    .topSpaceToView(passwordview,0)
    .leftSpaceToView(contentview,12)
    .rightSpaceToView(contentview,12)
    .heightIs(55);
    
    
    againpasswordTextField.sd_layout
    .leftSpaceToView(againpasswordview,8)
    .rightSpaceToView(againpasswordview,8)
    .topSpaceToView(againpasswordview,11)
    .bottomSpaceToView(againpasswordview,0);
    
    
    
    againpasswordBottomview.sd_layout
    .rightSpaceToView(againpasswordview,0)
    .leftSpaceToView(againpasswordview,0)
    .bottomSpaceToView(againpasswordview,0)
    .heightIs(1);
    
    
    
    //请输入公司名字
    UIView *companyNameview = [[UIView alloc]init];
    companyNameview.backgroundColor = BCOLOR;
    [contentview addSubview:companyNameview];
    
    
    UITextField *companyNameTextField = [[UITextField alloc]init];
    NSString *companyNameStr = @"请输入公司名称";
    _companyNameTextField = companyNameTextField;
    _companyNameTextField.delegate = self;
    NSMutableAttributedString *placeStr3 = [[NSMutableAttributedString alloc]initWithString:companyNameStr];
    [placeStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#333333"] range:NSMakeRange(0, companyNameStr.length)];
    [placeStr3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, companyNameStr.length)];
    companyNameTextField.attributedPlaceholder = placeStr3;
    [companyNameview addSubview:companyNameTextField];
    
    UIView *companyNameBottomview = [[UIView alloc]init];
    companyNameBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eaeaea"];
    [companyNameview addSubview:companyNameBottomview];
    
    companyNameview.sd_layout
    .topSpaceToView(againpasswordview,0)
    .leftSpaceToView(contentview,12)
    .rightSpaceToView(contentview,12)
    .heightIs(55);
    
    
    companyNameTextField.sd_layout
    .leftSpaceToView(companyNameview,8)
    .rightSpaceToView(companyNameview,8)
    .topSpaceToView(companyNameview,11)
    .bottomSpaceToView(companyNameview,0);
    
    
    
    companyNameBottomview.sd_layout
    .rightSpaceToView(companyNameview,0)
    .leftSpaceToView(companyNameview,0)
    .bottomSpaceToView(companyNameview,0)
    .heightIs(1);
    
    
    //点击选择所在的职位
    UIView * positionview = [[UIView alloc]init];
    positionview.backgroundColor = BCOLOR;
    [contentview addSubview:positionview];
    
    UITextField *positionTextfield = [[UITextField alloc]init];
    NSString *positionStr = @"请输入公司职位";
    _positionTextfield = positionTextfield;
    _positionTextfield.delegate = self;
    NSMutableAttributedString *placeStr4 = [[NSMutableAttributedString alloc]initWithString:positionStr];
    [placeStr4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#333333"] range:NSMakeRange(0, positionStr.length)];
    [placeStr4 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, positionStr.length)];
    positionTextfield.attributedPlaceholder = placeStr4;
    [positionview addSubview:positionTextfield];
    
    UIView *positionBottomview = [[UIView alloc]init];
    positionBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eaeaea"];
    [positionview addSubview:positionBottomview];
    
    
    positionview.sd_layout
    .topSpaceToView(companyNameview,0)
    .leftSpaceToView(contentview,12)
    .rightSpaceToView(contentview,12)
    .bottomSpaceToView(contentview,0);
    
    
    positionTextfield.sd_layout
    .leftSpaceToView(positionview,8)
    .rightSpaceToView(positionview,8)
    .topSpaceToView(positionview,11)
    .bottomSpaceToView(positionview,0);
    
    
    
    positionBottomview.sd_layout
    .rightSpaceToView(positionview,0)
    .leftSpaceToView(positionview,0)
    .bottomSpaceToView(positionview,0)
    .heightIs(1);
    
    
    
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [registerBtn setTintColor:[UIColor whiteColor]];
    [registerBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    _registerBtn = registerBtn;
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    registerBtn.layer.cornerRadius = 20;
    registerBtn.layer.masksToBounds = YES;
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    
    registerBtn.sd_layout
    .topSpaceToView(contentview,40)
    .centerXEqualToView(self.view)
    .widthIs(284)
    .heightIs(44);
    
    
}

#pragma mark -- 注册
- (void)registerAction:(UIButton *)btn{
   
    
    if(![self isEnglishAndChinese:_nameTextField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
        return;
    }
    //公司的名字
     if(![self isEnglishAndChinese:_companyNameTextField.text])
     {
     [SVProgressHUD showErrorWithStatus:@"公司的名字"];
     return;
     }
    if(![self validatePassword:_passwordTextField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请设置注册密码"];
        return;
    }
    if (_passwordTextField.text.length<6)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
    if (_passwordTextField.text.length>18)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
    
//    if ([self isValidPassword:_passwordTextField.text]) {
//        
//        //以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~18
//        [SVProgressHUD showErrorWithStatus:@"密码包含无效字符"];
//        return;
//    }
    
    if(![self validatePassword:_againpasswordTextField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请设置注册密码"];
        return;
    }
    if (_againpasswordTextField.text.length<6)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
    if (_againpasswordTextField.text.length>20)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
//    if(![self isValidPassword:_againpasswordTextField.text])
//    {
//        //以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~18
//        [SVProgressHUD showErrorWithStatus:@"密码包含无效字符"];
//        return;
//    }
    if(![_passwordTextField.text isEqualToString:_againpasswordTextField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"密码不一致"];
        return;
    }
    //公司的职位
    if(![self isEnglishAndChinese:_positionTextfield.text])
    {
        [SVProgressHUD showErrorWithStatus:@"职位不合法"];
        return;
    }
    [self.view endEditing:YES];
    [self initRegist];
    
    
}
//注册请求
-(void)initRegist
{
    NSMutableDictionary * registerDict = [NSMutableDictionary dictionary];
    //[registerDict setObject:_phoneLabel forKey:@"USER_CODE"];
    [registerDict setObject:[MyMD5 md5:_passwordTextField.text] forKey:@"userPassword"];
    [registerDict setObject:_positionTextfield.text forKey:@"remark"];
    [registerDict setObject:_nameTextField.text forKey:@"userName"];
    [registerDict setObject:_phoneLabel forKey:@"mobilePhone"];
    [registerDict setObject:[NSString stringWithFormat:@"%@",@"youke"] forKey:@"flag"];
    //[registerDict setObject:[NSString stringWithFormat:@""] forKey:@"CREATE_USER"];
    //[registerDict setObject:[NSString stringWithFormat:@""] forKey:@"EMAIL"];
    //[registerDict setObject:[NSString stringWithFormat:@""] forKey:@"description"];
    //[registerDict setObject:[NSString stringWithFormat:@""] forKey:@"INVITE_CODE"];
    [registerDict setObject:_companyNameTextField.text forKey:@"officeName"];
   // [registerDict setObject:[NSString stringWithFormat:@""] forKey:@"OFFICE_CODE"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:registerDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    //URL_REGISTE_OFFICE_IOS URL_REGISTE_OFFICE
    //__weak typeof(self) weakSelf = self;
    //RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_REGISTE_OFFICE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                
//                weakSelf.registerModel = [RSRegisterModel yy_modelWithJSON:json];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [SVProgressHUD showSuccessWithStatus:@"注册成功"];
//                    //这边要对网络请求成功之后，进行数据的保存到NSUserDefault中
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                    //为了能够注册之后，自动去登录之后账号
                    [user setObject:_phoneLabel forKey:@"CODE"];
                    [user setObject:[MyMD5 md5:_passwordTextField.text] forKey:@"PWD"];
                    [user synchronize];
                    
                    
                    
                    //利用通知来让登录界面，自动登录
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"registerSuccessNSNotification" object:nil];
                    
//                    RSMainTabBarViewController * mainTabbarVc = [[RSMainTabBarViewController alloc]init];
//                    mainTabbarVc.selectedIndex = 0;
//                    [UIApplication sharedApplication].keyWindow.rootViewController = mainTabbarVc;
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"注册失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"注册失败"];
        }
    }];
}


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

/*
 
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
