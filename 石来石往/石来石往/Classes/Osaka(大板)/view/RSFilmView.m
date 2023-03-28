//
//  RSFilmView.m
//  石来石往
//
//  Created by mac on 17/5/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSFilmView.h"

@interface RSFilmView ()
@end
/**多选中的片数进行设置*/
static NSInteger count = 0;
@implementation RSFilmView


- (void)setFilmArray:(NSArray *)filmArray{

    _filmArray = filmArray;
    NSMutableArray *Array = [NSMutableArray array];
    for (int i = 0; i< filmArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shoppingChoiceCount:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f5f5f5"]];
    
        btn.layer.cornerRadius = 2;
        btn.layer.masksToBounds = YES;
        [self addSubview:btn];
    
        if (btn.currentTitle.length > 2) {
            btn.sd_layout
            .widthIs(40)
            .heightIs(24);
        }else{
            btn.sd_layout
            .widthIs(24)
            .heightIs(24);
        }
        [Array addObject:btn];
        
        
    }
    // 此步设置之后_autoWidthViewsContainer的高度可以根据子view自适应
    //第一个参数每行几个,第二个参数子视图上下间距,第三个参数子视图之间左右间距,第四个参数两端距离顶部和底部的距离.,第五个参数两端距离左右的距离
    [self setupAutoWidthFlowItems:[Array copy] withPerRowItemsCount:7.5 verticalMargin:7.5 horizontalMargin:7.5 verticalEdgeInset:7.5 horizontalEdgeInset:7.5];
}


- (void)setDataAry:(NSMutableArray *)dataAry{
    _dataAry = dataAry;
    [_dataAry enumerateObjectsUsingBlock:^(RSPiecesModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn =(UIButton *)[self viewWithTag:idx+100];
    [btn setTitle:[NSString stringWithFormat:@"%@",obj.pieceNum] forState:UIControlStateNormal];
        if (obj.status == 1) {
            [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff570a"]];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.selected = YES;
        } else{
            [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f5f5f5"]];
            [btn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
            btn.selected = NO;
        }
    }];
    count = self.tempselectCount;
}



- (void)shoppingChoiceCount:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        count++;
         //这样是为了确定最里面的模型里面的按键的状态为什么样的保存起来
        [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff570a"]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }else{
        count--;
        //这样是为了确定最里面的模型里面的按键的状态为什么样的保存起来
        [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f5f5f5"]];
        [btn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    }
    self.piecesModel = self.filmArray[btn.tag - 100];
    self.piecesModel.status = btn.selected;
    if([self.delegate respondsToSelector:@selector(choiceSliceCount:andPSPiecesModel: andBtn:)]){
        [self.delegate choiceSliceCount:count andPSPiecesModel:self.piecesModel andBtn:btn];
    }
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //刚进来要对选中的片数进行初始化;
        if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
            
        }else{
            count = 0;
        }
    }
    return self;
}

@end
