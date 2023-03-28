//
//  RSDabanPurchaseCell.m
//  石来石往
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSDabanPurchaseCell.h"


@interface RSDabanPurchaseCell()<UIScrollViewDelegate>

/// 标题的背景
@property (nonatomic, strong) UIView *backView;
/// 标题
//@property (nonatomic, strong) UILabel *titleLabel;
/// 删除按钮
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation RSDabanPurchaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
        
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
    
    
    
    
}


- (CGSize)obtainLabelTextSize:(NSString *)text andFont:(UIFont *)font{
    CGSize size = [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil].size;
    return size;
}


//#pragma mark - Set方法
//-(void)setName:(NSString *)name {
//    _name = name;
//    
//    self.titleLabel.text = [NSString stringWithFormat:@"这里有个%@", self.name];
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
