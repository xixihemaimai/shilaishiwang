//
//  RSNSNotificationMessageViewController.m
//  石来石往
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNSNotificationMessageViewController.h"
#import "RSNSNotCell.h"

#import "RSMessageManageController.h"


@interface RSNSNotificationMessageViewController ()

{
    
    /**点赞*/
    NSInteger  _tempLike;
    
    /**商圈动态*/
    NSInteger  _serviceMsg;
    
    /**评论应用*/
    NSInteger  _reply;
    
    /**系统消息*/
    NSInteger  _systemmsg;
    
    
    
    
    
}




/**图片*/
@property (nonatomic,strong)NSArray * nsnotImageArray;
/**标题*/
@property (nonatomic,strong)NSArray * nsnotTitleArray;


//@property (nonatomic,strong)UITableView * tableview;


/**消息的次数*/
@property (nonatomic,assign)NSInteger selectCount;



@end

@implementation RSNSNotificationMessageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息";
    [self isAddjust];
    [self.view addSubview:self.tableview];
    [self reloadDiffenentMessageCount];
    self.nsnotImageArray = @[@"服务消息",@"评论1",@"点赞1",@"通知"];
    self.nsnotTitleArray = @[@"服务消息",@"评论",@"点赞",@"通知"];
    
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    [self customNavigationBackBtn];
//    RSWeakself
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//         [weakSelf customTableview];
//    });
}

#pragma mark -- 获取每个地方的消息次数
- (void)reloadDiffenentMessageCount{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifkey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[UserManger getUserObject].userID forKey:@"userId"];
    //二进制数
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifkey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DIFF_MESSAGECOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                _tempLike = [json[@"Data"][@"like"] integerValue];
                _serviceMsg = [json[@"Data"][@"serviceMsg"] integerValue];
                _reply = [json[@"Data"][@"reply"] integerValue];
                _systemmsg = [json[@"Data"][@"systemmsg"] integerValue];
            }
        }
    }];
}

//TODO:自定义tableview
//- (void)customTableview{
//    CGFloat Y = 0.0;
//    if (iPhoneX_All) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Y, SCW, SCH - Y) style:UITableViewStylePlain];
//    self.tableview = tableview;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableview];
//}

//TODO:自定义导航返回按键
//- (void)customNavigationBackBtn{
//    RSNavigationButton  * backItem = [RSNavigationButton buttonWithType:UIButtonTypeCustom];
//    [backItem setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//    [backItem addTarget:self action:@selector(backAllHomeViewController) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:backItem];
//    self.navigationItem.leftBarButtonItem = item;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nsnotTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * NSNOTEFICATIONID = @"NSNOTEFICATIOONID";
    RSNSNotCell * cell = [tableView dequeueReusableCellWithIdentifier:NSNOTEFICATIONID];
    if (!cell) {
        cell = [[RSNSNotCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSNOTEFICATIONID];
    }
//    if (indexPath.row <= 2) {
//        cell.nsnotNumberLabel.hidden = YES;
//    }
    cell.nsnotImage.image = [UIImage imageNamed:self.nsnotImageArray[indexPath.row]];
    cell.nsnotImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.nsnotImage.clipsToBounds = YES;
   // cell.nsnotNumberLabel.text = @"3";
    cell.nsnotLabel.text = [NSString stringWithFormat:@"%@",self.nsnotTitleArray[indexPath.row]];
    if ([self.nsnotTitleArray[indexPath.row] isEqualToString:@"服务消息"] ) {
        if (_serviceMsg > 0) {
            cell.nsnotNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)_serviceMsg];
            cell.nsnotNumberLabel.hidden = NO;
        }else{
            cell.nsnotNumberLabel.hidden = YES;
        }
    }else if ([self.nsnotTitleArray[indexPath.row] isEqualToString:@"评论"]){
        if (_reply > 0) {
            cell.nsnotNumberLabel.text =  [NSString stringWithFormat:@"%ld",(long)_reply];
            cell.nsnotNumberLabel.hidden = NO;
        }else{
            cell.nsnotNumberLabel.hidden = YES;
        }
    }else if ([self.nsnotTitleArray[indexPath.row] isEqualToString:@"点赞"]){
        if (_tempLike > 0) {
            cell.nsnotNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)_tempLike];
            cell.nsnotNumberLabel.hidden = NO;
        }else{
            cell.nsnotNumberLabel.hidden = YES;
        }
    }else{
        if (_systemmsg > 0) {
            cell.nsnotNumberLabel.text =  [NSString stringWithFormat:@"%ld",(long)_systemmsg];
            cell.nsnotNumberLabel.hidden = NO;
        }else{
            cell.nsnotNumberLabel.hidden = YES;
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark -- 点击通知，点击评论
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * str = nil;
    NSString * titleStr = nil;
    RSNSNotCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
        //我的
        str = @"serviceMsg";
        titleStr = @"服务消息";
        cell.nsnotNumberLabel.hidden = YES;
        _selectCount += _serviceMsg ;
    }else if (indexPath.row == 1){
        //评论
        str = @"reply";
        titleStr = @"评论";
        cell.nsnotNumberLabel.hidden = YES;
        _selectCount += _reply;
    }else if (indexPath.row == 2){
        //点赞
        str = @"like";
        titleStr = @"点赞";
        cell.nsnotNumberLabel.hidden = YES;
        _selectCount += _tempLike ;
    }else{
        //通知
        str = @"systemmsg";
        titleStr = @"系统消息";
        cell.nsnotNumberLabel.hidden = YES;
        _selectCount += _systemmsg;
    }
    //self.hidesBottomBarWhenPushed = YES;
    RSMessageManageController * messageManageVc = [[RSMessageManageController alloc]init];
    messageManageVc.title = titleStr;
    messageManageVc.titleStr = str;
    messageManageVc.userModel = [UserManger getUserObject];
    messageManageVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageManageVc animated:YES];
    //self.hidesBottomBarWhenPushed = NO;
}

//- (void)backAllHomeViewController{
//    if ([self.delegate respondsToSelector:@selector(messageCount:)]) {
//        [self.delegate messageCount:_selectCount];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//}

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
