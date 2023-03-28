//
//  RSShippingRecordViewController.m
//  石来石往
//
//  Created by mac on 17/6/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSShippingRecordViewController.h"
#import "UIView+Frame.h"

//处理中
#import "RSHandleViewController.h"
//审核中
#import "RSVerifyViewController.h"
//待发货
#import "RSShipmentViewController.h"
//部分发货
#import "RSPartialViewController.h"
//已完成
#import "RSCompleteViewController.h"
//全部
#import "RSAllRecordViewController.h"




@interface RSShippingRecordViewController ()<UIScrollViewDelegate>

{
    //UIView * _navigationview;
}

@property (nonatomic,strong)UIView *titleview;

/** 保存所有的标题按钮 */
@property (nonatomic,strong) NSMutableArray *titleBtns;
/** 保存上一次点击的按钮 */
@property (nonatomic,strong) UIButton *preBtn;
/** 下滑线 */
@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong)UIScrollView *contentScrollview;
@end

@implementation RSShippingRecordViewController
- (NSMutableArray *)titleBtns
{
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
////    self.navigationController.navigationBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"出库记录";
    //搭建标题栏
    [self setupTitleView];
    // 添加内容的scrollView
    [self addContentScrollView];
    // 添加所有的子控制器
    [self addAllChildViewControllers];
    // 5.默认选中下标为0的按钮
    UIButton *titleBtn = self.titleBtns[0];
    [self titleBtnClick:titleBtn];

}


#pragma mark - 搭建标题栏
- (void)setupTitleView
{
    // 创建标题栏
    UIView *titleView = [[UIView alloc] init];
    self.titleview = titleView;
    titleView.backgroundColor = [UIColor whiteColor];
    // 设置frame
//    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
         titleView.frame = CGRectMake(0, 0, SCW, 35);
//    }else{
//         titleView.frame = CGRectMake(0, 88, SCW, 35);
//    }
    [self.view addSubview:titleView];
    // 添加所有的标题按钮
    [self addAllTitleBtns];
    // 添加下滑线
    [self setupUnderLineView];
}








#pragma mark - 添加下滑线
- (void)setupUnderLineView
{
    // 获取下标为0的标题按钮
    UIButton *titleBtn = self.titleBtns[0];
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    lineView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    // 下滑线高度
    CGFloat lineViewH = 2;
    CGFloat y = self.titleview.yj_height - lineViewH;
    lineView.yj_height = lineViewH;
    lineView.yj_y = y;
    // 设置下划线的宽度比文本内容宽度大10
    [titleBtn.titleLabel sizeToFit];
    lineView.yj_width = titleBtn.yj_width;
    lineView.yj_centerX = titleBtn.yj_centerX;
    // 添加到titleView里
    [self.titleview addSubview:lineView];
}




#pragma mark - 添加内容的scrollView
- (void)addContentScrollView
{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollview = contentScrollView;
    //    self.contentScrollView.backgroundColor = [UIColor  redColor];
    contentScrollView.frame = CGRectMake(0,self.titleview.yj_height, SCW, SCH - Height_NavBar - self.titleview.yj_height);
    [self.view addSubview:contentScrollView];
//    self.contentScrollview.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.lineView.frame), 0, 0, 0);
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

#pragma mark - 添加所有的子控制器
- (void)addAllChildViewControllers
{
    
    //全部
    RSAllRecordViewController * allRecordVc = [[RSAllRecordViewController alloc]init];
    allRecordVc.userID = self.userID;
    allRecordVc.usermodel = self.usermodel;
    [self addChildViewController:allRecordVc];
    
    // 审核中
    RSVerifyViewController *verifyVc = [[RSVerifyViewController alloc] init];
    verifyVc.userID = self.userID;
    verifyVc.usermodel = self.usermodel;
    [self addChildViewController:verifyVc];
    
    // 待发货
    RSShipmentViewController *shipmentVc = [[RSShipmentViewController alloc] init];
    shipmentVc.userID = self.userID;
    shipmentVc.usermodel = self.usermodel;
    [self addChildViewController:shipmentVc];
    
    // 部分发货
    RSPartialViewController *partialVc = [[RSPartialViewController alloc] init];
    partialVc.userID = self.userID;
    partialVc.usermodel = self.usermodel;
    [self addChildViewController:partialVc];
    
    // 已完成
    RSCompleteViewController *completeVc = [[RSCompleteViewController alloc] init];
    completeVc.userID = self.userID;
    completeVc.usermodel = self.usermodel;
    [self addChildViewController:completeVc];
    
    // 已失效
    RSHandleViewController *handleVc = [[RSHandleViewController alloc] init];
    handleVc.userID = self.userID;
    handleVc.usermodel = self.usermodel;
    [self addChildViewController:handleVc];
     NSInteger count = self.childViewControllers.count;
    //    // 给contentScrollView添加子控制器的view
    //    for (int i = 0 ; i < count; i++) {
    //        UIViewController *vc = self.childViewControllers[i];
    //        vc.view.frame = CGRectMake(i * YJScreenW, 0, YJScreenW, YJScreenH);
    //        [self.contentScrollView addSubview:vc.view];
    //    }
    // 设置内容scrollView的滚动范围
    self.contentScrollview.contentSize = CGSizeMake(count * self.contentScrollview.yj_width, 0);
}
#pragma mark - 添加所有的标题按钮
- (void)addAllTitleBtns
{
    
    
    // 所有的标题
    NSArray *titles = @[@"全部",@"审核中",@"待发货",@"部分发货",@"已完成",@"已失效"];
    // 按钮宽度
    CGFloat btnW = SCW / titles.count;
    CGFloat btnH = self.titleview.yj_height;
    for (int i = 0; i < titles.count; i++) {
        // 创建标题按钮
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.tag = i;
        titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        // 设置文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        // 设置选中按钮的文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateSelected];
        
        [self.titleview addSubview:titleBtn];
        
        // 保存标题按钮
        [self.titleBtns addObject:titleBtn];
        
        // 添加点击事件
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    
}
#pragma mark - 标题点击事件
- (void)titleBtnClick:(UIButton *)titleBtn
{
//    // 判断标题按钮是否重复点击
//    if (titleBtn == self.preBtn) {
//        // 重复点击标题按钮，发送通知给帖子控制器，告诉它刷新数据
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"titleBtnRefreshClick" object:nil];
//    }
    // 1.标题按钮点击三步曲
    self.preBtn.selected = NO;
    titleBtn.selected = YES;
    self.preBtn = titleBtn;
    NSInteger tag = titleBtn.tag;
    // 2.处理下滑线的移动
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.yj_width = titleBtn.titleLabel.yj_width;
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
    vc.view.frame = self.contentScrollview.bounds;
    [self.contentScrollview addSubview:vc.view];
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
