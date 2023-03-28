//
//  RSDetailsOfMachiningViewController.m
//  石来石往
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSDetailsOfMachiningViewController.h"

@interface RSDetailsOfMachiningViewController ()

@end

@implementation RSDetailsOfMachiningViewController
- (NSString *)businesstype{
    return @"加工";
}
- (NSString *)datefrom{
    return _datefrom;
}

- (NSString *)dateto{
    return _dateto;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
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
