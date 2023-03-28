//
//  RSNewCompanyCell.m
//  石来石往
//
//  Created by mac on 2021/12/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSNewCompanyCell.h"

@interface RSNewCompanyCell()

@property (nonatomic,strong)UIImageView * productImageview;

@property (nonatomic,strong)UILabel * productLabel;

@end

@implementation RSNewCompanyCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        
//        UIImageView * contentImageView = [[UIImageView alloc]init];
//        contentImageView.image = [UIImage imageNamed:@"圆角矩形 710 拷贝"];
//        [self.contentView addSubview:contentImageView];
        
        
        
        
        //图片
        UIImageView * productImageview = [[UIImageView alloc]init];
       // productImage.image = [UIImage imageNamed:@"1080-675"];
        productImageview.contentMode = UIViewContentModeScaleAspectFill;
        productImageview.clipsToBounds= YES;
        [self.contentView addSubview:productImageview];
        _productImageview = productImageview;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigPicturen:)];
        productImageview.userInteractionEnabled = YES;
        [productImageview addGestureRecognizer:tap];
        
        //产品
        UILabel * productLabel = [[UILabel alloc]init];
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productLabel.font = [UIFont systemFontOfSize:Width_Real(15)];
        productLabel.numberOfLines = 0;
        productLabel.textAlignment = NSTextAlignmentCenter;
        productLabel.text = @"米黄";
        [self.contentView addSubview:productLabel];
        _productLabel = productLabel;
        //大板
//        UILabel * dabanProductLabel = [[UILabel alloc]init];
//        dabanProductLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//        dabanProductLabel.font = [UIFont systemFontOfSize:14];
//        dabanProductLabel.textAlignment = NSTextAlignmentLeft;
//        dabanProductLabel.text = @"大板 234㎡";
//        [self.contentView addSubview:dabanProductLabel];
//        _dabanProductLabel = dabanProductLabel;
        //荒料
//        UILabel * huangProductLabel = [[UILabel alloc]init];
//        huangProductLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//        huangProductLabel.font = [UIFont systemFontOfSize:14];
//        huangProductLabel.textAlignment = NSTextAlignmentLeft;
//        huangProductLabel.text = @"荒料 2345m³";
//        [self.contentView addSubview:huangProductLabel];
//        _huangProductLabel = huangProductLabel;
        
        productImageview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .heightIs(Height_Real(120));
        
        productLabel.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.productImageview, 0)
        .bottomSpaceToView(self.contentView, 0);
        
//        dabanProductLabel.sd_layout
//        .leftSpaceToView(self.contentView, 14)
//        .rightSpaceToView(self.contentView, 0)
//        .topSpaceToView(productLabel, 7)
//        .heightIs(15);
        
//        huangProductLabel.sd_layout
//        .leftSpaceToView(self.contentView, 14)
//        .rightSpaceToView(self.contentView, 0)
//        .topSpaceToView(dabanProductLabel, 5)
//        .heightIs(15);
        
    }
    return self;
}


- (void)setCompanyModel:(RSNewCompanyModel *)companyModel{
    _companyModel = companyModel;
    
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
    [self.productImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_companyModel.attachment.url]] placeholderImage:[UIImage imageNamed:@"01"]];
//        cell.dabanProductLabel.text = [NSString stringWithFormat:@"大板:%@m²",cargomaincampmodel.plateTotalMessage];
    self.productLabel.text = _companyModel.nameCn;
    
}

- (void)showBigPicturen:(UITapGestureRecognizer *)tap{
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
    NSMutableArray * images = [NSMutableArray array];
    NSMutableArray * miniImages = [NSMutableArray array];
    [images addObject:[NSString stringWithFormat:@"%@%@",url,self.companyModel.attachment.urlOrigin]];
    [miniImages addObject:[NSString stringWithFormat:@"%@%@",url,self.companyModel.attachment.url]];
    [XLPhotoBrowser showPhotoBrowserWithImages:images andMiniImage:miniImages currentImageIndex:0];
}


@end
