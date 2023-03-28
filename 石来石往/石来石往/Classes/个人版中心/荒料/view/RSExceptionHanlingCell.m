//
//  RSExceptionHanlingCell.m
//  石来石往
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSExceptionHanlingCell.h"


@interface RSExceptionHanlingCell()
{
    
    
    UILabel * _productNameLabel;
    
    
    UILabel * _productDetailLabel;
    
    UILabel * _productTypeDetailLabel;
    
    
    UILabel * _productShapeDetailLabel;
    
    UILabel * _productAreaDetailLabel;
    
    UILabel * _productWightDetailLabel;
}

@end


@implementation RSExceptionHanlingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
        //内容信息
        UIView * exceptionView = [[UIView alloc]init];
        exceptionView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [self.contentView addSubview:exceptionView];
        
        
        exceptionView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 5)
        .heightIs(184);
        
        
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
        _productNameLabel = productNameLabel;
        //编辑按键
//        UIButton * productEidtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [productEidtBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        // [productEidtBtn setTitle:@"" forState:UIControlStateNormal];
        // [productEidtBtn setTitleColor:[UIColor colorWithHexColorStr:@""] forState:UIControlStateNormal];
      //  [productEidtBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
//        [exceptionView addSubview:productEidtBtn];
       // _productEidtBtn = productEidtBtn;
        
        
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
        _productDetailLabel = productDetailLabel;
        
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
        
        _productTypeDetailLabel = productTypeDetailLabel;
        
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
        _productShapeDetailLabel = productShapeDetailLabel;
        
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
        _productAreaDetailLabel = productAreaDetailLabel;
        
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
        _productWightDetailLabel = productWightDetailLabel;
        
        UILabel * handleLabel = [[UILabel alloc]init];
        handleLabel.text = @"处理后";
        handleLabel.textAlignment = NSTextAlignmentLeft;
        handleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        handleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:handleLabel];
        _handleLabel = handleLabel;
        
        UIButton * handBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [handBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
        [handBtn setTitle:@"断裂+1" forState:UIControlStateNormal];
        handBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [handBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [self.contentView addSubview:handBtn];
        _handBtn = handBtn;
        
        
        
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
        
        
//        productEidtBtn.sd_layout
//        .rightSpaceToView(productDeleteBtn, 10)
//        .topEqualToView(productDeleteBtn)
//        .bottomEqualToView(productDeleteBtn)
//        .widthIs(28);
        
        
        midView.sd_layout
        .leftSpaceToView(exceptionView, 0)
        .rightSpaceToView(exceptionView, 0)
        .topSpaceToView(productNameLabel, 5)
        .heightIs(2);
        
        
        
        
        productLabel.sd_layout
        .leftSpaceToView(exceptionView, 17)
        .topSpaceToView(midView, 7)
        .widthIs(70)
        .heightIs(21);
        
        productDetailLabel.sd_layout
        .rightSpaceToView(exceptionView, 15)
        .topEqualToView(productLabel)
        .bottomEqualToView(productLabel)
        .widthRatioToView(exceptionView, 0.5);
        
        
        
        
        productTypeLabel.sd_layout
        .leftEqualToView(productLabel)
        .rightEqualToView(productLabel)
        .topSpaceToView(productLabel, 3)
        .heightIs(21);
        
        
        productTypeDetailLabel.sd_layout
        .rightEqualToView(productDetailLabel)
        .topEqualToView(productTypeLabel)
        .bottomEqualToView(productTypeLabel)
        .leftEqualToView(productDetailLabel);
        
        
        productShapeLabel.sd_layout
        .leftEqualToView(productTypeLabel)
        .topSpaceToView(productTypeLabel, 3)
        .widthIs(85)
        .heightIs(21);
        
        
        productShapeDetailLabel.sd_layout
        .leftEqualToView(productTypeDetailLabel)
        .rightEqualToView(productTypeDetailLabel)
        .topEqualToView(productShapeLabel)
        .bottomEqualToView(productShapeLabel);
        
        
        productAreaLabel.sd_layout
        .leftEqualToView(productShapeLabel)
        .topSpaceToView(productShapeLabel, 3)
        .widthIs(70)
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
        .widthIs(65);
        
        productWightDetailLabel.sd_layout
        .leftEqualToView(productAreaDetailLabel)
        .rightEqualToView(productAreaDetailLabel)
        .topEqualToView(productWightLabel)
        .bottomEqualToView(productWightLabel);
        
        handleLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(exceptionView, 12)
        .widthIs(100)
        .heightIs(20);
        
        
        handBtn.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(exceptionView, 12)
        .widthIs(52)
        .heightIs(21);
    }
    return self;
}


- (void)setStoragemanagementmodel:(RSStoragemanagementModel *)storagemanagementmodel{
    _storagemanagementmodel = storagemanagementmodel;
    _productNameLabel.text = storagemanagementmodel.blockNo;
    _productDetailLabel.text = storagemanagementmodel.mtlName;
    _productTypeDetailLabel.text = storagemanagementmodel.mtltypeName;
    
    _productShapeDetailLabel.text = [NSString stringWithFormat:@"%0.1lf | %0.1lf | %0.2lf",[storagemanagementmodel.length doubleValue],[storagemanagementmodel.width doubleValue],[storagemanagementmodel.height doubleValue]];
    
    _productAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[storagemanagementmodel.volume doubleValue]];
    _productWightDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[storagemanagementmodel.weight doubleValue]];
    
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
