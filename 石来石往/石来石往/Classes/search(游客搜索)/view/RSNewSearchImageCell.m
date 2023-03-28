//
//  RSNewSearchImageCell.m
//  石来石往
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSNewSearchImageCell.h"

@interface RSNewSearchImageCell()

{
    
    UIImageView * _imageview;
    
    UILabel * _imageLabel;
}

@end

@implementation RSNewSearchImageCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView * imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@"03"];
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:imageview];
        _imageview = imageview;
        
        
        UILabel * imageLabel = [[UILabel alloc]init];
        imageLabel.text = @"白玉兰";
        imageLabel.contentMode = UIViewContentModeScaleAspectFill;
        imageLabel.clipsToBounds=YES;
        imageLabel.textAlignment = NSTextAlignmentCenter;
        imageLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        imageLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#333333"];
        imageLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:imageLabel];
        [imageLabel bringSubviewToFront:self];
        _imageLabel = imageLabel;
        
        
        imageview.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        
        imageLabel.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .heightIs(20);
        
        
        
    }
    return self;
}


- (void)setHotStoneModel:(RSHotStoneModel *)hotStoneModel{
    _hotStoneModel = hotStoneModel;
    
    _imageLabel.text = _hotStoneModel.stoneName;
    [_imageview sd_setImageWithURL:[NSURL URLWithString:_hotStoneModel.stoneImg] placeholderImage:[UIImage imageNamed:@"512"]];
    
}


@end
