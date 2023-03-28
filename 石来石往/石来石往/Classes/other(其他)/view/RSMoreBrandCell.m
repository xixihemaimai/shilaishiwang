//
//  RSMoreBrandCell.m
//  石来石往
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSMoreBrandCell.h"

@implementation RSMoreBrandCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UIImageView * contentImage = [[UIImageView alloc]init];
        contentImage.contentMode = UIViewContentModeScaleAspectFill;
        contentImage.clipsToBounds = YES;
        [self.contentView addSubview:contentImage];
        _contentImage = contentImage;
        contentImage.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0);
        
        contentImage.layer.borderColor = [UIColor colorWithHexColorStr:@"#f5f5f5"].CGColor;
        contentImage.layer.borderWidth = 1;
        
    }
    return self;
}




@end
