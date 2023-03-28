//
//  RSAccountAndSafeViewController.m
//  石来石往
//
//  Created by mac on 2022/9/16.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSAccountAndSafeViewController.h"
#import "RSAccountAndSafeCell.h"
#import "RSFirstCancellationViewController.h"

@interface RSAccountAndSafeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RSAccountAndSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号与安全";
    [self.view addSubview:self.tableview];
    self.tableview.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.tableview registerClass:[RSAccountAndSafeCell class] forCellReuseIdentifier:@"RSAccountAndSafeCell"];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSAccountAndSafeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RSAccountAndSafeCell"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    RSFirstCancellationViewController * firstCancellationVc = [[RSFirstCancellationViewController alloc]init];
    [self.navigationController pushViewController:firstCancellationVc animated:true];
    
    
}






@end
