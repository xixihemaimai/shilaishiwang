//
//  RSServiceMyServiceController.m
//  石来石往
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServiceMyServiceController.h"
#import "RSMyServiceCell.h"
#import "RSMyServiceCompleteCell.h"

//服务评价
#import "RSServiceEvaluationViewController.h"

//模型
#import "RSMyServiceModel.h"
#import "RSServicePepleModel.h"

//出库服务
#import "RSStorehouseDetailsViewController.h"
//市场服务
#import "RSServiceMarketViewController.h"

//查看评价
#import "RSAlreadyEvaluatedViewController.h"

//服务人员控制器
#import "RSServicePeopleDetailViewController.h"



#import "RSRecordDetailViewController.h"

#import "RSDispatchedPersonnelViewController.h"


@interface RSServiceMyServiceController ()

{
    
    //未完成按键
    UIButton * _incompleteBtn;
    //已完成按键
    UIButton * _completeBtn;
    
    //未完成下面的下划线
    UIView * _inView;
    //已完成下面的下划线
    UIView * _completeView;
    
    
    
    //用来判断是未完成的按键还是已完成的按键
    NSString * temp;
    //蒙版
    //UIView * _menview;
    
    
    
    
    
}
//@property (nonatomic,strong)UITableView * tableview;




// 用来存放Cell的唯一标示符未完成
//@property (nonatomic, strong) NSMutableDictionary *cellNoCompelteDic;

//用来存放已完成Cell唯一标示已完成
//@property (nonatomic, strong) NSMutableDictionary *cellCompeletDic;


/**
 *按钮选中中间值
 */
@property(nonatomic,strong)UIButton * selectedBtn;


/**获取我的服务的列表的数组*/
@property (nonatomic,strong)NSMutableArray * serviceArray;


/**用来保存服务人员列表的数组*/
@property (nonatomic,strong)NSMutableArray * servicePepoleArray;


@end

@implementation RSServiceMyServiceController
- (NSMutableArray *)serviceArray{
    if (_serviceArray == nil) {
        _serviceArray = [NSMutableArray array];
    }
    return _serviceArray;
}

- (NSMutableArray *)servicePepoleArray{
    if (_servicePepoleArray == nil) {
        _servicePepoleArray = [NSMutableArray array];
    }
    return _servicePepoleArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
    //去除导航栏下方的横线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    
    self.title = @"我的服务";
    temp = @"";
    
    [self isAddjust];
    [self.view addSubview:self.tableview];
    [self roalNetWorkNoCompleteAndCompleteData:temp];
    
   
   
    //总的界面
//    CGFloat Y = 0.0;
//    CGFloat bottomH = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//        bottomH = 34;
//    }else{
//        Y = 64;
//        bottomH = 0.0;
//    }
//
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;

    //这边要添加一个视图
    UIView * choiceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 40)];
    choiceView.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
    choiceView.layer.borderWidth = 1;
    choiceView.backgroundColor = [UIColor whiteColor];
      [self.view addSubview:choiceView];
    
    UIButton * incompleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (SCW/2) - 0.5, 38)];
    [incompleteBtn setTitle:@"未完结" forState:UIControlStateNormal];
    [incompleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
    incompleteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [choiceView addSubview:incompleteBtn];
    
    incompleteBtn.tag = 1000000001;
    [incompleteBtn addTarget:self action:@selector(choiceServiceStyle:) forControlEvents:UIControlEventTouchUpInside];
    
    _incompleteBtn = incompleteBtn;
    
    //分隔线
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(incompleteBtn.frame), 6, 1, 28)];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#D6D6D6"];
    [choiceView addSubview:midView];
    
    UIButton * completeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midView.frame), 0, (SCW/2) - 0.5, 38)];
    [completeBtn setTitle:@"已完结" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#313131"] forState:UIControlStateNormal];
    completeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [choiceView addSubview:completeBtn];
    
    completeBtn.tag = 1000000002;
    [completeBtn addTarget:self action:@selector(choiceServiceStyle:) forControlEvents:UIControlEventTouchUpInside];
    
    _completeBtn = completeBtn;
    UIView * inView = [[UIView alloc]init];
    inView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    CGFloat lineViewH = 1;
    
    inView.yj_height = lineViewH;
    inView.yj_y = CGRectGetMaxY(incompleteBtn.frame);
    inView.yj_width = 60;
    inView.yj_centerX = incompleteBtn.yj_centerX;
    [inView sizeToFit];
    // 设置下划线的宽度比文本内容宽度大10
    [choiceView addSubview:inView];
    inView.hidden = NO;
    _inView = inView;
    
    UIView * completeView = [[UIView alloc]init];
    
    completeView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    completeView.yj_height = lineViewH;
    completeView.yj_y = CGRectGetMaxY(completeBtn.frame);
    completeView.yj_width = 60;
    completeView.yj_centerX = completeBtn.yj_centerX;
    [completeView sizeToFit];
    // 设置下划线的宽度比文本内容宽度大10
    [choiceView addSubview:completeView];
    completeView.hidden = YES;
    
    _completeView = completeView;
    
    
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(choiceView.frame), SCW, SCH - CGRectGetMaxY(choiceView.frame) - Height_NavBar);
    
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(choiceView.frame), SCW, SCH - CGRectGetMaxY(choiceView.frame)) style:UITableViewStylePlain];
//
//    self.tableview = tableview;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
//    self.tableview.showsHorizontalScrollIndicator = NO;
//    self.tableview.showsVerticalScrollIndicator = NO;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    [self.view addSubview:self.tableview];
//
   
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf roalNetWorkNoCompleteAndCompleteData:temp];
//    }];
//
    RSWeakself
    //向下刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf roalNetWorkNoCompleteAndCompleteData:temp];
    }];
    
    
    
    
//    UIView * menview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
//    menview.backgroundColor = [UIColor colorWithHexColorStr:@"#000000" alpha:0.5];
//    [self.view addSubview:menview];
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiheMenView:)];
//    menview.userInteractionEnabled = YES;
//    [menview addGestureRecognizer:tap];
//
//    [menview bringSubviewToFront:self.view];
//    _menview = menview;
//    _menview.hidden = YES;
//    UIView * centerView = [[UIView alloc]initWithFrame:CGRectMake(24, (SCH/2) - 80, SCW - 48, 160)];
//    centerView.backgroundColor = [UIColor whiteColor];
//    [menview addSubview:centerView];
//
//
//    UIImageView * centerImageview = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 - 40, (SCH/2) - 120, 80, 80)];
//    centerImageview.backgroundColor = [UIColor clearColor];
//    centerImageview.image = [UIImage imageNamed:@"服务完成"];
//    centerImageview.layer.cornerRadius = centerImageview.yj_width * 0.5;
//    centerImageview.layer.masksToBounds = YES;
//    [menview addSubview:centerImageview];
//
//    UILabel * centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, centerView.yj_width, 18)];
//    centerLabel.text = @"服务完成";
//    centerLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    centerLabel.font = [UIFont systemFontOfSize:18];
//    centerLabel.textAlignment = NSTextAlignmentCenter;
//    [centerView addSubview:centerLabel];
//
//    UILabel * serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(centerLabel.frame) + 10, centerView.yj_width, 15)];
//    serviceLabel.text = @"服务人员已完成当前服务";
//    serviceLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//    serviceLabel.font = [UIFont systemFontOfSize:15];
//    serviceLabel.textAlignment = NSTextAlignmentCenter;
//    [centerView addSubview:serviceLabel];
//
//    UIView * serviceFengView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(serviceLabel.frame) + 15, centerView.yj_width, 1)];
//    serviceFengView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
//    [centerView addSubview:serviceFengView];
//
//
//    UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(serviceFengView.frame),(centerView.yj_width/2) - 1, centerView.yj_height - CGRectGetMaxY(serviceFengView.frame))];
//    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
//    [cancelBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
//    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [centerView addSubview:cancelBtn];
//    [cancelBtn addTarget:self action:@selector(cancelChoiceAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    UIView * midCenterView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(serviceFengView.frame), 1, cancelBtn.yj_height)];
//    midCenterView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
//    [centerView addSubview:midCenterView];
//
//
//    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midCenterView.frame),CGRectGetMaxY(serviceFengView.frame), centerView.yj_width - cancelBtn.yj_width - midCenterView.yj_width, centerView.yj_height - CGRectGetMaxY(serviceFengView.frame))];
//    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
//    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [centerView addSubview:sureBtn];
//    [sureBtn addTarget:self action:@selector(sureChoiceAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
   
    
    
    
}


////FIXME:隐藏蒙版
//- (void)hiheMenView:(UITapGestureRecognizer *)tap{
//    _menview.hidden = YES;
//    self.navigationController.navigationBar.userInteractionEnabled = YES;
//}

//FIXME:我的服务（未完成和已完成的列表）
- (void)roalNetWorkNoCompleteAndCompleteData:(NSString *)currentTitle{
    
    
    //当前用户Id    userId    String
    //服务状态    status    String    传status= 5 已完结，未完结可以不传
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    if ([currentTitle isEqualToString:@""]) {
        //[dict setObject:[NSNull null] forKey:@"status"];
    }else{
        [dict setObject:currentTitle forKey:@"status"];
    }
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
     NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SERVICESEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [weakSelf.serviceArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                if (array.count > 0) {
                    for (int i = 0; i < array.count; i++) {
                        RSMyServiceModel * myservicemodel = [[RSMyServiceModel alloc]init];
                        myservicemodel.outBoundNo = [[array objectAtIndex:i]objectForKey:@"outBoundNo"];
                        myservicemodel.serviceThing = [[array objectAtIndex:i]objectForKey:@"serviceThing"];
                        myservicemodel.serviceType = [[array objectAtIndex:i]objectForKey:@"serviceType"];
                        myservicemodel.status = [[array objectAtIndex:i]objectForKey:@"status"];
                        myservicemodel.appointTime = [[array objectAtIndex:i]objectForKey:@"appointTime"];
                        myservicemodel.serviceId = [[array objectAtIndex:i]objectForKey:@"serviceId"];
                        myservicemodel.serviceKind = [[array objectAtIndex:i]objectForKey:@"serviceKind"];
                        myservicemodel.serviceComment = [[array objectAtIndex:i]objectForKey:@"serviceComment"];
                        myservicemodel.starLevel = [[[array objectAtIndex:i]objectForKey:@"starLevel"] integerValue];
                        [weakSelf.serviceArray addObject:myservicemodel];
                    }
                    [weakSelf.tableview reloadData];
                    [weakSelf.tableview.mj_header endRefreshing];
                }else{
                    [weakSelf.tableview reloadData];
                    [weakSelf.tableview.mj_header endRefreshing];
                }
            }else{
                 [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
             [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}






//- (void)jumpDispatchedPersonnelViewController{
//    RSDispatchedPersonnelViewController * dispatchedPersonlVc = [[RSDispatchedPersonnelViewController alloc]init];
//    dispatchedPersonlVc.usermodel = self.usermodel;
//    [self.navigationController pushViewController:dispatchedPersonlVc animated:YES];
//}



//FIXME:取消
//- (void)cancelChoiceAction:(UIButton *)btn{
//    _menview.hidden = YES;
//    self.navigationController.navigationBar.userInteractionEnabled = YES;
//}
//FIXME:确定
//- (void)sureChoiceAction:(UIButton *)btn{
//     btn.tag = _menview.tag;
//     NSIndexPath * indexpath = [NSIndexPath indexPathForRow:btn.tag - 1000000000 inSection:0];
//     [self completeServiceLoadData:indexpath];
//    _menview.hidden = YES;
//    self.navigationController.navigationBar.userInteractionEnabled = YES;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.serviceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([temp isEqualToString:@""]) {
        
        
//        NSString *identifier = [_cellNoCompelteDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
//        if (identifier == nil) {
//            identifier = [NSString stringWithFormat:@"%@%@", @"MYSERVICEID", [NSString stringWithFormat:@"%@", indexPath]];
//            [_cellNoCompelteDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
//            // 注册Cell
//
//        }
        
        static NSString * MYSERVICEID = @"MYSERVICEID";
        RSMyServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:MYSERVICEID];
        if (!cell) {
            cell = [[RSMyServiceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MYSERVICEID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //修改服务
         cell.myModifyServiceBtn.tag = 1000000000 + indexPath.row;
        [cell.myModifyServiceBtn addTarget:self action:@selector(modifyService:) forControlEvents:UIControlEventTouchUpInside];
        //取消服务
        cell.myCancelServiceBtn.tag = 1000000000 + indexPath.row;
        [cell.myCancelServiceBtn addTarget:self action:@selector(cancelService:) forControlEvents:UIControlEventTouchUpInside];
        //服务详情
        cell.myServiceDetailBtn.tag = 1000000000 + indexPath.row;
        [cell.myServiceDetailBtn addTarget:self action:@selector(serviceDetails:) forControlEvents:UIControlEventTouchUpInside];
        
        RSMyServiceModel * myservicemodel = self.serviceArray[indexPath.row];
        
        
        if ([myservicemodel.serviceType isEqualToString:@"出库服务"]) {
            cell.myImageView.image = [UIImage imageNamed:@"出库服务"];
            cell.myServiceLabel.text = @"出库服务";
            cell.myServiceOutLabel.text = [NSString stringWithFormat:@"出库单:%@",myservicemodel.outBoundNo];
            
        }else{
            cell.myImageView.image = [UIImage imageNamed:@"市场服务"];
            cell.myServiceLabel.text = @"市场服务";
            cell.myServiceOutLabel.text = [NSString stringWithFormat:@"类型:%@",myservicemodel.serviceKind];
        }
        cell.myServiceTimeLabel.text = [NSString stringWithFormat:@"预约时间:%@",myservicemodel.appointTime];
        //cell.myServiceTimeLabel.text = [NSDate date];
        if ([myservicemodel.status isEqualToString:@"未受理"]) {
            [cell.myServiceBtn setTitle:@"未受理" forState:UIControlStateNormal];
             [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
            cell.myCancelServiceBtn.enabled = YES;
            [cell.myCancelServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
            [cell.myCancelServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
            [cell.myCancelServiceBtn setTitle:@"取消服务" forState:UIControlStateNormal];
            
            if ([myservicemodel.serviceType isEqualToString:@"出库服务"]) {
                 [cell.myModifyServiceBtn setTitle:@"修改服务" forState:UIControlStateNormal];
                cell.myModifyServiceBtn.enabled = NO;
                [cell.myModifyServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f9f9f9"]];
                [cell.myModifyServiceBtn setTitleColor:[UIColor colorWithRed:210/255.0 green:209/255.0 blue:206/255.0 alpha:1.0] forState:UIControlStateNormal];
            }else{
                cell.myModifyServiceBtn.enabled = YES;
                 [cell.myModifyServiceBtn setTitle:@"修改服务" forState:UIControlStateNormal];
                [cell.myModifyServiceBtn setBackgroundColor:[UIColor whiteColor]]; [cell.myModifyServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
            }
        }else if ([myservicemodel.status isEqualToString:@"已受理"]){
            
            [cell.myServiceBtn setTitle:@"已受理" forState:UIControlStateNormal];
            [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FBCC81"]];
            cell.myCancelServiceBtn.enabled = NO;
            [cell.myCancelServiceBtn setTitleColor:[UIColor colorWithRed:210/255.0 green:209/255.0 blue:206/255.0 alpha:1.0] forState:UIControlStateNormal];
            [cell.myCancelServiceBtn setTitle:@"取消服务" forState:UIControlStateNormal];
            [cell.myCancelServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
            [cell.myModifyServiceBtn setTitle:@"服务人员" forState:UIControlStateNormal];
            [cell.myCancelServiceBtn setTitleColor:[UIColor colorWithRed:210/255.0 green:209/255.0 blue:206/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            cell.myModifyServiceBtn.enabled = YES;
            
        }else if ([myservicemodel.status isEqualToString:@"派遣中"]){
            [cell.myServiceBtn setTitle:@"派遣中" forState:UIControlStateNormal];
            [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
            cell.myCancelServiceBtn.enabled = NO;
            [cell.myCancelServiceBtn setTitle:@"取消服务" forState:UIControlStateNormal];
            [cell.myModifyServiceBtn setTitle:@"服务人员" forState:UIControlStateNormal];
            [cell.myCancelServiceBtn setTitleColor:[UIColor colorWithRed:210/255.0 green:209/255.0 blue:206/255.0 alpha:1.0] forState:UIControlStateNormal];
            cell.myModifyServiceBtn.enabled = YES;
            [cell.myCancelServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        }else{
            [cell.myServiceBtn setTitle:@"进行中" forState:UIControlStateNormal];
            [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#B3E49A"]];
           
            
            cell.myModifyServiceBtn.enabled = YES;
            
//            [cell.myCancelServiceBtn setTitle:@"完成服务" forState:UIControlStateNormal];
//            cell.myCancelServiceBtn.enabled = YES;
//            [cell.myCancelServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
            
            
            [cell.myCancelServiceBtn setTitle:@"服务执行" forState:UIControlStateNormal];
            cell.myCancelServiceBtn.enabled = NO;
            [cell.myCancelServiceBtn setTitleColor:[UIColor colorWithRed:210/255.0 green:209/255.0 blue:206/255.0 alpha:1.0] forState:UIControlStateNormal];
            [cell.myCancelServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
            [cell.myModifyServiceBtn setTitle:@"服务人员" forState:UIControlStateNormal];
            [cell.myCancelServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        }
        return cell;
    }else{
        
        
//        NSString *identifier = [_cellCompeletDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
//        if (identifier == nil) {
//            identifier = [NSString stringWithFormat:@"%@%@", @"MYSERVICEIDCOMPLETE", [NSString stringWithFormat:@"%@", indexPath]];
//            [_cellCompeletDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
//            // 注册Cell
//
//        }
        
        
        
        static NSString * MYSERVICEIDCOMPLETE = @"MYSERVICEIDCOMPLETE";
        
        RSMyServiceCompleteCell * cell = [tableView dequeueReusableCellWithIdentifier:MYSERVICEIDCOMPLETE];
        if (!cell) {
            cell = [[RSMyServiceCompleteCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MYSERVICEIDCOMPLETE];
        }
        //服务评价
        cell.myModifyCompleteServiceBtn.tag = 1000000000 + indexPath.row;
        [cell.myModifyCompleteServiceBtn addTarget:self action:@selector(serviceEvaluation:) forControlEvents:UIControlEventTouchUpInside];
        //服务人员
        cell.myServicePeopleBtn.tag = 1000000000 + indexPath.row;
        [cell.myServicePeopleBtn addTarget:self action:@selector(servicePeople:) forControlEvents:UIControlEventTouchUpInside];
        //服务详情
        cell.myServiceCompleteDetailBtn.tag = 1000000000 + indexPath.row;
        [cell.myServiceCompleteDetailBtn addTarget:self action:@selector(completeServiceDetail:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        RSMyServiceModel * myservicemodel = self.serviceArray[indexPath.row];
        if ([myservicemodel.serviceType isEqualToString:@"出库服务"]) {
            cell.myCompleteImageView.image = [UIImage imageNamed:@"出库服务"];
            cell.myServiceCompleteLabel.text = @"出库服务";
            cell.myServiceCompleteOutLabel.text = [NSString stringWithFormat:@"出库单:%@",myservicemodel.outBoundNo];
           
        }else{
            cell.myCompleteImageView.image = [UIImage imageNamed:@"市场服务"];
            cell.myServiceCompleteLabel.text = @"市场服务";
           
            cell.myServiceCompleteOutLabel.text = [NSString stringWithFormat:@"类型:%@",myservicemodel.serviceKind];
            
        }
        cell.myServiceCompleteTimeLabel.text = [NSString stringWithFormat:@"预约时间:%@",myservicemodel.appointTime];
        if (myservicemodel.starLevel > 0 ) {
             [cell.myModifyCompleteServiceBtn setTitle:@"查看评价" forState:UIControlStateNormal];
        }else{
             [cell.myModifyCompleteServiceBtn setTitle:@"服务评价" forState:UIControlStateNormal];
        }
        
        if ([myservicemodel.status isEqualToString:@"已取消"]) {
            cell.myModifyCompleteServiceBtn.enabled = NO;
            cell.myServicePeopleBtn.enabled = NO;
            cell.myServiceCompleteDetailBtn.enabled = NO;
            [cell.myModifyCompleteServiceBtn setTitleColor:[UIColor colorWithRed:210/255.0 green:209/255.0 blue:206/255.0 alpha:1.0] forState:UIControlStateNormal];
            [cell.myModifyCompleteServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
            [cell.myServicePeopleBtn setTitleColor:[UIColor colorWithRed:210/255.0 green:209/255.0 blue:206/255.0 alpha:1.0] forState:UIControlStateNormal];
            [cell.myServicePeopleBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
            [cell.myServiceCompleteDetailBtn setTitleColor:[UIColor colorWithRed:210/255.0 green:209/255.0 blue:206/255.0 alpha:1.0] forState:UIControlStateNormal];
            [cell.myServiceCompleteDetailBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        }else{
            
            cell.myModifyCompleteServiceBtn.enabled = YES;
            cell.myServicePeopleBtn.enabled = YES;
            cell.myServiceCompleteDetailBtn.enabled = YES;
            [cell.myModifyCompleteServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
            [cell.myModifyCompleteServiceBtn setBackgroundColor:[UIColor whiteColor]];
            [cell.myServicePeopleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
            [cell.myServicePeopleBtn setBackgroundColor:[UIColor whiteColor]];
            [cell.myServiceCompleteDetailBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
            [cell.myServiceCompleteDetailBtn setBackgroundColor:[UIColor whiteColor]];
        }
        return cell;
    }
}


//FIXME:服务详情
- (void)serviceDetails:(UIButton *)btn{
    RSMyServiceModel * myservicemodel = self.serviceArray[btn.tag - 1000000000];
    if ([myservicemodel.serviceType isEqualToString:@"出库服务"] ) {
        //出库服务
//        RSStorehouseDetailsViewController * storeHouseDetailVc = [[RSStorehouseDetailsViewController alloc]init];
//        storeHouseDetailVc.usermodel = self.usermodel;
//        storeHouseDetailVc.serviceId = myservicemodel.serviceId;
//        storeHouseDetailVc.type = @"ckfw";
//        storeHouseDetailVc.search = @"0";
//        [self.navigationController pushViewController:storeHouseDetailVc animated:YES];
        
        RSRecordDetailViewController * recordDetailVc = [[RSRecordDetailViewController alloc]init];
        recordDetailVc.usermodel = self.usermodel;
        recordDetailVc.outBoundNo = myservicemodel.outBoundNo;
        [self.navigationController pushViewController:recordDetailVc animated:YES];
        
    }else{
        
        //市场服务
        [SVProgressHUD showWithStatus:@"加载市场服务内容,请等待........"];
        RSServiceMarketViewController * serviceMarketVc = [[RSServiceMarketViewController alloc]init];
        serviceMarketVc.usermodel = self.usermodel;
        serviceMarketVc.serviceId = myservicemodel.serviceId;
        serviceMarketVc.type = @"scfw";
        serviceMarketVc.search = @"0";
        serviceMarketVc.jumpStr = self.jumpStr;
        [self.navigationController pushViewController:serviceMarketVc animated:YES];
        
    }
}

//FIXME:已完成服务人员
- (void)servicePeople:(UIButton *)btn{
    //服务人员
    RSMyServiceModel * myservicemodel = self.serviceArray[btn.tag - 1000000000];
    NSString * type = [NSString string];
    if ([myservicemodel.serviceType isEqualToString:@"出库服务"]) {
        type = @"ckfw";
    }else{
        type = @"scfw";
    }
    RSServicePeopleDetailViewController * servicePeopleDetailVc = [[RSServicePeopleDetailViewController alloc]init];
    servicePeopleDetailVc.usermodel = self.usermodel;
    servicePeopleDetailVc.type = type;
    servicePeopleDetailVc.serviceId = myservicemodel.serviceId;
    [self.navigationController pushViewController:servicePeopleDetailVc animated:YES];
}
//FIXME:已完成的服务详情
- (void)completeServiceDetail:(UIButton *)btn{
    RSMyServiceModel * myservicemodel = self.serviceArray[btn.tag - 1000000000];
    if ([myservicemodel.serviceType isEqualToString:@"出库服务"] ) {
        //出库服务
//        RSStorehouseDetailsViewController * storeHouseDetailVc = [[RSStorehouseDetailsViewController alloc]init];
//        storeHouseDetailVc.usermodel = self.usermodel;
//        storeHouseDetailVc.serviceId = myservicemodel.serviceId;
//        storeHouseDetailVc.type = @"ckfw";
//        storeHouseDetailVc.search = @"0";
//        [self.navigationController pushViewController:storeHouseDetailVc animated:YES];
        
        
        
        RSRecordDetailViewController * recordDetailVc = [[RSRecordDetailViewController alloc]init];
        recordDetailVc.usermodel = self.usermodel;
        recordDetailVc.outBoundNo = myservicemodel.outBoundNo;
        [self.navigationController pushViewController:recordDetailVc animated:YES];
        
        
    }else{
        //市场服务
        
        
        
         [SVProgressHUD showWithStatus:@"加载市场服务内容,请等待........"];
        
        
        RSServiceMarketViewController * serviceMarketVc = [[RSServiceMarketViewController alloc]init];
        serviceMarketVc.usermodel = self.usermodel;
        serviceMarketVc.serviceId = myservicemodel.serviceId;
        serviceMarketVc.type = @"scfw";
        serviceMarketVc.search = @"0";
        
        serviceMarketVc.modifyStatusStr = @"0";
        serviceMarketVc.jumpStr = self.jumpStr;
        [self.navigationController pushViewController:serviceMarketVc animated:YES];
    }
}




//FIXME:服务评价和查看评价
- (void)serviceEvaluation:(UIButton *)btn{    
     RSMyServiceModel * myservicemodel = self.serviceArray[btn.tag - 1000000000];
    NSString * type = [NSString string];
    if ([myservicemodel.serviceType isEqualToString:@"出库服务"]) {
        type = @"ckfw";
    }else{
        type = @"scfw";
    }

    if ([btn.currentTitle isEqualToString:@"服务评价"]) {
        //服务评价
        RSServiceEvaluationViewController * serviceEvaluationVc = [[RSServiceEvaluationViewController alloc]init];
        serviceEvaluationVc.usermodel = self.usermodel;
        serviceEvaluationVc.type = type;
        serviceEvaluationVc.serviceId = myservicemodel.serviceId;
        RSWeakself
        serviceEvaluationVc.completesubmit = ^{
            [weakSelf roalNetWorkNoCompleteAndCompleteData:temp];
        };
        [self.navigationController pushViewController:serviceEvaluationVc animated:YES];
    }else{
        //查看评价
        RSAlreadyEvaluatedViewController * alreadEvaluatedVc = [[RSAlreadyEvaluatedViewController alloc]init];
        alreadEvaluatedVc.usermodel = self.usermodel;
        alreadEvaluatedVc.serviceId = myservicemodel.serviceId;
        [self.navigationController pushViewController:alreadEvaluatedVc animated:YES];
    }
}

//FIXME:修改服务和服务人员
- (void)modifyService:(UIButton *)btn{
    RSMyServiceModel * myservicemodel = self.serviceArray[btn.tag - 1000000000];
    if ([btn.currentTitle isEqualToString:@"修改服务"]) {
        
        
         [SVProgressHUD showWithStatus:@"加载市场服务内容,请等待........"];
        
        //修改服务
        RSServiceMarketViewController * serviceMarketVc = [[RSServiceMarketViewController alloc]init];
        serviceMarketVc.usermodel = self.usermodel;
        serviceMarketVc.serviceId = myservicemodel.serviceId;
        serviceMarketVc.type = @"scfw";
        serviceMarketVc.search = @"0";
        serviceMarketVc.modifyStatusStr = @"1";
        
        //用来判断从那边界面跳转过去的
        serviceMarketVc.jumpStr = self.jumpStr;
        [self.navigationController pushViewController:serviceMarketVc animated:YES];
        
        
    }else{
        //服务人员
        NSString * type = [NSString string];
        if ([myservicemodel.serviceType isEqualToString:@"出库服务"]) {
            type = @"ckfw";
        }else{
            type = @"scfw";
        }
        RSServicePeopleDetailViewController * servicePeopleDetailVc = [[RSServicePeopleDetailViewController alloc]init];
        servicePeopleDetailVc.usermodel = self.usermodel;
        servicePeopleDetailVc.type = type;
        servicePeopleDetailVc.serviceId = myservicemodel.serviceId;
        [self.navigationController pushViewController:servicePeopleDetailVc animated:YES];
    }
}

//FIXME:取消服务和服务完成
- (void)cancelService:(UIButton *)btn{
    
//    if ([temp isEqualToString:@""]) {
//        _menview.hidden = NO;
//    }
    if ([btn.currentTitle isEqualToString:@"取消服务"]){
        //这边加一个确定与否
        RSWeakself
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确实取消服务吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //取消服务
            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:btn.tag - 1000000000 inSection:0];
            [weakSelf cancalServiceloadDataIndex:indexpath];
            
        }];
        [alert addAction:action1];
        UIAlertAction  * action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action2];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            
            alert.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alert animated:YES completion:nil];
        
      
    }
//    else{
//        //服务完成
//        _menview.hidden = NO;
//        self.navigationController.navigationBar.userInteractionEnabled = NO;
//        _menview.tag = btn.tag;
//
//    }
}


//服务完成的网络请求
//- (void)completeServiceLoadData:(NSIndexPath *)indexpath{
//    RSMyServiceModel * myservicemodel = self.serviceArray[indexpath.row];
//    NSString * serviceStyle = [NSString string];
//    if ([myservicemodel.serviceType isEqualToString:@"出库服务"]) {
//        serviceStyle = @"ckfw";
//    }else{
//        serviceStyle = @"scfw";
//    }
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    [dict setObject:self.usermodel.userID forKey:@"userId"];
//    [dict setObject:myservicemodel.serviceId forKey:@"serviceId"];
//    [dict setObject:serviceStyle forKey:@"type"];
//    [dict setObject:@"3" forKey:@"search"];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":ERPID};
//    RSWeakself
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_SERVICESEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//             BOOL Result = [json[@"Result"]boolValue];
//            if (Result) {
//                [weakSelf roalNetWorkNoCompleteAndCompleteData:temp];
//                //这边要跳转到评价的页面
//                //服务评价
//                RSServiceEvaluationViewController * serviceEvaluationVc = [[RSServiceEvaluationViewController alloc]init];
//                serviceEvaluationVc.usermodel = self.usermodel;
//                serviceEvaluationVc.type = serviceStyle;
//                serviceEvaluationVc.serviceId = myservicemodel.serviceId;
//                serviceEvaluationVc.completesubmit = ^{
//                    [weakSelf roalNetWorkNoCompleteAndCompleteData:temp];
//                };
//                [self.navigationController pushViewController:serviceEvaluationVc animated:YES];
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"服务完成失败"];
//            }
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"服务完成失败"];
//        }
//    }];
//}

//取消服务的网络请求
- (void)cancalServiceloadDataIndex:(NSIndexPath *)indexpath{
    RSMyServiceModel * myservicemodel = self.serviceArray[indexpath.row];
    NSString * serviceStyle = [NSString string];
    if ([myservicemodel.serviceType isEqualToString:@"出库服务"]) {
        serviceStyle = @"ckfw";
    }else{
        serviceStyle = @"scfw";
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    [dict setObject:myservicemodel.serviceId forKey:@"serviceId"];
    [dict setObject:serviceStyle forKey:@"type"];
    [dict setObject:@"2" forKey:@"search"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SERVICESEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [SVProgressHUD showSuccessWithStatus:@"取消成功"];
                [weakSelf roalNetWorkNoCompleteAndCompleteData:temp];
            }else{
                [SVProgressHUD showErrorWithStatus:@"取消失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"取消失败"];
        }
    }];
}

//FIXME:按键的选择的方式
- (void)choiceServiceStyle:(UIButton *)btn{
     if(btn != self.selectedBtn){
     self.selectedBtn.selected = NO ;
     btn.selected = YES ;
     self.selectedBtn = btn;
     //temp = btn.currentTitle;
         if (btn.tag == 1000000001) {
             [_incompleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
             _inView.hidden = NO;
             _completeView.hidden = YES;
             [_completeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#313131"] forState:UIControlStateNormal];
             temp = @"";
             [self roalNetWorkNoCompleteAndCompleteData:temp];
         }else{
             [_completeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
             _inView.hidden = YES;
             _completeView.hidden = NO;
             [_incompleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#313131"] forState:UIControlStateNormal];
             temp = @"5";
             [self roalNetWorkNoCompleteAndCompleteData:temp];
         }
     } else {
     self.selectedBtn.selected  =  YES ;
     }
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
