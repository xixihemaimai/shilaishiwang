//
//  RSMainStoneCell.m
//  石来石往
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSMainStoneCell.h"

@implementation RSMainStoneCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //次数
        UILabel * mainStoneNumberLabel = [[UILabel alloc]init];
        mainStoneNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
      //  mainStoneNumberLabel.text = @"01";
        mainStoneNumberLabel.textAlignment = NSTextAlignmentLeft;
        mainStoneNumberLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:mainStoneNumberLabel];
        _mainStoneNumberLabel = mainStoneNumberLabel;
        
        //是否收藏的图片
        UIButton * mainStoneCollectionBtn = [[UIButton alloc]init];
        [mainStoneCollectionBtn setImage:[UIImage imageNamed:@"nh-拷贝-2"] forState:UIControlStateNormal];
        [self.contentView addSubview:mainStoneCollectionBtn];
        _mainStoneCollectionBtn = mainStoneCollectionBtn;
        
        
        //间隔view
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:midView];
        
        
        //荒料号
        UILabel * huangliaoLabel = [[UILabel alloc]init];
      //  huangliaoLabel.text = @"荒料号:HXAC019654/SX-15605";
        huangliaoLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        huangliaoLabel.textAlignment = NSTextAlignmentLeft;
        huangliaoLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:huangliaoLabel];
        _huangliaoLabel = huangliaoLabel;
        //规格
        UILabel * ruleLabel = [[UILabel alloc]init];
     //   ruleLabel.text = @"规格:1.2*45*52";
        ruleLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        ruleLabel.textAlignment = NSTextAlignmentLeft;
        ruleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:ruleLabel];
        _ruleLabel = ruleLabel;
        
        //体积
        UILabel * areaLabel = [[UILabel alloc]init];
      //  areaLabel.text = @"体积:12.123m³";
        areaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        areaLabel.textAlignment = NSTextAlignmentLeft;
        areaLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:areaLabel];
        _areaLabel = areaLabel;
        
        
        //重量
        UILabel * weightLabel = [[UILabel alloc]init];
       // weightLabel.text = @"重量:1.11吨";
        weightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        weightLabel.textAlignment = NSTextAlignmentRight;
        weightLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:weightLabel];
        _weightLabel = weightLabel;
        
        //分隔线
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
        [self.contentView addSubview:bottomView];
        
        mainStoneNumberLabel.sd_layout
        .leftSpaceToView(self.contentView, 24)
        .topSpaceToView(self.contentView, 18)
        .heightIs(12)
        .widthIs(40);
        
        mainStoneCollectionBtn.sd_layout
        .leftSpaceToView(self.contentView, 19)
        .topSpaceToView(mainStoneNumberLabel, 1)
        .widthIs(30)
        .heightEqualToWidth();
        
        
        midView.sd_layout
        .topSpaceToView(self.contentView, 22)
        .bottomSpaceToView(self.contentView, 22)
        .widthIs(1)
        .leftSpaceToView(mainStoneCollectionBtn, 9);
        
        
        huangliaoLabel.sd_layout
        .leftSpaceToView(midView, 14)
        .topSpaceToView(self.contentView, 13)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(14);
        
        
        ruleLabel.sd_layout
        .leftEqualToView(huangliaoLabel)
        .rightEqualToView(huangliaoLabel)
        .topSpaceToView(huangliaoLabel, 7)
        .heightIs(14);
        
        
        areaLabel.sd_layout
        .leftEqualToView(ruleLabel)
        .topSpaceToView(ruleLabel, 9)
        .heightIs(14)
        .widthRatioToView(self.contentView, 0.3);
        
        
        weightLabel.sd_layout
        .rightSpaceToView(self.contentView, 17)
        .heightIs(14)
        .topEqualToView(areaLabel)
        .leftSpaceToView(areaLabel, 20);
        
        
        
        bottomView.sd_layout
        .leftSpaceToView(self.contentView, 22)
        .rightSpaceToView(self.contentView, 22)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);

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
