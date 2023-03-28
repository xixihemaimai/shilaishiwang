//
//  RSTaoBaoProductDetialCell.m
//  石来石往
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoProductDetialCell.h"

@interface RSTaoBaoProductDetialCell()<UITextFieldDelegate>



@end



@implementation RSTaoBaoProductDetialCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        
        
        UIView * backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:backView];
        
        
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
        [backView addSubview:showView];
        
        
        
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"淘石删除"] forState:UIControlStateNormal];
        [showView addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
        
        
        //匝号
        UILabel * turnsNoLabel = [[UILabel alloc]init];
        turnsNoLabel.text = @"匝号";
        turnsNoLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        turnsNoLabel.font = [UIFont systemFontOfSize:10];
        turnsNoLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:turnsNoLabel];
        
        
        
        
        UITextField * turnNoTextField = [[UITextField alloc]init];
        turnNoTextField.textAlignment = NSTextAlignmentLeft;
        turnNoTextField.delegate = self;
        turnNoTextField.returnKeyType = UIReturnKeyDone;
        [showView addSubview:turnNoTextField];
        _turnNoTextField = turnNoTextField;
        
        
        
        
        //长
        UILabel * lenghtLabel = [[UILabel alloc]init];
        lenghtLabel.text = @"长(cm)";
        lenghtLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        lenghtLabel.font = [UIFont systemFontOfSize:10];
        lenghtLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:lenghtLabel];
        
        
        
        
        UITextField * lenghtTextField = [[UITextField alloc]init];
        lenghtTextField.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:lenghtTextField];
        lenghtTextField.delegate = self;
         lenghtTextField.returnKeyType = UIReturnKeyDone;
        _lenghtTextField = lenghtTextField;
        
        
        //厚
        
        UILabel * heightLabel = [[UILabel alloc]init];
        heightLabel.text = @"厚(cm)";
        heightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        heightLabel.font = [UIFont systemFontOfSize:10];
        heightLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:heightLabel];
        
        
        
        
        UITextField * heightTextField = [[UITextField alloc]init];
        heightTextField.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:heightTextField];
        heightTextField.delegate = self;
        heightTextField.returnKeyType = UIReturnKeyDone;
        _heightTextField = heightTextField;
        
        
        //扣尺面积
        
        UILabel * buckleAreaLabel = [[UILabel alloc]init];
        buckleAreaLabel.text = @"扣尺面积(m²)";
        buckleAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        buckleAreaLabel.font = [UIFont systemFontOfSize:10];
        buckleAreaLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:buckleAreaLabel];
        
        
        
        
        UITextField * buckleAreaTextField = [[UITextField alloc]init];
        buckleAreaTextField.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:buckleAreaTextField];
        buckleAreaTextField.delegate = self;
        buckleAreaTextField.returnKeyType = UIReturnKeyDone;
        _buckleAreaTextField = buckleAreaTextField;
        
        //片数
        
        UILabel * numberLabel = [[UILabel alloc]init];
        numberLabel.text = @"片数";
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        numberLabel.font = [UIFont systemFontOfSize:10];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:numberLabel];
        
        
        
        
        UITextField * numberTextField = [[UITextField alloc]init];
        numberTextField.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:numberTextField];
        numberTextField.delegate = self;
        numberTextField.returnKeyType = UIReturnKeyDone;
        _numberTextField = numberTextField;
        //宽
        
        
        UILabel * widthLabel = [[UILabel alloc]init];
        widthLabel.text = @"宽(cm)";
        widthLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        widthLabel.font = [UIFont systemFontOfSize:10];
        widthLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:widthLabel];
        
        
        
        
        UITextField * widthTextField = [[UITextField alloc]init];
        widthTextField.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:widthTextField];
        widthTextField.delegate = self;
        widthTextField.returnKeyType = UIReturnKeyDone;
        _widthTextField = widthTextField;
        
        
        //原始面积
        UILabel * primitiveAreaLabel = [[UILabel alloc]init];
        primitiveAreaLabel.text = @"原始面积(m²)";
        primitiveAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        primitiveAreaLabel.font = [UIFont systemFontOfSize:10];
        primitiveAreaLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:primitiveAreaLabel];
        
        
        
        
        UITextField * primitiveAreaTextField = [[UITextField alloc]init];
        primitiveAreaTextField.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:primitiveAreaTextField];
        primitiveAreaTextField.delegate = self;
        primitiveAreaTextField.returnKeyType = UIReturnKeyDone;
        _primitiveAreaTextField = primitiveAreaTextField;
        
        //实际面积
        UILabel * actualAreaLabel = [[UILabel alloc]init];
        actualAreaLabel.text = @"实际面积(m²)";
        actualAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        actualAreaLabel.font = [UIFont systemFontOfSize:10];
        actualAreaLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:actualAreaLabel];
        
        
        
        
        UITextField * actualAreaTextField = [[UITextField alloc]init];
        actualAreaTextField.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:actualAreaTextField];
        actualAreaTextField.delegate = self;
        actualAreaTextField.returnKeyType = UIReturnKeyDone;
        
        _actualAreaTextField = actualAreaTextField;
        
        
        
        backView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        showView.sd_layout
        .leftSpaceToView(backView, 11)
        .rightSpaceToView(backView, 11)
        .topSpaceToView(backView, 5)
        .bottomSpaceToView(backView, 0);
        
        showView.layer.cornerRadius = 6;
        
        
        
        deleteBtn.sd_layout
        .topSpaceToView(showView, 8)
        .widthIs(20)
        .heightIs(20)
        .rightSpaceToView(showView, 12);
        
        
        turnsNoLabel.sd_layout
        .leftSpaceToView(showView, 12)
        .topSpaceToView(showView, 34)
        .heightIs(20)
        .widthIs(62);
        
        
        
        turnNoTextField.sd_layout
        .leftSpaceToView(turnsNoLabel, 0)
        .topEqualToView(turnsNoLabel)
        .bottomEqualToView(turnsNoLabel)
        .widthIs(80);
        
        
        turnNoTextField.layer.borderWidth = 1;
        turnNoTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
        
        
        
        lenghtLabel.sd_layout
        .leftEqualToView(turnsNoLabel)
        .rightEqualToView(turnsNoLabel)
        .topSpaceToView(turnsNoLabel, 8)
        .heightIs(20);
        
        
        lenghtTextField.sd_layout
        .leftSpaceToView(lenghtLabel, 0)
        .topEqualToView(lenghtLabel)
        .bottomEqualToView(lenghtLabel)
        .widthIs(80);
        
        
        lenghtTextField.layer.borderWidth = 1;
        lenghtTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
        
        
        
        heightLabel.sd_layout
        .leftEqualToView(lenghtLabel)
        .rightEqualToView(lenghtLabel)
        .topSpaceToView(lenghtLabel, 8)
        .heightIs(20);
        
        
        heightTextField.sd_layout
        .leftSpaceToView(heightLabel, 0)
        .topEqualToView(heightLabel)
        .bottomEqualToView(heightLabel)
        .widthIs(80);
        
        
        heightTextField.layer.borderWidth = 1;
        heightTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
        
        
        buckleAreaLabel.sd_layout
        .leftEqualToView(heightLabel)
        .rightEqualToView(heightLabel)
        .topSpaceToView(heightLabel, 8)
        .heightIs(20);
        
        buckleAreaTextField.sd_layout
        .leftSpaceToView(buckleAreaLabel, 0)
        .topEqualToView(buckleAreaLabel)
        .bottomEqualToView(buckleAreaLabel)
        .widthIs(80);
        
        
        buckleAreaTextField.layer.borderWidth = 1;
        buckleAreaTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
        
        
        
        
        numberLabel.sd_layout
        .leftSpaceToView(turnNoTextField, 10)
        .topEqualToView(turnNoTextField)
        .bottomEqualToView(turnNoTextField)
        .widthIs(62);
        
        
        numberTextField.sd_layout
        .leftSpaceToView(numberLabel, 0)
        .widthIs(80)
        .topEqualToView(numberLabel)
        .bottomEqualToView(numberLabel);
        
        numberTextField.layer.borderWidth = 1;
        numberTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
        
        
        
        widthLabel.sd_layout
        .leftEqualToView(numberLabel)
        .rightEqualToView(numberLabel)
        .topSpaceToView(numberLabel, 8)
        .heightIs(20);
        
        widthTextField.sd_layout
        .leftSpaceToView(widthLabel, 0)
        .topEqualToView(widthLabel)
        .bottomEqualToView(widthLabel)
        .widthIs(80);
        
        widthTextField.layer.borderWidth = 1;
        widthTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
        
        primitiveAreaLabel.sd_layout
        .leftEqualToView(widthLabel)
        .rightEqualToView(widthLabel)
        .topSpaceToView(widthLabel, 8)
        .heightIs(20);
        
        
        primitiveAreaTextField.sd_layout
        .leftSpaceToView(primitiveAreaLabel, 0)
        .topEqualToView(primitiveAreaLabel)
        .bottomEqualToView(primitiveAreaLabel)
        .widthIs(80);
        
        primitiveAreaTextField.layer.borderWidth = 1;
        primitiveAreaTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
        
        actualAreaLabel.sd_layout
        .leftEqualToView(primitiveAreaLabel)
        .rightEqualToView(primitiveAreaLabel)
        .topSpaceToView(primitiveAreaLabel, 8)
        .heightIs(20);
        
        
        actualAreaTextField.sd_layout
        .leftSpaceToView(actualAreaLabel, 0)
        .topEqualToView(actualAreaLabel)
        .bottomEqualToView(actualAreaLabel)
        .widthIs(80);
        
        
        actualAreaTextField.layer.borderWidth = 1;
        actualAreaTextField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
        

        
    }
    return self;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}





-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    if (textField == _lenghtTextField || textField == _widthTextField) {
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
                        if (range.location - ran.location <= 1) {
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
    }else if (textField == _numberTextField){
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
    }else if (textField == _heightTextField){
        
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
                        if (range.location - ran.location <= 2) {
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
    }else if (textField == _actualAreaTextField || textField == _primitiveAreaTextField || textField == _buckleAreaTextField){
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
    if (textField == _lenghtTextField) {
        if ([_lenghtTextField.text isEqualToString:@"0.0"] || [_lenghtTextField.text isEqualToString:@"0"]) {
            _lenghtTextField.text = @"";
        }
    }else if (textField == _heightTextField){
        if ([_heightTextField.text isEqualToString:@"0.00"]|| [_heightTextField.text isEqualToString:@"0"]) {
            _heightTextField.text = @"";
        }
    }else if (textField == _buckleAreaTextField){
        if ([_buckleAreaTextField.text isEqualToString:@"0.000"] || [_buckleAreaTextField.text isEqualToString:@"0"]) {
            _buckleAreaTextField.text = @"";
        }
    }else if (textField == _numberTextField){
        if ( [_numberTextField.text isEqualToString:@"0"]) {
            _numberTextField.text = @"";
        }
    }else if (textField == _widthTextField){
        if ( [_widthTextField.text isEqualToString:@"0.0"]) {
            _widthTextField.text = @"";
        }
    }
    else if (textField == _primitiveAreaTextField){
        if ( [_primitiveAreaTextField.text isEqualToString:@"0.000"] || [_primitiveAreaTextField.text isEqualToString:@"0.0"]) {
            _primitiveAreaTextField.text = @"";
        }
    }
    else if (textField == _actualAreaTextField){
        if ( [_actualAreaTextField.text isEqualToString:@"0.000"] || [_actualAreaTextField.text isEqualToString:@"0.0"]) {
            _actualAreaTextField.text = @"";
        }
    }
}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
