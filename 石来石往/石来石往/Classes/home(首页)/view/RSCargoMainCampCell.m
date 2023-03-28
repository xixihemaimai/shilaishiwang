//
//  RSCargoMainCampCell.m
//  石来石往
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCargoMainCampCell.h"

@implementation RSCargoMainCampCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        
//        UIImageView * contentImageView = [[UIImageView alloc]init];
//        contentImageView.image = [UIImage imageNamed:@"圆角矩形 710 拷贝"];
//        [self.contentView addSubview:contentImageView];
        
        
        
        
        //图片
        UIImageView * productImageview = [[UIImageView alloc]init];
       // productImage.image = [UIImage imageNamed:@"1080-675"];
        productImageview.contentMode = UIViewContentModeScaleAspectFill;
        productImageview.clipsToBounds=YES;
        [self.contentView addSubview:productImageview];
        _productImageview = productImageview;
        //产品
        UILabel * productLabel = [[UILabel alloc]init];
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productLabel.font = [UIFont systemFontOfSize:15];
        productLabel.textAlignment = NSTextAlignmentLeft;
        productLabel.text = @"米黄";
        [self.contentView addSubview:productLabel];
        _productLabel = productLabel;
        //大板
        UILabel * dabanProductLabel = [[UILabel alloc]init];
        dabanProductLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        dabanProductLabel.font = [UIFont systemFontOfSize:14];
        dabanProductLabel.textAlignment = NSTextAlignmentLeft;
        dabanProductLabel.text = @"大板 234㎡";
        [self.contentView addSubview:dabanProductLabel];
        _dabanProductLabel = dabanProductLabel;
        //荒料
        UILabel * huangProductLabel = [[UILabel alloc]init];
        huangProductLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        huangProductLabel.font = [UIFont systemFontOfSize:14];
        huangProductLabel.textAlignment = NSTextAlignmentLeft;
        huangProductLabel.text = @"荒料 2345m³";
        [self.contentView addSubview:huangProductLabel];
        _huangProductLabel = huangProductLabel;
        
        productImageview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .heightIs(120);
        
        productLabel.sd_layout
        .leftSpaceToView(self.contentView, 14)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.productImageview, 8)
        .heightIs(15);
        
        dabanProductLabel.sd_layout
        .leftSpaceToView(self.contentView, 14)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(productLabel, 7)
        .heightIs(15);
        
        huangProductLabel.sd_layout
        .leftSpaceToView(self.contentView, 14)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(dabanProductLabel, 5)
        .heightIs(15);
        
        
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:productImageview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = productImageview.bounds;
//        maskLayer.path = maskPath.CGPath;
//        productImageview.layer.mask = maskLayer;
        //productImageview.layer.masksToBounds = YES;
        
        
        
    }
    return self;
}


@end
