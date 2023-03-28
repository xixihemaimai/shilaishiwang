//
//  RSRTQPBViewController.m
//  石来石往
//
//  Created by mac on 2021/4/12.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSRTQPBViewController.h"
#import "RSRTQPBCell.h"
#import "RSRTPBHeaderView.h"

static NSString * RTQPBCELLID = @"RTQPBCELLID";
static NSString * RTQPBHEADERID = @"RTQPBHEADERID";
@interface RSRTQPBViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,strong)UITableView * tableview;

@end

@implementation RSRTQPBViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"实时查询商户应付余额表";
    
    UIView * searchView = [[UIView alloc]init];
    searchView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCW, 65);
    searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:searchView];
    
    UISearchBar * searchBar = [[UISearchBar alloc]init];
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(12, 12, SCW - 63, 40);
    searchBar.placeholder = @"请输入您要查找的费用类型";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [searchView addSubview:searchBar];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(CGRectGetMaxX(searchBar.frame) + 17.5, 0, 31, 65);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchView addSubview:searchBtn];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(searchView.frame), SCW, SCH - CGRectGetMaxY(searchView.frame)) style:UITableViewStylePlain];
    [self.tableview registerClass:[RSRTQPBCell class] forCellReuseIdentifier:RTQPBCELLID];
    [self.tableview registerClass:[RSRTPBHeaderView class] forHeaderFooterViewReuseIdentifier:RTQPBHEADERID];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.estimatedRowHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSRTPBHeaderView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:RTQPBHEADERID];
    return header;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSRTQPBCell * cell = [tableView dequeueReusableCellWithIdentifier:RTQPBCELLID];
    if (indexPath.row % 2 == 0) {
        
        cell.showView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }else{
        cell.showView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:250/255.0 alpha:1.0];
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"=================%@",searchBar.text);
}







@end
