//
//  RSServiceLibraryCell.m
//  石来石往
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServiceLibraryCell.h"

@implementation RSServiceLibraryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //最外层的view
        UIView * serviceLibraryView = [[UIView alloc]init];
        serviceLibraryView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        [self.contentView addSubview:serviceLibraryView];
        
        //里面的view
        UIView * serviceContentView = [[UIView alloc]init];
        serviceContentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [serviceLibraryView addSubview:serviceContentView];
        
        
        //里面的view的最左边的显示
        
        UIButton * serviceBtn = [[UIButton alloc]init];
        [serviceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FF3000"]];
        serviceBtn.enabled = NO;
        [serviceContentView addSubview:serviceBtn];
        
        
        //里面view出库单
        UILabel * serviceOutLabel = [[UILabel alloc]init];
      //  serviceOutLabel.text = [NSString stringWithFormat:@"出库单:%@",@"123456789056"];
        serviceOutLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        serviceOutLabel.font = [UIFont systemFontOfSize:15];
        serviceOutLabel.textAlignment = NSTextAlignmentLeft;
        [serviceContentView addSubview:serviceOutLabel];
        
        _serviceOutLabel = serviceOutLabel;
        //里面view出库的时间
        UILabel * serviceOutTimeLabel = [[UILabel alloc]init];
       // serviceOutTimeLabel.text = [NSString stringWithFormat:@"下单时间:%@",@"2016-10-01 19:19:19"];
        serviceOutTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        serviceOutTimeLabel.font = [UIFont systemFontOfSize:15];
        serviceOutTimeLabel.textAlignment = NSTextAlignmentLeft;
        [serviceContentView addSubview:serviceOutTimeLabel];
        _serviceOutTimeLabel = serviceOutTimeLabel;
        
//        //里面View出库的状态
//        UILabel * serviceOutStatusLabel = [[UILabel alloc]init];
//        serviceOutStatusLabel.text = [NSString stringWithFormat:@"订单状态:%@",@"审核完成"];
//        serviceOutStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
//        serviceOutStatusLabel.font = [UIFont systemFontOfSize:15];
//        serviceOutStatusLabel.textAlignment = NSTextAlignmentLeft;
//        [serviceContentView addSubview:serviceOutStatusLabel];
//        _serviceOutStatusLabel = serviceOutStatusLabel;
        
        
        //上面和下面的分隔的view
        UIView * serviceSeparateView = [[UIView alloc]init];
        serviceSeparateView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [serviceContentView addSubview:serviceSeparateView];
        
        //下面的view显示的内容 订单详情
        UIButton * serviceOrderDetailsBtn = [[UIButton alloc]init];
        [serviceOrderDetailsBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        [serviceOrderDetailsBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        serviceOrderDetailsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [serviceOrderDetailsBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [serviceContentView addSubview:serviceOrderDetailsBtn];
        _serviceOrderDetailsBtn = serviceOrderDetailsBtn;
        //下面的view显示的内容 发起服务
        UIButton * initiatingServiceBtn = [[UIButton alloc]init];
        [initiatingServiceBtn setTitle:@"发起服务" forState:UIControlStateNormal];
        [initiatingServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        initiatingServiceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [initiatingServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [serviceContentView addSubview:initiatingServiceBtn];
        _initiatingServiceBtn = initiatingServiceBtn;
        
        //俩个按键中间的view
        UIView * serviceMidView = [[UIView alloc]init];
        serviceMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [serviceContentView addSubview:serviceMidView];
        
        
        serviceLibraryView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        serviceContentView.sd_layout
        .leftSpaceToView(serviceLibraryView, 12)
        .rightSpaceToView(serviceLibraryView, 12)
        .topSpaceToView(serviceLibraryView, 10.5)
        .bottomSpaceToView(serviceLibraryView, 0);
        
        serviceContentView.layer.cornerRadius = 6;
        serviceContentView.layer.masksToBounds = YES;
        
        
        serviceBtn.sd_layout
        .leftSpaceToView(serviceContentView, 12)
        .topSpaceToView(serviceContentView,18)
        .widthIs(10)
        .heightIs(10);
        serviceBtn.layer.cornerRadius = serviceBtn.yj_width * 0.5;
        serviceBtn.layer.masksToBounds = YES;
        
        
        serviceOutLabel.sd_layout
        .leftSpaceToView(serviceBtn, 10)
        .rightSpaceToView(serviceContentView, 12)
        .topSpaceToView(serviceContentView, 16)
        .heightIs(14.5);
        
        
        serviceOutTimeLabel.sd_layout
        .leftEqualToView(serviceOutLabel)
        .rightEqualToView(serviceOutLabel)
        .topSpaceToView(serviceOutLabel, 10)
        .heightIs(14.5);
        
        
//        serviceOutStatusLabel.sd_layout
//        .leftEqualToView(serviceOutTimeLabel)
//        .rightEqualToView(serviceOutTimeLabel)
//        .topSpaceToView(serviceOutTimeLabel, 10)
//        .heightIs(14.5);
        
        
        serviceSeparateView.sd_layout
        .leftSpaceToView(serviceContentView, 0)
        .rightSpaceToView(serviceContentView, 0)
        .topSpaceToView(serviceOutTimeLabel, 10)
        .heightIs(1);
        
        
        serviceOrderDetailsBtn.sd_layout
        .leftSpaceToView(serviceContentView, 0)
        .topSpaceToView(serviceSeparateView, 0)
        .widthIs(((SCW - 24)/2) - 1)
        .bottomSpaceToView(serviceContentView, 0);
        
     
        
        serviceMidView.sd_layout
        .leftSpaceToView(serviceOrderDetailsBtn, 0)
        .topEqualToView(serviceOrderDetailsBtn)
        .bottomEqualToView(serviceOrderDetailsBtn)
        .widthIs(1);
        
        
    
        
        
        
        initiatingServiceBtn.sd_layout
        .leftSpaceToView(serviceMidView, 0)
        .topEqualToView(serviceMidView)
        .bottomEqualToView(serviceMidView)
        .rightSpaceToView(serviceContentView, 0);
    
        
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
