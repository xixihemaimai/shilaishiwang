//
//  RSShopBusinessViewController.m
//  石来石往
//
//  Created by mac on 2021/10/29.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSShopBusinessViewController.h"
#import "YBPopupMenu.h"
//电话簿
#import "RSOwnerViewController.h"
//信息
#import "RSNSNotificationMessageViewController.h"
//发布商圈
#import "RSMyPublishViewController.h"
//商圈界面
#import "RSShopCircleViewController.h"


@interface RSShopBusinessViewController ()<RSSearchContentViewDelegate,UIScrollViewDelegate,YBPopupMenuDelegate,RSShopCircleViewControllerDelegate>

@property (nonatomic,strong)RSSearchContentView * searchContentView;
/** 保存上一次点击的按钮 */
@property (nonatomic,strong) UIButton * preBtn;
/**标题视图*/
@property (nonatomic,strong)UIView * titleView;
/**内容的视图*/
@property (nonatomic,strong)UIScrollView *contentScrollView;
/** 下滑线 */
@property (nonatomic,strong) UIView *lineView;
/** 保存所有的标题按钮 */
@property (nonatomic,strong) NSMutableArray *titleBtns;

@end

@implementation RSShopBusinessViewController

- (RSSearchContentView *)searchContentView{
    if (!_searchContentView) {
        _searchContentView = [[RSSearchContentView alloc]initWithFrame:CGRectMake(0, 0, SCW, Height_Real(161)) andPlaceholder:@"请输入你要查找的石材" andShowQRCode:false andShopBusiness:true andIsEdit:true];
        _searchContentView.delegate = self;
    }
    return _searchContentView;
}

- (NSMutableArray *)titleBtns{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.searchContentView];
    NSArray * titleArray = @[@"供应",@"求购"];
    //添加标题view
    [self addBLShowTitleViewWithTitleArray:titleArray];
    // 添加内容的scrollView
    [self addBLShowContentScrollView];
    
    // 添加所有的子控制器
    NSMutableArray * controllers = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        RSShopCircleViewController * SCContentVc = [[RSShopCircleViewController alloc]init];
        SCContentVc.title = titleArray[i];
        SCContentVc.delegate = self;
        SCContentVc.searchType = 1;
        [controllers addObject:SCContentVc];
    }
    [self addAllChildViewViewControllers:controllers];
    // 默认点击下标为0的标题按钮
    [self titleBtnClick:self.titleBtns[0]];
}

#pragma mark 添加标题view
- (void)addBLShowTitleViewWithTitleArray:(NSArray *)titleArray{
    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(Width_Real(16), self.searchContentView.yj_y + self.searchContentView.yj_height + Height_Real(5), SCW - Width_Real(32), Height_Real(38))];
    titleview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.titleView = titleview;
    [self.view addSubview:titleview];
    // 添加所有的标题按钮
    [self addAllTitleBtnsWithTitleArray:titleArray];
    // 添加下滑线
    [self setupUnderLineView];
}
#pragma mark 添加内容的scrollView
- (void)addBLShowContentScrollView
{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView = contentScrollView;
    contentScrollView.frame = CGRectMake(0,self.titleView.yj_y + self.titleView.yj_height , SCW, SCH - self.titleView.yj_y - self.titleView.yj_height - Height_TabBar);
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

#pragma mark 添加下滑线
- (void)setupUnderLineView
{
    //获取下标为0的标题按钮
    UIButton *titleBtn = self.titleBtns[0];
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    lineView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    //下滑线高度
    CGFloat lineViewH = Height_Real(3);
    CGFloat y = self.titleView.yj_height - lineViewH - Height_Real(4);
    lineView.yj_height = lineViewH;
    lineView.yj_y = y;
    //设置下划线的宽度比文本内容宽度大10
    [titleBtn.titleLabel sizeToFit];
    //lineView.yj_width = titleBtn.titleLabel.yj_width;
    lineView.yj_width = Width_Real(16);
    lineView.yj_centerX = titleBtn.yj_centerX;
    // 添加到titleView里
    [self.titleView addSubview:lineView];
    lineView.layer.cornerRadius = Width_Real(2);
    //lineView.layer.masksToBounds = YES;
}


#pragma mark - 添加所有的子控制器  添加控制器的数组
- (void)addAllChildViewViewControllers:(NSMutableArray<UIViewController *> *)controllers
{


    for (UIViewController * controller in controllers) {
        [self addChildViewController:controller];
    }

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
- (void)addAllTitleBtnsWithTitleArray:(NSArray *)titleArray;
{
    // 所有的标题
//    NSArray *titles = ;
    // 按钮宽度
    CGFloat btnW = (self.titleView.yj_width/3)/titleArray.count;
//    if (showType == 1) {
//       btnW = (SCW/2)/titles.count;
//    }else{
//       btnW = SCW/titles.count;
//    }
    CGFloat btnH = self.titleView.yj_height;
    for (int i = 0; i < titleArray.count; i++) {
        // 创建标题按钮
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.tag = i;
        titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(15) weight:UIFontWeightMedium];
        [titleBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        // 设置文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        // 设置选中按钮的文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateSelected];
        [self.titleView addSubview:titleBtn];
        // 保存标题按钮
        [self.titleBtns addObject:titleBtn];
        // 添加点击事件
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
}
#pragma mark - 标题点击事件
- (void)titleBtnClick:(UIButton *)titleBtn
{
   self.preBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightMedium];
   self.preBtn.selected = NO;
   titleBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(17) weight:UIFontWeightSemibold];
    //self.preBtn.selected = NO;
    titleBtn.selected = YES;
    self.preBtn = titleBtn;
    NSInteger tag = titleBtn.tag;
    // 2.处理下滑线的移动
    [UIView animateWithDuration:0.25 animations:^{
//        self.lineView.yj_width = titleBtn.titleLabel.yj_width;
        self.lineView.yj_centerX = titleBtn.yj_centerX;
        // 3.修改contentScrollView的便宜量,点击标题按钮的时候显示对应子控制器的view
        self.contentScrollView.contentOffset = CGPointMake(tag * self.contentScrollView.yj_width, 0);
//        CLog(@"-------------------------%@",titleBtn.currentTitle);
        self.searchContentView.searchTextView.text = @"";
        [self.searchContentView.searchTextView resignFirstResponder];
//        if ([titleBtn.currentTitle isEqualToString:@"企业"]) {
//            self.searchContentView.searchTextView.zw_placeHolder = @"请输入你要的企业";
//        }else if ([titleBtn.currentTitle isEqualToString:@"精选案例"]){
//            self.searchContentView.searchTextView.zw_placeHolder = @"请输入你要的精选案例";
//        }else{
//            self.searchContentView.searchTextView.zw_placeHolder = @"请输入你要的石材";
//        }
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


#pragma mark RSSearchContentViewDelegate
- (void)implementActionWithTag:(NSInteger)tag andActionName:(NSString *)actionName andButton:(nonnull UIButton *)btn{
//    CLog(@"点击的按键的-----------------%@",actionName);
    [UserManger checkLogin:self successBlock:^{
        if ([actionName isEqualToString:@"电话簿"]) {
            RSOwnerViewController * ownerVc = [[RSOwnerViewController alloc]init];
            //ownerVc.usermodel = self.userModel;
            [self.navigationController pushViewController:ownerVc animated:YES];
        }else if ([actionName isEqualToString:@"信息"]){
            RSNSNotificationMessageViewController * nsnotVc = [[RSNSNotificationMessageViewController alloc]init];
//            nsnotVc.userModel = self.userModel;
//            nsnotVc.delegate = self;
            [self.navigationController pushViewController:nsnotVc animated:YES];
            
        }else{
            [YBPopupMenu showRelyOnView:btn titles:@[@"供应",@"求购"] icons:@[@"供应",@"新求购"] menuWidth:Width_Real(152) andTag:0 delegate:self];
        }
    }];
}


- (void)searchTextViewWithContentStr:(NSString *)searchStr{
//    CLog(@"搜索的内容------------%@",searchStr);
//    CLog(@"++++++++++++++++++++++++++=%ld",self.preBtn.tag);
    RSShopCircleViewController * shopCircleVc = self.childViewControllers[self.preBtn.tag];
    shopCircleVc.searchStr = searchStr;
    shopCircleVc.searchType = 2;
    [shopCircleVc loadNewDataWithPageSize:10 andIsHead:true];
}




#pragma mark YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
//    CLog(@"============================%ld",index);
    
    RSMyPublishViewController * myPublishVc = [[RSMyPublishViewController alloc]init];
    myPublishVc.usermodel = [UserManger getUserObject];
    if (index == 0) {
        myPublishVc.tempStr = @"gongying";
    }else{
        myPublishVc.tempStr = @"qiugou";
    }
    [self.navigationController pushViewController:myPublishVc animated:true];
}


#pragma mark -- 关注
- (void)changAttatitionDataMoment:(Moment *)moment andSelectStr:(NSString *)selectStr{
    if ([selectStr isEqualToString:@"gongying"]) {
        //推荐
        RSShopCircleViewController * shopCircle = self.childViewControllers[1];
        for (int i = 0; i < shopCircle.momentList.count; i++) {
            Moment * moment1 = shopCircle.momentList[i];
            if ([moment.HZName isEqualToString:moment1.HZName]) {
                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                moment1.attstatus = moment.attstatus;
                [shopCircle.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    }else{
        RSShopCircleViewController * shopCircle = self.childViewControllers[0];
        for (int i = 0; i < shopCircle.momentList.count; i++) {
            Moment * moment1 = shopCircle.momentList[i];
            if ([moment.HZName isEqualToString:moment1.HZName]) {
                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                moment1.attstatus = moment.attstatus;
                [shopCircle.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    }
}






@end
