//
//  RSSCContentCompanyCell.m
//  石来石往
//
//  Created by mac on 2021/10/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCContentCompanyCell.h"

@interface RSSCContentCompanyCell()

@property (nonatomic,strong)UIImageView * companyTouImage;

@property (nonatomic,strong)UILabel * companyNameLabel;

@property (nonatomic,strong)UIImageView * companyVipImage;


@property (nonatomic,strong)UILabel * companyAddressLabel;

@property (nonatomic,strong)UILabel * companyIntrdouctLabel;

@property (nonatomic,strong)UIImageView * companyfirstImage;

@property (nonatomic,strong)UIImageView * companySecondImage;

@property (nonatomic,strong)UIImageView * companyThirdImage;

@end

@implementation RSSCContentCompanyCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        //企业图片
        UIImageView * companyTouImage = [[UIImageView alloc]init];
        companyTouImage.image = [UIImage imageNamed:@"01"];
        [self.contentView addSubview:companyTouImage];
        
        companyTouImage.sd_layout.topSpaceToView(self.contentView, Height_Real(14)).leftSpaceToView(self.contentView, Width_Real(16)).widthIs(Width_Real(90)).heightIs(Height_Real(60));
        companyTouImage.layer.cornerRadius = Width_Real(4);
        companyTouImage.layer.masksToBounds = true;
        _companyTouImage = companyTouImage;
        
        //企业名称
        UILabel * companyNameLabel = [[UILabel alloc]init];
        companyNameLabel.text = @"海西石材有限公司";
        companyNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        companyNameLabel.font = [UIFont systemFontOfSize:Width_Real(16) weight:UIFontWeightMedium];
        companyNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:companyNameLabel];
        _companyNameLabel = companyNameLabel;
        
        
        companyNameLabel.sd_layout.topSpaceToView(self.contentView, Height_Real(12)).leftSpaceToView(companyTouImage, Width_Real(12)).rightSpaceToView(self.contentView, Width_Real(16)).heightIs(Height_Real(23));
        
        //vip
        UIImageView * companyVipImage = [[UIImageView alloc]init];
        companyVipImage.image = [UIImage imageNamed:@"vip"];
        [self.contentView addSubview:companyVipImage];
        
        companyVipImage.sd_layout.leftEqualToView(companyNameLabel).topSpaceToView(companyNameLabel, Height_Real(4)).widthIs(Height_Real(16)).heightEqualToWidth();
        _companyVipImage = companyVipImage;
        
        //地址
        UILabel * companyAddressLabel = [[UILabel alloc]init];
        companyAddressLabel.text = @"福建 南安 水头镇 海西石材城";
        companyAddressLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        companyAddressLabel.font = [UIFont systemFontOfSize:Width_Real(10) weight:UIFontWeightMedium];
        companyAddressLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:companyAddressLabel];
        _companyAddressLabel = companyAddressLabel;
        
        companyAddressLabel.sd_layout.leftEqualToView(companyVipImage).topSpaceToView(companyVipImage, Height_Real(8)).rightEqualToView(companyNameLabel).heightIs(Height_Real(14));
        
        //介绍
        
        UILabel * companyIntrdouctLabel = [[UILabel alloc]init];
        companyIntrdouctLabel.text = @"主营：雪花白，细花白，印象会，意大利金，奥特曼，摩卡，汉主营：雪花白，细花白，印象会，意大利金，奥特曼，摩卡，汉";
        companyIntrdouctLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        companyIntrdouctLabel.font = [UIFont systemFontOfSize:Width_Real(12) weight:UIFontWeightMedium];
        companyIntrdouctLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:companyIntrdouctLabel];
        _companyIntrdouctLabel = companyIntrdouctLabel;
        
        companyIntrdouctLabel.sd_layout.leftSpaceToView(self.contentView, Width_Real(16)).topSpaceToView(companyTouImage, Height_Real(11)).rightSpaceToView(self.contentView, Width_Real(16)).heightIs(Height_Real(17));
        
        //三张图片
        
        CGFloat width = (SCW - Width_Real(32) - (Width_Real(8) * 2))/3;
       // CGFloat height =  (width * Height_Real(73)) / Width_Real(109);
        UIImageView * companyfirstImage = [[UIImageView alloc]init];
        companyfirstImage.image = [UIImage imageNamed:@"01"];
        [self.contentView addSubview:companyfirstImage];
        _companyfirstImage = companyfirstImage;
        
        companyfirstImage.sd_layout.leftSpaceToView(self.contentView, Width_Real(16)).widthIs(width).heightIs(Height_Real(73)).topSpaceToView(companyIntrdouctLabel, Height_Real(8));
        companyfirstImage.layer.cornerRadius = Width_Real(4);
        companyfirstImage.layer.masksToBounds = true;
        
        UIImageView * companySecondImage = [[UIImageView alloc]init];
        companySecondImage.image = [UIImage imageNamed:@"01"];
        [self.contentView addSubview:companySecondImage];
        _companySecondImage = companySecondImage;
        
        companySecondImage.sd_layout.topEqualToView(companyfirstImage).bottomEqualToView(companyfirstImage).widthIs(width).centerXEqualToView(self.contentView);
        companySecondImage.layer.cornerRadius = Width_Real(4);
        companySecondImage.layer.masksToBounds = true;
        
        UIImageView * companyThirdImage = [[UIImageView alloc]init];
        companyThirdImage.image = [UIImage imageNamed:@"01"];
        [self.contentView addSubview:companyThirdImage];
        _companyThirdImage = companyThirdImage;
        
        companyThirdImage.sd_layout.topEqualToView(companySecondImage).bottomEqualToView(companySecondImage).widthIs(width).rightSpaceToView(self.contentView, Width_Real(16));
        
        companyThirdImage.layer.cornerRadius = Width_Real(4);
        companyThirdImage.layer.masksToBounds = true;
        
        //分割线
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#DCDFE6" alpha:1.0];
        [self.contentView addSubview:bottomView];
        
        bottomView.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(Height_Real(0.5));
        
        
        
    }
    return self;
}


- (void)setSccompanyModel:(RSSCCompanyModel *)sccompanyModel{
    _sccompanyModel = sccompanyModel;
    
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
//    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_sccontentModel.url]]]];
    [_companyTouImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_sccompanyModel.logoUrl]] placeholderImage:nil];
    
    _companyNameLabel.text = _sccompanyModel.nameCn;
    _companyAddressLabel.text = _sccompanyModel.address;
    
    _companyIntrdouctLabel.text = _sccompanyModel.mainBusiness;
    
    if (_sccompanyModel.urlList.count > 0) {
       [_companyfirstImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_sccompanyModel.urlList[0]]] placeholderImage:nil];
        _companyfirstImage.hidden = false;
    } else{
        _companyfirstImage.hidden = true;
    }
    if (_sccompanyModel.urlList.count > 1) {
       [_companySecondImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_sccompanyModel.urlList[1]]] placeholderImage:nil];
        _companySecondImage.hidden = false;
    }else{
        _companySecondImage.hidden = true;
    }
    if (_sccompanyModel.urlList.count > 2) {
        [_companyThirdImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_sccompanyModel.urlList[2]]] placeholderImage:nil];
        _companyThirdImage.hidden = false;
    }else{
        _companyThirdImage.hidden = true;
    }
}

@end
