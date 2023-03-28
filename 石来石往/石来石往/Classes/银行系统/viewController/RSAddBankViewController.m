//
//  RSAddBankViewController.m
//  石来石往
//
//  Created by mac on 2021/4/12.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSAddBankViewController.h"

//下一步添加银行卡
#import "RSBankInfomationViewController.h"


@interface RSAddBankViewController ()

//持卡人
@property (nonatomic,strong)UITextField * moneyTextfiled;
//
@property (nonatomic,strong)UITextField * currentTextfiled;

@end

@implementation RSAddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加银行卡";
    self.view.layer.backgroundColor = [UIColor colorWithRed:247/255.0 green:245/255.0 blue:246/255.0 alpha:1.0].CGColor;
    
    [self setUI];
    
}

- (void)setUI{
    
    //UIView
    UIView * contentView = [[UIView alloc]init];
    contentView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCW, 200);
    contentView.backgroundColor = [UIColor colorWithHexString:@"#F7F5F6"];
    [self.view addSubview:contentView];
    //输入您支付金额
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(15, 16.5, SCW - 30, 20);
    titleLabel.text = @"请输入您银行卡信息";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [contentView addSubview:titleLabel];
    //总应支付金额
    UIView * totalView = [[UIView alloc]init];
    totalView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 7, SCW, 49);
    totalView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [contentView addSubview:totalView];
    
    UILabel * totalTitleLabel = [[UILabel alloc]init];
    totalTitleLabel.frame = CGRectMake(15, 13.5, 100, 22.5);
    totalTitleLabel.text = @"持卡人";
    totalTitleLabel.font = [UIFont systemFontOfSize:16];
    totalTitleLabel.textAlignment = NSTextAlignmentLeft;
    totalTitleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [totalView addSubview:totalTitleLabel];
    
    UITextField * moneyTextfiled = [[UITextField alloc]init];
    moneyTextfiled.frame = CGRectMake(CGRectGetMaxX(totalTitleLabel.frame) + 23, 13.5, SCW - CGRectGetMaxX(totalTitleLabel.frame) - 23, 22.5);
    moneyTextfiled.placeholder = @"请输入持卡人名字";
    moneyTextfiled.textAlignment = NSTextAlignmentLeft;
    moneyTextfiled.font = [UIFont systemFontOfSize:16];
    moneyTextfiled.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [totalView addSubview:moneyTextfiled];
    _moneyTextfiled = moneyTextfiled;
    
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#E8E8E8"];
    midView.frame = CGRectMake(0, 48, SCW, 1);
    [totalView addSubview:midView];
    //现支付金额
    UIView * currentView = [[UIView alloc]init];
    currentView.frame = CGRectMake(0, CGRectGetMaxY(totalView.frame), SCW, 49);
    currentView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [contentView addSubview:currentView];
    
    UILabel * currentTitleLabel = [[UILabel alloc]init];
    currentTitleLabel.frame = CGRectMake(15, 13.5, 100, 22.5);
    currentTitleLabel.text = @"卡 号";
    currentTitleLabel.font = [UIFont systemFontOfSize:16];
    currentTitleLabel.textAlignment = NSTextAlignmentLeft;
    currentTitleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [currentView addSubview:currentTitleLabel];
    
    UITextField * currentTextfiled = [[UITextField alloc]init];
    currentTextfiled.frame = CGRectMake(CGRectGetMaxX(currentTitleLabel.frame) + 23, 13.5, SCW - CGRectGetMaxX(currentTitleLabel.frame) - 23, 22.5);
    currentTextfiled.placeholder = @"请输入银行卡号";
    currentTextfiled.textAlignment = NSTextAlignmentLeft;
    currentTextfiled.font = [UIFont systemFontOfSize:16];
    currentTextfiled.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [currentView addSubview:currentTextfiled];
    _currentTextfiled = currentTextfiled;
    //确定支付
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(15, CGRectGetMaxY(currentView.frame) + 20, SCW - 30, 50);
    nextBtn.layer.cornerRadius = 12;
    [nextBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFEFF"]];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:nextBtn];
}

//下一步添加银行卡
- (void)nextAction:(UIButton *)nextBtn{
//    if (_moneyTextfiled.text.length > 0 && _currentTextfiled.text.length > 0) {
        RSBankInfomationViewController * bankInfomationVc = [[RSBankInfomationViewController alloc]init];
        [self.navigationController pushViewController:bankInfomationVc animated:true];
//    }else{
//        [SVProgressHUD showErrorWithStatus:@"请输入持卡人和卡号"];
//    }
}


@end
