//
//  RSPersonalBalanceCell.m
//  石来石往
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPersonalBalanceCell.h"


@interface RSPersonalBalanceCell()

{
    UILabel * _productNameLabel;
    UILabel * _productNameNumberLabel;
    UILabel * _productDetailNumberLabel;
    
    UILabel * _productNumberLabel;
    
    
    UILabel * _productDetailAreaLabel;
    
    UILabel * _productAreaLabel;
    
    UILabel * _productDetailWightLabel;
    
    UILabel * _productWightLabel;
}

@end

@implementation RSPersonalBalanceCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        
        UIView * balanceView = [[UIView alloc]init];
        balanceView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:balanceView];
        
        
        balanceView.sd_layout
        .topSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 10);
        
        
        UIImageView * yellewView = [[UIImageView alloc]init];
        //yellewView.backgroundColor = [UIColor colorWithHexColorStr:@"#FBC05F"];
        yellewView.image = [UIImage imageNamed:@"Rectangle 32 Copy 4"];
        yellewView.contentMode = UIViewContentModeScaleAspectFill;
        yellewView.clipsToBounds = YES;
        [balanceView addSubview:yellewView];
        
        
        
        yellewView.sd_layout
        .leftSpaceToView(balanceView, 0)
        .topSpaceToView(balanceView, 11)
        .heightIs(17)
        .widthIs(4);
        
        UIImageView * blueView = [[UIImageView alloc]init];
        blueView.image = [UIImage imageNamed:@"Rectangle 32 Copy 5"];
        blueView.contentMode = UIViewContentModeScaleAspectFill;
        blueView.clipsToBounds = YES;
        [balanceView addSubview:blueView];
        
        blueView.sd_layout
        .rightSpaceToView(balanceView, 0)
        .topSpaceToView(balanceView, 11)
        .heightIs(17)
        .widthIs(4);
        
        
        //产品名
        UILabel * productNameLabel = [[UILabel alloc]init];
        productNameLabel.text = @"白玉兰";
        productNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productNameLabel.font = [UIFont systemFontOfSize:17];
        productNameLabel.textAlignment = NSTextAlignmentLeft;
        [balanceView addSubview:productNameLabel];
        
         productNameLabel.sd_layout
        .leftSpaceToView(yellewView, 9)
        .topSpaceToView(balanceView, 8)
        .widthRatioToView(balanceView, 0.5)
        .heightIs(24);
        _productNameLabel = productNameLabel;
        
        
        //印章 To be reviewed
//        UIImageView * reviewedImageView = [[UIImageView alloc]init];
//        reviewedImageView.image = [UIImage imageNamed:@"印章 To be reviewed"];
//        reviewedImageView.contentMode = UIViewContentModeScaleAspectFill;
//        reviewedImageView.clipsToBounds = YES;
//        [balanceView addSubview:reviewedImageView];
//
//
//        reviewedImageView.sd_layout
//        .rightSpaceToView(balanceView, 12)
//        .topSpaceToView(balanceView, 9)
//        .heightIs(22)
//        .widthIs(45);
        

        //物料号
        UILabel * productNameNumberLabel = [[UILabel alloc]init];
        productNameNumberLabel.text = @"ESB00295/DH-539";
        productNameNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productNameNumberLabel.font = [UIFont systemFontOfSize:14];
        productNameNumberLabel.textAlignment = NSTextAlignmentRight;
        [balanceView addSubview:productNameNumberLabel];
        productNameNumberLabel.hidden = YES;
        
        productNameNumberLabel.sd_layout
        .rightSpaceToView(blueView, 9)
        .topSpaceToView(balanceView, 10)
        .heightIs(20)
        .widthRatioToView(balanceView, 0.5);
        
        _productNameNumberLabel = productNameNumberLabel;
        //数据的view
        UIView * dataView = [[UIView alloc]init];
        dataView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
        [balanceView addSubview:dataView];
        
        dataView.sd_layout
        .leftEqualToView(productNameLabel)
        .rightSpaceToView(balanceView, 12)
        .topSpaceToView(productNameLabel, 8)
        .heightIs(73);
        
        dataView.layer.cornerRadius = 6;
        
        //颗数数据
        UILabel * productDetailNumberLabel = [[UILabel alloc]init];
        productDetailNumberLabel.text = @"25颗";
        productDetailNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productDetailNumberLabel.font = [UIFont systemFontOfSize:15];
        productDetailNumberLabel.textAlignment = NSTextAlignmentLeft;
        [dataView addSubview:productDetailNumberLabel];
        _productDetailNumberLabel = productDetailNumberLabel;
        
        UILabel * productNumberLabel = [[UILabel alloc]init];
        productNumberLabel.text = @"总颗数";
        productNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        productNumberLabel.font = [UIFont systemFontOfSize:12];
        productNumberLabel.textAlignment = NSTextAlignmentLeft;
        [dataView addSubview:productNumberLabel];
        _productNumberLabel = productNumberLabel;
        
        productDetailNumberLabel.sd_layout
        .leftSpaceToView(dataView, 17)
        .topSpaceToView(dataView, 15)
        .heightIs(21)
        .widthRatioToView(dataView, 0.3);
        
        
        productNumberLabel.sd_layout
        .leftEqualToView(productDetailNumberLabel)
        .topSpaceToView(productDetailNumberLabel, 6)
        .heightIs(17)
        .widthIs(37);
        
        //体积数据
        
        UILabel * productDetailAreaLabel = [[UILabel alloc]init];
        productDetailAreaLabel.text = @"5.888m³";
        productDetailAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productDetailAreaLabel.font = [UIFont systemFontOfSize:15];
        productDetailAreaLabel.textAlignment = NSTextAlignmentCenter;
        [dataView addSubview:productDetailAreaLabel];
        
        _productDetailAreaLabel = productDetailAreaLabel;
      
        
        
        UILabel * productAreaLabel = [[UILabel alloc]init];
        productAreaLabel.text = @"总体积";
        productAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        productAreaLabel.font = [UIFont systemFontOfSize:12];
        productAreaLabel.textAlignment = NSTextAlignmentCenter;
        [dataView addSubview:productAreaLabel];
        _productAreaLabel = productAreaLabel;
        
        
        productDetailAreaLabel.sd_layout
        .centerXEqualToView(dataView)
        .topSpaceToView(dataView, 15)
        .heightIs(21)
        .widthRatioToView(dataView, 0.3);
        
        
        productAreaLabel.sd_layout
        .centerXEqualToView(dataView)
        .topSpaceToView(productDetailAreaLabel, 6)
        .heightIs(17)
        .widthIs(37);
        
        
        
        
        //总重量
        
        UILabel * productDetailWightLabel = [[UILabel alloc]init];
        productDetailWightLabel.text = @"5吨";
        productDetailWightLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productDetailWightLabel.font = [UIFont systemFontOfSize:15];
        productDetailWightLabel.textAlignment = NSTextAlignmentRight;
        [dataView addSubview:productDetailWightLabel];
        _productDetailWightLabel = productDetailWightLabel;
        
        
        UILabel * productWightLabel = [[UILabel alloc]init];
        productWightLabel.text = @"总重量";
        productWightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        productWightLabel.font = [UIFont systemFontOfSize:12];
        productWightLabel.textAlignment = NSTextAlignmentRight;
        [dataView addSubview:productWightLabel];
        _productWightLabel = productWightLabel;
        
        productDetailWightLabel.sd_layout
        .rightSpaceToView(dataView, 18)
        .topSpaceToView(dataView, 15)
        .heightIs(21)
        .widthRatioToView(dataView, 0.3);
        
        productWightLabel.sd_layout
        .rightEqualToView(productDetailWightLabel)
        .topSpaceToView(productDetailWightLabel, 6)
        .heightIs(17)
        .widthIs(37);
        
        
        
        //码单
        UIButton * codeSheetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [codeSheetBtn setTitle:@"码单" forState:UIControlStateNormal];
        [codeSheetBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        codeSheetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [balanceView addSubview:codeSheetBtn];
        _codeSheetBtn = codeSheetBtn;
        
        codeSheetBtn.sd_layout
        .rightSpaceToView(balanceView, 12)
        .topSpaceToView(dataView, 10)
        .widthIs(55)
        .heightIs(27);
        
        codeSheetBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#BCBCBC"].CGColor;
        codeSheetBtn.layer.borderWidth = 1;
        codeSheetBtn.layer.cornerRadius = 14;
        //报表
        //report form
        UIButton * reportFormBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reportFormBtn setTitle:@"报表" forState:UIControlStateNormal];
        [reportFormBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        reportFormBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [balanceView addSubview:reportFormBtn];
        _reportFormBtn = reportFormBtn;
        
        reportFormBtn.sd_layout
        .rightSpaceToView(codeSheetBtn, 12)
        .topSpaceToView(dataView, 10)
        .widthIs(55)
        .heightIs(27);
        reportFormBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#BCBCBC"].CGColor;
        reportFormBtn.layer.borderWidth = 1;
        reportFormBtn.layer.cornerRadius = 14;
 
    }
    return self;
}



- (void)setBalancemodel:(RSBalanceModel *)balancemodel{
    _balancemodel = balancemodel;
    
    if (_balancemodel.mtlName != nil) {
          _productNameLabel.text = balancemodel.mtlName;
    }else{
          _productNameLabel.text = balancemodel.whsName;
    }
  
    
    _productNumberLabel.text = @"总颗数";
    _productAreaLabel.text = @"总体积";
    _productWightLabel.text = @"总重量";
    
    _productDetailNumberLabel.text = [NSString stringWithFormat:@"%ld颗",balancemodel.qty];
    _productDetailAreaLabel.text = [NSString stringWithFormat:@"%@m³",[balancemodel.volume stringValue]];
    _productDetailWightLabel.text = [NSString stringWithFormat:@"%@吨",[balancemodel.weight stringValue]];
}


//- (void)setSelectFunctionType:(NSString *)selectFunctionType{
//    _selectFunctionType = selectFunctionType;
//
//
//    if ([_selectFunctionType isEqualToString:@"荒料库存余额表"]) {
//
//        _productNameNumberLabel.hidden = YES;
//
//        _productDetailNumberLabel.text = @"25颗";
//        _productNumberLabel.text = @"总颗数";
//        _productDetailAreaLabel.text = @"5.888m³";
//        _productAreaLabel.text = @"总体积";
//        _productDetailWightLabel.text = @"5吨";
//        _productWightLabel.text = @"总重量";
//
//    }else{
//        _productDetailNumberLabel.text = @"5匝";
//        _productNumberLabel.text = @"总匝数";
//        _productDetailAreaLabel.text = @"28片";
//        _productAreaLabel.text = @"总片数";
//        _productDetailWightLabel.text = @"5.888m²";
//        _productWightLabel.text = @"总面积";
//         _productNameNumberLabel.hidden = NO;
//
//    }
//
//
//
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
