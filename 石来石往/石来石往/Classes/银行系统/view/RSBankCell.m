//
//  RSBankCell.m
//  石来石往
//
//  Created by mac on 2021/4/12.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSBankCell.h"

@implementation RSBankCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
//        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F7F5F6"];
        self.contentView.layer.backgroundColor = [UIColor colorWithRed:247/255.0 green:245/255.0 blue:246/255.0 alpha:1.0].CGColor;
        //视图
        UIView * bankView = [[UIView alloc]init];
        bankView.backgroundColor = [UIColor colorWithHexColorStr:@"#D8D8D8"];
        [self.contentView addSubview:bankView];
        //图片
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"编组"];
        [bankView addSubview:imageView];
        
        //小图片
        UIImageView * samllImageView = [[UIImageView alloc]init];
        samllImageView.image = [UIImage imageNamed:@"民生logo"];
        [bankView addSubview:samllImageView];
        //银行名称
        UILabel * bankLabel = [[UILabel alloc]init];
        bankLabel.text = @"民生银行";
        bankLabel.font = [UIFont systemFontOfSize:20];
        bankLabel.textAlignment = NSTextAlignmentLeft;
        bankLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [bankView addSubview:bankLabel];
        //账号
        UILabel * bankAcountlabel = [[UILabel alloc]init];
        bankAcountlabel.text = @"**** **** **** 8888";
        bankAcountlabel.font = [UIFont systemFontOfSize:20];
        bankAcountlabel.textAlignment = NSTextAlignmentLeft;
        bankAcountlabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [bankView addSubview:bankAcountlabel];
        
       
        bankView.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 0);
        bankView.layer.cornerRadius = 12;
        
        imageView.userInteractionEnabled = true;
        imageView.sd_layout.leftSpaceToView(bankView, 0).topSpaceToView(bankView, 0).rightSpaceToView(bankView, 0).bottomSpaceToView(bankView, 0);
        samllImageView.sd_layout.leftSpaceToView(bankView, 25).topSpaceToView(bankView, 28).widthIs(45).heightIs(45);
        bankLabel.sd_layout.leftSpaceToView(samllImageView, 15.5).topSpaceToView(bankView, 36.5).heightIs(28).rightSpaceToView(bankView, 15);
        
        bankAcountlabel.sd_layout.leftEqualToView(bankLabel).rightEqualToView(bankLabel).topSpaceToView(bankLabel, 10.5).heightIs(22.5);
        
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
