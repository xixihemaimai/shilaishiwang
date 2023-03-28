//
//  RSRawMaterialCell.m
//  石来石往
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSRawMaterialCell.h"

@implementation RSRawMaterialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#E6E6E6"];
        
        UIView * selectiveInventoryView = [[UIView alloc]init];
        selectiveInventoryView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:selectiveInventoryView];
        
        
        //物料号
        UILabel * selectiveLabel = [[UILabel alloc]init];
        //selectiveLabel.text = @"ESB00295/DH-539";
        selectiveLabel.font = [UIFont systemFontOfSize:15];
        selectiveLabel.textAlignment = NSTextAlignmentLeft;
        selectiveLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [selectiveInventoryView addSubview:selectiveLabel];
        _selectiveLabel = selectiveLabel;
        
        //选择
        UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectBtn setImage:[UIImage imageNamed:@"Oval 9"] forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"个人选中"] forState:UIControlStateSelected];
        [selectiveInventoryView addSubview:selectBtn];
        _selectBtn = selectBtn;
        //        [selectBtn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        
//        UILabel * isfrozenLabel = [[UILabel alloc]init];
//        isfrozenLabel.textColor = [UIColor redColor];
//        isfrozenLabel.text = @"已冻结";
//        isfrozenLabel.font = [UIFont systemFontOfSize:14];
//        isfrozenLabel.textAlignment = NSTextAlignmentRight;
//        [selectiveInventoryView addSubview:isfrozenLabel];
       // _isfrozenLabel = isfrozenLabel;
        
        
        
        //分割线
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [selectiveInventoryView addSubview:midView];
        
        
        //图片显示
        //        UIImageView * selectiveImageView = [[UIImageView alloc]init];
        //        selectiveImageView.contentMode = UIViewContentModeScaleAspectFill;
        //        selectiveImageView.clipsToBounds = YES;
        //        selectiveImageView.image = [UIImage imageNamed:@"512"];
        //        [selectiveInventoryView addSubview:selectiveImageView];
        
        //物料名称
        UILabel * selectNameLabel = [[UILabel alloc]init];
        selectNameLabel.text = @"物料名称:";
        selectNameLabel.font = [UIFont systemFontOfSize:15];
        selectNameLabel.textAlignment = NSTextAlignmentLeft;
        selectNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [selectiveInventoryView addSubview:selectNameLabel];
        
        
        UILabel * selectDetailNameLabel = [[UILabel alloc]init];
        selectDetailNameLabel.text = @"白玉兰";
        selectDetailNameLabel.font = [UIFont systemFontOfSize:15];
        selectDetailNameLabel.textAlignment = NSTextAlignmentRight;
        selectDetailNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [selectiveInventoryView addSubview:selectDetailNameLabel];
        _selectDetailNameLabel = selectDetailNameLabel;
        //物料类型
        UILabel * selectTypeLabel = [[UILabel alloc]init];
        selectTypeLabel.text = @"物料类型:";
        selectTypeLabel.font = [UIFont systemFontOfSize:15];
        selectTypeLabel.textAlignment = NSTextAlignmentLeft;
        selectTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [selectiveInventoryView addSubview:selectTypeLabel];
        
        
        UILabel * selectDetailTypeLabel = [[UILabel alloc]init];
        selectDetailTypeLabel.text = @"大理石";
        selectDetailTypeLabel.font = [UIFont systemFontOfSize:15];
        selectDetailTypeLabel.textAlignment = NSTextAlignmentRight;
        selectDetailTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [selectiveInventoryView addSubview:selectDetailTypeLabel];
        _selectDetailTypeLabel = selectDetailTypeLabel;
        
        //长宽高
        UILabel * shapeLabel = [[UILabel alloc]init];
        shapeLabel.text = @"长宽高(cm):";
        shapeLabel.font = [UIFont systemFontOfSize:15];
        shapeLabel.textAlignment = NSTextAlignmentLeft;
        shapeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [selectiveInventoryView addSubview:shapeLabel];
        
        
        UILabel * selectDetailShapeLabel = [[UILabel alloc]init];
        selectDetailShapeLabel.text = @"0.1 | 3.3 | 2.8";
        selectDetailShapeLabel.font = [UIFont systemFontOfSize:15];
        selectDetailShapeLabel.textAlignment = NSTextAlignmentRight;
        selectDetailShapeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [selectiveInventoryView addSubview:selectDetailShapeLabel];
        _selectDetailShapeLabel = selectDetailShapeLabel;
        
        //体积
        UILabel * areaLabel = [[UILabel alloc]init];
        areaLabel.text = @"体积(m³):";
        areaLabel.font = [UIFont systemFontOfSize:15];
        areaLabel.textAlignment = NSTextAlignmentLeft;
        areaLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [selectiveInventoryView addSubview:areaLabel];
        
        
        UILabel * selectDetailAreaLabel = [[UILabel alloc]init];
        selectDetailAreaLabel.text = @"5.883";
        selectDetailAreaLabel.font = [UIFont systemFontOfSize:15];
        selectDetailAreaLabel.textAlignment = NSTextAlignmentRight;
        selectDetailAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [selectiveInventoryView addSubview:selectDetailAreaLabel];
        _selectDetailAreaLabel = selectDetailAreaLabel;
        
        //重量
        UILabel * wightLabel = [[UILabel alloc]init];
        wightLabel.text = @"重量(吨):";
        wightLabel.font = [UIFont systemFontOfSize:15];
        wightLabel.textAlignment = NSTextAlignmentLeft;
        wightLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [selectiveInventoryView addSubview:wightLabel];
        
        
        UILabel * selectDetailWightLabel = [[UILabel alloc]init];
        selectDetailWightLabel.text = @"5.445";
        selectDetailWightLabel.font = [UIFont systemFontOfSize:15];
        selectDetailWightLabel.textAlignment = NSTextAlignmentRight;
        selectDetailWightLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [selectiveInventoryView addSubview:selectDetailWightLabel];
        _selectDetailWightLabel = selectDetailWightLabel;
        
        
        //入库日期还是出库日期
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"入库时间:";
        timeLabel.font = [UIFont systemFontOfSize:15];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [selectiveInventoryView addSubview:timeLabel];
        _timeLabel = timeLabel;
        
        UILabel * timeDetialLabel = [[UILabel alloc]init];
        timeDetialLabel.text = @"2019-4-29";
        timeDetialLabel.font = [UIFont systemFontOfSize:15];
        timeDetialLabel.textAlignment = NSTextAlignmentRight;
        timeDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [selectiveInventoryView addSubview:timeDetialLabel];
        _timeDetialLabel = timeDetialLabel;
        
        
        //入库类型还是出库类型
        
        UILabel * typeLabel = [[UILabel alloc]init];
        typeLabel.text = @"入库类型:";
        typeLabel.font = [UIFont systemFontOfSize:15];
        typeLabel.textAlignment = NSTextAlignmentLeft;
        typeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [selectiveInventoryView addSubview:typeLabel];
        _typeLabel = typeLabel;
        
        UILabel * typeDetialLabel = [[UILabel alloc]init];
        typeDetialLabel.text = @"采购入库";
        typeDetialLabel.font = [UIFont systemFontOfSize:15];
        typeDetialLabel.textAlignment = NSTextAlignmentRight;
        typeDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [selectiveInventoryView addSubview:typeDetialLabel];
        
        _typeDetialLabel = typeDetialLabel;
        
        //入库仓库还是出库仓库
        UILabel * wareHouseLabel = [[UILabel alloc]init];
        wareHouseLabel.text = @"入库仓库:";
        wareHouseLabel.font = [UIFont systemFontOfSize:15];
        wareHouseLabel.textAlignment = NSTextAlignmentLeft;
        wareHouseLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [selectiveInventoryView addSubview:wareHouseLabel];
        _wareHouseLabel = wareHouseLabel;
        
        UILabel * wareHouseDetialLabel = [[UILabel alloc]init];
        wareHouseDetialLabel.text = @"一号仓库";
        wareHouseDetialLabel.font = [UIFont systemFontOfSize:15];
        wareHouseDetialLabel.textAlignment = NSTextAlignmentRight;
        wareHouseDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [selectiveInventoryView addSubview:wareHouseDetialLabel];
        _wareHouseDetialLabel = wareHouseDetialLabel;
        
        
        
        selectiveInventoryView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0);
        
        selectiveInventoryView.layer.cornerRadius = 3;
        
        selectiveLabel.sd_layout
        .leftSpaceToView(selectiveInventoryView, 18)
        .topSpaceToView(selectiveInventoryView, 10)
        .rightSpaceToView(selectiveInventoryView, 0.4)
        .heightIs(21);
        
        
        selectBtn.sd_layout
        .rightSpaceToView(selectiveInventoryView, 14)
        .topSpaceToView(selectiveInventoryView, 12)
        .widthIs(20)
        .heightEqualToWidth();
        
        
//
//        isfrozenLabel.sd_layout
//        .rightSpaceToView(selectBtn, 0)
//        .topSpaceToView(selectiveInventoryView, 10)
//        .heightIs(21)
//        .widthIs(50);
//
        
        
        midView.sd_layout
        .leftSpaceToView(selectiveInventoryView, 0)
        .rightSpaceToView(selectiveInventoryView, 0)
        .heightIs(1)
        .topSpaceToView(selectiveInventoryView, 41);
        
        
        //        selectiveImageView.sd_layout
        //        .leftSpaceToView(selectiveInventoryView, 18)
        //        .topSpaceToView(midView, 18)
        //        .widthIs(92)
        //        .heightEqualToWidth();
        //
        //        selectiveImageView.layer.cornerRadius = 3;
        
        
        selectNameLabel.sd_layout
        .leftSpaceToView(selectiveInventoryView, 18)
        .topSpaceToView(midView, 13)
        .widthIs(94)
        .heightIs(21);
        
        
        selectDetailNameLabel.sd_layout
        .leftSpaceToView(selectNameLabel, 10)
        .rightSpaceToView(selectiveInventoryView, 12)
        .topEqualToView(selectNameLabel)
        .bottomEqualToView(selectNameLabel);
        
        
        
        selectTypeLabel.sd_layout
        .topSpaceToView(selectNameLabel, 3)
        .leftEqualToView(selectNameLabel)
        .widthIs(94)
        .heightIs(21);
        
        
        
        
        
        selectDetailTypeLabel.sd_layout
        .leftSpaceToView(selectTypeLabel, 10)
        .rightSpaceToView(selectiveInventoryView, 12)
        .topEqualToView(selectTypeLabel)
        .bottomEqualToView(selectTypeLabel);
        
        
        shapeLabel.sd_layout
        .topSpaceToView(selectTypeLabel, 3)
        .leftEqualToView(selectTypeLabel)
        .widthIs(94)
        .heightIs(21);
        
        
        selectDetailShapeLabel.sd_layout
        .leftSpaceToView(shapeLabel, 10)
        .rightSpaceToView(selectiveInventoryView, 12)
        .topEqualToView(shapeLabel)
        .bottomEqualToView(shapeLabel);
        
        
        areaLabel.sd_layout
        .topSpaceToView(shapeLabel, 3)
        .leftEqualToView(shapeLabel)
        .widthIs(94)
        .heightIs(21);
        
        selectDetailAreaLabel.sd_layout
        .leftSpaceToView(areaLabel, 10)
        .rightSpaceToView(selectiveInventoryView, 12)
        .topEqualToView(areaLabel)
        .bottomEqualToView(areaLabel);
        
        
        wightLabel.sd_layout
        .topSpaceToView(areaLabel, 3)
        .leftEqualToView(areaLabel)
        .widthIs(94)
        .heightIs(21);
        
        
        
        selectDetailWightLabel.sd_layout
        .leftSpaceToView(wightLabel, 10)
        .rightSpaceToView(selectiveInventoryView, 12)
        .topEqualToView(wightLabel)
        .bottomEqualToView(wightLabel);
        
        timeLabel.sd_layout
        .topSpaceToView(wightLabel, 3)
        .leftEqualToView(wightLabel)
        .widthIs(94)
        .heightIs(21);
        
        timeDetialLabel.sd_layout
        .leftSpaceToView(timeLabel, 10)
        .rightSpaceToView(selectiveInventoryView, 12)
        .topEqualToView(timeLabel)
        .bottomEqualToView(timeLabel);
        
        
        typeLabel.sd_layout
        .topSpaceToView(timeLabel, 3)
        .leftEqualToView(timeLabel)
        .widthIs(94)
        .heightIs(21);
        
        typeDetialLabel.sd_layout
        .leftSpaceToView(typeLabel, 10)
        .rightSpaceToView(selectiveInventoryView, 12)
        .topEqualToView(typeLabel)
        .bottomEqualToView(typeLabel);
        
        wareHouseLabel.sd_layout
        .topSpaceToView(typeLabel, 3)
        .leftEqualToView(typeLabel)
        .widthIs(94)
        .heightIs(21);
        
        wareHouseDetialLabel.sd_layout
        .leftSpaceToView(wareHouseLabel, 10)
        .rightSpaceToView(selectiveInventoryView, 12)
        .topEqualToView(wareHouseLabel)
        .bottomEqualToView(wareHouseLabel);
        
        
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
