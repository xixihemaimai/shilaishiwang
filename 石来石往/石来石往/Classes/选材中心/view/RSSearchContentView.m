//
//  RSSearchContentView.m
//  石来石往
//
//  Created by mac on 2021/10/26.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSearchContentView.h"

@interface RSSearchContentView()<UITextFieldDelegate>


//@property (nonatomic,assign)BOOL isEdit;

@end

@implementation RSSearchContentView


- (instancetype)initWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeholder andShowQRCode:(BOOL)qrCode andShopBusiness:(BOOL)isBusiness andIsEdit:(BOOL)isEdit{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexColorStr:@"#fffffff"];
        
//        self.isEdit = isEdit;
        //二维码按键
        if (qrCode) {
            UIButton * showQRCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [showQRCodeBtn setImage:[UIImage imageNamed:@"扫二维码用的"] forState:UIControlStateNormal];
            [showQRCodeBtn addTarget:self action:@selector(showQRCodeAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:showQRCodeBtn];
            
            showQRCodeBtn.sd_layout.topSpaceToView(self, Height_Real(51)).rightSpaceToView(self, Width_Real(18)).widthIs(Width_Real(30)).heightEqualToWidth();
         
        }
        
        if (isBusiness) {
            //商圈
            UIButton * phoneListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [phoneListBtn setImage:[UIImage imageNamed:@"货主列表"] forState:UIControlStateNormal];
            [self addSubview:phoneListBtn];
            phoneListBtn.tag = 0;
            [phoneListBtn addTarget:self action:@selector(phoneListAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            phoneListBtn.sd_layout.leftSpaceToView(self , Width_Real(20)).topSpaceToView(self, Height_Real(51)).widthIs(Width_Real(24)).heightEqualToWidth();
            
            UIButton * informationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [informationBtn setImage:[UIImage imageNamed:@"通知1"] forState:UIControlStateNormal];
            [self addSubview:informationBtn];
            informationBtn.tag = 1;
            [informationBtn addTarget:self action:@selector(informationAction:) forControlEvents:UIControlEventTouchUpInside];
            
            informationBtn.sd_layout.leftSpaceToView(phoneListBtn , Width_Real(14)).topSpaceToView(self, Height_Real(51)).widthIs(Width_Real(24)).heightEqualToWidth();
            
            UIButton * releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [releaseBtn setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
            [self addSubview:releaseBtn];
            releaseBtn.tag = 2;
            releaseBtn.sd_layout.rightSpaceToView(self , Width_Real(20)).topSpaceToView(self, Height_Real(51)).widthIs(Width_Real(24)).heightEqualToWidth();
            
            [releaseBtn addTarget:self action:@selector(releaseAction:) forControlEvents:UIControlEventTouchUpInside];
        }

        UIImageView * logoView = [[UIImageView alloc]init];
        logoView.image = [UIImage imageNamed:@"新logo"];
        [self addSubview:logoView];
        
        logoView.sd_layout.centerXEqualToView(self).topSpaceToView(self, Height_Real(73)).widthIs(136).heightIs(32);
        
        
        //这边要创建一个搜索的界面
        UIView * searchView = [[UIView alloc]init];
//        searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self addSubview:searchView];
        
        searchView.sd_layout.leftSpaceToView(self, Width_Real(16)).rightSpaceToView(self, Width_Real(16)).topSpaceToView(logoView, Height_Real(15)).heightIs(Height_Real(40));
        searchView.layer.borderWidth = Width_Real(1);
        searchView.layer.borderColor = [UIColor colorWithHexColorStr:@"#999999" alpha:0.6].CGColor;
        searchView.layer.cornerRadius = Width_Real(4);
        
        //图片
        UIImageView * searchImage = [[UIImageView alloc]init];
        searchImage.image = [UIImage imageNamed:@"cxSearch"];
        [searchView addSubview:searchImage];
        
        searchImage.sd_layout.centerYEqualToView(searchView).leftSpaceToView(searchView, Width_Real(15)).widthIs(Width_Real(13)).heightEqualToWidth();
        
        //搜索内容
        UITextField * searchTextView = [[UITextField alloc]init];
//        searchTextView.zw_placeHolder = placeholder;
        searchTextView.placeholder = placeholder;
//        searchTextView.showsVerticalScrollIndicator = false;
        searchTextView.returnKeyType = UIReturnKeySend;//返回键的类型
        [searchTextView addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        searchTextView.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#999999"]}];
        searchTextView.attributedPlaceholder = placeholderString;
//        searchTextView.zw_placeHolderColor = [UIColor colorWithHexColorStr:@"#999999"];
        [searchView addSubview:searchTextView];
        
        if (isEdit) {
//            searchTextView.editing = true;
            searchTextView.delegate = self;
        }else{
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpAction:)];
            [searchTextView addGestureRecognizer:tap];
//            searchTextView.editing = false;
        }
        _searchTextView = searchTextView;
//        if (iPhone12_ProMax) {
//            searchTextView.sd_layout.centerYEqualToView(searchView).leftSpaceToView(searchImage, Width_Real(6)).heightIs(Height_Real(25)).rightSpaceToView(searchView, 0);
//        }else{
        searchTextView.sd_layout.centerYEqualToView(searchView).leftSpaceToView(searchImage, Width_Real(6)).heightIs(Height_Real(32)).rightSpaceToView(searchView, 0);
//        }
    }
    return self;
}

//二维码按键
- (void)showQRCodeAction:(UIButton *)qrCodeBtn{
//    CLog(@"+++++");
    if ([self.delegate respondsToSelector:@selector(openScanQRCode)]) {
        [self.delegate openScanQRCode];
    }
}



#pragma mark -- 点击uitextfield
- (void)jumpAction:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(jumpNewController)]) {
        [self.delegate jumpNewController];
    }
}


//FIXME:UITextViewDelegate
// 将要开始编辑
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    CLog(@"-------------------------%@",textView.text);
//    return self.isEdit;
//}

// 将要结束编辑
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView;

// 开始编辑
//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    CLog(@"----1111-----------%@",textView.text);
//    if ([self.delegate respondsToSelector:@selector(jumpNewController)]) {
//        [self.delegate jumpNewController];
//    }
//}
// 结束编辑
//- (void)textViewDidEndEditing:(UITextView *)textView{
//    CLog(@"----2222-----------%@",textView.text);
//    if ([self.delegate respondsToSelector:@selector(searchTextViewWithContentStr:)]) {
//        [self.delegate searchTextViewWithContentStr:textView.text];
//    }
//}

// 文本将要改变
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
//        [textView resignFirstResponder];
//       //在这里做你响应return键的代码
//       return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
//    }
//    return YES;
//}


- (void)textFieldChange:(UITextField *)textfield{
//    CLog(@"===============================%@",textfield.text);
    if ([self.delegate respondsToSelector:@selector(rowNowSearchTextFieldStr:)]) {
        [self.delegate rowNowSearchTextFieldStr:textfield.text];
    }
}




- (void)textFieldDidEndEditing:(UITextField *)textField{
//    CLog(@"----2222-----------%@",textField.text);
    if ([self.delegate respondsToSelector:@selector(searchTextViewWithContentStr:)]) {
        [self.delegate searchTextViewWithContentStr:textField.text];
    }
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textField resignFirstResponder];
       //在这里做你响应return键的代码
       return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}


#pragma mark 电话簿
- (void)phoneListAction:(UIButton *)phoneListBtn{
//    CLog(@"电话簿");
    if ([self.delegate respondsToSelector:@selector(implementActionWithTag:andActionName:andButton:)]) {
        [self.delegate implementActionWithTag:phoneListBtn.tag andActionName:@"电话簿" andButton:phoneListBtn];
    }
}


#pragma mark 信息
- (void)informationAction:(UIButton *)informationBtn{
//    CLog(@"信息");
    if ([self.delegate respondsToSelector:@selector(implementActionWithTag:andActionName:andButton:)]) {
        [self.delegate implementActionWithTag:informationBtn.tag andActionName:@"信息" andButton:informationBtn];
    }
}

#pragma mark 发布
- (void)releaseAction:(UIButton *)releaseBtn{
//    CLog(@"发布");
    if ([self.delegate respondsToSelector:@selector(implementActionWithTag:andActionName:andButton:)]) {
        [self.delegate implementActionWithTag:releaseBtn.tag andActionName:@"发布" andButton:releaseBtn];
    }
}


@end
