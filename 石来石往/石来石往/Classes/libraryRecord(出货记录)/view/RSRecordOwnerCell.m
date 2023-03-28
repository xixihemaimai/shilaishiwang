//
//  RSRecordOwnerCell.m
//  石来石往
//
//  Created by mac on 2018/1/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSRecordOwnerCell.h"

@implementation RSRecordOwnerCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
     
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"提货人名字:";
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:nameLabel];
        
        
        
        
        UILabel * phoneLabel = [[UILabel alloc]init];
        phoneLabel.text = @"提货人电话:";
        phoneLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:phoneLabel];
        
        
        //提货人的名字
        UILabel * owerNameLabel = [[UILabel alloc]init];
        owerNameLabel.font = [UIFont systemFontOfSize:16];
        owerNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:owerNameLabel];
        _owerNameLabel = owerNameLabel;
        
        //提货人的电话号码
        UIButton * owerPhoneBtn = [[UIButton alloc]init];
        owerPhoneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [owerPhoneBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        [owerPhoneBtn setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:owerPhoneBtn];
         owerPhoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _owerPhoneBtn = owerPhoneBtn;
        
        
        
        UIButton * owerBtn = [[UIButton alloc]init];
        [owerBtn setTitle:@"修改提货人" forState:UIControlStateNormal];
        [owerBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        owerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [owerBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f0f0f0"]];
        [self.contentView addSubview:owerBtn];
        _owerBtn = owerBtn;
        
        nameLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .widthIs(90)
        .heightIs(20);
        
        
        phoneLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(nameLabel, 10)
        .bottomSpaceToView(self.contentView, 10)
        .widthIs(110);
        
        
        owerNameLabel.sd_layout
        .leftSpaceToView(nameLabel, 10)
        .topEqualToView(nameLabel)
        .bottomEqualToView(nameLabel)
        .widthRatioToView(self.contentView, 0.5);
        
        owerPhoneBtn.sd_layout
        .leftEqualToView(owerNameLabel)
        .rightEqualToView(owerNameLabel)
        .topEqualToView(phoneLabel)
        .bottomEqualToView(phoneLabel);
        
        
        
        
        owerBtn.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .widthIs(80)
        .heightIs(40);

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
