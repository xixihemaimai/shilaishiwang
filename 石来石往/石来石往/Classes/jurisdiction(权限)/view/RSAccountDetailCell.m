//
//  RSAccountDetailCell.m
//  权限
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAccountDetailCell.h"



#import "UIColor+HexColor.h"
#import <SDAutoLayout.h>





@implementation RSAccountDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView * cellImage = [[UIImageView alloc]init];
        [self.contentView addSubview:cellImage];
        _cellImage = cellImage;
        
        
        UILabel * titleNameLabel = [[UILabel alloc]init];
        titleNameLabel.textAlignment = NSTextAlignmentLeft;
        titleNameLabel.font = [UIFont systemFontOfSize:15];
        titleNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:titleNameLabel];
        _titleNameLabel = titleNameLabel;
        
        
        UITextField * textfield = [[UITextField alloc]init];
        textfield.font = [UIFont systemFontOfSize:14];
        textfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:textfield];
        _textfield = textfield;
        
        
        
        UIButton * sendMsgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sendMsgBtn setTitle:@"发送短信" forState:UIControlStateNormal];
        [sendMsgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendMsgBtn.layer.cornerRadius = 5;
        sendMsgBtn.layer.masksToBounds = YES;
        [sendMsgBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1c98e6"]];
        sendMsgBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _sendMsgBtn = sendMsgBtn;
        [self.contentView addSubview:sendMsgBtn];
        
 
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
        
        cellImage.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        //.topSpaceToView(self.contentView, 11)
        //.bottomSpaceToView(self.contentView, 11)
        .heightIs(23)
        .widthIs(23);
        
        
        titleNameLabel.sd_layout
        .centerYEqualToView(cellImage)
        .leftSpaceToView(cellImage, 6)
        .topEqualToView(cellImage)
        .bottomEqualToView(cellImage)
        .widthIs(90);
        
        
        
        
        sendMsgBtn.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(30)
        .widthIs(80);
        
        
        
        
        
        
        
        textfield.sd_layout
        .leftSpaceToView(titleNameLabel, 10)
        .topEqualToView(titleNameLabel)
        .bottomEqualToView(titleNameLabel)
        .rightSpaceToView(sendMsgBtn, 10);
        
        
        
        
        
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 13)
        .rightSpaceToView(self.contentView,13)
        .bottomSpaceToView(self.contentView,0)
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
