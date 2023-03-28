//
//  RSTaoBaoCommodityManagementViewController.m
//  石来石往
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 mac. All rights reserved.
//


#import "RSTaoBaoCommodityManagementViewController.h"

//内容
#import "RSTaoBaoShopManagementViewController.h"

//店铺管理
#import "RSTaoBaoApplyShopViewController.h"


@interface RSTaoBaoCommodityManagementViewController ()<UIScrollViewDelegate>

/** 保存上一次点击的按钮 */
@property (nonatomic,strong) UIButton *preBtn;

/**标题视图*/
@property (nonatomic,strong)UIView * titleView;

/**内容的视图*/
@property (nonatomic,strong)UIScrollView *contentScrollView;

/** 下滑线 */
@property (nonatomic,strong) UIView *lineView;


/** 保存所有的标题按钮 */
@property (nonatomic,strong) NSMutableArray *titleBtns;



@end

@implementation RSTaoBaoCommodityManagementViewController

- (NSMutableArray *)titleBtns{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺管理";
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    
    //搜索按键
//    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [searchBtn setImage:[UIImage imageNamed:@"淘宝搜索"] forState:UIControlStateNormal];
//    searchBtn.frame = CGRectMake(0, 0, 50, 50);
//    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
//    self.navigationItem.rightBarButtonItem = item;
    
    
    //添加标题view
    [self addBLShowTitleView];
    
    // 添加内容的scrollView
    [self addBLShowContentScrollView];
        
    // 添加所有的子控制器
    [self addAllChildViewControllers];
    
    // 默认点击下标为0的标题按钮
    [self titleBtnClick:self.titleBtns[0]];
    
    // 去掉控制器给scrollView添加的额外内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}



- (void)addBLShowTitleView{
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
    }else{
        Y = 64;
    }
    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(0, Y, SCW, 38)];
    titleview.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
    self.titleView = titleview;
    [self.view addSubview:titleview];
    // 添加所有的标题按钮
    [self addAllTitleBtns];
    
    // 添加下滑线
    [self setupUnderLineView];
}


- (void)addBLShowContentScrollView
{
    //    CGFloat Y = 0.0;
    //    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
    //        Y = 88;
    //    }else{
    //        Y = 64;
    //    }
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView = contentScrollView;
    //self.contentScrollview.hidden = YES;
    //self.contentScrollView.backgroundColor = [UIColor  redColor];
    contentScrollView.frame = CGRectMake(0,CGRectGetMaxY(self.titleView.frame) , SCW, SCH - CGRectGetMaxY(self.titleView.frame));
    [self.view addSubview:contentScrollView];
    // 设置scrollView
    // 设置分页效果
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    // 去掉弹簧效果
    contentScrollView.bounces = NO;
    // 设置代理
    contentScrollView.delegate = self;
    [contentScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    
}


- (void)setupUnderLineView
{
    // 获取下标为0的标题按钮
    UIButton *titleBtn = self.titleBtns[0];
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    lineView.backgroundColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    // 下滑线高度
    CGFloat lineViewH = 2;
    CGFloat y = self.titleView.yj_height - lineViewH - 4;
    lineView.yj_height = lineViewH;
    lineView.yj_y = y;
    // 设置下划线的宽度比文本内容宽度大10
    [titleBtn.titleLabel sizeToFit];
    //lineView.yj_width = titleBtn.titleLabel.yj_width;
    lineView.yj_width = 30;
    lineView.yj_centerX = titleBtn.yj_centerX;
    // 添加到titleView里
    [self.titleView addSubview:lineView];
    lineView.layer.cornerRadius = 1;
    lineView.layer.masksToBounds = YES;
}




#pragma mark - 添加所有的子控制器
- (void)addAllChildViewControllers
{
    
    
    RSTaoBaoShopManagementViewController * view1 = [[RSTaoBaoShopManagementViewController alloc]init];
    view1.taobaoUsermodel = self.taobaoUsermodel;
    view1.title = @"荒料";
    view1.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    [self addChildViewController:view1];
    
    
    CGRect rect1 = CGRectMake(0, 0, SCW, SCH - CGRectGetMaxY(self.titleView.frame));
    CGRect oldRect1 = rect1;
    oldRect1.size.width = SCW;
    UIBezierPath * maskPath1 = [UIBezierPath bezierPathWithRoundedRect:oldRect1 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer * maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.path = maskPath1.CGPath;
    maskLayer1.frame = oldRect1;
    view1.view.layer.mask = maskLayer1;
    
    
    
    
    RSTaoBaoShopManagementViewController * view2 = [[RSTaoBaoShopManagementViewController alloc]init];
    view2.taobaoUsermodel = self.taobaoUsermodel;
    view2.title = @"大板";
    view2.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self addChildViewController:view2];
    CGRect rect2 = CGRectMake(0, 0, SCW, SCH - CGRectGetMaxY(self.titleView.frame));
    CGRect oldRect2 = rect2;
    oldRect1.size.width = SCW;
    UIBezierPath * maskPath2 = [UIBezierPath bezierPathWithRoundedRect:oldRect1 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer * maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.path = maskPath2.CGPath;
    maskLayer2.frame = oldRect2;
    view2.view.layer.mask = maskLayer2;
    
    
    RSTaoBaoApplyShopViewController * view3 = [[RSTaoBaoApplyShopViewController alloc]init];
    view3.taobaoUsermodel = self.taobaoUsermodel;
    view3.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    view3.title = @"店铺";
    [self addChildViewController:view3];
    
    
    CGRect rect3 = CGRectMake(0, 0, SCW, SCH - CGRectGetMaxY(self.titleView.frame));
    CGRect oldRect3 = rect3;
    oldRect1.size.width = SCW;
    UIBezierPath * maskPath3 = [UIBezierPath bezierPathWithRoundedRect:oldRect1 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer * maskLayer3 = [[CAShapeLayer alloc] init];
    maskLayer3.path = maskPath3.CGPath;
    maskLayer3.frame = oldRect3;
    view3.view.layer.mask = maskLayer3;
    
    
    
    NSInteger count = self.childViewControllers.count;
    //    // 给contentScrollView添加子控制器的view
    //    for (int i = 0 ; i < count; i++) {
    //        UIViewController *vc = self.childViewControllers[i];
    //        vc.view.frame = CGRectMake(i * YJScreenW, 0, YJScreenW, YJScreenH);
    //        [self.contentScrollView addSubview:vc.view];
    //    }
    // 设置内容scrollView的滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * self.contentScrollView.yj_width, 0);
}



#pragma mark - 添加所有的标题按钮
- (void)addAllTitleBtns
{
    // 所有的标题
    NSArray *titles = @[@"荒料",@"大板",@"店铺"];
    // 按钮宽度
    CGFloat btnW = SCW/titles.count;
    CGFloat btnH = self.titleView.yj_height;
    for (int i = 0; i < titles.count; i++) {
        // 创建标题按钮
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.tag = i;
        titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        // 设置文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        // 设置选中按钮的文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateSelected];
        
        [self.titleView addSubview:titleBtn];
        
        //        if (i == 0) {
        //            UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleBtn.frame), 10, 1, 21)];
        //            midView.backgroundColor = [UIColor colorWithHexColorStr:@"#979797"];
        //            [self.titleView addSubview:midView];
        //        }
        //
        // 保存标题按钮
        [self.titleBtns addObject:titleBtn];
        
        // 添加点击事件
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    
}
#pragma mark - 标题点击事件
- (void)titleBtnClick:(UIButton *)titleBtn
{
    // 判断标题按钮是否重复点击
    //    if (titleBtn == self.preBtn) {
    //        // 重复点击标题按钮，发送通知给帖子控制器，告诉它刷新数据
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"titleBtnRefreshClick" object:nil];
    //    }
    // 1.标题按钮点击三步曲
    if (titleBtn.selected) {
        titleBtn.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        //        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FF4B33"] forState:UIControlStateNormal];
        self.preBtn.selected = NO;
        titleBtn.selected = YES;
        self.preBtn = titleBtn;
    }else{
        titleBtn.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        self.preBtn.selected = NO;
        titleBtn.selected = YES;
        self.preBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.preBtn = titleBtn;
    }
    
    NSInteger tag = titleBtn.tag;
    // 2.处理下滑线的移动
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.yj_width = titleBtn.titleLabel.yj_width + 10;
        self.lineView.yj_centerX = titleBtn.yj_centerX;
        
        // 3.修改contentScrollView的便宜量,点击标题按钮的时候显示对应子控制器的view
        self.contentScrollView.contentOffset = CGPointMake(tag * self.contentScrollView.yj_width, 0);
    }];
    
    // 添加子控制器的view
    UIViewController *vc = self.childViewControllers[tag];
    // 如果子控制器的view已经添加过了，就不需要再添加了
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:vc.view];
    
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
    // 设置下划线的centerX
    self.lineView.yj_centerX = self.preBtn.yj_centerX + ratio * self.preBtn.yj_width;
    
}


@end
