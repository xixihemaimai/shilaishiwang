//
//  RSRecordSecondCell.m
//  石来石往
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSRecordSecondCell.h"

@implementation RSRecordSecondCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        
        UIButton * paiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        paiBtn.enabled = NO;
        [paiBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0  ] forState:UIControlStateNormal];
        _paiBtn = paiBtn;
        [paiBtn setBackgroundColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]];
        
        
        [self.contentView addSubview:paiBtn];
        
        //荒料号
        UILabel * huangliaoLabel = [[UILabel alloc]init];
        huangliaoLabel.text = @"荒料号:";
        huangliaoLabel.font = [UIFont systemFontOfSize:14];
        huangliaoLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:huangliaoLabel];
        
        
        UILabel * detailHuangliaoLabel = [[UILabel alloc]init];
        detailHuangliaoLabel.font = [UIFont systemFontOfSize:14];
        detailHuangliaoLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:detailHuangliaoLabel];
        _detailHuangliaoLabel = detailHuangliaoLabel;
        
        
        
        
        //名称
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text = @"名   称:";
        [self.contentView addSubview:nameLabel];
        
        
        
        
        UILabel * detailNameLabel = [[UILabel alloc]init];
        detailNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        detailNameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:detailNameLabel];
        _detailNameLabel = detailNameLabel;
        
        
        //匝数
        UILabel * zaLabel = [[UILabel alloc]init];
        zaLabel.text = @"片   数:";
        zaLabel.font = [UIFont systemFontOfSize:14];
        zaLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:zaLabel];
        
        
        
        UILabel * detailZaLabel = [[UILabel alloc]init];
        detailZaLabel.font = [UIFont systemFontOfSize:14];
        detailZaLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:detailZaLabel];
        
        _detailZaLabel = detailZaLabel;
        
        
        
        
        
        
        
        //体积
        UILabel * arenLabel = [[UILabel alloc]init];
        arenLabel.text = @"面   积:";
        arenLabel.font = [UIFont systemFontOfSize:14];
        arenLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:arenLabel];
        
        
        UILabel * detailAreaLabel = [[UILabel alloc]init];
        detailAreaLabel.font = [UIFont systemFontOfSize:14];
        detailAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:detailAreaLabel];
        _detailAreaLabel = detailAreaLabel;
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eeeeee"];
        [self.contentView addSubview:bottomview];
        
        
        
        //储位号
        UILabel * locationLabel = [[UILabel alloc]init];
        locationLabel.text = @"储   位:";
        locationLabel.font = [UIFont systemFontOfSize:14];
        locationLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:locationLabel];
        
        
        
        //储位号的数据
        UILabel * locationDetailLabel = [[UILabel alloc]init];
        locationDetailLabel.font = [UIFont systemFontOfSize:14];
        locationDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:locationDetailLabel];
        _locationDetailLabel = locationDetailLabel;
        
        
        //匝位
        UILabel * turnLabel = [[UILabel alloc]init];
        turnLabel.text = @"匝   号:";
        turnLabel.font = [UIFont systemFontOfSize:14];
        turnLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:turnLabel];
        
        
        UILabel * turnDetailLabel = [[UILabel alloc]init];
        turnDetailLabel.font = [UIFont systemFontOfSize:14];
        turnDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:turnDetailLabel];
        _turnDetailLabel = turnDetailLabel;
        
        
        
        paiBtn.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .widthIs(17)
        .heightIs(17);
        paiBtn.layer.cornerRadius = paiBtn.yj_width * 0.5;
        paiBtn.layer.masksToBounds = YES;
        
        
        
        huangliaoLabel.sd_layout
        .leftSpaceToView(paiBtn, 9)
        .topEqualToView(paiBtn)
        .bottomEqualToView(paiBtn)
        .widthIs(60);
        
        
        detailHuangliaoLabel.sd_layout
        .leftSpaceToView(huangliaoLabel, 10)
        .rightSpaceToView(self.contentView, 12)
        .topEqualToView(huangliaoLabel)
        .bottomEqualToView(huangliaoLabel);
        
        
        
        nameLabel.sd_layout
        .leftEqualToView(huangliaoLabel)
        .rightEqualToView(huangliaoLabel)
        .topSpaceToView(huangliaoLabel, 7)
        .heightIs(13);
        
        
        detailNameLabel.sd_layout
        .leftEqualToView(detailHuangliaoLabel)
        .rightEqualToView(detailHuangliaoLabel)
        .topEqualToView(nameLabel)
        .bottomEqualToView(nameLabel);
        
        
        zaLabel.sd_layout
        .leftEqualToView(nameLabel)
        .rightEqualToView(nameLabel)
        .topSpaceToView(nameLabel, 7)
        .heightIs(13);
        
        
        detailZaLabel.sd_layout
        .leftEqualToView(detailNameLabel)
        .rightEqualToView(detailNameLabel)
        .topEqualToView(zaLabel)
        .bottomEqualToView(zaLabel);
        
        
        arenLabel.sd_layout
        .leftEqualToView(zaLabel)
        .rightEqualToView(zaLabel)
        .topSpaceToView(zaLabel, 7)
        //.bottomSpaceToView(self.contentView, 9);
        .heightIs(13);
        
        
        detailAreaLabel.sd_layout
        .leftEqualToView(detailZaLabel)
        .rightEqualToView(detailZaLabel)
        .topEqualToView(arenLabel)
        .bottomEqualToView(arenLabel);
        
        
        locationLabel.sd_layout
        .leftEqualToView(arenLabel)
        .rightEqualToView(arenLabel)
        .topSpaceToView(arenLabel, 7)
        .heightIs(13);
        
        locationDetailLabel.sd_layout
        .leftEqualToView(detailAreaLabel)
        .rightEqualToView(detailAreaLabel)
        .topEqualToView(locationLabel)
        .bottomEqualToView(locationLabel);
        
        
        turnLabel.sd_layout
        .leftEqualToView(locationLabel)
        .rightEqualToView(locationLabel)
        .topSpaceToView(locationLabel, 7)
        .heightIs(13);
        
        turnDetailLabel.sd_layout
        .leftEqualToView(locationDetailLabel)
        .rightEqualToView(locationDetailLabel)
        .topEqualToView(turnLabel)
        .bottomEqualToView(turnLabel);

        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
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
