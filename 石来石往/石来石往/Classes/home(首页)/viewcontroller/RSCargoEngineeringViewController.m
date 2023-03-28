//
//  RSCargoEngineeringViewController.m
//  石来石往
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCargoEngineeringViewController.h"
#import <UIViewController+YNPageExtend.h>
#import "RSCargoEngineeringCaseCell.h"
#import "RSMyRingCell.h"
#import "RSMyRingHeaderview.h"
#import "RSFriendModel.h"
#import "YJFastButton.h"
#import "RSCaseProjectDetailsViewController.h"
#import "RSPublishingProjectCaseViewController.h"
#import "RSFriendDetailController.h"
#import "RSMyRingFooterview.h"
#import "RSPublishButton.h"
#define margin 10
#define ECA 3
#define MARGIN 11
#import "RSMyPublishViewController.h"
#import "RSLeftViewController.h"
#import "RSProductDetailViewController.h"
#import "RSProjectCaseModel.h"
#import "RSProjectCaseImageModel.h"
#import "RSVideoScreenViewController.h"

@interface RSCargoEngineeringViewController ()<UITableViewDelegate,UITableViewDataSource,RSMyRingHeaderviewDelegate>
{
    //蒙版View;
    UIView * _menview;
}
@property (nonatomic,strong)NSMutableArray * oweArray;
@property (nonatomic,strong)UIView * centerloadImageView;
@property (nonatomic,strong)YJFastButton * fastBtn;
/**获取是上啦刷新，还是下拉刷新的地方 true是下拉刷新，false是下来刷新*/
@property (nonatomic,assign)BOOL isRefresh;
/**获取上啦刷新的页数*/
@property (nonatomic,assign)NSInteger pageNum;
/**获取工程案例列表的也是*/

@end
@implementation RSCargoEngineeringViewController
- (NSMutableArray *)oweArray{
    if (!_oweArray) {
        _oweArray = [NSMutableArray array];
    }
    return _oweArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
    //删除的时候要进行的刷新
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delFriendData) name:@"delFriendData" object:nil];
    //这边是发表评论和图片的时候要做的刷新的动作
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshMyFriendData) name:@"refreshMyFriendData" object:nil];

}

static NSString * MYCARGOENGINEERINGCASEHEADER = @"MYCARGOENGINEERINGCASEHEADER";
static NSString * MYCARGOENGINEERINGCASEFOOTER = @"MYCARGOENGINEERINGCASEFOOTER";
static NSString * MYCARGOMAINHEAERVIEWFOOD = @"MYCARGOMAINHEAERVIEWFOOD";
static NSInteger oldMyCargoEngineeringCaseSection = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.pageNum = 2;
    [self addTableViewRefresh];
    [self.tableView.mj_header beginRefreshing];
}



- (void)addTableViewRefresh{
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCW,SCH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        //这边是商圈
        UIView * headerview = [[UIView alloc]init];
        headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        //这边里面的视图
        UIView * alassetview = [[UIView alloc]init];
        alassetview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [headerview addSubview:alassetview];
        
        UILabel * alassetLabel = [[UILabel alloc]init];
        alassetLabel.text = @"今天";
        alassetLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        alassetLabel.font = [UIFont systemFontOfSize:28];
        [alassetview addSubview:alassetLabel];
        
        UIButton * alassetBtn  = [[UIButton alloc]init];
        [alassetBtn setImage:[UIImage imageNamed:@"iconfont-照相机"] forState:UIControlStateNormal];
        [alassetview addSubview:alassetBtn];
        
        alassetview.sd_layout
        .leftSpaceToView(headerview, 0)
        .rightSpaceToView(headerview, 0)
        .topSpaceToView(headerview, 0)
        .heightIs(90);
        //调用相册
        alassetLabel.sd_layout
        .leftSpaceToView(alassetview, 12)
        .topSpaceToView(alassetview, 10)
        .widthIs(70)
        .heightIs(30);
        
        alassetBtn.sd_layout
        .leftSpaceToView(alassetLabel, 10)
        .topEqualToView(alassetLabel)
        .bottomSpaceToView(alassetview, 10)
        .widthIs(70);
        if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]){
            alassetLabel.hidden = NO;
            [alassetBtn addTarget:self action:@selector(choiceAlassetPicture:) forControlEvents:UIControlEventTouchUpInside];
            BOOL isResult = [self.creat_userIDStr compare:self.usermodel.userID] == NSOrderedSame;
            if (isResult) {
                alassetBtn.enabled = YES;
                alassetBtn.hidden = NO;
                alassetview.sd_layout
                .heightIs(90);
            }else{
                alassetBtn.enabled = NO;
                alassetBtn.hidden = YES;
                alassetview.sd_layout
                .heightIs(0);
            }
        }else if([[self.navigationController.viewControllers objectAtIndex:1]class] == [RSProductDetailViewController class]){
            alassetBtn.hidden = YES;
            alassetBtn.enabled = NO;
            alassetLabel.hidden = YES;
            alassetview.sd_layout
            .heightIs(0);
        }else{
            alassetBtn.hidden = YES;
            alassetBtn.enabled = NO;
            alassetLabel.hidden = YES;
            alassetview.sd_layout
            .heightIs(0);
        }
        [headerview setupAutoHeightWithBottomView:alassetview bottomMargin:10];
        [headerview layoutSubviews];
        self.tableView.tableHeaderView = headerview;
    RSWeakself
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadCargoEngineerNewData];
    }];
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf loadCargoEngineerMoreNewData];
//    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadCargoEngineerMoreNewData];
    }];
    
    
        self.centerloadImageView = [[UIView alloc]initWithFrame:CGRectMake(SCW/2 - 50, 5, 100, 100)];
        self.centerloadImageView.backgroundColor = [UIColor clearColor];
        [self.tableView addSubview:self.centerloadImageView];
        YJFastButton * fastBtn = [[YJFastButton alloc]initWithFrame:CGRectMake(0, 0, 100, 70)];
        [fastBtn setImage:[UIImage imageNamed:@"矢量智能对象1"] forState:UIControlStateNormal];
        [fastBtn setTitle:@"暂无案例" forState:UIControlStateNormal];
        [fastBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        fastBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.centerloadImageView addSubview:fastBtn];
    
    if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]){
            self.centerloadImageView.hidden = YES;
        }else{
            self.centerloadImageView.hidden = NO;
        }
}



/**选择相片*/
- (void)choiceAlassetPicture:(UIButton *)choiceAlassetBtn{
    UIView * menview = [[UIView alloc]init];
    menview.backgroundColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:0.7];
    //menview.alpha = 0.5;
    [self.view addSubview:menview];
    [menview bringSubviewToFront:self.view];
    
    menview.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view , 0);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelMenview:)];
    menview.userInteractionEnabled = YES;
    [menview addGestureRecognizer:tap];
    _menview = menview;
    
    UIView * selectview = [[UIView alloc]init];
    selectview.backgroundColor = [UIColor whiteColor];
    [menview addSubview:selectview];
    [selectview bringSubviewToFront:menview];
    if (iPhone4 || iPhone5) {
        selectview.sd_layout
        .leftSpaceToView(menview, 24)
        .rightSpaceToView(menview, 24)
        .centerXEqualToView(menview)
        .centerYEqualToView(menview)
        .heightIs(180);
    }else{
        selectview.sd_layout
        .leftSpaceToView(menview, 24)
        .rightSpaceToView(menview, 24)
        .centerXEqualToView(menview)
        .centerYEqualToView(menview)
        .heightIs(220);
    }
    
    NSArray * imageArray = @[@"说荒料",@"谈大板",@"言花岗岩",@"抒生活",@"辅料",@"求购"];
    NSArray * titleArray = @[@"说荒料",@"谈大板",@"言花岗岩",@"抒生活",@"语辅料",@"求购"];
    CGFloat btnW = ((SCW - 48) - (ECA + 1)*margin)/ECA;
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
        [selectview addSubview:publishBtn];
        [publishBtn addTarget:self action:@selector(selectPublishStyle:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)selectPublishStyle:(UIButton *)btn{
    NSString * tempStr = [NSString string];
    switch (btn.tag) {
        case 10000:
            tempStr = @"gongying";
            break;
        case 10001:
            tempStr = @"gongying";
            break;
        case 10002:
            tempStr = @"gongying";
            break;
        case 10003:
            tempStr = @"gongying";
            break;
        case 10004:
            tempStr = @"gongying";
            break;
        case 10005:
            tempStr = @"qiugou";
            break;
    }
    RSMyPublishViewController * mypublishVc = [[RSMyPublishViewController alloc]init];
    mypublishVc.usermodel = self.usermodel;
    //发布什么类型的朋友圈
    mypublishVc.tempStr = tempStr;
    [self.navigationController pushViewController:mypublishVc animated:YES];
    for (UIView * view  in _menview.subviews) {
        [view removeFromSuperview];
    }
    [_menview removeFromSuperview];
}

- (void)cancelMenview:(UITapGestureRecognizer *)tap
{
    for (UIView * view in _menview.subviews) {
        [view removeFromSuperview];
    }
    //让蒙版的view清除掉
    [_menview removeFromSuperview];
}

- (void)loadCargoEngineerNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    
    if (verifykey.length > 0) {
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        RSWeakself
            self.isRefresh = true;
            [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
            [phoneDict setObject:[NSString stringWithFormat:@"%d",1] forKey:@"page_num"];
            [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
            [phoneDict setObject:self.creat_userIDStr forKey:@"friendId"];
            [phoneDict setObject:self.erpCodeStr forKey:@"erpCode"];
            [phoneDict setObject:self.usermodel.userID forKey:@"loginUserId"];
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_FOOT_MY_QUAN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    [SVProgressHUD dismiss];
                    BOOL Result = [json[@"Result"] boolValue];
                    if (Result) {
                        [weakSelf.oweArray removeAllObjects];
                        // weakSelf.oweArray = [RSFriendModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                        NSMutableArray * array = [NSMutableArray array];
                        array = json[@"Data"];
                        for (int j = 0; j < array.count; j++) {
                            RSFriendModel *friendModel = [[RSFriendModel alloc]init];
                            friendModel.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
                            friendModel.status = [[array objectAtIndex:j] objectForKey:@"status"];
                            friendModel.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
                            friendModel.content = [[array objectAtIndex:j] objectForKey:@"content"];
                            friendModel.url = [[array objectAtIndex:j] objectForKey:@"url"];
                            friendModel.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                            friendModel.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
                            friendModel.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
                            friendModel.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
                            friendModel.day = [[array objectAtIndex:j]objectForKey:@"day"];
                            friendModel.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
                            friendModel.month = [[array objectAtIndex:j]objectForKey:@"month"];
                            friendModel.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                            friendModel.status = [[array objectAtIndex:j]objectForKey:@"status"];
                            friendModel.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
                            friendModel.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
                            friendModel.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                            friendModel.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
                            friendModel.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
                            friendModel.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
                            friendModel.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
                            friendModel.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
                            friendModel.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
                            friendModel.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
                            friendModel.index = j;
                            friendModel.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
                            friendModel.type = [[array objectAtIndex:j]objectForKey:@"type"];
                            friendModel.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
                            friendModel.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
                            
                            friendModel.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
                            friendModel.video = [[array objectAtIndex:j]objectForKey:@"video"];
                            friendModel.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
                            friendModel.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
                            friendModel.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"]doubleValue];
                            [weakSelf.oweArray addObject:friendModel];
                        }
                        
                        if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]){
                            self.centerloadImageView.hidden = YES;
                        }else{
                            if (weakSelf.oweArray.count >= 1) {
                                weakSelf.centerloadImageView.hidden = YES;
                            }else{
                                weakSelf.centerloadImageView.hidden = NO;
                            }
                        }
                        [weakSelf.tableView reloadData];
                        [weakSelf.tableView.mj_header endRefreshing];
                        weakSelf.pageNum = 2;
                    }else{
                        weakSelf.centerloadImageView.hidden = NO;
                        [weakSelf.tableView.mj_header endRefreshing];
                    }
                }else{
                    weakSelf.centerloadImageView.hidden = NO;
                    [weakSelf.tableView.mj_header endRefreshing];
                }
            }];
    }
}

- (void)loadCargoEngineerMoreNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
      RSWeakself
        self.isRefresh = false;
        [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
        [phoneDict setObject:[NSString stringWithFormat:@"%ld",(long)self.pageNum] forKey:@"page_num"];
        [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"item_num"];
        [phoneDict setObject:self.creat_userIDStr forKey:@"friendId"];
        [phoneDict setObject:self.usermodel.userID forKey:@"loginUserId"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_FOOT_MY_QUAN_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                [SVProgressHUD dismiss];
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    NSMutableArray * array = [NSMutableArray array];
                    NSMutableArray * temp = [NSMutableArray array];
                    array = json[@"Data"];
                    for (int j = 0; j < array.count; j++) {
                        RSFriendModel *friendModel = [[RSFriendModel alloc]init];
                        friendModel.HZLogo = [[array objectAtIndex:j] objectForKey:@"HZLogo"];
                        friendModel.status = [[array objectAtIndex:j] objectForKey:@"status"];
                        friendModel.HZName = [[array objectAtIndex:j] objectForKey:@"HZName"];
                        friendModel.content = [[array objectAtIndex:j] objectForKey:@"content"];
                        friendModel.url = [[array objectAtIndex:j] objectForKey:@"url"];
                        friendModel.userType = [[array objectAtIndex:j]objectForKey:@"userType"];
                        friendModel.checkMsg = [[array objectAtIndex:j]objectForKey:@"checkMsg"];
                        friendModel.create_time = [[array objectAtIndex:j]objectForKey:@"create_time"];
                        friendModel.create_user = [[array objectAtIndex:j]objectForKey:@"create_user"];
                        friendModel.day = [[array objectAtIndex:j]objectForKey:@"day"];
                        friendModel.erp_id = [[array objectAtIndex:j]objectForKey:@"erp_id"];
                        friendModel.month = [[array objectAtIndex:j]objectForKey:@"month"];
                        friendModel.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                        friendModel.status = [[array objectAtIndex:j]objectForKey:@"status"];
                        friendModel.timeMark = [[array objectAtIndex:j]objectForKey:@"timeMark"];
                        friendModel.timeMarkYear = [[array objectAtIndex:j]objectForKey:@"timeMarkYear"];
                        friendModel.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                        friendModel.actenum = [[array objectAtIndex:j]objectForKey:@"actenum"];
                        friendModel.actecomment = [[array objectAtIndex:j]objectForKey:@"actecomment"];
                        friendModel.userid = [[array objectAtIndex:j]objectForKey:@"userid"];
                        friendModel.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
                        friendModel.likenum = [[array objectAtIndex:j]objectForKey:@"likenum"];
                        friendModel.likestatus = [[array objectAtIndex:j]objectForKey:@"likestatus"];
                        friendModel.photos = [[array objectAtIndex:j] objectForKey:@"newphotos"];
                        friendModel.index = j;
                        friendModel.pageranks = [[array objectAtIndex:j]objectForKey:@"pageranks"];
                        friendModel.type = [[array objectAtIndex:j]objectForKey:@"type"];
                        friendModel.attstatus = [[array objectAtIndex:j]objectForKey:@"attstatus"];
                        friendModel.theme = [[array objectAtIndex:j]objectForKey:@"theme"];
                        
                        friendModel.viewType = [[array objectAtIndex:j]objectForKey:@"viewType"];
                        friendModel.video = [[array objectAtIndex:j]objectForKey:@"video"];
                        friendModel.cover = [[array objectAtIndex:j]objectForKey:@"cover"];
                        friendModel.coverWidth = [[[array objectAtIndex:j]objectForKey:@"coverWidth"] doubleValue];
                        friendModel.coverHeight = [[[array objectAtIndex:j]objectForKey:@"coverHeight"]doubleValue];

                        [temp addObject:friendModel];
                    }
                    [weakSelf.oweArray addObjectsFromArray:temp];
                    if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]){
                        self.centerloadImageView.hidden = YES;
                    }else{
                        if (weakSelf.oweArray.count > 0) {
                            weakSelf.centerloadImageView.hidden = YES;
                        }else{
                            weakSelf.centerloadImageView.hidden = NO;
                        }
                    }
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.mj_footer endRefreshing];
                    weakSelf.pageNum++;
                }
            }else{
                if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]){
                    self.centerloadImageView.hidden = YES;
                }else{
                    if (weakSelf.oweArray.count > 0) {
                        weakSelf.centerloadImageView.hidden = YES;
                    }else{
                        weakSelf.centerloadImageView.hidden = NO;
                    }
                }
                [weakSelf.tableView.mj_footer endRefreshing];
            }
        }];
}

//发表
- (void)refreshMyFriendData{
    [self loadCargoEngineerNewData];
}

//删除
- (void)delFriendData{
    
    [self loadCargoEngineerNewData];
    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
}


#pragma mark - UITableViewDelegate  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.oweArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)myRingPlaySelectVideoIndex:(NSInteger)index{
    RSFriendModel * friendmodel = self.oweArray[index];
    [RSJumpPlayVideoTool canYouSkipThePlaybackVideoInterfaceRSFriendModel:friendmodel andViewController:self];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        RSMyRingHeaderview * myHeaderview = [[RSMyRingHeaderview alloc]initWithReuseIdentifier:MYCARGOENGINEERINGCASEHEADER];
        myHeaderview.delegate = self;
        RSFriendModel * myfriendmodel = self.oweArray[section];
        RSFriendModel * mysecondFriendmodel = [[RSFriendModel alloc]init];
        if (section > 0) {
            mysecondFriendmodel = self.oweArray[section - 1];
        }
        if (myfriendmodel.timeMark == mysecondFriendmodel.timeMark && [myfriendmodel.day isEqualToString:mysecondFriendmodel.day] && [myfriendmodel.month isEqualToString:mysecondFriendmodel.month] && myfriendmodel.timeMarkYear == mysecondFriendmodel.timeMarkYear) {
            myHeaderview.dayTimeLabel.hidden = YES;
        }else{
            myHeaderview.dayTimeLabel.hidden = NO;
        }
        myHeaderview.friendmodel = self.oweArray[section];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor clearColor]];
        [myHeaderview.contentView addSubview:btn];
        btn.tag = 10000+section;
        [btn addTarget:self action:@selector(jumpCargoEngineeringDetailConent:) forControlEvents:UIControlEventTouchUpInside];
        btn.sd_layout
        .leftSpaceToView(myHeaderview.view ,10)
        .rightSpaceToView(myHeaderview.contentView, 0)
        .topSpaceToView(myHeaderview.contentView, 0)
        .bottomSpaceToView(myHeaderview.contentView, 0);
        
        myHeaderview.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        return myHeaderview;
}

- (void)jumpCargoEngineeringDetailConent:(UIButton *)btn{
    RSFriendModel * friendmodel = self.oweArray[btn.tag - 10000];
    if ([friendmodel.status isEqualToString:@"2"]) {
        RSWeakself
        [JHSysAlertUtil presentAlertViewWithTitle:@"你上传的图片审核不通过" message:@"你是否需要删除" cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
             [SVProgressHUD showInfoWithStatus:@"取消删除"];
        } confirm:^{
            [weakSelf deletFriendNotConformToPicture:friendmodel];
            [weakSelf.oweArray removeObjectAtIndex:btn.tag - 10000];
        }];
    }else{
        RSFriendDetailController * friendDetailVc = [[RSFriendDetailController alloc]init];
        friendDetailVc.titleStyle = @"";
        friendDetailVc.selectStr = @"";
        friendDetailVc.friendID = friendmodel.friendId;
        friendDetailVc.userModel = self.usermodel;
        friendDetailVc.title = friendmodel.HZName;
        [self.navigationController pushViewController:friendDetailVc animated:YES];
    }
}


#pragma mark -- 删除朋友圈
- (void)deletFriendNotConformToPicture:(RSFriendModel *)friendmodel{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:friendmodel.friendId forKey:@"friendId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DEL_FRIEND_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                [weakSelf.tableView reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        RSFriendModel * friendmodel = self.oweArray[section];
        if ([friendmodel.viewType isEqualToString:@"video"]) {
            return 80;
        }else if([friendmodel.viewType isEqualToString:@"picture"]){
            
            if (friendmodel.photos.count < 1) {
                CGSize size = [friendmodel.content boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
                return size.height + 20;
            }else{
              return 80;
            }
        }else{
            CGSize size = [friendmodel.content boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
            return size.height + 20;
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        oldMyCargoEngineeringCaseSection = section;
        RSFriendModel * myfriendmodel = self.oweArray[oldMyCargoEngineeringCaseSection];
        RSFriendModel * nextMyfriendmodel = [[RSFriendModel alloc]init];
        if (oldMyCargoEngineeringCaseSection + 1 <= self.oweArray.count - 1) {
            nextMyfriendmodel = self.oweArray[oldMyCargoEngineeringCaseSection + 1];
            if ([myfriendmodel.day isEqualToString:nextMyfriendmodel.day] && [myfriendmodel.month isEqualToString:nextMyfriendmodel.month] && myfriendmodel.timeMarkYear == nextMyfriendmodel.timeMarkYear) {
                return 5;
            }else{
                return 15;
            }
        }else{
            return 15;
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([self.cellTitle isEqualToString:@"商圈"]) {
        static NSString * MYCARGOENGINEERINGCASECELL = @"MYRSCargoEngineeringCaseCell";
        RSMyRingCell *cell = [tableView dequeueReusableCellWithIdentifier:MYCARGOENGINEERINGCASECELL];
        if (!cell) {
            cell = [[RSMyRingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MYCARGOENGINEERINGCASECELL];
        }
        return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
        RSMyRingFooterview * myFooterview = [[RSMyRingFooterview alloc]initWithReuseIdentifier:MYCARGOENGINEERINGCASEFOOTER];
        myFooterview.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        return myFooterview;
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = false;
//}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
