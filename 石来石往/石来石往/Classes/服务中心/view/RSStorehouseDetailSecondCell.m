//
//  RSStorehouseDetailSecondCell.m
//  石来石往
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSStorehouseDetailSecondCell.h"

@implementation RSStorehouseDetailSecondCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //出货单
        UILabel * outNameLabel = [[UILabel alloc]init];
       // outNameLabel.text = @"海西石材交易中心";
        outNameLabel.font = [UIFont systemFontOfSize:15];
        outNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        outNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:outNameLabel];
        _outNameLabel = outNameLabel;
        
        //颗数
        UILabel * outNumber = [[UILabel alloc]init];
       // outNumber.text = @"海西石材交易中心";
        outNumber.font = [UIFont systemFontOfSize:15];
        outNumber.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        outNumber.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:outNumber];
        _outNumber = outNumber;
        //预约时间
        UILabel * outTimeLabel = [[UILabel alloc]init];
       // outTimeLabel.text = @"海西石材交易中心";
        outTimeLabel.font = [UIFont systemFontOfSize:15];
        outTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        outTimeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:outTimeLabel];
        _outTimeLabel = outTimeLabel;
        
        /**汽车类型*/
        UILabel * carTypeLabel = [[UILabel alloc]init];
        carTypeLabel.font = [UIFont systemFontOfSize:15];
        carTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        carTypeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:carTypeLabel];
        _carTypeLabel = carTypeLabel;
        
        outNameLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 5)
        .heightIs(15);
        
        outNumber.sd_layout
        .leftEqualToView(outNameLabel)
        .rightEqualToView(outNameLabel)
        .topSpaceToView(outNameLabel, 10)
        .heightIs(15);
        
        
        outTimeLabel.sd_layout
        .leftEqualToView(outNumber)
        .rightEqualToView(outNumber)
        .topSpaceToView(outNumber, 10)
        .heightIs(15);
        
        
        carTypeLabel.sd_layout
        .leftEqualToView(outTimeLabel)
        .rightEqualToView(outTimeLabel)
        .topSpaceToView(outTimeLabel, 13)
        .bottomSpaceToView(self.contentView, 10);
        
    }
    return self;
    
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
