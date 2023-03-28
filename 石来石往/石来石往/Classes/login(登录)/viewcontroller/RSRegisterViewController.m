//
//  RSRegisterViewController.m
//  石来石往
//
//  Created by mac on 17/5/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSRegisterViewController.h"
#import "RSNextRegisterViewController.h"
#import "NSString+RSExtend.h"
#import "Utility.h"
#import "RSUserInformationViewController.h"

@interface RSRegisterViewController ()<UITextFieldDelegate>
{
    UIView *_navigationview;
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

@implementation RSRegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //定时器之后60秒
//    self.count = 60;
    self.uuid = [NSString get_uuid];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    
    self.title = @"注册";
    self.automaticallyAdjustsScrollViewInsets = NO;
    //自定义内容视图
    [self addCustonContentView];
    
    
}






- (void)addCustonContentView{
    UIView * contentview = [[UIView alloc]init];
    contentview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self.view addSubview:contentview];
    
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
    [phoneTextfield addTarget:self action:@selector(phoneNumeberIsSure:) forControlEvents:UIControlEventEditingChanged];
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
    .widthIs(200)
    .topSpaceToView(phoneview,11)
    .bottomSpaceToView(phoneview,0);
    
    
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
    
    
    smsBottomview.sd_layout.leftSpaceToView(codePictureview, 12).rightSpaceToView(codePictureview, 12).bottomSpaceToView(codePictureview, 0).heightIs(1);
    
    
    
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
    [codeBtn  addTarget:self action:@selector(initSendCode:) forControlEvents:UIControlEventTouchUpInside];
    codeBtn.layer.cornerRadius = 5;
    codeBtn.layer.masksToBounds = YES;
    
    [Codeview addSubview:codeBtn];
    //colorWithHexColorStr:@"#1c98e6"
    
    codeTextfield.sd_layout
    .leftSpaceToView(Codeview,0)
    .widthRatioToView(Codeview,0.6)
    .topSpaceToView(Codeview,11)
    .bottomSpaceToView(Codeview,0);
    
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
    
    [_smsBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?key=%@",URL_GET_TEXT_SMS_VERIFY_CODE_IOS,self.uuid]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"背景"]];
   
    
    
    
    UIButton * nextBtn = [[UIButton alloc]init];
    [nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
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
    .leftSpaceToView(self.view, 12)
    .rightSpaceToView(self.view, 12)
    .heightIs(44);
    
    
    
   
    
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"注册即代表阅读并同意";
    
    CGRect disCountrect = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    label.frame = CGRectMake(Width_Real(24), CGRectGetMaxY(nextBtn.frame), disCountrect.size.width, Height_Real(20));
    [self.view addSubview:label];
    
    label.sd_layout.leftEqualToView(nextBtn).widthIs(disCountrect.size.width).topSpaceToView(nextBtn, 5).heightIs(20);
    
    
    
   
    
    
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
    userProtocolBtn.sd_layout.leftSpaceToView(label, 0).topEqualToView(label).widthIs(userProtocol.size.width).heightIs(20);
    
    
    UILabel * andLabel = [[UILabel alloc]init];
    andLabel.text = @"和";
    andLabel.textAlignment = NSTextAlignmentCenter;
    andLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    
    CGRect andLabelRect = [andLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    
    andLabel.font = [UIFont systemFontOfSize:14];
//    andLabel.frame = CGRectMake(CGRectGetMaxX(userProtocolBtn.frame), CGRectGetMaxY(nextBtn.frame), andLabelRect.size.width, Height_Real(20));
    [self.view addSubview:andLabel];
    
    andLabel.sd_layout.leftSpaceToView(userProtocolBtn, 0).topEqualToView(userProtocolBtn).widthIs(andLabelRect.size.width).heightIs(20);
    
    
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
    userPrivacyBtn.sd_layout.leftSpaceToView(andLabel, 0).topEqualToView(andLabel).widthIs(userPrivacy.size.width).heightIs(20);
}



- (void)changCodePitureAction:(UIButton *)smsBtn{
    [self reloadPictureCode:smsBtn];
}


- (void)reloadPictureCode:(UIButton *)smsBtn{
    _smsTextField.text = @"";
    self.uuid = [NSString get_uuid];
    [_smsBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?key=%@",URL_GET_TEXT_SMS_VERIFY_CODE_IOS,self.uuid]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"背景"]];
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



#pragma mark -- 下一步
- (void)nextView:(UIButton *)btn{
    
    
    [_phoneTextfield resignFirstResponder];
    [_codeTextfield resignFirstResponder];
    //这里要对手机号的输入和验证码的输入进行判读是否都是正确的
    
    if(![self isTrueMobile:_phoneTextfield.text] && _codeTextfield.text.length < 6)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }else{
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//        //手机号
//        [phoneDict setObject:_phoneTextfield.text forKey:@"ERPCODE"];
//        //验证码
//        [phoneDict setObject:_codeTextfield.text forKey:@"KEY"];
        
        
        
        //手机号
        [phoneDict setObject:_phoneTextfield.text forKey:@"mobilePhone"];
        //验证码
        [phoneDict setObject:_codeTextfield.text forKey:@"phoneCode"];
        
        //二进制数
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        
        
        //URL_VERIFY_TEXT_VERIFY_UNLOGIN_IOS URL_VERIFY_TEXT_VERIFY_UNLOGIN
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_VERIFY_TEXT_VERIFY_UNLOGIN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                //[SVProgressHUD showSuccessWithStatus:@"检测验证码正确"];
               
                
                BOOL Result = [json[@"Result"] boolValue];
                
                if (Result) {
                    //移除定时器
//                    [self removeTimer];
                    
                    [SVProgressHUD showSuccessWithStatus:@"验证码正确"];
                    RSNextRegisterViewController *nextRegisterVc = [[RSNextRegisterViewController alloc]init];
                    
                    nextRegisterVc.phoneLabel = _phoneTextfield.text;
                    [self.navigationController pushViewController:nextRegisterVc animated:YES];
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:@"输入的验证码失败"];
                }
                
                
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"检测验证码失败"];
            }
        }];
        
    }
}




#pragma mark -- 验证码的内容
- (void)createSure:(UITextField *)textfield{
   
    
    if(textfield.text.length == 6)
    {
        _nextBtn.enabled = YES;
        
        [_nextBtn setBackgroundColor:[UIColor  colorWithHexColorStr:@"#3385ff"]];
    }
}

#pragma mark -- 发送验证码
//- (void)initSendCode{
//
//
//    //URL_GET_TEXT_VERIFY_UNLOGIN_IOS
//    //增加定时器
//    [self addSendCodeTimer];
//
//    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//    //[phoneDict setObject:_phoneTextfield.text forKey:@"MOBILEPHONE"];
//     [phoneDict setObject:_phoneTextfield.text forKey:@"mobilePhone"];
//    //二进制数
//    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    //URL_GET_TEXT_VERIFY_UNLOGIN
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//
//    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_GET_TEXT_VERIFY_UNLOGIN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//
//
//        if (success) {
//
//            BOOL Result = [json[@"Result"] boolValue] ;
//            if (Result) {
//
//                [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
//            }
//
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"发送验证码失败"];
//
//
//        }
//    }];
//}


-(void)initSendCode:(UIButton *)btn{
    if ([self isTrueMobile:_phoneTextfield.text]) {
        
        
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        //[phoneDict setObject:_phoneTextfield.text forKey:@"MOBILEPHONE"];
         [phoneDict setObject:_phoneTextfield.text forKey:@"mobilePhone"];
        
        
        [phoneDict setObject:self.uuid forKey:@"key"];
        [phoneDict setObject:_smsTextField.text forKey:@"value"];
        
        //二进制数
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //URL_GET_TEXT_VERIFY_UNLOGIN
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
        //URL_GET_TEXT_VERIFY_UNLOGIN_IOS
        [network getDataWithUrlString:URL_GET_TEXT_SMS_VERIFY_SEND_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue] ;
                if (Result) {
                    //[SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
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




#pragma mark --- 监测textfield是不是满足电话号码的正则
- (void)phoneNumeberIsSure:(UITextField *)textfield{
   
    //这边要对手机号进行服务器上面的检测
   
    if (textfield.text.length == 11) {
        
        
        if (![self isTrueMobile:textfield.text]) {
            
            
            [SVProgressHUD showInfoWithStatus:@"输入手机号码不对"];
            return;
            
        }else{
            [SVProgressHUD showWithStatus:@"正在验证手机号"];
            
            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
            [phoneDict setObject:_phoneTextfield.text forKey:@"mobilePhone"];
            //二进制数
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            
            
            //URL_VERIFY_MOBILEPHONE_IOS URL_CHECK_MOBIL_PHONE
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_VERIFY_MOBILEPHONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                
                if (success) {
                    BOOL isResult = [json[@"Result"] boolValue];
                    if (isResult) {
                        [SVProgressHUD dismiss];
                        
                        _phoneChangeLabel.text = @"该手机号可以注册";
                        _phoneChangeLabel.textColor = [UIColor greenColor];
                        _phoneChangeLabel.hidden = NO;
                        [_codeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
                        _codeBtn.enabled = YES;
                    }else{
                        [SVProgressHUD dismiss];
                        _phoneChangeLabel.text = @"该手机号已经注册";
                        _phoneChangeLabel.textColor = [UIColor redColor];
                        _phoneChangeLabel.hidden = NO;
                        [_codeBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
                        _codeBtn.enabled = NO;
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"手机号验证失败"];
                }
            }];
        }
    }else{
        _phoneChangeLabel.hidden = YES;
        [_codeBtn setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]];
        _codeBtn.enabled = NO;
    }
}

//#pragma mark -- 增加定时器
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
//        self.count = 60;
//        [_codeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
//        [self removeTimer];
//    }
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    //移除定时器
//    [self removeTimer];
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
