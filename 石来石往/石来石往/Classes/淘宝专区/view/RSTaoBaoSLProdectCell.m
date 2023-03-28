//
//  RSTaoBaoSLProdectCell.m
//  石来石往
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoSLProdectCell.h"

@interface RSTaoBaoSLProdectCell()

@property (nonatomic,strong)UILabel * filmNumberLabel;

@property (nonatomic,strong)UITextField * longDetailLabel;

@property (nonatomic,strong)UITextField * wideDetialLabel;

@property (nonatomic,strong)UITextField * thickDeitalLabel;


@property (nonatomic,strong)UITextField * originalAreaDetailLabel;

@property (nonatomic,strong)UITextField * deductionAreaDetailLabel;

@property (nonatomic,strong)UITextField * actualAreaDetailLabel;

@property (nonatomic,strong)UILabel * originalAreaLabel;
@property (nonatomic,strong)UILabel *longLabel;
@property (nonatomic,strong)UILabel * wideLabel;
@property (nonatomic,strong)UILabel * thickLabel;
@property (nonatomic,strong)UILabel *deductionAreaLabel;
@property (nonatomic,strong)UILabel * actualAreaLabel;


@end


@implementation RSTaoBaoSLProdectCell

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
    blueView.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    blueView.frame = CGRectMake(13, 10, 3, 13);
    [backView addSubview:blueView];
    
    //片号
    UILabel * filmNumberLabel = [[UILabel alloc]init];
    filmNumberLabel.text = @"匝号：4-1 12片";
    filmNumberLabel.frame = CGRectMake(20, 6, 120, 20);
    filmNumberLabel.font = [UIFont systemFontOfSize:14];
    filmNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    filmNumberLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:filmNumberLabel];
    _filmNumberLabel = filmNumberLabel;

    
    //长
    UILabel * longLabel = [[UILabel alloc]init];
    longLabel.frame = CGRectMake(11, 31, 40, 14);
    longLabel.text = @"长(cm)";
    longLabel.font = [UIFont systemFontOfSize:9];
    longLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    longLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:longLabel];
    _longLabel = longLabel;
    
    //宽
    UILabel * wideLabel = [[UILabel alloc]init];
    wideLabel.frame = CGRectMake(CGRectGetMaxX(longLabel.frame) + 90, 30, 40, 14);
    wideLabel.text = @"宽(cm)";
    wideLabel.font = [UIFont systemFontOfSize:9];
    wideLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    wideLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:wideLabel];
    _wideLabel = wideLabel;
    //厚
    UILabel * thickLabel = [[UILabel alloc]init];
    thickLabel.frame = CGRectMake(CGRectGetMaxX(wideLabel.frame) + 90, 30, 40, 14);
    thickLabel.text = @"厚(cm)";
    thickLabel.font = [UIFont systemFontOfSize:9];
    thickLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    thickLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:thickLabel];
    _thickLabel = thickLabel;
    
    
    //长的值
    UITextField * longDetailLabel = [[UITextField alloc]init];
    longDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size = [self obtainLabelTextSize:@"0.1" andFont:longDetailLabel.font];
    longDetailLabel.frame = CGRectMake(longLabel.yj_x, CGRectGetMaxY(longLabel.frame), size.width, 20);
    longDetailLabel.text = @"0.1";
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
    thickDeitalLabel.keyboardType = UIKeyboardTypeDefault;
    thickDeitalLabel.returnKeyType = UIReturnKeyDone;
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
    _originalAreaLabel = originalAreaLabel;
    
    //扣尺面积
    UILabel * deductionAreaLabel = [[UILabel alloc]init];
    deductionAreaLabel.frame = CGRectMake(wideDetialLabel.yj_x, CGRectGetMaxY(wideDetialLabel.frame) + 1, 70, 14);
    deductionAreaLabel.text = @"扣尺面积(m²)";
    deductionAreaLabel.font = [UIFont systemFontOfSize:10];
    deductionAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    deductionAreaLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:deductionAreaLabel];
    _deductionAreaLabel = deductionAreaLabel;
    //实际面积
    UILabel * actualAreaLabel = [[UILabel alloc]init];
    actualAreaLabel.frame = CGRectMake(thickDeitalLabel.yj_x, CGRectGetMaxY(thickDeitalLabel.frame) + 1, 70, 14);
    actualAreaLabel.text = @"实际面积(m²)";
    actualAreaLabel.font = [UIFont systemFontOfSize:10];
    actualAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    actualAreaLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:actualAreaLabel];
    _actualAreaLabel = actualAreaLabel;
    
    
    //原生面积的值
    UITextField * originalAreaDetailLabel = [[UITextField alloc]init];
    originalAreaDetailLabel.text = @"3.11";
    originalAreaDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size3 = [self obtainLabelTextSize:@"3.11" andFont:originalAreaDetailLabel.font];
    originalAreaDetailLabel.frame = CGRectMake(originalAreaLabel.yj_x, CGRectGetMaxY(originalAreaLabel.frame), size3.width, 20);
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
    _actualAreaDetailLabel = actualAreaDetailLabel;
}

- (CGSize)obtainLabelTextSize:(NSString *)text andFont:(UIFont *)font{
    CGSize size = [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil].size;
    return size;
}


- (void)setTaobaoStoneDtlmodel:(RSTaobaoStoneDtlModel *)taobaoStoneDtlmodel{
    _taobaoStoneDtlmodel = taobaoStoneDtlmodel;
    
    _filmNumberLabel.text = [NSString stringWithFormat:@"匝号：%@ %ld片",_taobaoStoneDtlmodel.turnNo,_taobaoStoneDtlmodel.turnQty];
    _longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[_taobaoStoneDtlmodel.length floatValue]];
    _wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[_taobaoStoneDtlmodel.width floatValue]];
    
     _thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[_taobaoStoneDtlmodel.height floatValue]];
    
    _originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[_taobaoStoneDtlmodel.preArea floatValue]];
    
    _deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[_taobaoStoneDtlmodel.dedArea floatValue]];
    
    _actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[_taobaoStoneDtlmodel.area floatValue]];
    
    
    
    
    CGSize size = [self obtainLabelTextSize:_longDetailLabel.text andFont:_longDetailLabel.font];
    _longDetailLabel.frame = CGRectMake(_longLabel.yj_x, CGRectGetMaxY(_longLabel.frame), size.width, 20);
    
    
    CGSize size1 = [self obtainLabelTextSize:_wideDetialLabel.text andFont:_wideDetialLabel.font];
    _wideDetialLabel.frame = CGRectMake(_wideLabel.yj_x, CGRectGetMaxY(_wideLabel.frame), size1.width, 20);
    
    
    CGSize size2 = [self obtainLabelTextSize:_thickDeitalLabel.text andFont:_thickDeitalLabel.font];
    _thickDeitalLabel.frame = CGRectMake(_thickLabel.yj_x, CGRectGetMaxY(_thickLabel.frame), size2.width, 20);
    
    
    CGSize size3 = [self obtainLabelTextSize:_originalAreaDetailLabel.text andFont:_originalAreaDetailLabel.font];
    _originalAreaDetailLabel.frame = CGRectMake(_originalAreaLabel.yj_x, CGRectGetMaxY(_originalAreaLabel.frame), size3.width, 20);
    
    
    
    CGSize size4 = [self obtainLabelTextSize:_deductionAreaDetailLabel.text andFont:_deductionAreaDetailLabel.font];
    _deductionAreaDetailLabel.frame = CGRectMake(_deductionAreaLabel.yj_x, CGRectGetMaxY(_deductionAreaLabel.frame), size4.width, 20);
    
    
    
    CGSize size5 = [self obtainLabelTextSize:_actualAreaDetailLabel.text andFont:_actualAreaDetailLabel.font];
    _actualAreaDetailLabel.frame = CGRectMake(_actualAreaLabel.yj_x, CGRectGetMaxY(_actualAreaLabel.frame), size5.width, 20);
    
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
