//
//  RSCargoEngineeringCaseCell.m
//  石来石往
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCargoEngineeringCaseCell.h"

@implementation RSCargoEngineeringCaseCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        UIImageView * enginerrImage = [[UIImageView alloc]init];
        enginerrImage.image = [UIImage imageNamed:@"1080-675"];
      //  enginerrImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:enginerrImage];
        _enginerrImage = enginerrImage;
        enginerrImage.contentMode = UIViewContentModeScaleAspectFill;
        enginerrImage.clipsToBounds=YES;
        
        UIView * nextView = [[UIView alloc]init];
        nextView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:nextView];
        
        
        UILabel * enginerrLabel = [[UILabel alloc]init];
        enginerrLabel.numberOfLines = 0;
        enginerrLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        enginerrLabel.font = [UIFont systemFontOfSize:18];
        enginerrLabel.text = @"轻奢家装";
        enginerrLabel.textAlignment = NSTextAlignmentLeft;
        [nextView addSubview:enginerrLabel];
        _enginerrLabel = enginerrLabel;
        
        RSSFLabel * productLabel = [[RSSFLabel alloc]init];
        productLabel.numberOfLines = 0;
        productLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        productLabel.font = [UIFont systemFontOfSize:14];
        productLabel.textAlignment = NSTextAlignmentLeft;
        productLabel.text = @"石材天然、高贵、奢华，可以有造型和线条，甚至光度都可以控制……";
        [nextView addSubview:productLabel];
        _productLabel = productLabel;
        
        enginerrImage.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .heightIs(175);
        
        enginerrImage.layer.cornerRadius = 6;
        enginerrImage.layer.masksToBounds = YES;
        
        
        nextView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(enginerrImage, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        
        
        enginerrLabel.sd_layout
        .leftSpaceToView(nextView, 12)
        .rightSpaceToView(nextView, 12)
        .topSpaceToView(nextView, 12)
        .heightIs(17);
        
        
        
        
        
        productLabel.sd_layout
        .leftSpaceToView(nextView, 12)
        .rightSpaceToView(nextView, 12)
        .topSpaceToView(enginerrLabel, 4)
        .bottomSpaceToView(nextView, 0);
        
        
        
        
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
