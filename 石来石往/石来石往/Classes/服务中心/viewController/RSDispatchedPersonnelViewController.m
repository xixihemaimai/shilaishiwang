//
//  RSDispatchedPersonnelViewController.m
//  石来石往
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSDispatchedPersonnelViewController.h"
#import "RSDispatchPersonlCell.h"
#import "HomeMenuView.h"
#import "RSDispatchPersonDataModel.h"

#import "RSRecordDetailViewController.h"
#import "RSServiceMarketViewController.h"


/**空闲服务人员的模型*/
#import "RSChoiceFreeServiceModel.h"



#import "MJChiBaoZiHeader.h"

@interface RSDispatchedPersonnelViewController ()<RSServiceChoiceRightViewDelegate,HomeMenuViewdelegate,UIScrollViewDelegate>


{
    
    
    UIView * _menview;
    
}

//@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,strong)NSMutableArray * dispatchedPersonlArray;

/**页数*/
@property (nonatomic,assign)NSInteger pageNum;

/**开始时间*/
@property (nonatomic,strong)NSString * startdate;

/**截止时间*/
@property (nonatomic,strong)NSString * enddate;

/**用户名*/
@property (nonatomic,strong)NSString * userName;

/**服务状态*/
@property (nonatomic,strong)NSString * serviceStatus;

/**服务类型*/
@property (nonatomic,strong)NSString * serviceType;



/**保存空闲服务人员的数组*/
@property (nonatomic,strong)NSMutableArray * freeServicePeopleArray;


/**用来保存选中的服务人员的数组*/
@property (nonatomic,strong)NSMutableArray * saveFreeServicePeopleArray;


@end

@implementation RSDispatchedPersonnelViewController
- (NSMutableArray *)dispatchedPersonlArray{
    if (_dispatchedPersonlArray == nil) {
        _dispatchedPersonlArray = [NSMutableArray array];
    }
    return _dispatchedPersonlArray;
}

- (NSMutableArray *)freeServicePeopleArray{
    
    if (_freeServicePeopleArray == nil) {
        _freeServicePeopleArray = [NSMutableArray array];
    }
    return _freeServicePeopleArray;
}

- (NSMutableArray *)saveFreeServicePeopleArray{
    
    if (_saveFreeServicePeopleArray == nil) {
        _saveFreeServicePeopleArray = [NSMutableArray array];
    }
    return _saveFreeServicePeopleArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"派遣人员中心";
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    
    self.pageNum = 2;
    self.serviceStatus = @"0";
    
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    //self.startdate = currentDateString;
    self.enddate = currentDateString;
    
    
    //获取前一个月的时间
    NSDate *monthagoData = [self getPriousorLaterDateFromDate:currentDate withMonth:-1];
    NSString *beforeString = [dateFormatter stringFromDate:monthagoData];
    self.startdate = beforeString;
    self.userName = @"";
    self.serviceType = @"";
    

    RSRightNavigationButton * showQRBtn = [[RSRightNavigationButton alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    [showQRBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [showQRBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // [showQRBtn setImage:[UIImage imageNamed:@"扫二维码用的"] forState:UIControlStateNormal];
    [showQRBtn addTarget:self action:@selector(serviceScreenAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:showQRBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    
   
    [self addDispatchedPersonlCustomTableview];
    [self loadDispatchPersonlNetworkData];
    
}








//获取前一个月
-(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month{
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// NSGregorianCalendar
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

- (void)addDispatchedPersonlCustomTableview{
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navHeight + navY, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//    self.tableview = tableview;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    //self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 160, 0);
//    [self.view addSubview:self.tableview];
    
    
    RSWeakself
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//
//        [weakSelf loadDispatchPersonlNetworkData];
//    }];
    
    
    //向下刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDispatchPersonlNetworkData];
    }];
    
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadDispatchPersonlMoreNetworkData];
    }];
    
    
    //右边的视图
    //添加左边的视图
    _rightview = [[RSServiceRightFunctionView alloc]initWithSender:self];
    _rightview.backgroundColor = [UIColor whiteColor];
    //_leftview.lefttap.delegate = self;
    [self.view addSubview:_rightview];
    
    RSServiceChoiceRightView * serviceChoiceRightview = [[RSServiceChoiceRightView alloc]initWithFrame:CGRectMake(0, 0, 268,SCH)];
    _serviceChoiceRightview = serviceChoiceRightview;
    _serviceChoiceRightview.delegate = self;
    _serviceChoiceRightview.userName = self.usermodel.userName;
    serviceChoiceRightview.backgroundColor = [UIColor yellowColor];
    [_rightview setContentView:serviceChoiceRightview];
    
    
    
}


- (void)loadDispatchPersonlNetworkData{
    //URL_FINDSERVICEITEM_IOS
    /**
     用户名    userName    String    模糊搜索
     开始日期    startdate    String    2018-01-02
     结束日期    enddate    String    2018-01-02
     服务状态    serviceStatus    Int    服务状态 0->未受理， 1->已受理 ，2->派遣中， 3->进行中,4->取消服务，5->已完成，全部就传：-1
     每页条数    itemNum    Int
     页数    pageNum    Int
     //  服务类型    serviceType    String    ckfw or  scfw
     */
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.userName forKey:@"userName"];
    [dict setObject:self.startdate forKey:@"startdate"];
    [dict setObject:self.enddate forKey:@"enddate"];
    [dict setObject:self.serviceStatus forKey:@"serviceStatus"];
    [dict setObject:self.serviceType forKey:@"serviceType"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"pageNum"];
    [dict setObject:[NSString stringWithFormat:@"10"] forKey:@"itemNum"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_FINDSERVICEITEM_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [weakSelf.dispatchedPersonlArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                if (array.count > 0) {
                    for (int i = 0; i < array.count; i++) {
                        RSDispatchPersonDataModel * dispatchpersonlmodel = [[RSDispatchPersonDataModel alloc]init];
                        dispatchpersonlmodel.dispatchPersonlId = [[array objectAtIndex:i]objectForKey:@"id"];
                        dispatchpersonlmodel.appointtime = [[array objectAtIndex:i]objectForKey:@"appointtime"];
                        dispatchpersonlmodel.status = [[[array objectAtIndex:i]objectForKey:@"status"] integerValue];
                        dispatchpersonlmodel.userId = [[array objectAtIndex:i]objectForKey:@"userId"];
                        dispatchpersonlmodel.user_name = [[array objectAtIndex:i]objectForKey:@"user_name"];
                         dispatchpersonlmodel.servicetype = [[array objectAtIndex:i]objectForKey:@"servicetype"];
                        dispatchpersonlmodel.comment = [[array objectAtIndex:i]objectForKey:@"comment"];
                        dispatchpersonlmodel.servicekind = [[array objectAtIndex:i]objectForKey:@"servicekind"];
                        dispatchpersonlmodel.outBoundNo = [[array objectAtIndex:i]objectForKey:@"outBoundNo"];
                            dispatchpersonlmodel.serviceadd = [[array objectAtIndex:i]objectForKey:@"serviceadd"];
                            dispatchpersonlmodel.servicething = [[array objectAtIndex:i]objectForKey:@"servicething"];
                            dispatchpersonlmodel.updatetime = [[array objectAtIndex:i]objectForKey:@"updatetime"];
                        [weakSelf.dispatchedPersonlArray addObject:dispatchpersonlmodel];
                    }
                }
                weakSelf.pageNum = 2;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)loadDispatchPersonlMoreNetworkData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.userName forKey:@"userName"];
    [dict setObject:self.startdate forKey:@"startdate"];
    [dict setObject:self.enddate forKey:@"enddate"];
    [dict setObject:self.serviceType forKey:@"serviceType"];
    [dict setObject:self.serviceStatus forKey:@"serviceStatus"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)self.pageNum] forKey:@"pageNum"];
    [dict setObject:[NSString stringWithFormat:@"10"] forKey:@"itemNum"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_FINDSERVICEITEM_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                if (array.count > 0) {
                    for (int i = 0; i < array.count; i++) {
                        RSDispatchPersonDataModel * dispatchpersonlmodel = [[RSDispatchPersonDataModel alloc]init];
                        dispatchpersonlmodel.dispatchPersonlId = [[array objectAtIndex:i]objectForKey:@"id"];
                        dispatchpersonlmodel.appointtime = [[array objectAtIndex:i]objectForKey:@"appointtime"];
                        dispatchpersonlmodel.status = [[[array objectAtIndex:i]objectForKey:@"status"] integerValue];
                        dispatchpersonlmodel.userId = [[array objectAtIndex:i]objectForKey:@"userId"];
                        dispatchpersonlmodel.user_name = [[array objectAtIndex:i]objectForKey:@"user_name"];
                        dispatchpersonlmodel.servicetype = [[array objectAtIndex:i]objectForKey:@"servicetype"];
                        dispatchpersonlmodel.comment = [[array objectAtIndex:i]objectForKey:@"comment"];
                        dispatchpersonlmodel.servicekind = [[array objectAtIndex:i]objectForKey:@"servicekind"];
                        dispatchpersonlmodel.outBoundNo = [[array objectAtIndex:i]objectForKey:@"outBoundNo"];
                            dispatchpersonlmodel.serviceadd = [[array objectAtIndex:i]objectForKey:@"serviceadd"];
                            dispatchpersonlmodel.servicething = [[array objectAtIndex:i]objectForKey:@"servicething"];
                            dispatchpersonlmodel.updatetime = [[array objectAtIndex:i]objectForKey:@"updatetime"];
                        
                        [weakSelf.dispatchedPersonlArray addObject:dispatchpersonlmodel];
                    }
                    weakSelf.pageNum++;
                    [weakSelf.tableview reloadData];
                    [weakSelf.tableview.mj_footer endRefreshing];
                }else{
                    [weakSelf.tableview.mj_footer endRefreshing];
                }
            }else{
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            //[weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}

//确定和重置
- (void)showChoiceMyServiceStyleStarTime:(NSString *)starTime andEndTime:(NSString *)endTime andApplicant:(NSString *)people andStatus:(NSString *)statusStr andServiceType:(NSString *)serviceType{
    self.pageNum = 2;
    self.startdate = starTime;
    self.enddate = endTime;
    self.userName = people;
    self.serviceStatus = statusStr;
    self.serviceType = serviceType;
    [self loadDispatchPersonlNetworkData];
    [_rightview hide];
}

#pragma mark -- 筛选按键
- (void)serviceScreenAction:(RSRightNavigationButton *)btn{
    //打开
    [_rightview switchMenu];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dispatchedPersonlArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 185;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * DISPATCHPERSONLID = @"DISPATCHPERSONLID";
    RSDispatchPersonlCell * cell = [tableView dequeueReusableCellWithIdentifier:DISPATCHPERSONLID];
    if (!cell) {
        cell = [[RSDispatchPersonlCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DISPATCHPERSONLID];
        
    }
    
    RSDispatchPersonDataModel * dispatchpersonlmodel = self.dispatchedPersonlArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //服务详情
    cell.dispatchPersonlDetailBtn.tag = 1000000000 + indexPath.row;
    //派遣服务人员，管理服务人员
    cell.dispatchPersonlmyServiceBtn.tag = 1000000000 + indexPath.row;
     [cell.dispatchPersonlmyServiceBtn addTarget:self action:@selector(dispatchPersonlserviceDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.dispatchPersonlDetailBtn setTitle:@"服务详情" forState:UIControlStateNormal];
    [cell.dispatchPersonlDetailBtn addTarget:self action:@selector(dispatchPersonlmodifyService:) forControlEvents:UIControlEventTouchUpInside];
    [cell.dispatchPersonlDetailBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    [cell.dispatchPersonlDetailBtn setBackgroundColor:[UIColor whiteColor]];
    // 服务状态 0->未受理， 1->已受理 ，2->派遣中， 3->进行中,4->取消服务，5->已完成，全部就传：-1
    if (dispatchpersonlmodel.status == 0) {
        [cell.dispatchPersonlServiceBtn setTitle:@"未受理" forState:UIControlStateNormal];
        [cell.dispatchPersonlServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
        
        //派遣服务人员，管理服务人员
        [cell.dispatchPersonlmyServiceBtn setTitle:@"派遣服务人员" forState:UIControlStateNormal];
        [cell.dispatchPersonlmyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        [cell.dispatchPersonlmyServiceBtn setBackgroundColor:[UIColor whiteColor]];
        cell.dispatchPersonlmyServiceBtn.enabled =YES;
        
    }else if (dispatchpersonlmodel.status == 1){
        [cell.dispatchPersonlServiceBtn setTitle:@"已受理" forState:UIControlStateNormal];
        [cell.dispatchPersonlServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FBCC81"]];
        
        //派遣服务人员，管理服务人员
        [cell.dispatchPersonlmyServiceBtn setTitle:@"更换服务人员" forState:UIControlStateNormal];
        [cell.dispatchPersonlmyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        [cell.dispatchPersonlmyServiceBtn setBackgroundColor:[UIColor whiteColor]];
        cell.dispatchPersonlmyServiceBtn.enabled =YES;
        
    }else if (dispatchpersonlmodel.status == 2){
        [cell.dispatchPersonlServiceBtn setTitle:@"派遣中" forState:UIControlStateNormal];
        [cell.dispatchPersonlServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        //派遣服务人员，管理服务人员
        [cell.dispatchPersonlmyServiceBtn setTitle:@"更换服务人员" forState:UIControlStateNormal];
//        cell.dispatchPersonlmyServiceBtn.enabled =NO;
//        [cell.dispatchPersonlmyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
//        [cell.dispatchPersonlmyServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
        
        
        [cell.dispatchPersonlmyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        [cell.dispatchPersonlmyServiceBtn setBackgroundColor:[UIColor whiteColor]];
        cell.dispatchPersonlmyServiceBtn.enabled =YES;
    }else if (dispatchpersonlmodel.status == 3){
        [cell.dispatchPersonlServiceBtn setTitle:@"进行中" forState:UIControlStateNormal];
        [cell.dispatchPersonlServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#B3E49A"]];
        //派遣服务人员，管理服务人员
        [cell.dispatchPersonlmyServiceBtn setTitle:@"更换服务人员" forState:UIControlStateNormal];
//        [cell.dispatchPersonlmyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
//        [cell.dispatchPersonlmyServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
//        cell.dispatchPersonlmyServiceBtn.enabled =NO;
        [cell.dispatchPersonlmyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        [cell.dispatchPersonlmyServiceBtn setBackgroundColor:[UIColor whiteColor]];
        cell.dispatchPersonlmyServiceBtn.enabled =YES;
        
    }else if (dispatchpersonlmodel.status == 4){
        [cell.dispatchPersonlServiceBtn setTitle:@"取消服务" forState:UIControlStateNormal];
        [cell.dispatchPersonlServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
        //派遣服务人员，管理服务人员
        [cell.dispatchPersonlmyServiceBtn setTitle:@"更换服务人员" forState:UIControlStateNormal];
        [cell.dispatchPersonlmyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [cell.dispatchPersonlmyServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
        cell.dispatchPersonlmyServiceBtn.enabled =NO;
    }else{
        [cell.dispatchPersonlServiceBtn setTitle:@"已完成" forState:UIControlStateNormal];
        [cell.dispatchPersonlServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        //派遣服务人员，管理服务人员
        [cell.dispatchPersonlmyServiceBtn setTitle:@"更换服务人员" forState:UIControlStateNormal];
        [cell.dispatchPersonlmyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        [cell.dispatchPersonlmyServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
        cell.dispatchPersonlmyServiceBtn.enabled =NO;
    }
    
    if ([dispatchpersonlmodel.servicetype isEqualToString:@"ckfw"]) {
        cell.dispatchPersonlImageView.image = [UIImage imageNamed:@"出库服务"];
        cell.dispatchPersonlLabel.text = @"出库服务";
        cell.dispatchPersonlOutLabel.text = [NSString stringWithFormat:@"出货单:%@",dispatchpersonlmodel.outBoundNo];
        
    }else{
        cell.dispatchPersonlImageView.image = [UIImage imageNamed:@"市场服务"];
        cell.dispatchPersonlLabel.text = @"市场服务";
        cell.dispatchPersonlOutLabel.text = [NSString stringWithFormat:@"类型:%@",dispatchpersonlmodel.servicekind];
    }
    cell.dispatchPersonlTimeLabel.text = [NSString stringWithFormat:@"预约时间:%@",dispatchpersonlmodel.appointtime];
    cell.dispatchPersonlShowLabel.text = [NSString stringWithFormat:@"商户:%@",dispatchpersonlmodel.user_name];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//服务详情
- (void)dispatchPersonlmodifyService:(UIButton *)btn{
    
    RSDispatchPersonDataModel * dispatchpersonlmodel = self.dispatchedPersonlArray[btn.tag - 1000000000];
    //self.hidesBottomBarWhenPushed = YES;
    if ([dispatchpersonlmodel.servicetype isEqualToString:@"ckfw"]) {
    //出库服务
        RSRecordDetailViewController * recordDetailVc = [[RSRecordDetailViewController alloc]init];
        recordDetailVc.usermodel = self.usermodel;
        recordDetailVc.outBoundNo = dispatchpersonlmodel.outBoundNo;
//        recordDetailVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:recordDetailVc animated:YES];
        
    }else{
        
    //市场服务
        RSServiceMarketViewController * serviceMarketVc = [[RSServiceMarketViewController alloc]init];
        serviceMarketVc.usermodel = self.usermodel;
        serviceMarketVc.serviceId = dispatchpersonlmodel.dispatchPersonlId;
        serviceMarketVc.type = dispatchpersonlmodel.servicetype;
        serviceMarketVc.search = @"0";
        serviceMarketVc.jumpStr = self.jumpStr;
//        serviceMarketVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:serviceMarketVc animated:YES];
    }
}

//派遣服务人员和管理服务人员
- (void)dispatchPersonlserviceDetails:(UIButton *)btn{
//    self.navigationController.navigationBar.userInteractionEnabled = NO;
//    self.navigationController.navigationBar.hidden = YES;
    UIView * menview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    menview.tag = btn.tag;
    menview.backgroundColor = [UIColor colorWithHexColorStr:@"#000000" alpha:0.5];
    [self.view addSubview:menview];
    [menview bringSubviewToFront:self.view];
    menview.userInteractionEnabled = YES;
    _menview = menview;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenDispatchPersonMenview)];
    [menview addGestureRecognizer:tap];
    
    UIView * choiceView = [[UIView alloc]initWithFrame:CGRectMake(29,(SCH/2)/2, SCW - (29+31), 277)];
    choiceView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    [menview addSubview:choiceView];
    choiceView.layer.cornerRadius = 5;
    choiceView.layer.masksToBounds = YES;
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(choiceView.frame), 58)];
    topView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [choiceView addSubview:topView];
    
    UILabel * topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 21,CGRectGetWidth(topView.frame) , CGRectGetHeight(topView.frame) - 42)];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.text = @"选择您需要派遣的人员";
    topLabel.font = [UIFont systemFontOfSize:16];
    topLabel.textColor = [UIColor colorWithHexColorStr:@"#616161"];
    [topView addSubview:topLabel];
    
    
    //中间View
    //CGRectGetHeight(choiceView.frame) - CGRectGetHeight(topView.frame) - 60
    HomeMenuView * homeview = [[HomeMenuView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + 1, CGRectGetWidth(choiceView.frame),170)];
    homeview.delegate = self;
    // 对自定义菜单view设置数据
    // menuView.menus = self.menus;
    
    
   // homeview.menus = @[@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一",@"王八一"];
    
    [choiceView addSubview:homeview];
    //CGRectGetHeight(choiceView.frame) - CGRectGetMaxY(homeview.frame) + 1
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(homeview.frame) + 1, CGRectGetWidth(choiceView.frame),48)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    [choiceView addSubview:bottomview];
    
    
    UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bottomview.frame)/2 - 0.5, CGRectGetHeight(bottomview.frame))];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
    [bottomview addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelChoiceServicePepole:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * bottomMidView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame), 0, 1,  CGRectGetHeight(bottomview.frame))];
    bottomMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    [bottomview addSubview:bottomMidView];
    
    
    UIButton * rightNowBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bottomMidView.frame), 0, CGRectGetWidth(bottomview.frame) - CGRectGetMaxX(bottomMidView.frame), CGRectGetHeight(bottomview.frame))];
    [rightNowBtn setTitle:@"立即派遣" forState:UIControlStateNormal];
    [rightNowBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    [rightNowBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
    [bottomview addSubview:rightNowBtn];
    [rightNowBtn addTarget:self action:@selector(rightRowServicePeople:) forControlEvents:UIControlEventTouchUpInside];
    
    [self dispatchFreeServicePersonnelServiceData:btn.tag - 1000000000 andHomeMenuView:homeview];
}


- (void)dispatchFreeServicePersonnelServiceData:(NSInteger)index andHomeMenuView:(HomeMenuView *) homeview{
    
    /**
     每页条数    itemNum    Int
     页数    pageNum    Int
     当前服务id    serviceId    String
     服务人员类别    userType    String
     */
    RSDispatchPersonDataModel * dispatchpersonlmodel = self.dispatchedPersonlArray[index];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:dispatchpersonlmodel.dispatchPersonlId forKey:@"serviceId"];
    [dict setObject:dispatchpersonlmodel.servicetype forKey:@"userType"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"pageNum"];
    [dict setObject:[NSString stringWithFormat:@"10000"] forKey:@"itemNum"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
   RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETFREESERVICCEUSER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [weakSelf.freeServicePeopleArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                if (array.count > 0) {
                    for ( int i = 0; i < array.count; i++) {
                        RSChoiceFreeServiceModel * choicefreeServicemodel = [[RSChoiceFreeServiceModel alloc]init];
                        choicefreeServicemodel.ID = [[array objectAtIndex:i]objectForKey:@"ID"];
                        choicefreeServicemodel.isChose = [[[array objectAtIndex:i]objectForKey:@"isChose"] boolValue];
                        choicefreeServicemodel.user_phone = [[array objectAtIndex:i]objectForKey:@"user_phone"];
                        choicefreeServicemodel.USER_NAME = [[array objectAtIndex:i]objectForKey:@"USER_NAME"];
                        choicefreeServicemodel.dispatchpersonlmodel = dispatchpersonlmodel;
                        [weakSelf.freeServicePeopleArray addObject:choicefreeServicemodel];
                    }
                    homeview.menus = weakSelf.freeServicePeopleArray;
                }else{
                    weakSelf.navigationController.navigationBar.hidden = NO;
                    weakSelf.navigationController.navigationBar.userInteractionEnabled = YES;
                    //[_menview removeFromSuperview];
                }
            }else{
                weakSelf.navigationController.navigationBar.hidden = NO;
                weakSelf.navigationController.navigationBar.userInteractionEnabled = YES;
                [_menview removeFromSuperview];
            }
        }else{
            weakSelf.navigationController.navigationBar.hidden = NO;
            weakSelf.navigationController.navigationBar.userInteractionEnabled = YES;
            [_menview removeFromSuperview];
        }
    }];
}




//FIXME:立即派遣服务人员
- (void)rightRowServicePeople:(UIButton *)btn{

   
    
    btn.tag = _menview.tag;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    self.navigationController.navigationBar.hidden = NO;
    RSDispatchPersonDataModel * dispatchpersonlmodel = self.dispatchedPersonlArray[ btn.tag- 1000000000];
    
    //self.saveFreeServicePeopleArray
    
    //URL_SHARESERVICE_IOS
    
    /**
     货主Id    sendUserId    String
     //后台人员Id    //shareId    //String
     分配给服务人员    serviceUsers    String[]    这是一个数组集合详情如下
     服务种类    serviceKing    String
     指定时间    appointTime    String    预约时间
     地址    address    String
     serviceUsers[] : [0]:服务者Id， [1]:服务Id ，[2]:服务人员手机号，
     [3]:服务人员名字
     */
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:dispatchpersonlmodel.userId forKey:@"sendUserId"];
    [dict setObject:dispatchpersonlmodel.servicekind forKey:@"serviceKing"];
    [dict setObject:dispatchpersonlmodel.appointtime forKey:@"appointTime"];
    [dict setObject:dispatchpersonlmodel.serviceadd forKey:@"address"];
    [dict setObject:self.saveFreeServicePeopleArray forKey:@"serviceUsers"];
    [dict setObject:dispatchpersonlmodel.dispatchPersonlId forKey:@"serviceId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SHARESERVICE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [weakSelf loadDispatchPersonlNetworkData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"派遣服务人员失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"派遣服务人员失败"];
        }
    }];
     [self.saveFreeServicePeopleArray removeAllObjects];
    
    [_menview removeFromSuperview];
    
}


//FIXME:取消派遣服务人员
- (void)cancelChoiceServicePepole:(UIButton *)btn{
    [self.saveFreeServicePeopleArray removeAllObjects];
    [_menview removeFromSuperview];
}



- (void)hiddenDispatchPersonMenview{
     [self.saveFreeServicePeopleArray removeAllObjects];
    [_menview removeFromSuperview];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     [self.saveFreeServicePeopleArray removeAllObjects];
    [_menview removeFromSuperview];
}


- (void)selectArray:(NSMutableArray *)selectArray{
    [self.saveFreeServicePeopleArray removeAllObjects];
    for (int i = 0; i < selectArray.count; i++) {
        RSChoiceFreeServiceModel * choicefreeservicemodel = selectArray[i];
        NSString * temp = [NSString stringWithFormat:@"%@,%@,%@,%@",choicefreeservicemodel.ID,choicefreeservicemodel.dispatchpersonlmodel.dispatchPersonlId,choicefreeservicemodel.user_phone,choicefreeservicemodel.USER_NAME];
        [self.saveFreeServicePeopleArray addObject:temp];
    }
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
