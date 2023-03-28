//
//  RSBankViewController.m
//  石来石往
//
//  Created by mac on 2021/4/12.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSBankViewController.h"
#import "RSBankCell.h"

//添加银行卡
#import "RSAddBankViewController.h"


static NSString * BANKCELLID = @"BANKCELLID";
@interface RSBankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableview;



@end

@implementation RSBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡";
    
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:245/255.0 blue:246/255.0 alpha:1.0];
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCW, SCH - CGRectGetMaxY(self.navigationController.navigationBar.frame)) style:UITableViewStylePlain];
//    self.tableview.backgroundColor = [UIColor colorWithRed:247/255.0 green:245/255.0 blue:246/255.0 alpha:1.0];
    tableview.backgroundColor = self.view.backgroundColor;
    self.tableview = tableview;
    [self.tableview registerClass:[RSBankCell class] forCellReuseIdentifier:BANKCELLID];
    self.tableview.estimatedRowHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    [self addTableFootView];
}


- (void)addTableFootView{
    
    UIView * footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F5F6"];
    footView.frame = CGRectMake(0, 0, SCW, 70);
    
    UIButton * addBankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBankBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [addBankBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
    [addBankBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
    addBankBtn.frame = CGRectMake(15, 20, SCW - 30, 50);
    [addBankBtn addTarget:self action:@selector(addBankAcion:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:addBankBtn];
    addBankBtn.layer.cornerRadius = 12;
    self.tableview.tableFooterView = footView;
}

//添加银行卡界面
- (void)addBankAcion:(UIButton *)addBankBtn{
    RSAddBankViewController * addBankVc = [[RSAddBankViewController alloc]init];
    [self.navigationController pushViewController:addBankVc animated:true];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 167;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSBankCell * cell = [tableView dequeueReusableCellWithIdentifier:BANKCELLID];
    return cell;
}


@end
