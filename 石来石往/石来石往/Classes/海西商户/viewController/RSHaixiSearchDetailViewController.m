//
//  RSHaixiSearchDetailViewController.m
//  石来石往
//
//  Created by mac on 2021/10/29.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSHaixiSearchDetailViewController.h"
#import "RSSCOwnerDetailViewController.h"
#import "RSHistorySearchModel.h"

#import "RSDetailSegmentViewController.h"

@interface RSHaixiSearchDetailViewController ()<UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)UITextField * searchTextView;

//@property (nonatomic,strong)NSArray *titleData;
//
//@property (nonatomic,strong)NSMutableArray * views;

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

@implementation RSHaixiSearchDetailViewController

- (NSMutableArray *)titleBtns{
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}




//- (NSArray *)titleData {
//    if (!_titleData) {
//        _titleData = @[@"荒料",@"大板"];
//    }
//    return _titleData;
//}

//- (NSMutableArray *)views{
//    if (!_views) {
//        _views = [NSMutableArray array];
//    }
//    return _views;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加搜索
    UIView * searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width_Real(319), Height_Real(32))];
    searchView.layer.cornerRadius = Width_Real(15);
    searchView.layer.masksToBounds = true;
    searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F6F8"];
    
    UIImageView * searchImage = [[UIImageView alloc]init];
    searchImage.image = [UIImage imageNamed:@"cxSearch"];
    [searchView addSubview:searchImage];
    
    searchImage.sd_layout.centerYEqualToView(searchView).leftSpaceToView(searchView, Width_Real(15)).widthIs(Width_Real(13)).heightEqualToWidth();
    
    //搜索内容
    //搜索内容
    UITextField * searchTextView = [[UITextField alloc]init];
//        searchTextView.zw_placeHolder = placeholder;
    searchTextView.placeholder = @"请输入你需要的石材";
    searchTextView.text = self.title;
//        searchTextView.showsVerticalScrollIndicator = false;
    searchTextView.returnKeyType = UIReturnKeySend;//返回键的类型
//    [searchTextView addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    searchTextView.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入你需要的石材" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#999999"]}];
    searchTextView.attributedPlaceholder = placeholderString;
//        searchTextView.zw_placeHolderColor = [UIColor colorWithHexColorStr:@"#999999"];
    [searchView addSubview:searchTextView];
    searchTextView.delegate = self;
    searchTextView.sd_layout.centerYEqualToView(searchView).leftSpaceToView(searchImage, Width_Real(6)).heightIs(Height_Real(32)).rightSpaceToView(searchView, 0);
    _searchTextView = searchTextView;
    
   
    
    
    self.navigationItem.titleView = searchView;
    
    
    
//     [self setCachePolicy:WMPageControllerCachePolicyBalanced];//平衡高，低缓存，建议设置
//
//     self.titles = self.titleData;
//
//     self.progressColor = [UIColor colorWithHexColorStr:@"#3385ff"];
//     self.progressHeight = Height_Real(3);
//     self.progressViewWidths = @[[NSString stringWithFormat:@"%f",Width_Real(16)],[NSString stringWithFormat:@"%f",Width_Real(16)]];
//     self.progressViewBottomSpace = 0;
// //    self.progressViewIsNaughty = YES;
//     self.titleFontName = @"PingFangSC-Medium";
//     self.titleSizeNormal = Width_Real(15);//未选中字体大小
//     self.titleSizeSelected = Width_Real(16);//选中字体大小
//     self.titleColorNormal =[UIColor colorWithHexColorStr:@"#333333"];
//     self.titleColorSelected = [UIColor colorWithHexColorStr:@"#3385ff"];
//     self.menuHeight = Height_Real(38);
//     self.menuBGColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//     self.menuViewStyle = WMMenuViewStyleLine;
//     self.menuViewLayoutMode = WMMenuViewLayoutModeLeft;
//     self.menuItemWidth = (SCW/2)/self.titleData.count;//每个标题的宽度
//
//     for (int i = 0; i < self.titleData.count; i++) {
//         RSSCOwnerDetailViewController * SCContentVc = [[RSSCOwnerDetailViewController alloc]init];
//         SCContentVc.title = self.titleData[i];
//         SCContentVc.stoneName = @"";
//         [self.views addObject:SCContentVc];
//     }
//
//    [self reloadData];
//
//    [self addCustomTableviewConntroller];
    
    
  
    
    NSArray * titleArray = @[@"荒料",@"大板"];
    //添加标题view
    [self addBLShowTitleViewWithTitleArray:titleArray];
    // 添加内容的scrollView
    [self addBLShowContentScrollView];
    
    // 添加所有的子控制器
    NSMutableArray * controllers = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        RSSCOwnerDetailViewController * SCContentVc = [[RSSCOwnerDetailViewController alloc]init];
        SCContentVc.title = titleArray[i];
        SCContentVc.stoneName = self.title;
        [controllers addObject:SCContentVc];
    }
    [self addAllChildViewViewControllers:controllers];
    // 默认点击下标为0的标题按钮
    [self titleBtnClick:self.titleBtns[0]];
    
}


- (void)addBLShowTitleViewWithTitleArray:(NSArray *)titleArray{
    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(0, 0 ,SCW/2, Height_Real(38))];
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
    contentScrollView.frame = CGRectMake(0,self.titleView.yj_y + self.titleView.yj_height , SCW, SCH - self.titleView.yj_y - self.titleView.yj_height - Height_NavBar);
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
    // 按钮宽度
    CGFloat btnW = (SCW/2)/titleArray.count;
    CGFloat btnH = self.titleView.yj_height;
    for (int i = 0; i < titleArray.count; i++) {
        // 创建标题按钮
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.tag = i;
        titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightMedium];
        [titleBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        // 设置文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
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
//        self.searchTextView.text = @"";
        [self.searchTextView resignFirstResponder];
//        self.searchTextView.placeholder = @"请输入你要的石材";
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


#pragma mark uitextfieldDelegate
// 结束编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    CLog(@"----2222-----------%@",textField.text);
//    CLog(@"----2222-----------%d",self.selectIndex);
//    RSSCOwnerDetailViewController * SCContentVc =(RSSCOwnerDetailViewController *)self.views[self.selectIndex];
    
//    [textView resignFirstResponder];
//}




- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.searchTextView resignFirstResponder];
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
         //[self.rsSearchTextField resignFirstResponder];
        return NO;
    }
    self.tableview.hidden = YES;
    self.searchTextView.text = textField.text;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        RSSCOwnerDetailViewController * SCContentVc =(RSSCOwnerDetailViewController *)self.childViewControllers[i];
        SCContentVc.stoneName = self.searchTextView.text;
        [SCContentVc newStoneSearchPageSize:10 andIsHead:true andStoneName:SCContentVc.stoneName];
    }
    return YES;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textField resignFirstResponder];
       //在这里做你响应return键的代码
       return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}







//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//   [self.searchTextView resignFirstResponder];
//}


@end
