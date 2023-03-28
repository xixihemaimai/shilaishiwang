//
//  RSHSStockNewThirdCell.m
//  石来石往
//
//  Created by mac on 2019/1/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSHSStockNewThirdCell.h"

@implementation RSHSStockNewThirdCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
     
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor yellowColor];
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:imageView];
        _imageView = imageView;
    
        imageView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
    }
    return self;
}


@end
