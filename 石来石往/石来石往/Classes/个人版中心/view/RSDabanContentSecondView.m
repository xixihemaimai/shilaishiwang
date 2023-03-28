//
//  RSDabanContentSecondView.m
//  石来石往
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSDabanContentSecondView.h"
#define margin 10
#define ECA 1
@implementation RSDabanContentSecondView

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
         RSChoosingSliceModel * choosingSlicemodel = dataArray[i];
        UIView * showView = [[UIView alloc]init];
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
        filmNumberLabel.text = [NSString stringWithFormat:@"片号%d",i+1];
        filmNumberLabel.font = [UIFont systemFontOfSize:14];
        filmNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        filmNumberLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:filmNumberLabel];
        
        //长
        UILabel * longLabel = [[UILabel alloc]init];
        longLabel.frame = CGRectMake(11, 31, 32, 14);
        longLabel.text = @"长(cm)";
        longLabel.font = [UIFont systemFontOfSize:9];
        longLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        longLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:longLabel];
        
        
        //宽
        UILabel * wideLabel = [[UILabel alloc]init];
        wideLabel.frame = CGRectMake(CGRectGetMaxX(longLabel.frame) + 90, 30, 32, 14);
        wideLabel.text = @"宽(cm)";
        wideLabel.font = [UIFont systemFontOfSize:9];
        wideLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        wideLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:wideLabel];
        
        //厚
        UILabel * thickLabel = [[UILabel alloc]init];
        thickLabel.frame = CGRectMake(CGRectGetMaxX(wideLabel.frame) + 90, 30, 32, 14);
        thickLabel.text = @"厚(cm)";
        thickLabel.font = [UIFont systemFontOfSize:9];
        thickLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        thickLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:thickLabel];
        
        
        
        //长的值
        UILabel * longDetailLabel = [[UILabel alloc]init];
        longDetailLabel.font = [UIFont systemFontOfSize:14];
        CGSize size = [self obtainLabelTextSize:@"0.1" andFont:longDetailLabel.font];
        longDetailLabel.frame = CGRectMake(longLabel.yj_x, CGRectGetMaxY(longLabel.frame), size.width, 14);
        longDetailLabel.text = @"0.1";
        
        
        longDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        longDetailLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:longDetailLabel];
        
        
        //长的修改的值
        UILabel * longModifyLabel = [[UILabel alloc]init];
        longModifyLabel.font = [UIFont systemFontOfSize:14];
        CGSize size6 = [self obtainLabelTextSize:@"2.3" andFont:longModifyLabel.font];
        longModifyLabel.frame = CGRectMake(CGRectGetMaxX(longDetailLabel.frame),longDetailLabel.yj_y , size6.width, 14);
        longModifyLabel.text = @"0.1";
        NSDictionary *attribtDic1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSMutableAttributedString * attribtStr1 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic1];
        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
        longModifyLabel.attributedText= attribtStr1;
        
        longModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
        longModifyLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:longModifyLabel];
        
        
        
        
        
        //宽的值
        UILabel * wideDetialLabel = [[UILabel alloc]init];
        wideDetialLabel.font = [UIFont systemFontOfSize:14];
        CGSize size1 = [self obtainLabelTextSize:@"3.3" andFont:wideDetialLabel.font];
        wideDetialLabel.frame = CGRectMake(wideLabel.yj_x, CGRectGetMaxY(wideLabel.frame), size1.width, 14);
        wideDetialLabel.text = @"3.3";
        
        wideDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        wideDetialLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:wideDetialLabel];
        
        //宽修改的值
        UILabel * wideModifyLabel = [[UILabel alloc]init];
        wideModifyLabel.font = [UIFont systemFontOfSize:14];
        CGSize size7 = [self obtainLabelTextSize:@"2.3" andFont:wideModifyLabel.font];
        wideModifyLabel.frame = CGRectMake(CGRectGetMaxX(wideDetialLabel.frame), wideDetialLabel.yj_y, size7.width, 14);
        wideModifyLabel.text = @"2.3";
        NSDictionary *attribtDic2 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSMutableAttributedString * attribtStr2 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic2];
        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
        wideModifyLabel.attributedText= attribtStr2;
        wideModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
        wideModifyLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:wideModifyLabel];
        
        //厚的值
        UILabel * thickDeitalLabel = [[UILabel alloc]init];
        thickDeitalLabel.font = [UIFont systemFontOfSize:14];
        CGSize size2 = [self obtainLabelTextSize:@"10.1" andFont:thickDeitalLabel.font];
        thickDeitalLabel.frame = CGRectMake(thickLabel.yj_x, CGRectGetMaxY(thickLabel.frame), size2.width, 14);
        thickDeitalLabel.text = @"10.1";
        
        thickDeitalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        thickDeitalLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:thickDeitalLabel];
        
        //厚修改的值
        UILabel * thickModifyLabel = [[UILabel alloc]init];
        thickModifyLabel.font = [UIFont systemFontOfSize:14];
        CGSize size8 = [self obtainLabelTextSize:@"2.3" andFont:thickModifyLabel.font];
        thickModifyLabel.frame = CGRectMake(CGRectGetMaxX(thickDeitalLabel.frame), thickDeitalLabel.yj_y, size8.width, 14);
        thickModifyLabel.text = @"2.3";
        NSDictionary *attribtDic3 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSMutableAttributedString * attribtStr3 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic3];
        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
        thickModifyLabel.attributedText= attribtStr3;
        thickModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
        thickModifyLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:thickModifyLabel];
        
        
        //原生面积
        UILabel * originalAreaLabel = [[UILabel alloc]init];
        originalAreaLabel.frame = CGRectMake(longDetailLabel.yj_x, CGRectGetMaxY(longDetailLabel.frame) + 1, 62, 14);
        originalAreaLabel.text = @"原始面积(m²)";
        originalAreaLabel.font = [UIFont systemFontOfSize:10];
        originalAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        originalAreaLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:originalAreaLabel];
        
        
        //扣尺面积
        UILabel * deductionAreaLabel = [[UILabel alloc]init];
        deductionAreaLabel.frame = CGRectMake(wideDetialLabel.yj_x, CGRectGetMaxY(wideDetialLabel.frame) + 1, 62, 14);
        deductionAreaLabel.text = @"扣尺面积(m²)";
        deductionAreaLabel.font = [UIFont systemFontOfSize:10];
        deductionAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        deductionAreaLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:deductionAreaLabel];
        
        //实际面积
        UILabel * actualAreaLabel = [[UILabel alloc]init];
        actualAreaLabel.frame = CGRectMake(thickDeitalLabel.yj_x, CGRectGetMaxY(thickDeitalLabel.frame) + 1, 62, 14);
        actualAreaLabel.text = @"实际面积(m²)";
        actualAreaLabel.font = [UIFont systemFontOfSize:10];
        actualAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        actualAreaLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:actualAreaLabel];
        
        
        
        //原生面积的值
        UILabel * originalAreaDetailLabel = [[UILabel alloc]init];
        originalAreaDetailLabel.text = @"3.11";
        originalAreaDetailLabel.font = [UIFont systemFontOfSize:14];
        CGSize size3 = [self obtainLabelTextSize:@"3.11" andFont:originalAreaDetailLabel.font];
        originalAreaDetailLabel.frame = CGRectMake(originalAreaLabel.yj_x, CGRectGetMaxY(originalAreaLabel.frame), size3.width, 20);
        
        originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        originalAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:originalAreaDetailLabel];
        
        //原生面积修改的值
        UILabel * originalModifyLabel = [[UILabel alloc]init];
        originalModifyLabel.font = [UIFont systemFontOfSize:14];
        CGSize size9 = [self obtainLabelTextSize:@"2.3" andFont:originalModifyLabel.font];
        originalModifyLabel.frame = CGRectMake(CGRectGetMaxX(originalAreaDetailLabel.frame), originalAreaDetailLabel.yj_y, size9.width, 14);
        originalModifyLabel.text = @"2.3";
        NSDictionary *attribtDic4 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSMutableAttributedString * attribtStr4 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic4];
        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
        originalModifyLabel.attributedText= attribtStr4;
        originalModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
        originalModifyLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:originalModifyLabel];
        
        
        
        
        //扣尺面积的值
        UILabel * deductionAreaDetailLabel = [[UILabel alloc]init];
        deductionAreaDetailLabel.font = [UIFont systemFontOfSize:14];
        CGSize size4 = [self obtainLabelTextSize:@"3.11" andFont:deductionAreaDetailLabel.font];
        deductionAreaDetailLabel.frame = CGRectMake(deductionAreaLabel.yj_x, CGRectGetMaxY(deductionAreaLabel.frame), size4.width, 20);
        deductionAreaDetailLabel.text = @"3.11";
        deductionAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        deductionAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:deductionAreaDetailLabel];
        
        //扣尺面积的值
        UILabel * deductionModifyLabel = [[UILabel alloc]init];
        deductionModifyLabel.font = [UIFont systemFontOfSize:14];
        CGSize size10 = [self obtainLabelTextSize:@"2.3" andFont:deductionModifyLabel.font];
        deductionModifyLabel.frame = CGRectMake(CGRectGetMaxX(deductionAreaDetailLabel.frame), deductionAreaDetailLabel.yj_y, size10.width, 14);
        deductionModifyLabel.text = @"2.3";
        NSDictionary *attribtDic5 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSMutableAttributedString * attribtStr5 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic5];
        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
        deductionModifyLabel.attributedText= attribtStr5;
        deductionModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
        deductionModifyLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:deductionModifyLabel];
        
        
        
        
        
        
        //实际面积的值
        UILabel * actualAreaDetailLabel = [[UILabel alloc]init];
        actualAreaDetailLabel.font = [UIFont systemFontOfSize:14];
        CGSize size5 = [self obtainLabelTextSize:@"3.11" andFont: actualAreaDetailLabel.font];
        actualAreaDetailLabel.frame = CGRectMake(actualAreaLabel.yj_x, CGRectGetMaxY(actualAreaLabel.frame), size5.width, 20);
        actualAreaDetailLabel.text = @"3.11";
        
        actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        actualAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:actualAreaDetailLabel];
        
        
        //实际面积的值
        UILabel * actualModifyLabel = [[UILabel alloc]init];
        actualModifyLabel.font = [UIFont systemFontOfSize:14];
        CGSize size11 = [self obtainLabelTextSize:@"2.3" andFont:actualModifyLabel.font];
        actualModifyLabel.frame = CGRectMake(CGRectGetMaxX(actualAreaDetailLabel.frame), actualAreaDetailLabel.yj_y, size11.width, 14);
        actualModifyLabel.text = @"2.3";
        NSDictionary *attribtDic6 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSMutableAttributedString * attribtStr6 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic6];
        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
        actualModifyLabel.attributedText= attribtStr6;
        actualModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
        actualModifyLabel.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:actualModifyLabel];
        
        
        
        if ([choosingSlicemodel.lenth isEqualToString:choosingSlicemodel.originalLenth] && [choosingSlicemodel.wide isEqualToString:choosingSlicemodel.originalWide] && [choosingSlicemodel.height isEqualToString:choosingSlicemodel.originalHeight] && [choosingSlicemodel.area isEqualToString:choosingSlicemodel.originalArea] && [choosingSlicemodel.deductionArea isEqualToString:choosingSlicemodel.originalDeductionArea] && [choosingSlicemodel.actualArea isEqualToString:choosingSlicemodel.originalActualArea]) {
            
            longModifyLabel.hidden = YES;
            wideModifyLabel.hidden = YES;
            thickModifyLabel.hidden = YES;
            originalModifyLabel.hidden = YES;
            deductionModifyLabel.hidden = YES;
            actualModifyLabel.hidden = YES;
        }else{
            
            longModifyLabel.hidden = NO;
            wideModifyLabel.hidden = NO;
            thickModifyLabel.hidden = NO;
            originalModifyLabel.hidden = NO;
            deductionModifyLabel.hidden = NO;
            actualModifyLabel.hidden = NO;
        }
        
    }
    
    
}


//- (void)setCount:(NSInteger)count{
//    _count = count;
//    CGFloat showViewW = SCW - 24;
//    CGFloat showViewH = 108;
//    for (int i = 0; i < count; i++) {
//        UIView * showView = [[UIView alloc]init];
//        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
//        CGFloat showViewX =  0;
//        CGFloat showViewY = i * showViewH + i * margin;
//        showView.frame = CGRectMake(showViewX, showViewY, showViewW, showViewH);
//        [self addSubview:showView];
//
//        UIView * blueView = [[UIView alloc]init];
//        blueView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
//        blueView.frame = CGRectMake(13, 10, 3, 13);
//        [showView addSubview:blueView];
//
//        //片号
//        UILabel * filmNumberLabel = [[UILabel alloc]init];
//        filmNumberLabel.frame = CGRectMake(20, 6, 120, 20);
//        filmNumberLabel.text = [NSString stringWithFormat:@"片号%d",i+1];
//        filmNumberLabel.font = [UIFont systemFontOfSize:14];
//        filmNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        filmNumberLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:filmNumberLabel];
//
//        //长
//        UILabel * longLabel = [[UILabel alloc]init];
//        longLabel.frame = CGRectMake(11, 31, 32, 14);
//        longLabel.text = @"长(cm)";
//        longLabel.font = [UIFont systemFontOfSize:9];
//        longLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//        longLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:longLabel];
//
//
//        //宽
//        UILabel * wideLabel = [[UILabel alloc]init];
//        wideLabel.frame = CGRectMake(CGRectGetMaxX(longLabel.frame) + 90, 30, 32, 14);
//        wideLabel.text = @"宽(cm)";
//        wideLabel.font = [UIFont systemFontOfSize:9];
//        wideLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//        wideLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:wideLabel];
//
//        //厚
//        UILabel * thickLabel = [[UILabel alloc]init];
//        thickLabel.frame = CGRectMake(CGRectGetMaxX(wideLabel.frame) + 90, 30, 32, 14);
//        thickLabel.text = @"厚(cm)";
//        thickLabel.font = [UIFont systemFontOfSize:9];
//        thickLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//        thickLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:thickLabel];
//
//
//
//        //长的值
//        UILabel * longDetailLabel = [[UILabel alloc]init];
//        longDetailLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size = [self obtainLabelTextSize:@"0.1" andFont:longDetailLabel.font];
//        longDetailLabel.frame = CGRectMake(longLabel.yj_x, CGRectGetMaxY(longLabel.frame), size.width, 14);
//        longDetailLabel.text = @"0.1";
//
//
//        longDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        longDetailLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:longDetailLabel];
//
//
//        //长的修改的值
//        UILabel * longModifyLabel = [[UILabel alloc]init];
//        longModifyLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size6 = [self obtainLabelTextSize:@"2.3" andFont:longModifyLabel.font];
//        longModifyLabel.frame = CGRectMake(CGRectGetMaxX(longDetailLabel.frame),longDetailLabel.yj_y , size6.width, 14);
//        longModifyLabel.text = @"0.1";
//        NSDictionary *attribtDic1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//
//        NSMutableAttributedString * attribtStr1 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic1];
//        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
//        longModifyLabel.attributedText= attribtStr1;
//
//        longModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
//        longModifyLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:longModifyLabel];
//
//
//
//
//
//        //宽的值
//        UILabel * wideDetialLabel = [[UILabel alloc]init];
//        wideDetialLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size1 = [self obtainLabelTextSize:@"3.3" andFont:wideDetialLabel.font];
//        wideDetialLabel.frame = CGRectMake(wideLabel.yj_x, CGRectGetMaxY(wideLabel.frame), size1.width, 14);
//        wideDetialLabel.text = @"3.3";
//
//        wideDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        wideDetialLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:wideDetialLabel];
//
//        //宽修改的值
//        UILabel * wideModifyLabel = [[UILabel alloc]init];
//        wideModifyLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size7 = [self obtainLabelTextSize:@"2.3" andFont:wideModifyLabel.font];
//        wideModifyLabel.frame = CGRectMake(CGRectGetMaxX(wideDetialLabel.frame), wideDetialLabel.yj_y, size7.width, 14);
//        wideModifyLabel.text = @"2.3";
//        NSDictionary *attribtDic2 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//
//        NSMutableAttributedString * attribtStr2 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic2];
//        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
//        wideModifyLabel.attributedText= attribtStr2;
//        wideModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
//        wideModifyLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:wideModifyLabel];
//
//
//
//
//        //厚的值
//        UILabel * thickDeitalLabel = [[UILabel alloc]init];
//        thickDeitalLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size2 = [self obtainLabelTextSize:@"10.1" andFont:thickDeitalLabel.font];
//        thickDeitalLabel.frame = CGRectMake(thickLabel.yj_x, CGRectGetMaxY(thickLabel.frame), size2.width, 14);
//        thickDeitalLabel.text = @"10.1";
//
//        thickDeitalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        thickDeitalLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:thickDeitalLabel];
//
//        //厚修改的值
//        UILabel * thickModifyLabel = [[UILabel alloc]init];
//        thickModifyLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size8 = [self obtainLabelTextSize:@"2.3" andFont:thickModifyLabel.font];
//        thickModifyLabel.frame = CGRectMake(CGRectGetMaxX(thickDeitalLabel.frame), thickDeitalLabel.yj_y, size8.width, 14);
//        thickModifyLabel.text = @"2.3";
//        NSDictionary *attribtDic3 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//
//        NSMutableAttributedString * attribtStr3 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic3];
//        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
//        thickModifyLabel.attributedText= attribtStr3;
//        thickModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
//        thickModifyLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:thickModifyLabel];
//
//
//        //原生面积
//        UILabel * originalAreaLabel = [[UILabel alloc]init];
//        originalAreaLabel.frame = CGRectMake(longDetailLabel.yj_x, CGRectGetMaxY(longDetailLabel.frame) + 1, 62, 14);
//        originalAreaLabel.text = @"原始面积(m²)";
//        originalAreaLabel.font = [UIFont systemFontOfSize:10];
//        originalAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//        originalAreaLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:originalAreaLabel];
//
//
//        //扣尺面积
//        UILabel * deductionAreaLabel = [[UILabel alloc]init];
//        deductionAreaLabel.frame = CGRectMake(wideDetialLabel.yj_x, CGRectGetMaxY(wideDetialLabel.frame) + 1, 62, 14);
//        deductionAreaLabel.text = @"扣尺面积(m²)";
//        deductionAreaLabel.font = [UIFont systemFontOfSize:10];
//        deductionAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//        deductionAreaLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:deductionAreaLabel];
//
//        //实际面积
//        UILabel * actualAreaLabel = [[UILabel alloc]init];
//        actualAreaLabel.frame = CGRectMake(thickDeitalLabel.yj_x, CGRectGetMaxY(thickDeitalLabel.frame) + 1, 62, 14);
//        actualAreaLabel.text = @"实际面积(m²)";
//        actualAreaLabel.font = [UIFont systemFontOfSize:10];
//        actualAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//        actualAreaLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:actualAreaLabel];
//
//
//
//        //原生面积的值
//        UILabel * originalAreaDetailLabel = [[UILabel alloc]init];
//        originalAreaDetailLabel.text = @"3.11";
//        originalAreaDetailLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size3 = [self obtainLabelTextSize:@"3.11" andFont:originalAreaDetailLabel.font];
//        originalAreaDetailLabel.frame = CGRectMake(originalAreaLabel.yj_x, CGRectGetMaxY(originalAreaLabel.frame), size3.width, 20);
//
//        originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        originalAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:originalAreaDetailLabel];
//
//        //原生面积修改的值
//        UILabel * originalModifyLabel = [[UILabel alloc]init];
//        originalModifyLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size9 = [self obtainLabelTextSize:@"2.3" andFont:originalModifyLabel.font];
//        originalModifyLabel.frame = CGRectMake(CGRectGetMaxX(originalAreaDetailLabel.frame), originalAreaDetailLabel.yj_y, size9.width, 14);
//        originalModifyLabel.text = @"2.3";
//        NSDictionary *attribtDic4 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//
//        NSMutableAttributedString * attribtStr4 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic4];
//        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
//        originalModifyLabel.attributedText= attribtStr4;
//        originalModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
//        originalModifyLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:originalModifyLabel];
//
//
//
//
//        //扣尺面积的值
//        UILabel * deductionAreaDetailLabel = [[UILabel alloc]init];
//        deductionAreaDetailLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size4 = [self obtainLabelTextSize:@"3.11" andFont:deductionAreaDetailLabel.font];
//        deductionAreaDetailLabel.frame = CGRectMake(deductionAreaLabel.yj_x, CGRectGetMaxY(deductionAreaLabel.frame), size4.width, 20);
//        deductionAreaDetailLabel.text = @"3.11";
//        deductionAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        deductionAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:deductionAreaDetailLabel];
//
//        //扣尺面积的值
//        UILabel * deductionModifyLabel = [[UILabel alloc]init];
//        deductionModifyLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size10 = [self obtainLabelTextSize:@"2.3" andFont:deductionModifyLabel.font];
//        deductionModifyLabel.frame = CGRectMake(CGRectGetMaxX(deductionAreaDetailLabel.frame), deductionAreaDetailLabel.yj_y, size10.width, 14);
//        deductionModifyLabel.text = @"2.3";
//        NSDictionary *attribtDic5 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//
//        NSMutableAttributedString * attribtStr5 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic5];
//        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
//        deductionModifyLabel.attributedText= attribtStr5;
//        deductionModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
//        deductionModifyLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:deductionModifyLabel];
//
//
//
//
//
//
//        //实际面积的值
//        UILabel * actualAreaDetailLabel = [[UILabel alloc]init];
//        actualAreaDetailLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size5 = [self obtainLabelTextSize:@"3.11" andFont: actualAreaDetailLabel.font];
//        actualAreaDetailLabel.frame = CGRectMake(actualAreaLabel.yj_x, CGRectGetMaxY(actualAreaLabel.frame), size5.width, 20);
//        actualAreaDetailLabel.text = @"3.11";
//
//        actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        actualAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:actualAreaDetailLabel];
//
//
//        //实际面积的值
//        UILabel * actualModifyLabel = [[UILabel alloc]init];
//        actualModifyLabel.font = [UIFont systemFontOfSize:14];
//        CGSize size11 = [self obtainLabelTextSize:@"2.3" andFont:actualModifyLabel.font];
//        actualModifyLabel.frame = CGRectMake(CGRectGetMaxX(actualAreaDetailLabel.frame), actualAreaDetailLabel.yj_y, size11.width, 14);
//        actualModifyLabel.text = @"2.3";
//        NSDictionary *attribtDic6 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//
//        NSMutableAttributedString * attribtStr6 = [[NSMutableAttributedString alloc]initWithString:@"2.3" attributes:attribtDic6];
//        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
//        actualModifyLabel.attributedText= attribtStr6;
//        actualModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
//        actualModifyLabel.textAlignment = NSTextAlignmentLeft;
//        [showView addSubview:actualModifyLabel];
//
//
//    }
//}
//

- (CGSize)obtainLabelTextSize:(NSString *)text andFont:(UIFont *)font{
    CGSize size = [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil].size;
    return size;
}

@end
