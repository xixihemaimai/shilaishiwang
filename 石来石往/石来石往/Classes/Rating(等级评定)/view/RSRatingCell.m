//
//  RSRatingCell.m
//  石来石往
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSRatingCell.h"
//模型
#import "RSRatingModel.h"

@interface RSRatingCell()

{
    /**荒料号*/
    UILabel * _blockLabel;
    
    /**石种*/
    UILabel * _stoneLabel;
    
    /**体积*/
    UILabel * _volumeLabel;
    
    /**重量*/
    UILabel * _wieghtLabel;
}


@end


@implementation RSRatingCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     //上边视图
        UIView *headerview = [[UIView alloc]init];
        headerview.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:headerview];
        
        headerview.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .topSpaceToView(self.contentView,0)
        .heightIs(92);
        
        //荒料号
        UILabel * label = [[UILabel alloc]init];
        label.text = @"荒料号:";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        [headerview addSubview:label];
        
        UILabel * blockLabel = [[UILabel alloc]init];
        blockLabel.textColor = [UIColor blackColor];
        blockLabel.text = @"HXACO19654/SX-15605";
        blockLabel.font = [UIFont systemFontOfSize:14];
        [headerview addSubview:blockLabel];
        _blockLabel = blockLabel;
        //石种
        UILabel * siLabel = [[UILabel alloc]init];
        siLabel.text = @"石    种:";
        siLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        siLabel.font = [UIFont systemFontOfSize:14];
        [headerview addSubview:siLabel];
        
        UILabel *stoneLabel = [[UILabel alloc]init];
        stoneLabel.text = @"白玉兰";
        stoneLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        stoneLabel.font = [UIFont systemFontOfSize:14];
        [headerview addSubview:stoneLabel];
        _stoneLabel = stoneLabel;
        
        //匝号
        UILabel *tiLabel = [[UILabel alloc]init];
        tiLabel.text = @"匝    号:";
        tiLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        tiLabel.font = [UIFont systemFontOfSize:14];
        [headerview addSubview:tiLabel];
        
        UILabel *volumeLabel = [[UILabel alloc]init];
        volumeLabel.text = @"12.123m3";
        volumeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        volumeLabel.font = [UIFont systemFontOfSize:14];
        [headerview addSubview:volumeLabel];
        _volumeLabel = volumeLabel;
        //面积
        
        UILabel * zhongLabel = [[UILabel alloc]init];
        zhongLabel.text = @"总面积:";
        zhongLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        zhongLabel.font = [UIFont systemFontOfSize:14];
        [headerview addSubview:zhongLabel];
        
        UILabel *wieghtLabel = [[UILabel alloc]init];
        wieghtLabel.text = @"1.11顿";
        wieghtLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        wieghtLabel.font = [UIFont systemFontOfSize:14];
        [headerview addSubview:wieghtLabel];
        _wieghtLabel = wieghtLabel;
        //底部分隔线
        UIView *bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [headerview addSubview:bottomview];
        
        label.sd_layout
        .leftSpaceToView(headerview,12)
        .topSpaceToView(headerview,6)
        .widthIs(60)
        .heightIs(15);
        
        blockLabel.sd_layout
        .leftSpaceToView(label,10)
        .rightSpaceToView(headerview,12)
        .topEqualToView(label)
        .bottomEqualToView(label);
        
        siLabel.sd_layout
        .leftEqualToView(label)
        .topSpaceToView(label,6)
        .rightEqualToView(label)
        .heightIs(15);
        
        stoneLabel.sd_layout
        .leftSpaceToView(siLabel,10)
        .rightSpaceToView(headerview,12)
        .topEqualToView(siLabel)
        .bottomEqualToView(siLabel);
        
        tiLabel.sd_layout
        .leftEqualToView(siLabel)
        .rightEqualToView(siLabel)
        .topSpaceToView(siLabel,6)
        .heightIs(15);
        
        volumeLabel.sd_layout
        .leftSpaceToView(tiLabel,10)
        .rightSpaceToView(headerview,12)
        .topEqualToView(tiLabel)
        .bottomEqualToView(tiLabel);
        
        zhongLabel.sd_layout
        .leftEqualToView(tiLabel)
        .rightEqualToView(tiLabel)
        .topSpaceToView(tiLabel,6)
        .heightIs(15);
        
        
        wieghtLabel.sd_layout
        .leftSpaceToView(zhongLabel,10)
        .rightSpaceToView(headerview,12)
        .topEqualToView(zhongLabel)
        .bottomEqualToView(zhongLabel);
        
        bottomview.sd_layout
        .leftSpaceToView(headerview,12)
        .rightSpaceToView(headerview,12)
        .bottomSpaceToView(headerview,0)
        .heightIs(1);
    
        UIView *midview = [[UIView alloc]init];
        midview.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:midview];
        
        midview.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .topSpaceToView(headerview,0)
        .heightIs(34);
        
        UILabel * gradeLabel = [[UILabel alloc]init];
        gradeLabel.text = @"等级评定";
        gradeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        gradeLabel.font = [UIFont systemFontOfSize:14];
        [midview addSubview:gradeLabel];
        
        UIButton * aBtn = [[UIButton alloc]init];
        aBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [aBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        [aBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
        aBtn.layer.cornerRadius = 10;
        aBtn.layer.masksToBounds = YES;
       
        [aBtn setTitle:@"A" forState:UIControlStateNormal];
        
        [midview addSubview:aBtn];
        _aBtn = aBtn;
        UIButton *bBtn = [[UIButton alloc]init];
        [bBtn setTitle:@"B" forState:UIControlStateNormal];
        [bBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        [bBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
        bBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        bBtn.layer.cornerRadius = 10;
        bBtn.layer.masksToBounds = YES;
        
        
        
        
        [midview addSubview:bBtn];
        
        _bBtn = bBtn;
        UIButton *cBtn = [[UIButton alloc]init];
        [cBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        [cBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f1eff2"]];
        cBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        cBtn.layer.cornerRadius = 10;
        cBtn.layer.masksToBounds = YES;
        
        [midview addSubview:cBtn];
        [cBtn setTitle:@"C" forState:UIControlStateNormal];
        _cBtn = cBtn;
        
        gradeLabel.sd_layout
        .leftSpaceToView(midview,12)
        .topSpaceToView(midview,5)
        .bottomSpaceToView(midview,5)
        .widthIs(70);
        
        aBtn.sd_layout
        .leftSpaceToView(gradeLabel,10)
        .topSpaceToView(midview,5)
        .bottomSpaceToView(midview,5)
        .widthIs(45);
        
        bBtn.sd_layout
        .leftSpaceToView(aBtn,10)
        .topEqualToView(aBtn)
        .bottomEqualToView(aBtn)
        .widthIs(45);
        
        cBtn.sd_layout
        .leftSpaceToView(bBtn,10)
        .topEqualToView(bBtn)
        .bottomEqualToView(bBtn)
        .widthIs(45);
        
    }
    return self;
}

- (void)setRatingModel:(RSRatingModel *)ratingModel{
    _ratingModel = ratingModel;
    _blockLabel.text = [NSString stringWithFormat:@"%@",ratingModel.stoneId];
    _stoneLabel.text = [NSString stringWithFormat:@"%@",ratingModel.stoneName];
    
    _volumeLabel.text = [NSString stringWithFormat:@"%@",ratingModel.stoneWeight];
    
    _wieghtLabel.text = [NSString stringWithFormat:@"%@",ratingModel.stoneMessage];

        
    
    
    
    
    
    
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
