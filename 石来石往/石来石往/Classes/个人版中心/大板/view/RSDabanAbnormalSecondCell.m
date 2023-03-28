//
//  RSDabanAbnormalSecondCell.m
//  石来石往
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSDabanAbnormalSecondCell.h"
#import "RSDabanContentSecondView.h"
#import "RSDabanContentFootView.h"

@interface RSDabanAbnormalSecondCell()
/// 标题的背景
@property (nonatomic, strong) UIView *backView;
/// 标题
//@property (nonatomic, strong) UILabel *titleLabel;
/// 删除按钮
@property (nonatomic, strong) UIButton *deleteButton;


@end


@implementation RSDabanAbnormalSecondCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        
        
        [self setupCell];
        
        
    }
    return self;
}

-(void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    /// 在cell上先添加滑动视图
    [self.contentView addSubview:self.mainScrollView];
    
    /// 再在滑动视图上添加背景视图（就是cell主要显示的内容）
    [self.mainScrollView addSubview:self.backView];
    [self.mainScrollView addSubview:self.deleteButton];
    //[self.backView addSubview:self.titleLabel];
    
    
    self.mainScrollView.frame = CGRectMake(12, 0, SCW - 24, 118);
    self.backView.frame = CGRectMake(0, 0, SCW - 24, 108);
    //self.titleLabel.frame = CGRectMake(10, 0, 200, 40);
    self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, [self deleteButtonWdith], 108);
    
    
    
    UIView * blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    blueView.frame = CGRectMake(13, 10, 3, 13);
    [self.backView addSubview:blueView];
    
    //片号
    UILabel * filmNumberLabel = [[UILabel alloc]init];
    filmNumberLabel.frame = CGRectMake(20, 6, 120, 20);
    filmNumberLabel.text = [NSString stringWithFormat:@"片号%d",1];
    filmNumberLabel.font = [UIFont systemFontOfSize:14];
    filmNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    filmNumberLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:filmNumberLabel];
    _filmNumberLabel = filmNumberLabel;
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
    CGSize size = [self obtainLabelTextSize:@"0.11" andFont:longDetailLabel.font];
    longDetailLabel.frame = CGRectMake(longLabel.yj_x, CGRectGetMaxY(longLabel.frame), size.width, 14);
    longDetailLabel.text = @"0.11";
    
    
    longDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    longDetailLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:longDetailLabel];
    _longDetailLabel = longDetailLabel;
    
    
    
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
    [self.backView addSubview:longModifyLabel];
    
    _longModifyLabel = longModifyLabel;
    
    
    //宽的值
    UILabel * wideDetialLabel = [[UILabel alloc]init];
    wideDetialLabel.font = [UIFont systemFontOfSize:14];
    CGSize size1 = [self obtainLabelTextSize:@"3.31" andFont:wideDetialLabel.font];
    wideDetialLabel.frame = CGRectMake(wideLabel.yj_x, CGRectGetMaxY(wideLabel.frame), size1.width, 14);
    wideDetialLabel.text = @"3.31";
    
    wideDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    wideDetialLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:wideDetialLabel];
    _wideDetialLabel = wideDetialLabel;
    
    
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
    [self.backView addSubview:wideModifyLabel];
    _wideModifyLabel = wideModifyLabel;
    
    
    //厚的值
    UILabel * thickDeitalLabel = [[UILabel alloc]init];
    thickDeitalLabel.font = [UIFont systemFontOfSize:14];
    CGSize size2 = [self obtainLabelTextSize:@"10.111" andFont:thickDeitalLabel.font];
    thickDeitalLabel.frame = CGRectMake(thickLabel.yj_x, CGRectGetMaxY(thickLabel.frame), size2.width, 14);
    thickDeitalLabel.text = @"10.111";
    
    thickDeitalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    thickDeitalLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:thickDeitalLabel];
    _thickDeitalLabel = thickDeitalLabel;
    
    
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
    [self.backView addSubview:thickModifyLabel];
    
    _thickModifyLabel = thickModifyLabel;
    
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
    originalAreaDetailLabel.text = @"3.1111";
    originalAreaDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size3 = [self obtainLabelTextSize:@"3.1111" andFont:originalAreaDetailLabel.font];
    originalAreaDetailLabel.frame = CGRectMake(originalAreaLabel.yj_x, CGRectGetMaxY(originalAreaLabel.frame), size3.width, 20);
    
    originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    originalAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:originalAreaDetailLabel];
    _originalAreaDetailLabel = originalAreaDetailLabel;
    
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
    [self.backView addSubview:originalModifyLabel];
    _originalModifyLabel = originalModifyLabel;
    
    
    //扣尺面积的值
    UILabel * deductionAreaDetailLabel = [[UILabel alloc]init];
    deductionAreaDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size4 = [self obtainLabelTextSize:@"3.1111" andFont:deductionAreaDetailLabel.font];
    deductionAreaDetailLabel.frame = CGRectMake(deductionAreaLabel.yj_x, CGRectGetMaxY(deductionAreaLabel.frame), size4.width, 20);
    deductionAreaDetailLabel.text = @"3.1111";
    deductionAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    deductionAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:deductionAreaDetailLabel];
    _deductionAreaDetailLabel = deductionAreaDetailLabel;
    
    
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
    [self.backView addSubview:deductionModifyLabel];
    _deductionModifyLabel = deductionModifyLabel;
    
    //实际面积的值
    UILabel * actualAreaDetailLabel = [[UILabel alloc]init];
    actualAreaDetailLabel.font = [UIFont systemFontOfSize:14];
    CGSize size5 = [self obtainLabelTextSize:@"3.1111" andFont: actualAreaDetailLabel.font];
    actualAreaDetailLabel.frame = CGRectMake(actualAreaLabel.yj_x, CGRectGetMaxY(actualAreaLabel.frame), size5.width, 20);
    actualAreaDetailLabel.text = @"3.1111";
    
    actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    actualAreaDetailLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:actualAreaDetailLabel];
    _actualAreaDetailLabel = actualAreaDetailLabel;
    
    
    
    
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
    [self.backView addSubview:actualModifyLabel];
    _actualModifyLabel = actualModifyLabel;
    
}


- (CGSize)obtainLabelTextSize:(NSString *)text andFont:(UIFont *)font{
    CGSize size = [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil].size;
    return size;
}

//- (void)setChoosingInventorymodel:(RSChoosingInventoryModel *)choosingInventorymodel{
//
//    _choosingInventorymodel = choosingInventorymodel;
//
//
//   // BOOL isbool = [[dict objectForKey:@"isbool"] boolValue];
//   // NSMutableArray * selectArray = [dict objectForKey:@"selectArray"];
//    NSInteger count = choosingInventorymodel.selectArray.count;
//    for (UIView * view in _dabanContentFootView.subviews) {
//        [view removeFromSuperview];
//    }
//    for (UIView * view in _dabanContentView.subviews) {
//        [view removeFromSuperview];
//    }
//
//
//    if (choosingInventorymodel.isBool) {
//
//        _exceptionView.layer.cornerRadius = 0;
//
//        CGRect rect = CGRectMake(0, 0, SCW - 24, 98);
//        CGRect oldRect = rect;
//        oldRect.size.width = SCW - 24;
//
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
//
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.path = maskPath.CGPath;
//        maskLayer.frame = oldRect;
//        _exceptionView.layer.mask = maskLayer;
//
//
//        if (count > 0) {
//            _dabanContentView.sd_layout
//            .topSpaceToView(_exceptionView, 0)
//            .heightIs(count * 118);
//            //_dabanContentView.count = count;
//
//            _dabanContentView.dataArray = choosingInventorymodel.selectArray;
//
//            _dabanContentFootView.sd_layout
//            .topSpaceToView(_dabanContentView, 0)
//            .heightIs(10);
//            _dabanContentFootView.isbool = choosingInventorymodel.isBool;
//        }else{
//            _dabanContentView.sd_layout
//            .topSpaceToView(_exceptionView, 0)
//            .heightIs(0);
//            _dabanContentFootView.sd_layout
//            .topSpaceToView(_dabanContentView, 0)
//            .heightIs(0);
//           // [_dabanContentView.dataArray removeAllObjects];
//            _exceptionView.layer.cornerRadius = 8;
//            //_dabanContentView.count = 0;
//            _dabanContentFootView.isbool = false;
//        }
//
//
//
//        //        _dabanContentView.sd_layout
//        //        .topSpaceToView(_exceptionView, 0)
//        //        .heightIs(count * 118);
//        //        _dabanContentView.count = count;
//        //
//        //        _dabanContentFootView.sd_layout
//        //        .topSpaceToView(_dabanContentView, 0)
//        //        .heightIs(10);
//        //        _dabanContentFootView.isbool = isbool;
//       // [self.downBtn setImage:[UIImage imageNamed:@"system-pull-down copy 2"] forState:UIControlStateNormal];
//        self.downImageView.image = [UIImage imageNamed:@"system-pull-down copy 2"];
//    }else{
//        _dabanContentView.sd_layout
//        .topSpaceToView(_exceptionView, 0)
//        .heightIs(0);
//        _dabanContentFootView.sd_layout
//        .topSpaceToView(_dabanContentView, 0)
//        .heightIs(0);
//        _exceptionView.layer.cornerRadius = 8;
//        //_dabanContentView.count = 0;
//        // [_dabanContentView.dataArray removeAllObjects];
//        _dabanContentFootView.isbool = choosingInventorymodel.isBool;
//       // [self.downBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
//        self.downImageView.image = [UIImage imageNamed:@"system-pull-down"];
//    }
//
//
//
//
//}



//- (void)setDict:(NSMutableDictionary *)dict{
//    _dict = dict;
//    BOOL isbool = [[dict objectForKey:@"isbool"] boolValue];
//    NSMutableArray * selectArray = [dict objectForKey:@"selectArray"];
//    NSInteger count = selectArray.count;
//    for (UIView * view in _dabanContentFootView.subviews) {
//        [view removeFromSuperview];
//    }
//    for (UIView * view in _dabanContentView.subviews) {
//        [view removeFromSuperview];
//    }
//    
//    
//    if (isbool) {
//        
//        _exceptionView.layer.cornerRadius = 0;
//        
//        CGRect rect = CGRectMake(0, 0, SCW - 24, 98);
//        CGRect oldRect = rect;
//        oldRect.size.width = SCW - 24;
//        
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
//        
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.path = maskPath.CGPath;
//        maskLayer.frame = oldRect;
//        _exceptionView.layer.mask = maskLayer;
//        
//        
//        if (count > 0) {
//            _dabanContentView.sd_layout
//            .topSpaceToView(_exceptionView, 0)
//            .heightIs(count * 118);
//            _dabanContentView.count = count;
//            
//            _dabanContentFootView.sd_layout
//            .topSpaceToView(_dabanContentView, 0)
//            .heightIs(10);
//            _dabanContentFootView.isbool = isbool;
//        }else{
//            _dabanContentView.sd_layout
//            .topSpaceToView(_exceptionView, 0)
//            .heightIs(0);
//            _dabanContentFootView.sd_layout
//            .topSpaceToView(_dabanContentView, 0)
//            .heightIs(0);
//            _exceptionView.layer.cornerRadius = 8;
//            _dabanContentView.count = 0;
//            _dabanContentFootView.isbool = false;
//        }
//        
//        [self.downBtn setImage:[UIImage imageNamed:@"system-pull-down copy 2"] forState:UIControlStateNormal];
//    }else{
//        _dabanContentView.sd_layout
//        .topSpaceToView(_exceptionView, 0)
//        .heightIs(0);
//        _dabanContentFootView.sd_layout
//        .topSpaceToView(_dabanContentView, 0)
//        .heightIs(0);
//        _exceptionView.layer.cornerRadius = 8;
//        _dabanContentView.count = 0;
//        _dabanContentFootView.isbool = isbool;
//        [self.downBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
//    }
//    
//}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint movePoint = self.mainScrollView.contentOffset;
    if (movePoint.x < 0) {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
    }
    
    if (movePoint.x > [self deleteButtonWdith]) {
        self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, movePoint.x, 108);
    } else {
        self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, [self deleteButtonWdith], 108);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGPoint endPoint = self.mainScrollView.contentOffset;
    if (endPoint.x < self.deleteButtonWdith) {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if (self.scrollAction) {
        self.scrollAction();
    }
}

#pragma mark - 点击事件
-(void)deleteAction:(UIButton *)button {
    if (self.deleteAction) {
        self.deleteAction(self.indexPath);
    }
}

#pragma mark - Get方法
-(CGFloat)deleteButtonWdith {
    return 60.0 * (SCW / 375.0);
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    }
    
    return _backView;
}

//-(UILabel *)titleLabel {
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc] init];
//    }
//    return _titleLabel;
//}

-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        /// 设置滑动视图的偏移量是：屏幕宽+删除按钮宽
        _mainScrollView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        _mainScrollView.contentSize = CGSizeMake(self.deleteButtonWdith + SCW, 0);
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.bounces = NO;
        _mainScrollView.userInteractionEnabled = YES;
    }
    
    return _mainScrollView;
}

-(UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _deleteButton.backgroundColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
        [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _deleteButton;
}

/// 判断是否被打开了
-(BOOL)isOpen {
    return self.mainScrollView.contentOffset.x >= self.deleteButtonWdith;
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
