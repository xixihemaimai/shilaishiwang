//
//  RSPaymentViewController.m
//  石来石往
//
//  Created by mac on 2021/4/12.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSPaymentViewController.h"
//#import "RSPayMentCell.h"
//#import "RSPayMentReusableView.h"

//银行卡界面
#import "RSBankViewController.h"
//添加银行卡界面
#import "RSAddBankViewController.h"
//支付部分
#import "RSPaymentCompleteViewController.h"


@interface RSPaymentViewController ()
@property (nonatomic,strong)UIView * selectView;
@property (nonatomic,strong) UILabel * totalNumberLabel;
@property (nonatomic,strong)UIButton * payBtn;
@end

@implementation RSPaymentViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"付款";
    //费用
    [self showTitleNumber];
    //选择支付的方式
    [self setSelectPayBtn];
    //支付
    [self payView];
    
    UIButton * bankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bankBtn setImage:[UIImage imageNamed:@"银行卡"] forState:UIControlStateNormal];
    bankBtn.frame = CGRectMake(0, 0, 50, 50);
    [bankBtn addTarget:self action:@selector(bankShowAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bankBtn];
}


//显示欠款的总金额
- (void)showTitleNumber{
    UILabel * totalNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.navigationController.navigationBar.frame) + 20, SCW - 30, 40)];
    self.totalNumberLabel = totalNumberLabel;
    totalNumberLabel.text = @"总费用:89998899999";
    totalNumberLabel.textAlignment = NSTextAlignmentLeft;
    totalNumberLabel.font = [UIFont systemFontOfSize:16];
    totalNumberLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.view addSubview:totalNumberLabel];
    
}

- (void)setSelectPayBtn{
    
    UIView * selectView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.totalNumberLabel.frame) + 10, SCW, 320)];
    self.selectView = selectView;
    [self.view addSubview:selectView];
    //创建5个
    CGFloat btnW = 165;
    CGFloat btnH = 90;
    for (int i = 0; i < 5; i++) {
        selectView.backgroundColor = UIColor.whiteColor;
        
        int row = i / 2;
        int colom = i % 2;
        UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.tag = i;
        
        selectBtn.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        selectBtn.layer.shadowOffset = CGSizeMake(0,0);
        selectBtn.layer.shadowOpacity = 1;
        selectBtn.layer.shadowRadius = 4;
        [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        selectBtn.frame = CGRectMake(colom * (btnW + 15) + 15, row * (btnH + 15) + 15, btnW, btnH);
       
        //添加按键内容
        UIView * blueView = [[UIView alloc]initWithFrame:CGRectMake(4.5, 25, 8.5, 8.5)];
        blueView.layer.backgroundColor = [UIColor colorWithRed:51/255.0 green:133/255.0 blue:255/255.0 alpha:1.0].CGColor;
//        blueView.backgroundColor = [UIColor colorWithHexString:@"#3385ff"];
        [selectBtn addSubview:blueView];
        blueView.layer.cornerRadius = blueView.yj_width * 0.5;
        blueView.layer.masksToBounds = YES;
        
        UILabel * payName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(blueView.frame) + 7, 18, selectBtn.yj_width - CGRectGetMaxX(blueView.frame) - 7, 22.5)];
        payName.text = @"仓储费";
        payName.textAlignment = NSTextAlignmentLeft;
        payName.font = [UIFont systemFontOfSize:16];
        payName.textColor = [UIColor colorWithHexString:@"#333333"];
        [selectBtn addSubview:payName];
        
        UILabel * payNumber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(blueView.frame) + 7, CGRectGetMaxY(payName.frame) + 8, selectBtn.yj_width - CGRectGetMaxX(blueView.frame) - 7, 22.5)];
        payNumber.text = @"233333333元";
        payNumber.textAlignment = NSTextAlignmentLeft;
        payNumber.font = [UIFont systemFontOfSize:16];
        payNumber.textColor = [UIColor colorWithHexString:@"#333333"];
        [selectBtn addSubview:payNumber];
        
        if (i == 0) {
            selectBtn.layer.shadowColor = [UIColor colorWithRed:173/255.0 green:206/255.0 blue:255/255.0 alpha:1.0].CGColor;
            selectBtn.selected = true;
        }else{
            selectBtn.layer.shadowColor = [UIColor colorWithRed:202/255.0 green:202/255.0 blue:202/255.0 alpha:0.5].CGColor;
            selectBtn.selected = false;
        }
        [selectView addSubview:selectBtn];
    }
}

- (void)payView{
    UIButton * payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(15, SCH - 100, SCW - 30, 50);
    payBtn.backgroundColor = [UIColor colorWithHexString:@"#3385FF"];
    [payBtn setTitle:@"支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:payBtn];
    payBtn.layer.backgroundColor = [UIColor colorWithRed:51/255.0 green:133/255.0 blue:255/255.0 alpha:1.0].CGColor;
    payBtn.layer.cornerRadius = 12;
    _payBtn = payBtn;
    [payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)payAction{
    NSString * str = @"";
    for (UIButton * selectBtn in self.selectView.subviews) {
        if (selectBtn.selected) {
            str = selectBtn.currentTitle;
        }
    }
    BOOL isbank = true;
    if (isbank) {
        //这边是直接支付部分
        RSPaymentCompleteViewController * payVc = [[RSPaymentCompleteViewController alloc]init];
        [self.navigationController pushViewController:payVc animated:true];
    
    }else{
        //这边是要去绑定银行卡部分
        RSAddBankViewController * addBankVc = [[RSAddBankViewController alloc]init];
            [self.navigationController pushViewController:addBankVc animated:true];
    }
}


- (void)selectAction:(UIButton *)btn{
    for (UIButton * selectBtn in self.selectView.subviews) {
        if (btn == selectBtn) {
            btn.layer.shadowColor = [UIColor colorWithRed:173/255.0 green:206/255.0 blue:255/255.0 alpha:1.0].CGColor;
            selectBtn.selected = true;
        }else{
            selectBtn.selected = false;
            selectBtn.layer.shadowColor = [UIColor colorWithRed:202/255.0 green:202/255.0 blue:202/255.0 alpha:0.5].CGColor;
        }
    }
}


//进入银行卡展示界面
- (void)bankShowAction:(UIButton *)sender{
    RSBankViewController * bankVc = [[RSBankViewController alloc]init];
    [self.navigationController pushViewController:bankVc animated:true];
}




@end
