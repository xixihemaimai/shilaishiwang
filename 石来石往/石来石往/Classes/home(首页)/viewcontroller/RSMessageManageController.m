//
//  RSMessageManageController.m
//  石来石往
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMessageManageController.h"
#import "RSNoticeCell.h"
#import "RSNSticeCommentCell.h"
#import "RSMyAndThumbsCell.h"
#import "RSAllHomeViewController.h"
#import "RSMessageModel.h"
#import "RSMessageFooterView.h"
#import "RSFriendDetailController.h"
#import "RSPersonalServiceViewController.h"
#import "RSServiceMyServiceController.h"

@interface RSMessageManageController ()

//@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * messageArray;
@property (nonatomic,assign)BOOL isRresh;
@property (nonatomic,assign)NSInteger pageNum;

@end

@implementation RSMessageManageController
- (NSMutableArray *)messageArray{
    if (_messageArray == nil) {
        _messageArray = [NSMutableArray array];
    }
    return _messageArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    [self isAddjust];
    [self.view addSubview:self.tableview];
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getStyleData];
    }];
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf getStyleMoreNewData];
    }];
    //self.tableView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.pageNum = 2;
//    [self addMessageManageCustomTableview];
    [self getStyleData];
}

//- (void)addMessageManageCustomTableview{
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//    self.tableView = tableview;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
//    self.tableView.showsHorizontalScrollIndicator = NO;
//    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    //self.tableview.contentInset = UIEdgeInsetsMake(0, 0, navY + navHeight, 0);
//    [self.view addSubview:self.tableView];
//
//    [self.tableView setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf getStyleData];
//    }];
//}

#pragma mark --- 获取不同的数据
- (void)getStyleData{
    self.isRresh = true;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //[dict setObject:self.userModel.userPhone forKey:@"mobilePhone"];
     [dict setObject:@"1" forKey:@"erpId"];
    [dict setObject:self.userModel.userID forKey:@"userId"];
    [dict setObject:self.titleStr forKey:@"msgType"];
    [dict setObject:[NSNumber numberWithBool:self.isRresh] forKey:@"isRefresh"];
    [dict setObject:[NSString stringWithFormat:@"10"] forKey:@"pageSize"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"page"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_MESSAGECOUNT_DEFIENT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [weakSelf.messageArray removeAllObjects];
                NSMutableArray * array = [RSMessageModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                weakSelf.messageArray = array;
                weakSelf.pageNum = 2;
                [weakSelf deleteMessageCount:self.titleStr];
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
                [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
            }
        }else{
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)getStyleMoreNewData{
    self.isRresh = true;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //[dict setObject:self.userModel.userPhone forKey:@"mobilePhone"];
    [dict setObject:@"1" forKey:@"erpId"];
    [dict setObject:self.userModel.userID forKey:@"userId"];
    [dict setObject:self.titleStr forKey:@"msgType"];
    [dict setObject:[NSNumber numberWithBool:self.isRresh] forKey:@"isRefresh"];
    [dict setObject:[NSString stringWithFormat:@"10"] forKey:@"pageSize"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)self.pageNum] forKey:@"page"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_MESSAGECOUNT_DEFIENT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = [RSMessageModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                [weakSelf.messageArray addObjectsFromArray:array];
                weakSelf.pageNum++;
                [weakSelf deleteMessageCount:self.titleStr];
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [weakSelf.tableview.mj_footer endRefreshing];
                [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
            }
        }else{
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}

#pragma mark -- 删除应用的角标
- (void)deleteMessageCount:(NSString *)msgType{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifkey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.userModel.userID forKey:@"userId"];
    [phoneDict setObject:msgType forKey:@"msgType"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifkey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DELETE_MESSAGECOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                //删除各个分类的角标
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

static NSString * MESSAGEFOOTVIEWID = @"messagefootviewid";
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    RSMessageFooterView * messagefootview = [[RSMessageFooterView alloc]initWithReuseIdentifier:MESSAGEFOOTVIEWID];
    return messagefootview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.messageArray.count < 1) {
        return 30;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.titleStr isEqualToString:@"serviceMsg"]) {
        static NSString * RSMYANDTHUMBSCELLID = @"rsmyandthumbscellid";
//        RSMyAndThumbsCell *cell = [tableView dequeueReusableCellWithIdentifier:RSMYANDTHUMBSCELLID];
//        if (!cell) {
//            cell = [[RSMyAndThumbsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSMYANDTHUMBSCELLID];
//        }
//        cell.myBtn.tag = indexPath.row;
//        // [cell.myBtn addTarget:self action:@selector(jumpAllHomeViewController:) forControlEvents:UIControlEventTouchUpInside];
//
//        cell.myBtn.enabled = NO;
//        cell.backgroundColor = [UIColor clearColor];
//        /**传递模型过去*/
//        cell.messagemodel = self.messageArray[indexPath.row];
        RSNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:RSMYANDTHUMBSCELLID];
        if (!cell) {
            cell = [[RSNoticeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSMYANDTHUMBSCELLID];
        }
        cell.messagemodel = self.messageArray[indexPath.row];
        cell.noticeStyle.text = @"服务消息";
        cell.backgroundColor = [UIColor clearColor];
       // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if ([self.titleStr isEqualToString:@"reply"]){
        static NSString * RSNSTICECOMMENTCELLID = @"rsnsticecommentcellid";
        RSNSticeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:RSNSTICECOMMENTCELLID];
        if (!cell) {
            cell = [[RSNSticeCommentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSNSTICECOMMENTCELLID];
        }
        cell.messagemodel = self.messageArray[indexPath.row];
        cell.nsticeCommentBtn.tag = indexPath.row;
        [cell.nsticeCommentBtn addTarget:self action:@selector(jumpAllHomeViewController:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([self.titleStr isEqualToString:@"like"]){
        static NSString * RSMYANDTHUMBSCELLSECONDID = @"rsmyandthumbscellsecondid";
        RSMyAndThumbsCell *cell = [tableView dequeueReusableCellWithIdentifier:RSMYANDTHUMBSCELLSECONDID];
        if (!cell) {
            cell = [[RSMyAndThumbsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSMYANDTHUMBSCELLSECONDID];
        }
        cell.myBtn.tag = indexPath.row;
        [cell.myBtn addTarget:self action:@selector(jumpAllHomeViewController:) forControlEvents:UIControlEventTouchUpInside];
        cell.messagemodel = self.messageArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString * RSNOTICECELLID = @"rsnoticecellid";
        RSNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:RSNOTICECELLID];
        if (!cell) {
            cell = [[RSNoticeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSNOTICECELLID];
        }
        cell.messagemodel = self.messageArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        cell.noticeStyle.text = @"系统通知";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.titleStr isEqualToString:@"reply"]) {
        
        //朋友圈详情
        RSMessageModel * messagemodel  = self.messageArray[indexPath.row];
        RSFriendDetailController * friendDetailVc = [[RSFriendDetailController alloc]init];
        friendDetailVc.userModel = self.userModel;
        friendDetailVc.title = messagemodel.messageContent;
        friendDetailVc.titleStyle = @"";
        friendDetailVc.friendID = messagemodel.friendsId;
        friendDetailVc.selectStr = @"";
//         friendDetailVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:friendDetailVc animated:YES];
        
        
    }else if ([self.titleStr isEqualToString:@"serviceMsg"]){
            //服务消息
        if ([self.userModel.userType isEqualToString:@"ckfw"] || [self.userModel.userType isEqualToString:@"scfw"]) {
            //服务人员
           
            RSPersonalServiceViewController * personalServiceVc = [[RSPersonalServiceViewController alloc]init];
            personalServiceVc.usermodel = self.userModel;
            personalServiceVc.jumpStr = @"1";
//             personalServiceVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personalServiceVc animated:YES];
            
        }else{
            //客户端
           
            RSServiceMyServiceController * myServiceVc = [[RSServiceMyServiceController alloc]init];
            myServiceVc.usermodel = self.userModel;
            myServiceVc.jumpStr = @"1";
//             myServiceVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myServiceVc animated:YES];
            
        }
    }
}

#pragma mark 朋友圈详情
- (void)jumpAllHomeViewController:(UIButton *)myBtn{
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[RSAllHomeViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//             [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshData" object:nil];
//        }
//    }
    RSMessageModel * messagemodel = self.messageArray[myBtn.tag];
   
    RSFriendDetailController * friendDetailVc = [[RSFriendDetailController alloc]init];
    friendDetailVc.userModel = self.userModel;
    friendDetailVc.titleStyle = @"";
    friendDetailVc.friendID = messagemodel.friendsId;
    friendDetailVc.selectStr = @"";
//    friendDetailVc.hidesBottomBarWhenPushed = YES;
    friendDetailVc.title = messagemodel.messageContent;
    [self.navigationController pushViewController:friendDetailVc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.titleStr isEqualToString:@"serviceMsg"]){
        return 148;
    }else if ( [self.titleStr isEqualToString:@"like"]){
        return 112;
    }else if ([self.titleStr isEqualToString:@"reply"]){
        return 132.5;
    }else{
        return 148;
    }
}

@end
