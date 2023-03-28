//
//  RSTwoPasswordView.m
//  石来石往
//
//  Created by mac on 17/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSTwoPasswordView.h"




@implementation RSTwoPasswordView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIView *view = [[UIView alloc]init];
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        UILabel * label = [[UILabel alloc]init];
        //label.text = @"请输入海西商户登录密码";
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        [view addSubview:label];
        _label = label;
        
        UITextField * twoPassword = [[UITextField alloc]init];
        //twoPassword.borderStyle = UITextBorderStyleRoundedRect;
        _twoPasswordfield = twoPassword;
        _twoPasswordfield.delegate = self;
        twoPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
        twoPassword.layer.borderWidth = 1;
        twoPassword.layer.cornerRadius = 5;
        twoPassword.layer.masksToBounds = YES;
        twoPassword.layer.borderColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0].CGColor;
        [view addSubview:twoPassword];
        
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
        sureBtn.layer.cornerRadius = 5;
        sureBtn.layer.masksToBounds = YES;
        [view addSubview:sureBtn];
        self.sureBtn = sureBtn;
        
        view.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,0)
        .bottomSpaceToView(self,0);
        
        label.sd_layout
        .topSpaceToView(view,25)
        .rightSpaceToView(view,12)
        .leftSpaceToView(view,12)
        .heightIs(10);
        
        twoPassword.sd_layout
        .topSpaceToView(label,13)
        .rightEqualToView(label)
        .leftEqualToView(label)
        .centerYEqualToView(view)
        .heightRatioToView(view,0.25);
        
        sureBtn.sd_layout
        .topSpaceToView(twoPassword,15)
        .bottomSpaceToView(view,10)
        .leftEqualToView(twoPassword)
        .rightEqualToView(twoPassword);
         
        
    }
    return self;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

@end
