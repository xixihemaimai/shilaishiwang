//
//  RSPaymentCompleteViewController.m
//  石来石往
//
//  Created by mac on 2021/4/12.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSPaymentCompleteViewController.h"

@interface RSPaymentCompleteViewController ()

@end

@implementation RSPaymentCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    titleLabel.text = @"请输入您支付金额";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [contentView addSubview:titleLabel];
    
    
    //选择卡号
    //总应支付金额
    UIView * cordView = [[UIView alloc]init];
    cordView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 7, SCW, 49);
    cordView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [contentView addSubview:cordView];
    
    UILabel * cardLabel = [[UILabel alloc]init];
    cardLabel.frame = CGRectMake(15, 13.5, 100, 22.5);
    cardLabel.text = @"卡 号";
    cardLabel.font = [UIFont systemFontOfSize:16];
    cardLabel.textAlignment = NSTextAlignmentLeft;
    cardLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [cordView addSubview:cardLabel];
    
    UIButton * cardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cardBtn.frame = CGRectMake(CGRectGetMaxX(cardLabel.frame) + 7, 0, SCW - CGRectGetMaxX(cardLabel.frame) - 7,49);
    [cardBtn addTarget:self action:@selector(choiceCardAction:) forControlEvents:UIControlEventTouchUpInside];
    [cardBtn setTitle:@"**** **** **** 888" forState:UIControlStateNormal];
    cardBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    cardBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cardBtn setTitleColor: [UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    [cordView addSubview:cardBtn];
    
    //总应支付金额
    UIView * totalView = [[UIView alloc]init];
    totalView.frame = CGRectMake(0, CGRectGetMaxY(cordView.frame) + 1, SCW, 49);
    totalView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [contentView addSubview:totalView];
    
    UILabel * totalTitleLabel = [[UILabel alloc]init];
    totalTitleLabel.frame = CGRectMake(15, 13.5, 100, 22.5);
    totalTitleLabel.text = @"总应支付金额";
    totalTitleLabel.font = [UIFont systemFontOfSize:16];
    totalTitleLabel.textAlignment = NSTextAlignmentLeft;
    totalTitleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [totalView addSubview:totalTitleLabel];
    
    UILabel * totalMoneyLabel = [[UILabel alloc]init];
    totalMoneyLabel.frame = CGRectMake(CGRectGetMaxX(totalTitleLabel.frame) + 23, 13.5, SCW - CGRectGetMaxX(totalTitleLabel.frame) - 23, 22.5);
    totalMoneyLabel.text = @"837838738元";
    totalMoneyLabel.font = [UIFont systemFontOfSize:16];
    totalMoneyLabel.textAlignment = NSTextAlignmentLeft;
    totalMoneyLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [totalView addSubview:totalMoneyLabel];
   
    //现支付金额
    UIView * currentView = [[UIView alloc]init];
    currentView.frame = CGRectMake(0, CGRectGetMaxY(totalView.frame) + 1, SCW, 49);
    currentView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [contentView addSubview:currentView];
    
    UILabel * currentTitleLabel = [[UILabel alloc]init];
    currentTitleLabel.frame = CGRectMake(15, 13.5, 100, 22.5);
    currentTitleLabel.text = @"现支付金额";
    currentTitleLabel.font = [UIFont systemFontOfSize:16];
    currentTitleLabel.textAlignment = NSTextAlignmentLeft;
    currentTitleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [currentView addSubview:currentTitleLabel];
    
    UITextField * currentTextfiled = [[UITextField alloc]init];
    currentTextfiled.frame = CGRectMake(CGRectGetMaxX(currentTitleLabel.frame) + 23, 13.5, SCW - CGRectGetMaxX(currentTitleLabel.frame) - 23, 22.5);
    currentTextfiled.placeholder = @"最低支付200000元";
    currentTextfiled.textAlignment = NSTextAlignmentLeft;
    currentTextfiled.font = [UIFont systemFontOfSize:16];
    currentTextfiled.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [currentView addSubview:currentTextfiled];
    //确定支付
    
    UIButton * surePayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [surePayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    surePayBtn.frame = CGRectMake(15, CGRectGetMaxY(currentView.frame) + 20, SCW - 30, 50);
    surePayBtn.layer.cornerRadius = 12;
    [surePayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    surePayBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [surePayBtn setTitle:@"确定支付" forState:UIControlStateNormal];
    [surePayBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:surePayBtn];
}


- (void)choiceCardAction:(UIButton *)cardBtn{
    NSLog(@"---------------3232==============");
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择你需要输入的银行卡号" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"**** **** **** 888" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [cardBtn setTitle:@"**** **** **** 888" forState:UIControlStateNormal];
    }];
    [alert addAction:action];
    
    [self presentViewController:alert animated:true completion:nil];
}

- (void)sureAction:(UIButton *)sureBtn{
    NSLog(@"=============确定支付");
}


@end
