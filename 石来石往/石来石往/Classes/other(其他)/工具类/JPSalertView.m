//
//  JPSalertView.m
//  PopViewOne
//
//  Created by 姜朋升 on 2017/5/22.
//  Copyright © 2017年 闪牛网络. All rights reserved.
//

#import "JPSalertView.h"

@interface JPSalertView()<UITextViewDelegate>
@property(nonatomic,strong)UIView *bgView;

@end
@implementation JPSalertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)createView
{

    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15;
    self.clipsToBounds = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 21,self.bounds.size.width, 20)];
    //label.text = @"联系人修改";
    label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _label = label;
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, 72, self.bounds.size.width, 16)];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.text = @"名称";
    nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    self.firstField = [[UITextView alloc] initWithFrame:CGRectMake(39, 96, self.bounds.size.width - 78, 34)];
    //self.firstField.borderStyle = UITextBorderStyleLine;
    self.firstField.placeholder = @"请输入姓名 ";
    self.firstField.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    self.firstField.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    self.firstField.layer.cornerRadius = 17;
    self.firstField.layer.masksToBounds = YES;
    self.firstField.delegate =self;
    self.firstField.returnKeyType = UIReturnKeySend;
    [self addSubview:self.firstField];
   
    //self.firstField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
    
    UILabel * numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, 143, self.bounds.size.width, 16)];
    numberLabel.textAlignment = NSTextAlignmentLeft;
    numberLabel.text = @"联系电话";
    numberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    numberLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:numberLabel];
    _numberLabel = numberLabel;
    
    self.secondField = [[UITextView alloc] initWithFrame:CGRectMake(39, 167, self.bounds.size.width - 78, 34)];
    self.secondField.placeholder = @"请输入电话";
    self.secondField.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    self.secondField.layer.cornerRadius = 17;
    self.secondField.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    self.secondField.layer.masksToBounds = YES;
     self.secondField.delegate =self;
    self.secondField.returnKeyType = UIReturnKeySend;
    [self addSubview:self.secondField];
    //self.secondField.contentInset = UIEdgeInsetsMake(0, 18, 0, 0);
    
    
    
    //这边是设置为默认联系人按键
    UIButton * settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 24 - 150, 220, 150, 13)];
    [settingBtn setTitle:@"设置为默认联系人" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _settingBtn = settingBtn;
   
    settingBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [settingBtn addTarget:self action:@selector(settingDefaultValueAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingBtn];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 248, self.bounds.size.width, 1)];
    view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [self addSubview:view];
    
    UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonOne.frame = CGRectMake(0, 249, self.bounds.size.width/2 - 0.5, 47);
    [buttonOne setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonOne setTitle:@"取消" forState:UIControlStateNormal];
    
    [buttonOne addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonOne];
    
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonOne.frame), 249, 1, 47)];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [self addSubview:midView];
    
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTwo.frame = CGRectMake(CGRectGetMaxX(midView.frame), 249,  self.bounds.size.width/2 - 0.5, 47);
    [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonTwo];
}


- (void)settingDefaultValueAction:(UIButton *)settingBtn{
    settingBtn.selected = !settingBtn.selected;
    if (settingBtn.selected) {
        [settingBtn setImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateNormal];
        self.IS_DEFAULT = 1;
    }else{
        [settingBtn setImage:[UIImage imageNamed:@"圆角矩形 916"] forState:UIControlStateNormal];
        self.IS_DEFAULT = 0;
    }
}


#pragma mark ====展示view
- (void)showView
{
    if (self.IS_DEFAULT == 1) {
        [self.settingBtn setImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateNormal];
        self.settingBtn.selected = YES;
    }else{
        self.settingBtn.selected = NO;
        [self.settingBtn setImage:[UIImage imageNamed:@"圆角矩形 916"] forState:UIControlStateNormal];
    }
    
    if ([self.selectype isEqualToString:@"1"]) {
        //这边是联系人和电话
        if ([self.funtionType isEqualToString:@"1"]) {
            /**1 新增*/
            _firstField.text = @"";
            _secondField.text = @"";
            
        }else if ([self.funtionType isEqualToString:@"2"]){
            //这边是编辑
            
            
        }

    }else{
        //这边是地址
        if ([self.funtionType isEqualToString:@"1"]) {
            //新增
            _firstField.text = @"";
            _secondField.text = @"";
            
        }else if ([self.funtionType isEqualToString:@"2"]){
            //编辑

        }
        //(39, 96, self.bounds.size.width - 78, 34)
        self.firstField.layer.cornerRadius = 6;
        self.firstField.layer.masksToBounds = YES;
        self.firstField.frame = CGRectMake(39, 96, self.bounds.size.width - 78, 112);
        self.firstField.layoutManager.allowsNonContiguousLayout = NO;
    }
    
    
    if (self.bgView) {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.bgView addGestureRecognizer:tap];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.4;
    [window addSubview:self.bgView];
    [window addSubview:self];
    
}
-(void)tap:(UIGestureRecognizer *)tap
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}

- (void)closeView
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}
-(void)cancelAction:(UIButton *)sender
{
    [self closeView];
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
     if ([text isEqualToString:@"\n"]){
         [self.firstField resignFirstResponder];
         [self.secondField resignFirstResponder];
         return NO;
     }
    return YES;
}





- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


-(void)sendAction:(UIButton *)sender
{
    //这边要先判断
    if ([self.selectype isEqualToString:@"1"]) {
        //联系人
        if ([self.funtionType isEqualToString:@"1"]) {
            //新增
            NSString *temp = [self.firstField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            temp = [self delSpaceAndNewline:temp];
            if ([temp length] > 0) {
                self.firstField.text = temp;
            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入名称"];
                return;
            }
            
            NSString *temp1 = [self.secondField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            temp1 = [self delSpaceAndNewline:temp1];
            if ([temp1 length] > 0) {
                
                if ([self isTrueMobile:temp1]) {
                    self.secondField.text = temp1;
                }else{
                    [SVProgressHUD showErrorWithStatus:@"输入的联系电话错误"];
                    return;
                }

            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入联系电话"];
                return;
            }
            
            if ([self.delegate respondsToSelector:@selector(contactsInformationSelectype:andContactsAddress:andContactsName:andContactsPhone:andIndex:andType:andIs_default:)]) {
                [self.delegate contactsInformationSelectype:self.selectype andContactsAddress:@"" andContactsName:self.firstField.text andContactsPhone:self.secondField.text andIndex:0 andType:@"xz" andIs_default:self.IS_DEFAULT];
            }
            
            
        }else if ([self.funtionType isEqualToString:@"2"]){
            //编辑
            NSString *temp = [self.firstField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            temp = [self delSpaceAndNewline:temp];
            if ([temp length] > 0) {
                self.firstField.text = temp;
            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入名称"];
                return;
            }
            NSString *temp1 = [self.secondField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            temp1 = [self delSpaceAndNewline:temp1];
            if ([temp1 length] > 0) {
                if ([self isTrueMobile:temp1]) {
                    self.secondField.text = temp1;
                }else{
                    [SVProgressHUD showErrorWithStatus:@"输入的联系电话错误"];
                    return;
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入联系电话"];
                return;
            }
            
         // - (void)loadContactsActAndAddressContactsType:(NSString *)selectype andType:(NSString *)type andContactsAddress:(NSString *)contactsAddress andContactsName:(NSString *)contactsName andContactsPhone:(NSString *)contactsPhone andIs_default:(NSInteger)is_default
           
            if ([self.delegate respondsToSelector:@selector(editContactsActAndAddressContactsType:andType:andContactsAddress:andContactsName:andContactsPhone:andIs_default:andContactsId:)]) {
                [self.delegate editContactsActAndAddressContactsType:self.selectype andType:@"edit" andContactsAddress:@"" andContactsName:self.firstField.text andContactsPhone:self.secondField.text andIs_default:self.IS_DEFAULT andContactsId:self.contactsId];
            }
            
            
        }
    }else{
        //地址
        if ([self.funtionType isEqualToString:@"1"]) {
            //新增
            NSString *temp = [self.firstField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            temp = [self delSpaceAndNewline:temp];
            if ([temp length] > 0) {
                self.firstField.text = temp;
            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入地址"];
                return;
            }
            
            if ([self.delegate respondsToSelector:@selector(contactsInformationSelectype:andContactsAddress:andContactsName:andContactsPhone:andIndex:andType:andIs_default:)]) {
                [self.delegate contactsInformationSelectype:self.selectype andContactsAddress:self.firstField.text andContactsName:@"" andContactsPhone:@"" andIndex:0 andType:@"xz" andIs_default:self.IS_DEFAULT];
            }
            
        }else if ([self.funtionType isEqualToString:@"2"]){
            //编辑
            NSString *temp = [self.firstField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            temp = [self delSpaceAndNewline:temp];
            if ([temp length] > 0) {
                self.firstField.text = temp;
            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入地址"];
                return;
            }
            
            if ([self.delegate respondsToSelector:@selector(editContactsActAndAddressContactsType:andType:andContactsAddress:andContactsName:andContactsPhone:andIs_default:andContactsId:)]) {
                [self.delegate editContactsActAndAddressContactsType:self.selectype andType:@"edit" andContactsAddress:self.firstField.text andContactsName:@"" andContactsPhone:@"" andIs_default:self.IS_DEFAULT andContactsId:self.contactsId];
            }
        }
    }
    
    
 
    
//    if ([self.delegate respondsToSelector:@selector(requestEventAction:)]) {
//        [self.delegate requestEventAction:sender];
//    }
    
}


//手机号验证
- (BOOL)isTrueMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^1(3|5|7|8|4)\\d{9}";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:mobile];
    
    // NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSString * MOBILE = @"^((13[0-9])|(15[^4])|(18[0-9])|(17[0-8])|(19[8,9])|(166)|(147))\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobile];
    
}


@end
