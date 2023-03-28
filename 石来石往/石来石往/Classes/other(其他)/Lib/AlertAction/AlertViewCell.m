//
//  AlertViewCell.m
//  GGAlertAction
//
//  Created by 吉祥 on 2017/8/21.
//  Copyright © 2017年 jixiang. All rights reserved.
//

#import "AlertViewCell.h"

@interface AlertViewCell ()

@end
@implementation AlertViewCell
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = self.backgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // initialize
    [self initialize];
    return self;
}

#pragma mark - Private
// 初始化
- (void)initialize {
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [self.contentView addSubview:self.titleLabel];
    
    self.detailTitleLabel = [[UILabel alloc]init];
    self.detailTitleLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    
    self.detailTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.detailTitleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.detailTitleLabel];
    
    self.selectImage = [[UIImageView alloc]init];
    [self.contentView addSubview:self.selectImage];
    [self.selectImage bringSubviewToFront:self.contentView];
    
    
    UIView * bottomview = [[UIView alloc]init];
    bottomview.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self.contentView addSubview:bottomview];
    
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 12)
    .topSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(25);
    
    
    self.detailTitleLabel.sd_layout
    .leftEqualToView(self.titleLabel)
    .rightEqualToView(self.titleLabel)
    .topSpaceToView(self.titleLabel, 0)
    .heightIs(25);
    
    self.selectImage.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 12)
    .widthIs(25)
    .heightEqualToWidth();
    
    bottomview.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0)
    .heightIs(1);
    
    
    
}

#pragma mark - Public
- (void)setAction:(AlertAction *)action{
    _action = action;
    self.titleLabel.text = action.title;
    self.selectImage.image = action.image;
    self.detailTitleLabel.text = action.detailTitle;
    if ([action.type isEqualToString:@"1"]) {
        //这边是联系人
        self.detailTitleLabel.hidden = NO;
        
        self.titleLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(25);
        
        self.detailTitleLabel.sd_layout
        .leftEqualToView(self.titleLabel)
        .rightEqualToView(self.titleLabel)
        .topSpaceToView(self.titleLabel, 0)
        .heightIs(25);
        
    }else if ([action.type isEqualToString:@"2"]){
        //这边是联系地址
        self.detailTitleLabel.hidden = YES;
        self.titleLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(50);
        
        self.detailTitleLabel.sd_layout
        .leftEqualToView(self.titleLabel)
        .rightEqualToView(self.titleLabel)
        .topSpaceToView(self.titleLabel, 0)
        .heightIs(0);
        
    }
    
    
}

@end
