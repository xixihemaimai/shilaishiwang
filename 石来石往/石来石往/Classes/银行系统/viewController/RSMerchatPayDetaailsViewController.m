//
//  RSMerchatPayDetaailsViewController.m
//  石来石往
//
//  Created by mac on 2021/4/13.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSMerchatPayDetaailsViewController.h"
#import "RSMerchatPayHeeaderView.h"

#import "RSMerchatPayCell.h"

static NSString * MERCHATPAYHEADERVIEW = @"RSMerchatPayHeeaderView";
static NSString * MERCHATPAYCELLID = @"RSMerchatPayCell";
@interface RSMerchatPayDetaailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableview;


@end

@implementation RSMerchatPayDetaailsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
   [super viewDidLoad];
   
    self.title = @"商户付款明细表";
    
    UIView * payDetailView = [[UIView alloc]init];
    payDetailView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCW, 64);
    payDetailView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:payDetailView];
    
    
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString * dateStr = [formatter stringFromDate:date];
    
    UIButton * beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    beginBtn.frame = CGRectMake(12, 14, 127, 36);
    beginBtn.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:250/255.0 alpha:1.0];
    [beginBtn setTitleColor:[UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0] forState:UIControlStateNormal];
    beginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [beginBtn addTarget:self action:@selector(beginAction:) forControlEvents:UIControlEventTouchUpInside];
    [beginBtn setTitle:dateStr forState:UIControlStateNormal];
    [payDetailView addSubview:beginBtn];
    beginBtn.layer.cornerRadius = 20;
    
    
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#D8D8D8"];
    midView.frame = CGRectMake(CGRectGetMaxX(beginBtn.frame) + 16.5, 64/2 - 1.5/2, 20, 1.5);
    [payDetailView addSubview:midView];
    
    
    UIButton * endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endBtn.frame = CGRectMake(CGRectGetMaxX(midView.frame) + 15.5, 14, 127, 36);
    [endBtn addTarget:self action:@selector(endAction:) forControlEvents:UIControlEventTouchUpInside];
    endBtn.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:250/255.0 alpha:1.0];
    [endBtn setTitleColor:[UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0] forState:UIControlStateNormal];
    endBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [endBtn setTitle:dateStr forState:UIControlStateNormal];
    [payDetailView addSubview:endBtn];
    endBtn.layer.cornerRadius = 20;
    
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(CGRectGetMaxX(endBtn.frame) + 17.5,0, 31, 64);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [payDetailView addSubview:searchBtn];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(payDetailView.frame), SCW, SCH - CGRectGetMaxY(payDetailView.frame)) style:UITableViewStylePlain];
    [self.tableview registerClass:[RSMerchatPayCell class] forCellReuseIdentifier:MERCHATPAYCELLID];
    [self.tableview registerClass:[RSMerchatPayHeeaderView class] forHeaderFooterViewReuseIdentifier:MERCHATPAYHEADERVIEW];
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
    RSMerchatPayHeeaderView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:MERCHATPAYHEADERVIEW];
    return header;
}
//
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSMerchatPayCell * cell = [tableView dequeueReusableCellWithIdentifier:MERCHATPAYCELLID];
    if (indexPath.row % 2 == 0) {
        
        cell.showView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }else{
        
        cell.showView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:250/255.0 alpha:1.0];
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



//开始时间
- (void)beginAction:(UIButton *)beginBtn{
   WSDatePickerView * beginDate = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
       //开始时间
    }];
    [beginDate show];
}

//结束时间
- (void)endAction:(UIButton *)endBtn{
   WSDatePickerView * endDate = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
        //结束时间
    }];
    [endDate show];
}


@end
