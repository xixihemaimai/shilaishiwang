//
//  RSHuangSecondCell.m
//  石来石往
//
//  Created by mac on 2018/7/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSHuangSecondCell.h"

@implementation RSHuangSecondCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        //标题
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"面积";
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleLabel.font = [UIFont systemFontOfSize:11];
        titleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        
        //背景
        UIView * choiceTitleBackView = [[UIView alloc]init];
        choiceTitleBackView.backgroundColor = [UIColor colorWithHexColorStr:@"#F4F4F4"];
        choiceTitleBackView.userInteractionEnabled = YES;
        [self.contentView addSubview:choiceTitleBackView];
        
        
        //按键
        RSDetailScreenButton * choiceBtn = [[RSDetailScreenButton alloc]init];
        choiceBtn.layer.cornerRadius = 4;
        choiceBtn.layer.masksToBounds = YES;
        [choiceBtn setBackgroundColor:[UIColor whiteColor]];
        choiceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        choiceBtn.layer.borderWidth = 1;
        choiceBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#d8d8d8"].CGColor;
        [choiceBtn setTitle:@"大于" forState:UIControlStateNormal];
        [choiceBtn setImage:[UIImage imageNamed:@"下来三角形"] forState:UIControlStateNormal];
        [choiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [choiceTitleBackView addSubview:choiceBtn];
        _choiceBtn = choiceBtn;
        
        
        //搜索内容
        UITextField * textfield = [[UITextField alloc]init];
        textfield.backgroundColor = [UIColor whiteColor];
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        //textfield.keyboardType = UIKeyboardTypeNumberPad;
        [choiceTitleBackView addSubview:textfield];
        _textfield = textfield;
        
        
        UILabel * textLabel = [[UILabel alloc]init];
        textLabel.text = @"m";
        textLabel.font = [UIFont systemFontOfSize:12];
        textLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [choiceTitleBackView addSubview:textLabel];
        _textLabel = textLabel;
        
        
        
        
        titleLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 5)
        .widthIs(24)
        .heightEqualToWidth();
        
        
        
        choiceTitleBackView.sd_layout
        .leftSpaceToView(titleLabel, 7)
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 5)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        choiceBtn.sd_layout
        .centerYEqualToView(choiceTitleBackView)
        .leftSpaceToView(choiceTitleBackView, 4)
        .widthIs(50)
        .heightIs(30);
        
        
        textfield.sd_layout
        .leftSpaceToView(choiceBtn, 7)
        .centerYEqualToView(choiceTitleBackView)
        .rightSpaceToView(choiceTitleBackView, 6)
        .heightIs(30);
    
        
        textLabel.sd_layout
        .centerYEqualToView(choiceTitleBackView)
        .rightSpaceToView(choiceTitleBackView, 7)
        .heightIs(18)
        .widthIs(22);
        
        
        
        
        
        
        
        
        
    }
    return self;
}
@end
