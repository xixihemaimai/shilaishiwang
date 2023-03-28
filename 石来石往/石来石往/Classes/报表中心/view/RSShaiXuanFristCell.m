//
//  RSShaiXuanFristCell.m
//  石来石往
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSShaiXuanFristCell.h"

@implementation RSShaiXuanFristCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView * showContentView = [[UIView alloc]init];
        showContentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:showContentView];
        
        
        UILabel * outLabel = [[UILabel alloc]init];
        outLabel.text = @"出库日期 :";
        outLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        outLabel.font = [UIFont systemFontOfSize:14];
        outLabel.textAlignment = NSTextAlignmentLeft;
        [showContentView addSubview:outLabel];
        
        
        UIButton * fristBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [fristBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        [fristBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#E1E1E1"]];
        fristBtn.layer.cornerRadius = 3;
        [fristBtn setTitle:@"2018/11/11" forState:UIControlStateNormal];
        fristBtn.layer.masksToBounds = YES;
        [showContentView addSubview:fristBtn];
        
        _fristBtn = fristBtn;
        
        UIView * midView =[[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#333333"];
        [showContentView addSubview:midView];
        
        
        
        
        UIButton * secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [secondBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        [secondBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#E1E1E1"]];
        secondBtn.layer.cornerRadius = 3;
        [secondBtn setTitle:@"2018/11/11" forState:UIControlStateNormal];
        secondBtn.layer.masksToBounds = YES;
        [showContentView addSubview:secondBtn];
        _secondBtn = secondBtn;
        
        showContentView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        outLabel.sd_layout
        .leftSpaceToView(showContentView, 16)
        .rightSpaceToView(showContentView, 16)
        .topSpaceToView(showContentView, 28)
        .heightIs((SCH/568)* 14);
        
        
        fristBtn.sd_layout
        .leftSpaceToView(showContentView, 14)
        .topSpaceToView(outLabel, 7)
        .bottomSpaceToView(showContentView, 0)
        .widthIs(107);
        
        midView.sd_layout
        .leftSpaceToView(fristBtn, 9)
        .heightIs(1.5)
        .widthIs(10)
        .centerYEqualToView(fristBtn);
        
        
        secondBtn.sd_layout
        .leftSpaceToView(midView, 10)
        .rightSpaceToView(showContentView, 14)
        .topEqualToView(fristBtn)
        .bottomEqualToView(fristBtn);
 
    
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
