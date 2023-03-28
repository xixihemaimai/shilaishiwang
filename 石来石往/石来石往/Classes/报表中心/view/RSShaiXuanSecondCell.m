//
//  RSShaiXuanSecondCell.m
//  石来石往
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSShaiXuanSecondCell.h"

@implementation RSShaiXuanSecondCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        UITextField * namefield = [[UITextField alloc]init];
        namefield.backgroundColor = [UIColor colorWithHexColorStr:@"#F4F4F4"];
        namefield.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
        namefield.layer.borderWidth = 1;
        namefield.layer.cornerRadius = 3;
        namefield.layer.masksToBounds = YES;
        
        [self.contentView addSubview:namefield];
        
        _namefield = namefield;
        nameLabel.sd_layout
        .leftSpaceToView(self.contentView, 16)
        .rightSpaceToView(self.contentView, 16)
        .topSpaceToView(self.contentView, 8)
        .heightIs((SCH/568) * 14);
    
        
        
        namefield.sd_layout
        .leftSpaceToView(self.contentView, 14)
        .rightSpaceToView(self.contentView, 14)
        .topSpaceToView(nameLabel, 7)
        .bottomSpaceToView(self.contentView, 0);
        
        
        namefield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
        namefield.leftViewMode = UITextFieldViewModeAlways;
        
        
        
        
        
        
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
