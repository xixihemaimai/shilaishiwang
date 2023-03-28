//
//  RSTaoBaoProductDetailSLCell.m
//  石来石往
//
//  Created by mac on 2019/8/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoProductDetailSLCell.h"

@implementation RSTaoBaoProductDetailSLCell



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
        
        
        RSAllMessageUIButton * checkBtn = [RSAllMessageUIButton buttonWithType:UIButtonTypeCustom];
        [checkBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        checkBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [checkBtn setImage:[UIImage imageNamed:@"下一页-(1)-拷贝-4"] forState:UIControlStateNormal];
        [checkBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
        [checkBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FF4B33"]];
        [blockNoLabel addSubview:checkBtn];
        _checkBtn = checkBtn;
        
        
        UIView * detailView = [[UIView alloc]init];
        detailView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:detailView];
        
        
        
        // 物料类型
        UILabel * typeLabel = [[UILabel alloc]init];
        typeLabel.text = @"物料类型";
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        typeLabel.font = [UIFont systemFontOfSize:14];
        typeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:typeLabel];
        
        
        UILabel * typeDetailLabel = [[UILabel alloc]init];
        typeDetailLabel.text = @"大理石";
        typeDetailLabel.textAlignment = NSTextAlignmentCenter;
        typeDetailLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        typeDetailLabel.font = [UIFont systemFontOfSize:15];
        typeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:typeDetailLabel];
        _typeDetailLabel = typeDetailLabel;
        
        //总匝数
        UILabel * numberLabel = [[UILabel alloc]init];
        numberLabel.text = @"总匝数";
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        numberLabel.font = [UIFont systemFontOfSize:14];
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:numberLabel];
        
        
        UILabel * numberDetailLabel = [[UILabel alloc]init];
        numberDetailLabel.text = @"5";
        numberDetailLabel.textAlignment = NSTextAlignmentCenter;
        numberDetailLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        numberDetailLabel.font = [UIFont systemFontOfSize:15];
        numberDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:numberDetailLabel];
        _numberDetailLabel = numberDetailLabel;
        
        
        
        //面积
        
        UILabel * areaLabel = [[UILabel alloc]init];
        areaLabel.text = @"面积(m²)";
        areaLabel.textAlignment = NSTextAlignmentCenter;
        areaLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        areaLabel.font = [UIFont systemFontOfSize:14];
        areaLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:areaLabel];
        
        
        UILabel * areaDetailLabel = [[UILabel alloc]init];
        areaDetailLabel.text = @"5";
        areaDetailLabel.textAlignment = NSTextAlignmentCenter;
        areaDetailLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        areaDetailLabel.font = [UIFont systemFontOfSize:15];
        areaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:areaDetailLabel];
        _areaDetailLabel = areaDetailLabel;
        
        
        //存储位置
        
        UILabel * addressLabel = [[UILabel alloc]init];
        addressLabel.text = @"存储位置";
        addressLabel.textAlignment = NSTextAlignmentCenter;
        addressLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        addressLabel.font = [UIFont systemFontOfSize:14];
        addressLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:addressLabel];
        
        
        UILabel * addressDetailLabel = [[UILabel alloc]init];
        addressDetailLabel.text = @"某某市场一号仓库";
        addressDetailLabel.textAlignment = NSTextAlignmentCenter;
        addressDetailLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        addressDetailLabel.font = [UIFont systemFontOfSize:15];
        addressDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [detailView addSubview:addressDetailLabel];
        _addressDetailLabel = addressDetailLabel;
        
        
        blockNoLabel.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(34);
        
        checkBtn.sd_layout
        .rightSpaceToView(blockNoLabel, 8)
        .topSpaceToView(blockNoLabel, 8)
        .bottomSpaceToView(blockNoLabel, 6)
        .widthIs(61);
        checkBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        checkBtn.layer.cornerRadius = 4;
        
        checkBtn.imageView.sd_layout
        .leftSpaceToView(checkBtn.titleLabel,3)
        .centerYEqualToView(checkBtn)
        .heightIs(8)
        .widthIs(4);
        
        
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
        .leftSpaceToView(typeLabel, -1)
        .heightIs(32)
        .rightSpaceToView(detailView, 0);
        
        typeDetailLabel.layer.borderWidth = 1;
        typeDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        
        numberLabel.sd_layout
        .leftEqualToView(typeLabel)
        .topSpaceToView(typeLabel,0)
        .rightEqualToView(typeLabel)
        .heightIs(34);
        numberLabel.layer.borderWidth = 1;
        numberLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        numberDetailLabel.sd_layout
        .leftSpaceToView(numberLabel, -1)
        .topSpaceToView(typeDetailLabel, 2)
        .heightIs(32)
        .rightEqualToView(typeDetailLabel);
        
        
        numberDetailLabel.layer.borderWidth = 1;
        numberDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;

        
        
        areaLabel.sd_layout
        .leftEqualToView(numberLabel)
        .topSpaceToView(numberLabel,0)
        .rightEqualToView(numberLabel)
        .heightIs(34);
        areaLabel.layer.borderWidth = 1;
        areaLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        areaDetailLabel.sd_layout
        .leftSpaceToView(areaLabel, -1)
        .topSpaceToView(numberDetailLabel, 2)
        .heightIs(32)
        .rightEqualToView(numberDetailLabel);
        
        
        areaDetailLabel.layer.borderWidth = 1;
        areaDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        
        addressLabel.sd_layout
        .leftEqualToView(areaLabel)
        .topSpaceToView(areaLabel,0)
        .rightEqualToView(areaLabel)
        .heightIs(34);
        addressLabel.layer.borderWidth = 1;
        addressLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
        
        
        addressDetailLabel.sd_layout
        .leftSpaceToView(addressLabel, -1)
        .topSpaceToView(areaDetailLabel, 2)
        .heightIs(32)
        .rightEqualToView(areaDetailLabel);
        
        
        addressDetailLabel.layer.borderWidth = 1;
        addressDetailLabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#f2f2f2"].CGColor;
        
        
        
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
