//
//  RSSegmentCell.m
//  石来石往
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSSegmentCell.h"

#import <UIImageView+WebCache.h>
#import <HUPhotoBrowser.h>

@interface RSSegmentCell ()


@property (nonatomic,strong)NSArray * tempImageURL;

@end



@implementation RSSegmentCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView * imageview = [[UIImageView alloc]init];
        imageview.layer.borderWidth = 1;
        imageview.layer.borderColor = [UIColor colorWithHexColorStr:@"#e3e3e3"].CGColor;
        [self.contentView addSubview:imageview];
        imageview.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showCompanyPicture:)];
        [imageview addGestureRecognizer:tap];
        
        
        _imageview = imageview;
        
        imageview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .bottomSpaceToView(self.contentView, 10)
        .widthIs(60);
        
        
        imageview.layer.cornerRadius = 10;
        imageview.layer.masksToBounds = YES;
        
        /**产品*/
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:nameLabel];
        
        nameLabel.sd_layout
        .leftSpaceToView(imageview, 10)
        .topEqualToView(imageview)
        .heightIs(23)
        .rightSpaceToView(self.contentView, 12);
        _nameLabel = nameLabel;
        
        
        /**颗*/
        UILabel * keLabel = [[UILabel alloc]init];
        keLabel.font = [UIFont systemFontOfSize:12];
        keLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self.contentView addSubview:keLabel];
       // keLabel.textAlignment = NSTextAlignmentLeft;
        
        keLabel.sd_layout
        .leftEqualToView(nameLabel)
        .topSpaceToView(nameLabel, 0)
        .bottomEqualToView(imageview)
//        .widthRatioToView(self.contentView, (SCW - CGRectGetMaxX(imageview.frame) * 0.3));
        .widthIs((SCW - 12-46-10)/3);
        _keLabel = keLabel;
        
        /**体积*/
        UILabel * tiLabel = [[UILabel alloc]init];
        tiLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        tiLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:tiLabel];
       // tiLabel.textAlignment = NSTextAlignmentCenter;
        
        tiLabel.sd_layout
        .leftSpaceToView(keLabel, 0)
        .topEqualToView(keLabel)
        .bottomEqualToView(keLabel)
//        .widthRatioToView(self.contentView, (SCW - CGRectGetMaxX(imageview.frame) * 0.3));
        .widthIs((SCW - 12-46-10)/3);
        _tiLabel = tiLabel;
        
        /**重量*/
        UILabel * weightLabel = [[UILabel alloc]init];
        weightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        weightLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:weightLabel];
        //weightLabel.textAlignment = NSTextAlignmentRight;
        
        weightLabel.sd_layout
        .leftSpaceToView(tiLabel, 0)
        .topEqualToView(tiLabel)
        .bottomEqualToView(tiLabel)
        .rightSpaceToView(self.contentView, 12);
        _weightLabel = weightLabel;
        
        
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



- (void)setHuangAndDamodel:(RSHuangAndDaModel *)huangAndDamodel{
    
    _huangAndDamodel = huangAndDamodel;
    
    _tempImageURL = huangAndDamodel.imgUrl;
    
     _nameLabel.text = [NSString stringWithFormat:@"%@",_huangAndDamodel.stoneName];
    if (huangAndDamodel.imgUrl.count > 0) {
        
        
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
        
        NSString * img = [huangAndDamodel.imgUrl objectAtIndex:0];
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
            
            img=[img stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [NSCharacterSet URLQueryAllowedCharacterSet];
            
            
        }else{
            img=[img stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        
        //  [_imageview sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //}];
        //[NSURL URLWithString:[NSString stringWithFormat:@"http://www.86ps.com/imgWeb/psd/hf_fj/FJ_159.jpg"]]
        [_imageview sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"512"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }else{
        _imageview.image = [UIImage imageNamed:@"默认图灰"];
    }
}



- (void)showCompanyPicture:(UITapGestureRecognizer *)tap{
    [HUPhotoBrowser showFromImageView:self.imageView withURLStrings:_tempImageURL atIndex:0];
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
