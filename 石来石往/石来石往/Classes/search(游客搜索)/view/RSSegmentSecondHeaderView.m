//
//  RSSegmentSecondHeaderView.m
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSegmentSecondHeaderView.h"
#import <UIImageView+WebCache.h>

#import <HUPhotoBrowser.h>

@interface RSSegmentSecondHeaderView ()

@property (nonatomic,strong)NSArray * secondHeaderTmepImageURL;

@end


@implementation RSSegmentSecondHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
      
        //self.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView * imageview = [[UIImageView alloc]init];
        imageview.layer.borderWidth = 1;
        imageview.layer.borderColor = [UIColor colorWithHexColorStr:@"#e3e3e3"].CGColor;
        [self.contentView addSubview:imageview];
        imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showHeaderImageUrl:)];
        [imageview addGestureRecognizer:tap];
        
        _imageview = imageview;
        imageview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .bottomSpaceToView(self.contentView, 10)
        .widthIs(60);
        
        UILabel * stoneLabel = [[UILabel alloc]init];
        stoneLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        stoneLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:stoneLabel];
        _stoneLabel = stoneLabel;
        
        
        stoneLabel.sd_layout
        .leftSpaceToView(imageview, 10)
        .topEqualToView(imageview)
        .heightIs(22.5)
        .rightSpaceToView(self.contentView, 12);
        
        
        
        UILabel * keLabel = [[UILabel alloc]init];
        keLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        keLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:keLabel];
        
        _keLabel = keLabel;
        
        keLabel.sd_layout
        .leftEqualToView(stoneLabel)
        .bottomEqualToView(imageview)
        .rightEqualToView(stoneLabel)
        .topSpaceToView(stoneLabel, 0);
        
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
        
        
    }
    return self;

}



- (void)showHeaderImageUrl:(UITapGestureRecognizer *)tap{
     [HUPhotoBrowser showFromImageView:self.imageview withURLStrings:_secondHeaderTmepImageURL atIndex:0];
}


- (void)setCompanyAndStoneModel:(RSCompanyAndStoneModel *)companyAndStoneModel{
    _companyAndStoneModel = companyAndStoneModel;
    
//    _secondHeaderTmepImageURL = companyAndStoneModel.imgUrl;
//    //URL_HEADER_IMAGEURL_IOS,
//    
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
//        
//        
//        
//        
//        
//        [self.imageview sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"默认图灰"]];
//    }else{
//        self.imageview.image = [UIImage imageNamed:@"默认图灰"];
//    }
//    
//   
//    self.stoneLabel.text = [NSString stringWithFormat:@"%@",companyAndStoneModel.stoneName];
 
}


@end
