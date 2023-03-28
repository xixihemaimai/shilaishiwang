//
//  RSTaoBaoProductDetailSLHeaderView.m
//  石来石往
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoProductDetailSLHeaderView.h"

@interface RSTaoBaoProductDetailSLHeaderView()<UITextFieldDelegate>

@end



@implementation RSTaoBaoProductDetailSLHeaderView



- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        
        
        
        UIView * backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:backView];
        //_backView = backView;
        
        
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [backView addSubview:showView];
        //_showView = showView;
        
        
        
        
        
        
        
        
        //荒料号
        UILabel * blockNoLabel = [[UILabel alloc]init];
        blockNoLabel.text = @"荒料号";
        blockNoLabel.textAlignment = NSTextAlignmentCenter;
        blockNoLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        blockNoLabel.font = [UIFont systemFontOfSize:14];
        blockNoLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [showView addSubview:blockNoLabel];
        
        
        
        
        
        
        UITextField * blockNoLabelTextField = [[UITextField alloc]init];
        blockNoLabelTextField.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        blockNoLabelTextField.textAlignment = NSTextAlignmentCenter;
        blockNoLabelTextField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        blockNoLabelTextField.font = [UIFont systemFontOfSize:15];
        
        blockNoLabelTextField.returnKeyType = UIReturnKeyDone;
        blockNoLabelTextField.text = @"ESB00295/DH-539";
        
        [showView addSubview:blockNoLabelTextField];
        _blockNoLabelTextField = blockNoLabelTextField;
        
        
        //物料类型
        UILabel * typeLabel = [[UILabel alloc]init];
        typeLabel.text = @"物料类型";
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        typeLabel.font = [UIFont systemFontOfSize:14];
        typeLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [showView addSubview:typeLabel];
        
        
        UITextField * typeTextField = [[UITextField alloc]init];
        typeTextField.textAlignment = NSTextAlignmentCenter;
        typeTextField.font = [UIFont systemFontOfSize:15];
        typeTextField.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        typeTextField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        
        typeTextField.returnKeyType = UIReturnKeyDone;
        [showView addSubview:typeTextField];
        
        _typeTextField = typeTextField;
        
        
        //总匝数
        UILabel * totalLabel = [[UILabel alloc]init];
        totalLabel.text = @"总匝数";
        totalLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        totalLabel.textAlignment = NSTextAlignmentCenter;
        totalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        totalLabel.font = [UIFont systemFontOfSize:14];
        [showView addSubview:totalLabel];
        
        
        UITextField * totalTextField = [[UITextField alloc]init];
        totalTextField.textAlignment = NSTextAlignmentCenter;
        totalTextField.font = [UIFont systemFontOfSize:15];
        totalTextField.returnKeyType = UIReturnKeyDone;
        
        totalTextField.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        totalTextField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        
        [showView addSubview:totalTextField];
        _totalTextField = totalTextField;
        
        //总面积
        UILabel * areaLabel = [[UILabel alloc]init];
        areaLabel.text = @"面积(m²)";
        areaLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        areaLabel.textAlignment = NSTextAlignmentCenter;
        areaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        areaLabel.font = [UIFont systemFontOfSize:14];
        [showView addSubview:areaLabel];
        
        
        UITextField * areaTextField = [[UITextField alloc]init];
        areaTextField.textAlignment = NSTextAlignmentCenter;
        areaTextField.font = [UIFont systemFontOfSize:15];
        areaTextField.returnKeyType = UIReturnKeyDone;
        
        areaTextField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        areaTextField.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [showView addSubview:areaTextField];
        _areaTextField = areaTextField;
        
        
        //存储位置
        UILabel * addressLabel = [[UILabel alloc]init];
        addressLabel.text = @"存储位置";
        addressLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        addressLabel.textAlignment = NSTextAlignmentCenter;
        addressLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        addressLabel.font = [UIFont systemFontOfSize:14];
        [showView addSubview:addressLabel];
        
        
        UITextField * addressTextField = [[UITextField alloc]init];
        addressTextField.textAlignment = NSTextAlignmentCenter;
        addressTextField.font = [UIFont systemFontOfSize:15];
        addressTextField.returnKeyType = UIReturnKeyDone;
        
        addressTextField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        addressTextField.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [showView addSubview:addressTextField];
        _addressTextField = addressTextField;
        
        
        blockNoLabelTextField.delegate = self;
        typeTextField.delegate = self;
        areaTextField.delegate = self;
        totalTextField.delegate = self;
        addressTextField.delegate = self;
        
        
        
        //删除
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:deleteBtn];
        
        deleteBtn.layer.cornerRadius = 12;
        deleteBtn.layer.borderWidth = 1;
        deleteBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FF4B33"].CGColor;
        _deleteBtn = deleteBtn;
        
        
        
        //添加匝信息
        
        RSAllMessageUIButton * addTurnsBtn = [RSAllMessageUIButton buttonWithType:UIButtonTypeCustom];
        [addTurnsBtn setTitle:@"添加匝信息" forState:UIControlStateNormal];
        [addTurnsBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
        addTurnsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
      //  [addTurnsBtn setImage:[UIImage imageNamed:@"向下-(1)-拷贝-4"] forState:UIControlStateNormal];
       // [addTurnsBtn setImage:[UIImage imageNamed:@"向下-(1)-拷贝-4"] forState:UIControlStateNormal];
        [backView addSubview:addTurnsBtn];
        addTurnsBtn.layer.cornerRadius = 12;
        [addTurnsBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FE2933"]];
        _addTurnsBtn = addTurnsBtn;
        
        
        backView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .bottomSpaceToView(self.contentView, 0);
        
        //backView.layer.cornerRadius = 6;
        
        
        CGRect rect6 = CGRectMake(0, 0, SCW - 24, 234);
        CGRect oldRect2 = rect6;
        oldRect2.size.width = SCW - 24;
        UIBezierPath * maskPath2 = [UIBezierPath bezierPathWithRoundedRect:oldRect2 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(6, 6)];
        CAShapeLayer * maskLayer2 = [[CAShapeLayer alloc] init];
        maskLayer2.path = maskPath2.CGPath;
        maskLayer2.frame = oldRect2;
        backView.layer.mask = maskLayer2;
        
        
        
        
        
        showView.sd_layout
        .leftSpaceToView(backView, 11)
        .rightSpaceToView(backView, 11)
        .topSpaceToView(backView, 12)
        .bottomSpaceToView(backView, 50);
        
        
        blockNoLabel.sd_layout
        .leftSpaceToView(showView, 0)
        .topSpaceToView(showView, 0)
        .heightIs(34)
        .widthIs(77);
        
        
        blockNoLabel.layer.borderWidth = 1;
        blockNoLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        blockNoLabelTextField.sd_layout
        .leftSpaceToView(blockNoLabel, -1)
        .topSpaceToView(showView, 1)
        .heightIs(32)
        .rightSpaceToView(showView, 0);
        
        blockNoLabelTextField.layer.borderWidth = 1;
        blockNoLabelTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        
        typeLabel.sd_layout
        .leftEqualToView(blockNoLabel)
        .rightEqualToView(blockNoLabel)
        .topSpaceToView(blockNoLabel, 0)
        .heightIs(34);
        
        typeLabel.layer.borderWidth = 1;
        typeLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        
        typeTextField.sd_layout
        .leftSpaceToView(typeLabel, -1)
        .rightEqualToView(blockNoLabelTextField)
        .topSpaceToView(blockNoLabelTextField, 2)
        .heightIs(32);
        
        typeTextField.layer.borderWidth = 1;
        typeTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        totalLabel.sd_layout
        .leftEqualToView(typeLabel)
        .rightEqualToView(typeLabel)
        .topSpaceToView(typeLabel, 0)
        .heightIs(34);
        
        totalLabel.layer.borderWidth = 1;
        totalLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        totalTextField.sd_layout
        .leftSpaceToView(totalLabel, -1)
        .topSpaceToView(typeTextField, 2)
        .rightEqualToView(typeTextField)
        .heightIs(32);
        
        totalTextField.layer.borderWidth = 1;
        totalTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        areaLabel.sd_layout
        .leftEqualToView(totalLabel)
        .rightEqualToView(totalLabel)
        .topSpaceToView(totalLabel, 0)
        .heightIs(34);
        
        areaLabel.layer.borderWidth = 1;
        areaLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        areaTextField.sd_layout
        .leftSpaceToView(areaLabel, -1)
        .topSpaceToView(totalTextField, 2)
        .rightEqualToView(totalTextField)
        .heightIs(32);
        
        areaTextField.layer.borderWidth = 1;
        areaTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        addressLabel.sd_layout
        .leftEqualToView(areaLabel)
        .rightEqualToView(areaLabel)
        .topSpaceToView(areaLabel, 0)
        .heightIs(34);
        
        addressLabel.layer.borderWidth = 1;
        addressLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        addressTextField.sd_layout
        .leftSpaceToView(addressLabel, -1)
        .topSpaceToView(areaTextField, 2)
        .rightEqualToView(areaTextField)
        .heightIs(32);
        
        addressTextField.layer.borderWidth = 1;
        addressTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        addTurnsBtn.sd_layout
        .rightSpaceToView(backView, 11)
        .topSpaceToView(showView, 12)
        .widthIs(98)
        .heightIs(23);
        
        addTurnsBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        
        addTurnsBtn.imageView.sd_layout
        .leftSpaceToView(addTurnsBtn.titleLabel,3)
        .centerYEqualToView(addTurnsBtn)
        .heightIs(7)
        .widthIs(11);
        
        
        
        
        
        deleteBtn.sd_layout
        .topEqualToView(addTurnsBtn)
        .bottomEqualToView(addTurnsBtn)
        .rightSpaceToView(addTurnsBtn, 9)
        .widthIs(47);
    }
    return self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}





-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
     if (textField == _totalTextField){
        //    限制只能输入数字
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];//当前输入的字符
            if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
                if([textField.text length] == 0){
                    if(single == '.') {
                        // NSLog(@"数据格式有误");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                //输入的字符是否是小数点
                if (single == '.') {
                    if(!isHaveDian)//text中还没有小数点
                    {
                        isHaveDian = YES;
                        return YES;
                    }else{
                        // NSLog(@"数据格式有误");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {//存在小数点
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 0) {
                            return YES;
                        }else{
                            //  NSLog(@"最多两位小数");
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                // NSLog(@"数据格式有误");
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }else if (textField == _areaTextField){
        //    限制只能输入数字
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];//当前输入的字符
            if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
                if([textField.text length] == 0){
                    if(single == '.') {
                        // NSLog(@"数据格式有误");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                //输入的字符是否是小数点
                if (single == '.') {
                    if(!isHaveDian)//text中还没有小数点
                    {
                        isHaveDian = YES;
                        return YES;
                    }else{
                        // NSLog(@"数据格式有误");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {//存在小数点
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 3) {
                            return YES;
                        }else{
                            //  NSLog(@"最多两位小数");
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                // NSLog(@"数据格式有误");
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }else{
        return YES;
    }
}



- (void)textFieldDidBeginEditing:(UITextField *)textField{
     if (textField == _areaTextField){
        if ([_areaTextField.text isEqualToString:@"0.000"]|| [_areaTextField.text isEqualToString:@"0"]) {
            _areaTextField.text = @"";
        }
    }else if (textField == _totalTextField){
        if ( [_totalTextField.text isEqualToString:@"0"]) {
            _totalTextField.text = @"";
        }
    }
}






@end
