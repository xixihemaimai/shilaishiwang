//
//  RSTaobaoSCContentViewController.m
//  石来石往
//
//  Created by mac on 2019/7/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaobaoSCContentViewController.h"

#import "RSTaoBaoSCContentCell.h"

#import "RSTaobaoSCShopCell.h"

//进店
#import "RSTaoBaoShopViewController.h"

#import "RSTaoBaoProductDetailsViewController.h"

@interface RSTaobaoSCContentViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * contentArray;

@end

@implementation RSTaobaoSCContentViewController
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
        _tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //updateSCData
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateSCData:) name:@"updateSCData" object:nil];
    
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fairReload) name:@"fairReload" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 2;
    
    [self.view addSubview:self.tableview];
    
    
    [self reloadCollectionListNewData];
    
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadCollectionListNewData];
    }];
    
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
         [weakSelf reloadCollectionListMoreNewData];
    }];
    
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
         [weakSelf reloadCollectionListNewData];
    }];
}


- (void)updateSCData:(NSNotification *)notification{
//    NSDictionary * infoDic = [notification object];
        // 这样就得到了我们在发送通知时候传入的字典了
//    NSString * str = [infoDic objectForKey:@"type"];
//    if ([str isEqualToString:@"shop"]) {
    //店铺
      [self reloadCollectionListNewData];
//    }
}



- (void)reloadCollectionListNewData{
    /**
    页码    pageNum    Int
    每页条数    pageSize    Int
    收藏类型    type    String    stone/shop 商品/店铺
    库存类型    stockType    String    huangliao/daban 荒料/大板 (类型为商品时传入)
    */
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
           verifykey = @"";
       }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSString * str = [NSString string];
    if ([self.title isEqualToString:@"荒料"]) {
        str = @"stone";
        [phoneDict setObject:@"huangliao" forKey:@"stockType"];
    }else if ([self.title isEqualToString:@"大板"]){
        str = @"stone";
        [phoneDict setObject:@"daban" forKey:@"stockType"];
    }else{
        str = @"shop";
    }
    [phoneDict setObject:str forKey:@"type"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_COLLECTIONLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
//                NSMutableArray * array = [NSMutableArray array];
                [weakSelf.contentArray removeAllObjects];
                if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]) {
//                    array = json[@"data"];
                    
                    weakSelf.contentArray = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json
                                             [@"data"]];
                    for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in weakSelf.contentArray) {
                        taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                    }
//                    for (int i = 0; i < array.count; i++) {
//                        RSTaoBaoUserLikeModel * taobaoUserLikemodel = [[RSTaoBaoUserLikeModel alloc]init];
//                        taobaoUserLikemodel.actId = [[[array objectAtIndex:i]objectForKey:@"actId"]integerValue];
//                        taobaoUserLikemodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"]integerValue];
//                        taobaoUserLikemodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
//                        taobaoUserLikemodel.userLikeID = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
//                        taobaoUserLikemodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
//                        taobaoUserLikemodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
//                        taobaoUserLikemodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
//                        taobaoUserLikemodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
//                        taobaoUserLikemodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
//                        taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
//                        taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
//                        taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
//                        taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
//                        taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
//                        taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
//                        taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
//                        taobaoUserLikemodel.imageUrl = [[array objectAtIndex:i]objectForKey:@"imageUrl"];
//                         taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
//                        taobaoUserLikemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
//                        NSMutableArray * temp = [NSMutableArray array];
//                        temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
//                        for (int j = 0; j < temp.count; j++) {
//                            RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
//                            videoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"]integerValue];
//                            videoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"]integerValue];
//                            videoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
//                            videoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
//                            [taobaoUserLikemodel.imageList addObject:videoAndPicturemodel];
//                        }
//                        [weakSelf.contentArray addObject:taobaoUserLikemodel];
//                    }
                }else{
                    weakSelf.contentArray = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json
                                             [@"data"]];
                    for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in weakSelf.contentArray) {
                        taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                    }
//                    array = json[@"data"];
//                    for (int i = 0; i < array.count; i++) {
//                        RSTaoBaoShopInformationModel * taobaoShopInformationmodel = [[RSTaoBaoShopInformationModel alloc]init];
//                        taobaoShopInformationmodel.address = [[array objectAtIndex:i]objectForKey:@"address"];
//                        taobaoShopInformationmodel.area =  [[array objectAtIndex:i]objectForKey:@"area"];
//                        taobaoShopInformationmodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"] integerValue];
//                         taobaoShopInformationmodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
//                        taobaoShopInformationmodel.shopInformationID =[[[array objectAtIndex:i]objectForKey:@"id"] integerValue];
//                          taobaoShopInformationmodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
//                        taobaoShopInformationmodel.phone = [[array objectAtIndex:i]objectForKey:@"phone"];
//                        taobaoShopInformationmodel.shopLogo = [[array objectAtIndex:i]objectForKey:@"shopLogo"];
//                        taobaoShopInformationmodel.shopName =[[array objectAtIndex:i]objectForKey:@"shopName"];
//                        taobaoShopInformationmodel.status = [[[array objectAtIndex:i]objectForKey:@"status"] integerValue];
//                        taobaoShopInformationmodel.sysUserId = [[[array objectAtIndex:i]objectForKey:@"sysUserId"] integerValue];
//                        taobaoShopInformationmodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
//                        taobaoShopInformationmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
//                        taobaoShopInformationmodel.userType = [[array objectAtIndex:i]objectForKey:@"userType"];
//                         taobaoShopInformationmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
//                        [weakSelf.contentArray addObject:taobaoShopInformationmodel];
//                    }
                }
                weakSelf.pageNum = 2;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取收藏列表失败"];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取收藏列表失败"];
            [weakSelf.tableview.mj_header endRefreshing];
            
        }
    }];
}



- (void)reloadCollectionListMoreNewData{
    /**
     页码    pageNum    Int
     每页条数    pageSize    Int
     收藏类型    type    String    stone/shop 商品/店铺
     库存类型    stockType    String    huangliao/daban 荒料/大板 (类型为商品时传入)
     */
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
           verifykey = @"";
       }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSString * str = [NSString string];
    if ([self.title isEqualToString:@"荒料"]) {
        str = @"stone";
        [phoneDict setObject:@"huangliao" forKey:@"stockType"];
    }else if ([self.title isEqualToString:@"大板"]){
        str = @"stone";
        [phoneDict setObject:@"daban" forKey:@"stockType"];
    }else{
        str = @"shop";
    }
    [phoneDict setObject:str forKey:@"type"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_COLLECTIONLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
//                NSMutableArray * array = [NSMutableArray array];
//                NSMutableArray * newTemp = [NSMutableArray array];
                if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]) {
                    NSMutableArray * array = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json
                                             [@"data"]];
                    for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in array) {
                        taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                    }
                    [weakSelf.contentArray addObjectsFromArray:array];
//                    array = json[@"data"];
//                    for (int i = 0; i < array.count; i++) {
//                        RSTaoBaoUserLikeModel * taobaoUserLikemodel = [[RSTaoBaoUserLikeModel alloc]init];
//                        taobaoUserLikemodel.actId = [[[array objectAtIndex:i]objectForKey:@"actId"]integerValue];
//                        taobaoUserLikemodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"]integerValue];
//                        taobaoUserLikemodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
//                        taobaoUserLikemodel.userLikeID = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
//                        taobaoUserLikemodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
//                        taobaoUserLikemodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
//                        taobaoUserLikemodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
//                        taobaoUserLikemodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
//                        taobaoUserLikemodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
//                        taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
//                        taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
//                        taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
//                        taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
//                        taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
//                        taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
//                        taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
//                        taobaoUserLikemodel.imageUrl = [[array objectAtIndex:i]objectForKey:@"imageUrl"];
//                         taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
//                        taobaoUserLikemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
//                        NSMutableArray * temp = [NSMutableArray array];
//                        temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
//                        for (int j = 0; j < temp.count; j++) {
//                            RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
//                            videoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"]integerValue];
//                            videoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"]integerValue];
//                            videoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
//                            videoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
//                            [taobaoUserLikemodel.imageList addObject:videoAndPicturemodel];
//                        }
//                        [newTemp addObject:taobaoUserLikemodel];
//                    }
                }else{
//                    array = json[@"data"];
//                    for (int i = 0; i < array.count; i++) {
//                        RSTaoBaoShopInformationModel * taobaoShopInformationmodel = [[RSTaoBaoShopInformationModel alloc]init];
//                        taobaoShopInformationmodel.address = [[array objectAtIndex:i]objectForKey:@"address"];
//                        taobaoShopInformationmodel.area =  [[array objectAtIndex:i]objectForKey:@"area"];
//                        taobaoShopInformationmodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"] integerValue];
//                        taobaoShopInformationmodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
//                        taobaoShopInformationmodel.shopInformationID =[[[array objectAtIndex:i]objectForKey:@"id"] integerValue];
//                        taobaoShopInformationmodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
//                        taobaoShopInformationmodel.phone = [[array objectAtIndex:i]objectForKey:@"phone"];
//                        taobaoShopInformationmodel.shopLogo = [[array objectAtIndex:i]objectForKey:@"shopLogo"];
//                        taobaoShopInformationmodel.shopName =[[array objectAtIndex:i]objectForKey:@"shopName"];
//                        taobaoShopInformationmodel.status = [[[array objectAtIndex:i]objectForKey:@"status"] integerValue];
//                        taobaoShopInformationmodel.sysUserId = [[[array objectAtIndex:i]objectForKey:@"sysUserId"] integerValue];
//                        taobaoShopInformationmodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
//                        taobaoShopInformationmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
//                        taobaoShopInformationmodel.userType = [[array objectAtIndex:i]objectForKey:@"userType"];
//                        taobaoShopInformationmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
//                        [newTemp addObject:taobaoShopInformationmodel];
//                    }
                    NSMutableArray * array = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json
                                             [@"data"]];
                    for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in array) {
                        taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                    }
                    [weakSelf.contentArray addObjectsFromArray:array];
                }
//                [weakSelf.contentArray addObjectsFromArray:newTemp];
                weakSelf.pageNum++;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取收藏列表失败"];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取收藏列表失败"];
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
    if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]) {
        return 108;
    }else{
        return 80;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * TAOBAOSCCONTENTCELLID = @"TAOBAOSCCONTENTCELLID";
    
    if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]) {
        RSTaoBaoSCContentCell * cell = [tableView dequeueReusableCellWithIdentifier:TAOBAOSCCONTENTCELLID];
        if (!cell) {
            cell = [[RSTaoBaoSCContentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TAOBAOSCCONTENTCELLID];
        }
        
        cell.taobaoUserlikemodel = self.contentArray[indexPath.row];
        
        cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        cell.rowNowRobBtn.hidden = YES;
        
        cell.mainScrollView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [cell.taoBaoSCBtn addTarget:self action:@selector(inShopAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.taoBaoSCBtn.tag = indexPath.row;
        RSWeakself
        cell.deleteAction = ^(NSIndexPath *indexPath) {
            [JHSysAlertUtil presentAlertViewWithTitle:@"提示" message:@"确实要删除该物料信息吗?" cancelTitle:@"确定" defaultTitle:@"取消" distinct:true cancel:^{
                [weakSelf cancelCollectionNewData:indexPath];
            } confirm:^{ 
            }];
//            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料信息吗?" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                 [weakSelf cancelCollectionNewData:indexPath];
//            }];
//            [alertView addAction:alert];
//            UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            }];
//            [alertView addAction:alert1];
//            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//                alertView.modalPresentationStyle = UIModalPresentationFullScreen;
//             }
//            [weakSelf presentViewController:alertView animated:YES completion:nil];
           
        };
        cell.scrollAction = ^{
            for (RSTaoBaoSCContentCell * tableViewCell in weakSelf.tableview.visibleCells) {
                /// 当屏幕滑动时，关闭不是当前滑动的cell
                if (tableViewCell.isOpen == YES && tableViewCell != cell) {
                    [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                }
            }
        };
        cell.joinBtn.tag = indexPath.row;
        [cell.joinBtn addTarget:self action:@selector(joinBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else{
        RSTaobaoSCShopCell * cell = [tableView dequeueReusableCellWithIdentifier:TAOBAOSCCONTENTCELLID];
        if (!cell) {
            cell = [[RSTaobaoSCShopCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TAOBAOSCCONTENTCELLID   ];
        }
        cell.taobaoShopInformationmodel = self.contentArray[indexPath.row];
        cell.joinShopBtn.tag = indexPath.row;
        [cell.joinShopBtn addTarget:self action:@selector(inShopAction:) forControlEvents:UIControlEventTouchUpInside];
        RSWeakself
        cell.deleteAction = ^(NSIndexPath *indexPath) {
            [JHSysAlertUtil presentAlertViewWithTitle:@"提示" message:@"确实要删除该物料信息吗?" cancelTitle:@"确定" defaultTitle:@"取消" distinct:true cancel:^{
                [weakSelf cancelCollectionNewData:indexPath];
            } confirm:^{
                
            }];
            
            
//            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料信息吗?" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//
//            }];
//            [alertView addAction:alert];
//            UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            }];
//            [alertView addAction:alert1];
//            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//
//                alertView.modalPresentationStyle = UIModalPresentationFullScreen;
//            }
//            [weakSelf presentViewController:alertView animated:YES completion:nil];
        };
        cell.scrollAction = ^{
            for (RSTaobaoSCShopCell * tableViewCell in weakSelf.tableview.visibleCells) {
                /// 当屏幕滑动时，关闭不是当前滑动的cell
                if (tableViewCell.isOpen == YES && tableViewCell != cell) {
                    [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                }
            }
        };
        cell.joinBtn.tag = indexPath.row;
        [cell.joinBtn addTarget:self action:@selector(joinBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}


- (void)joinBtnAction:(UIButton *)joinBtn{
    if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]){
        RSTaoBaoUserLikeModel * taobaoUserlikemodel = self.contentArray[joinBtn.tag];
        if (taobaoUserlikemodel.status != 1){
            [SVProgressHUD showInfoWithStatus:@"该商品已被下架"];
        }else{
            RSTaoBaoProductDetailsViewController * taobaoProductDetailsVc = [[RSTaoBaoProductDetailsViewController alloc]init];
            taobaoProductDetailsVc.tsUserId = taobaoUserlikemodel.userLikeID;
            [self.navigationController pushViewController:taobaoProductDetailsVc animated:YES];
        }
    }else{
        RSTaoBaoShopInformationModel * taobaoShopInformationmodel = self.contentArray[joinBtn.tag];
        if (taobaoShopInformationmodel.status != 1){
            [SVProgressHUD showInfoWithStatus:@"该店铺已停用"];
        }else{
            RSTaoBaoShopViewController * taoBaoShopVc = [[RSTaoBaoShopViewController alloc]init];
            taoBaoShopVc.tsUserId = taobaoShopInformationmodel.shopInformationID;
            [self.navigationController pushViewController:taoBaoShopVc animated:YES];
        }
    }
}



- (void)cancelCollectionNewData:(NSIndexPath *)indexpath{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"cancelCollection" forKey:@"optType"];
    if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]) {
        [phoneDict setObject:@"stone" forKey:@"type"];
        RSTaoBaoUserLikeModel * taobaoUserlikemodel = self.contentArray[indexpath.row];
        [phoneDict setObject:[NSNumber numberWithInteger:taobaoUserlikemodel.userLikeID] forKey:@"collId"];
        [phoneDict setObject:[NSNumber numberWithInteger:taobaoUserlikemodel.collectionId] forKey:@"collectionId"];
    }else{
        [phoneDict setObject:@"shop" forKey:@"type"];
        RSTaoBaoShopInformationModel * taobaoShopInformationmodel = self.contentArray[indexpath.row];
        [phoneDict setObject:[NSNumber numberWithInteger:taobaoShopInformationmodel.shopInformationID] forKey:@"collId"];
        [phoneDict setObject:[NSNumber numberWithInteger:taobaoShopInformationmodel.collectionId] forKey:@"collectionId"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_COLLECTIONOPT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf reloadCollectionListNewData];
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                 if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]) {
                    [dict setValue:@"stone" forKey:@"type"];
                 }else{
                    [dict setValue:@"shop" forKey:@"type"];
                 }
                [[NSNotificationCenter defaultCenter]postNotificationName:@"updateSCStatus" object:dict];
            }else{
                [SVProgressHUD showErrorWithStatus:@"操作失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"操作失败"];
        }
    }];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]){
        for (RSTaoBaoSCContentCell * tableViewCell in self.tableview.visibleCells) {
            /// 当屏幕滑动时，关闭被打开的cell
            if (tableViewCell.isOpen == YES) {
                [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
    }else{
        for (RSTaobaoSCShopCell * tableViewCell in self.tableview.visibleCells) {
            /// 当屏幕滑动时，关闭被打开的cell
            if (tableViewCell.isOpen == YES) {
                [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
    }
}


//进店
- (void)inShopAction:(UIButton *)taoBaoSCBtn{
    if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]){
        RSTaoBaoUserLikeModel * taobaoUserlikemodel = self.contentArray[taoBaoSCBtn.tag];
        if (taobaoUserlikemodel.status != 1){
            [SVProgressHUD showInfoWithStatus:@"该商品已被下架"];
        }else{
            RSTaoBaoShopViewController * taoBaoShopVc = [[RSTaoBaoShopViewController alloc]init];
            taoBaoShopVc.tsUserId = taobaoUserlikemodel.tsUserId;
            [self.navigationController pushViewController:taoBaoShopVc animated:YES];
        }
    }else{
        RSTaoBaoShopInformationModel * taobaoShopInformationmodel = self.contentArray[taoBaoSCBtn.tag];
        if (taobaoShopInformationmodel.status != 1){
            [SVProgressHUD showInfoWithStatus:@"该店铺已停用"];
        }else{
            RSTaoBaoShopViewController * taoBaoShopVc = [[RSTaoBaoShopViewController alloc]init];
            taoBaoShopVc.tsUserId = taobaoShopInformationmodel.shopInformationID;
            [self.navigationController pushViewController:taoBaoShopVc animated:YES];
        }
    }
}



- (void)fairReload{
    [self.tableview.mj_header beginRefreshing];
}





- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
