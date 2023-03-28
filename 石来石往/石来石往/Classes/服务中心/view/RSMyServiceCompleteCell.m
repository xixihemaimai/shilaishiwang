//
//  RSMyServiceCompleteCell.m
//  石来石往
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSMyServiceCompleteCell.h"

@implementation RSMyServiceCompleteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //每个cell
        UIView * allCompleteView = [[UIView alloc]init];
        allCompleteView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        [self.contentView addSubview:allCompleteView];
        
        //cell的里面的内容了
        UIView * myServiceContentCompleteView = [[UIView alloc]init];
        myServiceContentCompleteView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [allCompleteView addSubview:myServiceContentCompleteView];
        
        //服务类型图片
        UIImageView * myCompleteImageView = [[UIImageView alloc]init];
      //  myCompleteImageView.image = [UIImage imageNamed:@"出库服务"];
        [myServiceContentCompleteView addSubview:myCompleteImageView];
        _myCompleteImageView = myCompleteImageView;
        
        //服务类型
        UILabel * myServiceCompleteLabel = [[UILabel alloc]init];
        myServiceCompleteLabel.font = [UIFont systemFontOfSize:15];
        //myServiceCompleteLabel.text = @"出库服务";
        myServiceCompleteLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        myServiceCompleteLabel.textAlignment = NSTextAlignmentLeft;
        [myServiceContentCompleteView addSubview:myServiceCompleteLabel];
        _myServiceCompleteLabel = myServiceCompleteLabel;
        
        //出库单号
        UILabel * myServiceCompleteOutLabel = [[UILabel alloc]init];
      //  myServiceCompleteOutLabel.text = @"出库单：2545858";
        myServiceCompleteOutLabel.font = [UIFont systemFontOfSize:15];
        myServiceCompleteOutLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        myServiceCompleteOutLabel.textAlignment = NSTextAlignmentLeft;
        [myServiceContentCompleteView addSubview:myServiceCompleteOutLabel];
        _myServiceCompleteOutLabel = myServiceCompleteOutLabel;
        
        //预约时间
        UILabel * myServiceCompleteTimeLabel = [[UILabel alloc]init];
       // myServiceCompleteTimeLabel.text = @"预约时间：2016-05-06 16:05:05";
        myServiceCompleteTimeLabel.font = [UIFont systemFontOfSize:15];
        myServiceCompleteTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        myServiceCompleteTimeLabel.textAlignment = NSTextAlignmentLeft;
        [myServiceContentCompleteView addSubview:myServiceCompleteTimeLabel];
        _myServiceCompleteTimeLabel = myServiceCompleteTimeLabel;
        
//        //服务人员人数
//        UILabel * myServiceCompleteNumberLabel = [[UILabel alloc]init];
//        myServiceCompleteNumberLabel.text = @"服务人员：2号";
//        myServiceCompleteNumberLabel.font = [UIFont systemFontOfSize:15];
//        myServiceCompleteNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
//        myServiceCompleteNumberLabel.textAlignment = NSTextAlignmentLeft;
//        [myServiceContentCompleteView addSubview:myServiceCompleteNumberLabel];
        
//        //服务处理类型
//        UIButton * myServiceCompleteBtn = [[UIButton alloc]init];
//        [myServiceCompleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
//        myServiceCompleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [myServiceCompleteBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#696969"]];
//        [myServiceCompleteBtn setTitle:@"服务结束" forState:UIControlStateNormal];
//        [myServiceContentCompleteView addSubview:myServiceCompleteBtn];
//        myServiceCompleteBtn.enabled = NO;
        
        //上面和下面的分隔的view
        UIView * myServiceSeparateCompleteView = [[UIView alloc]init];
        myServiceSeparateCompleteView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [myServiceContentCompleteView addSubview:myServiceSeparateCompleteView];
        
        //服务详情
        UIButton * myServiceCompleteDetailBtn = [[UIButton alloc]init];
        [myServiceCompleteDetailBtn setTitle:@"服务详情" forState:UIControlStateNormal];
        [myServiceCompleteDetailBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        myServiceCompleteDetailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [myServiceCompleteDetailBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [myServiceContentCompleteView addSubview:myServiceCompleteDetailBtn];
        _myServiceCompleteDetailBtn = myServiceCompleteDetailBtn;
        
        //服务人员
        UIButton * myServicePeopleBtn = [[UIButton alloc]init];
        [myServicePeopleBtn setTitle:@"服务人员" forState:UIControlStateNormal];
        [myServicePeopleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        myServicePeopleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [myServicePeopleBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [myServiceContentCompleteView addSubview:myServicePeopleBtn];
        _myServicePeopleBtn = myServicePeopleBtn;

        //下面的view显示的内容 订单详情
        UIButton * myModifyCompleteServiceBtn = [[UIButton alloc]init];
        //[myModifyCompleteServiceBtn setTitle:@"服务评价" forState:UIControlStateNormal];
        [myModifyCompleteServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        myModifyCompleteServiceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [myModifyCompleteServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [myServiceContentCompleteView addSubview:myModifyCompleteServiceBtn];
        _myModifyCompleteServiceBtn = myModifyCompleteServiceBtn;
        
        //三个按键1和2按键中间的view
        UIView * firstMidView = [[UIView alloc]init];
        firstMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [myServiceContentCompleteView addSubview:firstMidView];
        
        //三个按键2和3按键中间的view
        UIView * serviceMidView = [[UIView alloc]init];
        serviceMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [myServiceContentCompleteView addSubview:serviceMidView];
        
        allCompleteView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0);
        
        
        myServiceContentCompleteView.sd_layout
        .leftSpaceToView(allCompleteView, 12)
        .rightSpaceToView(allCompleteView, 12)
        .topSpaceToView(allCompleteView, 10)
        .bottomSpaceToView(allCompleteView, 0);
        myServiceContentCompleteView.layer.cornerRadius = 6;
        myServiceContentCompleteView.layer.masksToBounds = YES;
        
        myCompleteImageView.sd_layout
        .leftSpaceToView(myServiceContentCompleteView, 20)
        .topSpaceToView(myServiceContentCompleteView, 12)
        .widthIs(30)
        .heightIs(30);
        
        myServiceCompleteLabel.sd_layout
        .leftSpaceToView(myCompleteImageView, 10)
        .topSpaceToView(myServiceContentCompleteView, 21)
        .widthRatioToView(myServiceContentCompleteView, 0.3)
        .heightIs(15);
        
        myServiceCompleteOutLabel.sd_layout
        .leftEqualToView(myCompleteImageView)
        .topSpaceToView(myCompleteImageView, 12)
        .rightSpaceToView(myServiceContentCompleteView, 12)
        .heightIs(15);
        
        myServiceCompleteTimeLabel.sd_layout
        .leftEqualToView(myServiceCompleteOutLabel)
        .rightEqualToView(myServiceCompleteOutLabel)
        .topSpaceToView(myServiceCompleteOutLabel, 12)
        .heightIs(15);
        
//        myServiceCompleteNumberLabel.sd_layout
//        .leftEqualToView(myServiceCompleteTimeLabel)
//        .rightEqualToView(myServiceCompleteTimeLabel)
//        .topSpaceToView(myServiceCompleteTimeLabel, 15)
//        .heightIs(15);
        
        myServiceSeparateCompleteView.sd_layout
        .leftSpaceToView(myServiceContentCompleteView, 0)
        .rightSpaceToView(myServiceContentCompleteView, 0)
      //  .topSpaceToView(myServiceCompleteNumberLabel, 13.5)
        .topSpaceToView(myServiceCompleteTimeLabel, 15)
        .heightIs(1);
        
//        myServiceCompleteBtn.sd_layout
//        .rightSpaceToView(myServiceContentCompleteView, 0)
//        .topEqualToView(myServiceCompleteLabel)
//        .heightIs(25)
//        .widthIs(75);
        
        //服务详情
        myServiceCompleteDetailBtn.sd_layout
        .leftSpaceToView(myServiceContentCompleteView, 0)
        .topSpaceToView(myServiceSeparateCompleteView, 0)
        .widthIs((SCW - 24)/3 - 1 )
        .bottomSpaceToView(myServiceContentCompleteView, 0);
        
        firstMidView.sd_layout
        .leftSpaceToView(myServiceCompleteDetailBtn, 0)
        .topEqualToView(myServiceCompleteDetailBtn)
        .bottomEqualToView(myServiceCompleteDetailBtn)
        .widthIs(1);
        
        //服务人员
        myServicePeopleBtn.sd_layout
        .leftSpaceToView(firstMidView, 0)
        .topEqualToView(firstMidView)
        .bottomEqualToView(firstMidView)
        .widthIs((SCW - 24)/3 - 1);
        
        serviceMidView.sd_layout
        .leftSpaceToView(myServicePeopleBtn, 0)
        .topEqualToView(myServicePeopleBtn)
        .bottomEqualToView(myServicePeopleBtn)
        .widthIs(1);
        
        //服务评价
        myModifyCompleteServiceBtn.sd_layout
        .leftSpaceToView(serviceMidView, 0)
        //.topSpaceToView(myServiceSeparateCompleteView, 0)
        .topEqualToView(serviceMidView)
        .bottomEqualToView(serviceMidView)
        .rightSpaceToView(myServiceContentCompleteView, 0);
        //.bottomSpaceToView(myServiceContentCompleteView, 0);
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
