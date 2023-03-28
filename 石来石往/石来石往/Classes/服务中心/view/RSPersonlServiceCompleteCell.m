//
//  RSPersonlServiceCompleteCell.m
//  石来石往
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPersonlServiceCompleteCell.h"

@implementation RSPersonlServiceCompleteCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        
        //每个cell
        UIView * personlCompleteAllView = [[UIView alloc]init];
        personlCompleteAllView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        [self.contentView addSubview:personlCompleteAllView];
        
        //cell的里面的内容了
        UIView * personlCompleteContentView = [[UIView alloc]init];
        personlCompleteContentView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [personlCompleteAllView addSubview:personlCompleteContentView];
        
        
        //服务类型图片
        UIImageView * personlCompleteImageView = [[UIImageView alloc]init];
       // personlCompleteImageView.image = [UIImage imageNamed:@"出库服务"];
        [personlCompleteContentView addSubview:personlCompleteImageView];
        _personlCompleteImageView = personlCompleteImageView;
        
        //服务类型
        UILabel * personlCompleteLabel = [[UILabel alloc]init];
        personlCompleteLabel.font = [UIFont systemFontOfSize:15];
       // personlCompleteLabel.text = @"出库服务";
        personlCompleteLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        personlCompleteLabel.textAlignment = NSTextAlignmentLeft;
        [personlCompleteContentView addSubview:personlCompleteLabel];
        _personlCompleteLabel = personlCompleteLabel;
        
        
        
        
        //服务人员商户
        UILabel * personlCompleteNameLabel = [[UILabel alloc]init];
        //personlCompleteNameLabel.text = @"商户：卓众石业";
        personlCompleteNameLabel.font = [UIFont systemFontOfSize:15];
        personlCompleteNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        personlCompleteNameLabel.textAlignment = NSTextAlignmentLeft;
        [personlCompleteContentView addSubview:personlCompleteNameLabel];
        _personlCompleteNameLabel = personlCompleteNameLabel;
        
        
        
        
        
        //出库单号
        UILabel * personlCompleteOutLabel = [[UILabel alloc]init];
       // personlCompleteOutLabel.text = @"出库单：2545858";
        personlCompleteOutLabel.font = [UIFont systemFontOfSize:15];
        personlCompleteOutLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        personlCompleteOutLabel.textAlignment = NSTextAlignmentLeft;
        [personlCompleteContentView addSubview:personlCompleteOutLabel];
        _personlCompleteOutLabel = personlCompleteOutLabel;
        
        
//        //出库数
//        UILabel * personlCompleteNumberLabel = [[UILabel alloc]init];
//        //personlCompleteNumberLabel.text = @"颗 数：2颗";
//        personlCompleteNumberLabel.font = [UIFont systemFontOfSize:15];
//        personlCompleteNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
//        personlCompleteNumberLabel.textAlignment = NSTextAlignmentLeft;
//        [personlCompleteContentView addSubview:personlCompleteNumberLabel];
//        _personlCompleteNumberLabel = personlCompleteNumberLabel;
        
        
        //预约时间
        UILabel * personlCompleteTimeLabel = [[UILabel alloc]init];
        //personlCompleteTimeLabel.text = @"预约时间：2016-05-06 16:05:05";
        personlCompleteTimeLabel.font = [UIFont systemFontOfSize:15];
        personlCompleteTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        personlCompleteTimeLabel.textAlignment = NSTextAlignmentLeft;
        [personlCompleteContentView addSubview:personlCompleteTimeLabel];
        _personlCompleteTimeLabel = personlCompleteTimeLabel;
        
        
        
        
        
        //上面和下面的分隔的view
        UIView * personlCompleteSeparateView = [[UIView alloc]init];
        
        personlCompleteSeparateView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [personlCompleteContentView addSubview:personlCompleteSeparateView];
        
        //下面的view显示的内容 订单详情
        UIButton * personlCompleteModifyServiceBtn = [[UIButton alloc]init];
        [personlCompleteModifyServiceBtn setTitle:@"服务详情" forState:UIControlStateNormal];
        [personlCompleteModifyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        personlCompleteModifyServiceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [personlCompleteModifyServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [personlCompleteContentView addSubview:personlCompleteModifyServiceBtn];
        _personlCompleteModifyServiceBtn = personlCompleteModifyServiceBtn;
        
        
        
        
        //上传图片
        UIButton * personlCompleteUploadPictureBtn = [[UIButton alloc]init];
        [personlCompleteUploadPictureBtn setTitle:@"上传图片" forState:UIControlStateNormal];
        [personlCompleteUploadPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        personlCompleteUploadPictureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [personlCompleteUploadPictureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [personlCompleteContentView addSubview:personlCompleteUploadPictureBtn];
        _personlCompleteUploadPictureBtn = personlCompleteUploadPictureBtn;
        
        
        //下面的view显示的内容 发起服务
        UIButton * personlCompleteEvaluationServiceBtn = [[UIButton alloc]init];
       // [personlCompleteEvaluationServiceBtn setTitle:@"查看评价" forState:UIControlStateNormal];
        [personlCompleteEvaluationServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        personlCompleteEvaluationServiceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [personlCompleteEvaluationServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [personlCompleteContentView addSubview:personlCompleteEvaluationServiceBtn];
        _personlCompleteEvaluationServiceBtn = personlCompleteEvaluationServiceBtn;
        
        //俩个按键中间的view
        UIView * personlCompleteMidView = [[UIView alloc]init];
        personlCompleteMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [personlCompleteContentView addSubview:personlCompleteMidView];
        
        //第二个按键和第三个按键的分隔view
        UIView * personlSecondMidView = [[UIView alloc]init];
        personlSecondMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
        [personlCompleteContentView addSubview:personlSecondMidView];
        
        
        
        personlCompleteAllView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        personlCompleteContentView.sd_layout
        .leftSpaceToView(personlCompleteAllView, 12)
        .topSpaceToView(personlCompleteAllView, 12)
        .rightSpaceToView(personlCompleteAllView, 12)
        .bottomSpaceToView(personlCompleteAllView, 0);
        
        
        personlCompleteContentView.layer.cornerRadius = 6;
        personlCompleteContentView.layer.masksToBounds = YES;
        
        personlCompleteImageView.sd_layout
        .leftSpaceToView(personlCompleteContentView, 15)
        .topSpaceToView(personlCompleteContentView, 10)
        .widthIs(30)
        .heightIs(30);
        
        
        personlCompleteLabel.sd_layout
        .leftSpaceToView(personlCompleteImageView, 10)
        .rightSpaceToView(personlCompleteContentView, 12)
        .topSpaceToView(personlCompleteContentView, 20)
        .heightIs(15);
        
        
        personlCompleteNameLabel.sd_layout
        .leftEqualToView(personlCompleteImageView)
        .rightEqualToView(personlCompleteLabel)
        .topSpaceToView(personlCompleteLabel, 10)
        .heightIs(15);
        
        
        
        personlCompleteOutLabel.sd_layout
        .leftEqualToView(personlCompleteNameLabel)
        .rightEqualToView(personlCompleteNameLabel)
        .topSpaceToView(personlCompleteNameLabel, 10)
        .heightIs(15);
        
        
//        personlCompleteNumberLabel.sd_layout
//        .leftEqualToView(personlCompleteOutLabel)
//        .rightEqualToView(personlCompleteOutLabel)
//        .topSpaceToView(personlCompleteOutLabel, 7.5)
//        .heightIs(15);
        
        personlCompleteTimeLabel.sd_layout
        //.leftEqualToView(personlCompleteNumberLabel)
        .leftEqualToView(personlCompleteOutLabel)
        .rightEqualToView(personlCompleteOutLabel)
        .topSpaceToView(personlCompleteOutLabel, 10)
        //.rightEqualToView(personlCompleteNumberLabel)
        //.topSpaceToView(personlCompleteNumberLabel, 7)
        .heightIs(15);
        
        
        
        personlCompleteSeparateView.sd_layout
        .leftSpaceToView(personlCompleteContentView, 0)
        .rightSpaceToView(personlCompleteContentView, 0)
        .topSpaceToView(personlCompleteTimeLabel, 10)
        .heightIs(1);
        
        personlCompleteModifyServiceBtn.sd_layout
        .leftSpaceToView(personlCompleteContentView, 0)
        .topSpaceToView(personlCompleteSeparateView, 0)
        .widthIs(((SCW - 24)/3) - 1)
        .bottomSpaceToView(personlCompleteContentView, 0);
        
        
        
        personlCompleteMidView.sd_layout
        .leftSpaceToView(personlCompleteModifyServiceBtn, 0)
        .topEqualToView(personlCompleteModifyServiceBtn)
        .bottomEqualToView(personlCompleteModifyServiceBtn)
        .widthIs(1);
        
        
        personlCompleteUploadPictureBtn.sd_layout
        .leftSpaceToView(personlCompleteMidView, 0)
        .topEqualToView(personlCompleteMidView)
        .bottomEqualToView(personlCompleteMidView)
        .widthIs((SCW - 24)/3 - 1);
        
        
        personlSecondMidView.sd_layout
        .leftSpaceToView(personlCompleteUploadPictureBtn, 0)
        .topEqualToView(personlCompleteUploadPictureBtn)
        .bottomEqualToView(personlCompleteUploadPictureBtn)
        .widthIs(1);
        
        
        
        personlCompleteEvaluationServiceBtn.sd_layout
        .leftSpaceToView(personlSecondMidView, 0)
        .topEqualToView(personlSecondMidView)
        .bottomEqualToView(personlSecondMidView)
        .rightSpaceToView(personlCompleteContentView, 0);
        
        
        
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
