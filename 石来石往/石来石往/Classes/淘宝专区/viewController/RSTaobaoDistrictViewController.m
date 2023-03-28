//
//  RSTaobaoDistrictViewController.m
//  石来石往
//
//  Created by mac on 2019/7/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaobaoDistrictViewController.h"

//淘宝首页，荒料，大板
#import "RSTaoBaoContentViewController.h"
//收藏界面
#import "RSTaobaoCollectionViewController.h"
//搜索
#import "RSTaoBaoSearchViewController.h"
//申请商店
#import "RSTaoBaoApplyShopViewController.h"
//登录
#import "RSLoginViewController.h"
//店铺管理
#import "RSTaoBaoCommodityManagementViewController.h"
//消息
#import "RSRedButton.h"
#import "RSNSNotificationMessageViewController.h"



#import "RSPaymentViewController.h"

//RSNSNotificationMessageViewControllerDelegate
@interface RSTaobaoDistrictViewController ()<UIScrollViewDelegate>

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

@property (nonatomic,strong) RSTaoBaoTool * taobaotool;


//@property (nonatomic,strong)RSRedButton * redbtn;

@end

@implementation RSTaobaoDistrictViewController
- (NSMutableArray *)titleBtns{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshRedBtnBadvalue) name:@"badgeValuerefresh" object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changEntryMode) name:@"SignOutLogin" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去掉控制器给scrollView添加的额外内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //[self loadTaoBaoUserInformation];
    RSTaoBaoTool * taobaotool = [[RSTaoBaoTool alloc]init];
    self.taobaotool = taobaotool;
    
    
    RSWeakself
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //添加搜索的界面
        [self addCustomSearchView];
        //添加标题view
        [self addBLShowTitleView];
        // 添加内容的scrollView
        [self addBLShowContentScrollView];
        // 添加所有的子控制器
        [self addAllChildViewControllers];
        // 默认点击下标为0的标题按钮
        [self titleBtnClick:self.titleBtns[0]];
    });
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
    RSWeakself
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
                   UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"商店有最新版" message:updateName preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    
                    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //随便的
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                                   }];
                    [alertView addAction:alert1];
                    
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                   [weakSelf presentViewController:alertView animated:YES completion:nil];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取版本错误"];
            }
        }
    }];
}







- (void)addCustomSearchView{
    //system-guanzhu复制
    UIView * searchView = [[UIView alloc]init];
    searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:searchView];
    
    //左边的位置
//    RSRedButton * redbtn = [[RSRedButton alloc] init];
//    [redbtn setImage:[UIImage imageNamed:@"通知1"] forState:UIControlStateNormal];
//    [redbtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
//    [redbtn addTarget:self action:@selector(jumpNSNotificationCenterViewController:) forControlEvents:UIControlEventTouchUpInside];
//       //redbtn.badgeValue = 3; //红点的值_btn.isRedBall = YES;此布尔值的设置只显示红点
//    [searchView addSubview:redbtn];
//    _redbtn = redbtn;
    
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"输入品种名" forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#EDEDED"]];
    [searchBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(taoBaoSearchAction:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [searchView addSubview:searchBtn];
    
    
    UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setTitle:@"..." forState:UIControlStateNormal];
    [menuBtn setTitleColor:[UIColor colorWithHexColorStr:@"#424545"] forState:UIControlStateNormal];
    menuBtn.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:21];
    [searchView addSubview:menuBtn];
    [menuBtn addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        searchView.frame = CGRectMake(0, 0, SCW, 88);
//      redbtn.frame = CGRectMake(12, 30, 25, 25);
        searchBtn.frame = CGRectMake(SCW/2 - (SCW/2 + 100)/2, 47, SCW/2 + 100, 32);
        menuBtn.frame = CGRectMake(SCW - 12 - 40, 40, 40, 32);
    }else{
        searchView.frame = CGRectMake(0, 0, SCW, 64);
//      redbtn.frame = CGRectMake(12, 30, 25, 25);
        searchBtn.frame = CGRectMake(SCW/2 - (SCW/2 + 100)/2, 27, SCW/2 + 100, 32);
        menuBtn.frame = CGRectMake(SCW - 40, 20, 40, 32);
    }
    searchBtn.layer.cornerRadius = 17;
}



//#pragma mark -- 重新获取角标数
//- (void)refreshRedBtnBadvalue{
//    [self reloadmessageCount];
//}
//
//
////#pragma mark -- 获取消息次数
//- (void)reloadmessageCount{
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * verifkey = [user objectForKey:@"VERIFYKEY"];
//    if (verifkey.length > 1) {
//        if (self.usermodel.userID != nil && self.usermodel.userName != nil && self.usermodel.userPhone != nil) {
//            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//            [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
//            //二进制数
//            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifkey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//            //__weak typeof(self) weakSelf = self;
//            XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//            [network getDataWithUrlString:URL_MESSAGECOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//                if (success) {
//                    BOOL Result = [json[@"Result"]boolValue];
//                    if (Result) {
//                        _redbtn.badgeValue = [json[@"Data"] integerValue];
//                    }
//                }else{
//                    _redbtn.badgeValue = 0;
//                }
//            }];
//        }else{
//            _redbtn.badgeValue = 0;
//            NSString * str = @"特别要注意的地方";
//            [RSERROExceptTool showErrorExceptErrorStr:str];
//        }
//    }else{
//        _redbtn.badgeValue = 0;
//    }
//}


//#pragma mark -- 跳转到通知页面
//- (void)jumpNSNotificationCenterViewController:(RSRedButton *)redBtn{
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
//    //self.userModel.userID == nil
//    if ( VERIFYKEY.length < 1 ) {
//        //self.hidesBottomBarWhenPushed = YES;
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//        loginVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginVc animated:YES];
//        //self.hidesBottomBarWhenPushed = NO;
//    }else{
//        //self.hidesBottomBarWhenPushed = YES;
//        //redBtn.badgeValue = 0;
//        RSNSNotificationMessageViewController * nsnotVc = [[RSNSNotificationMessageViewController alloc]init];
//        nsnotVc.userModel = self.usermodel;
//        nsnotVc.hidesBottomBarWhenPushed = YES;
//        nsnotVc.delegate = self;
//        [self.navigationController pushViewController:nsnotVc animated:YES];
//        //self.hidesBottomBarWhenPushed = NO;
//    }
//}

//- (void)messageCount:(NSInteger)selectCount{
//    self.redbtn.badgeValue = self.redbtn.badgeValue - selectCount;
//}
//
//
//- (void)changEntryMode{
//
//    self.redbtn.badgeValue = 0;
//}



//搜索界面
- (void)taoBaoSearchAction:(UIButton *)searchBtn{
    
//    RSPaymentViewController * payVc = [[RSPaymentViewController alloc]init];
//    [self.navigationController pushViewController:payVc animated:YES];
    
    RSTaoBaoSearchViewController * taobaoSearchVc = [[RSTaoBaoSearchViewController alloc]init];
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
//    if (VERIFYKEY.length < 1) {
//    }else{
//       taobaoSearchVc.taobaoUsermodel = self.taobaoUsermodel;
//    }
    [self.navigationController pushViewController:taobaoSearchVc animated:YES];
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
        [self.taobaotool showMenuContentType:@"首页" andOnView:menuBtn andViewController:self andBlock:^(RSTaobaoUserModel * _Nonnull taobaoUsermodel) {
            weakSelf.taobaoUsermodel = taobaoUsermodel;
        }];
//        [self.taobaotool showMenuContentType:@"首页" andOnView:menuBtn andViewController:self andUserModel:self.taobaoUsermodel];
    }
}




- (void)addBLShowTitleView{
//    CGFloat Y = 0.0;
//    if (iPhoneX_All) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, SCW/2, 38)];
    titleview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
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
//    if (iPhoneX_All) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView = contentScrollView;
    //self.contentScrollview.hidden = YES;
    //self.contentScrollView.backgroundColor = [UIColor  redColor];
    contentScrollView.frame = CGRectMake(0,Height_NavBar + 38 , SCW, SCH - Height_NavBar - 38);
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
    RSTaoBaoContentViewController * view1 = [[RSTaoBaoContentViewController alloc]init];
//    view1.taobaoUsermodel = self.taobaoUsermodel;
    view1.title = @"首页";
    view1.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [self addChildViewController:view1];
    
    RSTaoBaoContentViewController * view2 = [[RSTaoBaoContentViewController alloc]init];
//    view2.taobaoUsermodel = self.taobaoUsermodel;
    view2.title = @"荒料";
    view2.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [self addChildViewController:view2];
    
    RSTaoBaoContentViewController * view3 = [[RSTaoBaoContentViewController alloc]init];
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
    NSArray *titles = @[@"首页",@"荒料",@"大板"];
    // 按钮宽度
    CGFloat btnW = (SCW/2)/titles.count;
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
//    if (titleBtn.selected) {
//
//    }else{
//
//
//        titleBtn.selected = YES;
////        self.preBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        self.preBtn = titleBtn;
//    }
    
    
   self.preBtn.titleLabel.font = [UIFont systemFontOfSize:14];
   self.preBtn.selected = NO;
    
     
    titleBtn.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
//    self.preBtn.selected = NO;
    titleBtn.selected = YES;
    self.preBtn = titleBtn;
    
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


//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}


@end
