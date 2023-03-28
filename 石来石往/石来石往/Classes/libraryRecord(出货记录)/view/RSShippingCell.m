//
//  RSShippingCell.m
//  石来石往
//
//  Created by mac on 17/6/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSShippingCell.h"

@implementation RSShippingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //图片
        UIImageView * imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@"img_outstore_history"];
        [self.contentView addSubview:imageview];
        
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
        
        UILabel * detailStatusLabel = [[UILabel alloc]init];
        _detailStatusLabel = detailStatusLabel;
        //detailStatusLabel.text = @"处理中";
        detailStatusLabel.textColor = [UIColor greenColor];
        detailStatusLabel.font = [UIFont systemFontOfSize:14];
        detailStatusLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:detailStatusLabel];
        
        
        
        
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"撤销出库" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [self.contentView addSubview:cancelBtn];
        
        
        
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0];
        [self.contentView addSubview:bottomview];
        
        
        
        
        imageview.sd_layout
        .topSpaceToView(self.contentView,11)
        .leftSpaceToView(self.contentView,12)
        .widthIs(17)
        .heightIs(17);
        
        
        chuLabel.sd_layout
        .leftSpaceToView(imageview,12)
        .topEqualToView(imageview)
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
        
        
        detailStatusLabel.sd_layout
        .leftEqualToView(xiaLabel)
        .topSpaceToView(xiaLabel, 11)
        .widthIs(60)
        .heightIs(13);
        
        
        cancelBtn.sd_layout
        .leftSpaceToView(detailStatusLabel, 50)
        .topEqualToView(detailStatusLabel)
        .bottomSpaceToView(self.contentView, 5)
        .widthIs(70);
        
        cancelBtn.layer.cornerRadius = 5;
        cancelBtn.layer.borderWidth = 1;
        cancelBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#333333"].CGColor;
        cancelBtn.layer.masksToBounds = YES;
        _cancelBtn = cancelBtn;
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView,12)
        .rightSpaceToView(self.contentView,12)
        .bottomSpaceToView(self.contentView,0)
        .heightIs(1);
        
        
    }
    
    return self;
}



//- (void)setShipModel:(RSShipmentModel *)shipModel{
//    _shipModel = shipModel;
//    _detailLibraryLabel.text = [NSString stringWithFormat:@"%@",shipModel.outstoreId];
//    
//    
//    _detailDateLabel.text = [NSString stringWithFormat:@"%@",shipModel.outstoreDate];
//    
//   // _detailStatusLabel.text = [NSString stringWithFormat:@"%ld",shipModel.outstoreStatus];
//    
//    
//    
//    
//}




- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
