//
//  RSReportDetialCell.m
//  石来石往
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSReportDetialCell.h"

@implementation RSReportDetialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //整个view
        UIView * detailView = [[UIView alloc]init];
        detailView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8F8"];
        [self.contentView addSubview:detailView];
        
        //要显示的view
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor whiteColor];
        [detailView addSubview:showView];
        
        //上面的view
        UIView * topView = [[UIView alloc]init];
        topView.backgroundColor = [UIColor whiteColor];
        [showView addSubview:topView];
        
        
        //下面的view
        UIView * underView = [[UIView alloc]init];
        underView.backgroundColor = [UIColor whiteColor];
        [showView addSubview:underView];
        
        
        
        //下面的view
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor whiteColor];
        [showView addSubview:bottomView];
        
        
        //上面的view显示的东西
        UILabel * label = [[UILabel alloc]init];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.layer.cornerRadius = 4;
        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor colorWithHexColorStr:@"#FDAF1C"];
        label.font = [UIFont systemFontOfSize:16];
        [topView addSubview:label];
        _label = label;
        //上面的view显示的产品
        UILabel * productLabel = [[UILabel alloc]init];
        
        productLabel.textColor = [UIColor blackColor];
        productLabel.font = [UIFont systemFontOfSize:16];
        [topView addSubview:productLabel];
        _productLabel = productLabel;
        
        //上面的码单的按键
        UIButton * singlecodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [singlecodeBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FDAF1C"]];
        [singlecodeBtn setTitle:@"码单" forState:UIControlStateNormal];
        singlecodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        singlecodeBtn.layer.cornerRadius = 4;
        singlecodeBtn.layer.masksToBounds = YES;
        [singlecodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [underView addSubview:singlecodeBtn];
        _singlecodeBtn = singlecodeBtn;
        
        
        //上面的报表
        UIButton * reportFormBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reportFormBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FDAF1C"]];
        [reportFormBtn setTitle:@"报表" forState:UIControlStateNormal];
        reportFormBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        reportFormBtn.layer.cornerRadius = 4;
        singlecodeBtn.layer.masksToBounds = YES;
        [reportFormBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [underView addSubview:reportFormBtn];
        _reportFormBtn = reportFormBtn;
        
        UIView * separateView = [[UIView alloc]init];
        separateView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
        [underView addSubview:separateView];
        
        //下面的view的界面
        UIView * fristView = [[UIView alloc]init];
        fristView.backgroundColor = [UIColor whiteColor];
        [bottomView addSubview:fristView];
        
        
        UILabel * keLabel = [[UILabel alloc]init];
        
        keLabel.textColor = [UIColor colorWithHexColorStr:@"#3385FF"];
        keLabel.font = [UIFont systemFontOfSize:15];
        keLabel.textAlignment = NSTextAlignmentLeft;
        [fristView addSubview:keLabel];
        _keLabel = keLabel;
        
        
        UILabel * zongKeLabel = [[UILabel alloc]init];
        zongKeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        zongKeLabel.font = [UIFont systemFontOfSize:12];
        zongKeLabel.textAlignment = NSTextAlignmentLeft;
        
        [fristView addSubview:zongKeLabel];
        _zongKeLabel = zongKeLabel;
        
        
        
        
        
        
        UIView * fristMidView = [[UIView alloc]init];
        fristMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
        [bottomView addSubview:fristMidView];
        
        
        
        UIView * secondView = [[UIView alloc]init];
        secondView.backgroundColor = [UIColor whiteColor];
        [bottomView addSubview:secondView];
        
        
        
        UILabel * LiLabel = [[UILabel alloc]init];
        
        LiLabel.textColor = [UIColor colorWithHexColorStr:@"#3385ff"];
        LiLabel.font = [UIFont systemFontOfSize:15];
        LiLabel.textAlignment = NSTextAlignmentLeft;
        [secondView addSubview:LiLabel];
        _LiLabel = LiLabel;
        
        UILabel * zongLiLabel = [[UILabel alloc]init];
        
        zongLiLabel.textAlignment = NSTextAlignmentLeft;
        zongLiLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        zongLiLabel.font = [UIFont systemFontOfSize:12];
        [secondView addSubview:zongLiLabel];
        _zongLiLabel = zongLiLabel;
        
        
        UIView * secondMidView = [[UIView alloc]init];
        secondMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
        [bottomView addSubview:secondMidView];
        
        
        
        UIView * thirdView = [[UIView alloc]init];
        thirdView.backgroundColor = [UIColor whiteColor];
        [bottomView addSubview:thirdView];
        
        
        UILabel * weightLabel = [[UILabel alloc]init];
        
        weightLabel.textColor = [UIColor colorWithHexColorStr:@"#3385ff"];
        weightLabel.font = [UIFont systemFontOfSize:15];
        weightLabel.textAlignment = NSTextAlignmentLeft;
        [thirdView addSubview:weightLabel];
        _weightLabel = weightLabel;
        
        UILabel * zongWeightLabel = [[UILabel alloc]init];
        
        zongWeightLabel.textAlignment = NSTextAlignmentLeft;
        zongWeightLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        zongWeightLabel.font = [UIFont systemFontOfSize:12];
        [thirdView addSubview:zongWeightLabel];
        _zongWeightLabel = zongWeightLabel;
        
        
        detailView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        showView.sd_layout
        .leftSpaceToView(detailView, 0)
        .rightSpaceToView(detailView, 0)
        .topSpaceToView(detailView, 0)
        .bottomSpaceToView(detailView, 11);
        
        
        topView.sd_layout
        .leftSpaceToView(showView, 0)
        .topSpaceToView(showView, 0)
        .rightSpaceToView(showView, 0)
        .heightIs(39);
        
        
        bottomView.sd_layout
        .topSpaceToView(topView, 0)
        .rightSpaceToView(showView, 0)
        .leftSpaceToView(showView, 0)
        //.bottomSpaceToView(showView, 0);
        .heightIs(39);
        
        
        
        underView.sd_layout
        .topSpaceToView(bottomView, 0)
        .leftSpaceToView(showView, 0)
        .rightSpaceToView(showView, 0)
        .bottomSpaceToView(showView, 0);
        
        
        
        
        
        fristView.sd_layout
        .leftSpaceToView(bottomView, 0)
        .topSpaceToView(bottomView, 0)
        .bottomSpaceToView(bottomView, 0)
        .widthIs(SCW/3 - 1);
        
        fristMidView.sd_layout
        .leftSpaceToView(fristView, 0)
        .widthIs(1)
        .topSpaceToView(bottomView, 5)
        .bottomSpaceToView(bottomView, 5);
        
        
        secondView.sd_layout
        .leftSpaceToView(fristMidView, 0)
        .bottomSpaceToView(bottomView, 0)
        .topSpaceToView(bottomView, 0)
        .widthIs(SCW/3 - 1 );
        
        
        secondMidView.sd_layout
        .leftSpaceToView(secondView, 0)
        .topSpaceToView(bottomView, 5)
        .bottomSpaceToView(bottomView, 5)
        .widthIs(1);
        
        
        thirdView.sd_layout
        .leftSpaceToView(secondMidView, 0)
        .topSpaceToView(bottomView, 0)
        .bottomSpaceToView(bottomView, 0)
        .rightSpaceToView(bottomView, 0);
        
        
        label.sd_layout
        .centerYEqualToView(topView)
        .leftSpaceToView(topView, 12)
        .heightIs(17)
        .widthIs(17);
        
        productLabel.sd_layout
        .leftSpaceToView(label, 7)
        .topEqualToView(label)
        .bottomEqualToView(label)
        .widthRatioToView(topView, 0.7);
        
        separateView.sd_layout
        .leftSpaceToView(underView, 0)
        .rightSpaceToView(underView, 0)
        .topSpaceToView(underView, 0)
        .heightIs(1);
        
        
        singlecodeBtn.sd_layout
        .rightSpaceToView(underView, 12)
        .centerYEqualToView(underView)
        .widthIs(40)
        .heightIs(21);
        
        
        
        
        reportFormBtn.sd_layout
        .rightSpaceToView(singlecodeBtn, 12)
        .centerYEqualToView(underView)
        .widthIs(40)
        .heightIs(21);
        
        
        
       keLabel.sd_layout
        .leftSpaceToView(fristView, 12)
        .rightSpaceToView(fristView, 12)
        .topSpaceToView(fristView, 5)
        .heightIs( 14);
        
        
        zongKeLabel.sd_layout
        .leftEqualToView(keLabel)
        .rightEqualToView(keLabel)
        .topSpaceToView(keLabel, 6)
        .heightIs(12);
        
        
        LiLabel.sd_layout
        .leftSpaceToView(secondView, 12)
        .rightSpaceToView(secondView, 12)
        .topSpaceToView(secondView, 5)
        .heightIs( 14);
        
        zongLiLabel.sd_layout
        .leftEqualToView(LiLabel)
        .rightEqualToView(LiLabel)
        .topSpaceToView(LiLabel, 6)
        .heightIs( 12);
        
        
        weightLabel.sd_layout
        .leftSpaceToView(thirdView, 12)
        .rightSpaceToView(thirdView, 12)
        .topSpaceToView(thirdView, 5)
        .heightIs(14);
        
        zongWeightLabel.sd_layout
        .leftEqualToView(weightLabel)
        .rightEqualToView(weightLabel)
        .topSpaceToView(weightLabel, 6)
        .heightIs( 12);

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
