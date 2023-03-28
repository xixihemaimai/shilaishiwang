//
//  RSRSNewRoleThirdCell.m
//  石来石往
//
//  Created by mac on 2019/4/4.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSRSNewRoleThirdCell.h"

@implementation RSRSNewRoleThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        
        UIButton * fristBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [fristBtn setImage:[UIImage imageNamed:@"Rectangle 41 Copy 2"] forState:UIControlStateNormal];
        [self.contentView addSubview:fristBtn];
        _fristBtn = fristBtn;
        [fristBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        
        UILabel * fristLabel =  [[UILabel alloc]init];
        fristLabel.text = @"荒料入库";
        fristLabel.textAlignment = NSTextAlignmentLeft;
        fristLabel.font = [UIFont systemFontOfSize:14];
        fristLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:fristLabel];
        _fristLabel = fristLabel;
        
        fristBtn.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 15)
        .widthIs(20)
        .heightEqualToWidth();
        
        
        fristLabel.sd_layout
        .topEqualToView(fristBtn)
        .leftSpaceToView(fristBtn, 8)
        .bottomEqualToView(fristBtn)
        .widthIs(90);
        
        
        UIButton * secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [secondBtn setImage:[UIImage imageNamed:@"Rectangle 41 Copy 2"] forState:UIControlStateNormal];
        [self.contentView addSubview:secondBtn];
        _secondBtn = secondBtn;
          [secondBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        
        UILabel * secondLabel =  [[UILabel alloc]init];
        secondLabel.text = @"荒料入库";
        secondLabel.textAlignment = NSTextAlignmentLeft;
        secondLabel.font = [UIFont systemFontOfSize:14];
        secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:secondLabel];
        _secondLabel = secondLabel;
        
        
        
        secondBtn.sd_layout
        .leftSpaceToView(fristLabel, 4)
        .topSpaceToView(self.contentView, 15)
        .widthIs(20)
        .heightEqualToWidth();
        
        
        secondLabel.sd_layout
        .topEqualToView(secondBtn)
        .leftSpaceToView(secondBtn, 8)
        .bottomEqualToView(secondBtn)
        .widthIs(90);
        
//        secondBtn.sd_layout
//        .leftSpaceToView(self.contentView, SCW/2 + 12)
//        .centerYEqualToView(self.contentView)
//        .widthIs(20)
//        .heightEqualToWidth();
//

//        secondLabel.sd_layout
//        .centerYEqualToView(self.contentView)
//        .leftSpaceToView(secondBtn, 4)
//        .heightIs(20)
//        .widthIs(77);
        
        
        
        
        UIButton * thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [thirdBtn setImage:[UIImage imageNamed:@"Rectangle 41 Copy 2"] forState:UIControlStateNormal];
        [self.contentView addSubview:thirdBtn];
        [thirdBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        _thirdBtn = thirdBtn;
        
        UILabel * thirdLabel =  [[UILabel alloc]init];
        thirdLabel.text = @"荒料入库";
        thirdLabel.textAlignment = NSTextAlignmentLeft;
        thirdLabel.font = [UIFont systemFontOfSize:14];
        thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:thirdLabel];
        _thirdLabel = thirdLabel;
        
        
        thirdBtn.sd_layout
        .leftSpaceToView(secondLabel,8)
        .topSpaceToView(self.contentView, 15)
        .widthIs(20)
        .heightEqualToWidth();
        
        
        thirdLabel.sd_layout
        .topEqualToView(thirdBtn)
        .leftSpaceToView(thirdBtn, 8)
        .bottomEqualToView(thirdBtn)
        .widthIs(90);
        
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
        [self.contentView addSubview:bottomview];
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
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
