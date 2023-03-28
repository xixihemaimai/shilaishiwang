//
//  RSPersonalPackageViewController.m
//  石来石往
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSPersonalPackageViewController.h"

#import "SpecialAlertView.h"

@interface RSPersonalPackageViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    UITextField * _phoneTextfield;
    
    
    UITextField * _companyTextfield;
    
}

@property (nonatomic,strong)UITableView * tableview;
//@property (nonatomic,strong)UIButton * currentBtn;
@end

@implementation RSPersonalPackageViewController

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
    }
    return _tableview;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableview];
    
    UIView * headerview = [[UIView alloc]init];
    headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UIImageView * headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCW, 200)];
    headerImageView.userInteractionEnabled = YES;
    headerImageView.image = [UIImage imageNamed:@"头部背景"];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.clipsToBounds = YES;
    [headerview addSubview:headerImageView];
    
    
    //返回
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"上一页"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 11, 6, 11);
    [backBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#000000" alpha:0.5]];
    backBtn.frame = CGRectMake(12, 40, 32, 32);
    backBtn.layer.cornerRadius = backBtn.yj_width * 0.5;
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:backBtn];
    
    
    
//    UIButton * packageFirstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [packageFirstBtn setImage:[UIImage imageNamed:@"包月小"] forState:UIControlStateNormal];
//    packageFirstBtn.frame = CGRectMake(SCW/2 - 14 - 125, 242, 125, 97);
//    [headerview addSubview:packageFirstBtn];
//    [packageFirstBtn addTarget:self action:@selector(changesStatusAction:) forControlEvents:UIControlEventTouchUpInside];
//    packageFirstBtn.layer.borderWidth = 1;
//    packageFirstBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#F71454"].CGColor;
   
    
    
//    UIButton * packageSecondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [packageSecondBtn setImage:[UIImage imageNamed:@"包年"] forState:UIControlStateNormal];
//    packageSecondBtn.frame = CGRectMake(SCW/2 + 14, 242, 125, 97);
//    [headerview addSubview:packageSecondBtn];
//    [packageSecondBtn addTarget:self action:@selector(changesStatusAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerImageView.frame), SCW, 803)];
    contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFD205"];
    [headerview addSubview:contentView];
    

    //这边有
    UITextField * phoneTextfield = [[UITextField alloc]initWithFrame:CGRectMake(SCW/2 - 145, 23, 290, 40)];
    phoneTextfield.backgroundColor = [UIColor colorWithHexColorStr:@"#F19526"];
    phoneTextfield.layer.cornerRadius = 17;
    phoneTextfield.placeholder = @"请输入电话号码";
    phoneTextfield.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    phoneTextfield.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:phoneTextfield];
    phoneTextfield.keyboardType = UIKeyboardTypeDefault;
    
    phoneTextfield.returnKeyType = UIReturnKeyDone;
    _phoneTextfield = phoneTextfield;
    _phoneTextfield.delegate = self;
    //[phoneTextfield addTarget:self action:@selector(inputPhoneTextField:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    //公司名称
    UITextField * companyTextfield = [[UITextField alloc]initWithFrame:CGRectMake(SCW/2 - 145, CGRectGetMaxY(phoneTextfield.frame) + 10, 290, 40)];
    companyTextfield.backgroundColor = [UIColor colorWithHexColorStr:@"#F19526"];
    companyTextfield.layer.cornerRadius = 17;
    companyTextfield.placeholder = @"请输入公司名称";
    companyTextfield.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    companyTextfield.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:companyTextfield];
    companyTextfield.keyboardType = UIKeyboardTypeDefault;
    
    companyTextfield.returnKeyType = UIReturnKeyDone;
    _companyTextfield = companyTextfield;
    companyTextfield.delegate = self;
    //[companyTextfield addTarget:self action:@selector(inputCompanyTextField:) forControlEvents:UIControlEventEditingChanged];
    if ([self.ModifyStr isEqualToString:@"new"]) {
//        self.currentBtn.selected = !self.currentBtn.selected;
//        packageFirstBtn.selected = !packageFirstBtn.selected;
//        self.currentBtn = packageFirstBtn;
    }else{
        if ([self.applylistmodel.signingMode isEqualToString:@"month"]) {
//            self.currentBtn.selected = !self.currentBtn.selected;
//            packageFirstBtn.selected = !packageFirstBtn.selected;
//            self.currentBtn = packageFirstBtn;
        }else{
//            self.currentBtn.selected = !self.currentBtn.selected;
//            packageSecondBtn.selected = !packageSecondBtn.selected;
//            self.currentBtn = packageSecondBtn;
            _phoneTextfield.text = self.applylistmodel.contactPhone;
            _companyTextfield.text = self.applylistmodel.companyName;
        }
    }
    
    //申请开通
    UIButton * applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 1"] forState:UIControlStateNormal];
    applyBtn.frame = CGRectMake(SCW/2 - 145, CGRectGetMaxY(companyTextfield.frame) + 10, 290, 40);
    [applyBtn setTitle:@"申请开通,尽享权益" forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    applyBtn.layer.cornerRadius = 17;
    [applyBtn addTarget:self action:@selector(applyPersonalAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:applyBtn];
    
    //第一张图片
    UIImageView * firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 - 145, CGRectGetMaxY(applyBtn.frame) + 27, 290, 515)];
    firstImageView.image = [UIImage imageNamed:@"权益"];
    firstImageView.clipsToBounds = YES;
    [contentView addSubview:firstImageView];
    if (iphonex) {
        //firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    }else if (iPhoneXS){
        //firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    }else if (iPhoneXR){
        //firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    }else if (iPhoneXSMax){
        //firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        //firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    //第二种图片
    UIImageView * secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 - 145, CGRectGetMaxY(firstImageView.frame) + 21, 290, 53)];
    secondImageView.image = [UIImage imageNamed:@"联系客服"];
    secondImageView.contentMode = UIViewContentModeScaleAspectFill;
    secondImageView.clipsToBounds = YES;
    [contentView addSubview:secondImageView];
    
    [headerview setupAutoHeightWithBottomView:contentView bottomMargin:0];
    [headerview layoutIfNeeded];
    self.tableview.tableHeaderView = headerview;
    
}


//输入电话号码
//- (void)inputPhoneTextField:(UITextField *)phoneTextField{
//
//}
//
//- (void)inputCompanyTextField:(UITextField *)companyTextField{
//
//}




- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _phoneTextfield) {
        NSString * temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        temp = [self delSpaceAndNewline:temp];
        if ([temp length] > 0) {
            _phoneTextfield.text = temp;
        }else{
            _phoneTextfield.text = @"";
        }
        
    }else{
        
        NSString * temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        temp = [self delSpaceAndNewline:temp];
        if ([temp length] > 0) {
            _companyTextfield.text = temp;
        }else{
            _companyTextfield.text = @"";
        }
    }
    
}





//申请开通
- (void)applyPersonalAction:(UIButton *)applyBtn{
    //URL_APPLYPERSONAL_IOS
    [_phoneTextfield resignFirstResponder];
    [_companyTextfield resignFirstResponder];
    if (![self isTrueMobile:_phoneTextfield.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号错误"];
        return;
    }
    if ([_companyTextfield.text length] < 1) {
        [SVProgressHUD showErrorWithStatus:@"公司没有添写错误"];
        return;
    }
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSString * user_code = [user objectForKey:@"USER_CODE"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSString * str = [NSString string];
    if ([self.ModifyStr isEqualToString:@"new"]) {
        str = URL_APPLYPERSONAL_IOS;
        
        //[phoneDict setObject:_phoneTextfield.text forKey:@"contactPhone"];
        //[phoneDict setObject:_companyTextfield.text forKey:@"companyName"];
        //if (self.currentBtn.currentImage == [UIImage imageNamed:@"包月小"]) {
        //   [phoneDict setObject:@"month" forKey:@"signingMode"];
        //}else{
        //[phoneDict setObject:@"year" forKey:@"signingMode"];
        //}
    }else{
        
      //  企业名    companyName    String    企业名/个人版名义
      //  联系人电话    contactPhone    String    联系人电话
      //  签约付费方式    signingMode    String    month 包月  year 包年
      //  申请用户的ID    pwmsUserId    Int    申请列表里面模型的ID
      //  是否取消申请    cancel    Bool    取消申请填 true
        str = URL_UPDATEAPPLYA_IOS;
        [phoneDict setObject:[NSNumber numberWithInteger:self.applylistmodel.applyID] forKey:@"pwmsUserId"];
        [phoneDict setObject:[NSNumber numberWithBool:false] forKey:@"cancel"];
    }
    [phoneDict setObject:_phoneTextfield.text forKey:@"contactPhone"];
    [phoneDict setObject:_companyTextfield.text forKey:@"companyName"];
   // if (self.currentBtn.currentImage == [UIImage imageNamed:@"包月小"]) {
     //  [phoneDict setObject:@"month" forKey:@"signingMode"];
    //}else{
       [phoneDict setObject:@"year" forKey:@"signingMode"];
    //}
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:str withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isreust = [json[@"success"]boolValue];
            if (isreust) {
                if ([weakSelf.ModifyStr isEqualToString:@"new"]) {
                    SpecialAlertView *special = [[SpecialAlertView alloc]initWithTitleImage:@"完成申请" messageTitle:@"完成申请" messageString:@"    我们的工作人员会尽快与你联系                     客服电话：400-0046-056" sureBtnTitle:@"确定" sureBtnColor:[UIColor colorWithHexColorStr:@"#FEC519"] andTag:0];
                    [special withSureClick:^(NSString *string) {
                        // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(personalEditionIsAgreen) name:@"PersonalEdition" object:nil];
                        //这边要重新获取用户信息
                        [RSInitUserInfoTool registermodelUSER_CODE:user_code andVERIFYKEY:verifykey andViewController:weakSelf andObtain:^(BOOL isValue) {
                            if (isValue) {
//                                [[NSNotificationCenter defaultCenter] postNotificationName:@"retrievingUserInformation" object:nil];
                                [[NSNotificationCenter defaultCenter]postNotificationName:@"PersonalEdition" object:nil];
                                weakSelf.tabBarController.selectedIndex = 2;
                            }
                        }];
                    }];
                }else{
                    SpecialAlertView *special = [[SpecialAlertView alloc]initWithTitleImage:@"完成修改" messageTitle:@"完成修改" messageString:@"    我们的工作人员会尽快与你联系                     客服电话：400-0046-056" sureBtnTitle:@"确定" sureBtnColor:[UIColor colorWithHexColorStr:@"#FEC519"] andTag:0];
                    [special withSureClick:^(NSString *string) {
                        if (weakSelf.reload) {
                            weakSelf.reload(true);
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }
            }else{
                if ([weakSelf.ModifyStr isEqualToString:@"new"]) {
                    [SVProgressHUD showErrorWithStatus:@"申请失败"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"修改失败"];
                }
            }
        }else{
            if ([weakSelf.ModifyStr isEqualToString:@"new"]) {
                [SVProgressHUD showErrorWithStatus:@"申请失败"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
        }
    }];
}

- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

//返回
- (void)backAction:(UIButton *)backBtn{
  [self.navigationController popViewControllerAnimated:YES];
}


//切换状态
//- (void)changesStatusAction:(UIButton *)changBtn{
//
//    changBtn.layer.borderWidth = 1;
//    changBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#F71454"].CGColor;
//
//    if (!changBtn.isSelected) {
//        self.currentBtn.selected = !self.currentBtn.selected;
//
//        self.currentBtn.layer.borderWidth = 0;
//        self.currentBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#A7D0FF"].CGColor;
//        changBtn.selected = !changBtn.selected;
//        self.currentBtn = changBtn;
//    }
//}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PERSONALPACKAGE = @"PERSONALPACKAGE";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSONALPACKAGE];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PERSONALPACKAGE];
    }
    return cell;
}

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

@end
