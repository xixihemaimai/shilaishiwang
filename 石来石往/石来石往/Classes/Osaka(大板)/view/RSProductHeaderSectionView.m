//
//  RSProductHeaderSectionView.m
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSProductHeaderSectionView.h"
#import "UIImageView+WebCache.h"
#import "RSOsakaModel.h"
#import "RSTurnsCountModel.h"
@interface RSProductHeaderSectionView()

/**产品的图片*/
@property (nonatomic,strong)UIImageView * productImageview;
/**产品的荒料号*/
@property (nonatomic,strong)UILabel * blockLabel;
/**产品的名称*/
@property (nonatomic,strong)UILabel * nameLabel;
/**产品的片数*/
@property (nonatomic,strong)UILabel *numberLabel;
/**产品的类别*/
@property (nonatomic,strong)UILabel * categoryLabel;
/**产品的面积*/
@property (nonatomic,strong)UILabel *areaLabel;
@end

@implementation RSProductHeaderSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIView * contentview = [[UIView alloc]init];
        contentview.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentview];
        
        contentview.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,0)
        .heightIs(100);
        //图片
        UIImageView * productImageview = [[UIImageView alloc]init];
        _productImageview = productImageview;
        [contentview addSubview:productImageview];
        
        productImageview.sd_layout
        .leftSpaceToView(contentview,8)
        .topSpaceToView(contentview,6)
        .bottomSpaceToView(contentview,7)
        .widthIs(100);
        
        //荒料号
        UILabel * blockLabel = [[UILabel alloc]init];
        blockLabel.textColor = [UIColor colorWithHexColorStr:@"#ff570a"];
        blockLabel.font = [UIFont systemFontOfSize:15];
        _blockLabel = blockLabel;
        [contentview addSubview:blockLabel];
        
        blockLabel.sd_layout
        .leftSpaceToView(productImageview,8)
        .rightSpaceToView(contentview,12)
        .topEqualToView(productImageview)
        .heightIs(15);
        
        //名称
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        nameLabel.font = [UIFont systemFontOfSize:14];
        [contentview addSubview:nameLabel];
        _nameLabel = nameLabel;
        nameLabel.sd_layout
        .leftEqualToView(blockLabel)
        .rightEqualToView(blockLabel)
        .topSpaceToView(blockLabel,4)
        .heightIs(14);
        
        //片数
        UILabel *numberLabel = [[UILabel alloc]init];
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        numberLabel.font = [UIFont systemFontOfSize:14];
        [contentview addSubview:numberLabel];
        _numberLabel = numberLabel;
        numberLabel.sd_layout
        .leftEqualToView(nameLabel)
        .rightEqualToView(nameLabel)
        .topSpaceToView(nameLabel,4)
        .heightIs(14);
        
        
        //类别
        UILabel * categoryLabel = [[UILabel alloc]init];
        categoryLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        categoryLabel.font = [UIFont systemFontOfSize:14];
        [contentview addSubview:categoryLabel];
        
        _categoryLabel = categoryLabel;
        categoryLabel.sd_layout
        .leftEqualToView(numberLabel)
        .rightEqualToView(numberLabel)
        .topSpaceToView(numberLabel,4)
        .heightIs(14);
        
        //面积
        UILabel *areaLabel = [[UILabel alloc]init];
        areaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        areaLabel.font = [UIFont systemFontOfSize:14];
        [contentview addSubview:areaLabel];
        _areaLabel = areaLabel;
        areaLabel.sd_layout
        .leftEqualToView(categoryLabel)
        .rightEqualToView(categoryLabel)
        .topSpaceToView(categoryLabel,4)
        .bottomEqualToView(productImageview);
        
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [contentview addSubview:bottomview];
        bottomview.sd_layout
        .leftSpaceToView(contentview, 0)
        .rightSpaceToView(contentview, 0)
        .bottomSpaceToView(contentview, 0)
        .heightIs(1);

        
        
        
        
        
    }
    return self;
}


- (void)setOsakaModel:(RSOsakaModel *)osakaModel{
    _osakaModel = osakaModel;
    //URL_HEADER_IMAGEURL_IOS
    [_productImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_IMAGEURL_IOS ,osakaModel.imgpath]] placeholderImage:[UIImage imageNamed:@"默认图灰"]];
    _blockLabel.text =[NSString stringWithFormat:@"荒料号:%@/%@",osakaModel.erpid,osakaModel.blockID];
    _nameLabel.text = [NSString stringWithFormat:@"名   称:%@",osakaModel.blockName];
    
    
    _categoryLabel.text = [NSString stringWithFormat:@"类   别:%@",osakaModel.blockClasses];
    
    
     _numberLabel.text = [NSString stringWithFormat:@"匝   数:%ld",(long)osakaModel.turns.count];
     _areaLabel.text = [NSString stringWithFormat:@"面   积:%.3fm²",[osakaModel.blockVolume floatValue]];
    
}



@end
