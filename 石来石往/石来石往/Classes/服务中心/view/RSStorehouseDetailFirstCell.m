//
//  RSStorehouseDetailFirstCell.m
//  石来石往
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSStorehouseDetailFirstCell.h"

@implementation RSStorehouseDetailFirstCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //名字
        UILabel * companyName = [[UILabel alloc]init];
       // companyName.text = @"海西石材交易中心";
        companyName.font = [UIFont systemFontOfSize:15];
        companyName.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        companyName.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:companyName];
        _companyName = companyName;
        
        //电话号码
        UIButton * companyPhoneBtn = [[UIButton alloc]init];
       // companyPhoneName.text = @"海西石材交易中心";
        //companyPhoneName.font = [UIFont systemFontOfSize:15];
        companyPhoneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
       // [companyPhoneBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        //companyPhoneBtn.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        //companyPhoneBtn.textAlignment = NSTextAlignmentLeft;
        companyPhoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:companyPhoneBtn];
        _companyPhoneBtn = companyPhoneBtn;
        
        
        
        companyName.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 5)
        .heightIs(15);
        
        companyPhoneBtn.sd_layout
        .leftEqualToView(companyName)
        .rightEqualToView(companyName)
        .topSpaceToView(companyName, 5)
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
