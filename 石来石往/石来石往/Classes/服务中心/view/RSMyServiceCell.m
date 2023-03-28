//
//  RSMyServiceCell.m
//  石来石往
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSMyServiceCell.h"

@implementation RSMyServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //每个cell
        UIView * allView = [[UIView alloc]init];
        allView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        [self.contentView addSubview:allView];
        
        //cell的里面的内容了
        UIView * myServiceContentView = [[UIView alloc]init];
        myServiceContentView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [allView addSubview:myServiceContentView];
        
        
        //服务类型图片
        UIImageView * myImageView = [[UIImageView alloc]init];
        [myServiceContentView addSubview:myImageView];
        _myImageView = myImageView;
        
        //服务类型
        UILabel * myServiceLabel = [[UILabel alloc]init];
        myServiceLabel.font = [UIFont systemFontOfSize:15];
        myServiceLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        myServiceLabel.textAlignment = NSTextAlignmentLeft;
        [myServiceContentView addSubview:myServiceLabel];
        _myServiceLabel = myServiceLabel;
        
        //出库单号
        UILabel * myServiceOutLabel = [[UILabel alloc]init];
        myServiceOutLabel.font = [UIFont systemFontOfSize:15];
        myServiceOutLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        myServiceOutLabel.textAlignment = NSTextAlignmentLeft;
        [myServiceContentView addSubview:myServiceOutLabel];
        _myServiceOutLabel = myServiceOutLabel;
        
        //预约时间
        UILabel * myServiceTimeLabel = [[UILabel alloc]init];
        myServiceTimeLabel.font = [UIFont systemFontOfSize:15];
        myServiceTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        myServiceTimeLabel.textAlignment = NSTextAlignmentLeft;
        [myServiceContentView addSubview:myServiceTimeLabel];
        _myServiceTimeLabel = myServiceTimeLabel;

        
        
        
        //服务处理类型
        UIButton * myServiceBtn = [[UIButton alloc]init];
        [myServiceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        myServiceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [myServiceContentView addSubview:myServiceBtn];
        _myServiceBtn = myServiceBtn;
        myServiceBtn.enabled = NO;
        
        
        //上面和下面的分隔的view
        UIView * myServiceSeparateView = [[UIView alloc]init];
        myServiceSeparateView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [myServiceContentView addSubview:myServiceSeparateView];
        
        
        
        
        //服务详情
        UIButton * myServiceDetailBtn = [[UIButton alloc]init];
        [myServiceDetailBtn setTitle:@"服务详情" forState:UIControlStateNormal];
        [myServiceDetailBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        myServiceDetailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [myServiceDetailBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [myServiceContentView addSubview:myServiceDetailBtn];
        _myServiceDetailBtn = myServiceDetailBtn;
        
        
        //下面的view显示的内容 订单详情
        UIButton * myModifyServiceBtn = [[UIButton alloc]init];
        [myModifyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        myModifyServiceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [myModifyServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [myServiceContentView addSubview:myModifyServiceBtn];
        _myModifyServiceBtn = myModifyServiceBtn;
        
        
        //下面的view显示的内容 发起服务
        UIButton * myCancelServiceBtn = [[UIButton alloc]init];
        myCancelServiceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [myServiceContentView addSubview:myCancelServiceBtn];
        _myCancelServiceBtn = myCancelServiceBtn;
        
        
        //三个按键1和2按键中间的view
        UIView * firstMidView = [[UIView alloc]init];
        firstMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [myServiceContentView addSubview:firstMidView];
        
        
        
        
        //三个按键2和3按键中间的view
        UIView * serviceMidView = [[UIView alloc]init];
        serviceMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [myServiceContentView addSubview:serviceMidView];
        
        
        
        
        allView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0);
        
        
        myServiceContentView.sd_layout
        .leftSpaceToView(allView, 12)
        .rightSpaceToView(allView, 12)
        .topSpaceToView(allView, 10)
        .bottomSpaceToView(allView, 0);
        
        myServiceContentView.layer.cornerRadius = 6;
        myServiceContentView.layer.masksToBounds = YES;
        
        
        
        myImageView.sd_layout
        .leftSpaceToView(myServiceContentView, 20)
        .topSpaceToView(myServiceContentView, 12)
        .widthIs(30)
        .heightIs(30);
        
        
        
        myServiceLabel.sd_layout
        .leftSpaceToView(myImageView, 10)
        .topSpaceToView(myServiceContentView, 21)
        .widthRatioToView(myServiceContentView, 0.3)
        .heightIs(15);
        
        
        
        myServiceOutLabel.sd_layout
        .leftEqualToView(myImageView)
        .topSpaceToView(myImageView, 12)
        .rightSpaceToView(myServiceContentView, 12)
        .heightIs(15);
        
        
        myServiceTimeLabel.sd_layout
        .leftEqualToView(myServiceOutLabel)
        .rightEqualToView(myServiceOutLabel)
        .topSpaceToView(myServiceOutLabel, 12)
        .heightIs(15);
        
        
//        myServiceNumberLabel.sd_layout
//        .leftEqualToView(myServiceTimeLabel)
//        .rightEqualToView(myServiceTimeLabel)
//        .topSpaceToView(myServiceTimeLabel, 15)
//        .heightIs(15);
        
        
        myServiceSeparateView.sd_layout
        .leftSpaceToView(myServiceContentView, 0)
        .rightSpaceToView(myServiceContentView, 0)
        //.topSpaceToView(myServiceNumberLabel, 13.5)
        .topSpaceToView(myServiceTimeLabel, 15)
        .heightIs(1);
        
        myServiceDetailBtn.sd_layout
        .leftSpaceToView(myServiceContentView, 0)
        .topSpaceToView(myServiceSeparateView, 0)
        .widthIs(((SCW - 24)/3) - 1)
        .bottomSpaceToView(myServiceContentView, 0);
        
        
        firstMidView.sd_layout
        .leftSpaceToView(myServiceDetailBtn, 0)
        .topEqualToView(myServiceDetailBtn)
        .bottomEqualToView(myServiceDetailBtn)
        .widthIs(1);
        
        
        
        
        
        myModifyServiceBtn.sd_layout
        .leftSpaceToView(firstMidView, 0)
        //.topSpaceToView(myServiceSeparateView, 0)
        .topEqualToView(firstMidView)
        .widthIs(((SCW - 24)/3) - 1)
        //.bottomSpaceToView(myServiceContentView, 0);
        .bottomEqualToView(firstMidView);
        
        
        
        serviceMidView.sd_layout
        .leftSpaceToView(myModifyServiceBtn, 0)
        .topEqualToView(myModifyServiceBtn)
        .bottomEqualToView(myModifyServiceBtn)
        .widthIs(1);
        
        
        
        
        
        myCancelServiceBtn.sd_layout
        .leftSpaceToView(serviceMidView, 0)
        .topEqualToView(serviceMidView)
        .bottomEqualToView(serviceMidView)
        .rightSpaceToView(myServiceContentView, 0);
        
        
        
        
        myServiceBtn.sd_layout
        .rightSpaceToView(myServiceContentView, 0)
        .topEqualToView(myServiceLabel)
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
