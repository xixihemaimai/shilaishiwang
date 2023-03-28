//
//  RSFirstHeaderSectionView.m
//  石来石往
//
//  Created by mac on 17/5/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFirstHeaderSectionView.h"

@implementation RSFirstHeaderSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageview = [[UIImageView alloc]init];
        [self addSubview:imageview];
        
        self.imageview = imageview;
        imageview.sd_layout
        .leftSpaceToView(self,12)
        .topSpaceToView(self,7)
        .bottomSpaceToView(self, 7)
        .widthRatioToView(self.contentView, 0.2);
        
        UIButton * moreBtn = [[UIButton alloc]init];
        [moreBtn setTitle:@"更多>" forState:UIControlStateNormal];
        
        self.contentView.userInteractionEnabled = YES;
        
        [moreBtn addTarget:self action:@selector(jumpMoreViewController) forControlEvents:UIControlEventTouchUpInside];
        
        [moreBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:moreBtn];
        
        moreBtn.sd_layout
        .rightSpaceToView(self,12)
        .topEqualToView(imageview)
        .bottomEqualToView(imageview)
        .widthIs(50);
        
        
    }
    return self;
}
- (void)jumpMoreViewController{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"jumpMoreViewController" object:nil];
}

@end
