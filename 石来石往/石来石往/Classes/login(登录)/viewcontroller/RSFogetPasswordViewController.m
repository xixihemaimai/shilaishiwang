//
//  RSFogetPasswordViewController.m
//  石来石往
//
//  Created by mac on 17/5/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFogetPasswordViewController.h"
#define BCOLOR [UIColor colorWithHexColorStr:@"#f9f9f9"]
#import "MyMD5.h"
#define NUMBERS @"0123456789\n"
@interface RSFogetPasswordViewController ()<UITextFieldDelegate>
{
    UIView *_navigationview;
    
    /**手机的phoneTextfield*/
    UITextField * _phoneTextfield;
    
    /**手机的验证码*/
    UITextField * _codeTextfield;
    
    /**新密码*/
    UITextField *_newPasswordTextfield;
    
    /**再次输入新的密码*/
    UITextField * _againPasswordTextfield;
    
    /**发送验证码*/
    UIButton  * _sendCodeBtn;
    
    
    /**确认修改按键*/
    UIButton * _sureRevampBtn;
    
    //图形验证码输入框
    UITextField * _smsTextField;
    //更改图形验证码
    UIButton * _smsBtn;
    
}

/**添加定时器*/
//@property (nonatomic,strong)NSTimer *timer;
/**定时器的时间*/
//@property (nonatomic,assign)NSInteger count;

/**随机uuid*/
@property (nonatomic,copy)NSString * uuid;
@end

@implementation RSFogetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.uuid = [NSString get_uuid];
    [IQKeyboardManager sharedManager].enable = NO;
//    self.count = 60;
    self.title = @"找回密码";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BCOLOR;
    [self addCustomCententview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addCustomCententview{
    UIView *contentview = [[UIView alloc]init];
    contentview.backgroundColor = [UIColor whiteColor];
    contentview.layer.cornerRadius = 5;
    contentview.layer.masksToBounds = YES;
    [self.view addSubview:contentview];
    
    contentview.sd_layout
    .topSpaceToView(self.view,10)
    .leftSpaceToView(self.view,12)
    .rightSpaceToView(self.view,12)
    .heightIs(250);
    
    
    UIView * phoneview = [[UIView alloc]init];
    phoneview.backgroundColor = [UIColor whiteColor];
    [contentview addSubview:phoneview];
    
    UIImageView  *phoneImageview = [[UIImageView alloc]init];
    phoneImageview.image = [UIImage imageNamed:@"手机"];
    [phoneview addSubview:phoneImageview];
    
    UITextField *phoneTextfield = [[UITextField alloc]init];
    phoneTextfield.borderStyle = UITextBorderStyleNone;
    _phoneTextfield = phoneTextfield;
    NSString *phoneStr = @"请输入手机号码";
    phoneTextfield.keyboardType = UIKeyboardTypePhonePad;
    //[_phoneTextfield addTarget:self action:@selector() forControlEvents:UIControlEventValueChanged];
    NSMutableAttributedString *placeStr = [[NSMutableAttributedString alloc]initWithString:phoneStr];
    [placeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#999999"] range:NSMakeRange(0, phoneStr.length)];
    [placeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, phoneStr.length)];
    phoneTextfield.attributedPlaceholder = placeStr;
    [phoneview addSubview:phoneTextfield];
    
    UIView *phoneBottomview = [[UIView alloc]init];
    phoneBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e5e5e5"];
    [phoneview addSubview:phoneBottomview];
    
    phoneview.sd_layout
    .leftSpaceToView(contentview,0)
    .rightSpaceToView(contentview,0)
    .topSpaceToView(contentview,0)
    .heightIs(50);
    
    phoneImageview.sd_layout
    .leftSpaceToView(phoneview,10)
    .topSpaceToView(phoneview,12)
    .bottomSpaceToView(phoneview,12)
    .centerYEqualToView(phoneview)
    .widthIs(15);
    
    phoneTextfield.sd_layout
    .leftSpaceToView(phoneImageview,10)
    .rightSpaceToView(phoneview,0)
    .centerYEqualToView(phoneview)
    .topSpaceToView(phoneview,12)
    .bottomSpaceToView(phoneview,12);
    
    phoneBottomview.sd_layout
    .leftSpaceToView(phoneview,10)
    .rightSpaceToView(phoneview,10)
    .bottomSpaceToView(phoneview,0)
    .heightIs(1);
    
    
    
    UIView * codePictureview = [[UIView alloc]init];
    codePictureview.backgroundColor = [UIColor whiteColor];
    [contentview addSubview:codePictureview];
    
    
    
    UITextField *smsTextField = [[UITextField alloc]init];
    NSString * smsTextFieldStr = @"请输入图形验证码";
    smsTextField.delegate = self;
    _smsTextField = smsTextField;
    NSMutableAttributedString *placeStr4 = [[NSMutableAttributedString alloc]initWithString:smsTextFieldStr];
    [placeStr4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#999999"] range:NSMakeRange(0, smsTextFieldStr.length)];
    [placeStr4 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, smsTextFieldStr.length)];
    smsTextField.attributedPlaceholder = placeStr4;
    [codePictureview addSubview:smsTextField];
    
    
    UIButton * smsBtn = [[UIButton alloc]init];
    [smsBtn addTarget:self action:@selector(changCodePitureAction:) forControlEvents:UIControlEventTouchUpInside];
    [codePictureview addSubview:smsBtn];
    
    UIView * smsBottomview  =[[UIView alloc]init];
    smsBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e5e5e5"];
    [codePictureview addSubview:smsBottomview];
    
    
    
    codePictureview.sd_layout.leftSpaceToView(contentview, 0).rightSpaceToView(contentview, 0).topSpaceToView(phoneview, 0).heightIs(55);
    
    
    smsTextField.sd_layout.leftSpaceToView(codePictureview, 35).widthIs(SCW - 12-12-10-10-15-12-77.5)
        .centerYEqualToView(codePictureview)
        .topSpaceToView(codePictureview,12)
        .bottomSpaceToView(codePictureview,12);
    
    
    smsBtn.sd_layout.leftSpaceToView(smsTextField,0)
        .rightSpaceToView(codePictureview,10)
        .centerYEqualToView(codePictureview)
        .widthIs(77.5)
        .heightIs(30);
    _smsBtn = smsBtn;
    
    smsBottomview.sd_layout.leftSpaceToView(codePictureview, 10).rightSpaceToView(codePictureview, 10).bottomSpaceToView(codePictureview, 0).heightIs(1);
    
    
    
    UIView * codeview = [[UIView alloc]init];
    codeview.backgroundColor = [UIColor whiteColor];
    [contentview addSubview:codeview];
    
    
    UIImageView *codeImageview = [[UIImageView alloc]init];
    codeImageview.image = [UIImage imageNamed:@"验证码_y-(1)-1"];
    [codeview addSubview:codeImageview];
    
    
    UITextField *codeTextfield = [[UITextField alloc]init];
    codeTextfield.borderStyle = UITextBorderStyleNone;
    NSString *codeStr = @"请输入验证码";
    _codeTextfield = codeTextfield;
    _codeTextfield.keyboardType = UIKeyboardTypeNumberPad;
    NSMutableAttributedString *placeStr1 = [[NSMutableAttributedString alloc]initWithString:codeStr];
    [placeStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#999999"] range:NSMakeRange(0, codeStr.length)];
    [placeStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, codeStr.length)];
    codeTextfield.attributedPlaceholder = placeStr1;
    [codeview addSubview:codeTextfield];
    
    UIButton * sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendCodeBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#37a0e8"].CGColor;
    _sendCodeBtn = sendCodeBtn;
    [sendCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendCodeBtn.layer.cornerRadius = 5;
    sendCodeBtn.layer.masksToBounds = YES;
    [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [sendCodeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#37a0e8"]];
    sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [sendCodeBtn addTarget:self action:@selector(sendCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [codeview addSubview:sendCodeBtn];
    
    
    
    
    UIView * codeBottomview  =[[UIView alloc]init];
    codeBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e5e5e5"];
    [codeview addSubview:codeBottomview];
    
    codeview.sd_layout
    .leftSpaceToView(contentview,0)
    .rightSpaceToView(contentview,0)
    .topSpaceToView(codePictureview,0)
    .heightIs(50);
    
    codeImageview.sd_layout
    .leftSpaceToView(codeview,10)
    .topSpaceToView(codeview,15)
    .bottomSpaceToView(codeview,15)
    .centerYEqualToView(codeview)
    .widthIs(15);
    
    codeTextfield.sd_layout
    .leftSpaceToView(codeImageview,10)
    .widthIs(SCW - 12-12-10-10-15-12-77.5)
    .centerYEqualToView(codeview)
    .topSpaceToView(codeview,12)
    .bottomSpaceToView(codeview,12);
    
    
    sendCodeBtn.sd_layout
    .leftSpaceToView(codeTextfield,0)
    .rightSpaceToView(codeview,10)
    .centerYEqualToView(codeview)
    .widthIs(77.5)
    .heightIs(30);
    
    codeBottomview.sd_layout
    .leftSpaceToView(codeview,10)
    .rightSpaceToView(codeview,10)
    .bottomSpaceToView(codeview,0)
    .heightIs(1);
    
    UIView *newPasswordview = [[UIView alloc]init];
    newPasswordview.backgroundColor = [UIColor whiteColor];
    [contentview addSubview:newPasswordview];
    
    UIImageView *newPasswordImageview = [[UIImageView alloc]init];
    newPasswordImageview.image = [UIImage imageNamed:@"验证码_y-(1)"];
    [newPasswordview addSubview:newPasswordImageview];
    
    UITextField * newPasswordTextfield = [[UITextField alloc]init];
    NSString *newPasswordStr = @"请输入6-18位新密码";
    newPasswordTextfield.delegate = self;
    _newPasswordTextfield = newPasswordTextfield;
//    _newPasswordTextfield.keyboardType = UIKeyboardTypeNumberPad;
    newPasswordTextfield.secureTextEntry = YES;
    NSMutableAttributedString *placeStr2 = [[NSMutableAttributedString alloc]initWithString:newPasswordStr];
    [placeStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#999999"] range:NSMakeRange(0, newPasswordStr.length)];
    [placeStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, newPasswordStr.length)];
    newPasswordTextfield.attributedPlaceholder = placeStr2;
    [newPasswordview addSubview:newPasswordTextfield];

    UIView *newPasswordBottomview = [[UIView alloc]init];
    newPasswordBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e5e5e5"];
    [newPasswordview addSubview:newPasswordBottomview];
    
    newPasswordview.sd_layout
    .leftSpaceToView(contentview,0)
    .rightSpaceToView(contentview,0)
    .topSpaceToView(codeview,0)
    .heightIs(50);
    
    newPasswordImageview.sd_layout
    .leftSpaceToView(newPasswordview,10)
    .topSpaceToView(newPasswordview,15)
    .bottomSpaceToView(newPasswordview,15)
    .centerYEqualToView(newPasswordview)
    .widthIs(15);
    
    newPasswordTextfield.sd_layout
    .leftSpaceToView(newPasswordImageview,10)
    .rightSpaceToView(newPasswordview,0)
    .centerYEqualToView(newPasswordview)
    .topSpaceToView(newPasswordview,12)
    .bottomSpaceToView(newPasswordview,12);
    
    newPasswordBottomview.sd_layout
    .leftSpaceToView(newPasswordview,10)
    .rightSpaceToView(newPasswordview,10)
    .bottomSpaceToView(newPasswordview,0)
    .heightIs(1);
    
    
    UIView *againPasswordview = [[UIView alloc]init];
    againPasswordview.backgroundColor = [UIColor whiteColor];
    [contentview addSubview:againPasswordview];
    
    
    
    UITextField *againPasswordTextfield = [[UITextField alloc]init];
    NSString *againPasswordStr = @"再次确认新密码";
    againPasswordTextfield.delegate = self;
    againPasswordTextfield.secureTextEntry = YES;
    _againPasswordTextfield = againPasswordTextfield;
//    _againPasswordTextfield.keyboardType = UIKeyboardTypeNumberPad;
    NSMutableAttributedString *placeStr3 = [[NSMutableAttributedString alloc]initWithString:againPasswordStr];
    [placeStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#999999"] range:NSMakeRange(0, againPasswordStr.length)];
    [placeStr3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, againPasswordStr.length)];
    againPasswordTextfield.attributedPlaceholder = placeStr3;
    [againPasswordview addSubview:againPasswordTextfield];
    
//    UIView *againPasswordBottomview = [[UIView alloc]init];
//    againPasswordBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e5e5e5"];
//    [againPasswordview addSubview:againPasswordBottomview];
    
    
    againPasswordview.sd_layout
    .topSpaceToView(newPasswordview,0)
    .leftSpaceToView(contentview,0)
    .rightSpaceToView(contentview,0)
    .bottomSpaceToView(contentview,0);
    
    againPasswordTextfield.sd_layout
    .leftSpaceToView(againPasswordview,35)
    .rightSpaceToView(againPasswordview,0)
    .centerYEqualToView(againPasswordview)
    .topSpaceToView(againPasswordview,12)
    .bottomSpaceToView(againPasswordview,12);
    
//    againPasswordBottomview.sd_layout
//    .leftSpaceToView(againPasswordview,0)
//    .rightSpaceToView(againPasswordview,0)
//    .bottomSpaceToView(againPasswordview,0)
//    .heightIs(Height_Real(1));
    
    
    [_smsBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?key=%@",URL_GET_TEXT_SMS_VERIFY_CODE_IOS,self.uuid]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"背景"]];
    
    
    
    
    UIButton * sureRevampBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    sureRevampBtn.layer.cornerRadius = 5;
    sureRevampBtn.layer.masksToBounds = YES;
    [sureRevampBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [sureRevampBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    _sureRevampBtn = sureRevampBtn;
    [sureRevampBtn setTintColor:[UIColor whiteColor]];
    sureRevampBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureRevampBtn addTarget:self action:@selector(sureRevampAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureRevampBtn];
    
    
    sureRevampBtn.sd_layout
    .topSpaceToView(contentview,40)
    .heightIs(45)
    .centerXEqualToView(self.view)
    .leftSpaceToView(self.view,12)
    .rightSpaceToView(self.view,12);
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



#pragma mark -- 确认修改
- (void)sureRevampAction:(UIButton *)btn{
    
    
    if(![self isTrueMobile:_phoneTextfield.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    if([self istext:_codeTextfield])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
        return;
    }
    if(![self validatePassword:_newPasswordTextfield.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请设置登录密码"];
        return;
    }
    if (_newPasswordTextfield.text.length<6)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
    if (_newPasswordTextfield.text.length>18)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
    if(![self validatePassword:_againPasswordTextfield.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请设置登录密码"];
        return;
    }
    if (_againPasswordTextfield.text.length<6)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
    if (_againPasswordTextfield.text.length>18)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
//    if(![self isValidPassword:_againPasswordTextfield.text])
//    {
//        [SVProgressHUD showErrorWithStatus:@"密码包含无效字符"];
//        return;
//    }
    if(![_newPasswordTextfield.text isEqualToString:_againPasswordTextfield.text])
    {
        [SVProgressHUD showErrorWithStatus:@"密码不一致"];
        return;
    }
    [self.view endEditing:YES];
    
    //忘记密码登录请求
    [self initForgetPassword];
}



#pragma mark -- 忘记密码请求
- (void)initForgetPassword{
    
    [SVProgressHUD showWithStatus:@"正在查找密码"];
    //忘记密码请求
    //URL_FIND_BACK_PASSWORD
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:_phoneTextfield.text forKey:@"mobilePhone"];
    [dict setObject:_codeTextfield.text forKey:@"phoneCode"];
    [dict setObject:[MyMD5 md5:_newPasswordTextfield.text] forKey:@"userPassword"];
    
    BOOL isSecondPassword =  false;
    
    [dict setObject:[NSNumber numberWithBool:isSecondPassword] forKey:@"type"];
    
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_CHANGE_PASSWORD_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                
                [SVProgressHUD showSuccessWithStatus:@"找回密码成功"];
                //明天要测试下
//                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//                [user setObject:[MyMD5 md5:_newPasswordTextfield.text] forKey:@"PWD"];
//                [user synchronize];
                
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"找回密码失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"找回密码失败"];
        }
    }];
}



#pragma mark -- 发送验证码
//- (void)sendCodeAction:(UIButton *)btn{
//
//    //增加定时器
//    [self addSendCodeTimer];
//
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//   // [dict setObject:_phoneTextfield.text forKey:@"MOBILEPHONE"];
//    [dict setObject:_phoneTextfield.text forKey:@"mobilePhone"];
//    //二进制数
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//     //URL_GET_TEXT_VERIFY_UNLOGIN_IOS URL_GET_TEXT_VERIFY_UNLOGIN
//
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_GET_TEXT_VERIFY_UNLOGIN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//                [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
//            }
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"发送验证码失败"];
//        }
//    }];
//}

-(void)sendCodeAction:(UIButton *)btn{
    if ([self isTrueMobile:_phoneTextfield.text]) {
        
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
       // [dict setObject:_phoneTextfield.text forKey:@"MOBILEPHONE"];
        [dict setObject:_phoneTextfield.text forKey:@"mobilePhone"];
        [dict setObject:self.uuid forKey:@"key"];
        [dict setObject:_smsTextField.text forKey:@"value"];
        //二进制数
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
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
                        [self reloadPictureCode:_smsBtn];
                        _smsBtn.userInteractionEnabled = YES;
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


//#pragma mark -- 添加定时器
//- (void)addSendCodeTimer{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(ClickSendCodeTime) userInfo:nil repeats:YES];
//
//    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
//}
//
//#pragma mark-- 发送验证码的时间
//- (void)ClickSendCodeTime{
//    self.count--;
//    [_sendCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)self.count] forState:UIControlStateNormal];
//    _sendCodeBtn.enabled = NO;
//    [_sendCodeBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
//    if (self.count <= 0) {
//        [self removeClickSendCodeDate];
//        _sendCodeBtn.enabled = YES;
//        [_sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
//        [_sendCodeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#37a0e8"]];
//        self.count = 60;
//
//    }
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textfield{
    [textfield resignFirstResponder];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _smsTextField){
        NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        textField.text = temp;
    }
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

//
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [self removeClickSendCodeDate];
//}
//#pragma mark -- 移除定时器
//- (void)removeClickSendCodeDate{
//    [self.timer invalidate];
//    self.timer = nil;
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
