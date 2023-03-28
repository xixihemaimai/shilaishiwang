//
//  RSShowAuditStatusView.m
//  石来石往
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSShowAuditStatusView.h"

#import "RSAuditStatusLabelView.h"

@implementation RSShowAuditStatusView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
     
        
        self.backgroundColor = [UIColor whiteColor];
        //这边要进行处理
        
        //先处理view
        
        UIView * centerView = [[UIView alloc]init];
        centerView.backgroundColor = [UIColor clearColor];
        [self addSubview:centerView];
        _centerView = centerView;
        
        
        //第一个原点
        UIView * firstView = [[UIView alloc]init];
        firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [centerView addSubview:firstView];
        _firstView = firstView;
        
        
        
        //第一个中间的view
        UIView * firstProgressView = [[UIView alloc]init];
        firstProgressView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [centerView addSubview:firstProgressView];
        
        
        //第一个label
        UILabel * firstLabel = [[UILabel alloc]init];
        firstLabel.text  = @"提交";
        firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        firstLabel.textAlignment = NSTextAlignmentLeft;
        [centerView addSubview:firstLabel];
        _firstLabel = firstLabel;
        
        
        //第二个原点
        UIView * secondView = [[UIView alloc]init];
        secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [centerView addSubview:secondView];
        _secondView = secondView;
        
        
        //第二个中间的view
        UIView * secondProgressView = [[UIView alloc]init];
        secondProgressView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [centerView addSubview:secondProgressView];
        
        
        
        //第二个label
        UILabel * secondLabel = [[UILabel alloc]init];
        secondLabel.text  = @"审核";
        secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        secondLabel.textAlignment = NSTextAlignmentCenter;
        [centerView addSubview:secondLabel];
        _secondLabel = secondLabel;
        //第三个原点
        UIView * thirdView = [[UIView alloc]init];
        thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [centerView addSubview:thirdView];
        _thirdView = thirdView;
        
        //第三个label
        UILabel * thirdLabel = [[UILabel alloc]init];
        thirdLabel.text  = @"完成";
        thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        thirdLabel.textAlignment = NSTextAlignmentRight;
        [centerView addSubview:thirdLabel];
        _thirdLabel = thirdLabel;
        
        
        RSAuditStatusLabelView * auditStatusLabelview = [[RSAuditStatusLabelView alloc]init];
        //auditStatusLabelview.backgroundColor = [UIColor colorWithHexColorStr:@"#ff943d"];
        [centerView addSubview:auditStatusLabelview];

        _auditStatusLabelview = auditStatusLabelview;
        
        //底下view
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#eeeeee"];
        [self addSubview:bottomview];
        
        
        
        centerView.sd_layout
        .centerXEqualToView(self)
        .centerYEqualToView(self)
        .leftSpaceToView(self, 12)
        .rightSpaceToView(self, 12)
        .topSpaceToView(self, 12)
        .bottomSpaceToView(self, 12);
        
        
        
        firstView.sd_layout
        .leftSpaceToView(centerView, 40)
        .bottomSpaceToView(centerView, 12)
        .widthIs(15)
        .heightIs(15);
        
        firstView.layer.cornerRadius = firstView.yj_width * 0.5;
        firstView.layer.masksToBounds = YES;
        
        
        firstLabel.sd_layout
        .leftSpaceToView(centerView, 32)
        .bottomSpaceToView(firstView, 10)
        .heightIs(15)
        .widthIs(80);
        
        
        secondView.sd_layout
        //.centerYEqualToView(centerView)
        .centerXEqualToView(centerView)
        .bottomSpaceToView(centerView, 12)
        .widthIs(15)
        .heightIs(15);
        
        secondView.layer.cornerRadius = secondView.yj_width * 0.5;
        secondView.layer.masksToBounds = YES;
        
        secondLabel.sd_layout
        .centerXEqualToView(centerView)
        .bottomSpaceToView(secondView, 10)
        .heightIs(15)
        .widthIs(80);
        
        
        
        firstProgressView.sd_layout
        .leftSpaceToView(firstView, 10)
        .rightSpaceToView(secondView, 10)
        .centerXEqualToView(firstView)
        .centerYEqualToView(firstView)
        .heightIs(1);
        
        
        
        thirdView.sd_layout
        .rightSpaceToView(centerView, 40)
        .bottomSpaceToView(centerView, 12)
        .widthIs(15)
        .heightIs(15);
        
        thirdView.layer.cornerRadius = thirdView.yj_width * 0.5;
        thirdView.layer.masksToBounds = YES;
        
        
        secondProgressView.sd_layout
        .leftSpaceToView(secondView, 10)
        .rightSpaceToView(thirdView, 10)
        .centerYEqualToView(thirdView)
        .centerXEqualToView(thirdView)
        .heightIs(1);
        
        
        thirdLabel.sd_layout
        .rightSpaceToView(centerView, 32)
        .bottomSpaceToView(thirdView, 10)
        .heightIs(15)
        .widthIs(80);
        
        
//        auditStatusLabelview.sd_layout
//        .centerXEqualToView(centerView)
//        .bottomEqualToView(secondLabel)
//        .widthIs(60)
//        .heightIs(30);
        
     //   secondLabel.hidden = YES;
        
        
        bottomview.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .heightIs(1);
        
    }
    return self;
}

@end
