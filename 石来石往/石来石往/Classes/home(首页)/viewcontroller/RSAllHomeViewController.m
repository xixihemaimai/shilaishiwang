//
//  RSAllHomeViewController.m
//  石来石往
//
//  Created by mac on 2017/11/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAllHomeViewController.h"




#import "RSLoginViewController.h"
#import "RSMyPublishViewController.h"
#import "RSLifeViewController.h"
#import "RSALLMessageViewController.h"
#import "RSPublishButton.h"
//消息按键
#import "RSRedButton.h"
#define margin 15
#define ECA 3
#define MARGIN 11
//通知中心界面
#import "RSNSNotificationMessageViewController.h"
//筛选
#import "RSSecondScreenButton.h"
//全部消息
//#import "RSAllMessageUIButton.h"
//货主搜索
#import "RSOwnerViewController.h"
#import "RSTradingAreaView.h"
#import "RSBlocksNumberViewController.h"
#import "ZKImgRunLoopView.h"
#import "RSSecondStoneExtitibitionViewController.h"

#import "RSMyRingViewController.h"
#import "RSCargoCenterBusinessViewController.h"
#import "RSWeChatShareTool.h"
#import "RSJumpPlayVideoTool.h"
#import "RSFriendDetailController.h"
#define EXTENTH ((CGFloat)192/(CGFloat)720) * SCW
//RSHomeViewControllerDelegate
@interface RSAllHomeViewController ()<UIScrollViewDelegate,MomentViewControllerDelegate,RSTradingAreaViewDelegate,LXActivityDelegate,RSNSNotificationMessageViewControllerDelegate>

{
    UIView * _navigationView;
     BOOL isClick;
   // UIView * _friendStyleView;
    UIView * _publisView;
    //荒料部分按键的view;
   // UIView * _selectView;
    UIView * _menview;
    //展会的view是否显示
    BOOL isExhibitionShow;
}
//时间的数组
@property (nonatomic,strong)NSArray *times;
// 选中按钮
//@property (nonatomic, strong) UIButton *selectedBtn;
/**自定义self.navigationItem.titleView*/
@property (nonatomic,strong)UIView * titleview;
/** 标题栏 */
//@property (nonatomic,weak) UIScrollView *titleScrollView;
/** 上一次点击的按钮 */
@property (nonatomic,weak) UIButton *preBtn;
/** 内容的scrollView */
@property (nonatomic,weak) UIScrollView *contentScrollView;
/** 标题按钮数组 */
@property (nonatomic,strong) NSMutableArray *titleBtns;
/** 下滑线 */
@property (nonatomic,strong) UIView *lineView;



@property (nonatomic,strong)UIButton * rightBtn;
/**消息的按键*/
@property (nonatomic,strong)RSRedButton * redbtn;

/**选择你要看的选择的类型*/
//@property (nonatomic,strong)NSString * selectStr;


/**涮选的按键*/
//@property (nonatomic,strong)UIButton * choiceBtn;



/**中间值*/
//@property (nonatomic,strong)NSString * tempStyle;



/**搜索界面*/
@property (nonatomic,strong)RSTradingAreaView * tradingAreaview;



/**展会图片的数组*/
@property (nonatomic,strong)NSMutableArray * exhibitionArray;

/**展会点击图片的数组*/
@property (nonatomic,strong)NSMutableArray * exhibitionShowArray;
/**展会的bannerview*/
@property (nonatomic,strong)ZKImgRunLoopView *imgRunView ;


@end

@implementation RSAllHomeViewController


- (NSMutableArray *)exhibitionArray{
    if (!_exhibitionArray) {
        _exhibitionArray = [NSMutableArray array];
    }
    return _exhibitionArray;
}

-(NSMutableArray *)exhibitionShowArray{
    
    if (!_exhibitionShowArray) {
        _exhibitionShowArray = [NSMutableArray array];
    }
    return _exhibitionShowArray;
}




- (NSMutableArray *)titleBtns
{
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

- (RSTradingAreaView *)tradingAreaview{
    if (!_tradingAreaview) {
        _tradingAreaview = [[RSTradingAreaView alloc]initWithFrame:CGRectMake(0, SCH, SCW, SCH)];
        _tradingAreaview.userInteractionEnabled = YES;
        _tradingAreaview.delegate = self;
    }
    
    return _tradingAreaview;
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    /**退出登录要做的时候*/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changEntryMode) name:@"SignOutLogin" object:nil];
    
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshRedBtnBadvalue) name:@"badgeValuerefresh" object:nil];
}


#pragma mark --  这个是点赞
//- (void)reloadArrayDataRSFriendModel:(RSFriendModel *)friendmodel andFriendArray:(NSMutableArray *)friendArray andshowType:(NSString *)showType{
//    if ([showType isEqualToString:@"all"]) {
//       // RSLifeViewController * lifeVc = self.childViewControllers[1];
////        for (int i = 0; i < lifeVc.friendArray.count; i++) {
////            RSFriendModel * friendModel = lifeVc.friendArray[i];
////            if ([friendmodel.friendId isEqualToString:friendModel.friendId]) {
////                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
////                [lifeVc.friendArray replaceObjectAtIndex:indexpath.row withObject:friendmodel];
////                [lifeVc.informationTableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
////            }
////        }
//    }else{
//      //  RSALLMessageViewController *allMessageVc = self.childViewControllers[0];
////        for (int i = 0; i < allMessageVc.friendArray.count; i++) {
////            RSFriendModel * friendModel = allMessageVc.friendArray[i];
////            if ([friendmodel.friendId isEqualToString:friendModel.friendId]) {
////                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
////                [allMessageVc.friendArray replaceObjectAtIndex:indexpath.row withObject:friendmodel];
////                [allMessageVc.informationTableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
////            }
////        }
//    }
//}


- (void)reloadArrayDataMoment:(Moment *)moment andMomentList:(NSMutableArray *)momentList andshowType:(NSString *)showType{
//    if ([showType isEqualToString:@"all"]) {
    
//        RSLifeViewController * lifeVc = self.childViewControllers[1];
//        // 设置子控制器标题
//        lifeVc.title = @"关注";
//        lifeVc.delegate = self;
//        lifeVc.userModel = self.userModel;
//        for (UIView * view in lifeVc.view.subviews) {
//            [view removeFromSuperview];
//        }
//        [lifeVc viewDidLoad];
    
    
        RSLifeViewController * lifeVc = self.childViewControllers[1];
        for (int i = 0; i < lifeVc.momentList.count; i++) {
            Moment * moment1 = lifeVc.momentList[i];
            if ([moment.friendId isEqualToString:moment1.friendId]) {
                
                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                //            /[allMessageVc.friendArray replaceObjectAtIndex:indexpath.row withObject:friendmodel.attstatus];
                //moment1.attstatus = moment.attstatus;
                
                [lifeVc.momentList replaceObjectAtIndex:i withObject:moment];
                [UIView setAnimationsEnabled:NO];
              //  [momentList replaceObjectAtIndex:indexpath.row withObject:moment];
                [lifeVc.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                [UIView setAnimationsEnabled:YES];
                break;
            }
        }
    
        RSALLMessageViewController * allMessageVc = self.childViewControllers[0];
        for (int i = 0; i < allMessageVc.momentList.count; i++) {
            Moment * moment1 = allMessageVc.momentList[i];
            if ([moment.friendId isEqualToString:moment1.friendId]) {
                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                //            /[allMessageVc.friendArray replaceObjectAtIndex:indexpath.row withObject:friendmodel.attstatus];
                //moment1.attstatus = moment.attstatus;
                 [UIView setAnimationsEnabled:NO];
                [allMessageVc.momentList replaceObjectAtIndex:indexpath.row withObject:moment];
                [allMessageVc.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                 [UIView setAnimationsEnabled:YES];
                break;
            }
        }
//    }else{
//        RSALLMessageViewController * allMessageVc = self.childViewControllers[0];
//        // 设置子控制器标题
//        allMessageVc.title = @"石圈";
//        allMessageVc.delegate = self;
//        allMessageVc.userModel = self.userModel;
//        for (UIView * view in allMessageVc.view.subviews) {
//            [view removeFromSuperview];
//        }
//        [allMessageVc viewDidLoad];
//
//        RSLifeViewController * lifeVc = self.childViewControllers[1];
//        for (int i = 0; i < lifeVc.momentList.count; i++) {
//            Moment * moment1 = lifeVc.momentList[i];
//            if ([moment.friendId isEqualToString:moment1.friendId]) {
//                 [UIView setAnimationsEnabled:NO];
//                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
//                //            /[allMessageVc.friendArray replaceObjectAtIndex:indexpath.row withObject:friendmodel.attstatus];
//                //moment1.attstatus = moment.attstatus;
//                [momentList replaceObjectAtIndex:indexpath.row withObject:moment];
//                [lifeVc.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
//               // [lifeVc.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionNone animated:NO];
//                 [UIView setAnimationsEnabled:YES];
//                break;
//            }
//        }
//    }
}



//#pragma mark -- 关注
//- (void)changAttatitionDataRSFriendModel:(RSFriendModel *)friendmodel andShowType:(NSString *)showType{
//
//    // if ([showType isEqualToString:@"all"]) {
//    RSLifeViewController * lifeVc = self.childViewControllers[1];
//    // 设置子控制器标题
//    lifeVc.title = @"关注";
//    lifeVc.delegate = self;
//    lifeVc.userModel = self.userModel;
//    for (UIView * view in lifeVc.view.subviews) {
//        [view removeFromSuperview];
//    }
//    [lifeVc viewDidLoad];
//
//    RSALLMessageViewController * allMessageVc = self.childViewControllers[0];
//    for (int i = 0; i < allMessageVc.friendArray.count; i++) {
//        RSFriendModel * friendModel = allMessageVc.friendArray[i];
//        if ([friendmodel.HZName isEqualToString:friendModel.HZName]) {
//            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
//            //            /[allMessageVc.friendArray replaceObjectAtIndex:indexpath.row withObject:friendmodel.attstatus];
//            friendModel.attstatus = friendmodel.attstatus;
//            [allMessageVc.informationTableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
//        }
//    }
//}





#pragma mark -- 关注
- (void)changAttatitionDataMoment:(Moment *)moment andShowType:(NSString *)showType{
        RSLifeViewController * lifeVc = self.childViewControllers[1];
        // 设置子控制器标题
        lifeVc.title = @"关注";
        lifeVc.delegate = self;
        lifeVc.userModel = self.userModel;
        for (UIView * view in lifeVc.view.subviews) {
            [view removeFromSuperview];
        }
        [lifeVc viewDidLoad];
        
        RSALLMessageViewController * allMessageVc = self.childViewControllers[0];
        for (int i = 0; i < allMessageVc.momentList.count; i++) {
            Moment * moment1 = allMessageVc.momentList[i];
            if ([moment.HZName isEqualToString:moment1.HZName]) {
                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                //            /[allMessageVc.friendArray replaceObjectAtIndex:indexpath.row withObject:friendmodel.attstatus];
                moment1.attstatus = moment.attstatus;
                [allMessageVc.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
}

- (void)viewDidLoad {
   [super viewDidLoad];
    isExhibitionShow = false;
    self.times = @[@(0.5),@(0.4),@(0.3),@(0.2),@(0),@(0.1)];
  //[self initUserInfo];
    //自定义导航栏视图
    [self addCustomNavigationBarView];

    [self showBannerView];
  //  self.title = @"商圈";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    // 2.搭建标题栏视图
  //  [self setupTitleView];
     //[self addSendFriendStyle];
   // _selectStr = @"quanbu";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 3.搭建内容视图
        [self setupContentView];
        // __weak typeof(self) weakSelf = self;
        //  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //  if (self.userModel.userID != nil) {
        //  [weakSelf reloadmessageCount];
        // }
        // 1.添加所有子控制器
        [self addAllChildVC];
        self.automaticallyAdjustsScrollViewInsets = NO;
        // 5.默认选中下标为0的按钮
        [self titleBtnClick:self.titleBtns[0]];
        // });
        [self.view addSubview:self.tradingAreaview];
    });
}




- (void)showBannerView{
    
    //这边要加展销会的网络地址
    ZKImgRunLoopView *imgRunView = [[ZKImgRunLoopView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW,  EXTENTH) placeholderImg:[UIImage imageNamed:@"01"]];
    
    imgRunView.pageControl.hidden = NO;
    [self.view addSubview:imgRunView];
    _imgRunView = imgRunView;
    imgRunView.pageControl.PageControlStyle = JhPageControlContentModeLeft;
    _imgRunView.pageControl.PageControlStyle = JhPageControlStyelDefault;
    _imgRunView.pageControl.currentColor = [UIColor whiteColor];
    _imgRunView.pageControl.otherColor = [UIColor colorWithHexColorStr:@"#f7f7f7" alpha:0.4];
    
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETSTONEEXHIBITION_IOS withParameters:nil withBlock:^(id json, BOOL success) {
        
        if (success) {
            
            
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                
                isExhibitionShow = true;
                
                _imgRunView.hidden = NO;
            
                
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                for (int i = 0; i < array.count; i++) {
                    
                    //stoneExhibitionImg
                    NSString * stoneExhibitionImg = [[array objectAtIndex:i]objectForKey:@"stoneExhibitionImg"];
                    
                    [weakSelf.exhibitionArray addObject:stoneExhibitionImg];
                    //startAdvertisementUrl
                    
                    NSString * stoneExhibitionUrl = [[array objectAtIndex:i]objectForKey:@"stoneExhibitionUrl"];
                    [weakSelf.exhibitionShowArray addObject:stoneExhibitionUrl];
                    
                }
                
                
                
                _imgRunView.imgUrlArray = weakSelf.exhibitionArray;
                
                
                
            }else{
                
                _imgRunView.hidden = YES;
                isExhibitionShow = false;
                
            }
        }else{
            
            _imgRunView.hidden = YES;
            isExhibitionShow = false;
            
            
        }
    }];
    
    
    
    
    
    //这边是点击每个广告图片要跳转的位置
    [imgRunView  touchImageIndexBlock:^(NSInteger index) {
        
        NSString * stoneExhibitionUrl = weakSelf.exhibitionShowArray[index];
        
        
        RSSecondStoneExtitibitionViewController * secondStoneVc = [[RSSecondStoneExtitibitionViewController alloc]init];
        secondStoneVc.stoneExhibitionUrl = stoneExhibitionUrl;
        [self.navigationController pushViewController:secondStoneVc animated:YES];
        
        
        
    }];
    
    
}

- (void)changRedBadValueAttSize:(NSInteger)attSize andFriendRed:(BOOL)friendRed andShowType:(NSString *)showType{
    
    //_fristlabel
    //_secondlabel
    //friendRed 石圈
    //attSize的次数
    if (friendRed) {
        _fristlabel.hidden = NO;
    }else{
        _fristlabel.hidden = YES;
    }
    
   // NSInteger attInter = [attSize integerValue];
    
    if (attSize > 0) {
        _secondlabel.hidden = NO;
        _secondlabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:attSize]];
    }else{
        _secondlabel.hidden = YES;
        _secondlabel.text = @"";
    }
}


- (void)hideRedBadValueTitle:(NSString *)title{
    if ([title isEqualToString:@"石圈"]) {
        _fristlabel.hidden =YES;
        
    }else{
        _secondlabel.hidden = YES;
        _secondlabel.text = @"";
    }
}



#pragma mark -- 重新获取角标数
- (void)refreshRedBtnBadvalue{
    [self reloadmessageCount];
}

#pragma mark -- 获取消息次数
- (void)reloadmessageCount{

    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifkey = [user objectForKey:@"VERIFYKEY"];
    if (verifkey.length > 1) {
        if (self.userModel.userID != nil && self.userModel.userName != nil && self.userModel.userPhone != nil) {
            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
            [phoneDict setObject:self.userModel.userID forKey:@"userId"];
            //二进制数
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifkey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            //__weak typeof(self) weakSelf = self;
            XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_MESSAGECOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL Result = [json[@"Result"]boolValue];
                    if (Result) {
                        _redbtn.badgeValue = [json[@"Data"] integerValue];
                    }
                }else{
                    _redbtn.badgeValue = 0;
                }
            }];
        }else{
            _redbtn.badgeValue = 0;
            NSString * str = @"特别要注意的地方";
            [RSERROExceptTool showErrorExceptErrorStr:str];
        }
    }else{
        _redbtn.badgeValue = 0;
    }
}

#pragma mark -- 自定义导航栏视图
- (void)addCustomNavigationBarView{
    //这边要自定义导航栏了
    UIView * navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, -220, SCW, 300)];
    navigationView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    [self.view addSubview:navigationView];
    _navigationView = navigationView;
    //发表的界面
    UIView * publisView = [[UIView alloc]initWithFrame:CGRectMake(24,22,SCW - 48, 232)];
    publisView.backgroundColor = [UIColor clearColor];
    [_navigationView addSubview:publisView];
    _publisView = publisView;
    _publisView.hidden = YES;
    NSArray * imageArray = @[@"说荒料",@"谈大板",@"言花岗岩",@"抒生活",@"辅料",@"求购"];
    NSArray * titleArray = @[@"说荒料",@"谈大板",@"言花岗岩",@"抒生活",@"语辅料",@"求购"];
    CGFloat btnW = (publisView.bounds.size.width - (ECA + 1)*margin)/ECA;
    CGFloat btnH = btnW;
    for (int i = 0 ; i < imageArray.count; i++) {
        RSPublishButton * publishBtn = [[RSPublishButton alloc]init];
        NSInteger row = i / ECA;
        NSInteger colom = i % ECA;
        publishBtn.tag = 10000 + i;
        CGFloat btnX =  colom * (margin + btnW) + margin;
        CGFloat btnY =  row * (margin + btnH) + margin;
        publishBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [publishBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [publisView addSubview:publishBtn];
        [publishBtn addTarget:self action:@selector(publishStyle:) forControlEvents:UIControlEventTouchUpInside];
    }
    //底下的界面
    UIView * showView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(publisView.frame), SCW, 44)];
    showView.backgroundColor = [UIColor clearColor];
    [_navigationView addSubview:showView];
    
    //左边的位置
    RSRedButton * redbtn = [[RSRedButton alloc] init];
    [redbtn setImage:[UIImage imageNamed:@"通知1"] forState:UIControlStateNormal];
    [redbtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [redbtn addTarget:self action:@selector(jumpNSNotificationCenterViewController:) forControlEvents:UIControlEventTouchUpInside];
    //redbtn.badgeValue = 3; //红点的值_btn.isRedBall = YES;此布尔值的设置只显示红点
    [showView addSubview:redbtn];
    _redbtn = redbtn;
    
    UIButton * owerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [owerBtn setImage:[UIImage imageNamed:@"货主列表"] forState:UIControlStateNormal];
    [owerBtn addTarget:self action:@selector(jumpOwerViewController:) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:owerBtn];
    
    redbtn.sd_layout
    .leftSpaceToView(showView, 12)
    .centerYEqualToView(showView)
    .widthIs(25)
    .heightIs(25);
    
    owerBtn.sd_layout
    .leftSpaceToView(redbtn, 15)
    .topEqualToView(redbtn)
    .bottomEqualToView(redbtn)
    .widthIs(25);
 
    
    UIView * titleview = [[UIView alloc]init];
    _titleview = titleview;
    _titleview.backgroundColor = [UIColor clearColor];
    [showView addSubview:titleview];
    
    titleview.sd_layout
    .centerXEqualToView(showView)
    .centerYEqualToView(showView)
    .widthIs(SCW/2)
    .heightIs(44);
    
    UILabel * fristlabel = [[UILabel alloc]init];
    fristlabel.backgroundColor = [UIColor colorWithRed:251/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    //fristlabel.text = @"1";
    fristlabel.font = [UIFont systemFontOfSize:8];
    fristlabel.textAlignment = NSTextAlignmentCenter;
    [titleview addSubview:fristlabel];
    [fristlabel bringSubviewToFront:self.titleview];
    _fristlabel = fristlabel;
    _fristlabel.hidden = YES;
    
    fristlabel.sd_layout
    .leftSpaceToView(self.titleview, (_titleview.bounds.size.width/2) - 20)
    .topSpaceToView(self.titleview, 0)
    .widthIs(12)
    .heightIs(12);
    
    fristlabel.layer.cornerRadius = fristlabel.yj_width * 0.5;
    fristlabel.layer.masksToBounds = YES;
    
    UILabel * secondlabel = [[UILabel alloc]init];
    secondlabel.backgroundColor = [UIColor colorWithRed:251/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    //secondlabel.text = @"1";
    secondlabel.font = [UIFont systemFontOfSize:8];
    secondlabel.textAlignment = NSTextAlignmentCenter;
    [titleview addSubview:secondlabel];
    [secondlabel bringSubviewToFront:self.titleview];
    secondlabel.textColor = [UIColor whiteColor];
    _secondlabel = secondlabel;
    _secondlabel.hidden = YES;
    
    secondlabel.sd_layout
    .leftSpaceToView(self.titleview, _titleview.bounds.size.width - 20)
    .topSpaceToView(self.titleview, 0)
    .widthIs(12)
    .heightIs(12);
    secondlabel.layer.cornerRadius = fristlabel.yj_width * 0.5;
    secondlabel.layer.masksToBounds = YES;
    
    //右边的按键
    
    
    UIButton * searchBtn = [[UIButton alloc]init];
    [searchBtn setImage:[UIImage imageNamed:@"商圈搜索"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchTradingAreaAction:) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:searchBtn];
    
    
    UIButton * rightBtn = [[UIButton alloc]init];
    [rightBtn setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(sendInformation:) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:rightBtn];
    _rightBtn = rightBtn;
    
  
    
    
    rightBtn.sd_layout
    .rightSpaceToView(showView, 12)
//    .bottomSpaceToView(showView, 5)
    .centerYEqualToView(showView)
    .widthIs(25)
    .heightIs(25);
    
    
    
    searchBtn.sd_layout
    .centerYEqualToView(showView)
    .rightSpaceToView(rightBtn, 15)
    .widthIs(25)
    .heightIs(25);
    

    // 4.添加标题按钮
    [self setupAllTitleButton];
    [self setupUnderLineView];
}



//搜索商圈
- (void)searchTradingAreaAction:(UIButton *)searchBtn{
        //这边弄搜索商圈的界面
//        RSTradingAreaView * tradingAreaview = [[RSTradingAreaView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
//        tradingAreaview.userInteractionEnabled = YES;
//        tradingAreaview.delegate = self;
       // tradingAreaview.tag = 1236;
       // [[UIApplication sharedApplication].keyWindow addSubview:tradingAreaview];
    
    //这边要判断是否登录了
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    //self.userModel.userID == nil
    if ( VERIFYKEY.length < 1) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
        
    }else{
        RSWeakself
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.tradingAreaview.frame = CGRectMake(0, 0, SCW, SCH);
        }];
        
        self.tradingAreaview.searchTextfield.text = @"";
        self.tradingAreaview.usermodel = self.userModel;
        [self.tradingAreaview.searchTextfield becomeFirstResponder];
        self.tabBarController.tabBar.hidden = YES;
    }
}




#pragma mark --RSTradingAreaViewDelegate
- (void)cancelBtnAction{
    RSWeakself
     self.tabBarController.tabBar.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.tradingAreaview.frame = CGRectMake(0, SCH, SCW, SCH);
    }];
    [self.tradingAreaview.searchDataArray removeAllObjects];
    [self.tradingAreaview.tableview reloadData];
    [self.tradingAreaview.searchTextfield resignFirstResponder];
}



- (void)searchcontextTitle:(NSString *)title andFriendID:(NSString *)friendID andSelectStr:(NSString *)selectStr{
    
    RSFriendDetailController * friendDetailVc = [[RSFriendDetailController alloc]init];
    friendDetailVc.title = title;
    friendDetailVc.titleStyle = self.title;
    friendDetailVc.friendID = friendID;
    friendDetailVc.selectStr = selectStr;
    friendDetailVc.userModel = self.userModel;
    friendDetailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:friendDetailVc animated:YES];
    self.tradingAreaview.frame = CGRectMake(0, SCH, SCW, SCH);
    //self.tabBarController.tabBar.hidden = NO;
    [self.tradingAreaview.searchDataArray removeAllObjects];
    [self.tradingAreaview.tableview reloadData];
    [self.tradingAreaview.searchTextfield resignFirstResponder];
}


//点击用户名称
- (void)didShowFriendsCell:(MomentCell *)cell{
     
    //self.hidesBottomBarWhenPushed = YES;
    if ([cell.moment.userType isEqualToString:@"hxhz"]) {
        RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:cell.moment.erpCode andCreat_userIDStr:cell.moment.create_user andUserIDStr:cell.moment.userid];
        cargoCenterVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cargoCenterVc animated:YES];
        
    }else{
        
        
        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
        myRingVc.erpCodeStr = cell.moment.erpCode;
        myRingVc.userIDStr = cell.moment.userid;
        //新添加一个是游客还是货主
        /**
         myRingVc.userType = _currentComment.commentUserType;
         myRingVc.creat_userIDStr = _currentComment.commentUserId
         */
        myRingVc.userType = cell.moment.userType;
        myRingVc.creat_userIDStr = cell.moment.create_user;
        myRingVc.userModel = self.userModel;
        myRingVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myRingVc animated:YES];
       
    }
   // self.hidesBottomBarWhenPushed = NO;
    self.tradingAreaview.frame = CGRectMake(0, SCH, SCW, SCH);
    //self.tabBarController.tabBar.hidden = NO;
    
    [self.tradingAreaview.searchDataArray removeAllObjects];
    [self.tradingAreaview.tableview reloadData];
    [self.tradingAreaview.searchTextfield resignFirstResponder];
}


- (void)didShowFriendShareCell:(MomentCell *)cell{
    self.hidesBottomBarWhenPushed = YES;
    cell.menuView.show = NO;
    Moment * moment = cell.moment;
    NSArray *shareButtonTitleArray = nil;
    NSArray *shareButtonImageNameArray = nil;
    shareButtonTitleArray = @[@"微信",@"微信朋友圈"];
    shareButtonImageNameArray = @[@"微信",@"微信朋友圈"];
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消分享" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray andMoment:moment];
    [lxActivity showInView:self.view];
    self.hidesBottomBarWhenPushed = NO;
    self.tradingAreaview.frame = CGRectMake(0, SCH, SCW, SCH);
    //self.tabBarController.tabBar.hidden = NO;
    [self.tradingAreaview.searchDataArray removeAllObjects];
    [self.tradingAreaview.tableview reloadData];
    [self.tradingAreaview.searchTextfield resignFirstResponder];
}


#pragma mark - LXActivityDelegate分享---这个方法还是要修改
- (void)didClickOnImageIndex:(NSInteger *)imageIndex andMoment:(Moment *)moment{
    [RSWeChatShareTool weChatShareStyleImageIndex:imageIndex andMoment:moment];
}

//跳转到视频播放
- (void)didShowFriendsVideoMoment:(Moment *)moment{
    self.hidesBottomBarWhenPushed = YES;
    [RSJumpPlayVideoTool canYouSkipThePlaybackVideoInterfaceMoment:moment andViewController:self];
    self.hidesBottomBarWhenPushed = NO;
    self.tradingAreaview.frame = CGRectMake(0, SCH, SCW, SCH);
    //self.tabBarController.tabBar.hidden = NO;
    [self.tradingAreaview.searchDataArray removeAllObjects];
    [self.tradingAreaview.tableview reloadData];
    [self.tradingAreaview.searchTextfield resignFirstResponder];
}



//点击点赞里面的内容
- (void)didShowFriendsLikeContentLike:(RSLike *)like{
 
   // self.hidesBottomBarWhenPushed = YES;
    
    
    
//    if ([cell.moment.userType isEqualToString:@"hxhz"]) {
//        RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:cell.moment.create_user andUserIDStr:self.userModel.userID];
//        [self.navigationController pushViewController:cargoCenterVc animated:YES];
//
//    }else{
//        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
//        myRingVc.erpCodeStr = @"";
//        myRingVc.userIDStr = self.userModel.userID;
//        //新添加一个是游客还是货主
//        /**
//         myRingVc.userType = _currentComment.commentUserType;
//         myRingVc.creat_userIDStr = _currentComment.commentUserId
//         */
//        myRingVc.userType = cell.moment.userType;
//        myRingVc.creat_userIDStr = cell.moment.create_user;
//        myRingVc.userModel = self.userModel;
//        [self.navigationController pushViewController:myRingVc animated:YES];
//    }
    
    
    
    if ([like.USER_TYPE isEqualToString:@"hxhz"]) {
        RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:like.SYS_USER_ID andUserIDStr:like.SYS_USER_ID];
        cargoCenterVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cargoCenterVc animated:YES];
    }else{
        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
        myRingVc.erpCodeStr = @"";
        myRingVc.userIDStr = like.SYS_USER_ID;
        //新添加一个是游客还是货主
        myRingVc.userType = like.USER_TYPE;
        myRingVc.creat_userIDStr = like.SYS_USER_ID;
        myRingVc.userModel = self.userModel;
        myRingVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myRingVc animated:YES];
     
    }
    //self.hidesBottomBarWhenPushed = NO;
    self.tradingAreaview.frame = CGRectMake(0, SCH, SCW, SCH);
    //self.tabBarController.tabBar.hidden = NO;
    
    [self.tradingAreaview.searchDataArray removeAllObjects];
    [self.tradingAreaview.tableview reloadData];
    [self.tradingAreaview.searchTextfield resignFirstResponder];
}

#pragma mark -- 搜索货主
- (void)jumpOwerViewController:(UIButton *)btn{
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    //self.userModel.userID == nil
    if ( VERIFYKEY.length < 1) {
      //  self.hidesBottomBarWhenPushed = YES;
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
      //  self.hidesBottomBarWhenPushed = NO;
    }else{
        //self.hidesBottomBarWhenPushed = YES;
        RSOwnerViewController * ownerVc = [[RSOwnerViewController alloc]init];
        ownerVc.hidesBottomBarWhenPushed = YES;
        ownerVc.usermodel = self.userModel;
        [self.navigationController pushViewController:ownerVc animated:YES];
       // self.hidesBottomBarWhenPushed = NO;
    }
}

- (void)didShowFriendsFuntion:(Moment *)moment andType:(NSString *)type{
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"refreshData" object:nil];
    NSDictionary *dict = @{@"moment":moment,@"Type":type};
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"refreshFriendStatus" object:nil userInfo:dict]];
}

- (void)didShowFriendsYKFriend:(Comment *)currentComment{
    if ([currentComment.commentUserType isEqualToString:@"hxhz"]) {
        RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:currentComment.commentUserId andUserIDStr:currentComment.commentUserId];
        [self.navigationController pushViewController:cargoCenterVc animated:YES];
       
    }else{
        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
        myRingVc.erpCodeStr = @"";
        myRingVc.userIDStr = currentComment.commentUserId;
        //新添加一个是游客还是货主
        myRingVc.userType = currentComment.commentUserType;
        myRingVc.creat_userIDStr = currentComment.commentUserId;
        myRingVc.userModel = self.userModel;
        [self.navigationController pushViewController:myRingVc animated:YES];
    }
}

- (void)didShowFriendYKFriendReUser:(Comment *)currentComment{
    
    if ([currentComment.relUserType isEqualToString:@"hxhz"]) {
        RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:currentComment.relUserId andUserIDStr:currentComment.relUserId];
        [self.navigationController pushViewController:cargoCenterVc animated:YES];
    }else{
        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
        myRingVc.erpCodeStr = @"";
        myRingVc.userIDStr = currentComment.relUserId;
        //新添加一个是游客还是货主
        myRingVc.userType = currentComment.relUserType;
        myRingVc.creat_userIDStr = currentComment.relUserId;
        myRingVc.userModel = self.userModel;
        [self.navigationController pushViewController:myRingVc animated:YES];
      
    }
}




- (void)publishStyle:(UIButton *)publishBtn{
    NSString * tempStr = [NSString string];
    switch (publishBtn.tag) {
        case 10000:
            tempStr = @"huangliao";
            break;
        case 10001:
            tempStr = @"daban";
            break;
        case 10002:
            tempStr = @"huagangyan";
            break;
        case 10003:
            tempStr = @"shenghuo";
            break;
        case 10004:
            tempStr = @"fuliao";
            break;
        case 10005:
            tempStr = @"qiugou";
            break;
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    
    
    
    CGFloat bottomH = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        bottomH = 34;
    }else{
        bottomH = 0;
    }
    
    
    //self.userModel.userID == nil
    if ( VERIFYKEY.length < 1 ) {
        //self.hidesBottomBarWhenPushed = YES;
        _rightBtn.selected = NO;
        _menview.hidden = YES;
        _publisView.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            _navigationView.frame = CGRectMake(0, -220, SCW, 300);
            if (isExhibitionShow) {
                self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, EXTENTH);
                self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(_imgRunView.frame), SCW, SCH - CGRectGetMaxY(_imgRunView.frame) - bottomH - 49);
                _menview.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame));
            }else{
                self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW,0);
                self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame) - bottomH - 49);
                _menview.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame));
            }
        }];
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
        //self.hidesBottomBarWhenPushed = NO;
    }else{
        //self.hidesBottomBarWhenPushed = YES;
        _rightBtn.selected = NO;
        _menview.hidden = YES;
        _publisView.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            _navigationView.frame = CGRectMake(0, -220, SCW, 300);
            if (isExhibitionShow) {
                self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, EXTENTH);
                self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(_imgRunView.frame), SCW, SCH - CGRectGetMaxY(_imgRunView.frame) - bottomH - 49);
                _menview.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame));
            }else{
                self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, 0);
                self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(_imgRunView.frame), SCW, SCH - CGRectGetMaxY(_imgRunView.frame) - bottomH - 49);
                _menview.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame));
            }
        }];
        RSMyPublishViewController * mypublishVc = [[RSMyPublishViewController alloc]init];
        mypublishVc.usermodel = self.userModel;
        //发布什么类型的朋友圈
        mypublishVc.tempStr = tempStr;
        mypublishVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mypublishVc animated:YES];
//        self.hidesBottomBarWhenPushed = NO;
    }
}



- (void)showNavigationPublieviewContent{
    for (int i = 0; i < self.times.count; i++) {
        CGFloat btnW = (_publisView.bounds.size.width - (ECA + 1)*margin)/ECA;
        CGFloat btnH = btnW;
        NSInteger row = i / ECA;
        NSInteger colom = i % ECA;
        CGFloat btnX =  colom * (margin + btnW) + margin;
        CGFloat btnY =  row * (margin + btnH) + margin;
        RSPublishButton *  publishBtn = _publisView.subviews[i];
        POPSpringAnimation *anmi = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anmi.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, -btnY, btnW, btnH)];
        anmi.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btnW, btnH)];
        anmi.springBounciness = 5;
        anmi.springSpeed = 5;
        anmi.beginTime = CACurrentMediaTime() + [self.times[i] floatValue];
        [publishBtn pop_addAnimation:anmi forKey:nil];
    }
}



#pragma mark -- 跳转到通知页面
- (void)jumpNSNotificationCenterViewController:(RSRedButton *)redBtn{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    //self.userModel.userID == nil
    if ( VERIFYKEY.length < 1 ) {
        //self.hidesBottomBarWhenPushed = YES;
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
        //self.hidesBottomBarWhenPushed = NO;
    }else{
        //self.hidesBottomBarWhenPushed = YES;
        //redBtn.badgeValue = 0;
        RSNSNotificationMessageViewController * nsnotVc = [[RSNSNotificationMessageViewController alloc]init];
        nsnotVc.userModel = self.userModel;
        nsnotVc.hidesBottomBarWhenPushed = YES;
        nsnotVc.delegate = self;
        [self.navigationController pushViewController:nsnotVc animated:YES];
        //self.hidesBottomBarWhenPushed = NO;
    }
}

- (void)messageCount:(NSInteger)selectCount{
    self.redbtn.badgeValue = self.redbtn.badgeValue - selectCount;
}

#pragma mark -- 点击发布的状态
- (void)sendInformation:(UIButton *)btn{
    CGFloat bottomH = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        bottomH = 34;
    }else{
        bottomH = 0;
    }
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        _publisView.hidden = NO;
        _menview.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _navigationView.frame = CGRectMake(0, 0, SCW, 300);
            
            //这边是显示六个按键的动画的方法
            [self showNavigationPublieviewContent];
            
            if (isExhibitionShow) {
                self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, EXTENTH);
                self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(_imgRunView.frame), SCW, SCH - CGRectGetMaxY(_imgRunView.frame) - bottomH - 49);
            }else{
                self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, 0);
                self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.imgRunView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame) - bottomH - 49);
            }
            if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
                   _menview.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame) - 83);
            }else{
                   _menview.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame) - 49);
            }
        }];
    }else{
        _menview.hidden = YES;
        _publisView.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            _navigationView.frame = CGRectMake(0, -220, SCW, 300);
            if (isExhibitionShow) {
                self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, EXTENTH);
                self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(_imgRunView.frame), SCW, SCH - CGRectGetMaxY(_imgRunView.frame) - bottomH - 49);
                _menview.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame));
            }else{
                self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, 0);
                self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(_imgRunView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame) - bottomH - 49);
                _menview.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame));
            }
        }];
    }
}





#pragma mark - 搭建内容视图
- (void)setupContentView
{   // 创建内容scrollView
    CGFloat bottomH = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        bottomH = 34;
    }else{
        bottomH = 0;
    }
    UIScrollView * contentScrollow = [[UIScrollView alloc]init];
    self.contentScrollView = contentScrollow;
        if (isExhibitionShow) {
            self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, EXTENTH);
            contentScrollow.frame = CGRectMake(0, CGRectGetMaxY(self.imgRunView.frame), SCW, SCH - CGRectGetMaxY(self.imgRunView.frame) - bottomH - 49);
        }else{
            self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, 0);
            contentScrollow.frame = CGRectMake(0, CGRectGetMaxY(self.imgRunView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame) - bottomH - 49);
            
        }
    // contentScrollow.contentSize = CGSizeMake(SCW, 0);
    [self.view addSubview:contentScrollow];
    contentScrollow.delegate = self;
    contentScrollow.pagingEnabled = YES;
    contentScrollow.bounces = NO;
    contentScrollow.showsHorizontalScrollIndicator = NO;
    
    UIView * menview = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_navigationView.frame) , SCW, SCH - CGRectGetMaxY(_navigationView.frame))];
    menview.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer * menTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePublishView:)];
    
    [menview addGestureRecognizer:menTap];
    menview.hidden = YES;
    menview.alpha = 0.33;
    menview.userInteractionEnabled = YES;
    [self.view addSubview:menview];
    [menview bringSubviewToFront:self.view];
    _menview = menview;
    
    
}


- (void)hidePublishView:(UITapGestureRecognizer *)tap{
    
    CGFloat bottomH = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        bottomH = 34;
    }else{
        bottomH = 0;
    }
    self.rightBtn.selected = NO;
    
    _menview.hidden = YES;
    _publisView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _navigationView.frame = CGRectMake(0, -220, SCW, 300);
        if (isExhibitionShow) {
             self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, EXTENTH);
            self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(_imgRunView.frame), SCW, SCH - CGRectGetMaxY(_imgRunView.frame) - bottomH - 49);
            _menview.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame));
        }else{
             self.imgRunView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, 0);
            self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(_imgRunView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame) - bottomH - 49);
            _menview.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), SCW, SCH - CGRectGetMaxY(_navigationView.frame));
        }
    }];
}

// 有多少个子控制器就添加多少个标题按钮
#pragma mark - 添加标题按钮
- (void)setupAllTitleButton
{
    NSArray * titles = @[@"石圈",@"关注"];
    CGFloat btnW = _titleview.bounds.size.width/2;
    CGFloat btnH = _titleview.bounds.size.height;
    for (int i = 0; i < titles.count; i++) {
        RSSecondScreenButton * titleBtn = [RSSecondScreenButton buttonWithType:UIButtonTypeCustom];
        titleBtn.tag = i;
        titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
       // [titleBtn setImage:[UIImage imageNamed:@"矩形3拷贝5"] forState:UIControlStateNormal];
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        if (i == 1) {
            [titleBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        //设置文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        //设置选中按键的文字颜色
        [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateSelected];
        [_titleview addSubview:titleBtn];
        [self.titleBtns addObject:titleBtn];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
}

#pragma mark - 标题按钮点击调用
- (void)titleBtnClick:(UIButton *)titleBtn
{
    isClick = YES;
    self.preBtn.selected = NO;
    titleBtn.selected = YES;
//    if (![self.preBtn.currentTitle isEqualToString:titleBtn.currentTitle]) {
//        [self.preBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifkey = [user objectForKey:@"VERIFYKEY"];
    //self.userModel.userID != nil
    if (verifkey.length > 0) {
        if (titleBtn.tag == 1) {
            //这边要做的事情是对界面的一个地方进行清理
           // NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            //NSString * verifkey = [user objectForKey:@"VERIFYKEY"];
            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
            [phoneDict setObject:self.userModel.userID forKey:@"userId"];
            [phoneDict setObject:[NSString stringWithFormat:@"shangquanattmsg"] forKey:@"msgType"];
            //二进制数
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifkey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_DELETE_MESSAGECOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL Result = [json[@"Result"] boolValue];
                    if (Result) {
                        _secondlabel.hidden = YES;
                        _secondlabel.text = @"";
                        _fristlabel.hidden = YES;
                    }
                }
            }];
        }
    }
    self.preBtn = titleBtn;
   // [titleBtn setImage:[UIImage imageNamed:@"矩形3拷贝5"] forState:UIControlStateNormal];
    NSInteger tag = titleBtn.tag;
    // 2.处理下滑线的移动
    [UIView animateWithDuration:0.25 animations:^{
        if (iPhone5 || iPhone4) {
            self.lineView.yj_width = titleBtn.titleLabel.yj_width;
            self.lineView.yj_centerX = titleBtn.yj_centerX;
        }else if(iPhone6p){
            self.lineView.yj_width = titleBtn.titleLabel.yj_width - 2;
            self.lineView.yj_centerX = titleBtn.yj_centerX + 10 ;
        }else{
            self.lineView.yj_width = titleBtn.titleLabel.yj_width - 8;
            self.lineView.yj_centerX = titleBtn.yj_centerX + 6;
        }
        // 3.修改contentScrollView的便宜量,点击标题按钮的时候显示对应子控制器的view
        self.contentScrollView.contentOffset = CGPointMake(tag * SCW, 0);
    }];
    // 添加子控制器的view
    UIViewController *vc = self.childViewControllers[tag];
    // 如果子控制器的view已经添加过了，就不需要再添加了
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(tag * SCW, 0 , SCW, SCH - 100);
    [self.contentScrollView addSubview:vc.view];
}

#pragma mark - 添加所有子控制器
- (void)addAllChildVC
{
    
    
    /**
     
     if ([self.taobaoUsermodel.userType isEqualToString:@"common"]) {
         imageArray = @[@"system-guanzhu复制",@"我的店铺"];
         array = @[@"收藏",@"我的店铺"];
     }else{
         imageArray = @[@"system-guanzhu复制",@"我的店铺"];
         array = @[@"收藏",@"我的店铺"];
     }
 }
 [YBPopupMenu showRelyOnView:view titles:array icons:imageArray menuWidth:190 andTag:0 delegate:self];
     
     
     */
    // 石圈
    RSALLMessageViewController *allMessageVc = [[RSALLMessageViewController alloc] init];
    // 设置子控制器标题
    allMessageVc.title = @"石圈";
    allMessageVc.delegate = self;
    allMessageVc.userModel = self.userModel;
    [self addChildViewController:allMessageVc];
    // 关注
    RSLifeViewController * lifeVc = [[RSLifeViewController alloc] init];
    // 设置子控制器标题
    lifeVc.title = @"关注";
    lifeVc.userModel = self.userModel;
    lifeVc.delegate = self;
    [self addChildViewController:lifeVc];
    NSInteger count = self.childViewControllers.count;
    self.contentScrollView.contentSize = CGSizeMake(count * SCW, 0);
}
#pragma mark - <UIScrollViewDelegate>代理
// UIScrollView由于惯性会继续的往前滚动一段距离
// 当scrollView减速结束的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.yj_width;
    UIButton *titleBtn = self.titleBtns[index];
    // 调用标题按钮的点击事件
    [self titleBtnClick:titleBtn];
    
}
#pragma mark - 添加下滑线
- (void)setupUnderLineView
{
    // 获取下标为0的标题按钮
    UIButton *titleBtn = self.titleBtns[0];
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    lineView.layer.cornerRadius = 2;
    lineView.layer.masksToBounds = YES;
    lineView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    // 下滑线高度
    CGFloat lineViewH = 3;
    CGFloat y = _titleview.yj_height - lineViewH;
    lineView.yj_height = lineViewH;
    lineView.yj_y = y;
    // 设置下划线的宽度比文本内容宽度大10
    [titleBtn.titleLabel sizeToFit];
    if (iPhone5 || iPhone4) {
        lineView.yj_width = titleBtn.titleLabel.yj_width;
        lineView.yj_centerX = titleBtn.yj_centerX;
    }else if(iPhone6p){
        lineView.yj_width = titleBtn.titleLabel.yj_width - 2;
        lineView.yj_centerX = titleBtn.yj_centerX + 10;
    }else{
        lineView.yj_width = titleBtn.titleLabel.yj_width - 8;
        lineView.yj_centerX = titleBtn.yj_centerX + 6;
    }
    // 添加到titleView里
    [_titleview addSubview:lineView];
}
//开始拖动的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isClick = NO;
}

//// 当scrollView滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算拖拽的比例
    CGFloat ratio = scrollView.contentOffset.x / scrollView.yj_width;
    // 将整数部分减掉，保留小数部分的比例(控制器比例的范围0~1.0)
    ratio = ratio - self.preBtn.tag;
    NSInteger index = scrollView.contentOffset.x / scrollView.yj_width;
    if (isClick) {
        UIButton * titleBtn = self.titleBtns[index];
        self.lineView.yj_x = titleBtn.titleLabel.yj_x;
        if (iPhone5 || iPhone4) {
            self.lineView.yj_width = titleBtn.titleLabel.yj_width;
            self.lineView.yj_centerX = titleBtn.yj_centerX;
        }else if(iPhone6p){
            self.lineView.yj_width = titleBtn.titleLabel.yj_width - 2;
            self.lineView.yj_centerX = titleBtn.yj_centerX + 10 ;
        }else{
            self.lineView.yj_width = titleBtn.titleLabel.yj_width - 8;
            self.lineView.yj_centerX = titleBtn.yj_centerX + 6;
        }
        isClick = YES;
    }else{
            if (ratio > 0) {
                self.lineView.yj_x = self.preBtn.titleLabel.yj_x;
                self.lineView.yj_width = self.preBtn.yj_centerX + scrollView.contentOffset.x / 2.5 + 15;
                if (scrollView.contentOffset.x > 180) {
                    UIButton * btn = self.titleBtns[1];
                    self.lineView.yj_x =  scrollView.contentOffset.x / 2.5 + 15 - self.preBtn.yj_centerX;
                    self.lineView.yj_width = (btn.yj_centerX + btn.yj_width) - (scrollView.contentOffset.x / 2.5) - 45;
                }
            }else{
                self.lineView.yj_x = 15 + scrollView.contentOffset.x / 5 ;
                self.lineView.yj_width = self.preBtn.yj_centerX - (scrollView.contentOffset.x / 5);
                if (scrollView.contentOffset.x < 180) {
                    UIButton * btn = self.titleBtns[0];
                    self.lineView.yj_x = btn.titleLabel.yj_x;
                    self.lineView.yj_width  = btn.yj_width + (scrollView.contentOffset.x / 5) - 20;
                }
            }
    }
}

#pragma mark -- 主要就是当退出登录，会影响到这边进入界面的地方
- (void)changEntryMode{
    
    //self.isSecondLogin = NO;
   // self.isOrdinary = false;
   // self.isLogin = true;
    //self.isOwner = false;
    self.userModel = nil;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user removeObjectForKey:@"user"];
//    [user removeObjectForKey:@"VERIFYKEY"];
//    [user synchronize];
//    [self.nameBtn setTitle:@"点击登录" forState:UIControlStateNormal];
//    [self.fansBtn setTitle:@"粉丝" forState:UIControlStateNormal];
//    [self.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
//    self.nameBtn.enabled = YES;
//    self.signOutview.hidden = YES;
//    self.namePhone.enabled = YES;
//    [self.namePhone setTitle:@"" forState:UIControlStateNormal];
//    self.topBtn.enabled = NO;
//    self.iconImage.image = [UIImage imageNamed:@"求真像"];
    
    self.redbtn.badgeValue = 0;
    
    //这边要对推送那边的网络接口进行改变
    [self reloadChildViewController];
}

#pragma mark -- 退出的时候要对
- (void)reloadChildViewController {
    for (UIViewController * fn in self.childViewControllers) {
        for (UIView * view in fn.view.subviews) {
            [view removeFromSuperview];
        }
//        if ([fn isKindOfClass:[RSALLMessageViewController class]]) {
//            RSALLMessageViewController * allMessageVc = [[RSALLMessageViewController alloc]init];
//            allMessageVc = fn;
//            allMessageVc.userModel = self.userModel;
//            allMessageVc.deleagate = self;
//            [allMessageVc viewDidLoad];
//        }else if ([fn isKindOfClass:[RSLifeViewController class]]){
//            RSLifeViewController * lifeVc = [[RSLifeViewController alloc]init];
//            lifeVc = fn;
//            lifeVc.deleagate = self;
//            lifeVc.userModel = self.userModel;
//            [lifeVc viewDidLoad];
//        }
    }
    RSALLMessageViewController * allMessageVc = self.childViewControllers[0];
    allMessageVc.userModel = self.userModel;
    allMessageVc.delegate = self;
    [allMessageVc viewDidLoad];
    
    RSLifeViewController * lifeVc = self.childViewControllers[1];
    lifeVc.delegate = self;
    lifeVc.userModel = self.userModel;
    [lifeVc viewDidLoad];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"badgeValuerefresh" object:nil];
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
