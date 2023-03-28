//
//  RSPersonServiceCell.m
//  石来石往
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPersonServiceCell.h"

@implementation RSPersonServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        
        //每个cell
        UIView * personlServiceAllView = [[UIView alloc]init];
        personlServiceAllView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        [self.contentView addSubview:personlServiceAllView];
        
        //cell的里面的内容了
        UIView * personlServiceContentView = [[UIView alloc]init];
        personlServiceContentView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [personlServiceAllView addSubview:personlServiceContentView];
        
        
        //服务类型图片
        UIImageView * personlServiceImageView = [[UIImageView alloc]init];
       // personlServiceImageView.image = [UIImage imageNamed:@"出库服务"];
        [personlServiceContentView addSubview:personlServiceImageView];
        _personlServiceImageView = personlServiceImageView;
        
        //服务类型
        UILabel * personlServiceLabel = [[UILabel alloc]init];
        personlServiceLabel.font = [UIFont systemFontOfSize:15];
       // personlServiceLabel.text = @"出库服务";
        personlServiceLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        personlServiceLabel.textAlignment = NSTextAlignmentLeft;
        [personlServiceContentView addSubview:personlServiceLabel];
        _personlServiceLabel = personlServiceLabel;
        
        
        
        
        //服务人员商户
        UILabel * personlServiceNameLabel = [[UILabel alloc]init];
        personlServiceNameLabel.font = [UIFont systemFontOfSize:15];
        personlServiceNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        personlServiceNameLabel.textAlignment = NSTextAlignmentLeft;
        [personlServiceContentView addSubview:personlServiceNameLabel];
        _personlServiceNameLabel = personlServiceNameLabel;
        
        
        
        
        
        //出库单号
        UILabel * personlServiceOutLabel = [[UILabel alloc]init];
        personlServiceOutLabel.font = [UIFont systemFontOfSize:15];
        personlServiceOutLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        personlServiceOutLabel.textAlignment = NSTextAlignmentLeft;
        [personlServiceContentView addSubview:personlServiceOutLabel];
        _personlServiceOutLabel = personlServiceOutLabel;
        

        
        
        //预约时间
        UILabel * personlServiceTimeLabel = [[UILabel alloc]init];
        //personlServiceTimeLabel.text = @"预约时间：2016-05-06 16:05:05";
        personlServiceTimeLabel.font = [UIFont systemFontOfSize:15];
        personlServiceTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        personlServiceTimeLabel.textAlignment = NSTextAlignmentLeft;
        [personlServiceContentView addSubview:personlServiceTimeLabel];
        _personlServiceTimeLabel = personlServiceTimeLabel;
       
        
        
        //服务处理类型
        UIButton * myServiceBtn = [[UIButton alloc]init];
        myServiceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [personlServiceContentView addSubview:myServiceBtn];
        _myServiceBtn = myServiceBtn;
        myServiceBtn.enabled = NO;
        
        
        //上面和下面的分隔的view
        UIView * personlServiceSeparateView = [[UIView alloc]init];
        
        personlServiceSeparateView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [personlServiceContentView addSubview:personlServiceSeparateView];
        
        //下面的view显示的内容 订单详情
        UIButton * personlServiceModifyServiceBtn = [[UIButton alloc]init];
        [personlServiceModifyServiceBtn setTitle:@"服务详情" forState:UIControlStateNormal];
        [personlServiceModifyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        personlServiceModifyServiceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [personlServiceModifyServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [personlServiceContentView addSubview:personlServiceModifyServiceBtn];
        
        _personlServiceModifyServiceBtn = personlServiceModifyServiceBtn;
        
        
        //上传图片
        UIButton * personlUploadPictureBtn = [[UIButton alloc]init];
        [personlUploadPictureBtn setTitle:@"上传图片" forState:UIControlStateNormal];
        [personlUploadPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        personlUploadPictureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [personlUploadPictureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [personlServiceContentView addSubview:personlUploadPictureBtn];
        _personlUploadPictureBtn = personlUploadPictureBtn;
        
        
        //下面的view显示的内容 发起服务
        UIButton * personlServiceStartServiceBtn = [[UIButton alloc]init];
        [personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        personlServiceStartServiceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [personlServiceStartServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [personlServiceContentView addSubview:personlServiceStartServiceBtn];
        _personlServiceStartServiceBtn = personlServiceStartServiceBtn;
        
        
        //俩个按键中间的view
        UIView * personlserviceMidView = [[UIView alloc]init];
        personlserviceMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [personlServiceContentView addSubview:personlserviceMidView];
        
        
        //第二个按键和第三个按键的分隔view
        UIView * personlSecondMidView = [[UIView alloc]init];
        personlSecondMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [personlServiceContentView addSubview:personlSecondMidView];
        
        
        
        personlServiceAllView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        personlServiceContentView.sd_layout
        .leftSpaceToView(personlServiceAllView, 12)
        .topSpaceToView(personlServiceAllView, 12)
        .rightSpaceToView(personlServiceAllView, 12)
        .bottomSpaceToView(personlServiceAllView, 0);
        
        
        personlServiceContentView.layer.cornerRadius = 6;
        personlServiceContentView.layer.masksToBounds = YES;
        
        personlServiceImageView.sd_layout
        .leftSpaceToView(personlServiceContentView, 15)
        .topSpaceToView(personlServiceContentView, 10)
        .widthIs(30)
        .heightIs(30);
        
        
        personlServiceLabel.sd_layout
        .leftSpaceToView(personlServiceImageView, 10)
        .topSpaceToView(personlServiceContentView, 20)
        .widthRatioToView(personlServiceContentView, 0.6)
        .heightIs(15);
        
        
        personlServiceNameLabel.sd_layout
        .leftEqualToView(personlServiceImageView)
        .rightSpaceToView(personlServiceContentView, 12)
        .topSpaceToView(personlServiceLabel, 10)
        .heightIs(15);
        
        
        
        personlServiceOutLabel.sd_layout
        .leftEqualToView(personlServiceNameLabel)
        .rightEqualToView(personlServiceNameLabel)
        .topSpaceToView(personlServiceNameLabel, 10)
        .heightIs(15);
        
        personlServiceTimeLabel.sd_layout
        .leftEqualToView(personlServiceOutLabel)
        .rightEqualToView(personlServiceOutLabel)
        .topSpaceToView(personlServiceOutLabel, 10)
        .heightIs(15);
        
        
        
        personlServiceSeparateView.sd_layout
        .leftSpaceToView(personlServiceContentView, 0)
        .rightSpaceToView(personlServiceContentView, 0)
        .topSpaceToView(personlServiceTimeLabel, 10)
        .heightIs(1);
        
        personlServiceModifyServiceBtn.sd_layout
        .leftSpaceToView(personlServiceContentView, 0)
        .topSpaceToView(personlServiceSeparateView, 0)
        .widthIs(((SCW - 24)/3) - 1)
        .bottomSpaceToView(personlServiceContentView, 0);
        
        
        
        personlserviceMidView.sd_layout
        .leftSpaceToView(personlServiceModifyServiceBtn, 0)
        .topEqualToView(personlServiceModifyServiceBtn)
        .bottomEqualToView(personlServiceModifyServiceBtn)
        .widthIs(1);
        
        
        personlUploadPictureBtn.sd_layout
        .leftSpaceToView(personlserviceMidView, 0)
        .topEqualToView(personlserviceMidView)
        .bottomEqualToView(personlserviceMidView)
        .widthIs((SCW - 24)/3 - 1);
        
        
        
        personlSecondMidView.sd_layout
        .leftSpaceToView(personlUploadPictureBtn, 0)
        .topEqualToView(personlUploadPictureBtn)
        .bottomEqualToView(personlUploadPictureBtn)
        .widthIs(1);
        
        
        
        
        personlServiceStartServiceBtn.sd_layout
        .leftSpaceToView(personlSecondMidView, 0)
        .topEqualToView(personlSecondMidView)
        .bottomEqualToView(personlSecondMidView)
        .rightSpaceToView(personlServiceContentView, 0);
        
        
        myServiceBtn.sd_layout
        .rightSpaceToView(personlServiceContentView, 0)
        .topSpaceToView(personlServiceContentView, 10)
        .heightIs(25)
        .widthIs(75);
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:myServiceBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = myServiceBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        myServiceBtn.layer.mask = maskLayer;
        
        
  
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
