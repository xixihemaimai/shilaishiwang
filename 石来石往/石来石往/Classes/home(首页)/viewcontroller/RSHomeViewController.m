//
//  RSHomeViewController.m
//  石来石往
//
//  Created by mac on 17/5/10.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "RSHomeViewController.h"
#import "UIColor+HexColor.h"
#import "RSFriendCellCell.h"
#import <MJRefresh.h>
#import "RSLoginViewController.h"
#import "MyMD5.h"
//模型
#import "RSFriendModel.h"
#import <YYModel.h>
/**都是H5的内容*/
#import "RSCompayWebviewViewController.h"
/**帮助引导页*/
//#import "RSGuide.h"
//调整结构
#import "RSRePasswordViewController.h"
#import "RSCollectViewController.h"
#import "RSMyRingViewController.h"
#import "RSStonePictureMangerViewController.h"
#import "SDImageCache.h"
//发布
#import "RSMyPublishViewController.h"
//#import <WXApi.h>
#import "RSFriendDetailController.h"

/**H5的界面*/
#import "RSStoneExhibitionWebViewViewController.h"



//微信分享封装工具类
#import "RSWeChatShareTool.h"
#import "RSALLMessageViewController.h"
#import "RSLifeViewController.h"
#define margin 24
#define ECA 5
#import "RSAllMessageUIButton.h"
#import "UIScrollView+DREmptyDataSet.h"
//这边是跳转到货主的商圈
#import "RSCargoCenterBusinessViewController.h"
#import "RSVideoScreenViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "RSPublishButton.h"

//,SJVideoListTableViewCellDelegate,NSAttributedStringTappedDelegate
static NSString * const SJVideoListTableViewCellID = @"SJVideoListTableViewCell";
@interface RSHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,RSFriendCellCellDelegate,UIScrollViewDelegate>
{
    //置顶按键
    UIButton * _topBtn;
     //UIView * _friendStyleView;
    //荒料部分按键的view;
    //UIView * _selectView;
}
/**获取是上啦刷新，还是下拉刷新的地方 true是下拉刷新，false是下来刷新*/
@property (nonatomic,assign)BOOL isRefresh;
/**获取上啦刷新的页数*/
@property (nonatomic,assign)int pageNum;
// 选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;
/**选择你要看的选择的类型*/
@property (nonatomic,strong)NSString * selectStr;
/**用来存储全部的第一个最大的FriendID的中间值*/
@property (nonatomic,strong)NSString * tempFriendID;
/**全部按键*/
@property (nonatomic,strong)RSAllMessageUIButton * allBtn;


@end

@implementation RSHomeViewController

#pragma mark -- 懒加载
- (NSMutableArray *)friendArray{
    if (_friendArray == nil) {
        _friendArray = [NSMutableArray array];
    }
    return _friendArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    //这边是要对进入评论详情界面做的事情。
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"refreshData" object:nil];
    //点击TabbarItem
    //点击第二个控制器
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isNewData) name:@"isNewData" object:nil];
}

//是否有最新的数据--点击Tabbar各个控制器按键，还有就从后台进入前台的时候
- (void)isNewData{
    //1.这边要知道用户的的信息
    //2.这边要知道朋友圈的第一条信息
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length > 0) {
        if (self.userModel.userID != nil && _tempFriendID != nil) {
            //URL_NEWDATAINMESSAGE_IOS
            if ([self.showType isEqualToString:@"all"]) {
                // if ([_selectStr isEqualToString:@""]) {
                // RSFriendModel * freindmodel = self.friendArray[0];
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                NSString * verifkey = [user objectForKey:@"VERIFYKEY"];
                NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
                [phoneDict setObject:self.userModel.userID forKey:@"userId"];
                [phoneDict setObject:_tempFriendID forKey:@"friendId"];
                //二进制数
                NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
                NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifkey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                [network getDataWithUrlString:URL_NEWDATAINMESSAGE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                    if (success) {
                        BOOL Resutl = [json[@"Result"] boolValue];
                        if (Resutl) {
                            BOOL isfriendRed = [json[@"Data"][@"friendRed"] boolValue];
                            NSInteger  attSize = [json[@"Data"][@"attSize"] integerValue];
                            if ([self.deleagate respondsToSelector:@selector(changRedBadValueAttSize:andFriendRed:andShowType:)]) {
                                //self.title = @"石圈"
                                [self.deleagate changRedBadValueAttSize:attSize andFriendRed:isfriendRed andShowType:self.title];
                            }
                        }
                    }
                }];
                // }
            }
        }
    }
}



#pragma mark -- 刷新数据
- (void)refreshData{
    [self loadNewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.informationTableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if ([self.title isEqualToString:@"石圈"]) {
        self.showType = @"all";
    }else{
        self.showType = @"attention";
    }
    self.view.backgroundColor =[UIColor colorWithHexColorStr:@"#ffffff"];
    /**首页界面底下的tableview*/
    [self addCustomBottomInformationTableview];
    //对页数进行初始化
    self.pageNum = 2;
    //置顶
    UIButton * topBtn = [[UIButton alloc]init];
    _topBtn = topBtn;
    [topBtn setImage:[UIImage imageNamed:@"置顶1"] forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(topToTheTop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topBtn];
    _topBtn.hidden = YES;
    topBtn.sd_layout
    .rightSpaceToView(self.view,12)
    .bottomSpaceToView(self.view,SCH - 400)
    .heightIs(35)
    .widthIs(35);
    //全部
    _selectStr = @"";
    [self.informationTableview.mj_header beginRefreshing];
    //一进来获取网络数据
    static dispatch_once_t disOnce;
      __weak typeof(self) weakSelf = self;
    dispatch_once(&disOnce,^ {
        //只执行一次的代码
        //获取版本号
        [weakSelf getAPPCurrentVersion];
    });
}

//- (void)selectBtnStyle:(UIButton *)selectBtn{
//    //_selectStr = selectBtn.titleLabel.text;
//    if ([selectBtn.titleLabel.text isEqualToString:@"荒料"]) {
//        _selectStr = @"huangliao";
//    }else if ([selectBtn.titleLabel.text isEqualToString:@"大板"]){
//        _selectStr = @"daban";
//    }else if ([selectBtn.titleLabel.text isEqualToString:@"花岗岩"]){
//        _selectStr = @"huagangyan";
//    }else if ([selectBtn.titleLabel.text isEqualToString:@"生活"]){
//        _selectStr = @"shenghuo";
//    }else if ([selectBtn.titleLabel.text isEqualToString:@"辅料"]){
//        _selectStr = @"fuliao";
//    }else if ([selectBtn.titleLabel.text isEqualToString:@"求购"]){
//        _selectStr = @"qiugou";
//    }
//    if (!selectBtn.isSelected) {
//        self.selectedBtn.selected = !self.selectedBtn.selected;
//        self.selectedBtn.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
//        selectBtn.selected = !selectBtn.selected;
//        selectBtn.backgroundColor = [UIColor colorWithHexColorStr:@"#C1DAFF"];
//        self.selectedBtn = selectBtn;
//        [self.allBtn setBackgroundColor:[UIColor whiteColor]];
//        [self loadNewData];
//    }
//}

//#pragma mark -- 全部的按键
//- (void)allSelectAction:(RSAllMessageUIButton *)allBtn{
//    _selectStr = @"";
//    self.selectedBtn.selected = !self.selectedBtn.selected;
//   // self.selectedBtn.backgroundColor = [UIColor whiteColor];
//    allBtn.selected = !allBtn.selected;
//    self.selectedBtn = allBtn;
//    for (UIButton * btn in _selectView.subviews) {
//        btn.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
//    }
//    [self loadNewData];
//}

- (RSUserModel *)userModel{
    return nil;
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
                    [JHSysAlertUtil presentAlertViewWithTitle:@"商店有最新版" message:updateName cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
                    } confirm:^{
                        //随便的
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                    }];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取版本错误"];
            }
    }
    }];
    
}


#pragma mark -- 置顶到顶部
- (void)topToTheTop:(UIButton *)btn{
    [self.informationTableview setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark -- 添加自己的自定义的TABLEVIEW
- (void)addCustomBottomInformationTableview{
    self.informationTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.informationTableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.informationTableview];
    self.view.userInteractionEnabled = YES;
    self.informationTableview.delegate = self;
    self.informationTableview.dataSource = self;
    self.informationTableview.estimatedRowHeight = 0.f;
    self.informationTableview.estimatedSectionHeaderHeight = 0.f;
    self.informationTableview.estimatedSectionFooterHeight = 0.f;
    self.informationTableview.showsHorizontalScrollIndicator = NO;
    self.informationTableview.showsVerticalScrollIndicator = NO;
    self.informationTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak typeof(self) weakSelf = self;
    self.informationTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新数据
        [weakSelf loadNewData];
    }];
    
    self.informationTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //上拉加载更多
        [weakSelf loadMoreData];
    }];
    
    [self.informationTableview setupEmptyDataText:@"点击重新加载数据" tapBlock:^{
        [weakSelf loadNewData];
    }];
    
    
    [self reloadHeaderView];
    
//    UIView * friendStyleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 95)];
//    friendStyleView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:friendStyleView];
   // _friendStyleView = friendStyleView;
    
    
    //全部消息
//    NSString *t0 = @"全部\n";
//    NSString *t1 = @"消息";
//    NSDictionary *attrTitleDict0 = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName: [UIColor colorWithHexColorStr:@"#333333"]};
//    NSDictionary *attrTitleDict1 = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName: [UIColor colorWithHexColorStr:@"#333333"]};
//
//    NSAttributedString *attrStr0 = [[NSAttributedString alloc] initWithString: [t0 substringWithRange: NSMakeRange(0, t0.length)] attributes: attrTitleDict0];
//    NSAttributedString *attrStr1 = [[NSAttributedString alloc] initWithString: [t1 substringWithRange: NSMakeRange(0, t1.length)] attributes: attrTitleDict1];
//
//    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithAttributedString: attrStr0];
//    [attributedStr appendAttributedString:attrStr1];
//
//    //RSAllMessageUIButton.h
//    RSAllMessageUIButton * allBtn = [RSAllMessageUIButton buttonWithType:UIButtonTypeCustom];
//    allBtn.titleLabel.numberOfLines = 2;
//    [allBtn setAttributedTitle:attributedStr forState:UIControlStateNormal];
//    [allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [friendStyleView addSubview:allBtn];
//    [allBtn setBackgroundColor:[UIColor whiteColor]];
//    allBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    [allBtn setImage:[UIImage imageNamed:@"矩形3拷贝5"] forState:UIControlStateNormal];
//    [allBtn addTarget:self action:@selector(allSelectAction:) forControlEvents:UIControlEventTouchUpInside];
//    _allBtn = allBtn;
//
//    allBtn.sd_layout
//    .leftSpaceToView(friendStyleView, 0)
//    .topSpaceToView(friendStyleView, 0)
//    .bottomSpaceToView(friendStyleView, 10)
//    .widthIs(75);
//
//    UIView * geView = [[UIView alloc]init];
//    geView.backgroundColor = [UIColor colorWithHexColorStr:@"#E6E6E6"];
//    [friendStyleView addSubview:geView];
//
//    geView.sd_layout
//    .leftSpaceToView(allBtn, 0)
//    .topSpaceToView(friendStyleView, 10)
//    .bottomSpaceToView(friendStyleView, 20)
//    .widthIs(1);
//
//    //多个按键的
//    UIView * selectView = [[UIView alloc]init];
//    selectView.backgroundColor = [UIColor clearColor];
//    [friendStyleView addSubview:selectView];
//    _selectView = selectView;
//    selectView.sd_layout
//    .leftSpaceToView(geView, 10)
//    .rightSpaceToView(friendStyleView, 10)
//    .topSpaceToView(friendStyleView, 0)
//    .bottomSpaceToView(friendStyleView, 10);
//
//    NSArray * styleArray = @[@"荒料",@"大板",@"花岗岩",@"生活",@"辅料",@"求购"];
//    CGFloat btnW = ((SCW - 75 - 1 - 10 - 10 - 10) - (ECA + 1)*MARGIN)/ECA;
//    CGFloat btnH = 25;
//    for (int i = 0 ; i < styleArray.count; i++) {
//        UIButton * selectBtn = [[UIButton alloc]init];
//        NSInteger row = i / ECA;
//        NSInteger colom = i % ECA;
//        selectBtn.tag = 100000 + i;
//        CGFloat btnX =  colom * (MARGIN + btnW) + MARGIN;
//        CGFloat btnY =  row * (MARGIN + btnH) + MARGIN;
//        selectBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
//        selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        selectBtn.layer.cornerRadius = 3;
//        [selectBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F2F2F2"]];
//        selectBtn.layer.masksToBounds = YES;
//        [selectBtn setTitle:styleArray[i] forState:UIControlStateNormal];
//        [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
//        [selectView addSubview:selectBtn];
//        [selectBtn addTarget:self action:@selector(selectBtnStyle:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    UIView * bottomview = [[UIView alloc]init];
//    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    [friendStyleView addSubview:bottomview];
//
//    bottomview.sd_layout
//    .leftSpaceToView(friendStyleView, 0)
//    .topSpaceToView(_selectView, 0)
//    .rightSpaceToView(friendStyleView, 0)
//    .bottomSpaceToView(friendStyleView, 0);
//    self.informationTableview.tableHeaderView = friendStyleView;
}



- (void)reloadHeaderView{
    UIScrollView * friendStyleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCW, 95)];
      NSArray * styleArray = @[@"全部",@"荒料",@"大板",@"花岗岩",@"生活",@"辅料",@"求购"];
      NSArray * imageArray = @[@"语全部",@"语荒料",@"语大板",@"语花岗岩",@"语生活",@"语辅料",@"语求购"];
    friendStyleView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    friendStyleView.delegate = self;
    [self.view addSubview:friendStyleView];
    friendStyleView.pagingEnabled = NO;
    friendStyleView.showsHorizontalScrollIndicator = NO;
    // 去掉弹簧效果
    friendStyleView.bounces = NO;
    CGFloat fastBtnW = (SCW  - ((ECA + 1)*margin))/ECA;
    CGFloat fastBtnH = 75;
    for (int i = 0; i < styleArray.count; i++) {
        RSPublishButton * fastBtn = [[RSPublishButton alloc]init];
        fastBtn.tag = i;
        fastBtn.frame = CGRectMake(i * fastBtnW + i * margin + margin, 10, fastBtnW, fastBtnH);
        [fastBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [fastBtn setTitle:styleArray[i] forState:UIControlStateNormal];
        [fastBtn setBackgroundColor:[UIColor clearColor]];
        fastBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        if (i == 0) {
             [fastBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FBB399"] forState:UIControlStateNormal];
            self.selectedBtn.selected = !self.selectedBtn.selected;
            fastBtn.selected = !fastBtn.selected;
        self.selectedBtn = fastBtn;
        }else{
             [fastBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        }
        [fastBtn addTarget:self action:@selector(selectBtnStyle:) forControlEvents:UIControlEventTouchUpInside];
        [friendStyleView addSubview:fastBtn];
    }
     friendStyleView.contentSize = CGSizeMake(styleArray.count * fastBtnW + (styleArray.count + 1) * margin , 0);
     self.informationTableview.tableHeaderView = friendStyleView;
}

- (void)selectBtnStyle:(UIButton *)selectBtn{
    if ([selectBtn.titleLabel.text isEqualToString:@"全部"]) {
        _selectStr = @"";
    }else if ([selectBtn.titleLabel.text isEqualToString:@"荒料"]) {
        _selectStr = @"huangliao";
    }else if ([selectBtn.titleLabel.text isEqualToString:@"大板"]){
        _selectStr = @"daban";
    }else if ([selectBtn.titleLabel.text isEqualToString:@"花岗岩"]){
        _selectStr = @"huagangyan";
    }else if ([selectBtn.titleLabel.text isEqualToString:@"生活"]){
        _selectStr = @"shenghuo";
    }else if ([selectBtn.titleLabel.text isEqualToString:@"辅料"]){
        _selectStr = @"fuliao";
    }else if ([selectBtn.titleLabel.text isEqualToString:@"求购"]){
        _selectStr = @"qiugou";
    }
    if (!selectBtn.isSelected) {
        self.selectedBtn.selected = !self.selectedBtn.selected;
        //self.selectedBtn.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        [self.selectedBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        selectBtn.selected = !selectBtn.selected;
        //selectBtn.backgroundColor = [UIColor colorWithHexColorStr:@"#C1DAFF"];
        [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FBB399"] forState:UIControlStateNormal];
        self.selectedBtn = selectBtn;
       // [self.allBtn setBackgroundColor:[UIColor whiteColor]];
    }
     [self loadNewData];
}



#pragma mark -- 刷新新的数据
- (void)loadNewData{
    self.isRefresh = true;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    [phoneDict setObject:self.showType forKey:@"showType"];
    [phoneDict setObject:_selectStr forKey:@"friendType"];
    NSString * str = nil;
    if (self.userModel.userID == nil) {
        str = @"-1";
    }else{
        str = self.userModel.userID;
    }
    [phoneDict setObject:str forKey:@"userId"];
    // [phoneDict setObject:EPRID(1) forKey:@"erpId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_FRIEND_ZONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue] ;
            [weakSelf.friendArray removeAllObjects];
            if (Result) {
                NSMutableArray * array = [RSFriendModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                weakSelf.friendArray = array;
                weakSelf.pageNum = 2;
                //停止刷新
                [weakSelf.informationTableview reloadData];
                [weakSelf.informationTableview.mj_header endRefreshing];
                if ([_selectStr isEqualToString:@""]) {
                    if ([self.showType isEqualToString:@"all"]) {
                        //全部的时候
                        RSFriendModel *friendModel = weakSelf.friendArray[0];
                        _tempFriendID = friendModel.friendId;
                    }
                    //刷新的时候对消息角标进行处理下
                    if ([weakSelf.deleagate respondsToSelector:@selector(hideRedBadValueTitle:)]) {
                        [weakSelf.deleagate hideRedBadValueTitle:weakSelf.title];
                    }
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"badgeValuerefresh" object:nil];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
            [weakSelf.informationTableview.mj_header endRefreshing];
        }
    }];
}

#pragma mark --- 上拉获取更多的数据
- (void)loadMoreData{
    [self loadMoreNewData:_selectStr];
}

#pragma mark -- 上拉获取更多的网络请求
- (void)loadMoreNewData:(NSString *)selectStr{
    //这边就用到了很多网络的AFNetWorking
    self.isRefresh = false;
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
    [phoneDict setObject:self.showType forKey:@"showType"];
    [phoneDict setObject:selectStr forKey:@"friendType"];
    NSString * str =nil;
    if (self.userModel.userID == nil) {
        str = @"-1";
    }else{
        str = self.userModel.userID;
    }
    [phoneDict setObject:str forKey:@"userId"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_FRIEND_ZONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue] ;
            if (Result) {
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    NSMutableArray *array = [RSFriendModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                    [weakSelf.friendArray addObjectsFromArray:array];                
                        weakSelf.pageNum++;
                        [weakSelf.informationTableview.mj_footer endRefreshing];
                        //停止刷新
                        [weakSelf.informationTableview reloadData];

            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [weakSelf.informationTableview.mj_footer endRefreshing];
        }
    }];
}

#pragma mark -- 有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark -- 每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.friendArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

#pragma mark -- 每个Cell显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //这边要分是视频还是图片
    static NSString *homeID = @"cjsojsdfos";
    RSFriendCellCell *cell = [tableView dequeueReusableCellWithIdentifier:homeID];
    if (cell == nil) {
     cell = [[RSFriendCellCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:homeID] ;
    }
    //这边添加手势来跳转到H5的界面去
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpH5ViewController:)];
    UITapGestureRecognizer  *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpH5ViewController:)];
    [cell.HZLogo addGestureRecognizer:tap];
    [cell.HZName addGestureRecognizer:tap1];
    cell.HZLogo.userInteractionEnabled = YES;
    cell.HZName.userInteractionEnabled = YES;
    RSFriendModel *friendModel = self.friendArray[indexPath.row];
    cell.friendModel = friendModel;
    
    cell.tag = 1000+indexPath.row;
    cell.dibuview.commentBtn.tag = 1000+indexPath.row;
    cell.dibuview.upvoteBtn.tag = 1000+indexPath.row;
    cell.dibuview.shareBtn.tag = 1000+indexPath.row;
    cell.delegate = self;
    cell.followBtn.tag = 1000+indexPath.row;
    [cell.followBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([friendModel.likestatus isEqualToString:@"0"]) {
        //没有点赞的时候
        [cell.dibuview.upvoteBtn setTitle:friendModel.likenum forState:UIControlStateNormal];
        [cell.dibuview.upvoteBtn setTitleColor:[UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0] forState:UIControlStateNormal];
        [cell.dibuview.upvoteBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    }else {
        //这边是点了赞的
        [cell.dibuview.upvoteBtn setTitle:friendModel.likenum forState:UIControlStateNormal];
        [cell.dibuview.upvoteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#e14527"] forState:UIControlStateNormal];
        [cell.dibuview.upvoteBtn setImage:[UIImage imageNamed:@"已点赞"] forState:UIControlStateNormal];
    }
    //关注的状态
    if ([friendModel.attstatus isEqualToString:@"0"]) {
        [cell.followBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
        [cell.followBtn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
        [cell.followBtn setTitle:@"关注" forState:UIControlStateNormal];
    }else if([friendModel.attstatus isEqualToString:@"1"]){
        [cell.followBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [cell.followBtn setTitleColor:[UIColor colorWithHexColorStr:@"#747474"] forState:UIControlStateNormal];
        [cell.followBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else{
        [cell.followBtn setTitle:@"互相关注" forState:UIControlStateNormal];
        [cell.followBtn setTitleColor:[UIColor colorWithHexColorStr:@"#747474"] forState:UIControlStateNormal];
        [cell.followBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    [cell.dibuview.commentBtn setTitle:friendModel.actenum forState:UIControlStateNormal];
    [cell.dibuview.commentBtn addTarget:self action:@selector(commentBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.dibuview.upvoteBtn addTarget:self action:@selector(upvoteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.dibuview.shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //SDAutoLayout方法
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.friendArray.count - 2 ) {
        
        [self.informationTableview.mj_footer beginRefreshing];
    }
}


#pragma mark -- 关注
- (void)attentionAction:(UIButton *)followBtn{
    followBtn.selected = !followBtn.selected;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if ( VERIFYKEY.length < 1) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:followBtn.tag - 1000 inSection:0];
        RSFriendModel * friendmodel = self.friendArray[indexpath.row];
        RSWeakself
        if ( [followBtn.currentTitle isEqualToString:@"已关注"] ||[followBtn.currentTitle isEqualToString:@"互相关注"]) {
            [JHSysAlertUtil presentAlertViewWithTitle:@"是否取消关注" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            } confirm:^{
               [weakSelf cancelAndAttationMethodNSIndexpath:indexpath andFriendmodel:friendmodel];
            }];
        }else{
            [self cancelAndAttationMethodNSIndexpath:indexpath andFriendmodel:friendmodel];
        }
    }
}

- (void)cancelAndAttationMethodNSIndexpath:(NSIndexPath *)indexpath andFriendmodel:(RSFriendModel *)friendmodel{
    RSFriendCellCell *cell = [self.informationTableview cellForRowAtIndexPath:indexpath];
    [self dianzangNetwork:friendmodel andCell:(RSFriendCellCell *)cell andIndex:indexpath andType:@"gz"];
}

//FIXME:RSFriendCellCellDelegate代理 -- 跳转到播放视频的界面
- (void)showVideoPlayIndex:(NSInteger)index{
    RSFriendModel * friendmodel = self.friendArray[index];
    [RSJumpPlayVideoTool canYouSkipThePlaybackVideoInterfaceRSFriendModel:friendmodel andViewController:self];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.informationTableview) {
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
        if (VERIFYKEY.length < 1 ) {
            
            RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
            loginVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVc animated:YES];
        }else{
            
            RSFriendModel * friendmodel = self.friendArray[indexPath.row];
            RSFriendDetailController * friendDetailVc = [[RSFriendDetailController alloc]init];
            friendDetailVc.title = friendmodel.HZName;
            friendDetailVc.titleStyle = self.title;
            friendDetailVc.friendID = friendmodel.friendId;
            friendDetailVc.selectStr = _selectStr;
            friendDetailVc.titleStyle = self.title;
            friendDetailVc.userModel = self.userModel;
//            friendDetailVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:friendDetailVc animated:YES];
        }
    }
}



#pragma mark -- 评论
- (void)commentBtnAction:(RSSignOutButton *)btn{
    //这边要判断有没有登录
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    if (VERIFYKEY.length < 1) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        //这边要跳转到评论的详细页面
        
        RSFriendModel * friendmodel = self.friendArray[btn.tag - 1000];
        RSFriendDetailController * friendDetailVc = [[RSFriendDetailController alloc]init];
        friendDetailVc.friendID = friendmodel.friendId;
        friendDetailVc.title = friendmodel.HZName;
        friendDetailVc.titleStyle = self.title;
        friendDetailVc.title = friendmodel.HZName;
        friendDetailVc.selectStr = _selectStr;
        //代理
//        friendDetailVc.hidesBottomBarWhenPushed = YES;
        friendDetailVc.userModel = self.userModel;
        [self.navigationController pushViewController:friendDetailVc animated:YES];
    }
}

#pragma mark --  点赞
- (void)upvoteBtnAction:(RSSignOutButton *)btn{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    //self.userModel.userID == nil
    if (VERIFYKEY.length < 1) {
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        RSFriendModel * friendmodel = self.friendArray[btn.tag - 1000];
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:btn.tag - 1000 inSection:0];
        RSFriendCellCell *cell = [self.informationTableview cellForRowAtIndexPath:indexpath];
        [self dianzangNetwork:friendmodel andCell:(RSFriendCellCell *)cell andIndex:indexpath andType:@"dz"];
    }
}


- (void)dianzangNetwork:(RSFriendModel *)friendmodel andCell:(RSFriendCellCell *)cell andIndex:(NSIndexPath *)indexpath andType:(NSString *)type{
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    [phoneDict setObject:friendmodel.friendId forKey:@"friendId"];
    [phoneDict setObject:self.userModel.userID forKey:@"userId"];
    [phoneDict setObject:@"" forKey:@"commenter"];
    [phoneDict setObject:type forKey:@"type"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DIANZAO_PL_GZ_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                if ([type isEqualToString:@"dz"]) {
                    NSString * str = [json[@"Data"][@"likenum"] stringValue];
                    NSString * code = json[@"Data"][@"status"];
                    NSString * codeStr = [NSString stringWithFormat:@"%@",code];
                    BOOL OK = [codeStr isEqualToString:@"1"];
                    RSFriendModel * friendmodel = self.friendArray[indexpath.row];
                    friendmodel.likestatus = [NSString stringWithFormat:@"%d",OK];
                    friendmodel.likenum = str;
                   // [weakSelf.friendArray replaceObjectAtIndex:indexpath.row withObject:friendmodel];
                    
                   //  [weakSelf.informationTableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexpath.row inSection:indexpath.section];
                                RSFriendCellCell * cell = [weakSelf.informationTableview cellForRowAtIndexPath:indexPath];
                                if (OK) {
                                    [cell.dibuview.upvoteBtn setTitle:str forState:UIControlStateNormal];
                                  [cell.dibuview.upvoteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#e14527"] forState:UIControlStateNormal];
                                     [cell.dibuview.upvoteBtn setImage:[UIImage imageNamed:@"已点赞"] forState:UIControlStateNormal];
                                    [cell.dibuview.upvoteBtn popInsideWithDuration:0.4f];
                                }else{
                                    [cell.dibuview.upvoteBtn popOutsideWithDuration:0.5f];
                                    [cell.dibuview.upvoteBtn setTitle:str forState:UIControlStateNormal];
                                    [cell.dibuview.upvoteBtn setTitleColor:[UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0] forState:UIControlStateNormal];
                                    [cell.dibuview.upvoteBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
                                }
                   [weakSelf changOtherViewControllerViewFriendmodel:friendmodel andFriendArray:self.friendArray andShowType:self.showType];
                    
                }else{
                    //关注
                    //if ([self.showType isEqualToString:@"all"]) {
                        NSString * attentionStr = json[@"Data"][@"status"];
                        NSString * codeStr = [NSString stringWithFormat:@"%@",attentionStr];
                        //  BOOL OK = [codeStr isEqualToString:@"1"];
                        RSFriendModel * friendmodel = self.friendArray[indexpath.row];
                        //替换的地方
                        friendmodel.attstatus = [NSString stringWithFormat:@"%@",codeStr];
                        [weakSelf.friendArray replaceObjectAtIndex:indexpath.row withObject:friendmodel];
                       [weakSelf.informationTableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                     [weakSelf changOtherAttitonViewControllerFreindmodel:friendmodel andShowType:self.showType];
                  //  }else{
                        //[weakSelf loadNewData];
                    //}
                }
                [SVProgressHUD dismiss];
            }else{
                [SVProgressHUD showErrorWithStatus:@"失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
    }];
}



#pragma mark -- 点赞要做的事情
- (void)changOtherViewControllerViewFriendmodel:(RSFriendModel *)friendmodel andFriendArray:(NSMutableArray *)friendArray andShowType:(NSString *)ShowType{
    if ([self.deleagate respondsToSelector:@selector(reloadArrayDataRSFriendModel:andFriendArray:andshowType:)]) {
        [self.deleagate reloadArrayDataRSFriendModel:friendmodel andFriendArray:self.friendArray andshowType:ShowType];
    }
}

#pragma mark --- 关注要做的事情
- (void)changOtherAttitonViewControllerFreindmodel:(RSFriendModel *)friendmodel andShowType:(NSString *)showTyoe{
    if ([self.deleagate respondsToSelector:@selector(changAttatitionDataRSFriendModel:andShowType:)]) {
        [self.deleagate changAttatitionDataRSFriendModel:friendmodel andShowType:showTyoe];
    }
}

#pragma mark -- 分享
- (void)shareBtnAction:(RSSignOutButton *)btn{
    RSFriendModel * friendmodel = self.friendArray[btn.tag - 1000];
    NSArray *shareButtonTitleArray = nil;
    NSArray *shareButtonImageNameArray = nil;
    shareButtonTitleArray = @[@"微信",@"微信朋友圈"];
    shareButtonImageNameArray = @[@"微信",@"微信朋友圈"];
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消分享" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray andRSFriend:friendmodel];
    [lxActivity showInView:self.view];
}


#pragma mark - LXActivityDelegate
- (void)didClickOnImageIndex:(NSInteger *)imageIndex andRSFriendModel:(RSFriendModel *)friendmodel{
    [RSWeChatShareTool weChatShareStyleImageIndex:imageIndex andFriendModel:friendmodel];
}


- (void)didClickOnCancelButton
{
   // NSLog(@"didClickOnCancelButton");
}

#pragma mark -- 每个Cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSFriendModel * friendModel = self.friendArray[indexPath.row];
    CGSize size = CGSizeMake(SCW - 24, MAXFLOAT);
    CGRect textFrame = [friendModel.content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesDeviceMetrics attributes:nil context:nil];
    if ([friendModel.viewType isEqualToString:@"picture"]) {
        //这边也需要添加一个判断是视频还是相片
        if (friendModel.photos.count > 0){
            return [tableView cellHeightForIndexPath:indexPath model:friendModel keyPath:@"friendModel" cellClass:[RSFriendCellCell class] contentViewWidth:self.view.frame.size.width];
        }else{
            return 100 + textFrame.size.height + 50;
        }
    }else{
        if ([friendModel.cover isEqualToString:@""]) {
            return 100 + textFrame.size.height + 50;
        }else{
            return [tableView cellHeightForIndexPath:indexPath model:friendModel keyPath:@"friendModel" cellClass:[RSFriendCellCell class] contentViewWidth:self.view.frame.size.width];
        }
    }
    return 150;
}

#pragma mark -- 当微信登录，或者其他的界面返回的时候会向下20的距离，所以做了处理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 64) {
        _topBtn.hidden = YES;
    }else{
        _topBtn.hidden = NO;
    }
}

#pragma mark -- 跳转到我的圈的界面
- (void)jumpH5ViewController:(UITapGestureRecognizer *)tap{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
    //self.userModel.userID == nil
    if (VERIFYKEY.length < 1) {
        
        RSLoginViewController *loginVc = [[RSLoginViewController alloc]init];
        loginVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        //获得当前手势触发的在UITableView中的坐标
        CGPoint location = [tap locationInView:self.informationTableview];
        //获得当前坐标对应的indexPath
        NSIndexPath *indexPath = [self.informationTableview indexPathForRowAtPoint:location];
        if (indexPath) {
            //通过indexpath获得对应的Cell
            
            RSFriendCellCell *cell = [self.informationTableview cellForRowAtIndexPath:indexPath];
            RSFriendModel * friendModel = self.friendArray[cell.tag - 1000];
           if (![friendModel.userType isEqualToString:@"hxhz"]) {
                RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
                myRingVc.erpCodeStr = friendModel.erpCode;
                myRingVc.userIDStr = friendModel.userid;
                //新添加一个是游客还是货主
                myRingVc.userType = friendModel.userType;
                myRingVc.creat_userIDStr = friendModel.create_user;
                myRingVc.userModel = self.userModel;
               myRingVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:myRingVc animated:YES];
            }else{
                RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:friendModel.erpCode andCreat_userIDStr:friendModel.create_user andUserIDStr:friendModel.userid];
                cargoCenterVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:cargoCenterVc animated:YES];
            }
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"isNewData" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //清除图片的缓存
     [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}

@end
