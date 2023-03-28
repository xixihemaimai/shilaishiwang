//
//  HomeMenuView.m
//  08-美团首页九宫格菜单
//
//  Created by Apple on 16/9/7.
//  Copyright © 2016年 yunjia. All rights reserved.
//

#import "HomeMenuView.h"

#define YJScreenW [UIScreen mainScreen].bounds.size.width
#define ECA 3
#define margin 10

#import "RSChoiceFreeServiceModel.h"

@interface HomeMenuView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

/**用来保存用被选中的数组*/
@property (nonatomic,strong)NSMutableArray * selectArray;


@end
@implementation HomeMenuView

- (NSMutableArray *)selectArray{
    
    if (_selectArray == nil) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}



// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 初始化设置代码
        
        self.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
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
    NSInteger page = menus.count / 9;
    int extra = menus.count % 9;
    if (extra) { // 余数不为0
        page++;
    }

    // 设置总页码
    self.pageControl.numberOfPages = page;
    
    // 设置scrollView的内容尺寸
    self.scrollView.contentSize = CGSizeMake(page * self.bounds.size.width, 0);
    
    // 计算按钮的宽高
    CGFloat btnW = (self.bounds.size.width - (ECA + 1)*margin)/ECA;
    CGFloat btnH = 40;
    for (int i = 0; i < page; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(self.bounds.size.width * i, 0, self.bounds.size.width, self.bounds.size.height - 20);
        // 添加到scrollView
        [self.scrollView addSubview:view];
        NSInteger num = 9;
        if (extra && i == page-1) {
            num = extra;
        }
        for (int j = 0;j < num; j++) {
            // 索引
            NSInteger index = j + i * 9;
            // 获取模型
           // MenuItem *item = self.menus[index];
            // 创建按钮
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = index;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            NSInteger row = j / ECA;
            NSInteger colom = j % ECA;
            CGFloat btnX =  colom * (margin + btnW) + margin;
            CGFloat btnY =  row * (margin + btnH) + margin;
            
           // [btn setImage:[UIImage imageNamed:item.image] forState:UIControlStateNormal];
            RSChoiceFreeServiceModel * choicefreeservicemodel = self.menus[index];
            [btn setTitle:[NSString stringWithFormat:@"%@",choicefreeservicemodel.USER_NAME] forState:UIControlStateNormal];
            if (choicefreeservicemodel.isChose) {
                //被选中
                btn.selected = YES;
                [btn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                [self.selectArray addObject:choicefreeservicemodel];
            }else{
                //没有选中
                btn.selected = NO;
                [btn setTitleColor:[UIColor colorWithHexColorStr:@"#616161"] forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor whiteColor]];
//                for (int i = 0; i < self.selectArray.count; i++) {
//                    RSChoiceFreeServiceModel * choicefreeservicemodel = self.selectArray[i];
//                    if ([btn.currentTitle isEqualToString:choicefreeservicemodel.USER_NAME]) {
//                        [self.selectArray removeObjectAtIndex:i];
//                        break;
//                    }
//                }

            }
            btn.layer.cornerRadius = 6;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor colorWithHexColorStr:@"#E4E5E7"].CGColor;
            btn.layer.masksToBounds = YES;
            // 设置按钮的frame
            //j % 3 * btnW  j / 3 * btnH
            btn.frame = CGRectMake( btnX,btnY, btnW, btnH);
            // 给按钮添加点击事件
            [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchDown];
            // 将按钮添加到uiview里
            [view addSubview:btn];
            
            
        
            
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(selectArray:)]) {
        [self.delegate selectArray:self.selectArray];
    }
    
}

// 菜单按钮的点击事件
- (void)menuBtnClick:(UIButton *)menuBtn
{
    menuBtn.selected = !menuBtn.selected;
    if (menuBtn.selected) {
        
        //选中
        [menuBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [menuBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        RSChoiceFreeServiceModel * choicefreeservicemodel = self.menus[menuBtn.tag];
       // NSString * temp1 = [NSString stringWithFormat:@"%@,%@,%@,%@",choicefreeservicemodel.ID,choicefreeservicemodel.dispatchpersonlmodel.dispatchPersonlId,choicefreeservicemodel.user_phone,choicefreeservicemodel.USER_NAME];
       // if (self.selectArray.count < 1) {
            //这边是没有选中的情况下
            [self.selectArray addObject:choicefreeservicemodel];
//        }else{
//            //这边是已经有派遣服务人员的情况
//            for (int i = 0; i < self.selectArray.count; i++) {
//                RSChoiceFreeServiceModel * choicefreeservicemodel = self.selectArray[i];
//                NSString * temp = [NSString stringWithFormat:@"%@,%@,%@,%@",choicefreeservicemodel.ID,choicefreeservicemodel.dispatchpersonlmodel.dispatchPersonlId,choicefreeservicemodel.user_phone,choicefreeservicemodel.USER_NAME];
//                if (![temp1 isEqualToString:temp]) {
//                    [self.selectArray addObject:choicefreeservicemodel];
//                    //break;
//                }
//            }
//        }
    }else{
        //取消选中
        [menuBtn setTitleColor:[UIColor colorWithHexColorStr:@"#616161"] forState:UIControlStateNormal];
        [menuBtn setBackgroundColor:[UIColor whiteColor]];
       RSChoiceFreeServiceModel * choicefreeservicemodel = self.menus[menuBtn.tag];
        NSString * temp1 = [NSString stringWithFormat:@"%@,%@,%@,%@",choicefreeservicemodel.ID,choicefreeservicemodel.dispatchpersonlmodel.dispatchPersonlId,choicefreeservicemodel.user_phone,choicefreeservicemodel.USER_NAME];
        for (int i = 0; i < self.selectArray.count; i++) {
            RSChoiceFreeServiceModel * choicefreeservicemodel = self.selectArray[i];
            NSString * temp = [NSString stringWithFormat:@"%@,%@,%@,%@",choicefreeservicemodel.ID,choicefreeservicemodel.dispatchpersonlmodel.dispatchPersonlId,choicefreeservicemodel.user_phone,choicefreeservicemodel.USER_NAME];
            if ([temp1 isEqualToString:temp]) {
                [self.selectArray removeObjectAtIndex:i];
                break;
            }
        }
    }
//    if ([self.delegate respondsToSelector:@selector(menuBtnClick:andSelectArray:)]) {
//        [self.delegate menuBtnClick:menuBtn andSelectArray:self.selectArray];
//    }
    if ([self.delegate respondsToSelector:@selector(selectArray:)]) {
        [self.delegate selectArray:self.selectArray];
    }
}

// 监听scrollView的滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageCount = scrollView.contentOffset.x / YJScreenW + 0.5;
    self.pageControl.currentPage = pageCount;
}









@end
