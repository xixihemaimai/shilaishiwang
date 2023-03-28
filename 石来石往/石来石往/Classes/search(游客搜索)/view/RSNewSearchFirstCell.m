//
//  RSNewSearchFirstCell.m
//  石来石往
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNewSearchFirstCell.h"


@interface RSNewSearchFirstCell()
{
    
   
    
    UILabel * _fristMingLabel;
    
    
    UILabel * _fristgugeLabel;
    
    
    
    UILabel * _fristguge;
}


@end

@implementation RSNewSearchFirstCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //图片
        UIImageView * fristImage = [[UIImageView alloc]init];
        [self.contentView addSubview:fristImage];
        _fristImage = fristImage;
        fristImage.userInteractionEnabled = YES;
        
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showStonePicture:)];
//        [fristImage addGestureRecognizer:tap];
        
        
        
        
        //荒料号
        UILabel * fristHuangliao = [[UILabel alloc]init];
        fristHuangliao.text = @"荒料号";
        fristHuangliao.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        fristHuangliao.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:fristHuangliao];
        
        
        //荒料号的内容
        UILabel * fristHuangliaoLabel = [[UILabel alloc]init];
        fristHuangliaoLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        fristHuangliaoLabel.font = [UIFont systemFontOfSize:12];
       // fristHuangliaoLabel.text = @"1";
        [self.contentView addSubview:fristHuangliaoLabel];
        
        _fristHuangliaoLabel = fristHuangliaoLabel;
        
        //名称
        UILabel * fristMing = [[UILabel alloc]init];
        fristMing.text = @"名   称";
        fristMing.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        fristMing.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:fristMing];
        
        
        //名称的内容
        UILabel * fristMingLabel = [[UILabel alloc]init];
       // fristMingLabel.text = @"2";
        fristMingLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        fristMingLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:fristMingLabel];
        _fristMingLabel = fristMingLabel;
        
        //规格
        UILabel * fristguge = [[UILabel alloc]init];
      //  fristguge.text = @"规   格";
        fristguge.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        fristguge.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:fristguge];
        _fristguge = fristguge;
        //规格的内容
        
        UILabel * fristgugeLabel = [[UILabel alloc]init];
       // fristgugeLabel.text = @"3";
        fristgugeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        fristgugeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:fristgugeLabel];
        _fristgugeLabel = fristgugeLabel;
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
        
        fristImage.sd_layout
        .topSpaceToView(self.contentView, 8.5)
        .bottomSpaceToView(self.contentView, 8.5)
        .topSpaceToView(self.contentView, 11.5)
        .leftSpaceToView(self.contentView, 12)
        .widthIs(80.5);
        
        
        fristHuangliao.sd_layout
        .topEqualToView(fristImage)
        .leftSpaceToView(fristImage, 23.5)
        .widthIs(40)
        .heightIs(11.5);
        
        
        fristHuangliaoLabel.sd_layout
        .leftSpaceToView(fristHuangliao, 10)
        .rightSpaceToView(self.contentView, 12)
        .topEqualToView(fristHuangliao)
        .bottomEqualToView(fristHuangliao);
        
        
        fristMing.sd_layout
        .centerYEqualToView(fristImage)
        .leftEqualToView(fristHuangliao)
        .widthIs(40)
        .heightIs(11.5);
        
        
        
        fristMingLabel.sd_layout
        .leftEqualToView(fristHuangliaoLabel)
        .rightEqualToView(fristHuangliaoLabel)
        .topEqualToView(fristMing)
        .bottomEqualToView(fristMing);
        
        
        fristguge.sd_layout
        .leftEqualToView(fristMing)
        .rightEqualToView(fristMing)
        .bottomEqualToView(fristImage)
        .heightIs(11.5);
        
        
        fristgugeLabel.sd_layout
        .leftEqualToView(fristMingLabel)
        .rightEqualToView(fristMingLabel)
        .topEqualToView(fristguge)
        .bottomEqualToView(fristguge);
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
    }
    return self;
    
    
}




- (void)setCompanyAndStonemodel:(RSCompanyAndStoneModel *)companyAndStonemodel{
    _companyAndStonemodel = companyAndStonemodel;
    
    [_fristImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_companyAndStonemodel.imgUrl]] placeholderImage:[UIImage imageNamed:@"512"]];
    
    
    if ([_companyAndStonemodel.stockType isEqualToString:@"daban"]) {
        
        _fristguge.text = @"总面积";
        
        _fristgugeLabel.text = [NSString stringWithFormat:@"%@m²",_companyAndStonemodel.vaqty];
        
        
    }else{
        _fristguge.text = @"体  积";
        _fristgugeLabel.text = [NSString stringWithFormat:@"%@m³",_companyAndStonemodel.vaqty];
        
    }
    _fristMingLabel.text = [NSString stringWithFormat:@"%@",_companyAndStonemodel.stoneId];
    
    
    
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
