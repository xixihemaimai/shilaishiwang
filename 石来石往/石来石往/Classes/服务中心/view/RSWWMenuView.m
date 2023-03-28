//
//  RSWWMenuView.m
//  石来石往
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSWWMenuView.h"
#define YJScreenW [UIScreen mainScreen].bounds.size.width

#define margin 10
#define ECA 2
#import "RSPrintModel.h"

@interface RSWWMenuView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) UIButton * currentBtn;


@end

@implementation RSWWMenuView

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 初始化设置代码
        // 创建scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        self.scrollView = scrollView;
        // 添加代理
        scrollView.delegate = self;
        // 去掉水平和垂直滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        // 设置分页效果
        scrollView.pagingEnabled = YES;
        
        [self addSubview:scrollView];
        
        
        // 添加分页控制器
        UIPageControl *pageC = [[UIPageControl alloc] init];
        self.pageControl = pageC;
        // 设置当前的页码
        pageC.currentPage = 0;
        // 设置选中页码的颜色
        pageC.currentPageIndicatorTintColor = [UIColor colorWithHexColorStr:@"#3385ff"];
        // 设置页码的颜色
        pageC.pageIndicatorTintColor = [UIColor grayColor];
        // 添加到scrollView里
        [self addSubview:pageC];
        
    }
    return self;
}

// 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置frame
    self.scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.pageControl.frame = CGRectMake(0, self.bounds.size.height - 20, 100, 20);
    CGPoint center = self.pageControl.center;
    center.x = self.bounds.size.width * 0.5;
    self.pageControl.center = center;
}


// 接收传递进来的模型数据
- (void)setMenus:(NSArray *)menus
{
    _menus = menus;
    // 判断有多少页
    /*
     NSInteger page = 0;
     int extra = menus.count % 10;
     if (extra) { // 余数不为0
     page = menus.count / 10 + 1;
     }else{ // 余数为0
     page = menus.count / 10;
     }*/
    
    // 判断有多少页
    NSInteger page = menus.count / 6;
    int extra = menus.count % 6;
    if (extra) { // 余数不为0
        page++;
    }
    
    // 设置总页码
    self.pageControl.numberOfPages = page;
    
    // 设置scrollView的内容尺寸
    self.scrollView.contentSize = CGSizeMake(page * self.bounds.size.width, 0);
    
    // 计算按钮的宽高
    CGFloat btnW = ((SCW - 16) - (ECA + 1)*margin)/ECA;
    CGFloat btnH = 40;
    for (int i = 0; i < page; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(self.bounds.size.width * i, 0, self.bounds.size.width, self.bounds.size.height - 20);
        // 添加到scrollView
        [self.scrollView addSubview:view];
        NSInteger num = 6;
        if (extra && i == page-1) {
            num = extra;
        }
        for (int j = 0;j < num; j++) {
            // 索引
            NSInteger index = j + i * 6;
            // 获取模型
            RSPrintModel * printmodel = self.menus[index];
            // 创建按钮
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = index + 10000;
            NSInteger row = j / ECA;
            NSInteger colom = j % ECA;
            CGFloat btnX =  colom * (margin + btnW) + margin;
            CGFloat btnY =  row * (margin + btnH) + margin;
            [btn setTitle:[NSString stringWithFormat:@"erp单号:%@,第%ld页",printmodel.erpOutboundNo,(long)printmodel.pageNum] forState:UIControlStateNormal];
            btn.layer.cornerRadius = 4;
            btn.layer.masksToBounds = YES;
            btn.titleLabel.font = [UIFont systemFontOfSize:10];
//            if (j == 0) {
//                btn.selected = YES;
//                self.currentBtn = btn;
//                [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
//            }
//            else{
                [btn setBackgroundColor:[UIColor colorWithHexColorStr:@""]];
//            }
            [btn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
            
            // 设置按钮的frame
            //btn.frame = CGRectMake(j % 5 * btnW, j / 5 * btnH, btnW, btnH);
            btn.frame = CGRectMake( btnX,btnY, btnW, btnH);
            // 给按钮添加点击事件
            [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchDown];
            // 将按钮添加到uiview里
            [view addSubview:btn];
        }
    }
}

// 菜单按钮的点击事件
- (void)menuBtnClick:(UIButton *)menuBtn
{
    if (menuBtn.selected) {
        [menuBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        self.currentBtn.selected = NO;
        menuBtn.selected = YES;
        //self.preBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.currentBtn = menuBtn;
    }else{
        [menuBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        self.currentBtn.selected = NO;
        menuBtn.selected = YES;
        //self.preBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.currentBtn setBackgroundColor:[UIColor colorWithHexColorStr:@""]];
        self.currentBtn = menuBtn;
    }
    if ([self.delegate respondsToSelector:@selector(menuBtnClick:)]) {
        [self.delegate menuBtnClick:menuBtn];
    }
}

// 监听scrollView的滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageCount = scrollView.contentOffset.x / YJScreenW + 0.5;
    self.pageControl.currentPage = pageCount;
}



@end
