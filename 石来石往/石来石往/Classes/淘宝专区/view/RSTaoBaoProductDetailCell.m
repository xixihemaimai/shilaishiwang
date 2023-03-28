//
//  RSTaoBaoProductDetailCell.m
//  石来石往
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoProductDetailCell.h"


@interface RSTaoBaoProductDetailCell()



@property (nonatomic,strong)UILabel * blockNoLabel;

@property (nonatomic,strong)UILabel * typeDetailLabel;


@property (nonatomic,strong)UILabel * widthDetialLabel;
@property (nonatomic,strong)UILabel * volumeDetialLabel;
@property (nonatomic,strong)UILabel * longDetialLabel;
@property (nonatomic,strong)UILabel * heightDetialLabel;
@property (nonatomic,strong)UILabel * weightDetialLabel;
@property (nonatomic,strong)UILabel * locationDetialLabel;

@end



@implementation RSTaoBaoProductDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
      //荒料号
        UILabel * blockNoLabel = [[UILabel alloc]init];
        blockNoLabel.text = @"ESB00295/DH-539";
        blockNoLabel.userInteractionEnabled = YES;
        blockNoLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        blockNoLabel.textAlignment = NSTextAlignmentCenter;
        blockNoLabel.font = [UIFont systemFontOfSize:15];
        blockNoLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:blockNoLabel];
        _blockNoLabel = blockNoLabel;
        
        
        UIView * detailView = [[UIView alloc]init];
        detailView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:detailView];
        
        //物料类型
        UILabel * typeLabel = [[UILabel alloc]init];
        typeLabel.text = @"物料类型";
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        typeLabel.font = [UIFont systemFontOfSize:14];
        typeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:typeLabel];
    
        //物料类型的信息
        UILabel * typeDetailLabel = [[UILabel alloc]init];
        typeDetailLabel.text = @"大理石";
        typeDetailLabel.textAlignment = NSTextAlignmentCenter;
        typeDetailLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        typeDetailLabel.font = [UIFont systemFontOfSize:15];
        typeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:typeDetailLabel];
        _typeDetailLabel = typeDetailLabel;
        //宽
        UILabel * widthLabel = [[UILabel alloc]init];
        widthLabel.text = @"宽(cm)";
        widthLabel.textAlignment = NSTextAlignmentCenter;
        widthLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        widthLabel.font = [UIFont systemFontOfSize:14];
        widthLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:widthLabel];
        
       
        UILabel * widthDetialLabel = [[UILabel alloc]init];
        widthDetialLabel.text = @"0.234";
        widthDetialLabel.textAlignment = NSTextAlignmentCenter;
        widthDetialLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        widthDetialLabel.font = [UIFont systemFontOfSize:14];
        widthDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:widthDetialLabel];
        _widthDetialLabel = widthDetialLabel;
        
        
        //体积
        UILabel * volumeLabel = [[UILabel alloc]init];
        volumeLabel.text = @"体积(m³)";
        volumeLabel.textAlignment = NSTextAlignmentCenter;
        volumeLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        volumeLabel.font = [UIFont systemFontOfSize:14];
        volumeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:volumeLabel];
        
        
        UILabel * volumeDetialLabel = [[UILabel alloc]init];
        volumeDetialLabel.text = @"234";
        volumeDetialLabel.textAlignment = NSTextAlignmentCenter;
        volumeDetialLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        volumeDetialLabel.font = [UIFont systemFontOfSize:14];
        volumeDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:volumeDetialLabel];
        _volumeDetialLabel = volumeDetialLabel;
        
        //长
        UILabel * longLabel = [[UILabel alloc]init];
        longLabel.text = @"长(cm)";
        longLabel.textAlignment = NSTextAlignmentCenter;
        longLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        longLabel.font = [UIFont systemFontOfSize:14];
        longLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:longLabel];
        
        
        UILabel * longDetialLabel = [[UILabel alloc]init];
        longDetialLabel.text = @"1.233";
        longDetialLabel.textAlignment = NSTextAlignmentCenter;
        longDetialLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        longDetialLabel.font = [UIFont systemFontOfSize:14];
        longDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:longDetialLabel];
        _longDetialLabel = longDetialLabel;
        
        //高
        UILabel * heightLabel = [[UILabel alloc]init];
        heightLabel.text = @"高(cm)";
        heightLabel.textAlignment = NSTextAlignmentCenter;
        heightLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        heightLabel.font = [UIFont systemFontOfSize:14];
        heightLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:heightLabel];
        
        
        UILabel * heightDetialLabel = [[UILabel alloc]init];
        heightDetialLabel.text = @"2.888";
        heightDetialLabel.textAlignment = NSTextAlignmentCenter;
        heightDetialLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        heightDetialLabel.font = [UIFont systemFontOfSize:14];
        heightDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:heightDetialLabel];
        _heightDetialLabel = heightDetialLabel;
        
        
        //重量
        UILabel * weightLabel = [[UILabel alloc]init];
        weightLabel.text = @"重量(吨)";
        weightLabel.textAlignment = NSTextAlignmentCenter;
        weightLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        weightLabel.font = [UIFont systemFontOfSize:14];
        weightLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:weightLabel];
        
        
        UILabel * weightDetialLabel = [[UILabel alloc]init];
        weightDetialLabel.text = @"5.445";
        weightDetialLabel.textAlignment = NSTextAlignmentCenter;
        weightDetialLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        weightDetialLabel.font = [UIFont systemFontOfSize:14];
        weightDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:weightDetialLabel];
        _weightDetialLabel = weightDetialLabel;
        
        //存储位置
        UILabel * locationLabel = [[UILabel alloc]init];
        locationLabel.text = @"存储位置";
        locationLabel.textAlignment = NSTextAlignmentCenter;
        locationLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        locationLabel.font = [UIFont systemFontOfSize:14];
        locationLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:locationLabel];
        
        
        UILabel * locationDetialLabel = [[UILabel alloc]init];
        locationDetialLabel.text = @"某某市场一号仓库";
        locationDetialLabel.textAlignment = NSTextAlignmentCenter;
        locationDetialLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        locationDetialLabel.font = [UIFont systemFontOfSize:15];
        locationDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:locationDetialLabel];
        _locationDetialLabel = locationDetialLabel;
        
        
        
        
        blockNoLabel.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(34);
        
        
        detailView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(blockNoLabel, 1)
        .bottomSpaceToView(self.contentView, 0);
        
        
        typeLabel.sd_layout
        .leftSpaceToView(detailView, 0)
        .topSpaceToView(detailView, 0)
        .widthIs(82)
        .heightIs(34);
        
        typeLabel.layer.borderWidth = 1;
        typeLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        typeDetailLabel.sd_layout
        .topSpaceToView(detailView, 1)
        .leftSpaceToView(typeLabel, 0)
        .heightIs(32)
        .widthIs(SCW/2 - 12 - 82);
        
        typeDetailLabel.layer.borderWidth = 1;
        typeDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        

        widthLabel.sd_layout
        .leftEqualToView(typeLabel)
        .topSpaceToView(typeLabel,0)
        .rightEqualToView(typeLabel)
        .heightIs(34);
        
        
        widthLabel.layer.borderWidth = 1;
        widthLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        widthDetialLabel.sd_layout
        .leftSpaceToView(widthLabel, 0)
        .topSpaceToView(typeDetailLabel, 2)
        .heightIs(32)
        .rightEqualToView(typeDetailLabel);
        
        
        widthDetialLabel.layer.borderWidth = 1;
        widthDetialLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;

        
        volumeLabel.sd_layout
        .leftEqualToView(widthLabel)
        .rightEqualToView(widthLabel)
        .topSpaceToView(widthLabel,0)
        .heightIs(34);
        
        volumeLabel.layer.borderWidth = 1;
        volumeLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        volumeDetialLabel.sd_layout
        .leftSpaceToView(volumeLabel, 0)
        .topSpaceToView(widthDetialLabel, 2)
        .heightIs(32)
        .rightEqualToView(widthDetialLabel);
        
        
        volumeDetialLabel.layer.borderWidth = 1;
        volumeDetialLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;


        longLabel.sd_layout
        .leftSpaceToView(typeDetailLabel, 0)
        .topSpaceToView(detailView, 0)
        .heightIs(34)
        .widthIs(82);
        
        
        longLabel.layer.borderWidth = 1;
        longLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        longDetialLabel.sd_layout
        .leftSpaceToView(longLabel, 0)
        .topSpaceToView(detailView, 1)
        .heightIs(32)
        .rightSpaceToView(detailView, 0);
        
        longDetialLabel.layer.borderWidth = 1;
        longDetialLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;

        
        heightLabel.sd_layout
        .leftSpaceToView(widthDetialLabel, 0)
        .rightEqualToView(longLabel)
        .topSpaceToView(longLabel, 0)
        .heightIs(34);
        
        
        heightLabel.layer.borderWidth = 1;
        heightLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        heightDetialLabel.sd_layout
        .leftSpaceToView(heightLabel, 0)
        .topSpaceToView(longDetialLabel,2)
        .heightIs(32)
        .rightSpaceToView(detailView, 0);
        
        heightDetialLabel.layer.borderWidth = 1;
        heightDetialLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        weightLabel.sd_layout
        .leftSpaceToView(volumeDetialLabel, 0)
        .rightEqualToView(heightLabel)
        .topSpaceToView(heightLabel, 0)
        .heightIs(34);
        
        weightLabel.layer.borderWidth = 1;
        weightLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        weightDetialLabel.sd_layout
        .leftSpaceToView(weightLabel, 0)
        .topSpaceToView(heightDetialLabel, 2)
        .heightIs(32)
        .rightSpaceToView(detailView, 0);
        
        weightDetialLabel.layer.borderWidth = 1;
        weightDetialLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        
        locationLabel.sd_layout
        .leftSpaceToView(detailView, 0)
        .topSpaceToView(volumeLabel, 0)
        .widthIs(82)
        .heightIs(34);
        
        
        locationLabel.layer.borderWidth = 1;
        locationLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        locationDetialLabel.sd_layout
        .leftSpaceToView(locationLabel, 0)
        .topSpaceToView(volumeDetialLabel, 2)
        .heightIs(32)
        .rightSpaceToView(detailView, 0);
        
        locationDetialLabel.layer.borderWidth = 1;
        locationDetialLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
    }
    return self;
}


- (void)setTaobaoStoneDtlmodel:(RSTaobaoStoneDtlModel *)taobaoStoneDtlmodel{
    _taobaoStoneDtlmodel = taobaoStoneDtlmodel;
    _blockNoLabel.text = [NSString stringWithFormat:@"%@",_taobaoStoneDtlmodel.blockNo];
    _typeDetailLabel.text = [NSString stringWithFormat:@"%@",_taobaoStoneDtlmodel.stoneType];
    _longDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[_taobaoStoneDtlmodel.length floatValue]];
    _widthDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[_taobaoStoneDtlmodel.width floatValue] ];
    _heightDetialLabel.text = [NSString stringWithFormat:@"%0.2lf",[_taobaoStoneDtlmodel.height floatValue]];
    _volumeDetialLabel.text = [NSString stringWithFormat:@"%0.3lf",[_taobaoStoneDtlmodel.volume floatValue]];
    _weightDetialLabel.text = [NSString stringWithFormat:@"%0.3lf",[_taobaoStoneDtlmodel.weight floatValue]];
    _locationDetialLabel.text = [NSString stringWithFormat:@"%@",_taobaoStoneDtlmodel.warehouseName];
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
