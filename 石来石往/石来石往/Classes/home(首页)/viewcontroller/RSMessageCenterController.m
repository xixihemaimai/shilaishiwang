//
//  RSMessageCenterController.m
//  石来石往
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMessageCenterController.h"
#import "RSMessageSecondCenterCell.h"
#import "RSMessageCenterModel.h"
#import "RSFriendDetailController.h"

@interface RSMessageCenterController ()

@property (nonatomic,assign)BOOL isRefresh;
@property (nonatomic,assign)NSInteger pageNum;
@property (nonatomic,strong)NSMutableArray * messageArray;
//@property (nonatomic,strong)UITableView * tableview;

@end

@implementation RSMessageCenterController
- (NSMutableArray *)messageArray{
    if (_messageArray == nil) {
        _messageArray = [NSMutableArray array];
    }
    return _messageArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadContentNewData) name:@"delFriendData" object:nil];
    
    
  
    // [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshData" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadMessageNewData) name:@"refreshData" object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    self.pageNum = 2;
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self isAddjust];
    [self.view addSubview:self.tableview];
    [self loadMessageCenterNewData];
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadMessageCenterNewData];
    }];
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadMessageCenterMoreNewData];
    }];
}



//点赞和评论要变的
- (void)reloadMessageNewData{
    [self loadMessageCenterNewData];
}


#pragma mark -- 重新获取数据
- (void)reloadContentNewData{
    [self loadMessageCenterNewData];
}

- (void)loadMessageCenterNewData{
    self.isRefresh = true;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"page"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh]forKey:@"isRefresh"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_MESSAGECENTER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [weakSelf.messageArray removeAllObjects];
                weakSelf.messageArray = [RSMessageCenterModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                    weakSelf.pageNum = 2;
                    [weakSelf.tableview reloadData];
                    [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [RSLoginValidity LoginValiditWithVerifyKey:verifykey andViewController:self];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }
    }];
}

- (void)loadMessageCenterMoreNewData{
    self.isRefresh = true;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"page"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh]forKey:@"isRefresh"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_MESSAGECENTER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = [RSMessageCenterModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                [weakSelf.messageArray addObjectsFromArray:array];
                    weakSelf.pageNum++;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
                }
        }else{
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * MESSAGESECONDCENTERID = @"messagesecondcenterid";
    RSMessageSecondCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:MESSAGESECONDCENTERID];
    if (!cell) {
        cell = [[RSMessageSecondCenterCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MESSAGESECONDCENTERID];
    }
    RSMessageCenterModel * messagecentermodel = self.messageArray[indexPath.row];
    cell.messagecentermodel = messagecentermodel;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    RSMessageCenterModel * messagecenter = self.messageArray[indexPath.row];
    RSFriendDetailController * friendDetailVc = [[RSFriendDetailController alloc]init];
    friendDetailVc.userModel = self.usermodel;
    friendDetailVc.friendID = messagecenter.friendsId;
    friendDetailVc.titleStyle = @"";
    friendDetailVc.selectStr = @"";
    [self.navigationController pushViewController:friendDetailVc animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
