//
//  RSCaseTitleView.m
//  石来石往
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCaseTitleView.h"


@interface RSCaseTitleView()




@end


@implementation RSCaseTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
     
        //这边是输入标题框
        
        UIView * menuview = [[UIView alloc]init];
        menuview.userInteractionEnabled = YES;
        menuview.backgroundColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:0.5];
        [self addSubview:menuview];
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAddMenuView:)];
        [menuview addGestureRecognizer:tap];
        
        UIView * titleView = [[UIView alloc]init];
        titleView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [menuview addSubview:titleView];
        _titleView = titleView;
        
        //确认按键
        UIButton * sureInputBtn = [[UIButton alloc]init];
        [sureInputBtn setTitle:@"输入标题" forState:UIControlStateNormal];
        [sureInputBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        [titleView addSubview:sureInputBtn];
        [sureInputBtn addTarget:self action:@selector(sureCaseTextfieldText:) forControlEvents:UIControlEventTouchUpInside];
        
        //输入框
        UITextField * textfield = [[UITextField alloc]init];
        //textfield.delegate = self;
        //[textfield becomeFirstResponder];
        textfield.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
        textfield.placeholder = @"请输入你要的标题";
        textfield.borderStyle = UITextBorderStyleNone;
        [titleView addSubview:textfield];
        _textfield = textfield;
        
        menuview.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        
        
        
        titleView.sd_layout
        .leftSpaceToView(menuview, 0)
        .rightSpaceToView(menuview, 0)
        .bottomSpaceToView(menuview, 0)
        .heightIs(45);
        
        sureInputBtn.sd_layout
        .rightSpaceToView(titleView, 0)
        .bottomSpaceToView(titleView, 0)
        .topSpaceToView(titleView, 0)
        .widthIs(80);
        
        
        textfield.sd_layout
        .leftSpaceToView(titleView, 0)
        .rightSpaceToView(sureInputBtn, 0)
        .topSpaceToView(titleView, 0)
        .bottomSpaceToView(titleView, 0);
    
    }
    return self;
    
}


- (void)cancelAddMenuView:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(hiddeMenuView)]) {
        [self.delegate hiddeMenuView];
    }
}



- (void)sureCaseTextfieldText:(UIButton *)sureInputBtn{
    
    NSString *temp = [self.textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //看剩下的字符串的长度是否为零
    if ([temp length]!=0) {
        if ([self.delegate respondsToSelector:@selector(sendCaseTitleString:)]) {
            [self.delegate sendCaseTitleString:temp];
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"你没有评论内容"];
    }

}












@end
