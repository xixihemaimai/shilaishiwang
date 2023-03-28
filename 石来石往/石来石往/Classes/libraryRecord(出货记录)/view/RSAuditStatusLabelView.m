//
//  RSAuditStatusLabelView.m
//  石来石往
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAuditStatusLabelView.h"

@interface RSAuditStatusLabelView()


@property (nonatomic,strong)UIImageView * titleImage;

@end


@implementation RSAuditStatusLabelView


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.layer.cornerRadius = 4;
        _titleLabel.text = @"审核中";
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        _titleLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ff943d"];
    }
    return _titleLabel;
}

- (UIImageView *)titleImage{
    if (!_titleImage) {
        _titleImage = [[UIImageView alloc]init];
        _titleImage.image = [UIImage imageNamed:@"向下1"];
        _titleImage.contentMode = UIViewContentModeScaleAspectFill;
        _titleImage.backgroundColor = [UIColor clearColor];
    }
    return _titleImage;
}



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self sd_addSubviews:@[self.titleLabel,self.titleImage]];
        self.titleLabel.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .heightIs(20);
        
        self.titleImage.sd_layout
        .centerXEqualToView(self)
        .topSpaceToView(self.titleLabel, -5)
        .heightIs(20)
        .widthIs(20);
    }
    return self;
}

@end
