//
//  RSWarehouseSecondViewController.m
//  石来石往
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSWarehouseSecondViewController.h"
#import "RSRankModel.h"
#import "RSHSCell.h"
#import "RSLoginViewController.h"
#import "RSProductDetailViewController.h"
#import "RSHSSectionView.h"
//<UITableViewDelegate,UITableViewDataSource>
@interface RSWarehouseSecondViewController ()
//@property (nonatomic,strong)UITableView *tableview;


/**页数*/
@property (nonatomic,assign)NSInteger pageNum;

/**获取网络上面的数据*/
@property (nonatomic,strong)NSMutableArray * rankArray;

/**获取网络数据的参数*/
@property (nonatomic,assign)BOOL isRefresh;

@end

@implementation RSWarehouseSecondViewController


- (NSMutableArray *)rankArray{
    if (_rankArray == nil) {
        _rankArray = [NSMutableArray array];
    }
    return _rankArray;
    
    
}
//@synthesize userModel;
static NSString * WAREHOUSEFIRST = @"WAREHOUSEFIRST";
static NSString *hsCell = @"hscell";
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    //添加刷新按键
    self.pageNum = 2;
    [self addCustomTableview];
    [self loadNewData];
}


- (void)addCustomTableview{
//    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - 206) style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - 206);
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreNewData];
    }];
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
        [weakSelf loadNewData];
    }];
}

#pragma mark -- 海西石种排名(向下刷新)
- (void)loadNewData{
    self.isRefresh = true;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    if (verifyKey.length < 1) {
        verifyKey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSString stringWithFormat:@"%@",self.WLTYPE] forKey:@"wltype"];
    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"20"] forKey:@"item_num"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_STONE_RANKING withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue] ;
            
            if (Result) {
                    [weakSelf.rankArray removeAllObjects];
                    
                    //NSMutableArray *array = nil;
                    // array = json[@"Data"];
                
                weakSelf.rankArray = [RSRankModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
//                        for (int i = 0; i < array.count; i++) {
//                            RSRankModel *rankModel = [[RSRankModel alloc]init];
//                            rankModel.VAQty = [[[array objectAtIndex:i] objectForKey:@"VAQty"] floatValue];
//                            rankModel.deaCode = [[array objectAtIndex:i] objectForKey:@"deaCode"];
//                            rankModel.deaName = [[array objectAtIndex:i] objectForKey:@"deaName"];
//                            rankModel.monthRank = [[[array objectAtIndex:i] objectForKey:@"monthRank"] integerValue];
//                            rankModel.mtlCode = [[array objectAtIndex:i] objectForKey:@"mtlCode"];
//                            rankModel.mtlName = [[array objectAtIndex:i] objectForKey:@"mtlName"];
//                            rankModel.mtlType = [[[array objectAtIndex:i] objectForKey:@"mtlType"] integerValue];
//                            rankModel.period = [[array objectAtIndex:i] objectForKey:@"period"];
//                            [weakSelf.rankArray addObject:rankModel];
//                        }
                weakSelf.pageNum = 2;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
               // [SVProgressHUD dismiss];
            }else{
                //[SVProgressHUD dismiss];
                 [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            //[SVProgressHUD dismiss];
             [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

#pragma mark -- 海西石种排名(向上刷新)
- (void)loadMoreNewData{
    [SVProgressHUD showWithStatus:@"加载更多数据"];
    self.isRefresh = false;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    if (verifyKey.length < 1) {
        verifyKey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithBool:self.isRefresh] forKey:@"is_refresh"];
    [phoneDict setObject:[NSString stringWithFormat:@"%@",self.WLTYPE] forKey:@"wltype"];
    [phoneDict setObject:[NSString stringWithFormat:@"%ld",(long)self.pageNum] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"20"] forKey:@"item_num"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_STONE_RANKING withParameters:parameters withBlock:^(id json, BOOL success){
        if (success) {
            BOOL Result = [json[@"Result"] boolValue] ;
            if (Result) {
                NSMutableArray *array = nil;
                array = [RSRankModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                [weakSelf.rankArray addObjectsFromArray:array];
                weakSelf.pageNum++;
                [weakSelf.tableview.mj_footer endRefreshing];
                [weakSelf.tableview reloadData];
                [SVProgressHUD dismiss];
            }else{
                [SVProgressHUD dismiss];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSHSSectionView * hssectionview = [[RSHSSectionView alloc]initWithReuseIdentifier:WAREHOUSEFIRST];
    if ([self.WLTYPE isEqualToString:@"huangliao"]) {
        hssectionview.volumeLabel.text = @"体积";
    }else
    {
        hssectionview.volumeLabel.text = @"面积";
    }
    return hssectionview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rankArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSHSCell *cell = [tableView dequeueReusableCellWithIdentifier:hsCell];
    if (!cell) {
        cell = [[RSHSCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:hsCell
                ];
    }
    RSRankModel *rankModel = self.rankArray[indexPath.row];
    cell.rankModel = rankModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [UserManger checkLogin:self successBlock:^{
        RSRankModel * rankmodel = self.rankArray[indexPath.row];
        RSProductDetailViewController * productVc = [[RSProductDetailViewController alloc]init];
        productVc.productNameLabel = rankmodel.mtlName;
        productVc.WLTYPE = self.WLTYPE;
        productVc.userModel = self.userModel;
//        productVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productVc animated:YES];
    }];
    
    
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
//    if ( VERIFYKEY.length < 1) {
//        //self.hidesBottomBarWhenPushed = YES;
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//        loginVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginVc animated:YES];
//       // self.hidesBottomBarWhenPushed = NO;
//    }else{
//        //self.hidesBottomBarWhenPushed = YES;
//        RSRankModel * rankmodel = self.rankArray[indexPath.row];
//        RSProductDetailViewController * productVc = [[RSProductDetailViewController alloc]init];
//        productVc.hidesBottomBarWhenPushed = YES;
//        productVc.productNameLabel = rankmodel.mtlName;
//        productVc.WLTYPE = self.WLTYPE;
//        productVc.userModel = self.userModel;
//        [self.navigationController pushViewController:productVc animated:YES];
//        //self.hidesBottomBarWhenPushed = NO;
//    }
}

#pragma mark -- 返回首页控制器
//- (void)backViewControler{
//    [self.navigationController popViewControllerAnimated:YES];
//}

//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"isNewData" object:nil];
//}

- (void)dealloc{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
