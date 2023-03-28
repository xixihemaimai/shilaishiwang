//
//  RSALLMessageViewController.m
//  石来石往
//
//  Created by mac on 2017/11/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSALLMessageViewController.h"

@interface RSALLMessageViewController ()

@end

@implementation RSALLMessageViewController

@synthesize userModel = _userModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}


//- (NSString *)tempStyle{
//     
//    return _tempStyle;
//}

- (RSUserModel *)userModel{

    return _userModel;
}

//- (BOOL)isOwner{
//    return _isOwner;
//}
//
//- (BOOL)isLogin{
//    return _isLogin;
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
