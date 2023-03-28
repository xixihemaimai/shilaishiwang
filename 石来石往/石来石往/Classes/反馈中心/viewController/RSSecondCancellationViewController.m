//
//  RSSecondCancellationViewController.m
//  石来石往
//
//  Created by mac on 2022/9/16.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSSecondCancellationViewController.h"

@interface RSSecondCancellationViewController ()

@end

@implementation RSSecondCancellationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账号注销";
    
    UILabel * titleAlertLabel = [[UILabel alloc]init];
    titleAlertLabel.text = @"账号注销";
    titleAlertLabel.textAlignment = NSTextAlignmentCenter;
    titleAlertLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    titleAlertLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    [self.view addSubview:titleAlertLabel];
    
    titleAlertLabel.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 30).heightIs(30);
    
    UILabel * alertLabel = [[UILabel alloc]init];
    alertLabel.text = @"以下信息将被情况且无法找回";
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    alertLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    [self.view addSubview:alertLabel];
    
    alertLabel.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(titleAlertLabel, 10).heightIs(40);
    
    
    
    UIView * centerView = [[UIView alloc]init];
    centerView.backgroundColor = [UIColor colorWithHexColorStr:@"#f7f7f7"];
    [self.view addSubview:centerView];
    
    centerView.sd_layout.centerYEqualToView(self.view).centerXEqualToView(self.view).widthIs(SCW - 32).heightIs(260);
    
    
    UILabel * centerContentLabel = [[UILabel alloc]init];
    centerContentLabel.textColor = [UIColor colorWithHexColorStr:@"#d7d7d7"];
    centerContentLabel.textAlignment = NSTextAlignmentLeft;
    centerContentLabel.font = [UIFont systemFontOfSize:15];
    centerContentLabel.numberOfLines = 0;
    [centerView addSubview:centerContentLabel];
    
    centerContentLabel.sd_layout.leftSpaceToView(centerView, 16).rightSpaceToView(centerView, 16).topSpaceToView(centerView, 10).bottomSpaceToView(centerView, 10);
    centerContentLabel.text = @"身份,账号信息\n交易记录\n个人隐私信息\n会员红包,奖励金\n\n\n\n----------------------------------------\n请先确保所有交易已完结且无纠纷,账号删除后的历史记录可能产生资金退回权益等将视作自动放弃";
    

    UIButton * applyCancellationBtn = [[UIButton alloc]init];
    [applyCancellationBtn setTitle:@"确定注销" forState:UIControlStateNormal];
    [applyCancellationBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    applyCancellationBtn.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    [applyCancellationBtn addTarget:self action:@selector(applyCancellationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:applyCancellationBtn];
    
    applyCancellationBtn.sd_layout.centerXEqualToView(self.view).widthIs(160).heightIs(45).topSpaceToView(centerView, 100);
    
    applyCancellationBtn.layer.cornerRadius = 5;
    applyCancellationBtn.layer.masksToBounds = true;
    
}


- (void)applyCancellationAction:(UIButton *)btn{
    
    [JHSysAlertUtil presentAlertViewWithTitle:@"确定注销账号吗?" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:true cancel:^{
            
        } confirm:^{
            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
               NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
               NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
               AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
               NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
               RSWeakself;
               XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
               [network getDataWithUrlString:URL_CANCELLATION_CONFIRMM_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                   if(success){
                       BOOL isresult = [json[@"success"]boolValue];
                       if (isresult) {
                           //    [self.navigationController popToRootViewControllerAnimated:true];
                               [UserManger logoOut];
                               NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                               [user removeObjectForKey:@"VERIFYKEY"];
                               AppDelegate *applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                               applegate.ERPID = @"0";
                                   // 必须先把根控制器modal出来的控制器dismiss掉再重设根控制器 不然之前的根控制器会释放不掉
                               [applegate.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
                               applegate.window.rootViewController = nil;
                               RSMainTabBarViewController * mainTabbarVc = [[RSMainTabBarViewController alloc]init];
                               applegate.window.rootViewController = mainTabbarVc;
                               mainTabbarVc.selectedIndex = 0;
                       }else{
                           [SVProgressHUD showErrorWithStatus:@"申请注销失败"];
                       }
                   }else{
                       [SVProgressHUD showErrorWithStatus:@"申请注销失败"];
                   }
               }];
        }];
}



@end
