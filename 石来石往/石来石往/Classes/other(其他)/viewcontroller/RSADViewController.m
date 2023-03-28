//
//  RSADViewController.m
//  石来石往
//
//  Created by mac on 2018/10/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSADViewController.h"
#import "RSMainTabBarViewController.h"

@interface RSADViewController ()

@property (strong, nonatomic) UIImageView *adImage;
@property (strong, nonatomic) UIView *adView;
@property (strong, nonatomic) UIButton *jumpBtn;
@property (nonatomic,strong)NSTimer *timer;

@end

@implementation RSADViewController

- (UIImageView *)adImage{
    if (!_adImage) {
        _adImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
        _adImage.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        _adImage.userInteractionEnabled = YES;
    }
    return _adImage;
}

- (UIView *)adView{
    if (!_adView ) {
        _adView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
        _adView.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
    }
    return _adView;
}

- (UIButton *)jumpBtn{
    if (!_jumpBtn) {
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jumpBtn.frame = CGRectMake(SCW - 130, 40, 90, 30);
        [_jumpBtn setTitle:@"3s跳转" forState:UIControlStateNormal];
        _jumpBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_jumpBtn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jumpBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.adView];
    [self.adView addSubview:self.adImage];
    [self.adImage addSubview:self.jumpBtn];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(jumpClick) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self setload];
}

- (void)jumpClick{
    static int i = 3;
    if (i < 1) {
        return [self jump:nil];
    }
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"%ds跳转",i] forState:UIControlStateNormal];
    i--;
}

- (void)setload{
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETSTARTADVERTISEMENT_IOS withParameters:nil withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [weakSelf.adImage sd_setImageWithURL:[NSURL URLWithString:json[@"Data"][@"startAdvertisementImg"]] placeholderImage:[UIImage imageNamed:@""]];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


- (void)jump:(UIButton *)sender {
    [self.timer invalidate];
    self.timer = nil;
    [[UITabBar appearance]setTintColor:[UIColor colorWithRed:41/255.0 green:51/255.0 blue:65/255.0 alpha:1]];
    RSMainTabBarViewController * mainTabbarVc = [[RSMainTabBarViewController alloc]init];
    //mainTabbarVc.delegate = self;
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    applegate.mainTabbarVc = mainTabbarVc;
    applegate.window.rootViewController = mainTabbarVc;
//    mainTabbarVc.delegate = applegate;
}

@end
