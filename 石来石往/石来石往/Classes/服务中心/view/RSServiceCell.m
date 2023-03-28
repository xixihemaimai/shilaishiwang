//
//  RSServiceCell.m
//  石来石往
//
//  Created by mac on 2018/3/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServiceCell.h"

@implementation RSServiceCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //最外层的View
        UIView * waiView = [[UIView alloc]init];
        waiView.userInteractionEnabled = YES;
        waiView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:waiView];
        
        //里面的view
        UIView * neiView = [[UIView alloc]init];
        neiView.layer.cornerRadius = 10;
        neiView.userInteractionEnabled = YES;
        neiView.layer.masksToBounds = YES;
        neiView.backgroundColor = [UIColor colorWithHexColorStr:@"#F1EFF2"];
        [waiView addSubview:neiView];
        
        
        //里面的view的图片
        
        UIImageView * serviceImageview = [[UIImageView alloc]init];
        serviceImageview.userInteractionEnabled = YES;
        [neiView addSubview:serviceImageview];
        _serviceImageview = serviceImageview;
        //里面view的服务类型
        UILabel * serviceLabel = [[UILabel alloc]init];
        serviceLabel.textAlignment = NSTextAlignmentCenter;
        
        
       
        serviceLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [neiView addSubview:serviceLabel];
        serviceLabel.userInteractionEnabled = YES;
        serviceLabel.font = [UIFont systemFontOfSize:30];
        _serviceLabel = serviceLabel;
        //里面view的服务类型的介绍
        UILabel * serviceLabelIntroduct = [[UILabel alloc]init];
        serviceLabelIntroduct.textAlignment = NSTextAlignmentCenter;
        serviceLabelIntroduct.font = [UIFont systemFontOfSize:14];
        serviceLabelIntroduct.userInteractionEnabled = YES;
        serviceLabelIntroduct.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [neiView addSubview:serviceLabelIntroduct];
        _serviceLabelIntroduct = serviceLabelIntroduct;
        //里面view的方向
        UIImageView * serviceFangImageview = [[UIImageView alloc]init];
        serviceFangImageview.userInteractionEnabled = YES;
        serviceFangImageview.backgroundColor = [UIColor clearColor];
        serviceFangImageview.image = [UIImage imageNamed:@"icon_chose_arrow_nor"];
        [neiView addSubview:serviceFangImageview];
        
        
        
        waiView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        neiView.sd_layout
        .leftSpaceToView(waiView, 12)
        .rightSpaceToView(waiView, 12)
        .topSpaceToView(waiView, 9)
        .bottomSpaceToView(waiView, 0);
        
        
        
        
        
        
        serviceImageview.sd_layout
        .leftSpaceToView(neiView, 30)
        .centerYEqualToView(neiView)
        .heightIs(80)
        .widthIs(80);
        
        
        
        serviceFangImageview.sd_layout
        .rightSpaceToView(neiView, 12)
        .centerYEqualToView(neiView)
        .heightIs(14)
        .widthIs(14);
        
        
        if (iPhone5 || iPhone4) {
            
            serviceLabel.sd_layout
            .leftSpaceToView(serviceImageview, 10)
            .topSpaceToView(neiView, 27)
            .rightSpaceToView(serviceFangImageview, 10)
            .heightIs(30);
            
            
            serviceLabelIntroduct.sd_layout
            .leftSpaceToView(serviceImageview, 8)
            .topSpaceToView(serviceLabel, 8)
            .bottomSpaceToView(neiView, 30)
            .rightSpaceToView(serviceFangImageview, 5);
            
        }else{
            serviceLabel.sd_layout
            .leftSpaceToView(serviceImageview, 21)
            .topSpaceToView(neiView, 27)
            .rightSpaceToView(serviceFangImageview, 21)
            .heightIs(30);
            
            serviceLabelIntroduct.sd_layout
            .leftEqualToView(serviceLabel)
            .topSpaceToView(serviceLabel, 8)
            .bottomSpaceToView(neiView, 30)
            .rightSpaceToView(serviceFangImageview, 15);
            
        }
        
        
        
        
      

        
       
        
        
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
