//
//  RSOrderDetailsCell.m
//  石来石往
//
//  Created by mac on 2017/9/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSOrderDetailsCell.h"

@implementation RSOrderDetailsCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        /*
        //图片
        UIImageView * imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@"img_outstore_history"];
        [self.contentView addSubview:imageview];
        */
        //出库订单
        UILabel * chuLabel = [[UILabel alloc]init];
        chuLabel.text = @"出库订单:";
        chuLabel.textColor = [UIColor blackColor];
        chuLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:chuLabel];
        
        
        //出库订单的详情
        UILabel * detailLibraryLabel = [[UILabel alloc]init];
        _detailLibraryLabel = detailLibraryLabel;
        // detailLibraryLabel.text = @"11111111111111";
        detailLibraryLabel.font = [UIFont systemFontOfSize:14];
        detailLibraryLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:detailLibraryLabel];
        
        
        //下单时间
        UILabel * xiaLabel = [[UILabel alloc]init];
        xiaLabel.text = @"下单时间:";
        xiaLabel.textColor = [UIColor blackColor];
        xiaLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:xiaLabel];
        
        
        
        //下单时间的详情
        UILabel * detailDateLabel = [[UILabel alloc]init];
        _detailDateLabel = detailDateLabel;
        // detailDateLabel.text = @"2017-10-10 20:11:11";
        detailDateLabel.font = [UIFont systemFontOfSize:14];
        detailDateLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:detailDateLabel];
        
        
        
        
        
        
        
        //状态的详情label
        UILabel * zhuaLabel = [[UILabel alloc]init];
        zhuaLabel.text = @"订单状态:";
        zhuaLabel.textColor = [UIColor blackColor];
        zhuaLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:zhuaLabel];
        
        
        
        
        
        
        
        UILabel * detailStatusLabel = [[UILabel alloc]init];
        _detailStatusLabel = detailStatusLabel;
        //detailStatusLabel.text = @"处理中";
        detailStatusLabel.textColor = [UIColor greenColor];
        detailStatusLabel.font = [UIFont systemFontOfSize:14];
        detailStatusLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:detailStatusLabel];
        
        
        
        UILabel * carLabel = [[UILabel alloc]init];
        carLabel.text = @"汽车类型:";
        carLabel.textColor = [UIColor blackColor];
        carLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:carLabel];
        
        
        UILabel * carTypeLabel = [[UILabel alloc]init];
        carTypeLabel.textColor = [UIColor blackColor];
        carTypeLabel.font = [UIFont systemFontOfSize:14];
        carTypeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:carTypeLabel];
        _carTypeLabel = carTypeLabel;
//        UIView * bottomview = [[UIView alloc]init];
//        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eeeeee"];
//        [self.contentView addSubview:bottomview];
        
        
        
        /*
        imageview.sd_layout
        .topSpaceToView(self.contentView,11)
        .leftSpaceToView(self.contentView,12)
        .widthIs(17)
        .heightIs(17);
        
        */
        chuLabel.sd_layout
        .leftSpaceToView(self.contentView,12)
        .topSpaceToView(self.contentView, 11)
        .heightIs(13)
        .widthIs(70);
        
        
        detailLibraryLabel.sd_layout
        .leftSpaceToView(chuLabel,5)
        .topEqualToView(chuLabel)
        .bottomEqualToView(chuLabel)
        .widthIs(180);
        
        
        xiaLabel.sd_layout
        .topSpaceToView(chuLabel,11)
        .heightIs(13)
        .widthIs(70)
        .leftEqualToView(chuLabel);
        
        
        detailDateLabel.sd_layout
        .leftSpaceToView(xiaLabel,5)
        .topEqualToView(xiaLabel)
        .bottomEqualToView(xiaLabel)
        .widthIs(180);
        
        
        
        zhuaLabel.sd_layout
        .leftEqualToView(xiaLabel)
        .topSpaceToView(xiaLabel, 11)
        .heightIs(13)
        .widthIs(70);
        
        
        
        detailStatusLabel.sd_layout
        .leftEqualToView(detailDateLabel)
        .topEqualToView(zhuaLabel)
        .bottomEqualToView(zhuaLabel)
        .widthIs(60);
        
        
        carLabel.sd_layout
        .leftEqualToView(zhuaLabel)
        .topSpaceToView(zhuaLabel, 11)
        .heightIs(13)
        .widthIs(70);
        
        carTypeLabel.sd_layout
        .leftEqualToView(detailStatusLabel)
        .topEqualToView(carLabel)
        .bottomEqualToView(carLabel)
        .rightSpaceToView(self.contentView, 12);
        
        
//        bottomview.sd_layout
//        .leftSpaceToView(self.contentView,12)
//        .rightSpaceToView(self.contentView,12)
//        .bottomSpaceToView(self.contentView,0)
//        .heightIs(1);
        
        
        
        
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
