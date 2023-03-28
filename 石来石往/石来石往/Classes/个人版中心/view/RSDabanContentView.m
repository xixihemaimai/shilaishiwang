//
//  RSDabanContentView.m
//  石来石往
//
//  Created by mac on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSDabanContentView.h"
#define margin 10
#define ECA 1
@implementation RSDabanContentView



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    CGFloat showViewW = SCW - 24;
    CGFloat showViewH = 108;
    for (int i = 0; i < _dataArray.count; i++) {
        
        RSSLStoragemanagementModel * slstoragemanagementmodel = dataArray[i];
        UIView * showView = [[UIView alloc]init];
        showView.userInteractionEnabled = YES;
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
        CGFloat showViewX =  0;
        CGFloat showViewY = i * showViewH + i * margin;
        showView.frame = CGRectMake(showViewX, showViewY, showViewW, showViewH);
        [self addSubview:showView];
        
        UIView * blueView = [[UIView alloc]init];
        blueView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
        blueView.frame = CGRectMake(13, 10, 3, 13);
        [showView addSubview:blueView];
        
        //片号
        UILabel * filmNumberLabel = [[UILabel alloc]init];
        filmNumberLabel.frame = CGRectMake(20, 6, 120, 20);
        filmNumberLabel.text = [NSString stringWithFormat:@"%@",slstoragemanagementmodel.slNo];
        filmNumberLabel.font = [UIFont systemFontOfSize:14];
        filmNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        filmNumberLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:filmNumberLabel];
        
        //长
        UILabel * longLabel = [[UILabel alloc]init];
        longLabel.frame = CGRectMake(11, 31, 40, 14);
        longLabel.text = @"长(cm)";
        longLabel.font = [UIFont systemFontOfSize:9];
        longLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        longLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:longLabel];
        
        
        //宽
        UILabel * wideLabel = [[UILabel alloc]init];
        wideLabel.frame = CGRectMake(CGRectGetMaxX(longLabel.frame) + 90, 30, 40, 14);
        wideLabel.text = @"宽(cm)";
        wideLabel.font = [UIFont systemFontOfSize:9];
        wideLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        wideLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:wideLabel];
        
        //厚
        UILabel * thickLabel = [[UILabel alloc]init];
        thickLabel.frame = CGRectMake(CGRectGetMaxX(wideLabel.frame) + 90, 30, 40, 14);
        thickLabel.text = @"厚(cm)";
        thickLabel.font = [UIFont systemFontOfSize:9];
        thickLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        thickLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:thickLabel];
        
        
        
        //长的值
        UILabel * longDetailLabel = [[UILabel alloc]init];
        longDetailLabel.font = [UIFont systemFontOfSize:14];
        CGSize size = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]] andFont:longDetailLabel.font];
        longDetailLabel.frame = CGRectMake(longLabel.yj_x, CGRectGetMaxY(longLabel.frame), size.width, 14);
        longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]];
        
        
        longDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        longDetailLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:longDetailLabel];
        
        

        
        
        //宽的值
        UILabel * wideDetialLabel = [[UILabel alloc]init];
        wideDetialLabel.font = [UIFont systemFontOfSize:14];
        CGSize size1 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]] andFont:wideDetialLabel.font];
        wideDetialLabel.frame = CGRectMake(wideLabel.yj_x, CGRectGetMaxY(wideLabel.frame), size1.width, 14);
        wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]];
        
        wideDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        wideDetialLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:wideDetialLabel];
        
        

        
        //厚的值
        UILabel * thickDeitalLabel = [[UILabel alloc]init];
        thickDeitalLabel.font = [UIFont systemFontOfSize:14];
        CGSize size2 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]] andFont:thickDeitalLabel.font];
        thickDeitalLabel.frame = CGRectMake(thickLabel.yj_x, CGRectGetMaxY(thickLabel.frame), size2.width, 14);
        thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]];
        
        thickDeitalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        thickDeitalLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:thickDeitalLabel];
        

        
        //原生面积
        UILabel * originalAreaLabel = [[UILabel alloc]init];
        originalAreaLabel.frame = CGRectMake(longDetailLabel.yj_x, CGRectGetMaxY(longDetailLabel.frame) + 1, 70, 14);
        originalAreaLabel.text = @"原始面积(m²)";
        originalAreaLabel.font = [UIFont systemFontOfSize:10];
        originalAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        originalAreaLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:originalAreaLabel];
        
        
        //扣尺面积
        UILabel * deductionAreaLabel = [[UILabel alloc]init];
        deductionAreaLabel.frame = CGRectMake(wideDetialLabel.yj_x, CGRectGetMaxY(wideDetialLabel.frame) + 1, 70, 14);
        deductionAreaLabel.text = @"扣尺面积(m²)";
        deductionAreaLabel.font = [UIFont systemFontOfSize:10];
        deductionAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        deductionAreaLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:deductionAreaLabel];
        
        //实际面积
        UILabel * actualAreaLabel = [[UILabel alloc]init];
        actualAreaLabel.frame = CGRectMake(thickDeitalLabel.yj_x, CGRectGetMaxY(thickDeitalLabel.frame) + 1, 70, 14);
        actualAreaLabel.text = @"实际面积(m²)";
        actualAreaLabel.font = [UIFont systemFontOfSize:10];
        actualAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        actualAreaLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:actualAreaLabel];
        
        
        
        //原生面积的值
        UILabel * originalAreaDetailLabel = [[UILabel alloc]init];
        originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]];
        originalAreaDetailLabel.font = [UIFont systemFontOfSize:14];
        CGSize size3 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] andFont:originalAreaDetailLabel.font];
        originalAreaDetailLabel.frame = CGRectMake(originalAreaLabel.yj_x, CGRectGetMaxY(originalAreaLabel.frame), size3.width, 20);
        
        originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        originalAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:originalAreaDetailLabel];
        

        //扣尺面积的值
        UILabel * deductionAreaDetailLabel = [[UILabel alloc]init];
        deductionAreaDetailLabel.font = [UIFont systemFontOfSize:14];
        CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]] andFont:deductionAreaDetailLabel.font];
        deductionAreaDetailLabel.frame = CGRectMake(deductionAreaLabel.yj_x, CGRectGetMaxY(deductionAreaLabel.frame), size4.width, 20);
        deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]];
        deductionAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        deductionAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:deductionAreaDetailLabel];
        
//        //实际面积的值
        UILabel * actualAreaDetailLabel = [[UILabel alloc]init];
        actualAreaDetailLabel.font = [UIFont systemFontOfSize:14];
        CGSize size5 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] andFont: actualAreaDetailLabel.font];
        actualAreaDetailLabel.frame = CGRectMake(actualAreaLabel.yj_x, CGRectGetMaxY(actualAreaLabel.frame), size5.width, 20);
        actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]];
        
        actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        actualAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:actualAreaDetailLabel];
        
    //filmNumberLabel.frame = CGRectMake(20, 6, 120, 20);
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"垃圾桶"] forState:UIControlStateNormal];
         deleteBtn.tag = i;
        [deleteBtn addTarget:self action:@selector(deleteCustomAction:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.frame = CGRectMake(showView.frame.size.width - 30, 6, 20, 20);
        [showView addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
    
        //按键要添加一个断裂+1按键
        UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(showView.frame.size.width - 52, showView.frame.size.height - 21, 52, 21);
        [addBtn setTitle:@"断裂+1" forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        addBtn.tag = i;
        [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        [showView addSubview:addBtn];
        _addBtn = addBtn;
        [addBtn addTarget:self action:@selector(addDabanAciton:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.layer.cornerRadius = 12;
    }
}


- (void)addDabanAciton:(UIButton *)addBtn{
    if ([self.delegate respondsToSelector:@selector(sendIndex:)]) {
        [self.delegate sendIndex:addBtn.tag];
    }
}


- (void)deleteCustomAction:(UIButton *)deleteBtn{
    if ([self.delegate respondsToSelector:@selector(deleteIndex:)]) {
        [self.delegate deleteIndex:deleteBtn.tag];
    }
}



- (CGSize)obtainLabelTextSize:(NSString *)text andFont:(UIFont *)font{
    CGSize size = [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil].size;
    return size;
}


@end
