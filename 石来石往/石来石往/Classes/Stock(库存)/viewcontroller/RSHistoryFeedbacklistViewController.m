//
//  RSHistoryFeedbacklistViewController.m
//  石来石往
//
//  Created by mac on 2022/9/14.
//  Copyright © 2022 mac. All rights reserved.
//

#import "RSHistoryFeedbacklistViewController.h"
#import "RSHistoryFeedBackCell.h"
#import "RSHistoryFeedBackListModel.h"
#import "RSMarketComplaintViewController.h"
#import "RSMarketUploadImageModel.h"
#import "RSImageListModel.h"

@interface RSHistoryFeedbacklistViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)NSMutableArray * historyList;

@property (nonatomic,assign)NSInteger pageNum;




@end

@implementation RSHistoryFeedbacklistViewController

- (NSMutableArray *)historyList{
    if(!_historyList){
        _historyList = [NSMutableArray array];
    }
    return _historyList;
}


//- (UITableView *)tableview{
//    if(!_tableview){
//        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableview.estimatedSectionFooterHeight = 0.0;
//        _tableview.estimatedSectionHeaderHeight = 0.0;
//        _tableview.estimatedRowHeight = 0;
//    }
//    return _tableview;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    self.pageNum = 1;
    
    self.title = @"历史反馈记录";
    
    self.tableview.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#FBFBFB"];
    [self.tableview registerClass:[RSHistoryFeedBackCell class] forCellReuseIdentifier:@"RSHistoryFeedBackCell"];
    
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadList)];
    
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadMoreDataList)];
    
    
    [self.tableview.mj_header beginRefreshing];
    
}


- (void)reloadList{
    self.pageNum = 1;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setValue:[NSNumber numberWithInt:10] forKey:@"pageSize"];
    [phoneDict setValue:[NSNumber numberWithInt:1] forKey:@"pageNum"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_MARKET_FEEDBACK_QUERY_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success){
            NSLog(@"====================%@",json);
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.historyList removeAllObjects];
                weakSelf.historyList = [RSHistoryFeedBackListModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                weakSelf.pageNum++;
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview reloadData];
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            [weakSelf.tableview.mj_header endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
    
}

- (void)reloadMoreDataList{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setValue:[NSNumber numberWithInt:10] forKey:@"pageSize"];
    [phoneDict setValue:[NSNumber numberWithInt:self.pageNum] forKey:@"pageNum"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_MARKET_FEEDBACK_QUERY_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success){
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableArray * tempArray = [NSMutableArray array];
                tempArray = [RSHistoryFeedBackListModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                [weakSelf.historyList addObjectsFromArray:tempArray];
                weakSelf.pageNum++;
                
                [weakSelf.tableview.mj_footer endRefreshing];
                [weakSelf.tableview reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.historyList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSHistoryFeedBackCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RSHistoryFeedBackCell"];
    cell.historyFeedBackListModel = self.historyList[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    
    RSHistoryFeedBackListModel * historyFeedBackListModel = self.historyList[indexPath.row];
    
    RSMarketComplaintViewController * marketComplaintVc = [[RSMarketComplaintViewController alloc]init];
    marketComplaintVc.isShow = true;
    for (int i = 0; i < historyFeedBackListModel.imageList.count; i++) {
        RSImageListModel * imageListModel = historyFeedBackListModel.imageList[i];
        RSMarketUploadImageModel * marketUploadImageModel = [[RSMarketUploadImageModel alloc]init];
        marketUploadImageModel.url = imageListModel.url;
        marketUploadImageModel.urlOrigin = imageListModel.urlOrigin;
        [marketComplaintVc.imageArray addObject:marketUploadImageModel];
    }
    
    marketComplaintVc.content = historyFeedBackListModel.content;
    marketComplaintVc.contactNumber = historyFeedBackListModel.contactNumber;
    [self.navigationController pushViewController:marketComplaintVc animated:true];

}


@end
