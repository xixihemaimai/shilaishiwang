//
//  RSStorehouseDetailThirdCell.m
//  石来石往
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSStorehouseDetailThirdCell.h"

@implementation RSStorehouseDetailThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //提货人
        UILabel * personLabel = [[UILabel alloc]init];
       // personLabel.text = @"海西石材交易中心";
        personLabel.font = [UIFont systemFontOfSize:15];
        personLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        personLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:personLabel];
        _personLabel = personLabel;
        
        //电话号码
        UIButton * personPhoneBtn = [[UIButton alloc]init];
        personPhoneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        //personPhoneBtn..textColor = [UIColor colorWithHexColorStr:@"#666666"];
       // personPhoneNumber.textAlignment = NSTextAlignmentLeft;
        [personPhoneBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        [personPhoneBtn setBackgroundColor:[UIColor whiteColor]];
         personPhoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:personPhoneBtn];
        _personPhoneBtn = personPhoneBtn;
        
        //身份证号
//        UILabel * personCardLabel = [[UILabel alloc]init];
//        //personCardLabel.text = @"海西石材交易中心";
//        personCardLabel.font = [UIFont systemFontOfSize:15];
//        personCardLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
//        personCardLabel.textAlignment = NSTextAlignmentLeft;
//        [self.contentView addSubview:personCardLabel];
//        _personCardLabel = personCardLabel;
        
        personLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .heightIs(15);
        
        
//        personPhoneBtn.sd_layout
//        .leftEqualToView(personLabel)
//        .rightEqualToView(personLabel)
//        .topSpaceToView(personLabel, 10)
//        .heightIs(15);
        
        
        
        personPhoneBtn.sd_layout
        .leftEqualToView(personLabel)
        .rightEqualToView(personLabel)
        .topSpaceToView(personLabel, 10)
        .bottomSpaceToView(self.contentView, 10);
        
        
//        personCardLabel.sd_layout
//        .leftEqualToView(personPhoneBtn)
//        .rightSpaceToView(self.contentView, 0)
//        .topSpaceToView(personPhoneBtn, 10)
//        .bottomSpaceToView(self.contentView, 10);
        
        
        
        
        
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
