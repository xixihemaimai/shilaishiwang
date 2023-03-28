//
//  RSGoodHeaderSectionView.m
//  石来石往
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSGoodHeaderSectionView.h"
#import "RSDirverContact.h"
@interface RSGoodHeaderSectionView ()

@property (nonatomic,strong)UILabel *driverName;

@property (nonatomic,strong)UILabel *driverphoneNumber;

//@property (nonatomic,strong)UILabel *driverIdentify;
//
//
//@property (nonatomic,strong)UILabel *drivierCarCord;


@end


@implementation RSGoodHeaderSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIView * contentview = [[UIView alloc]init];
        contentview.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
        [self addSubview:contentview];
        
        contentview.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,0)
        .heightIs(187);
        
        UIView *headerview = [[UIView alloc]init];
        headerview.backgroundColor = [UIColor whiteColor];
        [contentview addSubview:headerview];
        
        headerview.sd_layout
        .leftSpaceToView(contentview,0)
        .rightSpaceToView(contentview,0)
        .topSpaceToView(contentview,7.5)
        .heightIs(115);
        //载货司机
        UIView * driverview = [[UIView alloc]init];
        driverview.backgroundColor = [UIColor whiteColor];
        [headerview addSubview:driverview];
        
        driverview.sd_layout
        .leftSpaceToView(headerview,0)
        .topSpaceToView(headerview,0)
        .rightSpaceToView(headerview,0)
        .heightIs(35);
        
        
        UILabel * driverLabel = [[UILabel alloc]init];
        driverLabel.text = @"提货人信息";
        driverLabel.font = [UIFont systemFontOfSize:16];
        driverLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [driverview addSubview:driverLabel];
        
        driverLabel.sd_layout
        .leftSpaceToView(driverview,12)
        .centerYEqualToView(driverview)
        .widthRatioToView(driverview,0.3)
        .heightRatioToView(driverview,0.8);
        
        
        UIView * topview = [[UIView alloc]init];
        topview.backgroundColor = [UIColor colorWithHexColorStr:@"#e9e9e9"];
        [headerview addSubview:topview];
        
        topview.sd_layout
        .topSpaceToView(driverview,0)
        .leftSpaceToView(headerview,12)
        .rightSpaceToView(headerview,12)
        .heightIs(1);
        
        
        UIView *topContentview = [[UIView alloc]init];
        topContentview.backgroundColor = [UIColor whiteColor];
        [headerview addSubview:topContentview];
        
        topContentview.sd_layout
        .leftSpaceToView(headerview,0)
        .rightSpaceToView(headerview,0)
        .topSpaceToView(topview,0)
        .bottomSpaceToView(headerview,0);
        
        
        UILabel *driverName = [[UILabel alloc]init];
        driverName.font = [UIFont systemFontOfSize:14];
        driverName.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [topContentview addSubview:driverName];
        driverName.textAlignment = NSTextAlignmentLeft;
        _driverName = driverName;
        
        
        UILabel *driverphoneNumber = [[UILabel alloc]init];
        driverphoneNumber.font = [UIFont systemFontOfSize:14];
        driverphoneNumber.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [topContentview addSubview:driverphoneNumber];
        driverphoneNumber.textAlignment = NSTextAlignmentLeft;
        _driverphoneNumber = driverphoneNumber;
       // UILabel *driverIdentify = [[UILabel alloc]init];
        
//        driverIdentify.font = [UIFont systemFontOfSize:14];
//        driverIdentify.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        [topContentview addSubview:driverIdentify];
//        _driverIdentify = driverIdentify;
//        UILabel *drivierCarCord = [[UILabel alloc]init];
//
//        drivierCarCord.font = [UIFont systemFontOfSize:14];
//        drivierCarCord.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//        [topContentview addSubview:drivierCarCord];
//        _drivierCarCord = drivierCarCord;
        
        driverName.sd_layout
        .leftSpaceToView(topContentview,12)
        .topSpaceToView(topContentview,13)
        .rightSpaceToView(topContentview, 12)
        .heightIs(20);
        
        driverphoneNumber.sd_layout
        .leftEqualToView(driverName)
        .rightEqualToView(driverName)
        .topSpaceToView(driverName, 13)
        .heightIs(20);
        
        
//        driverIdentify.sd_layout
//        .centerYEqualToView(topContentview)
//        .leftEqualToView(driverName)
//        .topSpaceToView(driverphoneNumber,8)
//        .rightEqualToView(driverphoneNumber)
//        .heightIs(20);
//        
//        drivierCarCord.sd_layout
//        .bottomSpaceToView(topContentview,10)
//        .leftEqualToView(driverIdentify)
//        .rightEqualToView(driverIdentify)
//        .topSpaceToView(driverIdentify,8);
        
        
        
        
        //物料信息
        UIView *sectionview = [[UIView alloc]init];
        sectionview.backgroundColor = [UIColor whiteColor];
        [contentview addSubview:sectionview];
        
        sectionview.sd_layout
        .leftSpaceToView(contentview,0)
        .rightSpaceToView(contentview,0)
        .bottomSpaceToView(contentview,0)
        .topSpaceToView(headerview,7.5);
        
        UILabel * materielLabel = [[UILabel alloc]init];
        materielLabel.text = @"物料信息";
        materielLabel.font = [UIFont systemFontOfSize:16];
        materielLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [sectionview addSubview:materielLabel];
        
        
        
        materielLabel.sd_layout
        .leftSpaceToView(sectionview,12)
        .centerYEqualToView(sectionview)
        .widthRatioToView(sectionview,0.3)
        .heightRatioToView(sectionview,0.7);
        
        
        //总面积和总体积
        UILabel * zongPiLabel = [[UILabel alloc]init];
        zongPiLabel.textAlignment = NSTextAlignmentCenter;
        zongPiLabel.font = [UIFont systemFontOfSize:16];
        zongPiLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [sectionview addSubview:zongPiLabel];
        _zongPiLabel = zongPiLabel;
        
        zongPiLabel.sd_layout
        .leftSpaceToView(materielLabel, 10)
        .rightSpaceToView(sectionview, 12)
        .centerYEqualToView(sectionview)
        .topEqualToView(materielLabel)
        .bottomEqualToView(materielLabel);
        
        
        
        UIView *bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
        [sectionview addSubview:bottomview];
        bottomview.sd_layout
        .leftSpaceToView(sectionview,12)
        .rightSpaceToView(sectionview,12)
        .bottomSpaceToView(sectionview,0)
        .heightIs(1);
        
        
        
        
    }
    return self;
}

- (void)setContact:(RSDirverContact *)contact{
    
    _contact = contact;
//    
//    _driverName.text = contact.driverName;
//    _driverphoneNumber.text = contact.phoneNumber;
//    
//    _driverIdentify.text = [NSString stringWithFormat:@"身份证号:%@",contact.identity];
//    _drivierCarCord.text = [NSString stringWithFormat:@"车牌号:%@",contact.carCord];
    
    _driverName.text = [NSString stringWithFormat:@"提货人:%@",contact.csnName];
    _driverphoneNumber.text = [NSString stringWithFormat:@"电话号码:%@",contact.csnPhone];
   // _driverIdentify.text = [NSString stringWithFormat:@"身份证号:%@",contact.idCard];
    //_drivierCarCord.text = [NSString stringWithFormat:@"车牌号:%@",contact.license];
    
}
@end
