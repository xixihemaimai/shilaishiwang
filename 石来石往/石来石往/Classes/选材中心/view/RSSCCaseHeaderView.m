//
//  RSSCCaseHeaderView.m
//  石来石往
//
//  Created by mac on 2021/10/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCCaseHeaderView.h"

@interface RSSCCaseHeaderView()

@property (nonatomic,strong)UIScrollView * scrollview;

@end

@implementation RSSCCaseHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //这边要弄滑动的
//        NSArray * titleArray = @[@"全部精选",@"住宅别墅",@"酒店会所",@"办公大楼"];
        UIScrollView * scrollview = [[UIScrollView alloc]init];
        scrollview.contentSize = CGSizeMake(4 * Width_Real(80) + 4 * Width_Real(12), 0);
        scrollview.showsHorizontalScrollIndicator = false;
        scrollview.showsVerticalScrollIndicator = false;
        [self addSubview:scrollview];
        scrollview.sd_layout.leftSpaceToView(self, Width_Real(16)).rightSpaceToView(self, Width_Real(16)).topSpaceToView(self, 0).heightIs(Height_Real(18) + Width_Real(80));
        _scrollview = scrollview;
        
        
    }
    return self;
}


- (void)setCaseArray:(NSArray *)caseArray{
    _caseArray = caseArray;
    
    _scrollview.contentSize = CGSizeMake(caseArray.count * Width_Real(80) + caseArray.count * Width_Real(12), 0);
    
    for (int i = 0; i < _caseArray.count; i++) {
        RSCaseTypeModel * caseTypeModel = _caseArray[i];
        NSInteger colom = i % _caseArray.count;
        CGFloat btnX =  colom * (Width_Real(12) + Width_Real(80));
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setBackgroundImage:[UIImage imageNamed:@"01"] forState:UIControlStateNormal];
        NSString * url = [URL_HEADER_TEXT_IOS substringToIndex:URL_HEADER_TEXT_IOS.length - 1];
        btn.titleLabel.numberOfLines = 2;
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,caseTypeModel.url]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"01"]];
        
        NSMutableString * mutableString1=[NSMutableString stringWithFormat:@"%@",caseTypeModel.nameCn];
        if (caseTypeModel.nameCn.length > 4) {
            [mutableString1 insertString:@"\n" atIndex:4];
        }
        [btn setTitle:mutableString1 forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightSemibold];
        [btn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(jumpCaseAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.scrollview addSubview:btn];
        btn.sd_layout.leftSpaceToView(self.scrollview, btnX).topSpaceToView(self.scrollview, Height_Real(9)).widthIs(Width_Real(80)).heightEqualToWidth();
        
        [btn ls_getViewWithCornerRadius:Width_Real(4)];
        
//        btn.layer.cornerRadius = Width_Real(4);
//        btn.layer.masksToBounds = true;
    }
}





//FIXME:选择要跳转的类型
- (void)jumpCaseAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(jumpCaseTypeIndex:)]) {
        [self.delegate jumpCaseTypeIndex:btn.tag];
    }
}



@end
