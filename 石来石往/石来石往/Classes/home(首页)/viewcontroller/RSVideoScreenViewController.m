//
//  RSVideoScreenViewController.m
//  石来石往
//
//  Created by mac on 2018/10/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSVideoScreenViewController.h"

@interface RSVideoScreenViewController ()

@property (nonatomic, strong) SJVideoPlayer *player;

@property (nonatomic, strong) UIButton *button;

@end

@implementation RSVideoScreenViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setupViews];

    _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithTitle:self.title URL:self.outPutUrl playModel:[SJPlayModel new]];
    _player.URLAsset.title = self.title;

    _player.rotationManager.disabledAutorotation = NO;
}

- (UIButton *)button {
    if ( _button )  return _button;
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.backgroundColor = [UIColor clearColor];
    //[_button setTitle:@"全屏, 但不旋转" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    return _button;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
//    self.navigationController.navigationBar.hidden = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return YES;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (void)_setupViews {

    _player = [SJVideoPlayer lightweightPlayer];
    [self.view addSubview:_player.view];
    
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(12);
        make.top.offset(10);
        make.width.offset(30);
    }];
    
    
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.leading.trailing.top.bottom.offset(0);
    }];
    

}



- (void)clickedButton:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
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
