//
//  RSSelectCarViewController.m
//  石来石往
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSSelectCarViewController.h"
#define ECA 4
#define margin 10

//选择服务的时间
#import "CustomMyPickerView.h"

#import "RSServiceLibraryViewController.h"

@interface RSSelectCarViewController ()<CustomMyPickerViewDelegate>

//@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,strong)CustomMyPickerView * customVC;

@property (nonatomic,strong)UIButton * currentSelectBtn;

@property (nonatomic,strong)UIButton  * selectTimeBtn;

@property (nonatomic,strong)NSString * selectCarStr;


@end

@implementation RSSelectCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起服务";
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    [self setSelectCarTableviewUI];
    
}


- (void)setSelectCarTableviewUI{
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
//    //self.tableview.contentInset = UIEdgeInsetsMake(0, 0, navY + navHeight, 0);
//    [self.view addSubview:self.tableview];
    
    
    UIView * headerview = [[UIView alloc]init];
    headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    //_headerview = headerview;
    
    UIView * carview = [[UIView alloc]init];
    carview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:carview];
    
    
    carview.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(headerview, 10)
    .heightIs(40);
    
    //这边是显示(车辆类型)
    UILabel * carLabel = [[UILabel alloc]init];
    carLabel.text = @"车辆类型";
    carLabel.backgroundColor = [UIColor whiteColor];
    carLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    carLabel.textAlignment = NSTextAlignmentLeft;
    carLabel.font = [UIFont systemFontOfSize:15];
    [carview addSubview:carLabel];
    
    carLabel.sd_layout
    .leftSpaceToView(carview, 12)
    .rightSpaceToView(carview, 0)
    .topSpaceToView(carview, 0)
    .bottomSpaceToView(carview, 1);
    
    
    UIView * carBottomview = [[UIView alloc]init];
    carBottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [carview addSubview:carBottomview];
    carBottomview.sd_layout
    .leftSpaceToView(carview, 0)
    .rightSpaceToView(carview, 0)
    .bottomSpaceToView(carview, 0)
    .heightIs(1);
    
    
    
    //这边是有多少选择车的视图
    UIView * selectView = [[UIView alloc]init];
    selectView.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:selectView];
    selectView.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(carview, 0)
    .heightIs(50);
    
    NSArray * styleArray = @[@"短途车",@"长途车",@"货柜",@"其他"];
    CGFloat btnW = (SCW - (ECA + 1)*margin)/ECA;
    CGFloat btnH = 25;
    for (int i = 0 ; i < styleArray.count; i++) {
        UIButton * selectBtn = [[UIButton alloc]init];
        NSInteger row = i / ECA;
        NSInteger colom = i % ECA;
        selectBtn.tag = 100000 + i;
        CGFloat btnX =  colom * (margin + btnW) + margin;
        CGFloat btnY =  row * (margin + btnH) + margin;
        selectBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [selectBtn setTitle:styleArray[i] forState:UIControlStateNormal];
        [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#d6d6d6"] forState:UIControlStateNormal];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形1拷贝3"] forState:UIControlStateNormal];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"选中2"] forState:UIControlStateSelected];
        [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FA6A00"] forState:UIControlStateSelected];
        if (i == 3) {
            [self buttonTouchClick:selectBtn];
        }
        [selectView addSubview:selectBtn];
        [selectBtn addTarget:self action:@selector(buttonTouchClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    //选择服务时间
    UIView * selectTimeView = [[UIView alloc]init];
    selectTimeView.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:selectTimeView];
    selectTimeView.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(selectView, 10)
    .heightIs(40);
    
    
    UILabel * selectTimeLabel = [[UILabel alloc]init];
    selectTimeLabel.text = @"服务时间";
    selectTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    selectTimeLabel.font = [UIFont systemFontOfSize:15];
    selectTimeLabel.textAlignment = NSTextAlignmentLeft;
    [selectTimeView addSubview:selectTimeLabel];
    
    selectTimeLabel.sd_layout
    .leftSpaceToView(selectTimeView, 14)
    .centerYEqualToView(selectTimeView)
    .heightIs(14)
    .widthRatioToView(selectTimeView, 0.2);
    
    
    //服务时间选择
    UIButton  * selectTimeBtn = [[UIButton alloc]init];
    [selectTimeBtn setTitle:@"请选择服务时间" forState:UIControlStateNormal];
    selectTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [selectTimeBtn setTitleColor:[UIColor colorWithRed:203/255.0 green:203/255.0 blue:209/255.0 alpha:1.0] forState:UIControlStateNormal];
    [selectTimeBtn addTarget:self action:@selector(selectedServiceTime:) forControlEvents:UIControlEventTouchUpInside];
    [selectTimeView addSubview:selectTimeBtn];
    _selectTimeBtn = selectTimeBtn;
    
    selectTimeBtn.sd_layout
    .leftSpaceToView(selectTimeLabel, 10)
    .centerYEqualToView(selectTimeView)
    .rightSpaceToView(selectTimeView, 14)
    .heightIs(30);
    
    
    
    //按键立即预约
    UIButton * selectRightNowBtn = [[UIButton alloc]init];
    [selectRightNowBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [selectRightNowBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [headerview addSubview:selectRightNowBtn];
    [selectRightNowBtn addTarget:self action:@selector(sendServiceAction:) forControlEvents:UIControlEventTouchUpInside];
    
    selectRightNowBtn.sd_layout
    .leftSpaceToView(headerview, 24)
    .rightSpaceToView(headerview, 24)
    .heightIs(45)
    .topSpaceToView(selectTimeView, 100);
    
    selectRightNowBtn.layer.cornerRadius = 5;
    selectRightNowBtn.layer.masksToBounds = YES;
    
    
    [headerview setupAutoHeightWithBottomView:selectRightNowBtn bottomMargin:40];
    [headerview layoutSubviews];
    self.tableview.tableHeaderView = headerview;
}


#pragma mark -- 获取当前时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString * dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}


- (NSString *)currentTime{
    //实例化一个NSDateFormatter对象
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}

//FIXME:选择时间按键
- (void)selectedServiceTime:(UIButton *)btn{
    NSMutableArray * timeArray = [NSMutableArray array];
    timeArray = [self recaptureTime:[self currentTime]];
    RSWeakself
    CustomMyPickerView *customVC = [[CustomMyPickerView alloc]initWithComponentDataArray:timeArray titleDataArray:nil];
    _customVC = customVC;
    customVC.delegate = self;
    [self.view addSubview:customVC];
    customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        //  NSLog(@"zhelicom is = %@  title = %@",compoentString,titileString);
        if ([compoentString isEqualToString:@"立刻送"]) {
            compoentString = [weakSelf getCurrentTime];
        }else{
            compoentString = [NSString stringWithFormat:@"%@:00",compoentString];
        }
        [weakSelf.selectTimeBtn setTitle:[NSString stringWithFormat:@"%@ %@",titileString,compoentString] forState:UIControlStateNormal];
    };
}


//FIXME:CustomMyPickerViewDelegate
- (void)compareTime:(NSString *)titleTimeStr{
    NSMutableArray * timeArray = [NSMutableArray array];
    timeArray = [self recaptureTime:titleTimeStr];
    _customVC.componentArray = timeArray;
    RSWeakself
    _customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        // NSLog(@"zhelicom is = %@   title = %@",compoentString,titileString);
        if ([compoentString isEqualToString:@"立刻送"]) {
            compoentString = [weakSelf getCurrentTime];
        }else{
            compoentString = [NSString stringWithFormat:@"%@:00",compoentString];
        }
        [weakSelf.selectTimeBtn setTitle:[NSString stringWithFormat:@"%@ %@",titileString,compoentString] forState:UIControlStateNormal];
    };
    //重新刷新picerView显示内容
    [_customVC.picerView reloadAllComponents];
}





//重新获取时间
- (NSMutableArray *)recaptureTime:(NSString *)titleString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"mm"];
    NSString * dateTime = [formatter stringFromDate:[NSDate date]];
    NSString * minute = [formatter1 stringFromDate:[NSDate date]];
    NSString * reloadYear = [self currentTime];
    NSString * time = [NSString stringWithFormat:@"%@:%@",dateTime,minute];
    NSMutableArray * timeArray = [NSMutableArray array];
    NSArray * choiceTimeArray = @[@"00:00",@"00:30",@"01:00",@"01:30",@"02:00",@"02:30",@"03:00",@"03:30",@"04:00",@"04:30",@"05:00",@"05:30",@"06:00",@"06:30",@"07:00",@"07:30",@"08:00",@"08:30",@"09:00",@"09:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",@"21:30",@"22:00",@"22:30",@"23:00",@"23:30"];
    NSString * rightNowStr = @"立刻送";
    [timeArray removeAllObjects];
    for (int i = 0; i < choiceTimeArray.count; i++) {
        NSString * timeStr = choiceTimeArray[i];
        //相同
        BOOL resultYear = [titleString compare:reloadYear] == NSOrderedSame;
        if (resultYear) {
            //小于
            BOOL result = [timeStr compare:time] == NSOrderedDescending;
            if (result == 1){
                [timeArray addObject:choiceTimeArray[i]];
            }
        }else{
            //不相同
            [timeArray addObject:choiceTimeArray[i]];
        }
    }
    [timeArray insertObject:rightNowStr atIndex:0];
    return timeArray;
}


- (void)buttonTouchClick:(UIButton *)btn{
    self.currentSelectBtn.selected = NO;
    btn.selected = YES;
    self.currentSelectBtn = btn;
    //短途是dt 长途是ct 货柜是hg 其他 qt
    if ([self.currentSelectBtn.currentTitle isEqualToString:@"短途车"]) {
        self.selectCarStr = @"dt";
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"长途车"]){
        self.selectCarStr = @"ct";
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"货柜"]){
        self.selectCarStr = @"hg";
    }else if ([self.currentSelectBtn.currentTitle isEqualToString:@"其他"]){
        self.selectCarStr = @"qt";
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * SELECTCARID = @"SELECTCARID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SELECTCARID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SELECTCARID];
    }
    return cell;
}

//FIXME:发起服务
- (void)sendServiceAction:(UIButton *)btn{
    if ([self.selectTimeBtn.currentTitle isEqualToString:@"请选择服务时间"]) {
        [SVProgressHUD showErrorWithStatus:@"没有选择服务时间"];
        return;
    }
    [SVProgressHUD showWithStatus:@"发起服务中......."];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"sendUserId"];
    [dict setObject:self.outBoundNo forKey:@"outBoundNo"];
    [dict setObject:self.selectTimeBtn.currentTitle forKey:@"appointTime"];
    [dict setObject:self.selectCarStr forKey:@"carType"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_STARTADDSERVICE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [SVProgressHUD showSuccessWithStatus:@"发起服务成功"];
                    if ([weakSelf.delegate respondsToSelector:@selector(recaptureNetworkData)]) {
                        [weakSelf.delegate recaptureNetworkData];
                    }
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reout" object:nil];
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"发起服务失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"发起服务失败"];
        }
    }];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
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
