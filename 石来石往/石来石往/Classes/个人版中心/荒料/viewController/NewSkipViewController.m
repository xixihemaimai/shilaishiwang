//
//  NewSkipViewController.m
//  TableViewFloat
//
//  Created by 李雪阳 on 2018/8/28.
//  Copyright © 2018年 singularity. All rights reserved.
//

#import "NewSkipViewController.h"
#import "RSNewSkipCell.h"
#import "RSFactoryFromMenuView.h"

#import "RSReportFormMenuView.h"
#import "RSOutPutRateModel.h"

@interface NewSkipViewController ()
@property (nonatomic ,strong)RSReportFormMenuView * menu;

@property (nonatomic,strong)NSMutableDictionary * menuDict;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * contentArray;

@end

@implementation NewSkipViewController
- (NSMutableDictionary *)menuDict{
    if (!_menuDict) {
        _menuDict = [NSMutableDictionary dictionary];
    }
    return _menuDict;
}

- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"出材率";
    //self.view.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.pageNum = 2;
    
    UIButton * blockBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [blockBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [blockBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    blockBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:blockBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    [blockBtn addTarget:self action:@selector(machiningAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
     
    [self.menuDict setObject:@"" forKey:@"mtlName"];
    [self.menuDict setObject:@"" forKey:@"blockNo"];
    [self.menuDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [self.menuDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    
    
    
    
    
    
    RSWeakself
    RSFactoryFromMenuView * reportformView = [[RSFactoryFromMenuView alloc]initWithFrame:CGRectMake(91, 0, [UIScreen mainScreen].bounds.size.width - 91, [UIScreen mainScreen].bounds.size.height)];
     reportformView.menuType = @"2";
    
    reportformView.showSelectMenu = ^(NSString * _Nonnull selectyType, NSString * _Nonnull beginTime, NSString * _Nonnull endTime, NSString * _Nonnull wuliaoTextView, NSString * _Nonnull blockTextView, NSString * _Nonnull wareHouseView, NSInteger wareHouseIndex, NSString * _Nonnull factoryView, NSInteger factoryIndex) {
       
        [weakSelf.menuDict setObject:wuliaoTextView forKey:@"mtlName"];
        [weakSelf.menuDict setObject:blockTextView forKey:@"blockNo"];
        
        [weakSelf.menuDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [weakSelf reloadTimberproductionNewData];
        [weakSelf.menu hidenWithAnimation];
    };
    
    
    
    RSReportFormMenuView *menu = [RSReportFormMenuView MenuViewWithDependencyView:self.view MenuView:reportformView isShowCoverView:YES];
    self.menu = menu;
    
    [self reloadTimberproductionNewData];
    
    

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.menuDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        
    }];
    //向上刷新
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
    }];
    
    
    [self.tableView setupEmptyDataText:@"暂无数据" tapBlock:^{
        
    }];
    
    
    
    
}


- (void)reloadTimberproductionNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.menuDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_OUTPUTRATE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.contentArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSOutPutRateModel * outPutRatemodel = [[RSOutPutRateModel alloc]init];
                    outPutRatemodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    outPutRatemodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    outPutRatemodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                    outPutRatemodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    outPutRatemodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    outPutRatemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    outPutRatemodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    outPutRatemodel.rate = [[array objectAtIndex:i]objectForKey:@"rate"];
                    [weakSelf.contentArray addObject:outPutRatemodel];
                }
                weakSelf.pageNum = 2;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header endRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [weakSelf.tableView.mj_header endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [weakSelf.tableView.mj_header endRefreshing];
        }
    }];
}



- (void)reloadTimberproductionMoreNewData{
    [self.menuDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.menuDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_OUTPUTRATE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                NSMutableArray * tempArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    RSOutPutRateModel * outPutRatemodel = [[RSOutPutRateModel alloc]init];
                    outPutRatemodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    outPutRatemodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    outPutRatemodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                    outPutRatemodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    outPutRatemodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    outPutRatemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    outPutRatemodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    outPutRatemodel.rate = [[array objectAtIndex:i]objectForKey:@"rate"];
                    [tempArray addObject:outPutRatemodel];
                }
                
                [weakSelf.contentArray addObjectsFromArray:tempArray];
                weakSelf.pageNum++;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_footer endRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [weakSelf.tableView.mj_footer endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    }];
}


- (void)machiningAction:(UIButton *)blockBtn{
    [self.menu show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * NEWSKIPCELLID = @"NEWSKIPCELLID";
    RSNewSkipCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWSKIPCELLID];
    if (!cell) {
        cell = [[RSNewSkipCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWSKIPCELLID];
    }
    RSOutPutRateModel * outPutRatemodel = self.contentArray[indexPath.row];
    cell.outPutRatemodel = outPutRatemodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
