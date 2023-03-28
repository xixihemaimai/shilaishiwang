//
//  RSDetailsOfChargesViewController.m
//  石来石往
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSDetailsOfChargesViewController.h"

#import "RSScreenButton.h"


//父子控制器
#import "RSDetailsOfAllViewController.h"
#import "RSDetailsOfBlockViewController.h"
#import "RSDetailsOfOsakaViewController.h"
#import "RSDetailsOfMachiningViewController.h"
#import "RSDetailsOfPropertyViewController.h"
#import "RSDetailsOfBondedViewController.h"



@interface RSDetailsOfChargesViewController ()<UIScrollViewDelegate,RSDetailOfChargesLeftScreenViewDelegate>


@property (nonatomic,strong)UIView *titleview;

/** 保存所有的标题按钮 */
@property (nonatomic,strong) NSMutableArray *titleBtns;
/** 保存上一次点击的按钮 */
@property (nonatomic,strong) UIButton *preBtn;
/** 下滑线 */
@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong)UIScrollView *contentScrollview;
@end

@implementation RSDetailsOfChargesViewController
- (NSMutableArray *)titleBtns
{
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"费用明细";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
    [self isAddjust];
//    if (@available(iOS 11.0, *)) {
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    [self addDetailOfChargesCustomNavigation];
    
    
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:currentDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:-1];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    
    
    self.datefrom = beforDate;
    self.dateto = currentDateString;
    
    // 搭建标题栏
    [self setupTitleView];
    
    // 添加内容的scrollView
    [self addContentScrollView];
    
    
    
    // 添加所有的子控制器
    [self addAllChildViewControllers];
    
    
    // 5.默认选中下标为0的按钮
    UIButton *titleBtn = self.titleBtns[0];
    [self titleBtnClick:titleBtn];
    
    
    
    
    _leftview = [[RSRSDetailsOfChargesFuntionRightView alloc]initWithSender:self];
    _leftview.backgroundColor = [UIColor whiteColor];
    
    
    //_leftview.lefttap.delegate = self;
    [self.view addSubview:_leftview];
    _detailsOfChargesLeftScreenview = [[RSDetailOfChargesLeftScreenView alloc]initWithFrame:CGRectMake(0, 0, 269, SCH)];
    
     [_leftview setContentView:_detailsOfChargesLeftScreenview];
    _detailsOfChargesLeftScreenview.searchType = self.title;
     _detailsOfChargesLeftScreenview.delegate = self;
    [_leftview bringSubviewToFront:self.view];
    [_detailsOfChargesLeftScreenview bringSubviewToFront:_leftview];
    
    
}


#pragma mark -- 添加自定义导航栏
- (void)addDetailOfChargesCustomNavigation{

    RSScreenButton * screenBtn = [[RSScreenButton alloc]init];
    screenBtn.frame = CGRectMake(0, 0, 100, 40);
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    //  [screenBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F9F9"]];
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    screenBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //  [screenBtn setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
    [screenBtn addTarget:self action:@selector(showDetailsOfChargesScreenView:) forControlEvents:UIControlEventTouchUpInside];
    // [screenBtn bringSubviewToFront:self.view];
    // [self.view addSubview:screenBtn];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}



#pragma mark -- 筛选
- (void)showDetailsOfChargesScreenView:(RSScreenButton *)screenBtn{
    
    
    
    [_leftview switchMenu];
//    if (!_leftview.isOpen) {
//        self.navigationController.navigationBar.hidden = YES;
//    }else{
//        self.navigationController.navigationBar.hidden = NO;
//    }
    
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
        titleView.frame = CGRectMake(0, 0, SCW, 46);
//    }else{
//        titleView.frame = CGRectMake(0, 88, SCW, 46);
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
    lineView.layer.cornerRadius = 2;
    lineView.layer.masksToBounds = YES;
    lineView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    // 下滑线高度
    CGFloat lineViewH = 2;
    CGFloat y = self.titleview.yj_height - 7;
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
//    CGFloat Y;
//    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
//        Y = 64;
//    }else{
//        Y = 88;
//    }
    self.contentScrollview = contentScrollView;
    //    self.contentScrollView.backgroundColor = [UIColor  redColor];
    contentScrollView.frame = CGRectMake(0,CGRectGetMaxY(self.titleview.frame), SCW, SCH - CGRectGetMaxY(self.titleview.frame));
    [self.view addSubview:contentScrollView];
    self.contentScrollview.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.lineView.frame), 0, 0, 0);
    
    
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
    RSDetailsOfAllViewController * detailsOfAllVc = [[RSDetailsOfAllViewController alloc]init];
    detailsOfAllVc.datefrom = self.datefrom;
    detailsOfAllVc.dateto = self.dateto;
    [self addChildViewController:detailsOfAllVc];
    //荒料
    RSDetailsOfBlockViewController * detailsOfBlockVc = [[RSDetailsOfBlockViewController alloc]init];
    detailsOfBlockVc.datefrom = self.datefrom;
    detailsOfBlockVc.dateto = self.dateto;
    [self addChildViewController:detailsOfBlockVc];
    //大板
    RSDetailsOfOsakaViewController * detailsOfOsakaVc = [[RSDetailsOfOsakaViewController alloc]init];
    detailsOfOsakaVc.datefrom = self.datefrom;
    detailsOfOsakaVc.dateto = self.dateto;
    [self addChildViewController:detailsOfOsakaVc];
    //加工
    RSDetailsOfMachiningViewController * detailsOfMachineVc = [[RSDetailsOfMachiningViewController alloc]init];
    detailsOfMachineVc.datefrom = self.datefrom;
    detailsOfMachineVc.dateto = self.dateto;
    [self addChildViewController:detailsOfMachineVc];
    //物业
    RSDetailsOfPropertyViewController * detailsOfPropertyVc = [[RSDetailsOfPropertyViewController alloc]init];
    detailsOfPropertyVc.datefrom = self.datefrom;
    detailsOfPropertyVc.dateto = self.dateto;
    [self addChildViewController:detailsOfPropertyVc];
    //保税
    RSDetailsOfBondedViewController * detailsOfBondedVc = [[RSDetailsOfBondedViewController alloc]init];
    detailsOfBondedVc.datefrom = self.datefrom;
    detailsOfBondedVc.dateto = self.dateto;
    [self addChildViewController:detailsOfBondedVc];
    
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
    NSArray *titles = @[@"全部",@"荒料",@"大板",@"加工",@"其他物业",@"保税"];
    // 按钮宽度
    CGFloat btnW = SCW / titles.count;
    CGFloat btnH = self.titleview.yj_height;
    for (int i = 0; i < titles.count; i++) {
        // 创建标题按钮
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.tag = i;
        titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
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


//这边是筛选之后的选择时间的代理
- (void)selectorDatefrom:(NSString *)datefrom andDateto:(NSString *)Dateto{
    [_leftview hide];
    self.datefrom = datefrom;
    self.dateto = Dateto;
    for (UIViewController * fn in self.childViewControllers) {
        for (UIView * view in fn.view.subviews) {
            [view removeFromSuperview];
        }
    }
    //这边要重新请求
    //全部
    RSDetailsOfAllViewController * detailsOfAllVc = self.childViewControllers[0];
    detailsOfAllVc.datefrom = self.datefrom;
    detailsOfAllVc.dateto = self.dateto;
    [detailsOfAllVc viewDidLoad];
    //荒料
    RSDetailsOfBlockViewController * detailsOfBlockVc = self.childViewControllers[1];
    detailsOfBlockVc.datefrom = self.datefrom;
    detailsOfBlockVc.dateto = self.dateto;
    [detailsOfBlockVc viewDidLoad];
    //大板
    RSDetailsOfOsakaViewController * detailsOfOsakaVc = self.childViewControllers[2];
    detailsOfOsakaVc.datefrom = self.datefrom;
    detailsOfOsakaVc.dateto = self.dateto;
    [detailsOfOsakaVc viewDidLoad];
    //加工
    RSDetailsOfMachiningViewController * detailsOfMachineVc = self.childViewControllers[3];
    detailsOfMachineVc.datefrom = self.datefrom;
    detailsOfMachineVc.dateto = self.dateto;
    [detailsOfMachineVc viewDidLoad];
    //其他物业
    RSDetailsOfPropertyViewController * detailsOfPropertyVc = self.childViewControllers[4];
    detailsOfPropertyVc.datefrom = self.datefrom;
    detailsOfPropertyVc.dateto = self.dateto;
    [detailsOfPropertyVc viewDidLoad];
    //保税
    RSDetailsOfBondedViewController * detailsOfBondedVc = self.childViewControllers[5];
    detailsOfBondedVc.datefrom = self.datefrom;
    detailsOfBondedVc.dateto = self.dateto;
    [detailsOfBondedVc viewDidLoad];
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
