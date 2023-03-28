//
//  RSDetailsOfChargesFirstCell.m
//  石来石往
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSDetailsOfChargesFirstCell.h"

@implementation RSDetailsOfChargesFirstCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //类型
        UILabel * productLabel = [[UILabel alloc]init];
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        productLabel.font = [UIFont systemFontOfSize:14];
        productLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:productLabel];
        
        _productLabel = productLabel;
        //时间
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        timeLabel.font = [UIFont systemFontOfSize:12];
       // timeLabel.text = @"2018-1-10";
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
        
        //价钱
        UILabel * priceLabel = [[UILabel alloc]init];
        priceLabel.textColor = [UIColor colorWithHexColorStr:@"#FF0000"];
        priceLabel.font = [UIFont systemFontOfSize:16];
        //priceLabel.text = @"1344元";
        priceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:priceLabel];
        _priceLabel = priceLabel;
        
        //底下线
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
        
        
        
        productLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 11)
        .heightIs( 16)
        .widthRatioToView(self.contentView, 0.5);
        
        
        timeLabel.sd_layout
        .leftEqualToView(productLabel)
        .rightEqualToView(productLabel)
        .bottomSpaceToView(self.contentView, 12)
        .topSpaceToView(productLabel, 6);
        
        
        priceLabel.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 22)
        .bottomSpaceToView(self.contentView, 19)
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(productLabel, 10);
        
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
        
    }
    
    return self;
    
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
