//
//  RSRSBigBoardChangeCell.m
//  石来石往
//
//  Created by mac on 2019/3/6.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSRSBigBoardChangeCell.h"

@implementation RSRSBigBoardChangeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        [self setupCell];
        
        
        
        
    }
    return self;
}


-(void)setupCell {
    UIView * backView = [[UIView alloc]init];
    
    backView.frame = CGRectMake(12, 10, SCW - 24, 117);
    backView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    [self.contentView addSubview:backView];
    
    UIView * blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    blueView.frame = CGRectMake(13, 10, 3, 13);
    [backView addSubview:blueView];
    
    //片号
    UITextField * filmNumberTextfield = [[UITextField alloc]init];
    filmNumberTextfield.placeholder = @"板号";
    filmNumberTextfield.frame = CGRectMake(20, 6, 120, 20);
    //filmNumberLabel.text = [NSString stringWithFormat:@"片号%d",1];
    filmNumberTextfield.font = [UIFont systemFontOfSize:14];
    filmNumberTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    filmNumberTextfield.textAlignment = NSTextAlignmentLeft;
    filmNumberTextfield.keyboardType = UIKeyboardTypeDefault;
    filmNumberTextfield.returnKeyType = UIReturnKeyDone;
    filmNumberTextfield.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
    [backView addSubview:filmNumberTextfield];
    _filmNumberTextfield = filmNumberTextfield;
    
    
//    UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    selectBtn.frame = CGRectMake(backView.frame.size.width - 11 - 18, 8, 18, 18);
//    [selectBtn setImage:[UIImage imageNamed:@"Oval 9"] forState:UIControlStateNormal];
//    [selectBtn setImage:[UIImage imageNamed:@"个人选中"] forState:UIControlStateSelected];
//    [backView addSubview:selectBtn];
    
    
    //长
    UILabel * longLabel = [[UILabel alloc]init];
    longLabel.frame = CGRectMake(11, 31, 40, 14);
    longLabel.text = @"长(cm)";
    longLabel.font = [UIFont systemFontOfSize:9];
    longLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    longLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:longLabel];
    
    
    //宽
    UILabel * wideLabel = [[UILabel alloc]init];
    wideLabel.frame = CGRectMake(CGRectGetMaxX(longLabel.frame) + 90, 30, 40, 14);
    wideLabel.text = @"宽(cm)";
    wideLabel.font = [UIFont systemFontOfSize:9];
    wideLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    wideLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:wideLabel];
    
    //厚
    UILabel * thickLabel = [[UILabel alloc]init];
    thickLabel.frame = CGRectMake(CGRectGetMaxX(wideLabel.frame) + 90, 30, 40, 14);
    thickLabel.text = @"厚(cm)";
    thickLabel.font = [UIFont systemFontOfSize:9];
    thickLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    thickLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:thickLabel];
    
    
    
    //长的值
    UITextField * longDetailLabel = [[UITextField alloc]init];
    longDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size = [self obtainLabelTextSize:@"0.1" andFont:longDetailLabel.font];
    longDetailLabel.frame = CGRectMake(longLabel.yj_x, CGRectGetMaxY(longLabel.frame), size.width, 20);
    longDetailLabel.text = @"0.1";
//    longDetailLabel.layer.borderWidth = 1;
    longDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
    longDetailLabel.keyboardType = UIKeyboardTypeDefault;
    longDetailLabel.returnKeyType = UIReturnKeyDone;
    longDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    longDetailLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:longDetailLabel];
    _longDetailLabel = longDetailLabel;
    
    
    //宽的值
    UITextField * wideDetialLabel = [[UITextField alloc]init];
    wideDetialLabel.font = [UIFont systemFontOfSize:14];
    CGSize size1 = [self obtainLabelTextSize:@"3.3" andFont:wideDetialLabel.font];
    wideDetialLabel.frame = CGRectMake(wideLabel.yj_x, CGRectGetMaxY(wideLabel.frame), size1.width, 20);
    wideDetialLabel.keyboardType = UIKeyboardTypeDefault;
    wideDetialLabel.returnKeyType = UIReturnKeyDone;
    wideDetialLabel.text = @"3.3";
//    wideDetialLabel.layer.borderWidth = 1;
    wideDetialLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
    
    wideDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    wideDetialLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:wideDetialLabel];
    _wideDetialLabel = wideDetialLabel;
    
    
    
    
    
    //厚的值
    UITextField * thickDeitalLabel = [[UITextField alloc]init];
    thickDeitalLabel.font = [UIFont systemFontOfSize:14];
    CGSize size2 = [self obtainLabelTextSize:@"10.1" andFont:thickDeitalLabel.font];
    thickDeitalLabel.frame = CGRectMake(thickLabel.yj_x, CGRectGetMaxY(thickLabel.frame), size2.width, 20);
    thickDeitalLabel.text = @"10.1";
//    thickDeitalLabel.layer.borderWidth = 1;
    thickDeitalLabel.keyboardType = UIKeyboardTypeDefault;
    thickDeitalLabel.returnKeyType = UIReturnKeyDone;
    thickDeitalLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
    
    thickDeitalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    thickDeitalLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:thickDeitalLabel];
    
    _thickDeitalLabel = thickDeitalLabel;
    
    
    //原生面积
    UILabel * originalAreaLabel = [[UILabel alloc]init];
    originalAreaLabel.frame = CGRectMake(longDetailLabel.yj_x, CGRectGetMaxY(longDetailLabel.frame) + 1, 70, 14);
    originalAreaLabel.text = @"原始面积(m²)";
    originalAreaLabel.font = [UIFont systemFontOfSize:10];
    originalAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    originalAreaLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:originalAreaLabel];
    
    
    //扣尺面积
    UILabel * deductionAreaLabel = [[UILabel alloc]init];
    deductionAreaLabel.frame = CGRectMake(wideDetialLabel.yj_x, CGRectGetMaxY(wideDetialLabel.frame) + 1, 70, 14);
    deductionAreaLabel.text = @"扣尺面积(m²)";
    deductionAreaLabel.font = [UIFont systemFontOfSize:10];
    deductionAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    deductionAreaLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:deductionAreaLabel];
    
    //实际面积
    UILabel * actualAreaLabel = [[UILabel alloc]init];
    actualAreaLabel.frame = CGRectMake(thickDeitalLabel.yj_x, CGRectGetMaxY(thickDeitalLabel.frame) + 1, 70, 14);
    actualAreaLabel.text = @"实际面积(m²)";
    actualAreaLabel.font = [UIFont systemFontOfSize:10];
    actualAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    actualAreaLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:actualAreaLabel];
    
    
    
    //原生面积的值
    UITextField * originalAreaDetailLabel = [[UITextField alloc]init];
    originalAreaDetailLabel.text = @"3.11";
    originalAreaDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size3 = [self obtainLabelTextSize:@"3.11" andFont:originalAreaDetailLabel.font];
    originalAreaDetailLabel.frame = CGRectMake(originalAreaLabel.yj_x, CGRectGetMaxY(originalAreaLabel.frame), size3.width, 20);
//    originalAreaDetailLabel.layer.borderWidth = 1;
    originalAreaDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
    originalAreaDetailLabel.keyboardType = UIKeyboardTypeDefault;
    originalAreaDetailLabel.returnKeyType = UIReturnKeyDone;
    originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    originalAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:originalAreaDetailLabel];
    _originalAreaDetailLabel = originalAreaDetailLabel;
    
    //扣尺面积的值
    UITextField * deductionAreaDetailLabel = [[UITextField alloc]init];
    deductionAreaDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size4 = [self obtainLabelTextSize:@"3.11" andFont:deductionAreaDetailLabel.font];
    deductionAreaDetailLabel.frame = CGRectMake(deductionAreaLabel.yj_x, CGRectGetMaxY(deductionAreaLabel.frame), size4.width, 20);
    deductionAreaDetailLabel.text = @"3.11";
    deductionAreaDetailLabel.keyboardType = UIKeyboardTypeDefault;
    deductionAreaDetailLabel.returnKeyType = UIReturnKeyDone;
    deductionAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    deductionAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:deductionAreaDetailLabel];
//    deductionAreaDetailLabel.layer.borderWidth = 1;
    deductionAreaDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
    _deductionAreaDetailLabel = deductionAreaDetailLabel;
    //实际面积的值
    UITextField * actualAreaDetailLabel = [[UITextField alloc]init];
    actualAreaDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size5 = [self obtainLabelTextSize:@"3.11" andFont: actualAreaDetailLabel.font];
    actualAreaDetailLabel.frame = CGRectMake(actualAreaLabel.yj_x, CGRectGetMaxY(actualAreaLabel.frame), size5.width, 20);
    actualAreaDetailLabel.text = @"3.11";
    actualAreaDetailLabel.keyboardType = UIKeyboardTypeDefault;
    actualAreaDetailLabel.returnKeyType = UIReturnKeyDone;
    actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    actualAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:actualAreaDetailLabel];
//    actualAreaDetailLabel.layer.borderWidth = 1;
    actualAreaDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"].CGColor;
    _actualAreaDetailLabel = actualAreaDetailLabel;
//    UIView * bottomview = [[UIView alloc]init];
//    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    bottomview.frame = CGRectMake(12,CGRectGetMaxY(backView.frame) , SCW - 24, 10);
//    [self.contentView addSubview:bottomview];

}

- (CGSize)obtainLabelTextSize:(NSString *)text andFont:(UIFont *)font{
    CGSize size = [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil].size;
    return size;
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
