//
//  RSPersonalEditionCell.m
//  石来石往
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPersonalEditionCell.h"
#import "RSPublishButton.h"
#define ECA 4
#define MARGIN 25



@interface RSPersonalEditionCell()


@end


@implementation RSPersonalEditionCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
       
       
    }
    return self;
}

- (void)setTyle:(NSString *)tyle{
    _tyle = tyle;
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    if ([_tyle isEqualToString:@"huangliao"]) {
        CGFloat publishBtnW = 0.0;
        if (iPhoneXSMax || iPhoneXR || iPhone6p) {
            publishBtnW = (SCW - (4 + 1)*30)/4;
        }else if (iPhone5){
            publishBtnW = 50;
        }else{
            publishBtnW = 60;
        }
        CGFloat publishBtnH = 84;
        for (int i = 0; i < 4; i++) {
            RSPublishButton * publishBtn = [RSPublishButton buttonWithType:UIButtonTypeCustom];
            publishBtn.adjustsImageWhenHighlighted = NO;
            if (i == 0) {
                [publishBtn setTitle:@"荒料入库" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版荒料入库"] forState:UIControlStateNormal];
            }else if (i == 1){
                [publishBtn setTitle:@"荒料出库" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版荒料出库"] forState:UIControlStateNormal];
            }else if (i == 2){
                [publishBtn setTitle:@"库存管理" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版库存管理"] forState:UIControlStateNormal];
            }else{
                [publishBtn setTitle:@"报表中心" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版报表中心"] forState:UIControlStateNormal];
            }
            [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#282D38"] forState:UIControlStateNormal];
            if (iPhone5) {
               publishBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            }else{
               publishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            }
            
            //NSInteger row = i / ECA;
            [publishBtn setBackgroundColor:[UIColor clearColor]];
            NSInteger colom = i % ECA;
            CGFloat publishBtnX =  colom * (MARGIN + publishBtnW) + MARGIN;
            publishBtn.frame = CGRectMake(publishBtnX, 10, publishBtnW, publishBtnH);
            [self.contentView addSubview:publishBtn];
            [publishBtn addTarget:self action:@selector(jumpPersonalWorkContent:) forControlEvents:UIControlEventTouchUpInside];
            publishBtn.tag = i;
        }
    }else if ([_tyle isEqualToString:@"daban"]){
        CGFloat publishBtnW = 0.0;
        if (iPhoneXSMax || iPhoneXR || iPhone6p) {
            publishBtnW = (SCW - (4 + 1)*30)/4;
        }else if (iPhone5){
            publishBtnW = 50;
        }else{
            publishBtnW = 60;
        }
        CGFloat publishBtnH = 84;
        for (int i = 0; i < 4; i++) {
            RSPublishButton * publishBtn = [RSPublishButton buttonWithType:UIButtonTypeCustom];
            publishBtn.adjustsImageWhenHighlighted = NO;
            if (i == 0) {
                [publishBtn setTitle:@"大板入库" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版大板入库"] forState:UIControlStateNormal];
            }else if (i == 1){
                [publishBtn setTitle:@"大板出库" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版大板出库"] forState:UIControlStateNormal];
            }else if (i == 2){
                [publishBtn setTitle:@"库存管理" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版库存管理(1)"] forState:UIControlStateNormal];
            }else{
                [publishBtn setTitle:@"报表中心" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版报表中心(1)"] forState:UIControlStateNormal];
            }
            [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#282D38"] forState:UIControlStateNormal];
            if (iPhone5) {
                publishBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            }else{
                publishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            }
            //NSInteger row = i / ECA;
            [publishBtn setBackgroundColor:[UIColor clearColor]];
            NSInteger colom = i % ECA;
            CGFloat publishBtnX =  colom * (MARGIN + publishBtnW) + MARGIN;
            publishBtn.frame = CGRectMake(publishBtnX, 10, publishBtnW, publishBtnH);
            [self.contentView addSubview:publishBtn];
             [publishBtn addTarget:self action:@selector(jumpPersonalWorkContent:) forControlEvents:UIControlEventTouchUpInside];
             publishBtn.tag = i;
        }
    }else if ([_tyle isEqualToString:@"jichu"]){
        CGFloat publishBtnW = 0.0;
        if (iPhoneXSMax || iPhoneXR || iPhone6p) {
            publishBtnW = (SCW - (4 + 1)*30)/4;
        }else if (iPhone5){
            publishBtnW = 50;
        }else{
            publishBtnW = 60;
        }
        CGFloat publishBtnH = 84;
        for (int i = 0; i < 3; i++) {
            RSPublishButton * publishBtn = [RSPublishButton buttonWithType:UIButtonTypeCustom];
            publishBtn.adjustsImageWhenHighlighted = NO;
            if (i == 0) {
//                [publishBtn setTitle:@"数据字典" forState:UIControlStateNormal];
//                [publishBtn setImage:[UIImage imageNamed:@"个人版数据字典"] forState:UIControlStateNormal];
//            }else if (i == 1){
                [publishBtn setTitle:@"物料字典" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版物料字典"] forState:UIControlStateNormal];
            }else if (i == 1){
                [publishBtn setTitle:@"仓库管理" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版仓库管理"] forState:UIControlStateNormal];
            }else if (i == 2){
                [publishBtn setTitle:@"加工厂" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"加工厂"] forState:UIControlStateNormal];
            }
            [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#282D38"] forState:UIControlStateNormal];
            if (iPhone5) {
                publishBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            }else{
                publishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            }
            //NSInteger row = i / ECA;
            [publishBtn setBackgroundColor:[UIColor clearColor]];
            NSInteger colom = i % ECA;
            CGFloat publishBtnX =  colom * (MARGIN + publishBtnW) + MARGIN;
            publishBtn.frame = CGRectMake(publishBtnX, 10, publishBtnW, publishBtnH);
            [self.contentView addSubview:publishBtn];
             [publishBtn addTarget:self action:@selector(jumpPersonalWorkContent:) forControlEvents:UIControlEventTouchUpInside];
             publishBtn.tag = i;
        }
    }else{
        CGFloat publishBtnW = 0.0;
        if (iPhoneXSMax || iPhoneXR || iPhone6p) {
            publishBtnW = (SCW - (4 + 1)*30)/4;
        }else if (iPhone5){
            publishBtnW = 50;
        }else{
            publishBtnW = 60;
        }
        CGFloat publishBtnH = 84;
        for (int i = 0; i < 3; i++) {
            RSPublishButton * publishBtn = [RSPublishButton buttonWithType:UIButtonTypeCustom];
            publishBtn.adjustsImageWhenHighlighted = NO;
            if (i == 0) {
                [publishBtn setTitle:@"用户管理" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版用户管理"] forState:UIControlStateNormal];
            }else if (i == 1){
                [publishBtn setTitle:@"角色管理" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版角色管理"] forState:UIControlStateNormal];
            }
            else{
                [publishBtn setTitle:@"码单模板" forState:UIControlStateNormal];
                [publishBtn setImage:[UIImage imageNamed:@"个人版码单模版"] forState:UIControlStateNormal];
            }
            [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#282D38"] forState:UIControlStateNormal];
            if (iPhone5) {
                publishBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            }else{
                publishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            }
            
            //NSInteger row = i / ECA;
            [publishBtn setBackgroundColor:[UIColor clearColor]];
            NSInteger colom = i % ECA;
            CGFloat publishBtnX =  colom * (MARGIN + publishBtnW) + MARGIN;
            publishBtn.frame = CGRectMake(publishBtnX, 10, publishBtnW, publishBtnH);
            [self.contentView addSubview:publishBtn];
             [publishBtn addTarget:self action:@selector(jumpPersonalWorkContent:) forControlEvents:UIControlEventTouchUpInside];
             publishBtn.tag = i;
        }
    }
}






- (void)jumpPersonalWorkContent:(UIButton *)publishBtn{
    if ([self.delegate respondsToSelector:@selector(selectPublishCurrentImage:)]) {
        [self.delegate selectPublishCurrentImage:publishBtn.currentImage];
    }
    
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
