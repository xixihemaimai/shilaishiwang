//
//  RSEmptyDataView.m
//  石来石往
//
//  Created by mac on 2020/2/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSEmptyDataView.h"
//每列间隔
#define KViewMargin 10
//每行列数高
#define KVieH 28

@interface RSEmptyDataView()
{
    UIButton *tmpBtn;
    CGFloat btnW;
    CGFloat btnViewHeight;
}



@end

@implementation RSEmptyDataView



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        UIImageView * errorImageView = [[UIImageView alloc]init];
        errorImageView.image = [UIImage imageNamed:@"Group 79"];
        errorImageView.frame = CGRectMake(self.bounds.size.width/2 - 92, 0, 184, 130);
        [self addSubview:errorImageView];


        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"没有符合筛选添加的石材";
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(self.bounds.size.width/2 - 92, CGRectGetMaxY(errorImageView.frame) + 20, 184, 20);
        [self addSubview:titleLabel];


        UILabel * nametitleLabel = [[UILabel alloc]init];
        nametitleLabel.text = @"你可能想找";
        nametitleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nametitleLabel.font = [UIFont systemFontOfSize:14];
        nametitleLabel.textAlignment = NSTextAlignmentLeft;
        //titleLabel.frame = CGRectMake(0, 0, SCW - 24, 20);
        nametitleLabel.frame = CGRectMake(43, CGRectGetMaxY(titleLabel.frame) + 10, SCW - 86, 20);
        [self addSubview:nametitleLabel];
//        _nametitleLabel = nametitleLabel;


        UIView * btnsView = [[UIView alloc]initWithFrame:CGRectMake(43, CGRectGetMaxY(nametitleLabel.frame) + 10, SCW - 86, 100)];
        btnsView.backgroundColor = [UIColor clearColor];
        [self addSubview:btnsView];
        _btnsView = btnsView;
    }
    return self;
}

- (void)addKeywordArray:(NSArray *)keywordArray {
    /**
     *  数组存放适配屏幕大小的每行按钮的个数
     */
     NSMutableArray *indexbtns=[self returnBtnsForRowAndCol:keywordArray];
     //统计按钮View的高度
     btnViewHeight = indexbtns.count*(KVieH+KViewMargin)+10;
     //设置btnView的高度
     self.btnsView.height = btnViewHeight;
     NSInteger count=0;
     CGFloat Y;
    //九宫格
        for (int row=0; row<indexbtns.count; row++) {
            for (int col=0; col<[indexbtns[row]intValue]; col++) {
                CGFloat X;
                Y=10+row*(KViewMargin+KVieH);
                //按钮的宽
                btnW = [self returnBtnWithWithStr:keywordArray[count]];
                if (tmpBtn&&col) {
                    X=CGRectGetMaxX(tmpBtn.frame)+KViewMargin;
                }else{
                    X=KViewMargin+col*btnW;
                }
                UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(X, Y, btnW, KVieH)];
                [btn setTitle:keywordArray[count] forState:UIControlStateNormal];
                btn.titleLabel.font=[UIFont systemFontOfSize:12];
                //btn.layer.borderWidth=1;
                //btn.layer.borderColor = Color(156,156,156).CGColor;
                [btn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
                //[btn setTitleColor:Color(202, 48, 130) forState:UIControlStateSelected];
                [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F3F1F2"]];
                btn.layer.cornerRadius=7.5;
                //btn.tag=[keywordArray[count] integerValue];
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                //[self.allBtnArrays addObject:btn];
                tmpBtn=btn;
                [self.btnsView addSubview:btn];
                count+=1;
            }
        }
}

#pragma mark-按钮点击事件
- (void)btnClick:(UIButton *)btn
{
//    btn.selected = !btn.isSelected;
    if ([self.delegate respondsToSelector:@selector(selectItemContentTitle:andType:)]) {
        [self.delegate selectItemContentTitle:btn.currentTitle andType:self.type];
    }
//    if (btn.isSelected) {
//        btn.layer.borderColor = Color(202, 48, 130).CGColor;
//    }else
//    {
//        btn.layer.borderColor = Color(156, 156, 156).CGColor;
//    }
}


- (NSMutableArray*)returnBtnsForRowAndCol:(NSArray *)btnMsgArrays{
    CGFloat allWidth = 0.0;
    NSInteger countW=0;
    NSMutableArray *indexbtns=[NSMutableArray array];
    NSMutableArray *tmpbtns=[NSMutableArray array];
    for (int j=0;j<btnMsgArrays.count;j++) {
        CGFloat width=[self returnBtnWithWithStr:btnMsgArrays[j]];
        allWidth+=width+KViewMargin;
        countW+=1;
        if (allWidth>SCW - 84 -10) {
            //判断第一行情况
            NSInteger lastNum=[[tmpbtns lastObject]integerValue];
            [indexbtns addObject:@(lastNum)];
            [tmpbtns removeAllObjects];
            allWidth=0.0;
            countW=0;
            j-=1;
        }else{
            [tmpbtns addObject:@(countW)];
        }
    }
    if (tmpbtns.count!=0) {
        NSInteger lastNum=[[tmpbtns lastObject]integerValue];
        [indexbtns addObject:@(lastNum)];
    }
    return indexbtns;
}


-(CGFloat)returnBtnWithWithStr:(NSString *)str{
    //计算字符长度
    NSDictionary *minattributesri = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize mindetailSizeRi = [str boundingRectWithSize:CGSizeMake(100, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:minattributesri context:nil].size;
    return mindetailSizeRi.width + 12;
    
}


@end
