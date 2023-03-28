//
//  RSNewSearchFooterview.m
//  石来石往
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNewSearchFooterview.h"

@implementation RSNewSearchFooterview

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        
        
        UILabel * alertLabel = [[UILabel alloc]init];
        alertLabel.text = @"该列搜索内容没有数据";
        alertLabel.font = [UIFont systemFontOfSize:15];
        alertLabel.textAlignment = NSTextAlignmentCenter;
        alertLabel.textColor = [UIColor colorWithHexColorStr:@"#3385ff"];
        alertLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:alertLabel];
        _alertLabel = alertLabel;
        
        alertLabel.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .heightIs(0);
        
        
        UIView * footview = [[UIView alloc]init];
        footview.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:footview];
        
      //  [footview bringSubviewToFront:self.contentView];
        
        
        footview.sd_layout
        .leftSpaceToView(self.contentView, 0)
       // .topSpaceToView(self.contentView, 0)
        .topSpaceToView(alertLabel, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(30);
        
        UIButton * checkMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkMoreBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        //[checkMoreBtn setTitle:@"查看更多相关的荒料号" forState:UIControlStateNormal];
        checkMoreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        checkMoreBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        [checkMoreBtn setImage:[UIImage imageNamed:@"搜索2"] forState:UIControlStateNormal];
        checkMoreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
        [footview addSubview:checkMoreBtn];
        _checkMoreBtn = checkMoreBtn;
        
        
        checkMoreBtn.sd_layout
        .leftSpaceToView(footview, 12)
        .topSpaceToView(footview, 0)
        .bottomSpaceToView(footview, 0)
        .rightSpaceToView(footview, 12);
        
        
        
    }
    return self;
}

@end
