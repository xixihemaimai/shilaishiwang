//
//  RSNewRoleFirstCell.m
//  石来石往
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSNewRoleFirstCell.h"

@implementation RSNewRoleFirstCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"角色名称";
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:titleLabel];
        
        
        
        UITextField * titleTextfield = [[UITextField alloc]init];
        titleTextfield.placeholder = @"请输入角色";
        titleTextfield.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        titleTextfield.textAlignment = NSTextAlignmentLeft;
        titleTextfield.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:titleTextfield];
        _titleTextfield = titleTextfield;
        
        titleLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .heightIs(23)
        .widthIs(66);
        
        
        titleTextfield.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(titleLabel, 11)
        .rightSpaceToView(self.contentView, 12)
        .topEqualToView(titleLabel)
        .bottomEqualToView(titleLabel);
        
        
        
        
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
