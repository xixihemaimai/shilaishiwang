//
//  RSChangeSelectSearchContentView.m
//  石来石往
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSChangeSelectSearchContentView.h"
#define margin 0
#define ECA 3

@interface RSChangeSelectSearchContentView()


@property (nonatomic,strong) UIView * functionView;

@end



@implementation RSChangeSelectSearchContentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
     
        [self setUI];
        
        
    }
    return self;
}



- (void)setUI{
    //这边要有一个魔板的内容
    
    UIView * menview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    menview.backgroundColor = [UIColor colorWithHexColorStr:@"#B2B2B2" alpha:0.5];
    [self addSubview:menview];
    menview.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMenview:)];
    
    [menview addGestureRecognizer:tap];
    
    //功能界面
    UIView * functionView = [[UIView alloc]initWithFrame:CGRectMake(0, -155, SCW, 155)];
    functionView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    [menview addSubview:functionView];
    _functionView = functionView;
    //上面的功能界面
    UIView * topFunctionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 108)];
    topFunctionView.backgroundColor = [UIColor clearColor];
    [functionView addSubview:topFunctionView];
    
    NSArray * styleArray = @[@"荒料",@"大板",@"花岗岩",@"生活",@"辅料",@"求购"];
    CGFloat btnW = (topFunctionView.yj_width - (ECA + 1)*margin)/ECA;
    CGFloat btnH = 54;
    for (int i = 0 ; i < styleArray.count; i++) {
        UIButton * publishBtn = [[UIButton alloc]init];
        NSInteger row = i / ECA;
        NSInteger colom = i % ECA;
        publishBtn.tag = 10000 + i;
        CGFloat btnX =  colom * (margin + btnW) + margin;
        CGFloat btnY =  row * (margin + btnH) + margin;
        publishBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [publishBtn setTitle:styleArray[i] forState:UIControlStateNormal];
        publishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        [publishBtn addTarget:self action:@selector(changeSelectIndex:) forControlEvents:UIControlEventTouchUpInside];
        [publishBtn setBackgroundColor:[UIColor clearColor]];
        [topFunctionView addSubview:publishBtn];
        
    }

    //分隔线
    UIView * middenView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topFunctionView.frame), SCW, 1)];
    middenView.backgroundColor = [UIColor colorWithHexColorStr:@"#D8D8D8"];
    [functionView addSubview:middenView];
    
    
    //下面取消功能按键
    UIButton * functionAllBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(middenView.frame), SCW, functionView.yj_height - CGRectGetMaxY(middenView.frame))];
    [functionAllBtn setBackgroundColor:[UIColor clearColor]];
    [functionAllBtn setTitle:@"全部" forState:UIControlStateNormal];
    [functionAllBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    functionAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [functionView addSubview:functionAllBtn];
    functionAllBtn.tag = 100;
    [functionAllBtn addTarget:self action:@selector(changeSelectIndex:) forControlEvents:UIControlEventTouchUpInside];
    
}



//显示界面
- (void)showMenView{
    [UIView animateWithDuration:0.3 animations:^{
        _functionView.frame = CGRectMake(0, 0, SCW, 155);
    }];

}


//隐藏界面
- (void)hideMenView{
    [UIView animateWithDuration:0.3 animations:^{
        _functionView.frame = CGRectMake(0, -155, SCW, 155);
    }];
}


//选择了当前需要的搜索的分类
- (void)changeSelectIndex:(UIButton *)selectIndexBtn{
    if ([self.delegate respondsToSelector:@selector(selectNeedSearchContent:)]) {
        [self.delegate selectNeedSearchContent:selectIndexBtn.tag];
    }
}






- (void)hideMenview:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(hideSelectSearchContentView)]) {
        [self.delegate hideSelectSearchContentView];
    } 
}



@end
