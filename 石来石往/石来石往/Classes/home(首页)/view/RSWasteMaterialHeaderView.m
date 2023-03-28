//
//  RSWasteMaterialHeaderView.m
//  石来石往
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSWasteMaterialHeaderView.h"

@implementation RSWasteMaterialHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        //仓储位置的图片
        UIImageView * addressImageView = [[UIImageView alloc]init];
        addressImageView.image = [UIImage imageNamed:@"仓储位置"];
        addressImageView.contentMode = UIViewContentModeScaleAspectFill;
        addressImageView.clipsToBounds = YES;
        [self.contentView addSubview:addressImageView];
        
        
        //仓储位置的名称
        UILabel * addressLabel = [[UILabel alloc]init];
        addressLabel.textColor = [UIColor colorWithHexColorStr:@"#3385FF"];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.font = [UIFont systemFontOfSize:14];
        addressLabel.text = @"仓储位置";
        [self.contentView addSubview:addressLabel];
        
        
        //位置的信息
        UILabel * addressInformationLabel = [[UILabel alloc]init];
        addressInformationLabel.textColor = [UIColor colorWithHexColorStr:@"#3385FF"];
        addressInformationLabel.textAlignment = NSTextAlignmentRight;
        addressInformationLabel.font = [UIFont systemFontOfSize:14];
        addressInformationLabel.text = @"荒料1仓2区A01储位";
        [self.contentView addSubview:addressInformationLabel];
        _addressInformationLabel = addressInformationLabel;
        
      
        
        
        
        addressImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 9)
        .bottomSpaceToView(self.contentView, 9)
        .widthIs(12);
        
        addressLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(addressImageView, 4)
        .widthRatioToView(self.contentView, 0.2)
        .heightIs(14);
        
        
        addressInformationLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 13)
        .topSpaceToView(self.contentView, 11)
        .bottomSpaceToView(self.contentView, 10)
        .widthRatioToView(self.contentView, 0.6);
        
        
        
    }
    return self;
}

@end
