//
//  RSAddDriverViewController.m
//  石来石往
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAddDriverViewController.h"


#import "RSDirverContact.h"
#import "RSDriverViewController.h"





//出货记录界面的记录里面的数组
#import "RSOutRecordModel.h"

#import "RSDirverContact.h"

#import "RSBlockOutViewController.h"
#import "RSOsakaViewController.h"
#import "RSRecordDetailViewController.h"


@interface RSAddDriverViewController ()<UITextFieldDelegate>
{
    UIView *_navigationview;
    UIView *_headerview;
    UIView *_contentview;
}

/**提货人的名字*/
@property (nonatomic,strong)UITextField * nametextfield;

/**提货人的电话*/
@property (nonatomic,strong)UITextField * phonetextfield;
///**司机的身份证*/
//@property (nonatomic,strong)UITextField * identiftextfield;
///**司机的汽车车牌号*/
//@property (nonatomic,strong)UITextField * carcordtextfield;

@property (nonatomic,strong)NSArray * placeholderArray;

/**判断是添加司机信息，还是修改司机信息，true是添加，false是修改*/
@property (nonatomic,assign)BOOL isAddDriver;
@end

@implementation RSAddDriverViewController



- (NSArray *)placeholderArray{
    if (_placeholderArray == nil) {
        //,@"请填写身份证号码",@"请输入车牌号"
        _placeholderArray = @[@"请填写名字",@"请填写电话号码"];
    }
    return  _placeholderArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //对返回按钮的隐藏
    [self.navigationItem setHidesBackButton:YES];
     self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"添加提货人信息";
    //self.isAddDriver = true;
    [self initView];
    
    [self initContentView];
    
    [self addBottomView];
    
    
    
    //重新从司机获取的信息进行赋值
    [self huzhi];
   // &&[_identiftextfield.text isEqualToString:@""]&& [_carcordtextfield.text isEqualToString:@""]
    
    if ([_nametextfield.text isEqualToString:@""]&&[_phonetextfield.text isEqualToString:@""]) {
        self.isAddDriver = true;
    }else{
        self.isAddDriver = false;
    }
    
}

#pragma mark -- 重新赋值
- (void)huzhi{
    self.nametextfield.text = self.contact.csnName;
    self.phonetextfield.text = self.contact.csnPhone;
  //  self.identiftextfield.text = self.contact.idCard;
   // self.carcordtextfield.text = self.contact.license;
}



- (void)initView{
    UIView *Headerview = [[UIView alloc]init];
    Headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#efefef"];
    _headerview = Headerview;
    [self.view addSubview:Headerview];
    
    Headerview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view, 0)
    .heightIs(33.5);
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"提货人信息";
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [Headerview addSubview:titleLabel];
    
    titleLabel.sd_layout
    .centerYEqualToView(Headerview)
    .leftSpaceToView(Headerview,12)
    .heightIs(25)
    .widthRatioToView(Headerview,0.3);
}


- (void)initContentView{
    
    UIView *contentview = [[UIView alloc]init];
    contentview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentview];
    _contentview = contentview;
    contentview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_headerview,0)
    .heightIs(180);
    
    
    UIView *nameview = [[UIView alloc]init];
    nameview.backgroundColor = [UIColor whiteColor];
    [contentview addSubview:nameview];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"名字";
    nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    nameLabel.font = [UIFont systemFontOfSize:16];
    [nameview addSubview:nameLabel];
    
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@"iconfont-bitian-拷贝-2"];
    [nameview addSubview:imageview];
    
    
    UITextField * nametextfield = [[UITextField alloc]init];
    nametextfield.borderStyle = UITextBorderStyleNone;
    nametextfield.placeholder = self.placeholderArray[0];
    _nametextfield = nametextfield;
    
    _nametextfield.delegate = self;
    nametextfield.keyboardType = UIKeyboardTypeDefault;
    [nameview addSubview:nametextfield];
    
    
    UIView *nameBottom =  [[UIView alloc]init];
    nameBottom.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
    [nameview addSubview:nameBottom];
    
    
    UIView *phoneview = [[UIView alloc]init];
    phoneview.backgroundColor = [UIColor whiteColor];
    [contentview addSubview:phoneview];
    
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"电话号码";
    phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    phoneLabel.font = [UIFont systemFontOfSize:16];
    [phoneview addSubview:phoneLabel];
    
    UIImageView *phoneimage = [[UIImageView alloc]init];
    phoneimage.image = [UIImage imageNamed:@"iconfont-bitian-拷贝-2"];
    [phoneview addSubview:phoneimage];
    
    
    UITextField * phonetextfield = [[UITextField alloc]init];
    phonetextfield.borderStyle = UITextBorderStyleNone;
    phonetextfield.placeholder = self.placeholderArray[1];
    phonetextfield.keyboardType = UIKeyboardTypePhonePad;
    _phonetextfield = phonetextfield;
    
    _phonetextfield.delegate = self;
    
    
    
    [phoneview addSubview:phonetextfield];
    
    UIView *phoneBottom =  [[UIView alloc]init];
    phoneBottom.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
    [phoneview addSubview:phoneBottom];
    

//    UIView *identitfview = [[UIView alloc]init];
//    identitfview.backgroundColor = [UIColor whiteColor];
//    [contentview addSubview:identitfview];
//
//
//    UILabel *identifLabel = [[UILabel alloc]init];
//    identifLabel.text = @"身份证号码";
//    identifLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    identifLabel.font = [UIFont systemFontOfSize:16];
//    [identitfview addSubview:identifLabel];
//
//
//
//
//    UITextField * identiftextfield = [[UITextField alloc]init];
//    identiftextfield.borderStyle = UITextBorderStyleNone;
//    identiftextfield.placeholder = self.placeholderArray[2];
//    _identiftextfield = identiftextfield;
//
//    _identiftextfield.delegate = self;
//    [identitfview addSubview:identiftextfield];
//
//
//    UIView *identifBottom =  [[UIView alloc]init];
//    identifBottom.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
//    [identitfview addSubview:identifBottom];
//
//
//    UIView *carview = [[UIView alloc]init];
//    carview.backgroundColor = [UIColor whiteColor];
//    [contentview addSubview:carview];
//
//
//    UILabel *carcordLabel = [[UILabel alloc]init];
//    carcordLabel.text = @"车牌号";
//    carcordLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    carcordLabel.font = [UIFont systemFontOfSize:16];
//    [carview addSubview:carcordLabel];
//
//    UIImageView *carcordimage = [[UIImageView alloc]init];
//    carcordimage.image = [UIImage imageNamed:@"iconfont-bitian-拷贝-2"];
//    [carview addSubview:carcordimage];
//
//
//    UITextField * carcordtextfield = [[UITextField alloc]init];
//    carcordtextfield.borderStyle = UITextBorderStyleNone;
//    carcordtextfield.placeholder = self.placeholderArray[3];
//    _carcordtextfield = carcordtextfield;
//    _carcordtextfield.delegate = self;
//
//
//
//    [carview addSubview:carcordtextfield];
    
//    UIView *carcordBottom =  [[UIView alloc]init];
//    carcordBottom.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
//    [carview addSubview:carcordBottom];

    
    nameview.sd_layout
    .topSpaceToView(contentview,0)
    .leftSpaceToView(contentview,0)
    .rightSpaceToView(contentview,0)
    .heightIs(45);
    
    nameLabel.sd_layout
    .centerYEqualToView(nameview)
    .leftSpaceToView(nameview,12)
    .widthIs(35)
    .heightRatioToView(nameview,0.5);
    
    
    imageview.sd_layout
    .leftSpaceToView(nameLabel,10)
    .centerYEqualToView(nameview)
    .widthIs(10)
    .heightIs(10);
    
    nametextfield.sd_layout
    .leftSpaceToView(imageview,45)
    .widthRatioToView(nameview,0.3)
    .centerYEqualToView(nameview)
    .topSpaceToView(nameview,5)
    .bottomSpaceToView(nameview,5);
    
    
    nameBottom.sd_layout
    .leftSpaceToView(nameview,0)
    .rightSpaceToView(nameview,0)
    .bottomSpaceToView(nameview,0)
    .heightIs(1);
    
    
    phoneview.sd_layout
    .topSpaceToView(nameview,0)
    .leftSpaceToView(contentview,0)
    .rightSpaceToView(contentview,0)
    .heightIs(45);
    
    phoneLabel.sd_layout
    .centerYEqualToView(phoneview)
    .leftSpaceToView(phoneview,12)
    .widthIs(70)
    .heightRatioToView(phoneview,0.5);
    
    
    phoneimage.sd_layout
    .leftSpaceToView(phoneLabel,10)
    .centerYEqualToView(phoneview)
    .widthIs(10)
    .heightIs(10);

    phonetextfield.sd_layout
    .leftSpaceToView(phoneimage,10)
    .widthRatioToView(phoneview,0.5)
    .centerYEqualToView(phoneview)
    .topSpaceToView(phoneview,5)
    .bottomSpaceToView(phoneview,5);
    
    phoneBottom.sd_layout
    .leftSpaceToView(phoneview,0)
    .rightSpaceToView(phoneview,0)
    .bottomSpaceToView(phoneview,0)
    .heightIs(1);
    
    

    
//    identitfview.sd_layout
//    .topSpaceToView(phoneview,0)
//    .leftSpaceToView(contentview,0)
//    .rightSpaceToView(contentview,0)
//    .heightIs(45);
//
//
//    identifLabel.sd_layout
//    .centerYEqualToView(identitfview)
//    .leftSpaceToView(identitfview,12)
//    .widthIs(90)
//    .heightRatioToView(identitfview,0.5);
//
//
//    identiftextfield.sd_layout
//    .leftSpaceToView(identifLabel,10)
//    .centerYEqualToView(identitfview)
//    .rightSpaceToView(identitfview,12)
//    .topSpaceToView(identitfview,5)
//    .bottomSpaceToView(identitfview,5);
    
//    identifBottom.sd_layout
//    .leftSpaceToView(identitfview,0)
//    .rightSpaceToView(identitfview,0)
//    .bottomSpaceToView(identitfview,0)
//    .heightIs(1);
//
//
//
//
//    carview.sd_layout
//    .topSpaceToView(identitfview,0)
//    .leftSpaceToView(contentview,0)
//    .rightSpaceToView(contentview,0)
//    .heightIs(45);
//
//    carcordLabel.sd_layout
//    .centerYEqualToView(carview)
//    .leftSpaceToView(carview,12)
//    .widthIs(50)
//    .heightRatioToView(carview,0.5);
    
    
//    carcordimage.sd_layout
//    .leftSpaceToView(carcordLabel,10)
//    .centerYEqualToView(carview)
//    .widthIs(10)
//    .heightIs(10);
//
//    carcordtextfield.sd_layout
//    .leftSpaceToView(carcordimage,30)
//    .centerYEqualToView(carview)
//    .rightSpaceToView(carview,12)
//    .topSpaceToView(carview,5)
//    .bottomSpaceToView(carview,5);
//
//    carcordBottom.sd_layout
//    .leftSpaceToView(carview,0)
//    .rightSpaceToView(carview,0)
//    .bottomSpaceToView(carview,0)
//    .heightIs(1);
//
 
    
}
- (void)addBottomView{
    UIView *bottomview = [[UIView alloc]init];
    [self.view addSubview:bottomview];
    bottomview.backgroundColor = [UIColor whiteColor];
    
    bottomview.sd_layout
    
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_contentview, 0)
    .heightIs(50);
    
    
    UIButton * saveBtn = [[UIButton alloc]init];
    [saveBtn addTarget:self action:@selector(saveDriver) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTintColor:[UIColor whiteColor]];
    [bottomview addSubview:saveBtn];
    
    saveBtn.sd_layout
    .centerXEqualToView(bottomview)
    .centerYEqualToView(bottomview)
    .leftSpaceToView(bottomview,12)
    .rightSpaceToView(bottomview,12)
    .topSpaceToView(bottomview, 0)
    .bottomSpaceToView(bottomview, 0);
    
    
}




- (BOOL)textFieldShouldReturn:(UITextField *)textfield{
        [textfield resignFirstResponder];
    return YES;
}





#pragma mark -- 保存司机信息
- (void)saveDriver{
    NSString * temp = [_nametextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (temp.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"姓名错误"];
        return;
    }
    
    if (![self isTrueMobile:_phonetextfield.text]) {
        [SVProgressHUD showErrorWithStatus:@"电话号码错误"];
        return;
    }
//    if ([self checkUserID:_identiftextfield.text]) {
//        [SVProgressHUD showErrorWithStatus:@"身份证错误"];
//        return;
//    }
//    if ([self validateCarNo:_carcordtextfield.text]) {
//        [SVProgressHUD showErrorWithStatus:@"车牌号错误"];
//        return;
//    }
    
    //这边要做一个判断一下，到底是添加数据，还是修改数据
    
   if (self.isAddDriver == true) {
        //添加
       [self addDriverName:_nametextfield.text andDriverPhone:_phonetextfield.text];
     }
    else{
        //修改
       [self modifyOwerDriverName:_nametextfield.text andOwerDriverPhone:_phonetextfield.text];
    }
}


#pragma mark -- 修改
- (void)modifyOwerDriverName:(NSString *)csnName andOwerDriverPhone:(NSString *)csnPhone{
    
    //这边是修改
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    RSOutRecordModel * outRecordmodel = self.chuArray[0];
    //  [dict setObject:self.userID forKey:@"erpcode"];
    //[dict setObject:self.contact.driverID forKey:@"id"];
    // [dict setObject:_nametextfield.text forKey:@"name"];
    
    [dict setObject:[NSString stringWithFormat:@"%@",csnName] forKey:@"csnName"];
    [dict setObject:[NSString stringWithFormat:@"%@",csnPhone] forKey:@"csnPhone"];
    [dict setObject:[NSString stringWithFormat:@"%@",outRecordmodel.outstoreId] forKey:@"AppOutID"];
    
    //[dict setObject:_phonetextfield.text forKey:@"phone"];
    // [dict setObject:_identiftextfield.text forKey:@"idCard"];
    //[dict setObject:_carcordtextfield.text forKey:@"license"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    
    XLAFNetworkingBlock  * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_MODIFYCHILDACCESS_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                
                if (weakSelf.isAddDriver == true) {
                    
                    if ([weakSelf.deleagate respondsToSelector:@selector(transmitConsigneeName:andConsigneePhone:)]) {
                        [weakSelf.deleagate transmitConsigneeName:csnName andConsigneePhone:csnPhone];
                        
                    }
                    
                    NSUInteger index = [[weakSelf.navigationController viewControllers]indexOfObject:weakSelf];
                    
                    [weakSelf.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index - 2]animated:YES];
                    
                    
                }else{
                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",json[@"MSG_CODE"]] message:nil preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [weakSelf addDriverName:_nametextfield.text andDriverPhone:_phonetextfield.text];
                    }];
                    
                    [alert addAction:action];
                    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alert addAction:action1];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                           alert.modalPresentationStyle = UIModalPresentationFullScreen;
                                       }
                    [weakSelf presentViewController:alert animated:YES completion:nil];

                }
               
                //  [weakSelf.navigationController popViewControllerAnimated:YES];
                // [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",json[@"MSG_CODE"]]];
            }else{
                [RSLoginValidity LoginValiditWithVerifyKey:verifykey andViewController:weakSelf];
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
        }
    }];
    
}





- (void)addDriverName:(NSString *)csnName andDriverPhone:(NSString *)csnPhone{
//    BOOL isDifferent = YES;
//    for (int i = 0; i < self.driverArray.count; i++) {
//        RSDirverContact * contact = self.driverArray[i];
//        //相同
//        if ([contact.csnName isEqualToString:csnName] && [contact.csnPhone isEqualToString:csnPhone]) {
//            isDifferent = NO;
//            break;
//        }else{
//            //不同
//            isDifferent = YES;
//        }
//    }
//    if (isDifferent) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *verifykey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:self.userModel.userID forKey:@"userId"];
        [dict setObject:[NSString stringWithFormat:@"%@",csnName] forKey:@"name"];
        [dict setObject:[NSString stringWithFormat:@"%@",csnPhone] forKey:@"phone"];
        // [dict setObject:_identiftextfield.text forKey:@"idCard"];
        // [dict setObject:_carcordtextfield.text forKey:@"license"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        __weak typeof(self) weakSelf = self;
        XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
        //URL_DELIVERYPERSON_IOS
        [network getDataWithUrlString:URL_DELIVERYPERSON_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"contactDataRefresh" object:nil];
                    if ([[weakSelf.navigationController.viewControllers objectAtIndex:3]class] == [RSRecordDetailViewController class]) {
                        //在出库记录里面的数据
                        if (weakSelf.isAddDriver == true) {
                            //这边是新的添加提货人
                            weakSelf.isAddDriver = true;
                            [weakSelf modifyOwerDriverName:csnName andOwerDriverPhone:csnPhone];
                            //1.这边要添加到新的提货人列表
                            //2.这边也要对提货人的修改
                            //3.要返回原来的出库记录详情页面
                            
                        }else{
                            // 这边是旧的提货人（就是修改提货人）
                            if ([weakSelf.deleagate respondsToSelector:@selector(transmitConsigneeName:andConsigneePhone:)]) {
                                [weakSelf.deleagate transmitConsigneeName:csnName andConsigneePhone:csnPhone];
                            }
                            
                            
                            //[NSNotificationCenter de]
                            
                            NSUInteger index = [[weakSelf.navigationController viewControllers]indexOfObject:weakSelf];
                            [weakSelf.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index - 2]animated:YES];
                        }
                    }else{
                         [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                }else{
                    if ([[weakSelf.navigationController.viewControllers objectAtIndex:2]class] == [RSOsakaViewController class] ||[[weakSelf.navigationController.viewControllers objectAtIndex:2]class] == [RSBlockOutViewController class]) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }else{
                        
                        
                        if ([weakSelf.deleagate respondsToSelector:@selector(transmitConsigneeName:andConsigneePhone:)]) {
                            [weakSelf.deleagate transmitConsigneeName:csnName andConsigneePhone:csnPhone];
                        }
                        
                        NSUInteger index = [[weakSelf.navigationController viewControllers]indexOfObject:weakSelf];
                        [weakSelf.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index - 2]animated:YES];
                    }
                }
            }else{
                if ([[weakSelf.navigationController.viewControllers objectAtIndex:2]class] == [RSOsakaViewController class] ||[[weakSelf.navigationController.viewControllers objectAtIndex:2]class] == [RSBlockOutViewController class]) {
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    
                    NSUInteger index = [[weakSelf.navigationController viewControllers]indexOfObject:weakSelf];
                    [weakSelf.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index - 2]animated:YES];
                }
            }
        }];
//    }else{
//        [SVProgressHUD showInfoWithStatus:@"你添加的提货人已经存在了"];
//        
//        if ([[self.navigationController.viewControllers objectAtIndex:2]class] == [RSOsakaViewController class] ||[[self.navigationController.viewControllers objectAtIndex:2]class] == [RSBlockOutViewController class]) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            if ([self.deleagate respondsToSelector:@selector(transmitConsigneeName:andConsigneePhone:)]) {
//                [self.deleagate transmitConsigneeName:csnName andConsigneePhone:csnPhone];
//            }
//            NSUInteger index = [[self.navigationController viewControllers]indexOfObject:self];
//            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index - 2]animated:YES];
//        }
//       
//    }
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
