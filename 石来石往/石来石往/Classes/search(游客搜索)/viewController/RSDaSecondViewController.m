//
//  RSDaSecondViewController.m
//  石来石往
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDaSecondViewController.h"

@interface RSDaSecondViewController ()

@end

@implementation RSDaSecondViewController
@synthesize userModel = _userModel;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
}

- (NSString *)searchStr{
    return _searchStr;
}

- (RSUserModel *)userModel{
    return _userModel;
}

- (NSString *)searchType{
    return _searchType;
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
