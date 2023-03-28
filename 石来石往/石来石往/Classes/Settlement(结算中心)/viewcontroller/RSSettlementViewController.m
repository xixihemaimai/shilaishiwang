//
//  RSSettlementViewController.m
//  石来石往
//
//  Created by mac on 17/5/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSettlementViewController.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "Order.h"
//#import "RSADataSigner.h"

@interface RSSettlementViewController ()
{
    UIView *_navigationview;
    /**应付金额*/
    UITextField * _inputMoneyTextfield;
    
    //显示货主有多少钱
    UITextField * _productTextfield;
    
    
}
/**获取货主有多少钱*/
@property (nonatomic,strong)NSString * moneyStr;


@end

@implementation RSSettlementViewController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"支付";
    
    
     [self obtainOwnerMoney];
    
    
    //自定义内容视图
    [self addCustomView];
    
    
    
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
    
    //URL_ERPFEE_IOS URL_ERPFEE
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_ERPFEE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        
        if (success) {
            //BOOL Result = [json[@"Result"] boolValue];
            if ([json[@"MSG_CODE"] isEqualToString:@"OK"]) {
                
                
                weakSelf.moneyStr = json[@"Data"][@"deabalance"];
                
                
                _productTextfield.text = [NSString stringWithFormat:@"%@",weakSelf.moneyStr];
                
                
            
            }
        }
    }];
}




- (void)addCustomView{
    
    UIView * contentview = [[UIView alloc]init];
    [self.view addSubview:contentview];
    
    contentview.backgroundColor = [UIColor whiteColor];
    
    CGFloat Y;
    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
        Y = 64;
    }else{
        Y = 88;
    }
    
    

    contentview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,Y)
    .heightIs(200);
    
    UIView * productview = [[UIView alloc]init];
    productview.backgroundColor = [UIColor whiteColor];
    [contentview addSubview:productview];
    productview.sd_layout
    .topSpaceToView(contentview,10)
    .leftSpaceToView(contentview,0)
    .rightSpaceToView(contentview,0)
    .heightIs(30);
    
    
    
    UILabel *productLabel = [[UILabel alloc]init];
    productLabel.text = @"海西费用:";
    productLabel.font = [UIFont systemFontOfSize:12];
    productLabel.textColor = [UIColor blackColor];
    [productview addSubview:productLabel];
    
    
    
    productLabel.sd_layout
    .leftSpaceToView(productview,12)
    .centerYEqualToView(productview)
    .widthIs(55)
    .heightIs(20);
    
    UITextField * productTextfield = [[UITextField alloc]init];
    productTextfield.borderStyle = UITextBorderStyleNone;
    //productTextfield.text = self.moneyStr;
    _productTextfield = productTextfield;
    
    
    productTextfield.font = [UIFont systemFontOfSize:12];
    productTextfield.textColor = [UIColor darkGrayColor];
    [productview addSubview:productTextfield];
    
    productTextfield.sd_layout
    .leftSpaceToView(productLabel,10)
    .rightSpaceToView(productview,12)
    .topEqualToView(productLabel)
    .bottomEqualToView(productLabel)
    .centerYEqualToView(productview);
    
    
    UIView *productBottomview = [[UIView alloc]init];
    productBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
    [productview addSubview:productBottomview];
    
    productBottomview.sd_layout
    .leftSpaceToView(productview,12)
    .rightSpaceToView(productview,12)
    .bottomSpaceToView(productview,0)
    .heightIs(1);
    
    UIView * moneyview = [[UIView alloc]init];
    moneyview.backgroundColor = [UIColor whiteColor];
    [contentview addSubview:moneyview];
    moneyview.sd_layout
    .topSpaceToView(productview,0)
    .leftSpaceToView(contentview,0)
    .rightSpaceToView(contentview,0)
    .heightIs(30);
    
    
    
    UILabel *moneyLabel = [[UILabel alloc]init];
    moneyLabel.text = @"收款方:";
    moneyLabel.font = [UIFont systemFontOfSize:12];
    moneyLabel.textColor = [UIColor blackColor];
    [moneyview addSubview:moneyLabel];
    
    moneyLabel.sd_layout
    .leftSpaceToView(moneyview,12)
    .centerYEqualToView(moneyview)
    .widthIs(55)
    .heightIs(20);
    
    UITextField * moneyTextfield = [[UITextField alloc]init];
    moneyTextfield.borderStyle = UITextBorderStyleNone;
    moneyTextfield.text = @"海西股份";
    moneyTextfield.font = [UIFont systemFontOfSize:12];
    moneyTextfield.textColor = [UIColor darkGrayColor];
    [moneyview addSubview:moneyTextfield];
    
    moneyTextfield.sd_layout
    .leftSpaceToView(moneyLabel,10)
    .rightSpaceToView(moneyview,12)
    .topEqualToView(moneyLabel)
    .bottomEqualToView(moneyLabel)
    .centerYEqualToView(moneyview);
    
    
    UIView *moneyBottomview = [[UIView alloc]init];
    moneyBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
    [moneyview addSubview:moneyBottomview];
    
    moneyBottomview.sd_layout
    .leftSpaceToView(moneyview,12)
    .rightSpaceToView(moneyview,12)
    .bottomSpaceToView(moneyview,0)
    .heightIs(1);
    
    
    
    
    UIView * inputMoneyview = [[UIView alloc]init];
    inputMoneyview.backgroundColor = [UIColor whiteColor];
    [contentview addSubview:inputMoneyview];
    inputMoneyview.sd_layout
    .topSpaceToView(moneyview,0)
    .leftSpaceToView(contentview,0)
    .rightSpaceToView(contentview,0)
    .heightIs(30);
    
    
    
    UILabel *inputMoneyLabel = [[UILabel alloc]init];
    inputMoneyLabel.text = @"应付金额:";
    inputMoneyLabel.font = [UIFont systemFontOfSize:12];
    inputMoneyLabel.textColor = [UIColor blackColor];
    [inputMoneyview addSubview:inputMoneyLabel];
    
    inputMoneyLabel.sd_layout
    .leftSpaceToView(inputMoneyview,12)
    .centerYEqualToView(inputMoneyview)
    .widthIs(55)
    .heightIs(20);
    
    UITextField * inputMoneyTextfield = [[UITextField alloc]init];
    inputMoneyTextfield.borderStyle = UITextBorderStyleNone;
    inputMoneyTextfield.placeholder = @"请输入缴费金额";
    inputMoneyTextfield.font = [UIFont systemFontOfSize:12];
    inputMoneyTextfield.textColor = [UIColor darkGrayColor];
    [inputMoneyview addSubview:inputMoneyTextfield];
    _inputMoneyTextfield = inputMoneyTextfield;
    inputMoneyTextfield.sd_layout
    .leftSpaceToView(inputMoneyLabel,10)
    .rightSpaceToView(inputMoneyview,12)
    .topEqualToView(inputMoneyLabel)
    .bottomEqualToView(inputMoneyLabel)
    .centerYEqualToView(inputMoneyview);
    
    
    UIView *inputMoneyBottomview = [[UIView alloc]init];
    inputMoneyBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
    [inputMoneyview addSubview:inputMoneyBottomview];
    
    inputMoneyBottomview.sd_layout
    .leftSpaceToView(inputMoneyview,12)
    .rightSpaceToView(inputMoneyview,12)
    .bottomSpaceToView(inputMoneyview,0)
    .heightIs(1);

    
    
    UIView * inputStyleview = [[UIView alloc]init];
    inputStyleview.backgroundColor = [UIColor whiteColor];
    [contentview addSubview:inputStyleview];
    
    inputStyleview.sd_layout
    .topSpaceToView(inputMoneyview,0)
    .leftSpaceToView(contentview,0)
    .rightSpaceToView(contentview,0)
    .heightIs(30);
    

    
    UILabel *inputStyleLabel = [[UILabel alloc]init];
    inputStyleLabel.text = @"支付方式:";
    inputStyleLabel.font = [UIFont systemFontOfSize:12];
    inputStyleLabel.textColor = [UIColor blackColor];
    [inputStyleview addSubview:inputStyleLabel];
    
    inputStyleLabel.sd_layout
    .leftSpaceToView(inputStyleview,12)
    .centerYEqualToView(inputStyleview)
    .widthIs(55)
    .heightIs(20);
    
    UIImageView * inputStyleimage = [[UIImageView alloc]init];
    inputStyleimage.image = [UIImage imageNamed:@"zhifubao"];
    
    [inputStyleview addSubview:inputStyleimage];
    
    inputStyleimage.sd_layout
    .leftSpaceToView(inputStyleLabel,10)
    .widthIs(80)
    .topEqualToView(inputStyleLabel)
    .bottomEqualToView(inputStyleLabel)
    .centerYEqualToView(inputStyleview);
    
    
    UIView *inputStyleBottomview = [[UIView alloc]init];
    inputStyleBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
    [inputStyleview addSubview:inputStyleBottomview];
    
    inputStyleBottomview.sd_layout
    .leftSpaceToView(inputStyleview,12)
    .rightSpaceToView(inputStyleview,12)
    .bottomSpaceToView(inputStyleview,0)
    .heightIs(1);
    
    
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
    [sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn setTintColor:[UIColor whiteColor]];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentview addSubview:sureBtn];
    sureBtn.sd_layout
    .topSpaceToView(inputStyleview,20)
    .bottomSpaceToView(contentview,10)
    .rightSpaceToView(contentview,12)
    .leftSpaceToView(contentview,12);
}


#pragma mark -- 确认支付
- (void)sureBtnClick:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"该支付功能还没有进行开放，会在后续的版本中进行开放" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                           alert.modalPresentationStyle = UIModalPresentationFullScreen;
                       }
    [self presentViewController:alert animated:YES completion:nil];
    
    //用 UITextField * inputMoneyTextfield这里来进行支付的多少
    //URL_PAY_HAIXI_LIST
    
   
}


#pragma mark -- 输入金额，点击支付之后的方法，现在有点问题，在后续的版本进行修复
//- (void)inputMoney{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//
//
//    [dict setObject:_inputMoneyTextfield.text forKey:@"fee"];
//    [dict setObject:@"1" forKey:@"mactype"];
//
//
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_PAY_HAIXI_LIST withParameters:parameters withBlock:^(id json, BOOL success) {
//
//        if (success) {
//
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//
////                [self doAlipayPay:json[@"Data"]];
//            }
//        }
//    }];
//}


#pragma mark -- 这边进行调用支付宝的地方
//- (void)doAlipayPay:(NSDictionary *)dict
//{
//
//     NSString *appScheme = @"slsw";
//     NSString *signedString = [dict valueForKey:@"sign"];
//    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+ $,./?%#[]"] invertedSet];
//
//    NSString * newSignStr = [signedString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
//
//
//
////    // NOTE: 如果加签成功，则继续执行支付
//    if (newSignStr != nil) {
//        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
//
//        NSString * orderSpec = [NSString stringWithFormat:@"%@&sign=\"%@\"",dict[@"orderInfo"],newSignStr];
//
//
//
//       // orderSpec = [orderSpec stringByReplacingOccurrencesOfString:@"," withString:@""];
//        //orderSpec = [orderSpec stringByReplacingOccurrencesOfString:@":" withString:@""];
//
//      // orderSpec = [orderSpec stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//
//
//        // NOTE: 调用支付结果开始支付
//        [[AlipaySDK defaultService] payOrder:orderSpec fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            //NSLog(@"reslut = %@",resultDic);
//            //[[[UIApplication sharedApplication] windows] objectAtIndex:0];
//            [self getAliPayResuly:resultDic];
//
//        }];
//    }
//}
//
//#pragma mark -- 支付结果
//-(void)getAliPayResuly:(NSDictionary *)resultDic{
//    if ([resultDic[@"resultStatus"]isEqual:@"6001"])
//    {
//        //[[RSMessageView shareMessageView] showMessageWithType:RSLocal(@"支付取消") messageType:kRSMessageTypeDefault];
//        [SVProgressHUD showErrorWithStatus:@"支付取消"];
//    }
//
//    else if ([resultDic[@"resultStatus"]isEqual:@"4000"])
//    {
////        [[RSMessageView shareMessageView] showMessageWithType:RSLocal(@"订单支付失败") messageType:kRSMessageTypeDefault];
//
//        [SVProgressHUD showErrorWithStatus:@"订单支付失败"];
//
//    }
//    else if ([resultDic[@"resultStatus"]isEqual:@"8000"])
//    {
////        [[RSMessageView shareMessageView] showMessageWithType:RSLocal(@"正在处理中") messageType:kRSMessageTypeDefault];
//
//        [SVProgressHUD showSuccessWithStatus:@"正在处理中"];
//    }
//    else if ([resultDic[@"resultStatus"]isEqual:@"6002"])
//    {
////        [[RSMessageView shareMessageView] showMessageWithType:RSLocal(@"网络链接错误") messageType:kRSMessageTypeDefault];
//        [SVProgressHUD showErrorWithStatus:@"网络链接错误"];
//    }
//
//}





//// 生成订单号
//- (NSString *)generateTradeNO
//{
//    static int kNumber = 15;
//    
//    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//    NSMutableString *resultStr = [[NSMutableString alloc] init];
//    srand((unsigned)time(0));
//    for (int i = 0; i < kNumber; i++)
//    {
//        unsigned index = rand() % [sourceStr length];
//        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
//        [resultStr appendString:oneStr];
//    }
//    return resultStr;
//}



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
