//
//  RSPersonalFunctionCell.m
//  石来石往
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPersonalFunctionCell.h"

@implementation RSPersonalFunctionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        [self.contentView addSubview:showView];
        
        //显示界面的内容
        UIImageView * showImageView = [[UIImageView alloc]init];
        showImageView.contentMode = UIViewContentModeScaleAspectFill;
        showImageView.clipsToBounds = YES;
        showImageView.image = [UIImage imageNamed:@"已入库"];
        [showView addSubview:showImageView];
        _showImageView = showImageView;
        //单号
        UILabel * showLabel = [[UILabel alloc]init];
        showLabel.text = @"单号：CGRK201901070001";
        showLabel.textAlignment = NSTextAlignmentLeft;
        showLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        UIFont * font = [UIFont fontWithName:@"PingFangSC" size:16];
        showLabel.font = font;
        [showView addSubview:showLabel];
        _showLabel = showLabel;
        //时间
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"2019/01/12";
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        timeLabel.font = [UIFont systemFontOfSize:10];
        [showView addSubview:timeLabel];
        _timeLabel = timeLabel;
        //物料名称
        UILabel * productLabel = [[UILabel alloc]init];
        productLabel.text = @"物料名称：白玉兰、黑芝麻、奥特曼…";
        productLabel.textAlignment = NSTextAlignmentLeft;
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        productLabel.font = [UIFont systemFontOfSize:15];
        [showView addSubview:productLabel];
        _productLabel = productLabel;
        //颗数
        UILabel * numberLabel = [[UILabel alloc]init];
        numberLabel.text = @"颗  数：2颗";
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        numberLabel.font = [UIFont systemFontOfSize:15];
        [showView addSubview:numberLabel];
        _numberLabel = numberLabel;
        //立方米
        UILabel * areaLabel = [[UILabel alloc]init];
        areaLabel.text = @"立方米：3.234m³";
        areaLabel.textAlignment = NSTextAlignmentLeft;
        areaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        areaLabel.font = [UIFont systemFontOfSize:15];
        [showView addSubview:areaLabel];
        _areaLabel = areaLabel;
        //状态
        UILabel * statusLabel = [[UILabel alloc]init];
        statusLabel.text = @"已入库";
        statusLabel.textAlignment = NSTextAlignmentRight;
        statusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
        statusLabel.font = [UIFont systemFontOfSize:12];
        [showView addSubview:statusLabel];
        _statusLabel = statusLabel;
        
        
        //异常类型
        UILabel * abnormalLabel = [[UILabel alloc]init];
        abnormalLabel.text = @"异常类型:断裂处理";
        abnormalLabel.textAlignment = NSTextAlignmentLeft;
        abnormalLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        abnormalLabel.font = [UIFont systemFontOfSize:15];
        [showView addSubview:abnormalLabel];
        _abnormalLabel = abnormalLabel;
        
        //异常类型的详情值
//        UILabel * abnormalDetailLabel = [[UILabel alloc]init];
//        abnormalDetailLabel.text = @"断裂处理";
//        abnormalDetailLabel.textAlignment = NSTextAlignmentLeft;
//        abnormalDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//        abnormalDetailLabel.font = [UIFont systemFontOfSize:15];
//        [showView addSubview:abnormalDetailLabel];
        
        
        
        showView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0);
        showView.layer.cornerRadius = 6;
        
        showImageView.sd_layout
        .leftSpaceToView(showView, 15)
        .topSpaceToView(showView, 16)
        .widthIs(32)
        .heightEqualToWidth();
        
        showLabel.sd_layout
        .topSpaceToView(showView, 12)
        .leftSpaceToView(showImageView, 9)
        .widthRatioToView(showView, 0.6)
        .heightIs(23);
        
        
        timeLabel.sd_layout
        .rightSpaceToView(showView, 14)
        .topSpaceToView(showView, 19)
        .heightIs(14)
        .widthRatioToView(showView, 0.3);
        
        
        productLabel.sd_layout
        .leftEqualToView(showLabel)
        .rightSpaceToView(showView, 12)
        .topSpaceToView(showLabel, 3)
        .heightIs(21);
        
        numberLabel.sd_layout
        .leftEqualToView(productLabel)
        .rightEqualToView(productLabel)
        .topSpaceToView(productLabel, 3)
        .heightIs(21);
        
        areaLabel.sd_layout
        .leftEqualToView(numberLabel)
        .rightEqualToView(numberLabel)
        .topSpaceToView(numberLabel, 3)
        .heightIs(21);
        
        statusLabel.sd_layout
        .rightSpaceToView(showView, 14)
        .widthRatioToView(showView, 0.3)
        .heightIs(14)
        .bottomSpaceToView(showView, 13);
        
        
        abnormalLabel.sd_layout
        .leftEqualToView(areaLabel)
        .rightEqualToView(areaLabel)
        .topSpaceToView(areaLabel, 3)
        .heightIs(21);
    }
    return self;
}


- (void)setPersonalFunctionmodel:(RSPersonalFunctionModel *)personalFunctionmodel{
    _personalFunctionmodel = personalFunctionmodel;
    if (_personalFunctionmodel.status == 0) {
        if ([_personalFunctionmodel.billType isEqualToString:@"BILL_BL_CGRK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_BL_JGRK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_BL_PYRK"]) {
            _showImageView.image = [UIImage imageNamed:@"等待"];
            _statusLabel.text = @"等待入库";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
            _abnormalLabel.hidden = YES;
            _numberLabel.text = [NSString stringWithFormat:@"颗数:%ld",(long)_personalFunctionmodel.totalQty];
            _areaLabel.text = [NSString stringWithFormat:@"立方数:%0.3lfm³",[_personalFunctionmodel.totalVolume doubleValue]];
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_BL_XSCK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_BL_JGCK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_BL_PKCK"]){
                _abnormalLabel.hidden = YES;
                _showImageView.image = [UIImage imageNamed:@"等待"];
                _statusLabel.text = @"等待出库";
                _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
            _numberLabel.text = [NSString stringWithFormat:@"颗数:%ld",(long)_personalFunctionmodel.totalQty];
            _areaLabel.text = [NSString stringWithFormat:@"立方数:%0.3lfm³",[_personalFunctionmodel.totalVolume doubleValue]];
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_BL_YCCL"]){
            _abnormalLabel.hidden = NO;
            //_abnormalLabel.text = _personalFunctionmodel.abType;
            if ([_personalFunctionmodel.abType isEqualToString:@"dlcl"]) {
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:断裂处理"];
            }else if ([_personalFunctionmodel.abType isEqualToString:@"wlbg"])
            {
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:物料变更"];
            }else{
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:尺寸变更"];
            }
            _showImageView.image = [UIImage imageNamed:@"等待"];
            _statusLabel.text = @"正在处理";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
            _numberLabel.text = [NSString stringWithFormat:@"颗数:%ld",(long)_personalFunctionmodel.totalQty];
            _areaLabel.text = [NSString stringWithFormat:@"立方数:%0.3lfm³",[_personalFunctionmodel.totalVolume doubleValue]];
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_BL_DB"]){
            //荒料调拨
            _showImageView.image = [UIImage imageNamed:@"等待"];
            _statusLabel.text = @"正在调试";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
           // _abnormalLabel.text = [NSString stringWithFormat:@"仓库:%@",_personalFunctionmodel.warehouse];
             _abnormalLabel.text = [NSString stringWithFormat:@"仓库:%@->%@",_personalFunctionmodel.warehouse,_personalFunctionmodel.warehouseIn];
            _numberLabel.text = [NSString stringWithFormat:@"颗数:%ld",(long)_personalFunctionmodel.totalQty];
            _areaLabel.text = [NSString stringWithFormat:@"立方数:%0.3lfm³",[_personalFunctionmodel.totalVolume doubleValue]];
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_SL_CGRK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_SL_JGRK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_SL_PYRK"]){
            
            _showImageView.image = [UIImage imageNamed:@"等待"];
            _statusLabel.text = @"等待入库";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
            _numberLabel.text = [NSString stringWithFormat:@"匝数:%ld匝",(long)_personalFunctionmodel.totalTurns];
            _areaLabel.text = [NSString stringWithFormat:@"平方数:%0.3lfm²",[_personalFunctionmodel.totalArea doubleValue]];
            _abnormalLabel.hidden = YES;
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_SL_XSCK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_SL_JGCK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_SL_PKCK"]){
            
            _showImageView.image = [UIImage imageNamed:@"等待"];
            _statusLabel.text = @"等待出库";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
            _numberLabel.text = [NSString stringWithFormat:@"匝数:%ld匝",(long)_personalFunctionmodel.totalTurns];
            _areaLabel.text = [NSString stringWithFormat:@"平方数:%0.3lfm²",[_personalFunctionmodel.totalArea doubleValue]];
            _abnormalLabel.hidden = YES;
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_SL_YCCL"]){
            _abnormalLabel.hidden = NO;
            if ([_personalFunctionmodel.abType isEqualToString:@"dlcl"]) {
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:断裂处理"];
            }else if ([_personalFunctionmodel.abType isEqualToString:@"wlbg"])
            {
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:物料变更"];
            }else{
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:尺寸变更"];
            }
            _showImageView.image = [UIImage imageNamed:@"等待"];
            _statusLabel.text = @"正在处理";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
            _numberLabel.text = [NSString stringWithFormat:@"匝数:%ld",(long)_personalFunctionmodel.totalTurns];
            _areaLabel.text = [NSString stringWithFormat:@"平方米:%0.3lfm²",[_personalFunctionmodel.totalArea doubleValue]];
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_SL_DB"]){
            //大板调拨
            _showImageView.image = [UIImage imageNamed:@"等待"];
            _statusLabel.text = @"正在调试";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
            // _abnormalLabel.text = [NSString stringWithFormat:@"仓库:%@",_personalFunctionmodel.warehouse];
            _abnormalLabel.text = [NSString stringWithFormat:@"仓库:%@->%@",_personalFunctionmodel.warehouse,_personalFunctionmodel.warehouseIn];
            _numberLabel.text = [NSString stringWithFormat:@"匝数:%ld",(long)_personalFunctionmodel.totalTurns];
            _areaLabel.text = [NSString stringWithFormat:@"平方数:%0.3lfm²",[_personalFunctionmodel.totalArea doubleValue]];
        }
    }else{
        if ([_personalFunctionmodel.billType isEqualToString:@"BILL_BL_CGRK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_BL_JGRK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_BL_PYRK"]) {
            _abnormalLabel.hidden = YES;
            _showImageView.image = [UIImage imageNamed:@"已入库"];
            _statusLabel.text = @"已入库";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
            _numberLabel.text = [NSString stringWithFormat:@"颗数:%ld",(long)_personalFunctionmodel.totalQty];
            _areaLabel.text = [NSString stringWithFormat:@"立方数:%0.3lfm³",[_personalFunctionmodel.totalVolume doubleValue]];
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_BL_XSCK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_BL_JGCK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_BL_PKCK"]){
            _abnormalLabel.hidden = YES;
            _showImageView.image = [UIImage imageNamed:@"已入库"];
            _statusLabel.text = @"已出库";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
            _numberLabel.text = [NSString stringWithFormat:@"颗数:%ld",(long)_personalFunctionmodel.totalQty];
            _areaLabel.text = [NSString stringWithFormat:@"立方数:%0.3lfm³",[_personalFunctionmodel.totalVolume doubleValue]];
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_BL_YCCL"]){
            
            _abnormalLabel.hidden = NO;
            if ([_personalFunctionmodel.abType isEqualToString:@"dlcl"]) {
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:断裂处理"];
            }else if ([_personalFunctionmodel.abType isEqualToString:@"wlbg"])
            {
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:物料变更"];
            }else{
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:尺寸变更"];
            }
            _showImageView.image = [UIImage imageNamed:@"已入库"];
            _statusLabel.text = @"已处理";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
            _numberLabel.text = [NSString stringWithFormat:@"颗数:%ld",(long)_personalFunctionmodel.totalQty];
            _areaLabel.text = [NSString stringWithFormat:@"立方数:%0.3lfm³",[_personalFunctionmodel.totalVolume doubleValue]];
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_BL_DB"]){
            //荒料调拨
            _showImageView.image = [UIImage imageNamed:@"已入库"];
            _statusLabel.text = @"已调试";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
            _abnormalLabel.text = [NSString stringWithFormat:@"仓库:%@->%@",_personalFunctionmodel.warehouse,_personalFunctionmodel.warehouseIn];
            _numberLabel.text = [NSString stringWithFormat:@"颗数:%ld",(long)_personalFunctionmodel.totalQty];
            _areaLabel.text = [NSString stringWithFormat:@"立方数:%0.3lfm³",[_personalFunctionmodel.totalVolume doubleValue]];
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_SL_CGRK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_SL_JGRK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_SL_PYRK"]){
            
            _showImageView.image = [UIImage imageNamed:@"已入库"];
            _statusLabel.text = @"已入库";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
            _numberLabel.text = [NSString stringWithFormat:@"匝数:%ld匝",(long)_personalFunctionmodel.totalTurns];
            _areaLabel.text = [NSString stringWithFormat:@"平方数:%0.3lfm²",[_personalFunctionmodel.totalArea doubleValue]];
            _abnormalLabel.hidden = YES;
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_SL_XSCK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_SL_JGCK"] || [_personalFunctionmodel.billType isEqualToString:@"BILL_SL_PKCK"]){
            
            _showImageView.image = [UIImage imageNamed:@"已入库"];
            _statusLabel.text = @"已出库";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
            _numberLabel.text = [NSString stringWithFormat:@"匝数:%ld匝",(long)_personalFunctionmodel.totalTurns];
            _areaLabel.text = [NSString stringWithFormat:@"平方数:%0.3lfm²",[_personalFunctionmodel.totalArea doubleValue]];
            _abnormalLabel.hidden = YES;
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_SL_YCCL"]){
            _abnormalLabel.hidden = NO;
            if ([_personalFunctionmodel.abType isEqualToString:@"dlcl"]) {
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:断裂处理"];
            }else if ([_personalFunctionmodel.abType isEqualToString:@"wlbg"])
            {
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:物料变更"];
            }else{
                _abnormalLabel.text = [NSString stringWithFormat:@"异常类型:尺寸变更"];
            }
            _showImageView.image = [UIImage imageNamed:@"已入库"];
            _statusLabel.text = @"已处理";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
            _numberLabel.text = [NSString stringWithFormat:@"匝数:%ld",(long)_personalFunctionmodel.totalTurns];
            _areaLabel.text = [NSString stringWithFormat:@"平方米:%0.3lfm²",[_personalFunctionmodel.totalArea doubleValue]];
        }else if ([_personalFunctionmodel.billType isEqualToString:@"BILL_SL_DB"]){
            //大板调拨
            _showImageView.image = [UIImage imageNamed:@"已入库"];
            _statusLabel.text = @"已调拨";
            _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
            // _abnormalLabel.text = [NSString stringWithFormat:@"仓库:%@",_personalFunctionmodel.warehouse];
            _abnormalLabel.text = [NSString stringWithFormat:@"仓库:%@->%@",_personalFunctionmodel.warehouse,_personalFunctionmodel.warehouseIn];
            _numberLabel.text = [NSString stringWithFormat:@"匝数:%ld",(long)_personalFunctionmodel.totalTurns];
            _areaLabel.text = [NSString stringWithFormat:@"平方数:%0.3lfm²",[_personalFunctionmodel.totalArea doubleValue]];
        }
    }
    //单号:
    _showLabel.text = [NSString stringWithFormat:@"%@",_personalFunctionmodel.billNo];
    _timeLabel.text = _personalFunctionmodel.billDate;
    _productLabel.text = [NSString stringWithFormat:@"物料名称:%@",_personalFunctionmodel.mtlNames];
   
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
