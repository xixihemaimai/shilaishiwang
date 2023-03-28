//
//  RSNewRoleSecondCell.m
//  石来石往
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSNewRoleSecondCell.h"

@implementation RSNewRoleSecondCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        //头部的按键比如荒料入库
        UIButton * touBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [touBtn setImage:[UIImage imageNamed:@"Rectangle 41 Copy 2"] forState:UIControlStateNormal];
        [touBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [self.contentView addSubview:touBtn];
        _touBtn = touBtn;
        
        
        //比如荒料入库的文字
        UILabel * touLabel = [[UILabel alloc]init];
        touLabel.text = @"荒料入库:";
        touLabel.textAlignment = NSTextAlignmentLeft;
        touLabel.font = [UIFont systemFontOfSize:14];
        touLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:touLabel];
        _touLabel = touLabel;
        
        
        
        touBtn.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 15)
        .widthIs(20)
        .heightEqualToWidth();
        
        
        touLabel.sd_layout
        .topEqualToView(touBtn)
        .leftSpaceToView(touBtn, 13)
        .bottomEqualToView(touBtn)
        .widthIs(90);
        
        
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
        .leftSpaceToView(touLabel, 4)
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
        .leftEqualToView(fristBtn)
        .topSpaceToView(fristBtn, 15)
        .widthIs(20)
        .heightEqualToWidth();
        
        
        thirdLabel.sd_layout
        .topEqualToView(thirdBtn)
        .leftSpaceToView(thirdBtn, 8)
        .bottomEqualToView(thirdBtn)
        .widthIs(90);
        
        
        
        
        UIButton * fourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [fourBtn setImage:[UIImage imageNamed:@"Rectangle 41 Copy 2"] forState:UIControlStateNormal];
        [self.contentView addSubview:fourBtn];
        _fourBtn = fourBtn;
         [fourBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        UILabel * fourLabel =  [[UILabel alloc]init];
        fourLabel.text = @"荒料入库";
        fourLabel.textAlignment = NSTextAlignmentLeft;
        fourLabel.font = [UIFont systemFontOfSize:14];
        fourLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:fourLabel];
        _fourLabel = fourLabel;
        
        fourBtn.sd_layout
        .leftEqualToView(secondBtn)
        .topSpaceToView(secondBtn, 15)
        .widthIs(20)
        .heightEqualToWidth();
        
        
        fourLabel.sd_layout
        .topEqualToView(fourBtn)
        .leftSpaceToView(fourBtn, 8)
        .bottomEqualToView(fourBtn)
        .widthIs(90);
        
        
        UIButton * fiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [fiveBtn setImage:[UIImage imageNamed:@"Rectangle 41 Copy 2"] forState:UIControlStateNormal];
        [fiveBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [self.contentView addSubview:fiveBtn];
        _fiveBtn = fiveBtn;
        
        UILabel * fiveLabel =  [[UILabel alloc]init];
        fiveLabel.text = @"加工跟单操作";
        fiveLabel.textAlignment = NSTextAlignmentLeft;
        fiveLabel.font = [UIFont systemFontOfSize:14];
        fiveLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:fiveLabel];
        _fiveLabel = fiveLabel;
        
        
        fiveBtn.sd_layout
        .leftEqualToView(thirdBtn)
        .topSpaceToView(thirdBtn, 15)
        .widthIs(20)
        .heightEqualToWidth();
        
        
        fiveLabel.sd_layout
        .topEqualToView(fiveBtn)
        .leftSpaceToView(fiveBtn, 8)
        .bottomEqualToView(fiveBtn)
        .widthIs(90);
        
        
        UIButton * sixBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sixBtn setImage:[UIImage imageNamed:@"Rectangle 41 Copy 2"] forState:UIControlStateNormal];
        [sixBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [self.contentView addSubview:sixBtn];
        _sixBtn = sixBtn;
        
        UILabel * sixLabel =  [[UILabel alloc]init];
        sixLabel.text = @"加工跟单查看";
        sixLabel.textAlignment = NSTextAlignmentLeft;
        sixLabel.font = [UIFont systemFontOfSize:14];
        sixLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:sixLabel];
        _sixLabel = sixLabel;
        
        sixBtn.sd_layout
        .leftEqualToView(fourBtn)
        .topSpaceToView(fourBtn, 15)
        .widthIs(20)
        .heightEqualToWidth();
        
        
        sixLabel.sd_layout
        .topEqualToView(sixBtn)
        .leftSpaceToView(sixBtn, 8)
        .bottomEqualToView(sixBtn)
        .widthIs(90);
        
        
        
        UIButton * sevenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sevenBtn setImage:[UIImage imageNamed:@"Rectangle 41 Copy 2"] forState:UIControlStateNormal];
        [sevenBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [self.contentView addSubview:sevenBtn];
        _sevenBtn = sevenBtn;
        
        UILabel * sevenLabel =  [[UILabel alloc]init];
        sevenLabel.text = @"出材率";
        sevenLabel.textAlignment = NSTextAlignmentLeft;
        sevenLabel.font = [UIFont systemFontOfSize:14];
        sevenLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:sevenLabel];
        _sevenLabel = sevenLabel;
        
        
        sevenBtn.sd_layout
        .leftEqualToView(fiveBtn)
        .topSpaceToView(fiveBtn, 15)
        .widthIs(20)
        .heightEqualToWidth();
        
        
        sevenLabel.sd_layout
        .topEqualToView(sevenBtn)
        .leftSpaceToView(sevenBtn, 8)
        .bottomEqualToView(sevenBtn)
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
