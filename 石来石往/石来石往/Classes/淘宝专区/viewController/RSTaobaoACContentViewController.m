//
//  RSTaobaoACContentViewController.m
//  石来石往
//
//  Created by mac on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaobaoACContentViewController.h"
#import "RSTaoBaoActivityCell.h"

//进店
#import "RSTaoBaoShopViewController.h"

#import "RSTaoBaoUserLikeModel.h"
#import "RSTaobaoVideoAndPictureModel.h"

//单个商品
#import "RSTaoBaoProductDetailsViewController.h"


@interface RSTaobaoACContentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,strong)NSMutableArray * contentArray;

@property (nonatomic,assign)NSInteger pageNum;

@end

@implementation RSTaobaoACContentViewController

- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}


- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
        _tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fairReload) name:@"fairReload" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.pageNum = 2;
    [self.view addSubview:self.tableview];
    
    
    [self reloadActivityNewData];
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadActivityNewData];
    }];
    
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
          [weakSelf reloadActivityMoreNewData];
    }];
    
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
         [weakSelf reloadActivityNewData];
    }];
}


- (void)reloadActivityNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if (verifykey.length < 1) {
        verifykey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    [phoneDict setObject:@"" forKey:@"stoneName"];
    [phoneDict setObject:@"" forKey:@"shopName"];
    NSString * str = [NSString string];
    if ([self.title isEqualToString:@"荒料"]) {
        str = @"huangliao";
    }else if ([self.title isEqualToString:@"大板"]){
        str = @"daban";
    }else{
        str = @"";
    }
    [phoneDict setObject:str forKey:@"stockType"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETACTIVITYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
//                NSMutableArray * array = [NSMutableArray array];
//                array = json[@"data"][@"list"];
                [weakSelf.contentArray removeAllObjects];
                weakSelf.contentArray = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json
                                         [@"data"][@"list"]];
                for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in weakSelf.contentArray) {
                    taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                }
//                for (int i = 0; i < array.count; i++) {
//                    RSTaoBaoUserLikeModel * taobaoUserLikemodel = [[RSTaoBaoUserLikeModel alloc]init];
//                    taobaoUserLikemodel.actId = [[[array objectAtIndex:i]objectForKey:@"actId"]integerValue];
//                    taobaoUserLikemodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"]integerValue];
//                    taobaoUserLikemodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
//                    taobaoUserLikemodel.userLikeID = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
//                    taobaoUserLikemodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
//                    taobaoUserLikemodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
//                    taobaoUserLikemodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
//                    taobaoUserLikemodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
//                    taobaoUserLikemodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
//                    taobaoUserLikemodel.discount = [[array objectAtIndex:i]objectForKey:@"discount"];
//                    taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
//                    taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
//                    taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
//                    taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
//                    taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
//                    taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
//                    taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
//                    taobaoUserLikemodel.imageUrl =  [[array objectAtIndex:i]objectForKey:@"imageUrl"];
//                     taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
//                    taobaoUserLikemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
//                    NSMutableArray * temp = [NSMutableArray array];
//                    temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
//                    for (int j = 0; j < temp.count; j++) {
//                        RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
//                        videoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"]integerValue];
//                        videoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"]integerValue];
//                        videoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
//                        videoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
//                        [taobaoUserLikemodel.imageList addObject:videoAndPicturemodel];
//                    }
//                    [weakSelf.contentArray addObject:taobaoUserLikemodel];
//                }
                
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
                weakSelf.pageNum = 2;
            }else{
               
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
              [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}



- (void)reloadActivityMoreNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
        verifykey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    [phoneDict setObject:@"" forKey:@"stoneName"];
    [phoneDict setObject:@"" forKey:@"shopName"];
    NSString * str = [NSString string];
    if ([self.title isEqualToString:@"荒料"]) {
        str = @"huangliao";
    }else if ([self.title isEqualToString:@"大板"]){
        str = @"daban";
    }else{
        str = @"";
    }
    [phoneDict setObject:str forKey:@"stockType"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETACTIVITYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
//                NSMutableArray * temp = [NSMutableArray array];
//                NSMutableArray * array = [NSMutableArray array];
//                array = json[@"data"][@"list"];
//                for (int i = 0; i < array.count; i++) {
//                    RSTaoBaoUserLikeModel * taobaoUserLikemodel = [[RSTaoBaoUserLikeModel alloc]init];
//                    taobaoUserLikemodel.actId = [[[array objectAtIndex:i]objectForKey:@"actId"]integerValue];
//                    taobaoUserLikemodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"]integerValue];
//                    taobaoUserLikemodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
//                    taobaoUserLikemodel.userLikeID = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
//                    taobaoUserLikemodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
//                    taobaoUserLikemodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
//                    taobaoUserLikemodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
//                    taobaoUserLikemodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
//                    taobaoUserLikemodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
//                    taobaoUserLikemodel.discount = [[array objectAtIndex:i]objectForKey:@"discount"];
//                    taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
//                    taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
//                    taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
//                    taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
//                    taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
//                    taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
//                    taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
//                    taobaoUserLikemodel.imageUrl =[[array objectAtIndex:i]objectForKey:@"imageUrl"];
//                     taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
//                    taobaoUserLikemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
//                    NSMutableArray * temp = [NSMutableArray array];
//                    temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
//                    for (int j = 0; j < temp.count; j++) {
//                        RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
//                        videoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"]integerValue];
//                        videoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"]integerValue];
//                        videoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
//                        videoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
//                        [taobaoUserLikemodel.imageList addObject:videoAndPicturemodel];
//                    }
//                    [temp addObject:taobaoUserLikemodel];
//                }
                NSMutableArray * array = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json
                                         [@"data"][@"list"]];
                for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in array) {
                    taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                }
                [weakSelf.contentArray addObjectsFromArray:array];
                weakSelf.pageNum++;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
                
            }else{
                
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}









- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 127;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * TAOBAOSCCONTENTCELLID = @"TAOBAOSCCONTENTCELLID";
    RSTaoBaoActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:TAOBAOSCCONTENTCELLID];
    if (!cell) {
        cell = [[RSTaoBaoActivityCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TAOBAOSCCONTENTCELLID];
    }
    cell.taobaoUserlikemodel = self.contentArray[indexPath.row];
    cell.rowNowRobBtn.hidden = NO;
    cell.rowNowRobBtn.tag = indexPath.row;
    cell.taoBaoSCBtn.tag = indexPath.row;
    
    [cell.rowNowRobBtn addTarget:self action:@selector(rowNowAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.taoBaoSCBtn addTarget:self action:@selector(inShopAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

//进店
- (void)inShopAction:(UIButton *)taoBaoSCBtn{
    RSTaoBaoUserLikeModel * taobaoUserlikemodel = self.contentArray[taoBaoSCBtn.tag];
    RSTaoBaoShopViewController * taoBaoShopVc = [[RSTaoBaoShopViewController alloc]init];
//    taoBaoShopVc.taobaoUsermodel = self.taobaoUsermodel;
    taoBaoShopVc.tsUserId = taobaoUserlikemodel.tsUserId;
    [self.navigationController pushViewController:taoBaoShopVc animated:YES];
    
}


//马上抢
- (void)rowNowAction:(UIButton *)rowNowBtn{
    RSTaoBaoUserLikeModel * taobaoUserlikemodel = self.contentArray[rowNowBtn.tag];
    RSTaoBaoProductDetailsViewController * taobaoProductDetailsVc = [[RSTaoBaoProductDetailsViewController alloc]init];
    if ([taobaoUserlikemodel.stockType isEqualToString:@"huangliao"]) {
        taobaoProductDetailsVc.title = @"荒料";
    }else{
        taobaoProductDetailsVc.title = @"大板";
    }
//    taobaoProductDetailsVc.taobaoUsermodel = self.taobaoUsermodel;
    taobaoProductDetailsVc.tsUserId = taobaoUserlikemodel.userLikeID;
    [self.navigationController pushViewController:taobaoProductDetailsVc animated:YES];
}



- (void)fairReload{
    [self.tableview.mj_header beginRefreshing];
}



- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
