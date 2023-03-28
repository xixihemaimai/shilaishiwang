//
//  RSSCOwnerCell.m
//  石来石往
//
//  Created by mac on 2021/10/28.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCOwnerCell.h"

@interface RSSCOwnerCell()

@property (nonatomic,strong)UIImageView * companyImage;

@property (nonatomic,strong)UILabel * companyNameLabel;

@property (nonatomic,strong)UILabel * companyContactLabel;



@end


@implementation RSSCOwnerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        //图片
        UIImageView * companyImage = [[UIImageView alloc]init];
        companyImage.image = [UIImage imageNamed:@"01"];
        [self.contentView addSubview:companyImage];
        companyImage.sd_layout.leftSpaceToView(self.contentView, Width_Real(16)).topSpaceToView(self.contentView, Height_Real(8)).widthIs(Width_Real(130)).bottomSpaceToView(self.contentView, Height_Real(4));
        companyImage.layer.cornerRadius = Width_Real(4);
        companyImage.layer.masksToBounds = true;
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showbigPicture:)];
        companyImage.userInteractionEnabled  = YES;
        [companyImage addGestureRecognizer:tap];
        _companyImage = companyImage;
        
        //显示位置
        UIImageView * signImage = [[UIImageView alloc]init];
//        signImage.image = [UIImage imageNamed:@"Rectangle 13"];
        [companyImage addSubview:signImage];
        _signImage = signImage;
        signImage.sd_layout.leftSpaceToView(companyImage, 0).topSpaceToView(companyImage, 0).widthIs(32).heightIs(23);
        
        //表示显示位号
        UILabel * signLabel = [[UILabel alloc]init];
        signLabel.text = @"1";
        signLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        signLabel.backgroundColor = [UIColor clearColor];
        signLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightMedium];
        signLabel.textAlignment = NSTextAlignmentCenter;
        _signLabel = signLabel;
        [signImage addSubview:signLabel];
        signLabel.sd_layout.leftSpaceToView(signImage, 0).topSpaceToView(signImage, 0).rightSpaceToView(signImage, 0)
        .bottomSpaceToView(signImage, 0);
        
        //公司
        UILabel * companyNameLabel = [[UILabel alloc]init];
        companyNameLabel.text = @"海西石材有限公司";
        companyNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        companyNameLabel.font = [UIFont systemFontOfSize:Width_Real(16) weight:UIFontWeightMedium];
        companyNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:companyNameLabel];
        _companyNameLabel = companyNameLabel;
        
        companyNameLabel.sd_layout.leftSpaceToView(companyImage, Width_Real(12)).topSpaceToView(self.contentView, Height_Real(8)).rightSpaceToView(self.contentView, Width_Real(62)).heightIs(Height_Real(23));
        
        //联系方式
        UILabel * companyContactLabel = [[UILabel alloc]init];
        companyContactLabel.text = @"联系方式:13867648888";
        companyContactLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        companyContactLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
        companyContactLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:companyContactLabel];
        _companyContactLabel = companyContactLabel;
        
        
        companyContactLabel.sd_layout.leftEqualToView(companyNameLabel).topSpaceToView(companyNameLabel, Height_Real(4)).rightEqualToView(companyNameLabel).heightIs(Height_Real(20));
        
        
        
        UILabel * stoneWarehouse = [[UILabel alloc]init];
        stoneWarehouse.text = @"1区1架01";
        stoneWarehouse.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
        stoneWarehouse.textAlignment = NSTextAlignmentLeft;
        stoneWarehouse.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [self.contentView addSubview:stoneWarehouse];
        _stoneWarehouse = stoneWarehouse;
        
        _stoneWarehouse.sd_layout.leftEqualToView(companyContactLabel).rightEqualToView(companyContactLabel).topSpaceToView(companyContactLabel, Height_Real(4)).heightIs(Height_Real(19));
        
        
        //地址（有俩行）
        RSSCLabel * companyAddressLabel = [[RSSCLabel alloc]init];
        companyAddressLabel.numberOfLines = 0;
        companyAddressLabel.text = @"经营地址:南安 水头镇 海 西石材城==================================";
        companyAddressLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        companyAddressLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
        companyAddressLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:companyAddressLabel];
        
        companyAddressLabel.sd_layout.leftEqualToView(companyContactLabel).rightEqualToView(companyContactLabel).topSpaceToView(stoneWarehouse, Height_Real(4)).heightIs(0);
        _companyAddressLabel  = companyAddressLabel;
        
        
        UIButton * companyPhoneNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [companyPhoneNumberBtn setImage:[UIImage imageNamed:@"新电话"] forState:UIControlStateNormal];
        companyPhoneNumberBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:companyPhoneNumberBtn];
//        [companyPhoneNumberBtn addTarget:self action:@selector(playPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        companyPhoneNumberBtn.sd_layout.leftSpaceToView(companyContactLabel, Width_Real(13)).topSpaceToView(self.contentView, Height_Real(36)).heightIs(Height_Real(18)).widthIs(Width_Real(28));
        _companyPhoneNumberBtn = companyPhoneNumberBtn;
        
        UIButton * companyAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [companyAddressBtn setImage:[UIImage imageNamed:@"新地址"] forState:UIControlStateNormal];
        [self.contentView addSubview:companyAddressBtn];
        companyAddressBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _companyAddressBtn = companyAddressBtn;
        
        
        companyAddressBtn.sd_layout.leftSpaceToView(companyAddressLabel, Width_Real(13)).topSpaceToView(companyPhoneNumberBtn, Height_Real(34)).heightIs(Height_Real(18)).widthIs(Width_Real(28));
        
        
    }
    return self;
}

////打电话
//- (void)playPhoneAction:(UIButton *)playPhoneBtn{
////    CLog(@"打电话");
//    UIWebView *webview = [[UIWebView alloc]init];
//    if (playPhoneBtn.tag == 1) {
//
//        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.sccontentModel.contactNumber]]]];
//    }else{
//
//        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.ownerStoneModel.ownerPhone]]]];
//    }
//    [self.contentView addSubview:webview];
//}


- (void)setSccontentModel:(RSSCContentModel *)sccontentModel{
    _sccontentModel = sccontentModel;
//    _companyPhoneNumberBtn.tag = 1;
    _companyImage.tag = 1;
    
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
    
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",url,_sccontentModel.url]];
    
//    [_companyImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_sccontentModel.url]] placeholderImage:[UIImage imageNamed:@"01"]];
    
    [_companyImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@",url,_sccontentModel.url] placeholderImage:cacheImage];
    
    
    _companyNameLabel.text = _sccontentModel.enterpriseNameCn;
    
    _companyContactLabel.text = [NSString stringWithFormat:@"联系方式:%@",_sccontentModel.contactNumber];
    
    _stoneWarehouse.text =  [NSString stringWithFormat:@"展示位:%@",_sccontentModel.exhibitionLocation];
    
    _companyAddressLabel.text = [NSString stringWithFormat:@"经营地址:%@",_sccontentModel.address];
    
    _companyAddressLabel.sd_layout.leftEqualToView(_companyContactLabel).rightEqualToView(_companyContactLabel).topSpaceToView(_stoneWarehouse, Height_Real(4)).heightIs(Height_Real(39));
}

- (void)setOwnerStoneModel:(RSOwnerStoneModel *)ownerStoneModel{
    _ownerStoneModel = ownerStoneModel;
    
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
    [_companyImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_ownerStoneModel.stoneImageUrl]] placeholderImage:[UIImage imageNamed:@"01"]];
    _companyImage.tag = 2;
    _companyPhoneNumberBtn.tag = 2;
    _companyNameLabel.text = _ownerStoneModel.deaName;
    
//    CLog(@"====================================%@",_ownerStoneModel.location);
    _companyContactLabel.text = [NSString stringWithFormat:@"联系方式:%@",_ownerStoneModel.ownerPhone];

    _companyAddressLabel.text = [NSString stringWithFormat:@"存储位置:%@",_ownerStoneModel.location];
    
    _companyAddressLabel.sd_layout.leftEqualToView(_companyContactLabel).rightSpaceToView(self.contentView, Width_Real(16)).topSpaceToView(_companyContactLabel, Height_Real(4)).heightIs(Height_Real(39));
    
    _companyAddressBtn.sd_layout.leftSpaceToView(_companyAddressLabel, Width_Real(13)).topSpaceToView(_companyPhoneNumberBtn, Height_Real(15)).heightIs(Height_Real(18)).widthIs(Width_Real(28));
}



- (void)showbigPicture:(UITapGestureRecognizer *)tap{
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
    NSMutableArray * images = [NSMutableArray array];
    NSMutableArray * miniImages = [NSMutableArray array];
    if (_companyImage.tag == 1) {
        for (int i = 0; i < self.sccontentModel.imageList.count; i++) {
            RSImageListModel * imageModel = self.sccontentModel.imageList[i];
            [images addObject:[NSString stringWithFormat:@"%@%@",url,imageModel.urlOrigin]];
            [miniImages addObject:[NSString stringWithFormat:@"%@%@",url,imageModel.url]];
        }
//        [images addObject:[NSString stringWithFormat:@"%@%@",url,self.sccontentModel.urlOrigin]];
//        [miniImages addObject:[NSString stringWithFormat:@"%@%@",url,self.sccontentModel.url]];
        [XLPhotoBrowser showPhotoBrowserWithImages:images andMiniImage:miniImages currentImageIndex:0];
    }else{
        [images addObject:[NSString stringWithFormat:@"%@%@",url,self.ownerStoneModel.stoneImageUrl]];
        [HUPhotoBrowser showFromImageView:_companyImage withURLStrings:images atIndex:0];
    }
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
