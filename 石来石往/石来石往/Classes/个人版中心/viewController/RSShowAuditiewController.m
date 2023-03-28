//
//  RSShowAuditiewController.m
//  石来石往
//
//  Created by mac on 2019/5/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSShowAuditiewController.h"
#import "RSSalertView.h"
@interface RSShowAuditiewController ()

@property (nonatomic,strong)RSSalertView * alertView;

@end

@implementation RSShowAuditiewController

- (RSSalertView *)alertView
{
    if (!_alertView) {
        self.alertView = [[RSSalertView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 139.5, SCW - 66 , 279)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        //self.alertView.delegate = self;
        self.alertView.layer.cornerRadius = 15;
    }
    return _alertView;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.title = @"审核中";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];

//    if (self.navigationController.navigationBar.hidden == NO) {
//            UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            leftBtn.frame = CGRectMake(0, 0, 50, 50);
//            [leftBtn addTarget:self action:@selector(backUpFunctionAction:) forControlEvents:UIControlEventTouchUpInside];
//            [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//            UIBarButtonItem * leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//            self.navigationItem.leftBarButtonItem = leftitem;
//
//
//
//        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        rightBtn.frame = CGRectMake(0,0, 50, 50);
//        [rightBtn addTarget:self action:@selector(editFunctionAction:) forControlEvents:UIControlEventTouchUpInside];
//        [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
//        [rightBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//
//         UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//         self.navigationItem.rightBarButtonItem = rightitem;
//
//    }else{
    
         [self setCustomNavigaionView];
//    }
    
   
    
    
    
    
    UIImageView * showImageView = [[UIImageView alloc]init];
    showImageView.image = [UIImage imageNamed:@"等待审核"];
    [self.view addSubview:showImageView];
    showImageView.sd_layout
    .centerXEqualToView(self.view)
    .widthIs(160)
    .heightIs(141)
    .topSpaceToView(self.navigationController.navigationBar, 96);
    
    
    UILabel * showLabel = [[UILabel alloc]init];
    showLabel.text = @"正在审核";
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.font = [UIFont systemFontOfSize:17];
    showLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [self.view addSubview:showLabel];
    
    showLabel.sd_layout
    .topSpaceToView(showImageView, 9)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(24);
    
    UILabel * secondLabel = [[UILabel alloc]init];
    secondLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    secondLabel.font = [UIFont systemFontOfSize:14];
    secondLabel.textAlignment = NSTextAlignmentLeft;
    secondLabel.text = @"我们工作人员还在审核中,";
    //secondLabel.numberOfLines = 0;
    [self.view addSubview:secondLabel];
    
    secondLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(showLabel, 5)
    .widthIs(170)
    .heightIs(20);
    
    UILabel * thirdLabel = [[UILabel alloc]init];
    thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    thirdLabel.font = [UIFont systemFontOfSize:14];
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    thirdLabel.text = @"请耐心等待！";
    //secondLabel.numberOfLines = 0;
    [self.view addSubview:thirdLabel];
    
    thirdLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(secondLabel, 0)
    .widthIs(170)
    .heightIs(20);
    
    
    UILabel * fourLabel = [[UILabel alloc]init];
    fourLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    fourLabel.font = [UIFont systemFontOfSize:14];
    fourLabel.textAlignment = NSTextAlignmentLeft;
    fourLabel.text = @"感谢您对石来石往的信任";
    //secondLabel.numberOfLines = 0;
    [self.view addSubview:fourLabel];
    
    fourLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(thirdLabel, 0)
    .widthIs(170)
    .heightIs(20);
    
    
    UIButton * knowBtn = [[UIButton alloc]init];
    [knowBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [knowBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [self.view addSubview:knowBtn];
    [knowBtn addTarget:self action:@selector(knowAction:) forControlEvents:UIControlEventTouchUpInside];
    
    knowBtn.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(fourLabel, 22)
    .widthIs(109)
    .heightIs(32);
    
    knowBtn.layer.cornerRadius = 15;
    
}


- (void)setCustomNavigaionView{
    
    CGFloat H = 0.0;
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        H = 88;
        Y = 49;
    }else{
        H = 64;
        Y = 25;
    }
    
    UIView * navigaionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, H)];
    navigaionView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:navigaionView];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(12, Y - 5, 40, 40);
    [leftBtn addTarget:self action:@selector(backUpFunctionAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [navigaionView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(backUpFunctionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * contentTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW/2 - 50, Y + 5, 100, 23)];
    contentTitleLabel.text = @"审核中";
    contentTitleLabel.font = [UIFont systemFontOfSize:17];
    contentTitleLabel.textColor = [UIColor blackColor];
    contentTitleLabel.textAlignment = NSTextAlignmentCenter;
    [navigaionView addSubview:contentTitleLabel];
    
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(SCW - 50 - 12, Y - 5, 50, 50);
    [rightBtn addTarget:self action:@selector(editFunctionAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    [navigaionView addSubview:rightBtn];
   // UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
   // self.navigationItem.rightBarButtonItem = rightitem;
    
    
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, H - 1, SCW, 1)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [navigaionView addSubview:bottomview];
    
}


- (void)knowAction:(UIButton *)knowBtn{
    self.tabBarController.selectedIndex = 0;
}






- (void)backUpFunctionAction:(UIButton *)leftBtn{
    self.tabBarController.selectedIndex = 0;
}

- (void)editFunctionAction:(UIButton *)editBtn{
    self.alertView.materialProductName = self.applyylistmodel.contactPhone;
    self.alertView.materialTypeName = self.applyylistmodel.companyName;
    self.alertView.selectFunctionType = @"修改账号";
    self.alertView.applyID = self.applyylistmodel.applyID;
    [self.alertView showView];
    RSWeakself
    self.alertView.modilfy = ^(NSString * _Nonnull phoneTextStr, NSString * _Nonnull compantTextStr) {
        weakSelf.applyylistmodel.companyName = compantTextStr;
        weakSelf.applyylistmodel.contactPhone = phoneTextStr;
    };
}


@end
