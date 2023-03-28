//
//  RSSCContentCollectionCell.m
//  石来石往
//
//  Created by mac on 2021/10/26.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCContentCollectionCell.h"

@interface RSSCContentCollectionCell()

@property (nonatomic,strong)UIImageView * stoneImage;

@property (nonatomic,strong)UILabel * stoneName;

@property (nonatomic,strong)UILabel * stoneWarehouse;

@end


@implementation RSSCContentCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
//        CGFloat wight = (SCW - Width_Real(32) - Width_Real(16))/2;
//        CGFloat height = (wight * Height_Real(141))/Width_Real(165);
        
        UIImageView * stoneImage = [[UIImageView alloc]init];
//        stoneImage.image = [UIImage imageNamed:@"cover1"];
        stoneImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:stoneImage];
        
        stoneImage.userInteractionEnabled = true;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkStoneImage:)];
        [stoneImage addGestureRecognizer:tap];
        
        
//        stoneImage.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(Height_Real(141));
        
        stoneImage.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(141);
        
    
//        [stoneImage cutCircleDifferentImageWithBtn:stoneImage rect:CGRectMake(0, 0, self.contentView.frame.size.width, Height_Real(141)) width:self.contentView.frame.size.width radious:CGSizeMake(Width_Real(4), Width_Real(4)) corners:UIRectCornerTopLeft | UIRectCornerTopRight];
        
        [stoneImage cutCircleDifferentImageWithBtn:stoneImage rect:CGRectMake(0, 0, self.contentView.frame.size.width, 141) width:self.contentView.frame.size.width radious:CGSizeMake(4, 4) corners:UIRectCornerTopLeft | UIRectCornerTopRight];
        
        
        
        _stoneImage = stoneImage;
        
        
//        CGRect oldRect = stoneImage.bounds;
//        oldRect.size.width = self.contentView.frame.size.width;
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(Width_Real(4), Width_Real(4))];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.path = maskPath.CGPath;
//        maskLayer.frame = oldRect;
//        stoneImage.layer.mask = maskLayer;
        
        
        
        UILabel * stoneName = [[UILabel alloc]init];
        stoneName.text = @"石材品名";
        stoneName.font = [UIFont systemFontOfSize:Width_Real(15) weight:UIFontWeightMedium];
        stoneName.textAlignment = NSTextAlignmentLeft;
        stoneName.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:stoneName];
        
//        stoneName.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(stoneImage, Height_Real(8)).rightSpaceToView(self.contentView, 0).heightIs(Height_Real(23));
        
        stoneName.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(stoneImage, 8).rightSpaceToView(self.contentView, 0).heightIs(23);
        
        _stoneName = stoneName;
        
        UILabel * stoneWarehouse = [[UILabel alloc]init];
        stoneWarehouse.text = @"1区1架01";
        stoneWarehouse.font = [UIFont systemFontOfSize:Width_Real(12) weight:UIFontWeightRegular];
        stoneWarehouse.textAlignment = NSTextAlignmentLeft;
        stoneWarehouse.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self.contentView addSubview:stoneWarehouse];
        
        _stoneWarehouse = stoneWarehouse;
//        stoneWarehouse.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(stoneName, 0).rightSpaceToView(self.contentView, 0).heightIs(Height_Real(19));
        
        stoneWarehouse.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(stoneName, 0).rightSpaceToView(self.contentView, 0).heightIs(19);
        
        
        
    }
    return self;
}


- (void)setSccontentModel:(RSSCContentModel *)sccontentModel{
    _sccontentModel = sccontentModel;
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];

    
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",url,_sccontentModel.url]];
    
//    [_companyImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_sccontentModel.url]] placeholderImage:[UIImage imageNamed:@"01"]];
    
    [_stoneImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_sccontentModel.url]] placeholderImage:cacheImage];
    
    
//    [_stoneImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_sccontentModel.url]] placeholderImage:[UIImage imageNamed:@"cover1"]];
    
    
    

    _stoneName.text = _sccontentModel.stoneName;
    _stoneWarehouse.text = _sccontentModel.exhibitionLocation;
}


- (void)setIsExhibitionLocation:(BOOL)isExhibitionLocation{
    _isExhibitionLocation = isExhibitionLocation;
    
    if (!_isExhibitionLocation) {
        _stoneWarehouse.hidden = true;
        _stoneName.textAlignment = NSTextAlignmentCenter;
    }else{
        _stoneWarehouse.hidden = false;
        _stoneName.textAlignment = NSTextAlignmentLeft;
    }
}


- (void)checkStoneImage:(UITapGestureRecognizer *)tap{
    //这边要设置俩个数组
    NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
    NSMutableArray * images = [NSMutableArray array];
    NSMutableArray * miniImages = [NSMutableArray array];
    [images addObject:[NSString stringWithFormat:@"%@%@",url,_sccontentModel.urlOrigin]];
    [miniImages addObject:[NSString stringWithFormat:@"%@%@",url,_sccontentModel.url]];
    [XLPhotoBrowser showPhotoBrowserWithImages:images andMiniImage:miniImages currentImageIndex:0];
}


@end
