//
//  RSDispatchPersonlCell.m
//  石来石往
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSDispatchPersonlCell.h"

@implementation RSDispatchPersonlCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
     
        //每个cell
        UIView * allView = [[UIView alloc]init];
        allView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        [self.contentView addSubview:allView];
        
        //cell的里面的内容了
        UIView * dispatchPersonlContentView = [[UIView alloc]init];
        dispatchPersonlContentView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [allView addSubview:dispatchPersonlContentView];
        
        
        //服务类型图片
        UIImageView * dispatchPersonlImageView = [[UIImageView alloc]init];
        [dispatchPersonlContentView addSubview:dispatchPersonlImageView];
        _dispatchPersonlImageView = dispatchPersonlImageView;
        
        //服务类型
        UILabel * dispatchPersonlLabel = [[UILabel alloc]init];
        dispatchPersonlLabel.font = [UIFont systemFontOfSize:15];
        dispatchPersonlLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        dispatchPersonlLabel.textAlignment = NSTextAlignmentLeft;
        [dispatchPersonlContentView addSubview:dispatchPersonlLabel];
        _dispatchPersonlLabel = dispatchPersonlLabel;
        
        
        
        //商户
        UILabel * dispatchPersonlShowLabel = [[UILabel alloc]init];
        dispatchPersonlShowLabel.font = [UIFont systemFontOfSize:15];
        dispatchPersonlShowLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        dispatchPersonlShowLabel.textAlignment = NSTextAlignmentLeft;
        [dispatchPersonlContentView addSubview:dispatchPersonlShowLabel];
        _dispatchPersonlShowLabel = dispatchPersonlShowLabel;
        
        
        //出库单号
        UILabel * dispatchPersonlOutLabel = [[UILabel alloc]init];
        dispatchPersonlOutLabel.font = [UIFont systemFontOfSize:15];
        dispatchPersonlOutLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        dispatchPersonlOutLabel.textAlignment = NSTextAlignmentLeft;
        [dispatchPersonlContentView addSubview:dispatchPersonlOutLabel];
        _dispatchPersonlOutLabel = dispatchPersonlOutLabel;
        
        //预约时间
        UILabel * dispatchPersonlTimeLabel = [[UILabel alloc]init];
        dispatchPersonlTimeLabel.font = [UIFont systemFontOfSize:15];
        dispatchPersonlTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        dispatchPersonlTimeLabel.textAlignment = NSTextAlignmentLeft;
        [dispatchPersonlContentView addSubview:dispatchPersonlTimeLabel];
        _dispatchPersonlTimeLabel = dispatchPersonlTimeLabel;
        
        
        
        
        //服务处理类型
        UIButton * dispatchPersonlServiceBtn = [[UIButton alloc]init];
        [dispatchPersonlServiceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        dispatchPersonlServiceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [dispatchPersonlContentView addSubview:dispatchPersonlServiceBtn];
        
        dispatchPersonlServiceBtn.enabled = NO;
        _dispatchPersonlServiceBtn = dispatchPersonlServiceBtn;
        
        //上面和下面的分隔的view
        UIView * dispatchPersonlSeparateView = [[UIView alloc]init];
        dispatchPersonlSeparateView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [dispatchPersonlContentView addSubview:dispatchPersonlSeparateView];
        
        
        
        
        //服务详情
        UIButton * dispatchPersonlDetailBtn = [[UIButton alloc]init];
        //[dispatchPersonlDetailBtn setTitle:@"服务详情" forState:UIControlStateNormal];
      //  [dispatchPersonlDetailBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        dispatchPersonlDetailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     //   [dispatchPersonlDetailBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [dispatchPersonlContentView addSubview:dispatchPersonlDetailBtn];
        _dispatchPersonlDetailBtn = dispatchPersonlDetailBtn;
        
        
        //下面的view显示的内容 订单详情
        UIButton * dispatchPersonlmyServiceBtn = [[UIButton alloc]init];
       // [dispatchPersonlmyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
      //  [dispatchPersonlmyServiceBtn setTitle:@"派遣服务人员" forState:UIControlStateNormal];
        dispatchPersonlmyServiceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
      //  [dispatchPersonlmyServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [dispatchPersonlContentView addSubview:dispatchPersonlmyServiceBtn];
        _dispatchPersonlmyServiceBtn = dispatchPersonlmyServiceBtn;
        
        //三个按键1和2按键中间的view
        UIView * dispatchPersonlMidView = [[UIView alloc]init];
        dispatchPersonlMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [dispatchPersonlContentView addSubview:dispatchPersonlMidView];
        
        
        
        allView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0);
        
        
        dispatchPersonlContentView.sd_layout
        .leftSpaceToView(allView, 12)
        .rightSpaceToView(allView, 12)
        .topSpaceToView(allView, 10)
        .bottomSpaceToView(allView, 0);
        
        dispatchPersonlContentView.layer.cornerRadius = 6;
        dispatchPersonlContentView.layer.masksToBounds = YES;
        
        
        
        dispatchPersonlImageView.sd_layout
        .leftSpaceToView(dispatchPersonlContentView, 20)
        .topSpaceToView(dispatchPersonlContentView, 12)
        .widthIs(30)
        .heightIs(30);
        
        
        
        dispatchPersonlLabel.sd_layout
        .leftSpaceToView(dispatchPersonlImageView, 10)
        .topSpaceToView(dispatchPersonlContentView, 20)
        .widthRatioToView(dispatchPersonlContentView, 0.3)
        .heightIs(15);
        
        
        
        dispatchPersonlShowLabel.sd_layout
        .leftEqualToView(dispatchPersonlImageView)
        .topSpaceToView(dispatchPersonlImageView, 10)
        .rightSpaceToView(dispatchPersonlContentView, 12)
        .heightIs(15);
        
        
        dispatchPersonlOutLabel.sd_layout
        .leftEqualToView(dispatchPersonlShowLabel)
        .topSpaceToView(dispatchPersonlShowLabel, 10)
        .rightSpaceToView(dispatchPersonlContentView, 12)
        .heightIs(15);
        
        
        dispatchPersonlTimeLabel.sd_layout
        .leftEqualToView(dispatchPersonlOutLabel)
        .rightEqualToView(dispatchPersonlOutLabel)
        .topSpaceToView(dispatchPersonlOutLabel, 10)
        .heightIs(15);
        

        
        dispatchPersonlSeparateView.sd_layout
        .leftSpaceToView(dispatchPersonlContentView, 0)
        .rightSpaceToView(dispatchPersonlContentView, 0)
        .topSpaceToView(dispatchPersonlTimeLabel, 15)
        .heightIs(1);
        
        
        
        dispatchPersonlDetailBtn.sd_layout
        .leftSpaceToView(dispatchPersonlContentView, 0)
        .topSpaceToView(dispatchPersonlSeparateView, 0)
        .widthIs(((SCW - 24)/2))
        .bottomSpaceToView(dispatchPersonlContentView, 0);
        
        
        dispatchPersonlMidView.sd_layout
        .leftSpaceToView(dispatchPersonlDetailBtn, 0)
        .topEqualToView(dispatchPersonlDetailBtn)
        .bottomEqualToView(dispatchPersonlDetailBtn)
        .widthIs(1);
        
        dispatchPersonlmyServiceBtn.sd_layout
        .leftSpaceToView(dispatchPersonlMidView, 0)
        .topEqualToView(dispatchPersonlMidView)
        .rightSpaceToView(dispatchPersonlContentView, 0)
        .bottomEqualToView(dispatchPersonlMidView);
        
        dispatchPersonlServiceBtn.sd_layout
        .rightSpaceToView(dispatchPersonlContentView, 0)
        .topEqualToView(dispatchPersonlLabel)
        .heightIs(25)
        .widthIs(75);
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:dispatchPersonlServiceBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = dispatchPersonlServiceBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        dispatchPersonlServiceBtn.layer.mask = maskLayer;
        
        
        
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
