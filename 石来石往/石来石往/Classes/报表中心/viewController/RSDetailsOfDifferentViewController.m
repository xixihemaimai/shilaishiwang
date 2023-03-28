//
//  RSDetailsOfDifferentViewController.m
//  石来石往
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSDetailsOfDifferentViewController.h"


#import "RSDetailsOfChargesFirstCell.h"
#import "RSFeiYongModel.h"

#import "RSDetailsOfFristFootView.h"
@interface RSDetailsOfDifferentViewController ()


//@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,strong)NSMutableArray * feiArray;

@property (nonatomic,assign)NSInteger pageNum;





@end

@implementation RSDetailsOfDifferentViewController


- (NSMutableArray *)feiArray{
    
    if (_feiArray == nil) {
        _feiArray = [NSMutableArray array];
    }
    return _feiArray;
}


- (NSString *)businesstype{
    return @"";
}



- (NSString *)datefrom{
    return @"";
}

- (NSString *)dateto{
    return @"";
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self addDetailSofChargesCustomTableview];
    
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.pageNum = 2;
    
    [self feiLoadNewData];
    
    
}

- (void)addDetailSofChargesCustomTableview{
    
//    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - 64) style:UITableViewStylePlain];
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//
//    [self.view addSubview:self.tableview];
    
    
    RSWeakself
    //向下刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf feiLoadNewData];
    }];
    
    
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [weakSelf feiLoadMoreNewData];
        
    }];
    
    
//    [self.tableview setupEmptyDataText:@"获取数据" tapBlock:^{
//        [weakSelf feiLoadNewData];
//    }];
    
}




- (void)feiLoadNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInt:1] forKey:@"nowpage"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"pagesize"];
    [phoneDict setObject:[NSString stringWithFormat:@"%@",self.datefrom] forKey:@"datefrom"];
    [phoneDict setObject:[NSString stringWithFormat:@"%@",self.dateto] forKey:@"dateto"];
    [phoneDict setObject:[NSString stringWithFormat:@"%@",self.businesstype] forKey:@"businesstype"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_FEIYONGMINGXING_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                 [weakSelf.feiArray removeAllObjects];
                weakSelf.feiArray = [RSFeiYongModel mj_objectArrayWithKeyValuesArray:json[@"Data"][@"list"]];
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


- (void)feiLoadMoreNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"nowpage"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"pagesize"];
    [phoneDict setObject:[NSString stringWithFormat:@"%@",self.datefrom] forKey:@"datefrom"];
    [phoneDict setObject:[NSString stringWithFormat:@"%@",self.dateto] forKey:@"dateto"];
    [phoneDict setObject:[NSString stringWithFormat:@"%@",self.businesstype] forKey:@"businesstype"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_FEIYONGMINGXING_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
              NSMutableArray * array = [RSFeiYongModel mj_objectArrayWithKeyValuesArray:json[@"Data"][@"list"]];
                    [weakSelf.feiArray addObjectsFromArray:array];
                    [weakSelf.tableview.mj_footer endRefreshing];
                    [weakSelf.tableview reloadData];
                    weakSelf.pageNum++;
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
    return self.feiArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * DETAILSOFCHARGESID = @"detailsofchargesid";
    RSDetailsOfChargesFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:DETAILSOFCHARGESID];
    if (!cell) {
        cell = [[RSDetailsOfChargesFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DETAILSOFCHARGESID];
    }
//    if (indexPath.row == 0) {
//        cell.productLabel.text = @"荒料堆存费";
//    }else if (indexPath.row == 1){
//
//         cell.productLabel.text = @"大板堆存费";
//    }else if (indexPath.row == 2){
//         cell.productLabel.text = @"大板加工费";
//    }else if (indexPath.row == 3){
//         cell.productLabel.text = @"租金";
//    }else{
//         cell.productLabel.text = @"保存荒料堆存费";
//    }

    RSFeiYongModel * feiyongmodel = self.feiArray[indexPath.row];
    
    cell.productLabel.text = [NSString stringWithFormat:@"%@",feiyongmodel.feename];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",feiyongmodel.billdate];
    cell.priceLabel.text = [NSString stringWithFormat:@"%.3lf元",feiyongmodel.money];
    
    
    
    return cell;
}






- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.feiArray.count > 0) {
        return 0;
    }else{
       return 26;
    }
 
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString * DETAILSOFFRISTFOOT = @"detailsoffristfootid";
    RSDetailsOfFristFootView * detailsOfFootview = [[RSDetailsOfFristFootView alloc]initWithReuseIdentifier:DETAILSOFFRISTFOOT];
    return detailsOfFootview;
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
