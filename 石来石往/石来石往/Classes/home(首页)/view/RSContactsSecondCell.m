//
//  RSContactsSecondCell.m
//  石来石往
//
//  Created by mac on 2019/1/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSContactsSecondCell.h"

@implementation RSContactsSecondCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
       //联系人地址
        UIImageView * touImageView = [[UIImageView alloc]init];
        touImageView.contentMode = UIViewContentModeScaleAspectFill;
        touImageView.clipsToBounds = YES;
        touImageView.image = [UIImage imageNamed:@"联系人地址"];
        [self.contentView addSubview:touImageView];
        
        //地址
        UILabel * contactsNameLabel =[[UILabel alloc]init];
        contactsNameLabel.textAlignment = NSTextAlignmentLeft;
        contactsNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        contactsNameLabel.font = [UIFont systemFontOfSize:16];
        contactsNameLabel.text = @"陈先生";
        contactsNameLabel.numberOfLines = 0;
        [self.contentView addSubview:contactsNameLabel];
        _contactsNameLabel = contactsNameLabel;
        
        
        //默认图
        UIImageView * defultImageView = [[UIImageView alloc]init];
        defultImageView.image = [UIImage imageNamed:@"默认"];
        defultImageView.contentMode = UIViewContentModeScaleAspectFill;
        defultImageView.clipsToBounds =YES;
        [self.contentView addSubview:defultImageView];
        _defultImageView = defultImageView;
        
        
        //编辑按键
        UIButton * contactsEditBtn = [[UIButton alloc]init];
        [contactsEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [contactsEditBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        contactsEditBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [contactsEditBtn setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:contactsEditBtn];
        _contactsEditBtn = contactsEditBtn;
        
        //中间格线
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self.contentView addSubview:midView];
        
        
        //删除按键
        UIButton * contactsDeletBtn = [[UIButton alloc]init];
        [contactsDeletBtn setTitle:@"删除" forState:UIControlStateNormal];
        [contactsDeletBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        contactsDeletBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [contactsDeletBtn setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:contactsDeletBtn];
        _contactsDeletBtn = contactsDeletBtn;
        
        //底下横线
        UIView * bottomview =[[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomview];
        
        
        touImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .widthIs(32)
        .heightEqualToWidth();
        
        contactsNameLabel.sd_layout
        .leftSpaceToView(touImageView, 9)
        .topEqualToView(touImageView)
        .heightIs(touImageView.yj_height/2)
        .widthRatioToView(self.contentView, 0.5);
        
        defultImageView.sd_layout
        .leftSpaceToView(contactsNameLabel, 0)
        .topEqualToView(contactsNameLabel)
        .widthIs(28)
        .heightIs(16);
        
        contactsDeletBtn.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .widthIs(32)
        .heightEqualToWidth();
        
        
        midView.sd_layout
        .rightSpaceToView(contactsDeletBtn, 9)
        .topEqualToView(contactsDeletBtn)
        .bottomEqualToView(contactsDeletBtn)
        .widthIs(1);
        
        
        
        contactsEditBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(midView, 9)
        .widthIs(32)
        .heightEqualToWidth();
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
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
