//
//  RSRatingViewController.m
//  石来石往
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSRatingViewController.h"
#import "UIView+Frame.h"
#import "RSNORatingViewController.h"
#import "RSAlreadyRatingViewController.h"


@interface RSRatingViewController ()<UIScrollViewDelegate>


@property (nonatomic,strong)UITextField * searchTextfield;

@property (nonatomic,strong)UIView *titleview;

/** 保存所有的标题按钮 */
@property (nonatomic,strong) NSMutableArray *titleBtns;
/** 保存上一次点击的按钮 */
@property (nonatomic,strong) UIButton *preBtn;
/** 下滑线 */
@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong)UIScrollView *contentScrollview;


@property (nonatomic,strong)RSNORatingViewController * NoVc;
@property (nonatomic,strong)RSAlreadyRatingViewController * alreadyVc;

@end

@implementation RSRatingViewController
- (NSMutableArray *)titleBtns{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //自定义导航栏
    [self addCustomNavigationBarView];
    
    // 添加内容的scrollView
   [self addContentScrollView];
    
    // 搭建标题栏
    [self setupTitleView];
    
    // 添加所有的子控制器
    [self addAllChildViewControllers];

    
    // 5.默认选中下标为0的按钮
    UIButton *titleBtn = self.titleBtns[0];
    [self titleBtnClick:titleBtn];
    
    
    
}


- (void)addCustomNavigationBarView{
    
    
    UIView *navigationview = [[UIView alloc]init];
    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
        navigationview.frame = CGRectMake(0, 0, SCW, 64);
    }else{
        navigationview.frame = CGRectMake(0, 0, SCW, 88);
    }
    
    
    
    
    
    
    
    navigationview.backgroundColor = [UIColor colorWithHexColorStr:@"x"];
    [self.view addSubview:navigationview];

    
    RSNavigationButton  * backItem = [[RSNavigationButton alloc]init];
    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
        backItem.frame = CGRectMake(12, 27, 40, 30);
    }else{
        backItem.frame = CGRectMake(12, 50, 40, 30);
    }
    [backItem setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    [navigationview addSubview:backItem];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:backItem];
    self.navigationItem.leftBarButtonItem = item;
    
    
    UIView *searchview = [[UIView alloc]init];
    searchview.layer.borderWidth = 1;
    searchview.layer.borderColor = [UIColor colorWithHexColorStr:@"#dadada"].CGColor;
    searchview.layer.cornerRadius = 5;
    searchview.layer.masksToBounds = YES;
    searchview.backgroundColor = [UIColor whiteColor];
    [navigationview addSubview:searchview];
    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
        //searchview.frame = CGRectMake((SCW * 0.5) * 0.5, 26.5, SCW * 0.5, 35);
        searchview.sd_layout
        .centerXEqualToView(navigationview)
        .topSpaceToView(navigationview, 26.5)
        .widthRatioToView(navigationview, 0.6)
        .heightIs(35);
    }else{
        searchview.sd_layout
        .centerXEqualToView(navigationview)
        .topSpaceToView(navigationview, 48.5)
        .widthRatioToView(navigationview, 0.6)
        .heightIs(35);
    }
    
    //self.navigationItem.titleView = searchview;
    
    UIImageView * searchimageview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 7.5, 20, 20)];
    searchimageview.image = [UIImage imageNamed:@"放大镜"];
    [searchview addSubview:searchimageview];
    
    UITextField *searchfield = [[UITextField alloc]init];
    searchfield.borderStyle = UITextBorderStyleNone;
    searchfield.placeholder = @"查询石材";
    [searchview addSubview:searchfield];
    _searchTextfield = searchfield;
    searchfield.sd_layout
    .leftSpaceToView(searchimageview, 5)
    .topSpaceToView(searchview, 0)
    .bottomSpaceToView(searchview, 0)
    .rightSpaceToView(searchview, 0);
 
    
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"矩形-4"] forState:UIControlStateHighlighted];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    [navigationview addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(seachStoneLevel:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    searchBtn.sd_layout
    .rightSpaceToView(navigationview, 12)
    .topEqualToView(backItem)
    .bottomEqualToView(backItem)
    .leftSpaceToView(searchview, 10);
    
    
//    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
//    self.navigationItem.rightBarButtonItem = rightitem;
    /*
    UIView * bottomDLview = [[UIView alloc]init];
    bottomDLview.backgroundColor = [UIColor colorWithHexColorStr:@"#d6d6d6"];
    [navigationview addSubview:bottomDLview];
    
    
    navigationview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(64);
    
    backItem.sd_layout
    .leftSpaceToView(navigationview,8)
    .topSpaceToView(navigationview,27)
    .widthIs(40)
    .heightIs(30);
    
    searchview.sd_layout
    .leftSpaceToView(backItem,0)
    .topSpaceToView(navigationview,27)
    .centerXEqualToView(navigationview)
    .widthRatioToView(navigationview,0.7)
    .heightIs(30);
    
    searchimageview.sd_layout
    .leftSpaceToView(searchview,5)
    .topSpaceToView(searchview,5)
    .bottomSpaceToView(searchview,5)
    .widthIs(20);
    
    
    
    
    searchfield.sd_layout
    .leftSpaceToView(searchimageview,5)
    .topSpaceToView(searchview,0)
    .bottomSpaceToView(searchview,0)
    .rightSpaceToView(searchview,0);
    
    searchBtn.sd_layout
    .leftSpaceToView(searchview,5)
    .centerYEqualToView(searchview)
    .topEqualToView(searchview)
    .bottomEqualToView(searchview)
    .widthIs(40);
    
    
    
    
    bottomDLview.sd_layout
    .leftSpaceToView(navigationview,0)
    .rightSpaceToView(navigationview,0)
    .bottomSpaceToView(navigationview,0)
    .heightIs(1);
    */
}


#pragma mark - 搭建标题栏
- (void)setupTitleView
{
    // 创建标题栏
    UIView *titleView = [[UIView alloc] init];
    self.titleview = titleView;
    titleView.backgroundColor = [UIColor whiteColor];
    // 设置frame
    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
        titleView.frame = CGRectMake(0, 64, SCW, 38);
    }else{
        titleView.frame = CGRectMake(0, 88, SCW, 38);
    }
    [self.view addSubview:titleView];
    // 添加所有的标题按钮
    [self addAllTitleBtns];
    // 添加下滑线
    [self setupUnderLineView];
}

#pragma mark - 添加所有的标题按钮
- (void)addAllTitleBtns
{
    
    
    // 所有的标题
    NSArray *titles = @[@"未评",@"已评"];
    // 按钮宽度
    CGFloat btnW = SCW / titles.count;
    CGFloat btnH = self.titleview.yj_height;
    for (int i = 0; i < titles.count; i++) {
        // 创建标题按钮
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.tag = i;
        titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        // 设置文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        // 设置选中按钮的文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateSelected];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.titleview addSubview:titleBtn];
        
        // 保存标题按钮
        [self.titleBtns addObject:titleBtn];
        
        // 添加点击事件
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
}

- (void)addContentScrollView
{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollview = contentScrollView;
    //    self.contentScrollView.backgroundColor = [UIColor  redColor];
    
    
    CGFloat Y;
    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
        Y = 64;
    }else{
        Y = 88;
    }
    
    contentScrollView.frame = CGRectMake(0, Y+38, SCW, SCH - Y -38);
    [self.view addSubview:contentScrollView];
    
    // 设置scrollView
    // 设置分页效果
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    // 去掉弹簧效果
    contentScrollView.bounces = NO;
    // 设置代理
    contentScrollView.delegate = self;
}


#pragma mark - 添加下滑线
- (void)setupUnderLineView
{
    // 获取下标为0的标题按钮
    UIButton *titleBtn = self.titleBtns[0];
    
    
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    lineView.backgroundColor = [UIColor colorWithHexColorStr:@"#1c98e6"];
    // 下滑线高度
    CGFloat lineViewH = 1.5;
    CGFloat y = self.titleview.yj_height - lineViewH;
    lineView.yj_height = lineViewH;
    lineView.yj_y = y;
    // 设置下划线的宽度比文本内容宽度大10
    [titleBtn.titleLabel sizeToFit];
    lineView.yj_width = SCW/2;
    lineView.yj_centerX = titleBtn.yj_centerX;
    // 添加到titleView里
    [self.titleview addSubview:lineView];
}


#pragma mark - 标题点击事件
- (void)titleBtnClick:(UIButton *)titleBtn
{
    // 1.标题按钮点击三步曲
    self.preBtn.selected = NO;
    titleBtn.selected = YES;
    self.preBtn = titleBtn;
    NSInteger tag = titleBtn.tag;
    // 2.处理下滑线的移动
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.yj_width = SCW/2;
        self.lineView.yj_centerX = titleBtn.yj_centerX;
        
        // 3.修改contentScrollView的便宜量,点击标题按钮的时候显示对应子控制器的view
        self.contentScrollview.contentOffset = CGPointMake(tag * self.contentScrollview.yj_width, 0);
    }];
    
    // 添加子控制器的view
    UIViewController *vc = self.childViewControllers[tag];
    // 如果子控制器的view已经添加过了，就不需要再添加了
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(tag * SCW, 0, SCW, self.contentScrollview.yj_height);
    [self.contentScrollview addSubview:vc.view];

}

#pragma mark - 添加所有的子控制器
- (void)addAllChildViewControllers
{
    // 未评
    RSNORatingViewController *NoVc = [[RSNORatingViewController alloc] init];
    //按照是大板还是荒料
    NoVc.choiceStyle = self.choiceStyle;
    //是搜索框中的内容
    NoVc.searchTextfield = self.searchTextfield;
    self.NoVc = NoVc;
    
    [self addChildViewController:NoVc];
    //已评
    RSAlreadyRatingViewController *alreadyVc = [[RSAlreadyRatingViewController alloc]init];
    
    //按照是大板还是荒料
    alreadyVc.choiceStyle = self.choiceStyle;
    //是搜索框中的内容
    alreadyVc.searchTextfield = self.searchTextfield;
    [self addChildViewController:alreadyVc];
    self.alreadyVc = alreadyVc;
    
    
    
    NSInteger count = self.childViewControllers.count;
    
    // 给contentScrollView添加子控制器的view
    for (int i = 0 ; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * SCW, 0, SCW, self.contentScrollview.yj_height);
        [self.contentScrollview addSubview:vc.view];
    }
    
    // 设置内容scrollView的滚动范围
    self.contentScrollview.contentSize = CGSizeMake(count * self.contentScrollview.yj_width, 0);
}


#pragma mark - <UIScrollViewDelegate>
// 当scrollView减速结束的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取子控制对应的标题按钮
    // 计算出子控制器的下标
    NSInteger index = scrollView.contentOffset.x / scrollView.yj_width;
    UIButton *titleBtn = self.titleBtns[index];
    
    // 调用标题按钮的点击事件
    [self titleBtnClick:titleBtn];
}

// 当scrollView滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算拖拽的比例
    CGFloat ratio = scrollView.contentOffset.x / scrollView.yj_width;
    // 将整数部分减掉，保留小数部分的比例(控制器比例的范围0~1.0)
    ratio = ratio - self.preBtn.tag;
   // NSLog(@"ratio = %0.1f",ratio);
    // 设置下划线的centerX
    self.lineView.yj_centerX = self.preBtn.yj_centerX + ratio * self.preBtn.yj_width;
    
}


#pragma mark -- 搜索石头评级的数据
- (void)seachStoneLevel:(UIButton *)btn{
    
    
    
    [self.searchTextfield endEditing:YES];
    
    for (UIViewController *viewVc  in self.childViewControllers) {
        if ([viewVc isKindOfClass:[RSNORatingViewController class]]) {
            
            
            self.NoVc.searchTextfield = self.searchTextfield;
           self.NoVc.choiceStyle = self.choiceStyle;
            
            [self.NoVc getStoneSearchNoNullString];
            
            
        }else{
            
//            RSAlreadyRatingViewController * alreadyVc = [[RSAlreadyRatingViewController alloc]init];
//            alreadyVc.searchTextfield = self.searchTextfield;
//            alreadyVc.choiceStyle = self.choiceStyle;
            self.alreadyVc.searchTextfield = self.searchTextfield;
            self.alreadyVc.choiceStyle = self.choiceStyle;
            
            [self.alreadyVc getStoneHasBeenRatedSearchNoNullString];
        }
    }
}


- (void)backViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
