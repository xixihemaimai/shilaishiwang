//
//  RSSearchHuangAndDabanViewController.m
//  石来石往
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSSearchHuangAndDabanViewController.h"

#import "RShuangSecondDetailController.h"
#import "RSHuangThirdDetailViewController.h"

#define ECA 2
#define margin 20

@interface RSSearchHuangAndDabanViewController ()<UIScrollViewDelegate,RShuangSecondDetailControllerDelegate,RSHuangThirdDetailViewControllerDelegate>
/** 保存上一次点击的按钮 */
@property (nonatomic,strong) UIButton *preBtn;

/**这边是俩个按键的数组*/
@property (nonatomic,strong)NSMutableArray * titleBtns;

/**这边是俩个按键上面的view*/
@property (nonatomic,strong)NSMutableArray * upViews;

/**内容的视图*/
@property (nonatomic,strong)UIScrollView *contentScrollview;

/**标题视图*/
@property (nonatomic,strong)UIView * titleview;


@end

@implementation RSSearchHuangAndDabanViewController

- (NSMutableArray *)titleBtns{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
    
}

- (NSMutableArray *)upViews{
    if (_upViews == nil) {
        _upViews = [NSMutableArray array];
    }
    return _upViews;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //self.hidesBottomBarWhenPushed = YES;
    // [self.rsSearchTextField becomeFirstResponder];
    
    
    //去除导航栏下方的横线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.title = @"白玉兰";
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
     self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    
    [self addHuangAndDaBanContentScrollView];
    
    [self addHuangAndDaBanTitleView];
    [self addHuangAndDaBanAllChildViewControllers];
    
    
    
   // [self addHuangAndDaBanMarketScrollview];
    
   // [self addHuangAndDaBanSeparateView];
    
  //  [self addHuangAndDaBanShabuView];
    
    // 5.默认选中下标为0的按钮
    UIButton *titleBtn = self.titleBtns[0];
    [self titlesBtnClick:titleBtn];
}





//这边要添加一个市场的界面
//- (void)addHuangAndDaBanMarketScrollview{
//    CGFloat Y = 0.0;
//    if (iphonex) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
//
//    UIScrollView * marketScrollview =[[UIScrollView alloc]initWithFrame:CGRectMake(0, Y + 35, SCW, 88)];
//
//    marketScrollview.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
//
//    marketScrollview.delegate = self;
//    [self.view addSubview:marketScrollview];
//    marketScrollview.pagingEnabled = NO;
//    marketScrollview.showsHorizontalScrollIndicator = NO;
//    // 去掉弹簧效果
//    marketScrollview.bounces = NO;
//    _marketScrollview = marketScrollview;
//    [self addMartketScrollviewContentView];
//}








//中间添加一个分隔
//- (void)addHuangAndDaBanSeparateView{
//
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
//    UIView * separateview = [[UIView alloc]initWithFrame:CGRectMake(0, Y + 35 + 88, SCW, 10)];
//    separateview.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8F8"];
//    [self.view addSubview:separateview];
//}


//这边还是要添加一个选择刷新的样子
//- (void)addHuangAndDaBanShabuView{
//    CGFloat Y = 0.0;
//    if (iphonex) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
//    UIView * shabuView = [[UIView alloc]initWithFrame:CGRectMake(0,Y + 35 + 88 + 10 , SCW, 43)];
//    shabuView.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:shabuView];
//}




#pragma mark - 添加所有的子控制器
- (void)addHuangAndDaBanAllChildViewControllers
{
    //荒料
    RShuangSecondDetailController * huangVc = [[RShuangSecondDetailController alloc]init];
    huangVc.title = @"荒料";
    huangVc.userModel = self.usermodel;
    huangVc.searchStr = self.searchStr;
    huangVc.delegate = self;
    [self addChildViewController:huangVc];
    // 大板
    RSHuangThirdDetailViewController * daVc = [[RSHuangThirdDetailViewController alloc] init];
    daVc.title = @"大板";
    daVc.delegate = self;
    daVc.userModel = self.usermodel;
    daVc.searchStr = self.searchStr;
    [self addChildViewController:daVc];
    NSInteger count = self.childViewControllers.count;
    
    // 给contentScrollView添加子控制器的view
    //    for (int i = 0 ; i < count; i++) {
    //        UIViewController *vc = self.childViewControllers[i];
    //        vc.view.frame = CGRectMake(i * SCW, 0, SCW, self.contentScrollview.yj_height);
    //        [self.contentScrollview addSubview:vc.view];
    //    }
    
    // 设置内容scrollView的滚动范围
    self.contentScrollview.contentSize = CGSizeMake(count * self.contentScrollview.yj_width, 0);
}

- (void)addHuangAndDaBanTitleView{
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 35)];
//    titleview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.titleview = titleview;
    [self.view addSubview:titleview];
    [self addHuangAndDaBanAllTitleBtns];
}

- (void)addHuangAndDaBanContentScrollView
{
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollview = contentScrollView;
  //self.contentScrollview.hidden = YES;
  //self.contentScrollView.backgroundColor = [UIColor  redColor];
    contentScrollView.frame = CGRectMake(0,CGRectGetMaxY(self.titleview.frame) + 35, SCW, SCH - CGRectGetMaxY(self.titleview.frame) - 35);
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

#pragma mark - 添加所有的标题按钮
- (void)addHuangAndDaBanAllTitleBtns
{
    // 所有的标题
    NSArray *titles = @[@"荒料",@"大板"];
    // 按钮宽度
    CGFloat btnW = (SCW  - ((ECA + 1)*margin))/ECA;
    CGFloat btnH = self.titleview.yj_height;
    for (int i = 0; i < titles.count; i++) {
        // 创建标题按钮
        NSInteger colom = i % ECA;
        CGFloat btnx =  colom * (margin + btnW) + margin;
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.tag = i;
        UIView * upView = [[UIView alloc]init];
        upView.backgroundColor = [UIColor colorWithHexColorStr:@"#b4cff9"];

        upView.frame = CGRectMake(btnx , 0, btnW, 10);
        upView.layer.cornerRadius = 5;
        upView.layer.masksToBounds = YES;
        upView.alpha = 0.5;
        upView.tag = i;
        titleBtn.frame = CGRectMake(btnx, 1, btnW, btnH);
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        // 设置文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        // 设置选中按钮的文字颜色
         [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateSelected];
       // [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateSelected];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.titleview addSubview:upView];
        [self.titleview addSubview:titleBtn];
        [self.upViews addObject:upView];
        
        // 保存标题按钮
        [self.titleBtns addObject:titleBtn];
        
        // 添加点击事件
        [titleBtn addTarget:self action:@selector(titlesBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    
}



- (void)titlesBtnClick:(UIButton *)titleBtn{
    // 1.标题按钮点击三步曲
    
    
    
    
    
    //self.preBtn.selected = NO;
    //titleBtn.selected = YES;
    
    // 1.1将上一次点击的按钮的文字修改为黑色
     [self.preBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
     [self.preBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f9f9f9"]];
   //  self.preBtn.layer.borderWidth = 1;
    // self.preBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#759FFC"].CGColor;
    //这边要对按键进行左上和右上的角进行设置
    
     [self setViewStyle:titleBtn];
    
    
    
    
    // 1.2让当前点击的按钮文字变成红色
    [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [titleBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
   
    
    
    
    
    for (int i = 0 ; i < self.upViews.count; i++) {
        
        UIView * upview = self.upViews[i];
        
        if (upview.tag == titleBtn.tag) {
            
            upview.backgroundColor = [UIColor colorWithHexColorStr:@"#b4cff9"];
        }else{
            upview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
        }
        
    }
    
    
    
    self.preBtn = titleBtn;
    NSInteger tag = titleBtn.tag;
    // 2.处理下滑线的移动
    [UIView animateWithDuration:0.25 animations:^{
        //self.lineView.yj_width = titleBtn.titleLabel.yj_width;
        //self.lineView.yj_centerX = titleBtn.yj_centerX;
        
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






-(void)setViewStyle:(UIButton *)btn{
    
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 1, (SCW  - ((ECA + 1)*margin))/ECA, self.titleview.yj_height)
                                                    byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                                          cornerRadii:CGSizeMake(6.0f, 6.0f)];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    //maskLayer.frame  = CGRectMake(0, 0, 160, 10);
    maskLayer.path   = maskPath.CGPath;
    btn.layer.mask  = maskLayer;
    [btn.layer setMasksToBounds:NO];
}

//FIXME:UIScrollViewDelegate
// 当scrollView减速结束的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取子控制对应的标题按钮
    // 计算出子控制器的下标
    
 
        NSInteger index = scrollView.contentOffset.x / scrollView.yj_width;
        UIButton *titleBtn = self.titleBtns[index];
        
        // 调用标题按钮的点击事件
        [self titlesBtnClick:titleBtn];
        
    
    
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
        //self.lineView.yj_centerX = self.preBtn.yj_centerX + ratio * self.preBtn.yj_width;
    
}


//这边是让大板的变化 -- 荒料的代理
- (void)selectKeywordContentTitle:(NSString *)currentTitle andType:(NSInteger)type{
    if (type == 1) {
        RShuangSecondDetailController * huangVc = self.childViewControllers[0];
        huangVc.searchStr = currentTitle;
        huangVc.btnStr1 = @"2";
        huangVc.btnStr2 = @"2";
        huangVc.btnStr3 = @"2";
        huangVc.btnStr4 = @"2";
              
        huangVc.tempStr1 = @"-1";
        huangVc.tempStr2 = @"-1";
        huangVc.tempStr3 = @"-1";
        huangVc.tempStr4 = @"-1";
        huangVc.show_type = @"";
        [huangVc loadHuangliaoMoreMarketNewData];
//        [huangVc loadHuangDetailAndDaDetailNewData];
    }else{
        RSHuangThirdDetailViewController * daVc = self.childViewControllers[1];
        daVc.searchStr = currentTitle;
        daVc.btnStr1 = @"2";
        daVc.btnStr2 = @"2";
        daVc.btnStr3 = @"2";
        daVc.btnStr4 = @"2";
              
        daVc.tempStr1 = @"-1";
        daVc.tempStr2 = @"-1";
        daVc.tempStr3 = @"-1";
        daVc.tempStr4 = @"-1";
        daVc.show_type = @"";
        [daVc loadDabanMoreMarketNewData];
//        [daVc loadDabanDetailAndDaDetailNewData];
    }
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
