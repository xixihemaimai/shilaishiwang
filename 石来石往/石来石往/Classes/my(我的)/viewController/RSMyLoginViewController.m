//
//  RSMyLoginViewController.m
//  石来石往
//
//  Created by mac on 2017/9/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMyLoginViewController.h"
//#import "RSLeftViewController.h"
#import "RSLoginViewController.h"

@interface RSMyLoginViewController ()


@end

@implementation RSMyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"ffffff"];
    
    self.title = self.tabBarItem.title;
    
    UIImageView * imageview  = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@"未登录"];
    [self.view addSubview:imageview];
    
    
    UIButton *  loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 4;
    loginBtn.layer.borderWidth = 1;
    loginBtn.layer.borderColor = [UIColor blackColor].CGColor;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(jumpLeftviewController:) forControlEvents:UIControlEventTouchUpInside];
    
    
    imageview.sd_layout
    .centerXEqualToView(self.view)
    .centerYIs(SCH - (SCH/2) - 50)
    .widthIs(200)
    .heightEqualToWidth();
    
    
    
    loginBtn.sd_layout
    .leftEqualToView(imageview)
    .rightEqualToView(imageview)
    .topSpaceToView(imageview, 20)
    .heightIs(40);
}

- (void)jumpLeftviewController:(UIButton *)btn{
  //修改
    RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
    RSMyNavigationViewController * myNavi = [[RSMyNavigationViewController alloc]initWithRootViewController:loginVc];
//    [self.navigationController pushViewController:loginVc animated:YES];
    myNavi.modalPresentationStyle = 0;
    [self presentViewController:myNavi animated:true completion:^{
    }];
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
