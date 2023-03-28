//
//  RSApplyPersonalViewController.m
//  石来石往
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSApplyPersonalViewController.h"
#import "RSPersonalPackageViewController.h"
#import "RSLoginViewController.h"
#import "RSApplyListViewController.h"
@interface RSApplyPersonalViewController ()

@end

@implementation RSApplyPersonalViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * applyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    applyImageView.userInteractionEnabled = YES;
    applyImageView.image = [UIImage imageNamed:@"字"];
    applyImageView.clipsToBounds = YES;
    [self.view addSubview:applyImageView];
    CGFloat bottomH = 0.0;
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        bottomH = 34.0;
       //applyImageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        bottomH = 0.0;
       //applyImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    //申请历史
//    UIButton * applyHistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [applyHistoryBtn setImage:[UIImage imageNamed:@"申请历史"] forState:UIControlStateNormal];
//    applyHistoryBtn.frame = CGRectMake(53, SCH - 208, SCW -106 , 40);
//   // [applyHistoryBtn setTitle:@"申请历史" forState:UIControlStateNormal];
//    [self.view addSubview:applyHistoryBtn];
//    [applyHistoryBtn bringSubviewToFront:self.view];
//    [applyHistoryBtn addTarget:self action:@selector(applyHistoryAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //申请
    UIButton * applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyBtn setImage:[UIImage imageNamed:@"申请开通"] forState:UIControlStateNormal];
    applyBtn.frame = CGRectMake(53  , SCH - 161 - bottomH, SCW - 106, 40);
    [applyBtn addTarget:self action:@selector(applyPersonalAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:applyBtn];
    [applyBtn bringSubviewToFront:self.view];
    
    //关闭
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(53, CGRectGetMaxY(applyBtn.frame) + 16, SCW - 106, 40);
    [closeBtn addTarget:self action:@selector(closeapplyPersonalAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn bringSubviewToFront:self.view];
}
//申请历史
//- (void)applyHistoryAction:(UIButton *)applyHistoryBtn{
//    RSApplyListViewController * applyListVc = [[RSApplyListViewController alloc]init];
//    [self.navigationController pushViewController:applyListVc animated:YES];
//}
//申请个人账号
- (void)applyPersonalAction:(UIButton *)applyBtn{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1 ) {
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        RSPersonalPackageViewController * personalPackageVc = [[RSPersonalPackageViewController alloc]init];
        personalPackageVc.usermodel = self.usermodel;
        personalPackageVc.ModifyStr = @"new";
        [self.navigationController pushViewController:personalPackageVc animated:YES];
    }
}
//关闭申请个人账号
- (void)closeapplyPersonalAction:(UIButton *)closeBtn{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1 ) {
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }
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
