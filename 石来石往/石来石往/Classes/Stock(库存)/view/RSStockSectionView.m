//
//  RSStockSectionView.m
//  石来石往
//
//  Created by mac on 17/5/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSStockSectionView.h"

@implementation RSStockSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageview = [[UIImageView alloc]init];
        [self addSubview:imageview];
        
        self.sectionImageview = imageview;
        imageview.sd_layout
        .leftSpaceToView(self,12)
        .topSpaceToView(self,7)
        .bottomSpaceToView(self,7)
        .widthRatioToView(self.contentView, 0.2);
        
        UIView *view = [[UIView alloc]init];
        _view = view;
        view.backgroundColor = [UIColor colorWithHexColorStr:@"#f3f3f3"];
        [self addSubview:view];
        view.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .bottomSpaceToView(self,0)
        .heightIs(1);
        
        
        
    }
    return self;
}


@end
