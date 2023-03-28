//
//  RSChoosingInventoryHeaderView.m
//  石来石往
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSChoosingInventoryHeaderView.h"

@implementation RSChoosingInventoryHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
     
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
        
        [self setUI];
        
        
        
    }
    return self;
}

- (void)setUI{
    
    UIView *  choosingContentView = [[UIView alloc]init];
    choosingContentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.contentView addSubview:choosingContentView];
    
    
    //图片
//    UIImageView * choosingImageView = [[UIImageView alloc]init];
//    choosingImageView.image = [UIImage imageNamed:@"512"];
//    choosingImageView.contentMode = UIViewContentModeScaleAspectFill;
//    choosingImageView.clipsToBounds = YES;
//    [choosingContentView addSubview:choosingImageView];
    
    //物料号
    UILabel * choosingNumberLabel = [[UILabel alloc]init];
    choosingNumberLabel.text = @"ESB00295/DH-539";
    choosingNumberLabel.font = [UIFont systemFontOfSize:15];
    choosingNumberLabel.textAlignment = NSTextAlignmentLeft;
    choosingNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [choosingContentView addSubview:choosingNumberLabel];
    _choosingNumberLabel = choosingNumberLabel;
    //物品栏
    UILabel * choosingProductNameLabel = [[UILabel alloc]init];
    choosingProductNameLabel.text = @"白玉兰";
    choosingProductNameLabel.font = [UIFont systemFontOfSize:15];
    choosingProductNameLabel.textAlignment = NSTextAlignmentLeft;
    choosingProductNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [choosingContentView addSubview:choosingProductNameLabel];
    _choosingProductNameLabel = choosingProductNameLabel;
    
    //物品类型
    UILabel * choosingProductTypeLabel = [[UILabel alloc]init];
    choosingProductTypeLabel.text = @"大理石";
    choosingProductTypeLabel.font = [UIFont systemFontOfSize:15];
    choosingProductTypeLabel.textAlignment = NSTextAlignmentLeft;
    choosingProductTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [choosingContentView addSubview:choosingProductTypeLabel];
    _choosingProductTypeLabel = choosingProductTypeLabel;
    
    //面积
    UILabel * choosingAreaLabel = [[UILabel alloc]init];
    choosingAreaLabel.text = @"5.883(m²)";
    choosingAreaLabel.font = [UIFont systemFontOfSize:15];
    choosingAreaLabel.textAlignment = NSTextAlignmentLeft;
    choosingAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [choosingContentView addSubview:choosingAreaLabel];
    _choosingAreaLabel = choosingAreaLabel;
    
    
    //选中
    UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:[UIImage imageNamed:@"Oval 9"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"个人选中"] forState:UIControlStateSelected];
    [choosingContentView addSubview:selectBtn];
    _selectBtn = selectBtn;
    
    //分割线
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [choosingContentView addSubview:midView];
    
    
    //仓库位置
    UILabel * choosingWarehouseLabel = [[UILabel alloc]init];
    choosingWarehouseLabel.text = @"匝号：5-5 10片";
    choosingWarehouseLabel.font = [UIFont systemFontOfSize:15];
    choosingWarehouseLabel.textAlignment = NSTextAlignmentLeft;
    choosingWarehouseLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [choosingContentView addSubview:choosingWarehouseLabel];
    _choosingWarehouseLabel = choosingWarehouseLabel;
    //方向图片
    UIImageView * choosingDirectionImageView = [[UIImageView alloc]init];
    choosingDirectionImageView.image = [UIImage imageNamed:@"system-pull-down"];
    choosingDirectionImageView.clipsToBounds = YES;
    choosingDirectionImageView.contentMode = UIViewContentModeScaleAspectFill;
    [choosingContentView addSubview:choosingDirectionImageView];
    _choosingDirectionImageView = choosingDirectionImageView;
    
    choosingContentView.sd_layout
    .leftSpaceToView(self.contentView, 12)
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 12)
    .heightIs(155);
    
    
    
    CGRect rect = CGRectMake(0, 0, SCW - 24, 155);
    CGRect oldRect = rect;
    oldRect.size.width = SCW - 24;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = oldRect;
    choosingContentView.layer.mask = maskLayer;
    
    
    
//    choosingImageView.sd_layout
//    .leftSpaceToView(choosingContentView, 12)
//    .topSpaceToView(choosingContentView, 12)
//    .heightIs(92)
//    .widthEqualToHeight();
//
//    choosingImageView.layer.cornerRadius = 3;
    
    
    
    
    choosingNumberLabel.sd_layout
    .leftSpaceToView(choosingContentView, 12)
//    .topEqualToView(choosingContentView)
    .topSpaceToView(choosingContentView, 13)
    .heightIs(21)
    .widthRatioToView(choosingContentView, 0.5);
    
    
    choosingProductNameLabel.sd_layout
    .leftEqualToView(choosingNumberLabel)
    .topSpaceToView(choosingNumberLabel, 3)
    .heightIs(21)
    .rightEqualToView(choosingNumberLabel);
    
    choosingProductTypeLabel.sd_layout
    .leftEqualToView(choosingProductNameLabel)
    .rightEqualToView(choosingProductNameLabel)
    .topSpaceToView(choosingProductNameLabel, 3)
    .heightIs(21);
    
    
    choosingAreaLabel.sd_layout
    .leftEqualToView(choosingProductTypeLabel)
    .rightEqualToView(choosingProductTypeLabel)
    .topSpaceToView(choosingProductTypeLabel, 3)
    .heightIs(21);
    
    
    selectBtn.sd_layout
    .rightSpaceToView(choosingContentView, 11)
    .topSpaceToView(choosingContentView, 13)
    .heightIs(25)
    .widthEqualToHeight();
    
    
    midView.sd_layout
    .leftSpaceToView(choosingContentView, 0)
    .rightSpaceToView(choosingContentView, 0)
    .topSpaceToView(choosingContentView, 117)
    .heightIs(1);
    
    choosingWarehouseLabel.sd_layout
    .leftSpaceToView(choosingContentView, 12)
    .topSpaceToView(midView, 10)
    .heightIs(20)
    .widthIs(110);
    
    
    choosingDirectionImageView.sd_layout
    //.leftSpaceToView(choosingWarehouseLabel, 12)
    .rightSpaceToView(choosingContentView, 11)
    .widthIs(16)
    .heightIs(9)
    .topSpaceToView(midView, 16);
    
    
    
    self.tap = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:_tap];
    
    
}


@end
