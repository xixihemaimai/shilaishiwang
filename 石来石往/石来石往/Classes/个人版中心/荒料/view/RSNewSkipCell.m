//
//  RSNewSkipCell.m
//  石来石往
//
//  Created by mac on 2019/6/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSNewSkipCell.h"

@interface RSNewSkipCell()
{
    UILabel * _nameLabel;
    
    UILabel * _productLabel;
    
    UILabel * _lengDetaiLabel;
    UILabel * _widthDetaiLabel;
    UILabel * _heightDetialLabel;
    UILabel * _wightDetailLabel;
    UILabel * _completeDetailLabel;
    UILabel * _timberDetailLabel;
    
}



@end



@implementation RSNewSkipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        //左边蓝边
        UIView * blueView = [[UIView alloc]init];
        blueView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
        [self.contentView addSubview:blueView];
        
        
        //物料名称
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"白玉兰";
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        //物料号
        UILabel * productLabel = [[UILabel alloc]init];
        productLabel.text = @"ESB00295/DH-539";
        productLabel.textAlignment = NSTextAlignmentRight;
        productLabel.font = [UIFont systemFontOfSize:15];
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:productLabel];
        _productLabel = productLabel;
        
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#FAF8FB"];
        [self.contentView addSubview:showView];
        
        
        //长
        UILabel * lengLabel = [[UILabel alloc]init];
        lengLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#EFEDF1"];
        lengLabel.textAlignment = NSTextAlignmentCenter;
        lengLabel.text = @"长";
        lengLabel.font = [UIFont systemFontOfSize:14];
        lengLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [showView addSubview:lengLabel];
        
        
        UILabel * lengDetaiLabel = [[UILabel alloc]init];
        lengDetaiLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FAF8FB"];
        lengDetaiLabel.textAlignment = NSTextAlignmentCenter;
        lengDetaiLabel.text = @"2.333cm";
        lengDetaiLabel.font = [UIFont systemFontOfSize:15];
        lengDetaiLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:lengDetaiLabel];
        _lengDetaiLabel = lengDetaiLabel;
        
        
        //宽
        UILabel * widthLabel = [[UILabel alloc]init];
        widthLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#EFEDF1"];
        widthLabel.textAlignment = NSTextAlignmentCenter;
        widthLabel.text = @"宽";
        widthLabel.font = [UIFont systemFontOfSize:14];
        widthLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [showView addSubview:widthLabel];
        
        
        UILabel * widthDetaiLabel = [[UILabel alloc]init];
        widthDetaiLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FAF8FB"];
        widthDetaiLabel.textAlignment = NSTextAlignmentCenter;
        widthDetaiLabel.text = @"2.333cm";
        widthDetaiLabel.font = [UIFont systemFontOfSize:15];
        widthDetaiLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:widthDetaiLabel];
        _widthDetaiLabel = widthDetaiLabel;
        
        
        
        //厚
        UILabel * heightLabel = [[UILabel alloc]init];
        heightLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#EFEDF1"];
        heightLabel.textAlignment = NSTextAlignmentCenter;
        heightLabel.text = @"高";
        heightLabel.font = [UIFont systemFontOfSize:14];
        heightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [showView addSubview:heightLabel];
        
        
        UILabel * heightDetialLabel = [[UILabel alloc]init];
        heightDetialLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FAF8FB"];
        heightDetialLabel.textAlignment = NSTextAlignmentCenter;
        heightDetialLabel.text = @"1.333cm";
        heightDetialLabel.font = [UIFont systemFontOfSize:15];
        heightDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:heightDetialLabel];
        _heightDetialLabel = heightDetialLabel;
        
        
        //重量
        UILabel * wightLabel = [[UILabel alloc]init];
        wightLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#EFEDF1"];
        wightLabel.textAlignment = NSTextAlignmentCenter;
        wightLabel.text = @"重量";
        wightLabel.font = [UIFont systemFontOfSize:14];
        wightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [showView addSubview:wightLabel];
        
        
        UILabel * wightDetailLabel = [[UILabel alloc]init];
        wightDetailLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FAF8FB"];
        wightDetailLabel.textAlignment = NSTextAlignmentCenter;
        wightDetailLabel.text = @"2.333吨";
        wightDetailLabel.font = [UIFont systemFontOfSize:15];
        wightDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:wightDetailLabel];
        _wightDetailLabel = wightDetailLabel;
        
        
        //完工平方数
        UILabel * completeLabel = [[UILabel alloc]init];
        completeLabel.numberOfLines = 0;
        completeLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#EFEDF1"];
        completeLabel.textAlignment = NSTextAlignmentCenter;
        completeLabel.text = @"完工\n平方数";
        completeLabel.font = [UIFont systemFontOfSize:12];
        completeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [showView addSubview:completeLabel];
        
        UILabel * completeDetailLabel = [[UILabel alloc]init];
        completeDetailLabel.numberOfLines = 0;
        completeDetailLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FAF8FB"];
        completeDetailLabel.textAlignment = NSTextAlignmentCenter;
        completeDetailLabel.text = @"1.333m²";
        completeDetailLabel.font = [UIFont systemFontOfSize:15];
        completeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:completeDetailLabel];
        _completeDetailLabel = completeDetailLabel;
        
        
        
        //出材率
        UILabel * timberLabel = [[UILabel alloc]init];
        timberLabel.numberOfLines = 0;
        timberLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#EFEDF1"];
        timberLabel.textAlignment = NSTextAlignmentCenter;
        timberLabel.text = @"出材率";
        timberLabel.font = [UIFont systemFontOfSize:14];
        timberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [showView addSubview:timberLabel];
        
        UILabel * timberDetailLabel = [[UILabel alloc]init];
        timberDetailLabel.numberOfLines = 0;
        timberDetailLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FAF8FB"];
        timberDetailLabel.textAlignment = NSTextAlignmentCenter;
        timberDetailLabel.text = @"99.9%";
        timberDetailLabel.font = [UIFont systemFontOfSize:15];
        timberDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showView addSubview:timberDetailLabel];
        _timberDetailLabel = timberDetailLabel;
        
        blueView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 16)
        .heightIs(14)
        .widthIs(3);
        blueView.layer.cornerRadius = 2;
        
        nameLabel.sd_layout
        .leftSpaceToView(blueView, 3)
        .topSpaceToView(self.contentView, 12)
        .heightIs(21)
        .widthRatioToView(self.contentView, 0.5);
        
        
        productLabel.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 12)
        .heightIs(21)
        .widthRatioToView(self.contentView, 0.5);
        
        
        showView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(nameLabel, 5)
        .bottomSpaceToView(self.contentView, 0);
        
        
        lengLabel.sd_layout
        .leftSpaceToView(showView, 0)
        .topSpaceToView(showView, 0)
        .widthIs(62)
        .heightIs(33);
        
        
        lengDetaiLabel.sd_layout
        .topEqualToView(lengLabel)
        .leftSpaceToView(lengLabel, 0)
        .bottomEqualToView(lengLabel)
        .widthIs(SCW/2 - 12 - 62);
        
        
        
        widthLabel.sd_layout
        .leftSpaceToView(showView, 0)
        .topSpaceToView(lengLabel, 1)
        .widthIs(62)
        .heightIs(33);
        
        widthDetaiLabel.sd_layout
        .topEqualToView(widthLabel)
        .leftSpaceToView(widthLabel, 0)
        .bottomEqualToView(widthLabel)
        .widthIs(SCW/2 - 12 - 62);
        
        
        heightLabel.sd_layout
        .leftSpaceToView(showView, 0)
        .topSpaceToView(widthLabel, 1)
        .widthIs(62)
        .heightIs(33);
        
        
        heightDetialLabel.sd_layout
        .topEqualToView(heightLabel)
        .leftSpaceToView(heightLabel, 0)
        .bottomEqualToView(heightLabel)
        .widthIs(SCW/2 - 12 - 62);
        
        
        wightLabel.sd_layout
        .leftSpaceToView(lengDetaiLabel, 0)
        .topSpaceToView(showView, 0)
        .widthIs(62)
        .heightIs(33);
        
        wightDetailLabel.sd_layout
        .leftSpaceToView(wightLabel, 0)
        .topEqualToView(wightLabel)
        .bottomEqualToView(wightLabel)
        .widthIs(SCW/2 - 12 - 62);
        
        
        wightLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#FAF8FB"].CGColor;
        wightLabel.layer.borderWidth = 0.5;
        
        
        wightDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#FAF8FB"].CGColor;
        wightDetailLabel.layer.borderWidth = 0.5;
        
        
        
        completeLabel.sd_layout
        .leftSpaceToView(widthDetaiLabel, 0)
        .topSpaceToView(wightLabel, 0.5)
        .widthIs(62)
        .heightIs(33);
        
        
        completeDetailLabel.sd_layout
        .leftSpaceToView(completeLabel, 0)
        .topEqualToView(completeLabel)
        .bottomEqualToView(completeLabel)
        .widthIs(SCW/2 - 12 - 62);
        completeLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#FAF8FB"].CGColor;
        completeLabel.layer.borderWidth = 0.5;
        completeDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#FAF8FB"].CGColor;
        completeDetailLabel.layer.borderWidth = 0.5;
        
        timberLabel.sd_layout
        .leftSpaceToView(heightDetialLabel,0)
        .topSpaceToView(completeLabel, 0.5)
        .widthIs(62)
        .heightIs(33);
        
        timberDetailLabel.sd_layout
        .leftSpaceToView(timberLabel, 0)
        .topEqualToView(timberLabel)
        .bottomEqualToView(timberLabel)
        .widthIs(SCW/2 - 12 - 62);
        
        timberLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#FAF8FB"].CGColor;
        timberLabel.layer.borderWidth = 0.5;
        
        timberDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#FAF8FB"].CGColor;
        timberDetailLabel.layer.borderWidth = 0.5;
        
    }
    return self;
}

- (void)setOutPutRatemodel:(RSOutPutRateModel *)outPutRatemodel{
    _outPutRatemodel = outPutRatemodel;
    _nameLabel.text = _outPutRatemodel.mtlName;
    _productLabel.text = _outPutRatemodel.blockNo;
    _lengDetaiLabel.text = [NSString stringWithFormat:@"%0.1lfcm",[_outPutRatemodel.length floatValue]];
    _widthDetaiLabel.text = [NSString stringWithFormat:@"%0.1lfcm",[_outPutRatemodel.width floatValue]];
    _heightDetialLabel.text = [NSString stringWithFormat:@"%0.2lfcm",[_outPutRatemodel.height floatValue]];
    _wightDetailLabel.text = [NSString stringWithFormat:@"%0.3lf吨",[_outPutRatemodel.weight floatValue]];
    _completeDetailLabel.text = [NSString stringWithFormat:@"%0.3lfm²",[_outPutRatemodel.area floatValue]];
    _timberDetailLabel.text = [NSString stringWithFormat:@"%0.2lf",[_outPutRatemodel.rate floatValue]];
    
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
