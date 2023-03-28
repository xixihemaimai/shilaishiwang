//
//  RSMachiningCell.m
//  石来石往
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSMachiningCell.h"

@interface RSMachiningCell()
{
    UIImageView * _machiningImageView;
    
    UILabel * _machiningBlockLabel;
    
    UILabel * _machiningStatusLabel;
    
    UILabel * _machiningNameLabel;
    
    UILabel * _machiningLabel;
    
    UILabel * _machiningCurrentLabel;
}


@end


@implementation RSMachiningCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        
        //视图范围
        UIView * machiningView = [[UIView alloc]init];
        machiningView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        [self.contentView addSubview:machiningView];
        
        
        //图片
        UIImageView * machiningImageView = [[UIImageView alloc]init];
        machiningImageView.image = [UIImage imageNamed:@"等待"];
        machiningImageView.contentMode = UIViewContentModeScaleAspectFill;
        machiningImageView.clipsToBounds = YES;
        [machiningView addSubview:machiningImageView];
        _machiningImageView = machiningImageView;
        
        //荒料号
        UILabel * machiningBlockLabel = [[UILabel alloc]init];
        machiningBlockLabel.text = @"ESB00295/DH-539";
        machiningBlockLabel.textAlignment = NSTextAlignmentLeft;
        machiningBlockLabel.font = [UIFont systemFontOfSize:16];
        machiningBlockLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [machiningView addSubview:machiningBlockLabel];
        _machiningBlockLabel = machiningBlockLabel;
        
        
        //状态
        UILabel * machiningStatusLabel = [[UILabel alloc]init];
        machiningStatusLabel.text = @"进行中";
        machiningStatusLabel.textAlignment = NSTextAlignmentLeft;
        machiningStatusLabel.font = [UIFont systemFontOfSize:12];
        machiningStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
        [machiningView addSubview:machiningStatusLabel];
        _machiningStatusLabel = machiningStatusLabel;
        
         //物料名称
        UILabel * machiningNameLabel = [[UILabel alloc]init];
        machiningNameLabel.text = @"物料名称：白玉兰";
        machiningNameLabel.textAlignment = NSTextAlignmentLeft;
        machiningNameLabel.font = [UIFont systemFontOfSize:15];
        machiningNameLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [machiningView addSubview:machiningNameLabel];
        _machiningNameLabel = machiningNameLabel;
        
        //加工厂
        UILabel * machiningLabel = [[UILabel alloc]init];
        machiningLabel.text = @"加 工 厂：某某一号加工厂";
        machiningLabel.textAlignment = NSTextAlignmentLeft;
        machiningLabel.font = [UIFont systemFontOfSize:15];
        machiningLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [machiningView addSubview:machiningLabel];
        _machiningLabel = machiningLabel;
        
        //当前工序
        UILabel * machiningCurrentLabel = [[UILabel alloc]init];
        machiningCurrentLabel.text = @"当前工序：待磨1号机";
        machiningCurrentLabel.textAlignment = NSTextAlignmentLeft;
        machiningCurrentLabel.font = [UIFont systemFontOfSize:15];
        machiningCurrentLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [machiningView addSubview:machiningCurrentLabel];
        _machiningCurrentLabel = machiningCurrentLabel;
        
        machiningView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 13)
        .bottomSpaceToView(self.contentView, 0);
        
        machiningView.layer.cornerRadius = 6;
        
        
        
        machiningImageView.sd_layout
        .leftSpaceToView(machiningView, 15)
        .topSpaceToView(machiningView, 16)
        .widthIs(32)
        .heightEqualToWidth();
        
        
        machiningBlockLabel.sd_layout
        .leftSpaceToView(machiningImageView, 9)
        .topSpaceToView(machiningView, 12)
        .widthRatioToView(machiningView, 0.5)
        .heightIs(23);
        
        
        machiningStatusLabel.sd_layout
        .rightSpaceToView(machiningView, 0)
        .topSpaceToView(machiningView, 16)
        .heightIs(17)
        .widthIs(50);
        
        
        machiningNameLabel.sd_layout
        .leftEqualToView(machiningBlockLabel)
        .rightEqualToView(machiningBlockLabel)
        .topSpaceToView(machiningBlockLabel, 3)
        .heightIs(21);
        
        
        machiningLabel.sd_layout
        .leftEqualToView(machiningNameLabel)
        .rightEqualToView(machiningNameLabel)
        .topSpaceToView(machiningNameLabel, 3)
        .heightIs(21);
        
        machiningCurrentLabel.sd_layout
        .leftEqualToView(machiningLabel)
        .rightEqualToView(machiningLabel)
        .topSpaceToView(machiningLabel, 3)
        .heightIs(21);
    }
    return self;
}


- (void)setMachiningoutmodel:(RSMachiningOutModel *)machiningoutmodel{
    _machiningoutmodel = machiningoutmodel;
    
    if (machiningoutmodel.processStatus == 10) {
        _machiningImageView.image = [UIImage imageNamed:@"已入库"];
        _machiningStatusLabel.text = @"已完成";
        _machiningStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
        _machiningCurrentLabel.hidden = YES;
        
        
    }else{
        
        _machiningImageView.image = [UIImage imageNamed:@"等待"];
        _machiningStatusLabel.text = @"进行中";
        _machiningStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
        _machiningCurrentLabel.text = [NSString stringWithFormat:@"当前工序：%@",_machiningoutmodel.processName];
        _machiningCurrentLabel.hidden = NO;
       
        
    }
    
    _machiningBlockLabel.text = _machiningoutmodel.blockNo;
    _machiningNameLabel.text = [NSString stringWithFormat:@"物料名称：%@",_machiningoutmodel.mtlName];
    _machiningLabel.text = [NSString stringWithFormat:@"加 工 厂：%@",_machiningoutmodel.factoryName];
    
    
    
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
