//
//  YBScreenCell.m
//  UISegementController
//
//  Created by mac on 2017/7/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "YBScreenCell.h"

@interface YBScreenCell ()
{
     
}
@end



@implementation YBScreenCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
       
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:14];
//        nameLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        nameLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .heightRatioToView(self.contentView, 0.5)
        .widthIs(20);
        
        
        UIView * blackview = [[UIView alloc]init];
        blackview.backgroundColor = [UIColor colorWithHexColorStr:@"#f4f4f4"];
        [self.contentView addSubview:blackview];
        
        blackview.sd_layout
        .leftSpaceToView(nameLabel, 10)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 10)
        .bottomSpaceToView(self.contentView, 10);
        
       
        
        
       
        RSDetailScreenButton * choiceBtn = [[RSDetailScreenButton alloc]init];
        choiceBtn.layer.cornerRadius = 4;
        choiceBtn.layer.masksToBounds = YES;
        [choiceBtn setBackgroundColor:[UIColor whiteColor]];
        choiceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        choiceBtn.layer.borderWidth = 1;
        choiceBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#d8d8d8"].CGColor;
        [choiceBtn setTitle:@"大于" forState:UIControlStateNormal];
        [choiceBtn setImage:[UIImage imageNamed:@"下来三角形"] forState:UIControlStateNormal];
        
        
        [choiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [blackview addSubview:choiceBtn];
        _choiceBtn = choiceBtn;
        
        choiceBtn.sd_layout
        .leftSpaceToView(blackview, 9)
        .topSpaceToView(blackview, 5.5)
        .bottomSpaceToView(blackview, 5.5)
        .widthIs(79);
        
        
        
        UITextField * textfield = [[UITextField alloc]init];
        textfield.backgroundColor = [UIColor whiteColor];
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        //textfield.keyboardType = UIKeyboardTypeNumberPad;
        [blackview addSubview:textfield];
        _textfield = textfield;
        textfield.sd_layout
        .leftSpaceToView(choiceBtn, 9)
        .topEqualToView(choiceBtn)
        .bottomEqualToView(choiceBtn)
        .rightSpaceToView(blackview, 9);
        
        
        
    }
    
    return self;
    
    
    
}









- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
