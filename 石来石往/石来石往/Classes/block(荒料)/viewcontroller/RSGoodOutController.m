//
//  RSGoodOutController.m
//  石来石往
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSGoodOutController.h"
#import "RSGoodHeaderSectionView.h"
#import "RSGoodsCell.h"

//用来做判断是那个数组传给来的
#import "RSOsakaViewController.h"
#import "RSOsakaCell.h"

//模型
#import "RSOsakaModel.h"
#import "RSBlockModel.h"
#import "RSDirverContact.h"
#import "RSTurnsCountModel.h"
#import "RSPiecesModel.h"

#import "RSStockViewController.h"





//用来判断，用户有没有被其他的设备登录
#import "NSString+RSErrerResutl.h"


@interface RSGoodOutController ()<UITextFieldDelegate>
{
    UIButton * _timeBtn;
    UILabel * _phoneLabel;
    //输入短信验证码
    UITextField * _phoneTextfield;
    
    //图形验证码输入框
    UITextField * _smsTextField;
    //更改图形验证码
    UIButton * _smsBtn;
}
//输入验证码界面
@property (nonatomic,strong)UIView * informationview;
@property (nonatomic,strong)UIView * menview;

/**这个值，就用来对短信验证是否成功的一个成员属性*/
@property (nonatomic,assign)BOOL isSuccess;
//@property (nonatomic,strong)UITableView *tableview;
//@property (nonatomic,strong)NSTimer *timers;
//@property (nonatomic,assign)int count;
/**货主的超期加工超期费用*/
@property (nonatomic,assign)CGFloat deaMachiningOverFee;
/**货主的欠费提示语*/
@property (nonatomic,strong)NSString * feeMsg;
/**货主超期仓储超期费用*/
@property (nonatomic,assign)CGFloat deaStorageOverFee;
/**货主大板超期费用*/
@property (nonatomic,assign)CGFloat deaSlOverFee;

@property (nonatomic,copy)NSString * uuid;


@end

@implementation RSGoodOutController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.uuid = [NSString get_uuid];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self isAddjust];
    self.title = @"提交出货订单";
    //定时器
//    self.count = 120;
    //自定义导航栏
    [self addCustomNavigationBarView];
    //添加自定义的tableview
    [self addCustomTableview];
    //添加底部视图
    [self addBottomContentview];
    
    //获取货主的钱有多少
    [self obtainOwnerMoney];
   
}

- (void)obtainOwnerMoney{
    //URL_ERPFEE
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.userID forKey:@"userId"];
    [dict setObject:@"1" forKey:@"erpId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_ERPFEE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                weakSelf.deaMachiningOverFee = [json[@"Data"][@"deaMachiningOverFee"] floatValue];
                weakSelf.deaStorageOverFee = [json[@"Data"][@"deaStorageOverFee"] floatValue];
                weakSelf.deaSlOverFee = [json[@"Data"][@"deaSlOverFee"] floatValue];
                weakSelf.feeMsg = json[@"Data"][@"feeMsg"];
            }
        }
    }];
}




static NSString *goodHeaderID = @"goodheader";
static NSString *goodCellID = @"goodcell";
- (void)addCustomTableview{
//    CGFloat bottomH = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        bottomH = 34;
//    }else{
//        bottomH = 0.0;
//    }
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navHeight + navY, SCW, SCH - ((navY + navHeight) + 45 + bottomH)) style:UITableViewStylePlain];
//    //    self.tableview.scrollEnabled = NO;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar - Height_bottomSafeArea - 45);
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerClass:[RSGoodHeaderSectionView class] forHeaderFooterViewReuseIdentifier:goodHeaderID];
    [self.tableview registerClass:[RSGoodsCell class] forCellReuseIdentifier:goodCellID];
}

- (void)addCustomNavigationBarView{
    UIButton * backItem = [[UIButton alloc]init];
    [backItem setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    backItem.frame = CGRectMake(0, 0, 35, 35);
    [backItem addTarget:self action:@selector(backDriverViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:backItem];
    self.navigationItem.leftBarButtonItem = item;
}

#pragma mark -- 添加底部视图
- (void)addBottomContentview{
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 34;
//    }else{
//        Y = 0;
//    }
    UIButton * shipmentBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCH - Height_NavBar - Height_bottomSafeArea - 45, SCW, 45)];
    [shipmentBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
    [shipmentBtn setTitle:@"立即出货" forState:UIControlStateNormal];
    [shipmentBtn addTarget:self action:@selector(rightOffShipmen:) forControlEvents:UIControlEventTouchUpInside];
    shipmentBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:shipmentBtn];
    
    //    shipmentBtn.sd_layout
    //    .leftSpaceToView(self.view,0)
    //    .rightSpaceToView(self.view,0)
    //    .bottomSpaceToView(self.view,0)
    //    .heightIs(45);
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopNumberCountArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里要判断是用的是那个导航控制器------ 这句话有点问题
    //这边是判断是大板
    if ([[self.navigationController.viewControllers objectAtIndex:2]class] == [RSOsakaViewController class]) {
        RSOsakaModel * osakaModel = self.shopNumberCountArray[indexPath.row];
        RSGoodsCell * cell = [[RSGoodsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.osakaModel = osakaModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        //这边是荒料
        RSGoodsCell *cell = [[RSGoodsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        RSBlockModel *blockmodel = self.shopNumberCountArray[indexPath.row];
        cell.blockmodel = blockmodel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    RSGoodHeaderSectionView *goodheaderview = [self.tableview dequeueReusableHeaderFooterViewWithIdentifier:goodHeaderID];
    if (!goodheaderview) {
        goodheaderview = [[RSGoodHeaderSectionView alloc]initWithReuseIdentifier:goodHeaderID];
    }
    
    if ([[self.navigationController.viewControllers objectAtIndex:2]class] == [RSOsakaViewController class]){
        //这边是大板
        CGFloat zongPi = 0.0;
        for (int i = 0; i < self.shopNumberCountArray.count; i++) {
            RSOsakaModel * osakaModel = self.shopNumberCountArray[i];
            for (RSTurnsCountModel * turnsModel in osakaModel.turns) {
                //这边有按匝和按片的地方
                //这边要匝进行处理
                if (turnsModel.turnsStatus == 1) {
                    for (int j = 0; j < turnsModel.pieces.count; j++) {
                        RSPiecesModel * piecesModel = turnsModel.pieces[j];
                        zongPi += [piecesModel.area floatValue];
                    }
                }else{
                    //这边按片进行处理
                    for (int n = 0; n < turnsModel.pieces.count; n++) {
                        RSPiecesModel * piecesModel = turnsModel.pieces[n];
                        if (piecesModel.status == 1) {
                            zongPi += [piecesModel.area floatValue];
                        }
                    }
                }
            }
        }
        goodheaderview.zongPiLabel.text = [NSString stringWithFormat:@"总面积:%0.3fm²",zongPi];
    }else{
        //这边是荒料
        //RSBlockModel *blockmodel = self.shopNumberCountArray[indexPath.row];
        CGFloat zongLi = 0.0;
        for (int i = 0; i < self.shopNumberCountArray.count; i++) {
            RSBlockModel *blockmodel = self.shopNumberCountArray[i];
            zongLi += [blockmodel.blockVolume floatValue];
        }
        goodheaderview.zongPiLabel.text = [NSString stringWithFormat:@"总体积:%0.3fm³",zongLi];
    }
    goodheaderview.contact = self.contact;
    return goodheaderview;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 187;
}



#pragma mark -- 立即出货
- (void)rightOffShipmen:(UIButton *)btn{
    [self checkOutNoticeVaild];
    
    
    
}


- (void)checkOutNoticeVaild{
    //URL_CHECKOUTNOTICE_IOS
    [SVProgressHUD showWithStatus:@"库存校验中..."];
    RSWeakself
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSString * erpid  = [[NSString alloc]init];
    if ([[self.navigationController.viewControllers objectAtIndex:2]class] == [RSOsakaViewController class]) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < self.shopNumberCountArray.count; i++) {
            RSOsakaModel * osakaModel = self.shopNumberCountArray[i];
            for (RSTurnsCountModel * turnsModel in osakaModel.turns) {
                //这边有按匝和按片的地方
                //这边要匝进行处理
                if (turnsModel.turnsStatus == 1) {
                    for (int j = 0; j < turnsModel.pieces.count; j++) {
                        RSPiecesModel * piecesModel = turnsModel.pieces[j];
                        //NSString * erpid  = [[NSString alloc]init];
                        [array addObject:piecesModel.pieceID];
                        erpid = [array componentsJoinedByString:@","];
                    }
                }else{
                    //这边按片进行处理
                    for (int n = 0; n < turnsModel.pieces.count; n++) {
                        RSPiecesModel * piecesModel = turnsModel.pieces[n];
                        if (piecesModel.status == 1) {
                            [array addObject:piecesModel.pieceID];
                            erpid = [array componentsJoinedByString:@","];
                        }
                    }
                }
            }
        }
        [phoneDict setObject:self.userModel.userID forKey:@"userId"];
//        [phoneDict setObject:@"1" forKey:@"erpId"];
        [phoneDict setObject:self.userModel.userPhone forKey:@"mobilePhone"];
//        [phoneDict setObject:_phoneTextfield.text forKey:@"phoneCode"];
        [phoneDict setObject:erpid forKey:@"erpDids"];
        [phoneDict setObject:self.outStyle forKey:@"type"];
        [phoneDict setObject:self.contact.csnName forKey:@"name"];
        [phoneDict setObject:self.contact.csnPhone forKey:@"phone"];
        //[phoneDict setObject:self.contact.name forKey:@"driverName"];
        //[phoneDict setObject:self.contact.phone forKey:@"driverPhoneNum"];
        //[phoneDict setObject:self.contact.idCard forKey:@"driverIDCard"];
        //[phoneDict setObject:self.contact.license forKey:@"driverLicensePlate"];
        //二进制数
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_CHECKOUTNOTICE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
//                NSLog(@"===================%@",json);
                if (Result) {
                    [SVProgressHUD dismiss];
                    //这边直接添加蒙版和短信验证
                    [weakSelf addConfirmationInformationview];
                }else{
//                    [SVProgressHUD showErrorWithStatus:@"对不起,没有库存了"];
                    [SVProgressHUD showErrorWithStatus:json[@"MSG_CODE"]];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"校验失败"];
            }
        }];
    }else{
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < self.shopNumberCountArray.count; i++) {
            RSBlockModel *blockmodel = self.shopNumberCountArray[i];
            //[erpid appendFormat:@"%@",blockmodel.DID];
            [array addObject:blockmodel.DID];
            erpid = [array componentsJoinedByString:@","];
        }
        [phoneDict setObject:erpid forKey:@"erpDids"];
        [phoneDict setObject:self.outStyle forKey:@"type"];
        [phoneDict setObject:self.userModel.userPhone forKey:@"mobilePhone"];
        [phoneDict setObject:self.contact.csnName forKey:@"name"];
        [phoneDict setObject:self.contact.csnPhone forKey:@"phone"];
        [phoneDict setObject:self.userModel.userID forKey:@"userId"];
        //二进制数
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_CHECKOUTNOTICE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                  [SVProgressHUD dismiss];
                   //这边直接添加蒙版和短信验证
                   [weakSelf addConfirmationInformationview];
                }else{
                    [SVProgressHUD showErrorWithStatus:json[@"MSG_CODE"]];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"校验失败"];
            }
        }];
    }
}







#pragma mark -- 添加一个短信信息的界面
- (void)addConfirmationInformationview{
//    self.count = 120;
    UIView *menview = [[UIView alloc]init];
    menview.backgroundColor = [[UIColor darkGrayColor]colorWithAlphaComponent:0.5];
    menview.frame = CGRectMake(0, 0, SCW, SCH);
    [self.view addSubview:menview];
    _menview = menview;
    
    UIView * informationview = [[UIView alloc]init];
    informationview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:informationview];
    _informationview = informationview;
    informationview.layer.cornerRadius = 5;
    informationview.layer.masksToBounds = YES;
    
    informationview.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .leftSpaceToView(self.view,12)
    .rightSpaceToView(self.view,12)
    .heightIs(190.5);
    
    UILabel * label = [[UILabel alloc]init];
    label.text = @"发送短信验证码到";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    [informationview addSubview:label];
    
    label.sd_layout
    .leftSpaceToView(informationview,12)
    .topSpaceToView(informationview,20)
    .widthIs(130)
    .heightIs(13);
    
    //这个电话号码要从用户的模型中userModel模型里面
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = self.userModel.userPhone;
    phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#ff5f04"];
    phoneLabel.font = [UIFont systemFontOfSize:14];
    [informationview addSubview:phoneLabel];
    _phoneLabel = phoneLabel;
    
    phoneLabel.sd_layout
    .leftSpaceToView(label,2)
    .rightSpaceToView(informationview,12)
    .topEqualToView(label)
    .bottomEqualToView(label);
    
//    UIView *centerview = [[UIView alloc]init];
//    centerview.backgroundColor = [UIColor whiteColor];
//    centerview.layer.cornerRadius = 5;
//    centerview.layer.borderWidth = 1;
//    centerview.layer.masksToBounds = YES;
//    centerview.layer.borderColor = [UIColor colorWithHexColorStr:@"#e9e9e9"].CGColor;
//    [informationview addSubview:centerview];
    
    
    UITextField *smsTextField  = [[UITextField alloc]init];
//    NSString * smsTextFieldStr  = @"请输入图形验证码";
    smsTextField.placeholder = @"请输入图形验证码";
    smsTextField.borderStyle = UITextBorderStyleNone;
    smsTextField.delegate = self;
    _smsTextField = smsTextField;
//    NSMutableAttributedString *placeStr4 = [[NSMutableAttributedString alloc]initWithString:smsTextFieldStr];
//    [placeStr4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#333333"] range:NSMakeRange(0, smsTextFieldStr.length)];
//    [placeStr4 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, smsTextFieldStr.length)];
//    smsTextField.attributedPlaceholder = placeStr4;
    [informationview addSubview:smsTextField];
    
    
    UIButton * smsBtn = [[UIButton alloc]init];
    [smsBtn addTarget:self action:@selector(changCodePitureAction:) forControlEvents:UIControlEventTouchUpInside];
    [informationview addSubview:smsBtn];
    _smsBtn = smsBtn;
    
    
//    UIView * smsBottomview  =[[UIView alloc]init];
//    smsBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e5e5e5"];
//    [informationview addSubview:smsBottomview];

    
//    codePictureview.sd_layout.leftSpaceToView(contentview, 0).rightSpaceToView(contentview, 0).topSpaceToView(phoneview, 0).heightIs(55);
//
//    smsTextField.sd_layout.leftSpaceToView(codePictureview, 35).widthIs(SCW - 12-12-10-10-15-12-77.5)
//        .centerYEqualToView(codePictureview)
//        .topSpaceToView(codePictureview,12)
//        .bottomSpaceToView(codePictureview,12);
//
//
//    smsBtn.sd_layout.leftSpaceToView(smsTextField,0)
//        .rightSpaceToView(codePictureview,10)
//        .centerYEqualToView(codePictureview)
//        .widthIs(77.5)
//        .heightIs(30);
   
    [_smsBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?key=%@",URL_GET_TEXT_SMS_VERIFY_CODE_IOS,self.uuid]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"背景"]];
    
  
    
    UITextField * phoneTextfield = [[UITextField alloc]init];
    phoneTextfield.borderStyle = UITextBorderStyleNone;
    phoneTextfield.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextfield.placeholder = @"请输入验证码";
    [informationview addSubview:phoneTextfield];
    //[phoneTextfield addTarget:self action:@selector(verificationPhoneShortMessage:) forControlEvents:UIControlEventEditingChanged];
    _phoneTextfield = phoneTextfield;
    
    UIButton *timebtn = [[UIButton alloc]init];
//    timebtn.enabled = NO;
    [timebtn setTitle:@"发送短信" forState:UIControlStateNormal];
    [timebtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
    [timebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [timebtn addTarget:self action:@selector(startTimerSendMessageCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    timebtn.titleLabel.font = [UIFont systemFontOfSize:16];
    timebtn.layer.cornerRadius = 5;
    timebtn.layer.masksToBounds = YES;
    [informationview addSubview:timebtn];
    _timeBtn = timebtn;
    
    UIButton * sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(surePostInformation:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.layer.masksToBounds = YES;
    [informationview addSubview:sureBtn];
    
    UIButton * cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelSendMessageView:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.cornerRadius = 5;
    cancelBtn.layer.masksToBounds = YES;
    [informationview addSubview:cancelBtn];
    
//    centerview.sd_layout
//    .topSpaceToView(label,15)
//    .centerXEqualToView(informationview)
//    .leftSpaceToView(informationview,12)
//    .rightSpaceToView(informationview,12)
//    .heightIs(40.5);
    
    smsTextField.sd_layout
    .leftSpaceToView(informationview,12)
    .topSpaceToView(label,15)
    .heightIs(40.5)
    .widthIs(SCW * 0.5);
    
    
    smsTextField.layer.borderWidth = 1;
    smsTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#e9e9e9"].CGColor;
    
    
    smsBtn.sd_layout
    .leftSpaceToView(smsTextField,0)
    .rightSpaceToView(informationview,12)
    .topSpaceToView(label,15)
    .heightIs(40.5);
    
    phoneTextfield.sd_layout
    .leftSpaceToView(informationview,12)
    .topSpaceToView(smsTextField,0)
    .heightIs(40.5)
    .widthIs(SCW * 0.5);
    
    phoneTextfield.layer.borderWidth = 1;
    phoneTextfield.layer.borderColor = [UIColor colorWithHexColorStr:@"#e9e9e9"].CGColor;
    
    timebtn.sd_layout
    .leftSpaceToView(phoneTextfield,0)
    .rightSpaceToView(informationview,12)
    .topSpaceToView(smsTextField,0)
    .heightIs(40.5);
    
    sureBtn.sd_layout
    .topSpaceToView(phoneTextfield,12)
    .bottomSpaceToView(informationview,15)
    .leftSpaceToView(informationview,12)
    .widthIs((SCW - 24)/2 - 24);
    
    cancelBtn.sd_layout
    .topEqualToView(sureBtn)
    .bottomEqualToView(sureBtn)
    .leftSpaceToView(sureBtn, 24)
    .rightSpaceToView(informationview, 12);
    
//    [self addTimers];

//    if ([phoneLabel.text isEqualToString:@""]||phoneLabel.text == nil) {
//        [SVProgressHUD showErrorWithStatus:@"货主没有电话，暂时还不能出货申请"];
//        [self removeTime];
//        [_menview removeFromSuperview];
//        [_informationview removeFromSuperview];
//    }else{
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
//        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//        [phoneDict setObject:phoneLabel.text forKey:@"mobilePhone"];
//        //二进制数
//        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        //URL_GET_TEXT_VERIFY_UNLOGIN_IOS URL_GET_TEXT_VERIFY
//        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//        //__weak typeof(self) weakSelf = self;
//        XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//        [network getDataWithUrlString:URL_GET_TEXT_VERIFY_UNLOGIN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//            if (success) {
//                BOOL Result = [json[@"Result"] boolValue] ;
//                if (Result) {
//                    //                    [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
//                }else{
//                    if ([json[@"MSG_CODE"] isEqualToString:@"MAX_MSG_QTY"]) {
//                        [SVProgressHUD showErrorWithStatus:@"短信发送过多"];
//                    }else{
//                        //[RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:weakSelf];
//                    }
//                }
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"发送验证码失败"];
//            }
//        }];
//    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _smsTextField){
        NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        textField.text = temp;
    }
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



// 开启倒计时效果
-(void)startTimerSendMessageCodeBtn:(UIButton *)btn{
    if ([self isTrueMobile:_phoneLabel.text]) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        [phoneDict setObject:_phoneLabel.text forKey:@"mobilePhone"];
        
        [phoneDict setObject:self.uuid forKey:@"key"];
        [phoneDict setObject:_smsTextField.text forKey:@"value"];
        
        //二进制数
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //URL_GET_TEXT_VERIFY_UNLOGIN_IOS URL_GET_TEXT_VERIFY
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        //__weak typeof(self) weakSelf = self;
        XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
        //URL_GET_TEXT_VERIFY_UNLOGIN_IOS
        [network getDataWithUrlString:URL_GET_TEXT_SMS_VERIFY_SEND_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue] ;
                if (Result) {
                    //                    [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
                    __block NSInteger time = 119; //倒计时时间
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
                            int seconds = time % 120;
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
        [SVProgressHUD showErrorWithStatus:@"货主没有电话，暂时还不能出货申请"];
    }
}

#pragma mark -- 确认发送数据到服务器上
- (void)surePostInformation:(UIButton *)btn{
    if (_phoneTextfield.text.length > 0) {
        //这边要进行把数组里面的数组往支付上面送
        [self verificationPhoneShortMessage:_phoneTextfield];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请输入验证码"];
    }
}

//取消发送短信界面
- (void)cancelSendMessageView:(UIButton *)cancenBtn{
    [JHSysAlertUtil presentAlertViewWithTitle:@"操作取消按键，需库存重新匹配，请等待三分钟在开出库" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:true cancel:^{
    } confirm:^{
        [self.informationview removeFromSuperview];
        [self.menview removeFromSuperview];
    }];
}

//- (void)addTimers{
//    self.timers = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changTime) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.timers forMode:NSRunLoopCommonModes];
//}
//
//
//#pragma mark -- 每次执行定时器的方法
//- (void)changTime{
//    self.count--;
//    [_timeBtn setTitle:[NSString stringWithFormat:@"%d秒",self.count] forState:UIControlStateNormal];
//    if (_count <= 0) {
//        [self removeTime];
//        self.count = 120;
//        [SVProgressHUD showErrorWithStatus:@"信息不完整"];
//        [_menview removeFromSuperview];
//        [_informationview removeFromSuperview];
//    }
//}
//
//- (void)removeTime{
//    [self.timers invalidate];
//    self.timers = nil;
//}



#pragma mark --- 验证短信验证码
- (void)verificationPhoneShortMessage:(UITextField *)textfield{
    //self.isSuccess = false;
    if (textfield.text.length > 5) {
        //URL_VERIFY_TEXT_VERIFY
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        /*
         [phoneDict setObject:self.userID forKey:@"ERPCODE"];
         [phoneDict setObject:_phoneTextfield.text forKey:@"KEY"];
         */
        //手机号
        [phoneDict setObject:_phoneLabel.text forKey:@"mobilePhone"];
        //验证码
        [phoneDict setObject:_phoneTextfield.text forKey:@"phoneCode"];
        //二进制数
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        //URL_VERIFY_TEXT_VERIFY URL_VERIFY_TEXT_VERIFY_UNLOGIN_IOS
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_VERIFY_TEXT_VERIFY_UNLOGIN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    [weakSelf.informationview removeFromSuperview];
                    [weakSelf.menview removeFromSuperview];
                    weakSelf.isSuccess = true;
                    [SVProgressHUD showSuccessWithStatus:@"验证成功"];
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf deliverFromGodown:weakSelf.isSuccess];
//                    });
                }else{
                    weakSelf.isSuccess = false;
                    [SVProgressHUD showErrorWithStatus:json[@"MSG_CODE"]];
                    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:weakSelf];
                }
            }
        }];
    }else{
        self.isSuccess = false;
        [SVProgressHUD showErrorWithStatus:@"验证失败"];
    }
}



- (void)deliverFromGodown:(BOOL)isSuccess{
    if (self.isSuccess) {
        RSWeakself
        [SVProgressHUD showWithStatus:@"保存中......."];
        //URL_BLOCK_OUTSTORE_COMMIT  荒料出货
        //URL_PLATE_OUTSTORE_COMMIT  大板出货
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        NSString * erpid  = [[NSString alloc]init];
        if ([[self.navigationController.viewControllers objectAtIndex:2]class] == [RSOsakaViewController class]) {
            NSMutableArray * array = [NSMutableArray array];
            for (int i = 0; i < self.shopNumberCountArray.count; i++) {
                RSOsakaModel * osakaModel = self.shopNumberCountArray[i];
                for (RSTurnsCountModel * turnsModel in osakaModel.turns) {
                    //这边有按匝和按片的地方
                    //这边要匝进行处理
                    if (turnsModel.turnsStatus == 1) {
                        for (int j = 0; j < turnsModel.pieces.count; j++) {
                            RSPiecesModel * piecesModel = turnsModel.pieces[j];
                            //NSString * erpid  = [[NSString alloc]init];
                            [array addObject:piecesModel.pieceID];
                            erpid = [array componentsJoinedByString:@","];
                        }
                    }else{
                        //这边按片进行处理
                        for (int n = 0; n < turnsModel.pieces.count; n++) {
                            RSPiecesModel * piecesModel = turnsModel.pieces[n];
                            if (piecesModel.status == 1) {
                                [array addObject:piecesModel.pieceID];
                                erpid = [array componentsJoinedByString:@","];
                            }
                        }
                    }
                }
            }
            [phoneDict setObject:self.userID forKey:@"userId"];
            [phoneDict setObject:@"1" forKey:@"erpId"];
            [phoneDict setObject:_phoneLabel.text forKey:@"mobilePhone"];
            [phoneDict setObject:_phoneTextfield.text forKey:@"phoneCode"];
            [phoneDict setObject:erpid forKey:@"erpDids"];
            [phoneDict setObject:self.outStyle forKey:@"type"];
            [phoneDict setObject:self.contact.csnName forKey:@"name"];
            [phoneDict setObject:self.contact.csnPhone forKey:@"phone"];
            //[phoneDict setObject:self.contact.name forKey:@"driverName"];
            //[phoneDict setObject:self.contact.phone forKey:@"driverPhoneNum"];
            //[phoneDict setObject:self.contact.idCard forKey:@"driverIDCard"];
            //[phoneDict setObject:self.contact.license forKey:@"driverLicensePlate"];
            //二进制数
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_OUTSTORE_COMMIT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL Result = [json[@"Result"] boolValue];
                    if (Result) {
                        
                        //提醒
                        //deaMachiningOverFee
                        [weakSelf setupAlertController:weakSelf.deaMachiningOverFee andisSuccess:isSuccess];
                        //                        RSStockViewController * stockVc = [[RSStockViewController alloc]init];
                        //                        stockVc.userID = self.userID;
                        //                        [self.navigationController pushViewController:stockVc animated:YES];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"出货失败"];
                        // [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:weakSelf];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"出货失败"];
                }
            }];
        }else{
            NSMutableArray * array = [NSMutableArray array];
            for (int i = 0; i < self.shopNumberCountArray.count; i++) {
                RSBlockModel *blockmodel = self.shopNumberCountArray[i];
                //                [erpid appendFormat:@"%@",blockmodel.DID];
                [array addObject:blockmodel.DID];
                erpid = [array componentsJoinedByString:@","];
                //erpid = [NSString stringWithFormat:@"%@",blockmodel.DID];
            }
            [phoneDict setObject:self.userID forKey:@"userId"];
            [phoneDict setObject:@"1" forKey:@"erpId"];
            [phoneDict setObject:_phoneTextfield.text forKey:@"phoneCode"];
            [phoneDict setObject:erpid forKey:@"erpDids"];
            [phoneDict setObject:self.outStyle forKey:@"type"];
            [phoneDict setObject:_phoneLabel.text forKey:@"mobilePhone"];
            [phoneDict setObject:self.contact.csnName forKey:@"name"];
            [phoneDict setObject:self.contact.csnPhone forKey:@"phone"];
            //二进制数
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_OUTSTORE_COMMIT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL Result = [json[@"Result"] boolValue];
                    if (Result) {
                     [SVProgressHUD dismiss];
                        //提醒的目的
                        [weakSelf setupAlertController:weakSelf.deaMachiningOverFee andisSuccess:isSuccess];
                        //
                        //                        for (UIViewController *controller in self.navigationController.viewControllers) {
                        //
                        //                            if ([controller isKindOfClass:[RSStockViewController class]]) {
                        //
                        //                                [weakSelf.navigationController popToViewController:controller animated:YES];
                        //                            }
                        //                        }
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"出货失败"];
                        // [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:weakSelf];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"出货失败"];
                }
            }];
        }
    }
}

- (void)setupAlertController:(CGFloat)money andisSuccess:(BOOL)isSuccess{
    if (isSuccess) {
        [SVProgressHUD dismiss];
        RSWeakself
        //deaMachiningOverFee>0 || deaStorageOverFee >10
        if ( money > 50 || (self.deaStorageOverFee + self.deaSlOverFee)> 10)  {
            //系统检测到您有"+erpFee+"元未缴的海西费用,请拨打0595-26588686,联系海西招商部进行处理
            //  NSString * str = [NSString stringWithFormat:@"系统检测到您有%ld元未缴的海西费用,请尽快缴费,有疑问请拨打0595-26588686,联系海西招商部进行处理",(long)money];
            NSString * str = self.feeMsg;
            
            [JHSysAlertUtil presentAlertViewWithTitle:@"温馨提示" message:str confirmTitle:@"确定" handler:^{
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[RSStockViewController class]]) {
                        [weakSelf.navigationController popToViewController:controller animated:YES];
                    }
                }
            }];
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction * actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                for (UIViewController *controller in self.navigationController.viewControllers) {
//                    if ([controller isKindOfClass:[RSStockViewController class]]) {
//                        [weakSelf.navigationController popToViewController:controller animated:YES];
//                    }
//                }
//            }];
//            [alert addAction:actionConfirm];
//            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//                alert.modalPresentationStyle = UIModalPresentationFullScreen;
//            }
//            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
            NSString * str = [NSString stringWithFormat:@"出库成功,请在出库记录中查询订单审批进度"];
            [JHSysAlertUtil presentAlertViewWithTitle:@"温馨提示" message:str confirmTitle:@"确定" handler:^{
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[RSStockViewController class]]) {
                        [weakSelf.navigationController popToViewController:controller animated:YES];
                    }
                }
            }];
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction * actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                for (UIViewController *controller in self.navigationController.viewControllers) {
//                    if ([controller isKindOfClass:[RSStockViewController class]]) {
//                        [weakSelf.navigationController popToViewController:controller animated:YES];
//                    }
//                }
//            }];
//            [alert addAction:actionConfirm];
//            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//               alert.modalPresentationStyle = UIModalPresentationFullScreen;
//            }
//            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"出货失败"];
    }
}



#pragma mark -- 返回到司机的界面
- (void)backDriverViewController{
//    [self removeTime];
    [self.informationview removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
