//
//  RSServiceLibraryViewController.m
//  石来石往
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServiceLibraryViewController.h"
#import "RSServiceLibraryCell.h"

#import "RSLibraryModel.h"

//#import "CustomMyPickerView.h"

#import "RSRecordDetailViewController.h"

#import "RSSelectCarViewController.h"

//,CustomMyPickerViewDelegate
@interface RSServiceLibraryViewController
        ()<RSSelectCarViewControllerDelegate>
{
    //中间值用来保存服务的时间
    NSString * _serviceTimeStr;
}

/**蒙版*/
//@property (nonatomic,strong)UIView * menview;

//@property (nonatomic,strong)UITableView * tableview;
/**用来接收服务器的数组*/
@property (nonatomic,strong)NSMutableArray * libraryArray;

//@property (nonatomic,strong)CustomMyPickerView *customVC;
@end

@implementation RSServiceLibraryViewController

- (NSMutableArray *)libraryArray{
    if (_libraryArray == nil) {
        _libraryArray = [NSMutableArray array];
    }
    return _libraryArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"出库服务";
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//    self.tableview = tableview;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
//    self.tableview.showsHorizontalScrollIndicator = NO;
//    self.tableview.showsVerticalScrollIndicator = NO;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//   // self.tableview.contentInset = UIEdgeInsetsMake(0, 0, (SCH - Y - bottomH)/3, 0);
//    [self.view addSubview:self.tableview];
    RSWeakself
//    [self.tableview setupEmptyDataText:@"暂无可发起服务的订单" tapBlock:^{
//        //重新加载数据
//        [weakSelf getServiceIableOutBoundListData];
//    }];
    
    //向下刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getServiceIableOutBoundListData];
    }];
    [self getServiceIableOutBoundListData];
//    UIView * menview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
//    menview.backgroundColor = [UIColor colorWithHexColorStr:@"#000000" alpha:0.5];
//    [self.view addSubview:menview];
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hihelibrarySecondMenView:)];
//    menview.userInteractionEnabled = YES;
//    [menview addGestureRecognizer:tap];
//    [menview bringSubviewToFront:self.view];
//    _menview = menview;
//    _menview.hidden = YES;
//    UIView * centerView = [[UIView alloc]initWithFrame:CGRectMake(24, (SCH/2) - 80, SCW - 48, 160)];
//    centerView.backgroundColor = [UIColor whiteColor];
//    [menview addSubview:centerView];
//    UIImageView * centerImageview = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 - 40, (SCH/2) - 120, 80, 80)];
//    centerImageview.backgroundColor = [UIColor clearColor];
//    centerImageview.image = [UIImage imageNamed:@"开始服务"];
//    centerImageview.layer.cornerRadius = centerImageview.yj_width * 0.5;
//    centerImageview.layer.masksToBounds = YES;
//    [menview addSubview:centerImageview];
//
//    UILabel * centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, centerView.yj_width, 18)];
//    centerLabel.text = @"开始服务";
//    centerLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    centerLabel.font = [UIFont systemFontOfSize:18];
//    centerLabel.textAlignment = NSTextAlignmentCenter;
//    [centerView addSubview:centerLabel];
//
//    UILabel * serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(centerLabel.frame) + 10, centerView.yj_width, 15)];
//    serviceLabel.text = @"开始对此服务展开工作";
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
//    [cancelBtn addTarget:self action:@selector(cancellibrarySecondChoiceAction:) forControlEvents:UIControlEventTouchUpInside];
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
//    [sureBtn addTarget:self action:@selector(surelibrarySecondChoiceAction:) forControlEvents:UIControlEventTouchUpInside];

}



////FIXME:这边是点击蒙版的动作
//-(void) hihelibrarySecondMenView:(UITapGestureRecognizer *)tap{
//    _menview.hidden = YES;
//}
//
////FIXME:这边是要取消的
//- (void)cancellibrarySecondChoiceAction:(UIButton *)btn{
//    _menview.hidden = YES;
//}
//
////FIXME:这边是选择确定的按键
//- (void)surelibrarySecondChoiceAction:(UIButton *)btn{
//    _menview.hidden = YES;
//    RSLibraryModel * librarymodel = self.libraryArray[_menview.tag - 1000000];
//    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:_menview.tag - 1000000  inSection:0];
//   // [self addService:librarymodel.outboundNo andAppointTime:_serviceTimeStr andNSIndexpath:indexpath];
//}

- (void)getServiceIableOutBoundListData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SERVICEIABLEOUTBOUNDLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = [NSMutableArray array];
                [weakSelf.libraryArray removeAllObjects];
                array = json[@"Data"];
                if (array.count > 0) {
                    for (int i = 0; i < array.count; i++) {
                        RSLibraryModel * librarymodel = [[RSLibraryModel alloc]init];
                        librarymodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                        librarymodel.outboundNo = [[array objectAtIndex:i]objectForKey:@"outboundNo"];
                        [weakSelf.libraryArray addObject:librarymodel];
                    }
                }
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview reloadData];
            }else{
                 [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview reloadData];
            }
        }else{
            [weakSelf.tableview.mj_header endRefreshing];
            [weakSelf.tableview reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.libraryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * SERVICELIBRAY =  @"servicelibray";
    RSServiceLibraryCell * cell = [tableView dequeueReusableCellWithIdentifier:SERVICELIBRAY];
    if (!cell) {
        cell = [[RSServiceLibraryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SERVICELIBRAY];
    }
    cell.initiatingServiceBtn.tag = 1000000+indexPath.row;
    cell.serviceOrderDetailsBtn.tag = 1000000+indexPath.row;
    RSLibraryModel * librarymodel = self.libraryArray[indexPath.row];
    cell.serviceOutLabel.text = [NSString stringWithFormat:@"出库单:%@",librarymodel.outboundNo];
    cell.serviceOutTimeLabel.text = [NSString stringWithFormat:@"下单时间:%@",librarymodel.createTime];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //发起服务
    [cell.initiatingServiceBtn addTarget:self action:@selector(sendServiceAction:) forControlEvents:UIControlEventTouchUpInside];
    //订单详情
    [cell.serviceOrderDetailsBtn addTarget:self action:@selector(orderDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116;
}

//- (NSString *)currentTime{
//    NSDate *detaildate=[NSDate date];
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
//    return currentDateStr;
//}
//
//#pragma mark -- 代理方法
//- (void)compareTime:(NSString *)titleTimeStr{
//    NSMutableArray * timeArray = [NSMutableArray array];
//    timeArray = [self recaptureTime:titleTimeStr];
//    _customVC.componentArray = timeArray;
//    RSWeakself
//    _customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
//        //NSLog(@"zhelicom is = %@   title = %@",compoentString,titileString);
//        if ([compoentString isEqualToString:@"立刻送"]) {
//            compoentString = [weakSelf getCurrentTime];
//        }else{
//            compoentString = [NSString stringWithFormat:@"%@:00",compoentString];
//        }
//        //_menview.hidden = NO;
//       // _menview.tag = btn.tag;
//        weakSelf.menview.hidden = NO;
//        _serviceTimeStr = [NSString stringWithFormat:@"%@ %@",titileString,compoentString];
//    };
//    [_customVC.picerView reloadAllComponents];
//}
//
////重新获取时间
//- (NSMutableArray *)recaptureTime:(NSString *)titleString{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH"];
//    NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
//    [formatter1 setDateFormat:@"mm"];
//    NSString * dateTime = [formatter stringFromDate:[NSDate date]];
//    NSString * minute = [formatter1 stringFromDate:[NSDate date]];
//    NSString * reloadYear = [self currentTime];
//    NSString * time = [NSString stringWithFormat:@"%@:%@",dateTime,minute];
//    NSMutableArray * timeArray = [NSMutableArray array];
//    NSArray * choiceTimeArray = @[@"00:00",@"00:30",@"01:00",@"01:30",@"02:00",@"02:30",@"03:00",@"03:30",@"04:00",@"04:30",@"05:00",@"05:30",@"06:00",@"06:30",@"07:00",@"07:30",@"08:00",@"08:30",@"09:00",@"09:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",@"21:30",@"22:00",@"22:30",@"23:00",@"23:30"];
//    NSString * rightNowStr = @"立刻送";
//    [timeArray removeAllObjects];
//    for (int i = 0; i < choiceTimeArray.count; i++) {
//        NSString * timeStr = choiceTimeArray[i];
//        BOOL resultYear = [titleString compare:reloadYear] == NSOrderedSame;
//        if (resultYear) {
//            BOOL result = [timeStr compare:time] == NSOrderedDescending;
//            if (result == 1){
//                [timeArray addObject:choiceTimeArray[i]];
//            }
//        }else{
//            [timeArray addObject:choiceTimeArray[i]];
//        }
//    }
//    [timeArray insertObject:rightNowStr atIndex:0];
//    return timeArray;
//}

//FIXME:发起服务
- (void)sendServiceAction:(UIButton *)btn{
    
    RSLibraryModel * librarymodel = self.libraryArray[btn.tag - 1000000];
    RSSelectCarViewController * selectCarVc = [[RSSelectCarViewController alloc]init];
    selectCarVc.usermodel = self.usermodel;
    selectCarVc.outBoundNo = librarymodel.outboundNo;
    selectCarVc.delegate = self;
    [self.navigationController pushViewController:selectCarVc animated:YES];
    
    
    
    
    
    
    //这边是记住你选择是第几个出货服务的tag值
    //self.menview.tag = btn.tag;
//    NSMutableArray * timeArray = [NSMutableArray array];
//    timeArray = [self recaptureTime:[self currentTime]];
//    RSWeakself
//    CustomMyPickerView *customVC  = [[CustomMyPickerView alloc] initWithComponentDataArray:timeArray titleDataArray:nil];
//    customVC.delegate = self;
//    customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
//       // NSLog(@"zhelicom is = %@   title = %@",compoentString,titileString);
//        if ([compoentString isEqualToString:@"立刻送"]) {
//            compoentString = [weakSelf getCurrentTime];
//        }else{
//            compoentString = [NSString stringWithFormat:@"%@:00",compoentString];
//        }
//        weakSelf.menview.hidden = NO;
//
//        _serviceTimeStr = [NSString stringWithFormat:@"%@ %@",titileString,compoentString];
//    };
//    _customVC = customVC;
//    [self.view addSubview:customVC];
}

- (void)recaptureNetworkData{
    
    [self getServiceIableOutBoundListData];
    
}


//#pragma mark -- 获取当前时间
//- (NSString *)getCurrentTime {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH:mm:ss"];
//    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
//    return dateTime;
//}

////发起服务
//- (void)addService:(NSString *)outboundNo andAppointTime:(NSString *)appointTime andNSIndexpath:(NSIndexPath *)indexpath{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:self.usermodel.userID forKey:@"sendUserId"];
//    [dict setObject:outboundNo forKey:@"outBoundNo"];
//    [dict setObject:appointTime forKey:@"appointTime"];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":ERPID};
//    RSWeakself
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_STARTADDSERVICE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//                [SVProgressHUD showSuccessWithStatus:@"发起的服务成功"];
//                 //这边要进行的是，要对出库服务单条数据进行删除
//                [weakSelf.libraryArray removeObjectAtIndex:indexpath.row];
//                [weakSelf.tableview reloadData];
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"发起的服务失败"];
//            }
//        }else{
//             [SVProgressHUD showErrorWithStatus:@"发起的服务失败"];
//        }
//    }];
//}

//FIXME:订单详情
- (void)orderDetailAction:(UIButton *)btn{
    RSLibraryModel * librarymodel = self.libraryArray[btn.tag - 1000000];
    RSRecordDetailViewController * recordDetailVc = [[RSRecordDetailViewController alloc]init];
    recordDetailVc.usermodel = self.usermodel;
    recordDetailVc.outBoundNo = librarymodel.outboundNo;
    [self.navigationController pushViewController:recordDetailVc animated:YES];
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
