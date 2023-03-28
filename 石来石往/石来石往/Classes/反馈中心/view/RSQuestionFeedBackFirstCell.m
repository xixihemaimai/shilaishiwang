//
//  RSQuestionFeedBackFirstCell.m
//  石来石往
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSQuestionFeedBackFirstCell.h"
#define ECA 3
#define margin 10

@interface RSQuestionFeedBackFirstCell()

@property (nonatomic,strong)NSArray * titleArray;

@property (nonatomic,strong)UIButton * currentSelectBtn;
@end



@implementation RSQuestionFeedBackFirstCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        
        self.titleArray = @[@"闪退问题",@"BUG问题",@"数据纠错",@"改进建议",@"市场服务",@"其他"];
        
        
        CGFloat btnW = (SCW - (ECA + 1)*margin)/ECA;
        CGFloat btnH = 35;
        for (int i = 0 ; i < self.titleArray.count; i++) {
            UIButton * selectBtn = [[UIButton alloc]init];
            NSInteger row = i / ECA;
            NSInteger colom = i % ECA;
            selectBtn.tag = 100000 + i;
            CGFloat btnX =  colom * (margin + btnW) + margin;
            CGFloat btnY =  row * (margin + btnH) + margin;
            selectBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            [selectBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
            [selectBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形1拷贝3"] forState:UIControlStateNormal];
            [selectBtn setBackgroundImage:[UIImage imageNamed:@"选中2"] forState:UIControlStateSelected];
            [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FA6A00"] forState:UIControlStateSelected];
            if (i == 1) {
                [self questionFeedBackButtonTouchClick:selectBtn];
            }
            [self.contentView addSubview:selectBtn];
            [selectBtn addTarget:self action:@selector(questionFeedBackButtonTouchClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}


- (void)questionFeedBackButtonTouchClick:(UIButton *)selectBtn{
    
    /**
     闪退问题：stwt
     bug问题：bug
     数据纠错：sjjc
     改进建议gjjy
     市场服务：scfw
     其他：qt
     */
    
    self.currentSelectBtn.selected = NO;
    selectBtn.selected = YES;
    self.currentSelectBtn = selectBtn;
    NSString * type = [NSString string];
    switch (selectBtn.tag) {
        case 100000:
            type = @"stwt";
            break;
        case 100001:
            type = @"bug";
            break;
        case 100002:
            type = @"sjjc";
            break;
        case 100003:
            type = @"gjjy";
            break;
        case 100004:
            type = @"scfw";
            break;
        case 100005:
            type = @"qt";
            break;
    }
    if ([self.delegate respondsToSelector:@selector(currentSelectQuestionBtnTitle:)]) {
        [self.delegate currentSelectQuestionBtnTitle:type];
    }
    
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
