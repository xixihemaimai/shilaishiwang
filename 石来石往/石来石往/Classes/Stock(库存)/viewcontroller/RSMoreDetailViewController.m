//
//  RSMoreDetailViewController.m
//  石来石往
//
//  Created by mac on 17/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMoreDetailViewController.h"
#import "RSMoreCell.h"


#import "RSMoreHeaderSectionview.h"

#import "RSInformationModel.h"

#import "RSCompayWebviewViewController.h"

#import "RSInformationModel.h"


@interface RSMoreDetailViewController ()
{
    
    UIView * _naviBarview;
}


@property (nonatomic,strong)NSMutableArray *  modelDataArray;

//@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,assign)NSInteger pageNum;

@end

@implementation RSMoreDetailViewController
static NSString * HeaderID = @"headerid";



- (NSMutableArray *)modelDataArray{
    if (_modelDataArray == nil) {
        _modelDataArray = [NSMutableArray array];
    }
    return _modelDataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.title = @"海西资讯";
    
    self.pageNum = 2;
    
    
    
    [self getNewsListNetworkData];
    [self addCustomTableview];
}



- (void)addCustomTableview{
//    CGFloat Y;
//
//    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
//        Y = 64;
//    }else{
//        Y = 88;
//    }
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//    self.tableview = tableview;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableview];
//
//    //    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf getNewsListNetworkData];
//    }];
    
    RSWeakself

    //向下刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getNewsListNetworkData];
    }];
    
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf getNewsListMoreNetworkData];
    }];
    
    
}




- (void)getNewsListNetworkData{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"1" forKey:@"erpId"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"pageNum"];
    [dict setObject:[NSString stringWithFormat:@"10"] forKey:@"pageSize"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"status"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HAIXI_INFORMATION_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
//                NSMutableArray *array = nil;
                [weakSelf.modelDataArray removeAllObjects];
//                array = json[@"Data"];
                
                weakSelf.modelDataArray = [RSInformationModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                
//                for (int i = 0; i < array.count; i++) {
//                    RSInformationModel *informationModel = [[RSInformationModel alloc]init];
//                    informationModel.publisher = [[array objectAtIndex:i] objectForKey:@"publisher"];
//                    informationModel.publishTime = [[array objectAtIndex:i]objectForKey:@"publishTime"];
//                    informationModel.title = [[array objectAtIndex:i]objectForKey:@"title"];
//                    informationModel.type = [[array objectAtIndex:i]objectForKey:@"type"];
//                    //informationModel.url = [[array objectAtIndex:i]objectForKey:@"url"];
//                    informationModel.newsId = [[[array objectAtIndex:i]objectForKey:@"newsId"] integerValue];
//                    [weakSelf.modelDataArray addObject:informationModel];
//                }
                weakSelf.pageNum = 2;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                 [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
             [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}


- (void)getNewsListMoreNetworkData{
    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"1" forKey:@"erpId"];
    [dict setObject:[NSString stringWithFormat:@"%ld",self.pageNum] forKey:@"pageNum"];
    [dict setObject:[NSString stringWithFormat:@"10"] forKey:@"pageSize"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"status"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HAIXI_INFORMATION_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                //NSMutableArray *array = nil;
                //array = json[@"Data"];
                
                NSMutableArray * array = [RSInformationModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                
                [weakSelf.modelDataArray addObjectsFromArray:array];
//                for (int i = 0; i < array.count; i++) {
//                    RSInformationModel *informationModel = [[RSInformationModel alloc]init];
//                    informationModel.publisher = [[array objectAtIndex:i] objectForKey:@"publisher"];
//                    informationModel.publishTime = [[array objectAtIndex:i]objectForKey:@"publishTime"];
//                    informationModel.title = [[array objectAtIndex:i]objectForKey:@"title"];
//                    informationModel.type = [[array objectAtIndex:i]objectForKey:@"type"];
//                    //informationModel.url = [[array objectAtIndex:i]objectForKey:@"url"];
//                    informationModel.newsId = [[[array objectAtIndex:i]objectForKey:@"newsId"] integerValue];
//                    [weakSelf.modelDataArray addObject:informationModel];
//                }
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




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    RSMoreHeaderSectionview * moreHeaderview = [[RSMoreHeaderSectionview alloc]initWithReuseIdentifier:HeaderID];
    moreHeaderview.contentView.backgroundColor = [UIColor whiteColor];
    return moreHeaderview;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * moreCellID = @"morecell";
    
    
    RSMoreCell  * cell = [tableView dequeueReusableCellWithIdentifier:moreCellID];
    if (!cell) {
        cell = [[RSMoreCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:moreCellID];
        
    }
    RSInformationModel * informationModel = self.modelDataArray[indexPath.row];
    cell.informationModel = informationModel;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 20;
}

#pragma mark -- 和H5交互
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    RSInformationModel * informationModel = self.modelDataArray[indexPath.row];
    RSCompayWebviewViewController * companyVc = [[RSCompayWebviewViewController alloc]init];
    companyVc.showRightBtn = NO;
    companyVc.titleStr = @"海西货主";
    //域名 +  '/slsw/newDetail.html?newId=' + newId
    companyVc.urlStr = [NSString stringWithFormat:@"%@/slsw/newDetail.html?newId=%ld",URL_HEADER_TEXT_IOS,informationModel.newsId];
        
        //[self presentViewController:companyVc animated:YES completion:nil];
    [self.navigationController pushViewController:companyVc animated:YES];
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
