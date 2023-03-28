//
//  RSTaoBaoActivityViewController.m
//  石来石往
//
//  Created by mac on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoActivityViewController.h"
//活动界面
#import "RSTaobaoACContentViewController.h"
//收藏
#import "RSTaobaoCollectionViewController.h"
//进店
#import "RSTaoBaoShopViewController.h"
//首页
#import "RSTaobaoDistrictViewController.h"
//申请店铺
#import "RSTaoBaoApplyShopViewController.h"
//管理店铺
#import "RSTaoBaoCommodityManagementViewController.h"

#import "RSLoginViewController.h"


@interface RSTaoBaoActivityViewController ()<UIScrollViewDelegate>

{
    
    BOOL _isFirst;
    
    
}


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

@property (nonatomic,strong)RSTaoBaoTool * taobaoTool;

@end

@implementation RSTaoBaoActivityViewController

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
    if (verifyKey.length > 0) {
        [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isFirst = NO;
        // 去掉控制器给scrollView添加的额外内边距
        if (@available(iOS 11.0, *)) {
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    
    
    RSTaoBaoTool * taobaoTool = [[RSTaoBaoTool alloc]init];
    self.taobaoTool = taobaoTool;
    
    
    UILabel * titleName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    titleName.text = @"优惠专区";
    titleName.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    titleName.textAlignment = NSTextAlignmentCenter;
    titleName.font = [UIFont systemFontOfSize:17];
    
    self.navigationItem.titleView = titleName;
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#FE2933"];
    
    
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[backBtn setTitle:@"..." forState:UIControlStateNormal];
    //[backBtn setTitleColor:[UIColor colorWithHexColorStr:@"#424545"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"上一页"] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:21];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    UIBarButtonItem * leftitem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftitem;
    [backBtn addTarget:self action:@selector(upViewControllerAction:) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.imageView.sd_layout
    .centerXEqualToView(backBtn)
    .centerYEqualToView(backBtn)
    .widthIs(11)
    .heightIs(19);
    
    
    
    
    UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setTitle:@"..." forState:UIControlStateNormal];
    [menuBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    menuBtn.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    menuBtn.frame = CGRectMake(0, 0, 50, 50);
    menuBtn.titleLabel.sd_layout
       .centerXEqualToView(menuBtn)
       .topSpaceToView(menuBtn, -5);
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = item;
    [menuBtn addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //添加标题view
    [self addBLShowTitleView];
    
    // 添加内容的scrollView
    [self addBLShowContentScrollView];
    
    // 添加所有的子控制器
    [self addAllChildViewControllers];
    
    
    // 默认点击下标为0的标题按钮
    [self titleBtnClick:self.titleBtns[0]];
    
    


}


//菜单
- (void)menuAction:(UIButton *)menuBtn{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1) {
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        RSWeakself
        [self.taobaoTool showMenuContentType:@"活动" andOnView:menuBtn andViewController:self andBlock:^(RSTaobaoUserModel * _Nonnull taobaoUsermodel) {
            weakSelf.taobaoUsermodel = taobaoUsermodel;
        }];
    }
}


- (void)upViewControllerAction:(UIButton *)backBtn{

    [self.navigationController popViewControllerAnimated:YES];
}



- (void)addBLShowTitleView{
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
    }else{
        Y = 64;
    }
    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(0, Y, SCW/2, 38)];
    titleview.backgroundColor = [UIColor colorWithHexColorStr:@"#FE2933"];
    self.titleView = titleview;
    [self.view addSubview:titleview];
    // 添加所有的标题按钮
    [self addAllTitleBtns];
    
    // 添加下滑线
    [self setupUnderLineView];
}


- (void)addBLShowContentScrollView
{
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
    }else{
        Y = 64;
    }
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView = contentScrollView;
    //self.contentScrollview.hidden = YES;
    //self.contentScrollView.backgroundColor = [UIColor  colorWithHexColorStr:@"#F5F5F5"];
    contentScrollView.frame = CGRectMake(0,Y + 38 , SCW, SCH - Y - 38);
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
    lineView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
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
    
    
    RSTaobaoACContentViewController * view1 = [[RSTaobaoACContentViewController alloc]init];
//    view1.taobaoUsermodel = self.taobaoUsermodel;
    view1.title = @"全部";
    view1.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [self addChildViewController:view1];
    
    RSTaobaoACContentViewController * view2 = [[RSTaobaoACContentViewController alloc]init];
//    view2.taobaoUsermodel = self.taobaoUsermodel;
    view2.title = @"荒料";
    view2.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [self addChildViewController:view2];

    RSTaobaoACContentViewController * view3 = [[RSTaobaoACContentViewController alloc]init];
//    view3.taobaoUsermodel = self.taobaoUsermodel;
    view3.title = @"大板";
    view3.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [self addChildViewController:view3];
    
    
    
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
    NSArray *titles = @[@"全部",@"荒料",@"大板"];
    // 按钮宽度
    CGFloat btnW = (SCW /2)/titles.count;
    CGFloat btnH = self.titleView.yj_height;
    for (int i = 0; i < titles.count; i++) {
        // 创建标题按钮
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.tag = i;
        titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        // 设置文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
        // 设置选中按钮的文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateSelected];
        
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

- (BOOL)prefersStatusBarHidden{
    if (_isFirst == NO) {
        if (iphonex || iPhoneXSMax || iPhoneXR || iPhoneXS) {
            self.navigationController.navigationBar.frame = CGRectMake(0,44, SCW,44);
        }else{
            self.navigationController.navigationBar.frame = CGRectMake(0,20, SCW,44);
        }
        //_isFirst = YES;
    }else{
        self.navigationController.navigationBar.frame = CGRectMake(0,0, SCW,64);

    }
    return NO;
}

@end
