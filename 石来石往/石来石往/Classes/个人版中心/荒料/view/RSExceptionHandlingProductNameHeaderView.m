//
//  RSExceptionHandlingProductNameHeaderView.m
//  石来石往
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSExceptionHandlingProductNameHeaderView.h"

@implementation RSExceptionHandlingProductNameHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
        //内容信息
        UIView * exceptionView = [[UIView alloc]init];
        exceptionView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [self.contentView addSubview:exceptionView];
        
        
        exceptionView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 12)
        .heightIs(191);
        
        
        exceptionView.layer.cornerRadius = 3;
        
        
        UIImageView * yellewView = [[UIImageView alloc]init];
        //yellewView.backgroundColor = [UIColor colorWithHexColorStr:@"#FBC05F"];
        yellewView.image = [UIImage imageNamed:@"Rectangle 32 Copy 4"];
        yellewView.contentMode = UIViewContentModeScaleAspectFill;
        yellewView.clipsToBounds = YES;
        [exceptionView addSubview:yellewView];
        
        
        
        yellewView.sd_layout
        .leftSpaceToView(exceptionView, 0)
        .topSpaceToView(exceptionView, 12)
        .heightIs(17)
        .widthIs(4);
        
        UIImageView * blueView = [[UIImageView alloc]init];
        blueView.image = [UIImage imageNamed:@"Rectangle 32 Copy 5"];
        blueView.contentMode = UIViewContentModeScaleAspectFill;
        blueView.clipsToBounds = YES;
        [exceptionView addSubview:blueView];
        
        blueView.sd_layout
        .rightSpaceToView(exceptionView, 0)
        .topSpaceToView(exceptionView, 12)
        .heightIs(17)
        .widthIs(4);
        
        //物料号
        UILabel * productNameLabel = [[UILabel alloc]init];
        productNameLabel.text = @"ESB00295/DH-539";
        productNameLabel.font = [UIFont systemFontOfSize:15];
        productNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productNameLabel.textAlignment = NSTextAlignmentLeft;
        [exceptionView addSubview:productNameLabel];
        
        //编辑按键
        UIButton * productEidtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [productEidtBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        // [productEidtBtn setTitle:@"" forState:UIControlStateNormal];
        // [productEidtBtn setTitleColor:[UIColor colorWithHexColorStr:@""] forState:UIControlStateNormal];
        //[productEidtBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
        [exceptionView addSubview:productEidtBtn];
        _productEidtBtn = productEidtBtn;
        
        
        //删除按键
        UIButton * productDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [productDeleteBtn setImage:[UIImage imageNamed:@"垃圾桶"] forState:UIControlStateNormal];
        //[productDeleteBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
        [exceptionView addSubview:productDeleteBtn];
        
        _productDeleteBtn = productDeleteBtn;
        //分割线
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [exceptionView addSubview:midView];
        
        
        
        //物料名称
        UILabel * productLabel = [[UILabel alloc]init];
        productLabel.text = @"物料名称";
        productLabel.font = [UIFont systemFontOfSize:15];
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        productLabel.textAlignment = NSTextAlignmentLeft;
        [exceptionView addSubview:productLabel];
        
        UILabel * productDetailLabel = [[UILabel alloc]init];
        productDetailLabel.text = @"白玉兰";
        productDetailLabel.font = [UIFont systemFontOfSize:15];
        productDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productDetailLabel.textAlignment = NSTextAlignmentRight;
        [exceptionView addSubview:productDetailLabel];
        
        
        UILabel * productModifyLabel = [[UILabel alloc]init];
        NSDictionary *attribtDic2 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSMutableAttributedString * attribtStr2 = [[NSMutableAttributedString alloc]initWithString:@"白玉蓝" attributes:attribtDic2];
        //[[NSMutableAttributedString alloc]initWithString:oldStrattributes:attribtDic];
        productModifyLabel.attributedText= attribtStr2;
        
        productModifyLabel.font = [UIFont systemFontOfSize:10];
        productModifyLabel.textColor = [UIColor colorWithHexColorStr:@"#D0021B"];
        productModifyLabel.textAlignment = NSTextAlignmentRight;
        [exceptionView addSubview:productModifyLabel];
        
        
        //物料类型
        UILabel * productTypeLabel = [[UILabel alloc]init];
        productTypeLabel.text = @"物料类型";
        productTypeLabel.font = [UIFont systemFontOfSize:15];
        productTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        productTypeLabel.textAlignment = NSTextAlignmentLeft;
        [exceptionView addSubview:productTypeLabel];
        
        
        UILabel * productTypeDetailLabel = [[UILabel alloc]init];
        productTypeDetailLabel.text = @"大理石";
        productTypeDetailLabel.font = [UIFont systemFontOfSize:15];
        productTypeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productTypeDetailLabel.textAlignment = NSTextAlignmentRight;
        [exceptionView addSubview:productTypeDetailLabel];
        
        
        
        //长宽高
        UILabel * productShapeLabel = [[UILabel alloc]init];
        productShapeLabel.text = @"长宽高(cm)";
        productShapeLabel.font = [UIFont systemFontOfSize:15];
        productShapeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        productShapeLabel.textAlignment = NSTextAlignmentLeft;
        [exceptionView addSubview:productShapeLabel];
        
        
        UILabel * productShapeDetailLabel = [[UILabel alloc]init];
        productShapeDetailLabel.text = @"0.1 | 3.3 | 2.8";
        productShapeDetailLabel.font = [UIFont systemFontOfSize:15];
        productShapeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productShapeDetailLabel.textAlignment = NSTextAlignmentRight;
        [exceptionView addSubview:productShapeDetailLabel];
        
        
        //体积
        UILabel * productAreaLabel = [[UILabel alloc]init];
        productAreaLabel.text = @"体积(m³)";
        productAreaLabel.font = [UIFont systemFontOfSize:15];
        productAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        productAreaLabel.textAlignment = NSTextAlignmentLeft;
        [exceptionView addSubview:productAreaLabel];
        
        
        UILabel * productAreaDetailLabel = [[UILabel alloc]init];
        productAreaDetailLabel.text = @"5.883";
        productAreaDetailLabel.font = [UIFont systemFontOfSize:15];
        productAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productAreaDetailLabel.textAlignment = NSTextAlignmentRight;
        [exceptionView addSubview:productAreaDetailLabel];
        
        
        //重量
        UILabel * productWightLabel = [[UILabel alloc]init];
        productWightLabel.text = @"重量(吨)";
        productWightLabel.font = [UIFont systemFontOfSize:15];
        productWightLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        productWightLabel.textAlignment = NSTextAlignmentLeft;
        [exceptionView addSubview:productWightLabel];
        
        
        
        UILabel * productWightDetailLabel = [[UILabel alloc]init];
        productWightDetailLabel.text = @"5.445";
        productWightDetailLabel.font = [UIFont systemFontOfSize:15];
        productWightDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productWightDetailLabel.textAlignment = NSTextAlignmentRight;
        [exceptionView addSubview:productWightDetailLabel];
        
        
        productNameLabel.sd_layout
        .leftSpaceToView(exceptionView, 17)
        .topSpaceToView(exceptionView, 15)
        .heightIs(21)
        .widthRatioToView(exceptionView, 0.5);
        
        
        productDeleteBtn.sd_layout
        .rightSpaceToView(exceptionView, 16)
        .topSpaceToView(exceptionView, 7)
        .widthIs(28)
        .heightEqualToWidth();
        
        
        productEidtBtn.sd_layout
        .rightSpaceToView(productDeleteBtn, 10)
        .topEqualToView(productDeleteBtn)
        .bottomEqualToView(productDeleteBtn)
        .widthIs(28);
        
        
        midView.sd_layout
        .leftSpaceToView(exceptionView, 0)
        .rightSpaceToView(exceptionView, 0)
        .topSpaceToView(productNameLabel, 5)
        .heightIs(2);
        
        
        
        
        productLabel.sd_layout
        .leftSpaceToView(exceptionView, 17)
        .topSpaceToView(midView, 7)
        .widthIs(62)
        .heightIs(21);
        
        productDetailLabel.sd_layout
        .rightSpaceToView(exceptionView, 15)
        .topEqualToView(productLabel)
        .bottomEqualToView(productLabel)
        .widthRatioToView(exceptionView, 0.5);
        
        productModifyLabel.sd_layout
        .leftEqualToView(productDetailLabel)
        .rightEqualToView(productDetailLabel)
        .topSpaceToView(productDetailLabel, -3)
        .heightIs(14);
        
        
        
        productTypeLabel.sd_layout
        .leftEqualToView(productLabel)
        .rightEqualToView(productLabel)
        .topSpaceToView(productLabel, 10)
        .heightIs(21);
        
        
        productTypeDetailLabel.sd_layout
        .rightEqualToView(productDetailLabel)
        .topEqualToView(productTypeLabel)
        .bottomEqualToView(productTypeLabel)
        .leftEqualToView(productDetailLabel);
        
        
        productShapeLabel.sd_layout
        .leftEqualToView(productTypeLabel)
        .topSpaceToView(productTypeLabel, 3)
        .widthIs(78)
        .heightIs(21);
        
        
        productShapeDetailLabel.sd_layout
        .leftEqualToView(productTypeDetailLabel)
        .rightEqualToView(productTypeDetailLabel)
        .topEqualToView(productShapeLabel)
        .bottomEqualToView(productShapeLabel);
        
        
        productAreaLabel.sd_layout
        .leftEqualToView(productShapeLabel)
        .topSpaceToView(productShapeLabel, 3)
        .widthIs(62)
        .heightIs(21);
        
        
        productAreaDetailLabel.sd_layout
        .leftEqualToView(productShapeDetailLabel)
        .rightEqualToView(productShapeDetailLabel)
        .topEqualToView(productAreaLabel)
        .bottomEqualToView(productAreaLabel);
        
        
        productWightLabel.sd_layout
        .leftEqualToView(productAreaLabel)
        .topSpaceToView(productAreaLabel, 3)
        .heightIs(21)
        .widthIs(57);
        
        productWightDetailLabel.sd_layout
        .leftEqualToView(productAreaDetailLabel)
        .rightEqualToView(productAreaDetailLabel)
        .topEqualToView(productWightLabel)
        .bottomEqualToView(productWightLabel);
        
        
        UILabel * exceptionHandleLabel = [[UILabel alloc]init];
        exceptionHandleLabel.text = @"处理后";
        exceptionHandleLabel.font = [UIFont systemFontOfSize:14];
        exceptionHandleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        exceptionHandleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:exceptionHandleLabel];
        
        
        exceptionHandleLabel.sd_layout
        .leftEqualToView(exceptionView)
        .topSpaceToView(exceptionView, 12)
        .heightIs(20)
        .widthIs(43);
        
        
        UIButton * exceptionHandleCrackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [exceptionHandleCrackBtn setTitle:@"断裂+1" forState:UIControlStateNormal];
        [exceptionHandleCrackBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
        [exceptionHandleCrackBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [self.contentView addSubview:exceptionHandleCrackBtn];
        exceptionHandleCrackBtn.layer.cornerRadius = 11;
        exceptionHandleCrackBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _exceptionHandleCrackBtn = exceptionHandleCrackBtn;
        
        exceptionHandleCrackBtn.sd_layout
        .rightSpaceToView(self.contentView, 13)
        .topSpaceToView(exceptionView, 8)
        .heightIs(21)
        .widthIs(52);
        
    }
    return self;
}

@end
