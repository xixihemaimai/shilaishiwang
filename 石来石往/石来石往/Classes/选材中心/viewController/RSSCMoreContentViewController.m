//
//  RSSCMoreContentViewController.m
//  石来石往
//
//  Created by mac on 2021/11/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCMoreContentViewController.h"
#import "RSSCContentViewController.h"

@interface RSSCMoreContentViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField * searchTextView;

@property (nonatomic,strong)NSArray *titleData;

@property (nonatomic,strong)NSMutableArray * views;


@end

@implementation RSSCMoreContentViewController

- (NSArray *)titleData {
    if (!_titleData) {
        //@"大理石",@"花岗石",@"莱姆石",
        _titleData = @[@"石材信息",@"企业",@"精选案例"];
    }
    return _titleData;
}

- (NSMutableArray *)views{
    if (!_views) {
        _views = [NSMutableArray array];
    }
    return _views;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏要添加搜索框
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
    UITextField * searchTextView = [[UITextField alloc]init];
//        searchTextView.zw_placeHolder = placeholder;
    searchTextView.placeholder = @"请输入你需要的石材";
//        searchTextView.showsVerticalScrollIndicator = false;
    searchTextView.returnKeyType = UIReturnKeySend;//返回键的类型
    searchTextView.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入你需要的石材" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#999999"]}];
    searchTextView.attributedPlaceholder = placeholderString;
//        searchTextView.zw_placeHolderColor = [UIColor colorWithHexColorStr:@"#999999"];
    [searchView addSubview:searchTextView];
    searchTextView.delegate = self;
    searchTextView.sd_layout.centerYEqualToView(searchView).leftSpaceToView(searchImage, Width_Real(6)).heightIs(Height_Real(32)).rightSpaceToView(searchView, 0);
    _searchTextView = searchTextView;
    self.navigationItem.titleView = searchView;
    
    [self setCachePolicy:WMPageControllerCachePolicyBalanced];//平衡高，低缓存，建议设置
    self.preloadPolicy = WMPageControllerPreloadPolicyNever;
    self.titles = self.titleData;
    self.progressColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    self.progressHeight = Height_Real(3);
    self.progressViewWidths = @[[NSString stringWithFormat:@"%f",Width_Real(16)],[NSString stringWithFormat:@"%f",Width_Real(16)],[NSString stringWithFormat:@"%f",Width_Real(16)],[NSString stringWithFormat:@"%f",Width_Real(16)],[NSString stringWithFormat:@"%f",Width_Real(16)]];
    self.progressViewBottomSpace = 0;
//    self.progressViewIsNaughty = YES;
    self.titleFontName = @"PingFangSC-Medium";
    self.titleSizeNormal = Width_Real(14);//未选中字体大小
    self.titleSizeSelected = Width_Real(17);//选中字体大小
    self.titleColorNormal =[UIColor colorWithHexColorStr:@"#333333"];
    self.titleColorSelected = [UIColor colorWithHexColorStr:@"#3385ff"];
    self.menuHeight = Height_Real(38);
    self.menuBGColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuItemWidth =  SCW / self.titleData.count;//每个标题的宽度
    for (int i = 0; i < self.titleData.count; i++) {
        RSSCContentViewController * SCContentVc = [[RSSCContentViewController alloc]init];
        SCContentVc.title = self.titleData[i];
        SCContentVc.stoneName = @"";
        SCContentVc.nameCn = @"";
        SCContentVc.subject = @"";
        SCContentVc.type = 1;
        SCContentVc.isExhibitionLocation = false;
        [self.views addObject:SCContentVc];
    }
    [self reloadData];
}

#pragma mark - WMPageControllerDelegate,WMMenuViewDataSource
//子控制器数量
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}
 
//获取当前显示的控制器
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    return self.views[index];
}
 
//设置当前选中的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
//    NSLog(@"------------------------%ld",(long)self.selectIndex);
//    NSLog(@"--------------2222----------%ld",(long)index);
    return self.titles[index];
}
 
//设置菜单栏尺寸
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    return CGRectMake(0, 0, SCW, Height_Real(38));
}
 
//设置子控制器尺寸
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    return CGRectMake(0, 0, SCW, SCH - Height_NavBar - Height_Real(38));
}


/**
 内容视图完全停止滚动时调用（viewController完全显示在用户面前）
 @param pageController pageController
 @param viewController 即将显示的viewController
 @param info 包含index、title
 */
- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
//    CLog(@"==============================%@",viewController.title);
//    CLog(@"==============================%@",info);
//    CLog(@"==============================%@",info[@"title"]);
    if ([info[@"title"] isEqualToString:@"企业"]) {
        self.searchTextView.placeholder = @"请输入你要的企业";
    }else if ([info[@"title"] isEqualToString:@"精选案例"]){
        self.searchTextView.placeholder = @"请输入你要的精选案例";
    }else{
        self.searchTextView.placeholder = @"请输入你要的石材";
    }
    //self.searchTextView.text = @"";
}


#pragma mark uitextfieldDelegate
// 结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{
//    CLog(@"----2222-3232323----------%@",textField.text);
//    CLog(@"----2222-----------%d",self.selectIndex);
    RSSCContentViewController * SCContentVc =(RSSCContentViewController *)self.views[self.selectIndex];
    SCContentVc.title = self.titleData[self.selectIndex];
    SCContentVc.type = 1;
    if ([self.titleData[self.selectIndex] isEqualToString:@"企业"]) {
        SCContentVc.nameCn = textField.text;
        SCContentVc.stoneName = @"";
        SCContentVc.subject = @"";
       [SCContentVc selectionCenterShowContentWithSearchType:@"0" andNameCn:SCContentVc.nameCn andStoneName:SCContentVc.stoneName andSubject:SCContentVc.subject andPageSize:10 andIsHead:true];
    }else if ([self.titleData[self.selectIndex] isEqualToString:@"精选案例"]){
        SCContentVc.nameCn = @"";
        SCContentVc.subject = textField.text;
        SCContentVc.stoneName = @"";
        [SCContentVc selectionCenterShowContentWithSearchType:@"0" andNameCn:SCContentVc.nameCn andStoneName:SCContentVc.stoneName andSubject:SCContentVc.subject andPageSize:10 andIsHead:true];
    }else{
        SCContentVc.nameCn = @"";
        SCContentVc.subject = @"";
        SCContentVc.stoneName = textField.text;
//        NSString * stoneType = @"0";
//        if ([self.title isEqualToString:@"大理石"]) {
//            stoneType = @"0";
//        }else if ([self.title isEqualToString:@"花岗石"]){
//            stoneType = @"1";
//        }else{
//            stoneType = @"2";
//        }
        
       [SCContentVc selectionCenterShowContentWithSearchType:@"0" andNameCn:SCContentVc.nameCn andStoneName:SCContentVc.stoneName andSubject:SCContentVc.subject andPageSize:10 andIsHead:true];
    }
    
//    [textView resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textField resignFirstResponder];
       //在这里做你响应return键的代码
       return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}




@end
