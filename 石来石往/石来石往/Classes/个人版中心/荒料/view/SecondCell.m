//
//  SecondCell.m
//  TableViewFloat
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 singularity. All rights reserved.
//

#import "SecondCell.h"

@interface SecondCell()

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong)UILabel * priceLabel;

@property (nonatomic,strong)UILabel * numberLabel;

@property (nonatomic,strong)UILabel * moneyLabel;

@end



@implementation SecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorFromHexString:@"#ffffff"];
        
        
        //名称
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.numberOfLines = 0;
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"磨锯";
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textColor = [UIColor colorFromHexString:@"#666666"];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        //单价
        UILabel * priceLabel = [[UILabel alloc]init];
        priceLabel.text = @"12元";
        priceLabel.numberOfLines = 0;
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.font = [UIFont systemFontOfSize:15];
        priceLabel.textColor = [UIColor colorFromHexString:@"#666666"];
        [self.contentView addSubview:priceLabel];
        _priceLabel = priceLabel;
        
        //数量
        UILabel * numberLabel = [[UILabel alloc]init];
        numberLabel.text = @"2";
        numberLabel.numberOfLines = 0;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font = [UIFont systemFontOfSize:15];
        numberLabel.textColor = [UIColor colorFromHexString:@"#666666"];
        [self.contentView addSubview:numberLabel];
        _numberLabel = numberLabel;
        
        
        //金额
        UILabel * moneyLabel = [[UILabel alloc]init];
        moneyLabel.text = @"24元";
        moneyLabel.numberOfLines = 0;
        moneyLabel.textAlignment = NSTextAlignmentLeft;
        moneyLabel.font = [UIFont systemFontOfSize:15];
        moneyLabel.textColor = [UIColor colorFromHexString:@"#666666"];
        [self.contentView addSubview:moneyLabel];
        _moneyLabel = moneyLabel;
        
        //左边
        UIView * leftView = [[UIView alloc]init];
        leftView.backgroundColor = [UIColor colorFromHexString:@"#E8E8E8"];
        [self.contentView addSubview:leftView];
        
        
        //右边
        UIView * rightView = [[UIView alloc]init];
        rightView.backgroundColor = [UIColor colorFromHexString:@"#E8E8E8"];
        [self.contentView addSubview:rightView];
        
        
        
        //分割线
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorFromHexString:@"#E8E8E8"];
        [self.contentView addSubview:bottomview];
        
        
        nameLabel.sd_layout
        .leftSpaceToView(self.contentView, 24)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 1)
        .widthIs(123);
        
        
        priceLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .centerXEqualToView(self.contentView)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .widthIs(31);
        
        
        numberLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(priceLabel, 29)
        .topEqualToView(priceLabel)
        .bottomEqualToView(priceLabel)
        .widthIs(40);
        
        
        moneyLabel.sd_layout
        .leftSpaceToView(numberLabel, 20)
        .centerYEqualToView(self.contentView)
        .topEqualToView(numberLabel)
        .bottomEqualToView(numberLabel)
        .widthIs(60);
        
        
        
        leftView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .widthIs(1);
        
        rightView.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .widthIs(1);
        
        
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
        
        
        
    }
    return self;
}


- (void)setSecondProcessmodel:(RSSecondProcessModel *)secondProcessmodel{
    _secondProcessmodel = secondProcessmodel;
    
    _nameLabel.text = secondProcessmodel.name;
    
   _priceLabel.text = [NSString stringWithFormat:@"%@元",secondProcessmodel.price];
    
//    if (fmodf([secondProcessmodel.price floatValue], 1)==0) {//如果有一位小数点
//        _priceLabel.text = [NSString stringWithFormat:@"%.0lf",[secondProcessmodel.price floatValue]];
//    } else if (fmodf([secondProcessmodel.price floatValue]*10, 1)==0) {//如果有两位小数点
//         _priceLabel.text = [NSString stringWithFormat:@"%.1lf",[secondProcessmodel.price floatValue]];
//    } else {
//        _priceLabel.text = [NSString stringWithFormat:@"%.2lf",[secondProcessmodel.price floatValue]];
//    }

    _numberLabel.text = [NSString stringWithFormat:@"%ld",[secondProcessmodel.amount integerValue]];
    
    //_moneyLabel.text = [NSString stringWithFormat:@"%.2lf元",[secondProcessmodel.money floatValue]];
    _moneyLabel.text = [NSString stringWithFormat:@"%@元",secondProcessmodel.money];
}


//- (NSString *)formatFloat:(float)f
//{
//    if (fmodf(f, 1)==0) {//如果有一位小数点
//        return [NSString stringWithFormat:@"%.0f",f];
//    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
//        return [NSString stringWithFormat:@"%.1f",f];
//    } else {
//        return [NSString stringWithFormat:@"%.2f",f];
//    }
//}






- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
