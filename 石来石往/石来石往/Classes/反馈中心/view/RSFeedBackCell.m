//
//  RSFeedBackCell.m
//  石来石往
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSFeedBackCell.h"

@implementation RSFeedBackCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        //图片
        UIImageView * image = [[UIImageView alloc]init];
        [self.contentView addSubview:image];
        _image = image;
        //文字
        
        UILabel * feedStyleLabel = [[UILabel alloc]init];
        feedStyleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        feedStyleLabel.font = [UIFont systemFontOfSize:15];
        feedStyleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:feedStyleLabel];
        _feedStyleLabel = feedStyleLabel;
        
        //显示电话号码
        UILabel * feedPhoneLabel = [[UILabel alloc]init];
        feedPhoneLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        feedPhoneLabel.font = [UIFont systemFontOfSize:15];
        feedPhoneLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:feedPhoneLabel];
        _feedPhoneLabel = feedPhoneLabel;
        
        
        
        UIImageView * directionImage = [[UIImageView alloc]init];
        directionImage.image = [UIImage imageNamed:@"向右"];
        [self.contentView addSubview:directionImage];
        
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#ededed"];
        [self.contentView addSubview:bottomview];
        
        //反向图片
        //UIImageView * feedDirectionImage = [[UIImageView alloc]init];
        //feedDirectionImage.image = [UIImage imageNamed:@""];
        //[self.contentView addSubview:feedDirectionImage];
        
        image.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .widthIs(22)
        .heightEqualToWidth();
        
        
        feedStyleLabel.sd_layout
        .leftSpaceToView(image, 12)
        .centerYEqualToView(self.contentView)
        .topEqualToView(image)
        .bottomEqualToView(image)
        .widthRatioToView(self.contentView, 0.3);
        
        
        feedPhoneLabel.sd_layout
        .leftSpaceToView(feedStyleLabel, 20)
        .centerYEqualToView(self.contentView)
        .topEqualToView(feedStyleLabel)
        .bottomEqualToView(feedStyleLabel)
        .widthRatioToView(self.contentView, 0.4);
        
        
        
        directionImage.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 12)
        .widthIs(15)
        .heightEqualToWidth();
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
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
