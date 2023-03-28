//
//  RSBankInfomationViewController.m
//  石来石往
//
//  Created by mac on 2021/4/12.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSBankInfomationViewController.h"

@interface RSBankInfomationViewController ()

@property (nonatomic,strong) UIButton * choiceBankBtn;

@property (nonatomic,strong) UITextField * moneyTextfiled;

@property (nonatomic,strong) UITextField * currentTextfiled;
@end

@implementation RSBankInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"填写银行卡及身份信息";
    self.view.layer.backgroundColor = [UIColor colorWithRed:247/255.0 green:245/255.0 blue:246/255.0 alpha:1.0].CGColor;
    
    
    [self setUI];
}


- (void)setUI{
    
    //UIView
    UIView * contentView = [[UIView alloc]init];
    contentView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCW, 300);
    contentView.backgroundColor = [UIColor colorWithHexString:@"#F7F5F6"];
    [self.view addSubview:contentView];
    //输入您支付金额
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(15, 16.5, SCW - 30, 20);
    titleLabel.text = @"请输入您银行卡类型";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [contentView addSubview:titleLabel];
    
    UIView * bankView = [[UIView alloc]init];
    bankView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 7, SCW, 49);
    bankView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [contentView addSubview:bankView];
    
    
    UILabel * bankLabel = [[UILabel alloc]init];
    bankLabel.frame = CGRectMake(15, 13.5, 100, 22.5);
    bankLabel.text = @"银行";
    bankLabel.font = [UIFont systemFontOfSize:16];
    bankLabel.textAlignment = NSTextAlignmentLeft;
    bankLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [bankView addSubview:bankLabel];
    
    
    UIButton * choiceBankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    choiceBankBtn.frame = CGRectMake(CGRectGetMaxX(bankLabel.frame) + 20, 7, SCW - CGRectGetMaxX(bankLabel.frame) - 20, 30);
    [choiceBankBtn setTitle:@"民生银行" forState:UIControlStateNormal];
    choiceBankBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    choiceBankBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    choiceBankBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [choiceBankBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    [choiceBankBtn addTarget:self action:@selector(choiceBankAction:) forControlEvents:UIControlEventTouchUpInside];
    _choiceBankBtn = choiceBankBtn;
    [bankView addSubview:choiceBankBtn];
    
    
    
    UIView * bankMidView = [[UIView alloc]init];
    bankMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#E8E8E8"];
    bankMidView.frame = CGRectMake(0, 48, SCW, 1);
    [bankView addSubview:bankMidView];
    

    
    

    //总应支付金额
    UIView * totalView = [[UIView alloc]init];
    totalView.frame = CGRectMake(0, CGRectGetMaxY(bankView.frame), SCW, 49);
    totalView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [contentView addSubview:totalView];
    
    UILabel * totalTitleLabel = [[UILabel alloc]init];
    totalTitleLabel.frame = CGRectMake(15, 13.5, 100, 22.5);
    totalTitleLabel.text = @"手机号";
    totalTitleLabel.font = [UIFont systemFontOfSize:16];
    totalTitleLabel.textAlignment = NSTextAlignmentLeft;
    totalTitleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [totalView addSubview:totalTitleLabel];
    
    UITextField * moneyTextfiled = [[UITextField alloc]init];
    moneyTextfiled.frame = CGRectMake(CGRectGetMaxX(totalTitleLabel.frame) + 20, 13.5, SCW - CGRectGetMaxX(totalTitleLabel.frame) - 20, 22.5);
    moneyTextfiled.placeholder = @"请输入银行预留手机号";
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
    currentTitleLabel.text = @"短信验证";
    currentTitleLabel.font = [UIFont systemFontOfSize:16];
    currentTitleLabel.textAlignment = NSTextAlignmentLeft;
    currentTitleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [currentView addSubview:currentTitleLabel];
    
    UITextField * currentTextfiled = [[UITextField alloc]init];
    currentTextfiled.frame = CGRectMake(CGRectGetMaxX(currentTitleLabel.frame) + 20, 13.5, SCW - CGRectGetMaxX(currentTitleLabel.frame) - 20 - 77 - 15, 22.5);
    currentTextfiled.placeholder = @"请输入短信验证";
    currentTextfiled.textAlignment = NSTextAlignmentLeft;
    currentTextfiled.font = [UIFont systemFontOfSize:16];
    currentTextfiled.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [currentView addSubview:currentTextfiled];
    _currentTextfiled = currentTextfiled;
    
    
    UIButton * codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    [codeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    codeBtn.frame = CGRectMake(SCW - 15 - 77, 8, 77, 32);
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    codeBtn.layer.cornerRadius = 15.75;
    [codeBtn addTarget:self action:@selector(sendCodeBtnActin:) forControlEvents:UIControlEventTouchUpInside];
    [currentView addSubview:codeBtn];
    
    
    
    //确定支付
    
    UIButton * sureBingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBingBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    sureBingBtn.frame = CGRectMake(15, CGRectGetMaxY(currentView.frame) + 20, SCW - 30, 50);
    sureBingBtn.layer.cornerRadius = 12;
    [sureBingBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFEFF"]];
    sureBingBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBingBtn setTitle:@"确定绑卡" forState:UIControlStateNormal];
    [sureBingBtn addTarget:self action:@selector(sureBingAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:sureBingBtn];
}


//选择银行
- (void)choiceBankAction:(UIButton *)choiceBankBtn{
    NSLog(@"---------------3232==============");
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择你需要添加入的银行" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"民生银行" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [choiceBankBtn setTitle:@"民生银行" forState:UIControlStateNormal];
    }];
    [alert addAction:action];
    
    [self presentViewController:alert animated:true completion:nil];
}


//发送短信
- (void)sendCodeBtnActin:(UIButton *)sender{
    NSLog(@"发送短信");
    
}


//确定绑卡
- (void)sureBingAction:(UIButton *)sureBingBtn{
    if (_moneyTextfiled.text.length > 0 && _currentTextfiled.text.length > 0 && _choiceBankBtn.currentTitle.length > 0) {
       
        [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:true];
        
    }else{
        //其中没有输入的时候爆粗
        [SVProgressHUD showErrorWithStatus:@"有部分信息没有填完整,请重新输入"];
    }
}




@end
