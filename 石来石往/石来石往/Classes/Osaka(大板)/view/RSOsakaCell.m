//
//  RSOsakaCell.m
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSOsakaCell.h"

@implementation RSOsakaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
       
        [self creatUI];
        
        
    }
    return self;
}

- (void)creatUI{
    UIView *contentview = [[UIView alloc]init];
    contentview.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentview];
    
    contentview.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,0)
    .heightIs(105);
    
    UIImageView * redImageview = [[UIImageView alloc]init];
    redImageview.image = [UIImage imageNamed:@"椭圆-1"];
    [contentview addSubview:redImageview];
    
    redImageview.sd_layout
    .leftSpaceToView(contentview,12)
    .topSpaceToView(contentview,10.5)
    .heightIs(12)
    .widthIs(12);
    
    
    
    
    
    UILabel * blockNumberLabel = [[UILabel alloc]init];
    blockNumberLabel.text = @"荒料号";
    blockNumberLabel.font = [UIFont systemFontOfSize:16];
    blockNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [contentview addSubview:blockNumberLabel];
    
    UILabel * numberlabel = [[UILabel alloc]init];
    numberlabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    
    numberlabel.font = [UIFont systemFontOfSize:16];
    numberlabel.text = @"ESB000295/DH-539";
    [contentview addSubview:numberlabel];
    _numberlabel = numberlabel;
    
    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.text = @"名   称";
    [contentview addSubview:nameLabel];
    
    UILabel *productLabel = [[UILabel alloc]init];
    productLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    productLabel.font = [UIFont systemFontOfSize:16];
    productLabel.text = @"黄金麻";
    [contentview addSubview:productLabel];
    _productLabel = productLabel;
    //面积
    UILabel * ssLabel = [[UILabel alloc]init];
    ssLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    ssLabel.font = [UIFont systemFontOfSize:16];
    ssLabel.text = @"面   积";
    [contentview addSubview:ssLabel];
    
    UILabel * areaLabel = [[UILabel alloc]init];
    areaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    areaLabel.font = [UIFont systemFontOfSize:16];
    areaLabel.text = @"1.8*1.8*2.4(m)";
    [contentview addSubview:areaLabel];
    _areaLabel = areaLabel;
    
    
    UILabel *choicelabel = [[UILabel alloc]init];
    choicelabel.text = @"已选中";
    choicelabel.textColor = [UIColor darkGrayColor];
    choicelabel.font = [UIFont systemFontOfSize:16];
    [contentview addSubview:choicelabel];
    _choicelabel = choicelabel;
    choicelabel.hidden = YES;
    
    
    UIView * bottomview = [[UIView alloc]init];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
    [contentview addSubview:bottomview];
    
    
    
    blockNumberLabel.sd_layout
    .leftSpaceToView(redImageview,12)
    .topSpaceToView(contentview,7.5)
    .widthIs(50)
    .heightIs(20.5);
    
    numberlabel.sd_layout
    .leftSpaceToView(blockNumberLabel,10)
    .topEqualToView(blockNumberLabel)
    .bottomEqualToView(blockNumberLabel)
    .widthRatioToView(contentview,0.7);
    
    
    nameLabel.sd_layout
    .topSpaceToView(blockNumberLabel,10.5)
    .leftEqualToView(blockNumberLabel)
    .widthIs(50)
    .heightIs(20.5);
    
    productLabel.sd_layout
    .leftSpaceToView(nameLabel,10)
    .topEqualToView(nameLabel)
    .bottomEqualToView(nameLabel)
    .widthRatioToView(contentview,0.4);
    
    ssLabel.sd_layout
    .topSpaceToView(nameLabel,10.5)
    .leftEqualToView(nameLabel)
    .widthIs(50)
    .heightIs(20.5);
    
    areaLabel.sd_layout
    .leftSpaceToView(ssLabel,10)
    .topEqualToView(ssLabel)
    .bottomEqualToView(ssLabel)
    .widthRatioToView(contentview,0.6);
    
    //        removeBtn.sd_layout
    //        .rightSpaceToView(contentview,12)
    //        .centerYEqualToView(contentview)
    //        .leftSpaceToView(productLabel,20)
    //        .widthIs(20)
    //        .heightIs(20);
    
    
    choicelabel.sd_layout
    .rightSpaceToView(contentview,12)
    .centerYEqualToView(contentview)
    .leftSpaceToView(productLabel,20)
    .widthIs(60)
    .heightIs(20);
    
    bottomview.sd_layout
    .leftSpaceToView(contentview,12)
    .rightSpaceToView(contentview,12)
    .bottomSpaceToView(contentview,0)
    .heightIs(1);
}







- (void)setOsakaModel:(RSOsakaModel *)osakaModel{
    _osakaModel = osakaModel;
    
    _numberlabel.text = [NSString stringWithFormat:@"%@/%@",osakaModel.erpid,osakaModel.blockID];
    _productLabel.text = [NSString stringWithFormat:@"%@",osakaModel.blockName];
    _areaLabel.text = [NSString stringWithFormat:@"%.3fm²",[osakaModel.blockVolume floatValue]];
    
    
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
