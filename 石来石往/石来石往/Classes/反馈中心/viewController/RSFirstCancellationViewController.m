//
//  RSFirstCancellationViewController.m
//  石来石往
//
//  Created by mac on 2022/9/16.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSFirstCancellationViewController.h"
#import "RSSecondCancellationViewController.h"

@interface RSFirstCancellationViewController ()<UITextFieldDelegate>


@property (nonatomic,strong) UITextField *smsTextField;

@property (nonatomic,strong)UIButton * smsBtn;

@property (nonatomic,strong)UITextField * codeTextfield;

@property (nonatomic,strong) UIButton * codeBtn ;

@property (nonatomic,copy)NSString * uuid;

@property (nonatomic,copy)UIButton * nextBtn;

@end

@implementation RSFirstCancellationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份验证";
    
    self.uuid = [NSString get_uuid];
    
    UILabel * titleAlertLabel = [[UILabel alloc]init];
    titleAlertLabel.text = @"为确保是你本人操作，请完成以下验证";
    titleAlertLabel.textAlignment = NSTextAlignmentCenter;
    titleAlertLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    titleAlertLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:titleAlertLabel];
    
    titleAlertLabel.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 30).heightIs(20);
    
    UILabel * alertLabel = [[UILabel alloc]init];
    alertLabel.text = @"点击获取验证码会发送短信你的手机号";
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    alertLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:alertLabel];
    
    alertLabel.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(titleAlertLabel, 10).heightIs(40);
    
    UILabel * phoneLabel = [[UILabel alloc]init];
    NSString * phone = [UserManger getUserObject].userPhone;
    NSString * newPhone = [phone stringByReplacingCharactersInRange:NSMakeRange(4, 5) withString:@"*****"];
    phoneLabel.text = newPhone;
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.font = [UIFont systemFontOfSize:15];
    phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [self.view addSubview:phoneLabel];
    
    phoneLabel.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(alertLabel, 10).heightIs(40);
    
    UIView * codePictureview = [[UIView alloc]init];
    codePictureview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:codePictureview];
    
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
    
    codePictureview.sd_layout.leftSpaceToView(self.view, 12).rightSpaceToView(self.view, 12).topSpaceToView(phoneLabel, 10).heightIs(55);

    
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
    Codeview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:Codeview];
    
    Codeview.sd_layout
    .leftSpaceToView(self.view,12)
    .rightSpaceToView(self.view,12)
    .topSpaceToView(codePictureview,0)
    .heightIs(55);
    
    UITextField * codeTextfield = [[UITextField alloc]init];
    _codeTextfield = codeTextfield;
    NSString *str1  = @"请输入验证码";
    codeTextfield.keyboardType = UIKeyboardTypeNumberPad;
    NSMutableAttributedString * placeholderstr1 = [[NSMutableAttributedString alloc]initWithString:str1];
    [placeholderstr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#999999"] range:NSMakeRange(0, str1.length)];
    [placeholderstr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, str1.length)];
    
    codeTextfield.attributedPlaceholder = placeholderstr1;
    codeTextfield.borderStyle = UITextBorderStyleNone;
    [codeTextfield addTarget:self action:@selector(createSure:) forControlEvents:UIControlEventEditingChanged];
    [Codeview addSubview:codeTextfield];
    codeTextfield.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UIButton * codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeBtn setTitle:@"获得验证码" forState:UIControlStateNormal];
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _codeBtn = codeBtn;
    [codeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [codeBtn addTarget:self action:@selector(initSendCode:) forControlEvents:UIControlEventTouchUpInside];
    codeBtn.layer.cornerRadius = 5;
    codeBtn.layer.masksToBounds = YES;
    [Codeview addSubview:codeBtn];
    
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
    [nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#c0c0c0"]];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.layer.masksToBounds =  YES;
    _nextBtn = nextBtn;
    [nextBtn addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    nextBtn.sd_layout
    .topSpaceToView(Codeview,20)
    .centerXEqualToView(self.view)
    .leftSpaceToView(self.view, 12)
    .rightSpaceToView(self.view, 12)
    .heightIs(44);
    
}

-(void)initSendCode:(UIButton *)btn{
    if ([self isTrueMobile:[UserManger getUserObject].userPhone]) {
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
         [phoneDict setObject:[UserManger getUserObject].userPhone forKey:@"mobilePhone"];
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

- (void)changCodePitureAction:(UIButton *)smsBtn{
    [self reloadPictureCode:smsBtn];
}


- (void)reloadPictureCode:(UIButton *)smsBtn{
    _smsTextField.text = @"";
    self.uuid = [NSString get_uuid];
    [_smsBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?key=%@",URL_GET_TEXT_SMS_VERIFY_CODE_IOS,self.uuid]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"背景"]];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _smsTextField){
        NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        textField.text = temp;
    }
}


- (void)createSure:(UITextField *)textfield{
    if(textfield.text.length >= 6)
    {
        _nextBtn.enabled = YES;
        [_nextBtn setBackgroundColor:[UIColor  colorWithHexColorStr:@"#3385ff"]];
    }else{
        _nextBtn.enabled = NO;
        [_nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#c0c0c0"]];
    }
}


//下一页
- (void)nextView:(UIButton *)nextBtn{
    
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    //验证码
    [phoneDict setObject:_codeTextfield.text forKey:@"smsCode"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself;
    NSLog(@"=======================%@",parameters);
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_CANCELLATION_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success){
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                RSSecondCancellationViewController * secondVc = [[RSSecondCancellationViewController alloc]init];
                [weakSelf.navigationController pushViewController:secondVc animated:true];
            }else{
                [SVProgressHUD showErrorWithStatus:@"验证失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"验证失败"];
        }
    }];
}


@end
