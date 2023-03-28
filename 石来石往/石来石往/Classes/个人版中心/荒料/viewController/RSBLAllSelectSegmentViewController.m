//
//  RSBLAllSelectSegmentViewController.m
//  石来石往
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBLAllSelectSegmentViewController.h"
#import "RSWarehouseModel.h"
#import "RSBLSpotShowAreaViewController.h"
#import "RSBLSpotShowCompleteViewController.h"
@interface RSBLAllSelectSegmentViewController ()<UIScrollViewDelegate,RSBLSpotShowAreaViewControllerDelegate,RSBLSpotShowCompleteViewControllerDelegate>

/** 保存上一次点击的按钮 */
@property (nonatomic,strong) UIButton *preBtn;

@property (nonatomic ,strong)RSReportFormMenuView * menu;

/**标题视图*/
@property (nonatomic,strong)UIView * titleView;

/**内容的视图*/
@property (nonatomic,strong)UIScrollView *contentScrollView;

/** 下滑线 */
@property (nonatomic,strong) UIView *lineView;


/** 保存所有的标题按钮 */
@property (nonatomic,strong) NSMutableArray *titleBtns;


@end

@implementation RSBLAllSelectSegmentViewController

- (NSMutableArray *)titleBtns{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

- (NSMutableDictionary *)BLSpotDict{
    if (!_BLSpotDict) {
        _BLSpotDict = [NSMutableDictionary dictionary];
    }
    return _BLSpotDict;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"现货展示区";
    UIButton * blockBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [blockBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [blockBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    blockBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:blockBtn];
    
    //self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    [blockBtn addTarget:self action:@selector(machiningAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    
    [self.BLSpotDict setObject:@"2019-01-01" forKey:@"dateFrom"];
    [self.BLSpotDict setObject:[self showCurrentTime] forKey:@"dateTo"];
    [self.BLSpotDict setObject:@"" forKey:@"mtlName"];
    [self.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"mtlId"];
    [self.BLSpotDict setObject:@"" forKey:@"blockNo"];
    [self.BLSpotDict setObject:@"" forKey:@"whsName"];
    [self.BLSpotDict setObject:@"" forKey:@"storageType"];
    [self.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
    
    [self.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"isFrozen"];
    [self.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
    [self.BLSpotDict setObject:[NSNumber numberWithInteger:0]  forKey:@"widthType"];
    [self.BLSpotDict setObject:@"" forKey:@"length"];
    [self.BLSpotDict setObject:@"" forKey:@"width"];
    [self.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"isPublic"];
    [self.BLSpotDict setObject:@"1" forKey:@"pageNum"];
    [self.BLSpotDict setObject:@"10" forKey:@"pageSize"];
    
    
    RSReportFormView * reportformView = [[RSReportFormView alloc]initWithFrame:CGRectMake(91, 0, [UIScreen mainScreen].bounds.size.width - 91, [UIScreen mainScreen].bounds.size.height)];
    reportformView.longIndex = 0;
    reportformView.TimeStatus = @"1";
    reportformView.withIndex = 0;
    reportformView.wareHouseIndex = 0;
    reportformView.frozenviewIndex = 0;
    reportformView.inSelect = @"1";
    reportformView.selectFunctionType = @"荒料入库明细表";
    RSWeakself
    __weak typeof(reportformView) weakReportformview = reportformView;
    reportformView.reportformSelect = ^(NSString * _Nonnull inSelect,NSString * _Nonnull beginTime, NSString * _Nonnull endTime, NSString * _Nonnull wuliaoTextView, NSString * _Nonnull blockTextView, NSString * _Nonnull longTypeView, NSInteger longIndex, NSString * _Nonnull longTextView, NSString * _Nonnull withTypeView, NSInteger withIndex, NSString * _Nonnull withTextView, NSString * _Nonnull luTypeView, NSString * _Nonnull wareHouseView, NSInteger wareHouseIndex, NSString * _Nonnull frozenView, NSInteger frozenviewIndex) {
        
        //[weakSelf.BLSpotDict setObject:[weakSelf showDisplayTheTime:beginTime] forKey:@"dateFrom"];
        
        //[weakSelf.BLSpotDict setObject:[weakSelf showDisplayTheTime:endTime] forKey:@"dateTo"];
        
        
        [weakSelf.BLSpotDict setObject:wuliaoTextView forKey:@"mtlName"];
        [weakSelf.BLSpotDict setObject:blockTextView forKey:@"blockNo"];
        
        weakReportformview.wareHouseIndex = wareHouseIndex;
        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
        NSMutableArray * warehouseArray = [db getAllContent:@"BL"];
        RSWarehouseModel * warehousemodel = [[RSWarehouseModel alloc]init];
        warehousemodel.code = @"";
        warehousemodel.createTime = @"";
        warehousemodel.name = @"请选出所在仓库";
        warehousemodel.updateTime = @"";
        warehousemodel.whstype = @"";
        warehousemodel.createUser = 0;
        warehousemodel.pwmsUserId = 0;
        warehousemodel.status = 0;
        warehousemodel.updateUser = 0;
        warehousemodel.WareHouseID = 0;
        [warehouseArray insertObject:warehousemodel atIndex:0];
        
        RSWarehouseModel * warehousemodel1 = warehouseArray[wareHouseIndex];
        if ([warehousemodel1.name isEqualToString:@"请选出所在仓库"]) {
            
            //请选出所在仓库
            [weakSelf.BLSpotDict setObject:@"" forKey:@"whsName"];
            [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
        }else{
            
            [weakSelf.BLSpotDict setObject:warehousemodel1.name forKey:@"whsName"];
            [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:warehousemodel1.WareHouseID] forKey:@"whsId"];
        }
        
        if ([luTypeView isEqualToString:@"请选出入库类型"]) {
            [weakSelf.BLSpotDict setObject:@"" forKey:@"storageType"];
        }else{
            NSString * str = [NSString string];
            if ([luTypeView isEqualToString:@"采购入库"]) {
                str = @"CGRK";
            }else if ([luTypeView isEqualToString:@"加工入库"]){
                str = @"JGRK";
            }else if ([luTypeView isEqualToString:@"盘盈入库"]){
                str = @"PYRK";
            }
            [weakSelf.BLSpotDict setObject:str forKey:@"storageType"];
        }
        //不需要
//        if ([frozenView isEqualToString:@"请选择"]) {
        
            [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"isFrozen"];
            
//        }else{
//            if ([frozenView isEqualToString:@"未冻结"]) {
//                [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"isFrozen"];
//
//            }else{
//                [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"isFrozen"];
//            }
//        }
        if ([longTypeView isEqualToString:@"请选择类型"]) {
            [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
        }else if ([longTypeView isEqualToString:@"大于"]){
            [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"lengthType"];
        }else if ([longTypeView isEqualToString:@"等于"]){
            [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:2] forKey:@"lengthType"];
        }else{
            [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:3] forKey:@"lengthType"];
        }
        if ([withTypeView isEqualToString:@"请选择类型"]) {
            [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"widthType"];
        }else if ([longTypeView isEqualToString:@"大于"]){
            [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"lengthType"];
        }else if ([longTypeView isEqualToString:@"等于"]){
            [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:2] forKey:@"lengthType"];
        }else{
            [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:3] forKey:@"lengthType"];
        }
        
        if ([longTextView isEqualToString:@""]) {
            [weakSelf.BLSpotDict setObject:@"" forKey:@"length"];
        }else{
            [weakSelf.BLSpotDict setObject:[NSDecimalNumber decimalNumberWithString:longTextView] forKey:@"length"];
        }
        if ([withTextView isEqualToString:@""]) {
            [weakSelf.BLSpotDict setObject:@"" forKey:@"width"];
        }else{
            [weakSelf.BLSpotDict setObject:[NSDecimalNumber decimalNumberWithString:withTextView] forKey:@"width"];
        }
        [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        
        for (int i = 0; i < self.childViewControllers.count; i++) {
            if (i == 0) {
                RSBLSpotShowAreaViewController * vc = (RSBLSpotShowAreaViewController *)weakSelf.childViewControllers[i];
                vc.BLSpotDict = weakSelf.BLSpotDict;
                vc.delegate = self;
                vc.type = @"DETAIL";
                [vc.selectArray removeAllObjects];
                [vc.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
                [vc.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"isPublic"];
                vc.isReSelect = false;
                vc.isAllSelect = false;
                vc.allBtn.selected = false;
                [vc reloadBLSpotNewData];
                
            }else{
                RSBLSpotShowCompleteViewController * vc = (RSBLSpotShowCompleteViewController *)weakSelf.childViewControllers[i];
                [vc.selectArray removeAllObjects];
                vc.BLSpotDict = weakSelf.BLSpotDict;
                vc.delegate = self;
                [vc.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
                [vc.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"isPublic"];
                vc.type = @"DETAIL";
                vc.isReSelect = false;
                vc.isAllSelect = false;
                vc.allBtn.selected = false;
                [vc reloadBLCompleteSpotNewData];
            }
        }
        [weakSelf.menu hidenWithAnimation];
    };
    RSReportFormMenuView *menu = [RSReportFormMenuView MenuViewWithDependencyView:self.view MenuView:reportformView isShowCoverView:YES];
    self.menu = menu;
    //添加标题view
    [self addBLShowTitleView];
    
    // 添加内容的scrollView
    [self addBLShowContentScrollView];
    
    // 添加所有的子控制器
    [self addAllChildViewControllers];
   

    // 默认点击下标为0的标题按钮
    [self titleBtnClick:self.titleBtns[0]];
    
    
    // 去掉控制器给scrollView添加的额外内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)addBLShowTitleView{
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
    }else{
        Y = 64;
    }
    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(0, Y, SCW, 38)];
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
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
    }else{
        Y = 64;
    }
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView = contentScrollView;
    //self.contentScrollview.hidden = YES;
    //self.contentScrollView.backgroundColor = [UIColor  redColor];
    contentScrollView.frame = CGRectMake(0,Y + 38 , SCW, SCH - Y - 38);
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
    lineView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    // 下滑线高度
    CGFloat lineViewH = 2;
    CGFloat y = self.titleView.yj_height - lineViewH;
    lineView.yj_height = lineViewH;
    lineView.yj_y = y;
    // 设置下划线的宽度比文本内容宽度大10
    [titleBtn.titleLabel sizeToFit];
    lineView.yj_width = titleBtn.titleLabel.yj_width + 10;
    lineView.yj_centerX = titleBtn.yj_centerX;
    // 添加到titleView里
    [self.titleView addSubview:lineView];
}




#pragma mark - 添加所有的子控制器
- (void)addAllChildViewControllers
{
    

    // 未展示
    RSBLSpotShowAreaViewController *DramaVc = [[RSBLSpotShowAreaViewController alloc] init];
    DramaVc.selectType = self.selectType;
    DramaVc.title = self.title;
    DramaVc.usermodel = self.usermodel;
    DramaVc.selectFunctionType = self.title;
    DramaVc.BLSpotDict = self.BLSpotDict;
    DramaVc.delegate = self;
    DramaVc.type = @"DETAIL";
    [self addChildViewController:DramaVc];
    
    
    //已展示
    RSBLSpotShowCompleteViewController *recommendVc = [[RSBLSpotShowCompleteViewController alloc] init];
    recommendVc.selectType = self.selectType;
    recommendVc.title = self.title;
    recommendVc.usermodel = self.usermodel;
    recommendVc.selectFunctionType = self.title;
    recommendVc.BLSpotDict = self.BLSpotDict;
    recommendVc.delegate = self;
    recommendVc.type = @"DETAIL";
    [self addChildViewController:recommendVc];
    
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
    NSArray *titles = @[@"未展示",@"已展示"];
    // 按钮宽度
    CGFloat btnW = SCW / titles.count - 0.5;
    CGFloat btnH = self.titleView.yj_height;
    for (int i = 0; i < titles.count; i++) {
        // 创建标题按钮
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.tag = i;
        titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        // 设置文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        // 设置选中按钮的文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateSelected];
        
        [self.titleView addSubview:titleBtn];
        
        if (i == 0) {
            UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleBtn.frame), 10, 1, 21)];
            midView.backgroundColor = [UIColor colorWithHexColorStr:@"#979797"];
            [self.titleView addSubview:midView];
        }
        
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
    self.preBtn.selected = NO;
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




//筛选
- (void)machiningAction:(UIButton *)blockBtn{
    [self.menu show];
}


- (void)showBlockNoNewData{
    //这边要做的就是
    for (int i = 0; i < self.childViewControllers.count; i++) {
        if (i == 1) {
            RSBLSpotShowCompleteViewController * vc = (RSBLSpotShowCompleteViewController *)self.childViewControllers[i];
            [vc.selectArray removeAllObjects];
            vc.BLSpotDict = self.BLSpotDict;
            vc.delegate = self;
            vc.type = @"DETAIL";
            [vc.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
            [vc.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"isPublic"];
            vc.isReSelect = false;
            vc.isAllSelect = false;
            vc.allBtn.selected = false;
            [vc reloadBLCompleteSpotNewData];
        }
    }
}


- (void)cancelshowBlockNoNewData{
    for (int i = 0; i < self.childViewControllers.count; i++) {
        if (i == 0) {
            RSBLSpotShowAreaViewController * vc = (RSBLSpotShowAreaViewController *)self.childViewControllers[i];
            vc.BLSpotDict = self.BLSpotDict;
            vc.delegate = self;
            vc.type = @"DETAIL";
            [vc.selectArray removeAllObjects];
            [vc.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
            [vc.BLSpotDict setObject:[NSNumber numberWithInteger:0] forKey:@"isPublic"];
            vc.isReSelect = false;
            vc.isAllSelect = false;
            vc.allBtn.selected = false;
            [vc reloadBLSpotNewData];
        }
    }
}





- (NSString *)showCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

- (NSString *)showDisplayTheTime:(NSString *)time{
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [dateFormatter dateFromString:time];
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    return currentDateString;
}


@end
