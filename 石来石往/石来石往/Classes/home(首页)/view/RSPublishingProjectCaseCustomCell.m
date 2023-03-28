//
//  RSPublishingProjectCaseCustomCell.m
//  石来石往
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPublishingProjectCaseCustomCell.h"


#define CELL_WIDTH self.bounds.size.width
#define CELL_HEIGHT self.bounds.size.height


@interface RSPublishingProjectCaseCustomCell ()



@end





@implementation RSPublishingProjectCaseCustomCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initDatas];
        
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if([super initWithCoder:aDecoder])
    {
        [self initDatas];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initDatas];
}


/**
 *  初始化数据
 */
- (void)initDatas
{
    
    
    
    
    
    UIButton * stoneNameBtn = [[UIButton alloc]init];
    // indexpathLabel.text = @"石材名称1";
    
    
    //stoneNameBtn.ti.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    
    
    [stoneNameBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    
    stoneNameBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    stoneNameBtn.titleLabel.numberOfLines = 0;
    
    //stoneNameBtn.font = [UIFont systemFontOfSize:15];
    
    stoneNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:stoneNameBtn];
    _stoneNameBtn = stoneNameBtn;
    
    RSPublishingProjectCaseFirstButton * indexpathBtn = [[RSPublishingProjectCaseFirstButton alloc]init];
    [indexpathBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [indexpathBtn setTitle:@"添加案例用料图片" forState:UIControlStateNormal];
    [indexpathBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    indexpathBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    indexpathBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:indexpathBtn];
    _indexpathBtn = indexpathBtn;
    
    
    
    UIButton * deleteBtn = [[UIButton alloc]init];
    [deleteBtn setImage:[UIImage imageNamed:@"删除图片"] forState:UIControlStateNormal];
    [indexpathBtn addSubview:deleteBtn];
    [deleteBtn bringSubviewToFront:indexpathBtn];
    deleteBtn.hidden = YES;
    _deleteBtn = deleteBtn;
    
    UIView * bottomview = [[UIView alloc]init];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [self.contentView addSubview:bottomview];
    
    
    stoneNameBtn.sd_layout
    .leftSpaceToView(self.contentView, 21)
    .topSpaceToView(self.contentView, 10)
    .heightIs(100)
    .widthIs(80);
    
    if (iPhone4 || iPhone5) {
        
        indexpathBtn.sd_layout
        .leftSpaceToView(stoneNameBtn, 40)
        .topSpaceToView(self.contentView, 11)
        .widthIs(150)
        .heightIs(100)
        .centerYEqualToView(self.contentView);
    }else{
        
        indexpathBtn.sd_layout
        .leftSpaceToView(stoneNameBtn, 58)
        .topSpaceToView(self.contentView, 11)
        .widthIs(200)
        .heightIs(100)
        .centerYEqualToView(self.contentView);
        
    }

    
    
    deleteBtn.sd_layout
    .rightSpaceToView(indexpathBtn, 0)
    .topSpaceToView(indexpathBtn, 0)
    .widthIs(16)
    .heightIs(16);
    
    
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, indexpathBtn.yj_width, indexpathBtn.yj_height);//虚线框的大小
    borderLayer.position = CGPointMake(CGRectGetMidX(indexpathBtn.bounds),CGRectGetMidY(indexpathBtn.bounds));//虚线框锚点
    
    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;//矩形路径
    
    
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];//虚线宽度
    
    //虚线边框
    borderLayer.lineDashPattern = @[@5, @5];
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor colorWithHexColorStr:@"#FD9835"].CGColor;
    
    [indexpathBtn.layer addSublayer:borderLayer];
    
    
    
    bottomview.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0)
    .heightIs(1);
    
}



@end
