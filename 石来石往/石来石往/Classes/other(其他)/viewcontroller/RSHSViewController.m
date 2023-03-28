//
//  RSHSViewController.m
//  石来石往
//
//  Created by mac on 17/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSHSViewController.h"
#import "UIView+Frame.h"
/**搜索的页面*/
#import "RSHistoryViewController.h"
#import "NSString+RSErrerResutl.h"
#import "RSLoginViewController.h"
#import "RSWarehouseFirstViewController.h"
#import "RSWarehouseSecondViewController.h"



@interface RSHSViewController ()<UIScrollViewDelegate>
{
    /**用来判断是做月排行还是周排行*/
    //NSInteger _choiceStyle;
    
    //UIImageView *_imageview;
    /**导航栏的视图*/
//    UIView *_navigationview;
//    //荒料按键
//    UIButton * _huangliaoBtn;
//    //大板按键
//    UIButton * _dabanBtn;
//    //荒料下划线
//    UIView * _huangliaoView;
//    //大板下划线
//    UIView * _dabanView;
}

/**页数*/
//@property (nonatomic,assign)NSInteger pageNum;
//
//
//@property (nonatomic,strong)UITableView *tableview;
//
///**获取网络数据的参数*/
//@property (nonatomic,assign)BOOL isRefresh;
//
//
///**获取网络上面的数据*/
//@property (nonatomic,strong)NSMutableArray * rankArray;
//
///**临时保存网上的数据*/
//@property (nonatomic,strong)NSMutableArray *tempRankArray;
//
//
//
//@property (nonatomic,strong)NSMutableArray * marketArray;

@property (nonatomic,strong)UIView * searchView;

@property (nonatomic,strong)UIScrollView *contentScrollview;

@property (nonatomic,strong)UIView *titleview;
/** 保存所有的标题按钮 */
@property (nonatomic,strong) NSMutableArray *titleBtns;
/** 下滑线 */
@property (nonatomic,strong) UIView *lineView;
/** 保存上一次点击的按钮 */
@property (nonatomic,strong) UIButton *preBtn;

@end

@implementation RSHSViewController

- (NSMutableArray *)titleBtns{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

- (UIView *)searchView{
    if (!_searchView) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 166)];
        _searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UIImageView * searchImageLogoView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 54, 275, 34)];
        searchImageLogoView.image = [UIImage imageNamed:@"现货logo"];
        searchImageLogoView.contentMode = UIViewContentModeScaleAspectFill;
        searchImageLogoView.clipsToBounds = YES;
        [_searchView addSubview:searchImageLogoView];
        
        
        //搜索按键
        UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(searchImageLogoView.frame) + 25, SCW - 24, 43)];
        [searchBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F8F8F8"]];
        searchBtn.layer.cornerRadius = 22;
        searchBtn.layer.masksToBounds = YES;
        [_searchView addSubview:searchBtn];
        [searchBtn addTarget:self action:@selector(jumpSearchViewController:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //搜索图标
        UIImageView * searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(23, 15, 14, 14)];
        searchImageView.image = [UIImage imageNamed:@"iconfont-fangdajing 拷贝"];
        searchImageView.contentMode = UIViewContentModeScaleAspectFill;
        searchImageView.clipsToBounds = YES;
        [searchBtn addSubview:searchImageView];
        
        //文字
        UILabel * searchLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(searchImageView.frame) + 8, 0, searchBtn.yj_width - CGRectGetMaxX(searchImageView.frame) + 8, 43)];
        searchLabel.text = @"请输入石种名称、荒料号";
        searchLabel.textColor = [UIColor colorWithHexColorStr:@"#D5D5D5"];
        searchLabel.textAlignment = NSTextAlignmentLeft;
        searchLabel.font = [UIFont systemFontOfSize:14];
        [searchBtn addSubview:searchLabel];
        
        
    }
    return _searchView;
}




//
//- (NSMutableArray *)tempRankArray{
//    if (_tempRankArray == nil) {
//        _tempRankArray = [NSMutableArray array];
//    }
//    return _tempRankArray;
//}
//
//- (NSMutableArray *)marketArray{
//    if (!_marketArray) {
//       _marketArray = [NSMutableArray array];
//    }
//    return _marketArray;
//}
//
//
//
//- (NSMutableArray *)rankArray{
//    if (_rankArray == nil) {
//        _rankArray = [NSMutableArray array];
//    }
//    return _rankArray;
//
//
//}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changMarketHSNewData) name:@"changMarket" object:nil];
//}

//#pragma mark -- 退出登录
//- (void)quitLogin{
//    //self.isOrdinary = false;
//    self.isLogin = true;
//    self.isOwner = false;
//    self.userModel = nil;
//    [self.fansBtn setTitle:@"粉丝 0" forState:UIControlStateNormal];
//    [self.attentionBtn setTitle:@"关注 0" forState:UIControlStateNormal];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user removeObjectForKey:@"user"];
//    [user removeObjectForKey:@"VERIFYKEY"];
//    [user synchronize];
//    [self.nameBtn setTitle:@"点击登录" forState:UIControlStateNormal];
//
//    self.nameBtn.enabled = YES;
//    self.signOutview.hidden = YES;
//    self.namePhone.enabled = YES;
//    [self.namePhone setTitle:@"" forState:UIControlStateNormal];
//    //self.topBtn.enabled = NO;
//    self.iconImage.image = [UIImage imageNamed:@"求真像"];
//    [self loadADData];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (@available(iOS 11.0, *)) {
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    //self.title = self.titleStr;
    //初始化
    //self.searchURL = URL_HUANGLIANG_SEARCH;
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:self.searchView];
    [self setupTitleView];
    //[self loadNewData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self addContentScrollView];
        // 添加所有的子控制器
          [self addAllChildViewControllers];
        // 5.默认选中下标为0的按钮
          [self titleBtnClick:self.titleBtns[0]];
    });
}
#pragma mark - 标题点击事件
- (void)titleBtnClick:(UIButton *)titleBtn
{
    titleBtn.selected = YES;
    // 1.标题按钮点击三步曲
    UIFont * font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    self.preBtn.titleLabel.font = font;
    self.preBtn.selected = NO;
    UIFont * font1 = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    titleBtn.titleLabel.font = font1;
    self.preBtn = titleBtn;
    NSInteger tag = titleBtn.tag;
    // 2.处理下滑线的移动
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.yj_width = 22;
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
    vc.view.frame = CGRectMake(tag * SCW, 0, SCW, self.contentScrollview.yj_height);
    [self.contentScrollview addSubview:vc.view];
}


#pragma mark - 搭建标题栏
- (void)setupTitleView
{
    // 创建标题栏
    UIView *titleView = [[UIView alloc] init];
    self.titleview = titleView;
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.frame = CGRectMake(0, CGRectGetMaxY(self.searchView.frame), SCW, 40);
    [self.view addSubview:titleView];
    
    // 添加所有的标题按钮
    [self addAllTitleBtns];
    
    // 添加下滑线
    [self setupUnderLineView];
}





#pragma mark - 添加所有的标题按钮
- (void)addAllTitleBtns
{
    // 所有的标题
    NSArray *titles = @[@"市场",@"荒料出库排行榜",@"大板出库排行榜"];
    // 按钮宽度
    CGFloat btnW = SCW / titles.count;
    CGFloat btnH = self.titleview.yj_height;
    for (int i = 0; i < titles.count; i++) {
        // 创建标题按钮
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.tag = i;
        if (i == 0) {
            btnW = 60;
            titleBtn.frame = CGRectMake(0, 0, btnW, btnH);
        }else if(i == 1){
            btnW = 130;
            titleBtn.frame = CGRectMake(60, 0, btnW, btnH);
        }else{
            btnW = 130;
            titleBtn.frame = CGRectMake(190, 0, btnW, btnH);
        }
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        // 设置文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        // 设置选中按钮的文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateSelected];
        
        [self.titleview addSubview:titleBtn];
        // 保存标题按钮
        [self.titleBtns addObject:titleBtn];
        // 添加点击事件
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
}

#pragma mark - 添加下滑线
- (void)setupUnderLineView
{
    // 获取下标为0的标题按钮
    UIButton *titleBtn = self.titleBtns[0];
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    lineView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    // 下滑线高度
    CGFloat lineViewH = 3;
    CGFloat y = self.titleview.yj_height - lineViewH;
    lineView.yj_height = lineViewH;
    lineView.yj_y = y;
    // 设置下划线的宽度比文本内容宽度大10
    [titleBtn.titleLabel sizeToFit];
    lineView.yj_width = 22;
    lineView.yj_centerX = titleBtn.yj_centerX;
    // 添加到titleView里
    [self.titleview addSubview:lineView];
}


#pragma mark - 添加所有的子控制器
- (void)addAllChildViewControllers
{
    // 市场
    RSWarehouseFirstViewController *NoVc = [[RSWarehouseFirstViewController alloc] init];
    NoVc.userModel = [UserManger getUserObject];
    [self addChildViewController:NoVc];
    //荒料出库排行榜
    RSWarehouseSecondViewController * huangliaoVc = [[RSWarehouseSecondViewController alloc]init];
    huangliaoVc.userModel = [UserManger getUserObject];
    huangliaoVc.WLTYPE = @"huangliao";
    [self addChildViewController:huangliaoVc];
    //大板出库排行榜
    RSWarehouseSecondViewController * dabanVc = [[RSWarehouseSecondViewController alloc]init];
    dabanVc.userModel = [UserManger getUserObject];
    dabanVc.WLTYPE = @"daban";
    [self addChildViewController:dabanVc];
    
    NSInteger count = self.childViewControllers.count;
    // 给contentScrollView添加子控制器的view
    for (int i = 0 ; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * SCW, 0, SCW, self.contentScrollview.yj_height);
        [self.contentScrollview addSubview:vc.view];
    }
    // 设置内容scrollView的滚动范围
    self.contentScrollview.contentSize = CGSizeMake(count * self.contentScrollview.yj_width, 0);
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
    // NSLog(@"ratio = %0.1f",ratio);
    // 设置下划线的centerX
    self.lineView.yj_centerX = self.preBtn.yj_centerX + ratio * self.preBtn.yj_width;
    //+ ratio * self.preBtn.yj_width;
//     self.contentScrollview.contentOffset = CGPointMake(self.preBtn.tag * scrollView.yj_width, 0);
}

- (void)addContentScrollView
{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollview = contentScrollView;
    //    self.contentScrollView.backgroundColor = [UIColor  redColor];
    contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.titleview.frame), SCW, SCH -  CGRectGetMaxY(self.titleview.frame));
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

//- (void)showCarouselView:(NSMutableArray *)markArray{
//    [self addCustomTableview:markArray];
//    [self loadNewData];
//}
//
//
//
//static NSString *hsSectionHeader = @"hssectionheader";
//static NSString *hsCell = @"hscell";
//- (void)addCustomTableview:(NSMutableArray *)markArray{
//    CGFloat bottomH = 0.0;
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = -44;
//        bottomH = 34;
//    }else{
//        Y = -20;
//        bottomH = 0.0;
//    }
//    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Y, SCW, SCH) style:UITableViewStylePlain];
//    [self.view addSubview:self.tableview];
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    UIView * headerview = [[UIView alloc]init];
//    headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#EEF3FB"];
//    //这边是背景图片
//    UIButton * backgroudBtn = [[UIButton alloc]init];
//    [backgroudBtn setImage:[UIImage imageNamed:@"背景"] forState:UIControlStateNormal];
//    [headerview addSubview:backgroudBtn];
//    //这边添加一个标题
//    UILabel * titleLabel = [[UILabel alloc]init];
//    titleLabel.text = @"现货查询";
//    titleLabel.font = [UIFont systemFontOfSize:17];
//    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#000000"];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [backgroudBtn addSubview:titleLabel];
//
//    UIView * view = [[UIView alloc]init];
//    view.userInteractionEnabled = YES;
//    view.backgroundColor = [UIColor whiteColor];
//    view.layer.cornerRadius = 4;
//    view.layer.masksToBounds = YES;
//    view.frame = CGRectMake(18, 79, SCW - 36, 40);
//    [backgroudBtn addSubview:view];
//
//    UIImageView * imageview = [[UIImageView alloc]init];
//    imageview.image = [UIImage imageNamed:@"iconfont-fangdajing"];
//    imageview.frame = CGRectMake(12, 10, 20, 20);
//    [view addSubview:imageview];
//
//    RSActionButton * btn = [[RSActionButton alloc]init];
//    [btn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:15];
//    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [btn setBackgroundColor:[UIColor whiteColor]];
//    [btn setTitle:@"输入石种名称" forState:UIControlStateNormal];
//    [view addSubview:btn];
//    btn.frame = CGRectMake(CGRectGetMaxX(imageview.frame) + 2, 0, view.frame.size.width - CGRectGetMaxX(imageview.frame), 40);
//    [btn addTarget:self action:@selector(jumpSearchViewController:) forControlEvents:UIControlEventTouchUpInside];
//    //这边是设置显示的内容
//    UIView * showView =[[UIView alloc]init];
//    showView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEF3FB"];
//    [headerview addSubview:showView];
//
//    CGFloat hsmarketH = 180;
//    CGFloat  hsmarketY = 0.0f;
//    for (int i = 0; i < markArray.count; i++) {
//        NSInteger row = i / ECA;
//        hsmarketY =  row * (margin + hsmarketH) + margin;
//        RSMarkModel * markmodel = markArray[i];
//        RSHSMarketView * hsmarketView = [[RSHSMarketView alloc]initWithFrame:CGRectMake(12, hsmarketY, SCW - 24, hsmarketH)];
//        [showView addSubview:hsmarketView];
//        if (i == 1) {
//            hsmarketView.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#4CAEF5"];
//            hsmarketView.shadowView.backgroundColor = [UIColor colorWithHexColorStr:@"#4CAEF5"];
//            hsmarketView.shadowView.alpha = 0.1;
//        }else{
//            hsmarketView.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#5C8EFB"];
//            hsmarketView.shadowView.backgroundColor = [UIColor colorWithHexColorStr:@"#5C8EFB"];
//            hsmarketView.shadowView.alpha = 0.1;
//        }
//        NSMutableAttributedString * mutableAttriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",markmodel.erpName]];
//        NSShadow * shadow = [[NSShadow alloc] init];
//        shadow.shadowColor = [UIColor colorWithHexColorStr:@"#4965B7"];
//        shadow.shadowBlurRadius = 2.0;//模糊度
//        shadow.shadowOffset = CGSizeMake(1.0, 3.0);
//        NSDictionary * attris = @{NSShadowAttributeName:shadow,NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#ffffff"]};
//        [mutableAttriStr setAttributes:attris range:NSMakeRange(0,mutableAttriStr.length)];
//        hsmarketView.titleLabel.attributedText = mutableAttriStr;
//        hsmarketView.huangInputLabel.text = markmodel.blockTotalMessage;
//        hsmarketView.dabanInputLabel.text = markmodel.plateTotalMessage;
//        hsmarketView.typeInputLabel.text = markmodel.stoneTypeNum;
//    }
//
//    backgroudBtn.sd_layout
//    .leftSpaceToView(headerview, 0)
//    .rightSpaceToView(headerview, 0)
//    .topSpaceToView(headerview, 0)
//    .heightIs(125);
//
//    titleLabel.sd_layout
//    .topSpaceToView(backgroudBtn, 44)
//    .leftSpaceToView(backgroudBtn, 0)
//    .rightSpaceToView(backgroudBtn, 0)
//    .heightIs(16);
//
//    showView.sd_layout
//    .leftSpaceToView(headerview, 0)
//    .rightSpaceToView(headerview, 0)
//    .topSpaceToView(backgroudBtn, 0)
//    .heightIs(markArray.count * hsmarketH +  (markArray.count + 1) * margin);
//    [headerview setupAutoHeightWithBottomView:showView bottomMargin:0];
//    [headerview layoutSubviews];
//   // self.tableview.tableHeaderView = headerview;
//    //向下刷新
//    RSWeakself
//    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf loadNewData];
//    }];
//    //向上刷新
//    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
//          [weakSelf loadMoreNewData];
//    }];
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf loadNewData];
//    }];
//    self.tableview.offset = 100;
//}
//
#pragma mark -- 跳转到搜索的页面
- (void)jumpSearchViewController:(UIButton *)btn{
    [UserManger checkLogin:self successBlock:^{
        RSHistoryViewController * historyVc = [[RSHistoryViewController alloc]init];
//        historyVc.hidesBottomBarWhenPushed = YES;
        historyVc.userModel = [UserManger getUserObject];
        [self.navigationController pushViewController:historyVc animated:YES];
    }];
}
//
//#pragma mark -- 海西石种排名(向下刷新)
//- (void)loadNewData{
//    self.isRefresh = true;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    if (verifyKey.length < 1) {
//        verifyKey = @"";
//    }
//    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
//    [phoneDict setObject:[NSString stringWithFormat:@"%@",self.WLTYPE] forKey:@"wltype"];
//    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"page_num"];
//    [phoneDict setObject:[NSString stringWithFormat:@"20"] forKey:@"item_num"];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    RSWeakself
//    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_HEADER_STONE_RANKING withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue] ;
//            NSMutableArray *array = nil;
//            if (Result) {
//                array = json[@"Data"];
//                if (array.count == 0) {
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD showInfoWithStatus:@"月排行没有数据"];
//                    });
//                }else{
//                    [weakSelf.rankArray removeAllObjects];
//                    [weakSelf.tempRankArray removeAllObjects];
//                    if (weakSelf.rankArray.count < 20) {
//                        for (int i = 0; i < array.count; i++) {
//                            RSRankModel *rankModel = [[RSRankModel alloc]init];
//                            rankModel.VAQty = [[[array objectAtIndex:i] objectForKey:@"VAQty"] floatValue];
//                            rankModel.deaCode = [[array objectAtIndex:i] objectForKey:@"deaCode"];
//                            rankModel.deaName = [[array objectAtIndex:i] objectForKey:@"deaName"];
//                            rankModel.monthRank = [[[array objectAtIndex:i] objectForKey:@"monthRank"] integerValue];
//                            rankModel.mtlCode = [[array objectAtIndex:i] objectForKey:@"mtlCode"];
//                            rankModel.mtlName = [[array objectAtIndex:i] objectForKey:@"mtlName"];
//                            rankModel.mtlType = [[[array objectAtIndex:i] objectForKey:@"mtlType"] integerValue];
//                            rankModel.period = [[array objectAtIndex:i] objectForKey:@"period"];
//                            [weakSelf.rankArray addObject:rankModel];
//                            [weakSelf.tempRankArray addObject:rankModel];
//                        }
//                    }else{
//                        [weakSelf.rankArray removeAllObjects];
//                        [weakSelf.rankArray addObjectsFromArray:self.tempRankArray];
//                    }
//                }
//                    weakSelf.pageNum = 2;
//                    [weakSelf.tableview reloadData];
//                    [weakSelf.tableview.mj_header endRefreshing];
//                    [SVProgressHUD dismiss];
//            }else{
//                [SVProgressHUD dismiss];
//                [weakSelf.tableview.mj_header endRefreshing];
//            }
//        }else{
//            [SVProgressHUD dismiss];
//            [weakSelf.tableview.mj_header endRefreshing];
//        }
//    }];
//}
//
//
//
//
//#pragma mark -- 海西石种排名(向上刷新)
//- (void)loadMoreNewData{
//    [SVProgressHUD showWithStatus:@"加载更多数据"];
//    self.isRefresh = false;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    if (verifyKey.length < 1) {
//        verifyKey = @"";
//    }
//    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
//    [phoneDict setObject:[NSString stringWithFormat:@"%@",self.WLTYPE] forKey:@"wltype"];
//    [phoneDict setObject:[NSString stringWithFormat:@"%ld",(long)self.pageNum] forKey:@"page_num"];
//    [phoneDict setObject:[NSString stringWithFormat:@"20"] forKey:@"item_num"];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    RSWeakself
//    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_HEADER_STONE_RANKING withParameters:parameters withBlock:^(id json, BOOL success){
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue] ;
//            if (Result) {
//                NSMutableArray *array = nil;
//                array = [RSRankModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
//                    [weakSelf.rankArray addObjectsFromArray:array];
//                    weakSelf.pageNum++;
//                    [weakSelf.tableview.mj_footer endRefreshing];
//                    [weakSelf.tableview reloadData];
//                    [SVProgressHUD dismiss];
//            }else{
//                [SVProgressHUD dismiss];
//                [weakSelf.tableview.mj_footer endRefreshing];
//            }
//        }
//    }];
//}
//
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    RSHSSectionView *hssectionview = [[RSHSSectionView alloc]initWithReuseIdentifier:hsSectionHeader];
//    hssectionview.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
//    UIButton * huangliaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [huangliaoBtn setTitle:@"荒料出库排行榜" forState:UIControlStateNormal];
//    huangliaoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [huangliaoBtn addTarget:self action:@selector(huangliaoAction:) forControlEvents:UIControlEventTouchUpInside];
//    [hssectionview.topview addSubview:huangliaoBtn];
//    _huangliaoBtn = huangliaoBtn;
//    UIButton * dabanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [dabanBtn setTitle:@"大板出库排行榜" forState:UIControlStateNormal];
//    dabanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [dabanBtn addTarget:self action:@selector(dabanBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [hssectionview.topview addSubview:dabanBtn];
//    _dabanBtn = dabanBtn;
//    UIView * huangliaoView = [[UIView alloc]init];
//    [hssectionview.topview addSubview:huangliaoView];
//    _huangliaoView = huangliaoView;
//    UIView * dabanView = [[UIView alloc]init];
//    [hssectionview.topview addSubview:dabanView];
//    _dabanView = dabanView;
//    huangliaoBtn.sd_layout
//    .leftSpaceToView(hssectionview.topview, 0)
//    .topSpaceToView(hssectionview.topview, 0)
//    .widthIs(SCW/2)
//    .bottomSpaceToView(hssectionview.topview, 1);
//    huangliaoView.sd_layout
//    .leftSpaceToView(hssectionview.topview, 0)
//    .topSpaceToView(huangliaoBtn, 0)
//    .widthIs(SCW/2)
//    .heightIs(1);
//    dabanBtn.sd_layout
//    .leftSpaceToView(huangliaoBtn, 0)
//    .rightSpaceToView(hssectionview.topview, 0)
//    .topSpaceToView(hssectionview.topview, 0)
//    .bottomSpaceToView(hssectionview.topview, 1);
//    dabanView.sd_layout
//    .leftSpaceToView(huangliaoView, 0)
//    .rightSpaceToView(hssectionview.topview, 0)
//    .topSpaceToView(dabanBtn, 0)
//    .heightIs(1);
//    if ([self.WLTYPE isEqualToString:@"huangliao"]) {
//        hssectionview.volumeLabel.text = [NSString stringWithFormat:@"体积"];
//        _dabanView.hidden = YES;
//        _huangliaoView.hidden = NO;
//        [_huangliaoBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//        _huangliaoView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
//        [_dabanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//        _dabanView.backgroundColor = [UIColor colorWithHexColorStr:@"#333333"];
//    }else{
//        hssectionview.volumeLabel.text = [NSString stringWithFormat:@"面积"];
//        _dabanView.hidden = NO;
//        _huangliaoView.hidden = YES;
//        [_dabanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//        _dabanView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
//        _huangliaoView.backgroundColor = [UIColor colorWithHexColorStr:@"#333333"];
//        [_huangliaoBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//    }
//    return hssectionview;
//}
//
//- (void)huangliaoAction:(UIButton *)huangliaoBtn{
//    self.WLTYPE = @"huangliao";
//    _huangliaoView.hidden = NO;
//    [_huangliaoBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//    _huangliaoView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
//    [_dabanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//    _dabanView.backgroundColor = [UIColor colorWithHexColorStr:@"#333333"];
//    _dabanView.hidden = YES;
//    [self loadNewData];
//}
//
//- (void)dabanBtnAction:(UIButton *)dabanBtn{
//    self.WLTYPE = @"daban";
//    _huangliaoView.hidden = YES;
//    [_dabanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//    _dabanView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
//    _huangliaoView.backgroundColor = [UIColor colorWithHexColorStr:@"#333333"];
//    [_huangliaoBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//    _dabanView.hidden = NO;
//    [self loadNewData];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 82;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 35;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.rankArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    RSHSCell *cell = [tableView dequeueReusableCellWithIdentifier:hsCell];
//    if (!cell) {
//        cell = [[RSHSCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:hsCell
//                ];
//    }
//        RSRankModel *rankModel = self.rankArray[indexPath.row];
//        cell.rankModel = rankModel;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
//    if ( VERIFYKEY.length < 1) {
//        self.hidesBottomBarWhenPushed = YES;
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//        [self.navigationController pushViewController:loginVc animated:YES];
//        self.hidesBottomBarWhenPushed = NO;
//    }else{
//        self.hidesBottomBarWhenPushed = YES;
//        RSRankModel * rankmodel = self.rankArray[indexPath.row];
//        RSProductDetailViewController * productVc = [[RSProductDetailViewController alloc]init];
//        productVc.productNameLabel = rankmodel.mtlName;
//        productVc.WLTYPE = self.WLTYPE;
//        productVc.userModel = self.userModel;
//        [self.navigationController pushViewController:productVc animated:YES];
//        self.hidesBottomBarWhenPushed = NO;
//    }
//}
//#pragma mark -- 返回首页控制器
//- (void)backViewControler{
//    [self.navigationController popViewControllerAnimated:YES];
//}


//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"isNewData" object:nil];
//}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
