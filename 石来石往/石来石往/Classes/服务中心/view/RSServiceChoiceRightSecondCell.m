//
//  RSServiceChoiceRightSecondCell.m
//  石来石往
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServiceChoiceRightSecondCell.h"

@implementation RSServiceChoiceRightSecondCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
       RSServiceChoiceCustomButton * statusBtn = [[RSServiceChoiceCustomButton alloc]init];
       
        [statusBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        [statusBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F4F4F4"]];
        statusBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
        [statusBtn setImage:[UIImage imageNamed:@"矩形3拷贝5"] forState:UIControlStateNormal];
        statusBtn.layer.borderWidth = 1;
        statusBtn.layer.cornerRadius = 3;
        statusBtn.layer.masksToBounds = YES;
        statusBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:statusBtn];
        
        _statusBtn = statusBtn;
        nameLabel.sd_layout
        .leftSpaceToView(self.contentView, 16)
        .rightSpaceToView(self.contentView, 16)
        .topSpaceToView(self.contentView, 8)
        .heightIs((SCH/568) * 14);
        
        statusBtn.sd_layout
        .leftSpaceToView(self.contentView, 14)
        .rightSpaceToView(self.contentView, 14)
        .topSpaceToView(nameLabel, 7)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        
        
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
