//
//  RSSelectionCenterViewController.m
//  石来石往
//
//  Created by mac on 2021/10/23.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSelectionCenterViewController.h"
#import "RSSCContentViewController.h"
#import "RSSCMoreContentViewController.h"

#import "RSSCOwnerDetailViewController.h"

#import "QiCodeScanningViewController.h"

@interface RSSelectionCenterViewController ()<UIScrollViewDelegate,RSSearchContentViewDelegate>

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


@property (nonatomic,strong)RSSearchContentView * searchContentView;


@end

@implementation RSSelectionCenterViewController



- (RSSearchContentView *)searchContentView{
    if (!_searchContentView) {
        _searchContentView = [[RSSearchContentView alloc]initWithFrame:CGRectMake(0, 0, SCW, Height_Real(161)) andPlaceholder:@"请输入你要查找的石材" andShowQRCode:true andShopBusiness:false andIsEdit:false];
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
    
    //这边要添加一个按键是跳转到二维码的部分
    [self.view addSubview:self.searchContentView];
    NSArray * titleArray = @[@"大理石",@"花岗石",@"莱姆石",@"企业",@"精选案例"];
    //添加标题view
    [self addBLShowTitleViewWithTitleArray:titleArray];
    // 添加内容的scrollView
    [self addBLShowContentScrollView];
    
    // 添加所有的子控制器
    NSMutableArray * controllers = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        RSSCContentViewController * SCContentVc = [[RSSCContentViewController alloc]init];
        SCContentVc.title = titleArray[i];
        SCContentVc.stoneName = @"";
        SCContentVc.nameCn = @"";
        SCContentVc.subject = @"";
        SCContentVc.type = 0;
        SCContentVc.isExhibitionLocation = true;
        [controllers addObject:SCContentVc];
    }
    [self addAllChildViewViewControllers:controllers];
    // 默认点击下标为0的标题按钮
    [self titleBtnClick:self.titleBtns[0]];
    RSWeakself
    //版本获取
    static dispatch_once_t disOnce;
    dispatch_once(&disOnce,^ {
       //只执行一次的代码
       //获取版本号
       [weakSelf getAPPCurrentVersion];
    });
}

#pragma mark -- 获取版本号
- (void)getAPPCurrentVersion{
    //当前APP的名称
    //NSString * currentAppName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    //当前APP的版本
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    //app build版本
    //NSString *currentBulid = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    //包名
    NSString * currentBundleIdentifier = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"APP_TYPE"];
    [phoneDict setObject:currentBundleIdentifier forKey:@"VERSION"];
    [phoneDict setObject:currentVersion forKey:@"versionCode"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (applegate.ERPID == nil) {
        applegate.ERPID = @"0";
    }
//    RSWeakself
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_CURRENTVERSION_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSString * updateName = [NSString stringWithFormat:@"%@",json[@"MSG_CODE"]];
                NSString * url = [NSString stringWithFormat:@"%@",json[@"Data"][@"URL"]];
                //判断第一次进来之后的显示系统的问题
                if (![currentVersion isEqualToString:json[@"Data"][@"VERSIONCODE"]]) {
                    [JHSysAlertUtil presentAlertViewWithTitle:@"商店有最新版" message:updateName cancelTitle:@"取消" defaultTitle:@"确定" distinct:true cancel:^{
                    } confirm:^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                    }];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取版本错误"];
            }
        }
    }];
}






#pragma mark 添加标题view
- (void)addBLShowTitleViewWithTitleArray:(NSArray *)titleArray{
    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(Width_Real(14), self.searchContentView.yj_y + self.searchContentView.yj_height + Height_Real(5), SCW - Width_Real(28), Height_Real(38))];
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
    CGFloat btnW = self.titleView.yj_width/titleArray.count;
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
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
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
    self.preBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(14) weight:UIFontWeightRegular];
    self.preBtn.selected = NO;
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:Width_Real(17) weight:UIFontWeightMedium];
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
        if ([titleBtn.currentTitle isEqualToString:@"企业"]) {
            self.searchContentView.searchTextView.placeholder = @"请输入你要的企业";
        }else if ([titleBtn.currentTitle isEqualToString:@"精选案例"]){
            self.searchContentView.searchTextView.placeholder = @"请输入你要的精选案例";
        }else{
            self.searchContentView.searchTextView.placeholder = @"请输入你要的石材";
        }
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
- (void)openScanQRCode{
    QiCodeScanningViewController * scanVc = [[QiCodeScanningViewController alloc]init];
    [self.navigationController pushViewController:scanVc animated:true];
    scanVc.ScanResult = ^(NSString * _Nonnull resultString) {
        if (resultString) {
            CLog(@"扫描结果：%@",resultString);
            [self showInfo:resultString];
        } else {
            CLog(@"error: %@",resultString);
        }
    };
//    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeAll onFinish:^(NSString *result, NSError *error) {
//        if (error) {
//            CLog(@"error: %@",error);
//        } else {
//            CLog(@"扫描结果：%@",result);
//            [self showInfo:result];
//        }
//    }];
//    [self.navigationController pushViewController:scanVc animated:YES];
}

//扫描的结果
- (void)showInfo:(NSString*)str {
    CLog(@"扫描的结果%@",str);
    
    str = [str stringByRemovingPercentEncoding];
    /**
     NSStringEncoding dec = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacJapanese);
     NSData * data = [str dataUsingEncoding:dec];
     NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
     str = [[NSString alloc]initWithData:data encoding:enc];
     
     */
//    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString * dealwithStr = [[NSString alloc] initWithData:data encoding:enc];
//    //如果扫描中文乱码则需要处理，否则不处理
//    if (dealwithStr){
//        NSInteger max = [str length];
//        char *nbytes = malloc(max + 1);
//        for (int i = 0; i < max; i++){
//            unichar ch = [str characterAtIndex: i];
//            nbytes[i] = (char) ch;
//        }
//        nbytes[max] = '\0';
//        str = [NSString stringWithCString:nbytes encoding:enc];
//        CLog(@"=======================================%@",str);
//    }
//    if (dealwithStr != nil) {
    NSArray *array = [str componentsSeparatedByString:@","];
    NSLog(@"%@",array);
    if (array.count > 1) {
        RSSCOwnerDetailViewController * ownerVc = [[RSSCOwnerDetailViewController alloc]init];
        ownerVc.title = array[2];
        ownerVc.enterpriseId = [array[0] integerValue];
        ownerVc.stoneType = array[1];
        ownerVc.stoneName = array[2];
        [self.navigationController pushViewController:ownerVc animated:YES];
    }else{
        [JHSysAlertUtil presentAlertViewWithTitle:@"扫描的数据失败" message:nil confirmTitle:@"确定" handler:^{
        }];
    }
}


//- (NSString *)urlDecodedString:(NSString *)str{
//    NSString * decodedString = (__bridge_transfer NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
//    return decodedString;
//}

//搜索框搜索的内容
//- (void)searchTextViewWithContentStr:(NSString *)searchStr{
//    //先要获取到那一个页面
//    CLog(@"------------------------%ld",self.preBtn.tag);
//    RSSCContentViewController * SCContentVc =(RSSCContentViewController *)self.childViewControllers[self.preBtn.tag];
//    //这边就是执行获取数据显示
//}


#pragma mark -- 跳转到新的界面
- (void)jumpNewController{
//    CLog(@"=======================================");
    RSSCMoreContentViewController * scMoreContentVc = [[RSSCMoreContentViewController alloc]init];
    if (self.preBtn.tag == 0 || self.preBtn.tag == 1 || self.preBtn.tag == 2) {
        scMoreContentVc.selectIndex = 0;
    }else if (self.preBtn.tag == 3){
        scMoreContentVc.selectIndex = 1;
    }else{
        scMoreContentVc.selectIndex = 2;
    }
    
//    NSLog(@"========================%ld",(long)self.preBtn.tag);
//    SCContentVc.stoneName = @"";
//    SCContentVc.nameCn = @"";
    [self.navigationController pushViewController:scMoreContentVc animated:true];
}



@end
