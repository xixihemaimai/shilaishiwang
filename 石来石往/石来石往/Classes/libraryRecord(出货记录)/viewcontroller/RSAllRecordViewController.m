//
//  RSAllRecordViewController.m
//  石来石往
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAllRecordViewController.h"

@interface RSAllRecordViewController ()

@end

@implementation RSAllRecordViewController

- (YJTopicType)type
{
    // 返回部分发货数据
    return YJTopicTypeAll;
}


-(RSUserModel *)usermodel{
    return _usermodel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
