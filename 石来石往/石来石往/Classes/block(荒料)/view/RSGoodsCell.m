//
//  RSGoodsCell.m
//  石来石往
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSGoodsCell.h"
#import "RSBlockModel.h"

#import "RSOsakaModel.h"

#import "RSTurnsCountModel.h"
#import "RSPiecesModel.h"

@interface RSGoodsCell ()

{
    
    UILabel * _ssLabel;
    
    
    UILabel * _tiLabel;
    
}



@property (nonatomic,strong)UILabel * numberlabel;

@property (nonatomic,strong)UILabel *productLabel;

@property (nonatomic,strong)UILabel * psLabel;


@property (nonatomic,strong)UILabel * tiDetailLabel;

@end


@implementation RSGoodsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *contentview = [[UIView alloc]init];
        contentview.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentview];
        
        contentview.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,0)
        .bottomEqualToView(self);
        
        UIImageView * redImageview = [[UIImageView alloc]init];
        redImageview.image = [UIImage imageNamed:@"椭圆-1"];
        [contentview addSubview:redImageview];
        
        redImageview.sd_layout
        .leftSpaceToView(contentview,12)
        .topSpaceToView(contentview,10.5)
        .heightIs(12)
        .widthIs(12);
        
        //荒料号
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
        
        //名称
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
        
        //规格
        UILabel * ssLabel = [[UILabel alloc]init];
        ssLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        ssLabel.font = [UIFont systemFontOfSize:16];
        ssLabel.text = @"规   格";
        _ssLabel = ssLabel;
        [contentview addSubview:ssLabel];
        
        UILabel * psLabel = [[UILabel alloc]init];
        psLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        psLabel.font = [UIFont systemFontOfSize:16];
        psLabel.text = @"1.8*1.8*2.4(m)";
        [contentview addSubview:psLabel];
        _psLabel = psLabel;
        
        
        
        //总体积
        UILabel * tiLabel = [[UILabel alloc]init];
        tiLabel.text = @"体   积";
        tiLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        tiLabel.font = [UIFont systemFontOfSize:16];
        [contentview addSubview:tiLabel];
        _tiLabel = tiLabel;
        
        //总体积内容
        UILabel * tiDetailLabel = [[UILabel alloc]init];
        tiDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        tiDetailLabel.font = [UIFont systemFontOfSize:16];
        [contentview addSubview:tiDetailLabel];
        _tiDetailLabel = tiDetailLabel;
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
        [contentview addSubview:bottomview];
        
        
        
        blockNumberLabel.sd_layout
        .leftSpaceToView(redImageview,12)
        .topSpaceToView(contentview,10.5)
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
        
        psLabel.sd_layout
        .leftSpaceToView(ssLabel,10)
        .topEqualToView(ssLabel)
        .bottomEqualToView(ssLabel)
        .widthRatioToView(contentview,0.5);
        
       
        tiLabel.sd_layout
        .leftEqualToView(ssLabel)
        .topSpaceToView(ssLabel, 10.5)
        .widthIs(50)
        .heightIs(20.5);
        
        
        tiDetailLabel.sd_layout
        .leftSpaceToView(tiLabel, 10)
        .topEqualToView(tiLabel)
        .bottomEqualToView(tiLabel)
        .widthRatioToView(contentview, 0.5);
        
        
        bottomview.sd_layout
        .leftSpaceToView(contentview,12)
        .rightSpaceToView(contentview,12)
        .bottomSpaceToView(contentview,0)
        .heightIs(1);
        
        
        
        
    }
    return self;
}

- (void)setBlockmodel:(RSBlockModel *)blockmodel{
    _blockmodel = blockmodel;
    _numberlabel.text = [NSString stringWithFormat:@"%@/%@",blockmodel.erpid,blockmodel.blockID];
    _productLabel.text = [NSString stringWithFormat:@"%@",blockmodel.blockName];
    _psLabel.text = [NSString stringWithFormat:@"%@",blockmodel.blockLWH];
    //这边是总体积
    _tiLabel.text = @"体   积";
    _tiDetailLabel.text = [NSString stringWithFormat:@"%@m³",blockmodel.blockVolume];
}

- (void)setOsakaModel:(RSOsakaModel *)osakaModel{
    _osakaModel = osakaModel;
    _numberlabel.text = [NSString stringWithFormat:@"%@/%@",osakaModel.erpid,osakaModel.blockID];
    _productLabel.text = [NSString stringWithFormat:@"%@",osakaModel.blockName];
    _ssLabel.text = @"已   选";
    CGFloat zongPi = 0.0;
    for (int i = 0; i < _osakaModel.turns.count; i++) {
        RSTurnsCountModel * turnsModel = osakaModel.turns[i];
        if (turnsModel.turnsStatus == 1) {
            //这边是按匝
            for (int n = 0; n < turnsModel.pieces.count; n++) {
                RSPiecesModel * piecesModel = turnsModel.pieces[n];
                zongPi += [piecesModel.area floatValue];
            }
        }else{
            //这边是按片
            for (int n = 0; n < turnsModel.pieces.count; n++) {
                RSPiecesModel * piecesModel = turnsModel.pieces[n];
                if (piecesModel.status == 1) {
                    zongPi += [piecesModel.area floatValue];
                }
            }
        }
    }
    _psLabel.text = [NSString stringWithFormat:@"%ld片",(long)osakaModel.count];
    _tiLabel.text = @"面   积";
    _tiDetailLabel.text = [NSString stringWithFormat:@"%0.3fm²",zongPi];
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
