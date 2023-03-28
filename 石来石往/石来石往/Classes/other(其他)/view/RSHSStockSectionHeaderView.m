//
//  RSHSStockSectionHeaderView.m
//  石来石往
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSHSStockSectionHeaderView.h"

@implementation RSHSStockSectionHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        UILabel * sectionHaederLabel = [[UILabel alloc]init];
        sectionHaederLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        sectionHaederLabel.textAlignment = NSTextAlignmentLeft;
        sectionHaederLabel.text = @"热门石种";
        UIFont * font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        sectionHaederLabel.font = font;
        [self addSubview:sectionHaederLabel];
        _sectionHaederLabel = sectionHaederLabel;
        UIButton * changeBtn = [[UIButton alloc]init];
        [changeBtn setImage:[UIImage imageNamed:@"矢量智能对象 拷贝 6"] forState:UIControlStateNormal];
        [changeBtn setTitle:@"换一换" forState:UIControlStateNormal];
        changeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        changeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [changeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#6A6A6A"] forState:UIControlStateNormal];
        [self addSubview:changeBtn];
        _changeBtn = changeBtn;
        sectionHaederLabel.sd_layout
        .leftSpaceToView(self, 12)
        .centerYEqualToView(self)
        .topSpaceToView(self,0)
        .bottomSpaceToView(self, 0)
        .widthRatioToView(self, 0.6);
        
        changeBtn.sd_layout
        .centerYEqualToView(self)
        .rightSpaceToView(self, 12)
        .widthIs(100)
        .heightIs(14);
        
        changeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        changeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
        
    }
    
    return self;
}




@end
