//
//  FloatViewController.m
//  TableViewFloat
//
//  Created by 李雪阳 on 2018/8/28.
//  Copyright © 2018年 singularity. All rights reserved.
//

#import "FloatViewController.h"
#import "WMPageController.h"
#import "ParentClassScrollViewController.h"
#import "MainTouchTableTableView.h"
#import "FirstTableViewController.h"
#import "SecondTableViewController.h"
#import "ThirdTableViewController.h"

//#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
//#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
static CGFloat const headViewHeight = 190;
@interface FloatViewController ()<UITableViewDelegate,UITableViewDataSource,scrollDelegate,WMPageControllerDelegate>

@property(nonatomic ,strong)MainTouchTableTableView * mainTableView;
@property(nonatomic,strong) UIScrollView * parentScrollView;

@end

@implementation FloatViewController

-(MainTouchTableTableView *)mainTableView
{
    if (_mainTableView == nil)
    {
        
        CGFloat Y = 0.0;
        if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
            
            Y = 88;
        }else{
            Y = 64;
        }
        
        _mainTableView= [[MainTouchTableTableView alloc]initWithFrame:CGRectMake(0,Y,SCW,SCH - Y)];
        _mainTableView.delegate=self;
        _mainTableView.dataSource=self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.contentInset = UIEdgeInsetsMake(headViewHeight,0, 0, 0);
        _mainTableView.backgroundColor = [UIColor clearColor];
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"跟单详情";

    [self.view addSubview:self.mainTableView];
    
     [self setTable];
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}



#pragma mark clickEvent
- (void)setTable{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, -headViewHeight, SCREEN_WIDTH, headViewHeight)];
    headView.backgroundColor = [UIColor colorFromHexString:@"#F3F3F3"];
//    FloatHeadView *headView=[FloatHeadView new];
//    headView.goGathering = ^{
//    };
    
    
    //内容信息
    UIView * exceptionView = [[UIView alloc]init];
    exceptionView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [headView addSubview:exceptionView];
    
    
    exceptionView.sd_layout
    .leftSpaceToView(headView, 0)
    .rightSpaceToView(headView, 0)
    .topSpaceToView(headView, 0)
    .heightIs(180);
    
    
   // exceptionView.layer.cornerRadius = 3;
    
    //物料号
    UILabel * productNameLabel = [[UILabel alloc]init];
    productNameLabel.text = [NSString stringWithFormat:@"%@",self.machiningoutmodel.blockNo];
    productNameLabel.font = [UIFont systemFontOfSize:15];
    productNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    productNameLabel.textAlignment = NSTextAlignmentLeft;
    [exceptionView addSubview:productNameLabel];
    //_productNameLabel = productNameLabel;
    
   
    
    //分割线
//    UIView * midView = [[UIView alloc]init];
//    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
//    [exceptionView addSubview:midView];
//
    
    
    //物料名称
    UILabel * productLabel = [[UILabel alloc]init];
    productLabel.text = @"物料名称";
    productLabel.font = [UIFont systemFontOfSize:15];
    productLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    productLabel.textAlignment = NSTextAlignmentLeft;
    [exceptionView addSubview:productLabel];
    
    
    UILabel * productDetailLabel = [[UILabel alloc]init];
    productDetailLabel.text = [NSString stringWithFormat:@"%@",self.machiningoutmodel.mtlName];
    productDetailLabel.font = [UIFont systemFontOfSize:15];
    productDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    productDetailLabel.textAlignment = NSTextAlignmentRight;
    [exceptionView addSubview:productDetailLabel];
    //_productDetailLabel = productDetailLabel;
    
    //物料类型
    UILabel * productTypeLabel = [[UILabel alloc]init];
    productTypeLabel.text = @"物料类型";
    productTypeLabel.font = [UIFont systemFontOfSize:15];
    productTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    productTypeLabel.textAlignment = NSTextAlignmentLeft;
    [exceptionView addSubview:productTypeLabel];
    
    
    UILabel * productTypeDetailLabel = [[UILabel alloc]init];
    productTypeDetailLabel.text = [NSString stringWithFormat:@"%@",self.machiningoutmodel.mtltypeName];
    productTypeDetailLabel.font = [UIFont systemFontOfSize:15];
    productTypeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    productTypeDetailLabel.textAlignment = NSTextAlignmentRight;
    [exceptionView addSubview:productTypeDetailLabel];
   // _productTypeDetailLabel = productTypeDetailLabel;
    
    
    //长宽高
    UILabel * productShapeLabel = [[UILabel alloc]init];
    productShapeLabel.text = @"长宽高(cm)";
    productShapeLabel.font = [UIFont systemFontOfSize:15];
    productShapeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    productShapeLabel.textAlignment = NSTextAlignmentLeft;
    [exceptionView addSubview:productShapeLabel];
    
    
    UILabel * productShapeDetailLabel = [[UILabel alloc]init];
   // productShapeDetailLabel.text = @"0.1 | 3.3 | 2.8";
    
    productShapeDetailLabel.text = [NSString stringWithFormat:@"%0.1lf | %0.1lf | %0.2lf",[self.machiningoutmodel.length floatValue],[self.machiningoutmodel.width floatValue],[self.machiningoutmodel.height floatValue]];
    
    productShapeDetailLabel.font = [UIFont systemFontOfSize:15];
    productShapeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    productShapeDetailLabel.textAlignment = NSTextAlignmentRight;
    [exceptionView addSubview:productShapeDetailLabel];
    //_productShapeDetailLabel = productShapeDetailLabel;
    
    //体积
    UILabel * productAreaLabel = [[UILabel alloc]init];
    productAreaLabel.text = @"体积(m³)";
    productAreaLabel.font = [UIFont systemFontOfSize:15];
    productAreaLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    productAreaLabel.textAlignment = NSTextAlignmentLeft;
    [exceptionView addSubview:productAreaLabel];
    
    
    
    UILabel * productAreaDetailLabel = [[UILabel alloc]init];
    productAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[self.machiningoutmodel.volume floatValue]];
    productAreaDetailLabel.font = [UIFont systemFontOfSize:15];
    productAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    productAreaDetailLabel.textAlignment = NSTextAlignmentRight;
    [exceptionView addSubview:productAreaDetailLabel];
    //_productAreaDetailLabel = productAreaDetailLabel;
    
    //重量
    UILabel * productWightLabel = [[UILabel alloc]init];
    productWightLabel.text = @"重量(吨)";
    productWightLabel.font = [UIFont systemFontOfSize:15];
    productWightLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    productWightLabel.textAlignment = NSTextAlignmentLeft;
    [exceptionView addSubview:productWightLabel];
    
    
    
    UILabel * productWightDetailLabel = [[UILabel alloc]init];
    productWightDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[self.machiningoutmodel.weight floatValue]];
    productWightDetailLabel.font = [UIFont systemFontOfSize:15];
    productWightDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    productWightDetailLabel.textAlignment = NSTextAlignmentRight;
    [exceptionView addSubview:productWightDetailLabel];
    //_productWightDetailLabel = productWightDetailLabel;
    
    productNameLabel.sd_layout
    .leftSpaceToView(exceptionView, 17)
    .topSpaceToView(exceptionView, 15)
    .heightIs(21)
    .widthRatioToView(exceptionView, 0.5);
    
    
    productLabel.sd_layout
    .leftSpaceToView(exceptionView, 17)
    .topSpaceToView(productNameLabel, 8)
    .widthIs(62)
    .heightIs(21);
    
    productDetailLabel.sd_layout
    .rightSpaceToView(exceptionView, 15)
    .topEqualToView(productLabel)
    .bottomEqualToView(productLabel)
    .widthRatioToView(exceptionView, 0.5);
    
    
    
    
    productTypeLabel.sd_layout
    .leftEqualToView(productLabel)
    .rightEqualToView(productLabel)
    .topSpaceToView(productLabel, 3)
    .heightIs(21);
    
    
    productTypeDetailLabel.sd_layout
    .rightEqualToView(productDetailLabel)
    .topEqualToView(productTypeLabel)
    .bottomEqualToView(productTypeLabel)
    .leftEqualToView(productDetailLabel);
    
    
    productShapeLabel.sd_layout
    .leftEqualToView(productTypeLabel)
    .topSpaceToView(productTypeLabel, 3)
    .widthIs(78)
    .heightIs(21);
    
    
    productShapeDetailLabel.sd_layout
    .leftEqualToView(productTypeDetailLabel)
    .rightEqualToView(productTypeDetailLabel)
    .topEqualToView(productShapeLabel)
    .bottomEqualToView(productShapeLabel);
    
    
    productAreaLabel.sd_layout
    .leftEqualToView(productShapeLabel)
    .topSpaceToView(productShapeLabel, 3)
    .widthIs(62)
    .heightIs(21);
    
    
    productAreaDetailLabel.sd_layout
    .leftEqualToView(productShapeDetailLabel)
    .rightEqualToView(productShapeDetailLabel)
    .topEqualToView(productAreaLabel)
    .bottomEqualToView(productAreaLabel);
    
    
    productWightLabel.sd_layout
    .leftEqualToView(productAreaLabel)
    .topSpaceToView(productAreaLabel, 3)
    .heightIs(21)
    .widthIs(57);
    
    productWightDetailLabel.sd_layout
    .leftEqualToView(productAreaDetailLabel)
    .rightEqualToView(productAreaDetailLabel)
    .topEqualToView(productWightLabel)
    .bottomEqualToView(productWightLabel);
    
    [self.mainTableView addSubview:headView];
    
}


#pragma scrollDelegate
-(void)scrollViewLeaveAtTheTop:(UIScrollView *)scrollView
{
    self.parentScrollView = scrollView;
    //离开顶部 主View 可以滑动
    
    self.parentScrollView.scrollEnabled = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //获取滚动视图y值的偏移量
    CGFloat tabOffsetY = [_mainTableView rectForSection:0].origin.y;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY>=tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        self.parentScrollView.scrollEnabled = YES;
    }else{
    }
    
    
    /**
     * 处理头部视图
     */
    //    CGFloat yOffset  = scrollView.contentOffset.y;
    //    if(yOffset < -headViewHeight) {
    //
    //        CGRect f = self.headImageView.frame;
    //        f.origin.y= yOffset ;
    //        f.size.height=  -yOffset;
    //        f.origin.y= yOffset;
    //
    //        //改变头部视图的fram
    //        self.headImageView.frame= f;
    //        CGRect avatarF = CGRectMake(f.size.width/2-40, (f.size.height-headViewHeight)+56, 80, 80);
    //        _avatarImage.frame = avatarF;
    //        _countentLabel.frame = CGRectMake((f.size.width-Main_Screen_Width)/2+40, (f.size.height-headViewHeight)+172, Main_Screen_Width-80, 36);
    //    }
}

#pragma mark --tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCH - 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /* 添加pageView
     * 这里可以任意替换你喜欢的pageView
     *作者这里使用一款github较多人使用的 WMPageController 地址https://github.com/wangmchn/WMPageController
     */
    [cell.contentView addSubview:self.setPageViewControllers];
    
    return cell;
}


#pragma mark -- setter/getter

-(UIView *)setPageViewControllers
{
    WMPageController *pageController = [self p_defaultController];
    pageController.title = @"Line";
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleSizeSelected = 15;
    
    [self addChildViewController:pageController];
    [pageController didMoveToParentViewController:self];
    return pageController.view;
}

- (WMPageController *)p_defaultController {
    FirstTableViewController * oneVc  = [FirstTableViewController new];
    oneVc.delegate = self;
    oneVc.usermodel = self.usermodel;
    oneVc.billdtlid = self.billdtlid;
    oneVc.machiningoutmodel = self.machiningoutmodel;
    
    oneVc.firstReload = ^{
        if (self.machOutReload) {
            self.machOutReload();
        }
    };
    
    SecondTableViewController * twoVc  = [SecondTableViewController new];
    twoVc.delegate = self;
    twoVc.usermodel = self.usermodel;
    twoVc.billdtlid = self.billdtlid;
     twoVc.machiningoutmodel = self.machiningoutmodel;
    ThirdTableViewController * thirdVc  = [ThirdTableViewController new];
    thirdVc.delegate = self;
    thirdVc.usermodel = self.usermodel;
    thirdVc.billdtlid = self.billdtlid;
     thirdVc.machiningoutmodel = self.machiningoutmodel;
    NSArray *viewControllers = @[oneVc,twoVc,thirdVc];
    
    NSArray *titles = @[@"进度",@"加工费用",@"相册"];
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    [pageVC setViewFrame:CGRectMake(0, 0, SCW, SCH)];
    pageVC.delegate = self;
    pageVC.progressColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    pageVC.menuItemWidth = SCW/3;
    pageVC.menuHeight = 44;
    pageVC.menuBGColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    pageVC.progressWidth = 31;
    pageVC.titleColorSelected = [UIColor colorWithHexColorStr:@"#333333"];
    pageVC.titleColorNormal =[UIColor colorWithHexColorStr:@"#333333"];
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    return pageVC;
}


- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    //NSLog(@"%@",viewController);
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
