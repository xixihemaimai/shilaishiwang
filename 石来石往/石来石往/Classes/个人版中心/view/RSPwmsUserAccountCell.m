//
//  RSPwmsUserAccountCell.m
//  石来石往
//
//  Created by mac on 2019/4/3.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPwmsUserAccountCell.h"

@implementation RSPwmsUserAccountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        UIImageView * accountImageView = [[UIImageView alloc]init];
        accountImageView.image = [UIImage imageNamed:@"添加2"];
        accountImageView.contentMode = UIViewContentModeScaleAspectFill;
        accountImageView.clipsToBounds = YES;
        [self.contentView addSubview:accountImageView];
        _accountImageView = accountImageView;
        
        UILabel * addAccountLabel = [[UILabel alloc]init];
        addAccountLabel.text = @"添加公司";
        addAccountLabel.font = [UIFont systemFontOfSize:18];
        addAccountLabel.textAlignment = NSTextAlignmentLeft;
        addAccountLabel.textColor = [UIColor colorWithHexColorStr:@"#3385FF"];
        [self.contentView addSubview:addAccountLabel];
        _addAccountLabel = addAccountLabel;
        
        accountImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .widthIs(27)
        .heightEqualToWidth();
        
        
        addAccountLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(accountImageView, 19)
        .rightSpaceToView(self.contentView, 12)
        .heightIs(25);
        
        
        
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
