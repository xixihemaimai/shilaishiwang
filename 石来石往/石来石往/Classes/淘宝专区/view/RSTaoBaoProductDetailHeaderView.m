//
//  RSTaoBaoProductDetailHeaderView.m
//  石来石往
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoProductDetailHeaderView.h"

@interface RSTaoBaoProductDetailHeaderView()<UITextFieldDelegate>


    



@end


@implementation RSTaoBaoProductDetailHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        
        
        
        UIView * backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:backView];
        _backView = backView;
        
        
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [backView addSubview:showView];
        _showView = showView;
        
        
        
        
        //荒料号
        UITextField * blockNoLabelTextField = [[UITextField alloc]init];
        blockNoLabelTextField.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
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

        //宽
        UILabel * widthLabel = [[UILabel alloc]init];
        widthLabel.text = @"宽(cm)";
        widthLabel.textAlignment = NSTextAlignmentCenter;
        widthLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        widthLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        widthLabel.font = [UIFont systemFontOfSize:14];
        [showView addSubview:widthLabel];
        
        
        UITextField * widthTextField = [[UITextField alloc]init];
        widthTextField.textAlignment = NSTextAlignmentCenter;
        widthTextField.font = [UIFont systemFontOfSize:15];
        widthTextField.returnKeyType = UIReturnKeyDone;
        
        widthTextField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        widthTextField.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        [showView addSubview:widthTextField];
        _widthTextField = widthTextField;
       
        //面积
        UILabel * areaLabel = [[UILabel alloc]init];
        areaLabel.text = @"体积(m³)";
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
        
        
        //长
        UILabel * lenghtLabel = [[UILabel alloc]init];
        lenghtLabel.text = @"长(cm)";
        lenghtLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        lenghtLabel.textAlignment = NSTextAlignmentCenter;
        lenghtLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        lenghtLabel.font = [UIFont systemFontOfSize:14];
        [showView addSubview:lenghtLabel];
        
        
        UITextField * lenghtTextField = [[UITextField alloc]init];
        lenghtTextField.textAlignment = NSTextAlignmentCenter;
        lenghtTextField.font = [UIFont systemFontOfSize:15];
        lenghtTextField.returnKeyType = UIReturnKeyDone;
        
        lenghtTextField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        lenghtTextField.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        [showView addSubview:lenghtTextField];
        _lenghtTextField = lenghtTextField;
        
        //厚
        UILabel * heightLabel = [[UILabel alloc]init];
        heightLabel.text = @"高(cm)";
        heightLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        heightLabel.textAlignment = NSTextAlignmentCenter;
        heightLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        heightLabel.font = [UIFont systemFontOfSize:14];
        [showView addSubview:heightLabel];
        
        
        UITextField * heightTextField = [[UITextField alloc]init];
        heightTextField.textAlignment = NSTextAlignmentCenter;
        heightTextField.font = [UIFont systemFontOfSize:15];
        heightTextField.returnKeyType = UIReturnKeyDone;
        
        heightTextField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        heightTextField.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        [showView addSubview:heightTextField];
        _heightTextField = heightTextField;
        
        
        //总匝数
        
        UILabel * totalLabel = [[UILabel alloc]init];
        totalLabel.text = @"重量(吨)";
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
        widthTextField.delegate = self;
        areaTextField.delegate = self;
        lenghtTextField.delegate = self;
        heightTextField.delegate = self;
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
        
        
        blockNoLabelTextField.sd_layout
        .leftSpaceToView(showView, 0)
        .rightSpaceToView(showView, 0)
        .topSpaceToView(showView, 0)
        .heightIs(34);
        
        
        typeLabel.sd_layout
        .leftSpaceToView(showView, 0)
        .topSpaceToView(blockNoLabelTextField, 1)
        .widthIs(77)
        .heightIs(34);
        
        
        typeLabel.layer.borderWidth = 1;
        typeLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        typeTextField.sd_layout
        .topSpaceToView(blockNoLabelTextField, 2)
        .leftSpaceToView(typeLabel, 0)
        .heightIs(32)
        .widthIs(SCW/2 - 12 - 77 - 11);
        
        typeTextField.layer.borderWidth = 1;
        typeTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        widthLabel.sd_layout
        .leftEqualToView(typeLabel)
        .rightEqualToView(typeLabel)
        .topSpaceToView(typeLabel, 1)
        .heightIs(34);
        
        widthLabel.layer.borderWidth = 1;
        widthLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        widthTextField.sd_layout
        .topSpaceToView(typeTextField, 3)
        .leftSpaceToView(widthLabel, 0)
        .heightIs(32)
        .widthIs(SCW/2 - 12 - 77 - 11);
        
        widthTextField.layer.borderWidth = 1;
        widthTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        areaLabel.sd_layout
        .leftEqualToView(widthLabel)
        .rightEqualToView(widthLabel)
        .topSpaceToView(widthLabel, 1)
        .heightIs(34);
        
        areaLabel.layer.borderWidth = 1;
        areaLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        areaTextField.sd_layout
        .topSpaceToView(widthTextField, 3)
        .leftSpaceToView(areaLabel, 0)
        .heightIs(32)
        .widthIs(SCW/2 - 12 - 77 - 11);
        
        areaTextField.layer.borderWidth = 1;
        areaTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        
        
        
        lenghtLabel.sd_layout
        .leftSpaceToView(typeTextField, 0)
        .topSpaceToView(blockNoLabelTextField, 1)
        .heightIs(34)
        .widthIs(77);
        
        
        lenghtLabel.layer.borderWidth = 1;
        lenghtLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        lenghtTextField.sd_layout
        .leftSpaceToView(lenghtLabel, 0)
        .topSpaceToView(blockNoLabelTextField, 2)
        .heightIs(32)
        .rightSpaceToView(showView, 0);
        
        lenghtTextField.layer.borderWidth = 1;
        lenghtTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;

        
        heightLabel.sd_layout
        .leftSpaceToView(widthTextField, 0)
        .topSpaceToView(lenghtLabel, 1)
        .heightIs(34)
        .rightEqualToView(lenghtLabel);
        
        
        heightLabel.layer.borderWidth = 1;
        heightLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        
        heightTextField.sd_layout
        .leftSpaceToView(heightLabel, 0)
        .topSpaceToView(lenghtTextField, 3)
        .heightIs(32)
        .rightSpaceToView(showView, 0);
        
        heightTextField.layer.borderWidth = 1;
        heightTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        totalLabel.sd_layout
        .leftSpaceToView(areaTextField, 0)
        .topSpaceToView(heightLabel, 1)
        .rightEqualToView(heightLabel)
        .heightIs(34);
        
        totalLabel.layer.borderWidth = 1;
        totalLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
       totalTextField.sd_layout
        .leftSpaceToView(totalLabel, 0)
        .topSpaceToView(heightTextField, 3)
        .heightIs(32)
        .rightSpaceToView(showView, 0);
        
        totalTextField.layer.borderWidth = 1;
        totalTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        
        
        
        addressLabel.sd_layout
        .leftSpaceToView(showView, 0)
        .topSpaceToView(areaLabel, 1)
        .heightIs(34)
        .rightEqualToView(areaLabel);
        
        
        
        addressTextField.sd_layout
        .leftSpaceToView(addressLabel, 0)
        .rightSpaceToView(showView, 0)
        .topSpaceToView(areaTextField, 3)
        .heightIs(32);
        
        
        addressTextField.layer.borderWidth = 1;
        addressTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        deleteBtn.sd_layout
        .rightSpaceToView(backView, 11)
        .topSpaceToView(showView, 12)
        .widthIs(47)
        .heightIs(23);

        
    }
    return self;
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}





-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    if (textField == _lenghtTextField || textField == _widthTextField) {
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];
            if ((single >= '0' && single <= '9') || single == '.') {
                if([textField.text length] == 0){
                    if(single == '.') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                if (single == '.') {
                    if(!isHaveDian)
                    {
                        isHaveDian = YES;
                        return YES;
                    }else{
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 1) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }else if (textField == _totalTextField){
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];
            if ((single >= '0' && single <= '9') || single == '.') {
                if([textField.text length] == 0){
                    if(single == '.') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                if (single == '.') {
                    if(!isHaveDian)
                    {
                        isHaveDian = YES;
                        return YES;
                    }else{
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 3) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }else if (textField == _heightTextField){
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];
            if ((single >= '0' && single <= '9') || single == '.') {
                if([textField.text length] == 0){
                    if(single == '.') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                if (single == '.') {
                    if(!isHaveDian)
                    {
                        isHaveDian = YES;
                        return YES;
                    }else{
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 2) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }else if (textField == _areaTextField){
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];
            if ((single >= '0' && single <= '9') || single == '.') {
                if([textField.text length] == 0){
                    if(single == '.') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                if (single == '.') {
                    if(!isHaveDian)
                    {
                        isHaveDian = YES;
                        return YES;
                    }else{
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 3) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{
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
    if (textField == _widthTextField) {
        if ([_widthTextField.text isEqualToString:@"0.0"] || [_widthTextField.text isEqualToString:@"0"] || [_widthTextField.text isEqualToString:@"0.000"] || [_widthTextField.text isEqualToString:@"0.0"] ) {
            _widthTextField.text = @"";
        }
    }else if (textField == _areaTextField){
        if ([_areaTextField.text isEqualToString:@"0.000"]|| [_areaTextField.text isEqualToString:@"0"]||[_areaTextField.text isEqualToString:@"0.00"] || [_areaTextField.text isEqualToString:@"0.0"]) {
            _areaTextField.text = @"";
        }
    }else if (textField == _lenghtTextField){
        if ([_lenghtTextField.text isEqualToString:@"0.000"]|| [_lenghtTextField.text isEqualToString:@"0"]||[_lenghtTextField.text isEqualToString:@"0.00"] || [_lenghtTextField.text isEqualToString:@"0.0"] ) {
            _lenghtTextField.text = @"";
        }
    }else if (textField == _heightTextField){
        if ([_heightTextField.text isEqualToString:@"0.000"]|| [_heightTextField.text isEqualToString:@"0"]||[_heightTextField.text isEqualToString:@"0.00"] || [_heightTextField.text isEqualToString:@"0.0"]) {
            _heightTextField.text = @"";
        }
    }else if (textField == _totalTextField){
        if ([_totalTextField.text isEqualToString:@"0.000"]|| [_totalTextField.text isEqualToString:@"0"]||[_totalTextField.text isEqualToString:@"0.00"] || [_totalTextField.text isEqualToString:@"0.0"]) {
            _totalTextField.text = @"";
        }
    }
}













@end
