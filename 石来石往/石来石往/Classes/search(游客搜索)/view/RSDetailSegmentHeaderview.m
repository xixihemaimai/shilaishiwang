//
//  RSDetailSegmentHeaderview.m
//  石来石往
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDetailSegmentHeaderview.h"
#import <UIImageView+WebCache.h>
@interface RSDetailSegmentHeaderview ()

@property (nonatomic,strong)NSArray * detailImageUrl;

@end



@implementation RSDetailSegmentHeaderview

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        UIView * midContentview = [[UIView alloc]init];
        midContentview.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:midContentview];
        
        
        midContentview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 10);
        
        
        
        UIImageView * imageview = [[UIImageView alloc]init];
        imageview.userInteractionEnabled = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.clipsToBounds = YES;
        
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailCompanyPicture:)];
//        [imageview addGestureRecognizer:tap];
        
        [midContentview addSubview:imageview];
        _imageview = imageview;
        
        
        imageview.sd_layout
        .leftSpaceToView(midContentview, 12)
        .topSpaceToView(midContentview, 15)
        .bottomSpaceToView(midContentview, 15)
        .widthIs(115);
        
        
        imageview.layer.cornerRadius = 6;
        imageview.layer.masksToBounds = YES;
        
        UILabel * productLabel = [[UILabel alloc]init];
        
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productLabel.font = [UIFont systemFontOfSize:16];
        [midContentview addSubview:productLabel];
        _productLabel = productLabel;
        
        productLabel.sd_layout
        .leftSpaceToView(imageview, 10)
        .rightSpaceToView(midContentview, 12)
        .topEqualToView(imageview)
        .heightIs(15);
        
        
        UILabel * keLabel = [[UILabel alloc]init];
        keLabel.textAlignment = NSTextAlignmentLeft;
        keLabel.font = [UIFont systemFontOfSize:14];
        keLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [midContentview addSubview:keLabel];
        _keLabel = keLabel;
        
        
        keLabel.sd_layout
        .leftEqualToView(productLabel)
        .topSpaceToView(productLabel, 5)
        .widthIs(40)
        .heightIs(15);
        
        
        UILabel * tiLabel = [[UILabel alloc]init];
        tiLabel.textAlignment = NSTextAlignmentLeft;
        tiLabel.font = [UIFont systemFontOfSize:14];
        tiLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [midContentview addSubview:tiLabel];
        _tiLabel = tiLabel;
        
        tiLabel.sd_layout
        .leftSpaceToView(keLabel, 0)
        .topEqualToView(keLabel)
        .bottomEqualToView(keLabel)
        .widthIs(80);
        
        
        UILabel * weightLabel = [[UILabel alloc]init];
        
        weightLabel.textAlignment = NSTextAlignmentLeft;
        weightLabel.font = [UIFont systemFontOfSize:14];
        weightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [midContentview addSubview:weightLabel];
        _weightLabel = weightLabel;
        weightLabel.sd_layout
        .leftSpaceToView(tiLabel, 0)
        .topEqualToView(tiLabel)
        .bottomEqualToView(tiLabel)
        .rightSpaceToView(midContentview, 2);
        
        
        UILabel * companyLabel = [[UILabel alloc]init];
        
        companyLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        
        
        companyLabel.textAlignment = NSTextAlignmentLeft;
        companyLabel.font = [UIFont systemFontOfSize:14];
        [midContentview addSubview:companyLabel];
        _companyLabel = companyLabel;
        
        companyLabel.sd_layout
        .leftEqualToView(keLabel)
        .topSpaceToView(keLabel, 5)
        .widthIs(SCW - 115 - 12 - 10 - 40 - 5)
        .heightIs(15);
        
        
        
        
        UILabel * phoneLabel = [[UILabel alloc]init];
        phoneLabel.text = @"电话:";
        phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        phoneLabel.font = [UIFont systemFontOfSize:14];
        [midContentview addSubview:phoneLabel];
        
        
        phoneLabel.sd_layout
        .leftEqualToView(companyLabel)
        .topSpaceToView(companyLabel, 5)
        .bottomEqualToView(imageview)
        .widthIs(40);
        
        
        UILabel * numberPhoneLabel = [[UILabel alloc]init];
        numberPhoneLabel.textAlignment = NSTextAlignmentLeft;
        
        numberPhoneLabel.font = [UIFont systemFontOfSize:14];
        numberPhoneLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [midContentview addSubview:numberPhoneLabel];
        _numberPhoneLabel = numberPhoneLabel;
        
        numberPhoneLabel.sd_layout
        .leftSpaceToView(phoneLabel, 0)
        .topEqualToView(phoneLabel)
        .bottomEqualToView(phoneLabel)
        .widthRatioToView(midContentview, 0.3);
        
        
        UIButton * playPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [playPhoneBtn setImage:[UIImage imageNamed:@"打电话"] forState:UIControlStateNormal];
        [midContentview addSubview:playPhoneBtn];
        _playPhoneBtn = playPhoneBtn;
        
        playPhoneBtn.sd_layout
        .topEqualToView(companyLabel)
        .rightSpaceToView(midContentview, 12)
        .heightIs(32)
        .widthIs(32);
        
        
    }
    return self;
}




- (void)setCompanyAndStoneModel:(RSCompanyAndStoneModel *)companyAndStoneModel{
    
    _companyAndStoneModel = companyAndStoneModel;
    //URL_HEADER_IMAGEURL_IOS URL_HEADER_IMG
   // _detailImageUrl = companyAndStoneModel.imgUrl;
    
    
    
    
//    if (companyAndStoneModel.imgUrl.count > 0) {
//        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
//        
//        NSString * img = [companyAndStoneModel.imgUrl objectAtIndex:0];
//        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
//            
//            img=[img stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//            [NSCharacterSet URLQueryAllowedCharacterSet];
//            
//            
//        }else{
//            img=[img stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        }
//         [_imageview sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"默认图灰"]];
//        
//    }else{
//        _imageview.image = [UIImage imageNamed:@"默认图灰"];
//    }
//    
//   // _weightLabel.text = [NSString stringWithFormat:@"重量:%@吨",companyAndStoneModel.stoneWeight];
//    
//    
//    _companyLabel.text = [NSString stringWithFormat:@"%@",companyAndStoneModel.companyName];
//    
//    _productLabel.text = [NSString stringWithFormat:@"%@",companyAndStoneModel.stoneName];
//    _numberPhoneLabel.text = [NSString stringWithFormat:@"%@",companyAndStoneModel.phone];
    
    
    
}


@end
