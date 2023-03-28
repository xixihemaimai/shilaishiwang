//
//  RSBootPageViewController.m
//  石来石往
//
//  Created by mac on 17/6/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSBootPageViewController.h"


#import "RSLeftViewController.h"

#import "RSHomeViewController.h"

#import "RSMainTabBarViewController.h"

#import "RSADViewController.h"


@interface RSBootPageViewController ()<UIScrollViewDelegate>
{
    // 创建页码控制器
   // UIPageControl *pageControl;
    // 判断是否是第一次进入应用
    BOOL flag;
}

@end

@implementation RSBootPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    for (int i=0; i<3; i++) {
//        if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"启动页%d",i+1]];
//        }else{
//            image = [UIImage imageNamed:[NSString stringWithFormat:@"启动页9-%d",i+1]];
//        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCW * i, 0, SCW, SCH)];
        // 在最后一页创建按钮
        if (i == 2) {
            // 必须设置用户交互 否则按键无法操作
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
                 button.frame = CGRectMake((SCW / 2)/2 , SCH - ((SCH/2)/3), SCW / 2, SCH / 16);
//            }else{
//                 button.frame = CGRectMake((SCW / 2)/2 , SCH - ((SCH/2)/2), SCW / 2, SCH / 16);
//            }
           
            //[button setTitle:@"点击进入" forState:UIControlStateNormal];
            //[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:@"立即体验-未点击"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"立即体验点击"] forState:UIControlStateHighlighted];
            button.layer.borderWidth = 1;
            button.layer.cornerRadius = 5;
            button.layer.borderColor = [UIColor  colorWithRed:255/255.0 green:164/255.0 blue:0/255.0 alpha:1.0].CGColor;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            [button bringSubviewToFront:imageView];
        }
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(SCW * 3, SCH);
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
   // pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCW / 3, SCH * 15 / 16, SCW / 3, SCH / 16)];
    // 设置页数
    //pageControl.numberOfPages = 3;
    // 设置页码的点的颜色
    //pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    // 设置当前页码的点颜色
    //pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    //[self.view addSubview:pageControl];
    
    
    
    
}



#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算当前在第几页
    //pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
}

// 点击按钮保存数据并切换根视图控制器
- (void) go:(UIButton *)sender{
    flag = YES;
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 保存用户数据
    [useDef setBool:flag forKey:@"notFirst"];
    [useDef synchronize];
    // 切换根视图控制器
    
//    RSNavigationViewController *naVc = [[RSNavigationViewController alloc]initWithRootViewController:[RSHomeViewController alloc]];
//    RSLeftViewController *rsLeftVc = [[RSLeftViewController alloc]initWithStyle:UITableViewStylePlain];
//    
//    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc]initWithContentViewController:naVc menuViewController:rsLeftVc];
//    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    
    
//    RSMainTabBarViewController * mainTabbarVc = [[RSMainTabBarViewController alloc]init];
//
//    mainTabbarVc.selectedIndex = 0;
//
//    self.view.window.rootViewController = mainTabbarVc;
    
    
    RSADViewController * adVc = [[RSADViewController alloc]init];
    
    self.view.window.rootViewController = adVc;
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
