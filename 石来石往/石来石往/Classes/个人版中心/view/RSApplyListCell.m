//
//  RSApplyListCell.m
//  石来石往
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSApplyListCell.h"

@implementation RSApplyListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        //图片
        UIImageView * contentImageView = [[UIImageView alloc]init];
        contentImageView.image = [UIImage imageNamed:@"Oval 10"];
        contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        contentImageView.clipsToBounds = YES;
        [self.contentView addSubview:contentImageView];
        
        
        //文字
        UILabel * nameFirstlabel = [[UILabel alloc]init];
        nameFirstlabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        nameFirstlabel.textAlignment = NSTextAlignmentCenter;
        nameFirstlabel.font = [UIFont systemFontOfSize:19];
        [contentImageView addSubview:nameFirstlabel];
        _nameFirstlabel = nameFirstlabel;
        
        //公司名称
        UILabel * companyLabel = [[UILabel alloc]init];
        companyLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        companyLabel.textAlignment = NSTextAlignmentLeft;
        companyLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:companyLabel];
        _companyLabel = companyLabel;
        //状态
        UILabel * statusLabel = [[UILabel alloc]init];
        statusLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        statusLabel.textAlignment = NSTextAlignmentLeft;
        statusLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:statusLabel];
        _statusLabel = statusLabel;
        
        //按键-- 可以是编辑，重新申请
        UIButton * statusBtn = [[UIButton alloc]init];
        [statusBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [statusBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        [self.contentView addSubview:statusBtn];
        _statusBtn = statusBtn;
        //按键-撤销申请
        UIButton * cancelApplyBtn = [[UIButton alloc]init];
        [cancelApplyBtn setTitle:@"撤销申请" forState:UIControlStateNormal];
        [cancelApplyBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [cancelApplyBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#C5C5C5"]];
        [self.contentView addSubview:cancelApplyBtn];
        _cancelApplyBtn = cancelApplyBtn;
        
        
        //底部分隔线
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomview];
        
        
        contentImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .widthIs(40)
        .heightEqualToWidth();
    
        
        nameFirstlabel.sd_layout
        .leftSpaceToView(contentImageView, 0)
        .topSpaceToView(contentImageView, 0)
        .rightSpaceToView(contentImageView, 0)
        .bottomSpaceToView(contentImageView, 0);
        
        
        companyLabel.sd_layout
        .leftSpaceToView(contentImageView, 13)
        .topEqualToView(contentImageView)
        .widthRatioToView(self.contentView, 0.5)
        .heightIs(25);
        
        statusLabel.sd_layout
        .leftEqualToView(companyLabel)
        .rightEqualToView(companyLabel)
        .topSpaceToView(companyLabel, 0)
        .bottomEqualToView(contentImageView);
        
        statusBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(25)
        .widthIs(80);
        
        statusBtn.layer.cornerRadius = 12;
        
        
        cancelApplyBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(statusBtn, 6)
        .widthIs(80)
        .heightIs(25);
         cancelApplyBtn.layer.cornerRadius = 12;
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
        
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
