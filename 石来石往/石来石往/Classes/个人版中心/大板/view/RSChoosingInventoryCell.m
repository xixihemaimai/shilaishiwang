//
//  RSChoosingInventoryCell.m
//  石来石往
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSChoosingInventoryCell.h"

@interface RSChoosingInventoryCell()

/// 标题的背景
@property (nonatomic, strong) UIView *backView;

@end


@implementation RSChoosingInventoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
        [self setupCell];
        
 
    }
    return self;
}

-(void)setupCell {
    self.backView = [[UIView alloc]init];
    self.backView.userInteractionEnabled = YES;
    self.backView.frame = CGRectMake(12, 0, SCW - 24, 111);
    self.backView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    [self.contentView addSubview:self.backView];
    
    UIView * blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    blueView.frame = CGRectMake(13, 10, 3, 13);
    [self.backView addSubview:blueView];
    _blueView = blueView;
    //片号
    UILabel * filmNumberLabel = [[UILabel alloc]init];
    filmNumberLabel.frame = CGRectMake(20, 6, 120, 20);
    filmNumberLabel.text = [NSString stringWithFormat:@"片号%d",1];
    filmNumberLabel.font = [UIFont systemFontOfSize:14];
    filmNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    filmNumberLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:filmNumberLabel];
    _filmNumberLabel = filmNumberLabel;
    
    
    //图片
    UIImageView * iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(filmNumberLabel.frame), 6, 50, 20)];
    iamgeView.image = [UIImage imageNamed:@"印章 To be reviewed"];
    [self.backView addSubview:iamgeView];
    _iamgeView = iamgeView;
    
    
    UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(self.backView.frame.size.width - 11 - 18, 8, 25,25);
    [selectBtn setImage:[UIImage imageNamed:@"Oval 9"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"个人选中"] forState:UIControlStateSelected];
    [self.backView addSubview:selectBtn];
    _selectBtn = selectBtn;
    
    //长
    UILabel * longLabel = [[UILabel alloc]init];
    longLabel.frame = CGRectMake(11, 31, 40, 14);
    longLabel.text = @"长(cm)";
    longLabel.font = [UIFont systemFontOfSize:9];
    longLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    longLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:longLabel];
    
    
    //宽
    UILabel * wideLabel = [[UILabel alloc]init];
    wideLabel.frame = CGRectMake(CGRectGetMaxX(longLabel.frame) + 90, 30, 40, 14);
    wideLabel.text = @"宽(cm)";
    wideLabel.font = [UIFont systemFontOfSize:9];
    wideLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    wideLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:wideLabel];
    
    //厚
    UILabel * thickLabel = [[UILabel alloc]init];
    thickLabel.frame = CGRectMake(CGRectGetMaxX(wideLabel.frame) + 90, 30, 40, 14);
    thickLabel.text = @"厚(cm)";
    thickLabel.font = [UIFont systemFontOfSize:9];
    thickLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    thickLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:thickLabel];
    
    
    
    //长的值
    UILabel * longDetailLabel = [[UILabel alloc]init];
    longDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size = [self obtainLabelTextSize:@"0.1" andFont:longDetailLabel.font];
    longDetailLabel.frame = CGRectMake(longLabel.yj_x, CGRectGetMaxY(longLabel.frame), size.width, 14);
    longDetailLabel.text = @"0.1";
    
    
    longDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    longDetailLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:longDetailLabel];
    _longDetailLabel= longDetailLabel;
    
    
    //宽的值
    UILabel * wideDetialLabel = [[UILabel alloc]init];
    wideDetialLabel.font = [UIFont systemFontOfSize:14];
    CGSize size1 = [self obtainLabelTextSize:@"3.3" andFont:wideDetialLabel.font];
    wideDetialLabel.frame = CGRectMake(wideLabel.yj_x, CGRectGetMaxY(wideLabel.frame), size1.width, 14);
    wideDetialLabel.text = @"3.3";
    
    wideDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    wideDetialLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:wideDetialLabel];
    _wideDetialLabel = wideDetialLabel;
    
 
    //厚的值
    UILabel * thickDeitalLabel = [[UILabel alloc]init];
    thickDeitalLabel.font = [UIFont systemFontOfSize:14];
    CGSize size2 = [self obtainLabelTextSize:@"10.1" andFont:thickDeitalLabel.font];
    thickDeitalLabel.frame = CGRectMake(thickLabel.yj_x, CGRectGetMaxY(thickLabel.frame), size2.width, 14);
    thickDeitalLabel.text = @"10.1";
    
    thickDeitalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    thickDeitalLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:thickDeitalLabel];
    _thickDeitalLabel = thickDeitalLabel;
    
    
    
    //原生面积
    UILabel * originalAreaLabel = [[UILabel alloc]init];
    originalAreaLabel.frame = CGRectMake(longDetailLabel.yj_x, CGRectGetMaxY(longDetailLabel.frame) + 1, 70, 14);
    originalAreaLabel.text = @"原始面积(m²)";
    originalAreaLabel.font = [UIFont systemFontOfSize:10];
    originalAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    originalAreaLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:originalAreaLabel];
    
    
    //扣尺面积
    UILabel * deductionAreaLabel = [[UILabel alloc]init];
    deductionAreaLabel.frame = CGRectMake(wideDetialLabel.yj_x, CGRectGetMaxY(wideDetialLabel.frame) + 1, 70, 14);
    deductionAreaLabel.text = @"扣尺面积(m²)";
    deductionAreaLabel.font = [UIFont systemFontOfSize:10];
    deductionAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    deductionAreaLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:deductionAreaLabel];
    
    //实际面积
    UILabel * actualAreaLabel = [[UILabel alloc]init];
    actualAreaLabel.frame = CGRectMake(thickDeitalLabel.yj_x, CGRectGetMaxY(thickDeitalLabel.frame) + 1, 70, 14);
    actualAreaLabel.text = @"实际面积(m²)";
    actualAreaLabel.font = [UIFont systemFontOfSize:10];
    actualAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    actualAreaLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:actualAreaLabel];
    
    
    
    //原生面积的值
    UILabel * originalAreaDetailLabel = [[UILabel alloc]init];
    originalAreaDetailLabel.text = @"3.11";
    originalAreaDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size3 = [self obtainLabelTextSize:@"3.11" andFont:originalAreaDetailLabel.font];
    originalAreaDetailLabel.frame = CGRectMake(originalAreaLabel.yj_x, CGRectGetMaxY(originalAreaLabel.frame), size3.width, 20);
    
    originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    originalAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:originalAreaDetailLabel];
    _originalAreaDetailLabel = originalAreaDetailLabel;
    
    //扣尺面积的值
    UILabel * deductionAreaDetailLabel = [[UILabel alloc]init];
    deductionAreaDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size4 = [self obtainLabelTextSize:@"3.11" andFont:deductionAreaDetailLabel.font];
    deductionAreaDetailLabel.frame = CGRectMake(deductionAreaLabel.yj_x, CGRectGetMaxY(deductionAreaLabel.frame), size4.width, 20);
    deductionAreaDetailLabel.text = @"3.11";
    deductionAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    deductionAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:deductionAreaDetailLabel];
    _deductionAreaDetailLabel = deductionAreaDetailLabel;
    
    //实际面积的值
    UILabel * actualAreaDetailLabel = [[UILabel alloc]init];
    actualAreaDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size5 = [self obtainLabelTextSize:@"3.11" andFont: actualAreaDetailLabel.font];
    actualAreaDetailLabel.frame = CGRectMake(actualAreaLabel.yj_x, CGRectGetMaxY(actualAreaLabel.frame), size5.width, 20);
    actualAreaDetailLabel.text = @"3.11";
    
    actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    actualAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:actualAreaDetailLabel];
    _actualAreaDetailLabel= actualAreaDetailLabel;
    
    UIView * bottomview = [[UIView alloc]init];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    bottomview.frame = CGRectMake(12,CGRectGetMaxY(self.backView.frame) , SCW - 24, 10);
    [self.contentView addSubview:bottomview];
    
    
    
    
    
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
