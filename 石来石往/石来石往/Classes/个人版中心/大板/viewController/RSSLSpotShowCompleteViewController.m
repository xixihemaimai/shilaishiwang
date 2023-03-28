//
//  RSSLSpotShowCompleteViewController.m
//  石来石往
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLSpotShowCompleteViewController.h"
#import "RSSLSpotShowAreaCell.h"
#import "RSBLPerfectPictureViewController.h"
#import "RSSLSpotModel.h"

//#import "RSSLAllSelectSegmentViewController.h"

@interface RSSLSpotShowCompleteViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UIButton * _showBtn;
    
}

@property (nonatomic,strong)UITableView * tableview;


/**显示有多少cell的数组*/
@property (nonatomic,strong)NSMutableArray * contentArray;

@property (nonatomic,strong)RSSLSpotShowAreaCell * cell;


@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,assign)NSInteger totalcount;


@property (nonatomic,strong)UILabel * totalContentLabel;



@end

@implementation RSSLSpotShowCompleteViewController
- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}

- (NSMutableDictionary *)BLSpotDict{
    if (!_BLSpotDict) {
        _BLSpotDict = [NSMutableDictionary dictionary];
    }
    return _BLSpotDict;
}


static NSString * SLSPOTSHOWAREACELLID = @"SLSPOTSHOWAREACELLID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 2;
    //self.type = @"DETAIL";
    self.isReSelect = false;
    self.isAllSelect = false;
    
    [self.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"isPublic"];
    self.tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.estimatedRowHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableview];
    
    
    RSWeakself
    [self reloadSLCompleteSpotNewData];
    
    [self.tableview registerClass:[RSSLSpotShowAreaCell class] forCellReuseIdentifier:SLSPOTSHOWAREACELLID];
    
    
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
        [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"isPublic"];
        [weakSelf.selectArray removeAllObjects];
        weakSelf.isAllSelect = false;
        weakSelf.isReSelect = false;
        weakSelf.allBtn.selected = false;
        [weakSelf reloadSLCompleteSpotNewData];
    }];
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"isPublic"];
        [weakSelf reloadSLCompleteSpotMoreNewData];
    }];
    [self.tableview setupEmptyDataText:@"暂无数据" tapBlock:^{
//        [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
//        [weakSelf.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"isPublic"];
//        [weakSelf reloadSLCompleteSpotNewData];
    }];
    [self setBottomUI];
}

- (void)allSelectAction:(UIButton *)allBtn{
    
    if (self.contentArray.count > 0) {
        allBtn.selected = !allBtn.selected;
        if (allBtn.selected) {
            // 全选
            self.isAllSelect = true;
            self.isReSelect = true;
            [self.selectArray removeAllObjects];
        }else{
            //取消全选
            self.isAllSelect = false;
            self.isReSelect = false;
            [self.selectArray removeAllObjects];
            
        }
        [self.tableview reloadData];
        
     }else{
        [SVProgressHUD showInfoWithStatus:@"当前没有数据"];
    }
    
    
}


- (void)reloadSLCompleteSpotNewData{
    [self.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"isPublic"];
    [self.BLSpotDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.type forKey:@"type"];
    [phoneDict setObject:self.BLSpotDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SLBALANACE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.contentArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                weakSelf.totalcount = [json[@"data"][@"count"] integerValue];
                weakSelf.totalContentLabel.text = [NSString stringWithFormat:@"%ld/%ld匝",(long)weakSelf.totalcount,(long)self.selectArray.count];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSSLSpotModel * slspotmodel = [[RSSLSpotModel alloc]init];
                    slspotmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    slspotmodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                    slspotmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    slspotmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slspotmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slspotmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    slspotmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    slspotmodel.totalQty = [[[array objectAtIndex:i]objectForKey:@"totalQty"] integerValue];
                    slspotmodel.totalVaQty = [[array objectAtIndex:i]objectForKey:@"totalVaQty"];
                    slspotmodel.did = weakSelf.contentArray.count;
                    [weakSelf.contentArray addObject:slspotmodel];
                }
                weakSelf.pageNum = 2;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}



- (void)reloadSLCompleteSpotMoreNewData{
    [self.BLSpotDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.type forKey:@"type"];
    [phoneDict setObject:self.BLSpotDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SLBALANACE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableArray * array = [NSMutableArray array];
                //NSMutableArray * tempArray = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSSLSpotModel * slspotmodel = [[RSSLSpotModel alloc]init];
                    slspotmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    slspotmodel.length = [[array objectAtIndex:i]objectForKey:@"length"];
                    slspotmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    slspotmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slspotmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slspotmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    slspotmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    slspotmodel.totalQty = [[[array objectAtIndex:i]objectForKey:@"totalQty"] integerValue];
                    slspotmodel.totalVaQty = [[array objectAtIndex:i]objectForKey:@"totalVaQty"];
                    
                    slspotmodel.did = weakSelf.contentArray.count;
                    [weakSelf.contentArray addObject:slspotmodel];
                  //  [tempArray addObject:slspotmodel];
                }
                //[weakSelf.contentArray addObjectsFromArray:tempArray];
                weakSelf.pageNum++;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}





- (void)setBottomUI{
    UIView * bottomView = [[UIView alloc]init];
    if (iphonex) {
        bottomView.frame = CGRectMake(0, self.view.frame.size.height - 180, SCW, 50);
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 180, 0);
    }else if (iPhone6){
        
        bottomView.frame = CGRectMake(0, self.view.frame.size.height - 150, SCW, 50);
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    }else if (iPhone6p){
        
        bottomView.frame = CGRectMake(0, self.view.frame.size.height - 150, SCW, 50);
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
        
    }else if (iPhoneXR){
        bottomView.frame = CGRectMake(0, self.view.frame.size.height - 180, SCW, 50);
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 180, 0);
    }else if (iPhoneXS){
        
        bottomView.frame = CGRectMake(0, self.view.frame.size.height - 180, SCW, 50);
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 180, 0);
    }else if (iPhoneXSMax){
        bottomView.frame = CGRectMake(0, self.view.frame.size.height - 180, SCW, 50);
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 180, 0);
    }else{
        
        bottomView.frame = CGRectMake(0, self.view.frame.size.height - 150, SCW, 50);
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    }
    
    bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:bottomView];
    [bottomView bringSubviewToFront:self.view];
    
    
    //全选
    UIButton * allBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 100, 30)];
    [allBtn setTitle:@"全选" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    [allBtn setImage:[UIImage imageNamed:@"Oval 9"] forState:UIControlStateNormal];
    [allBtn setImage:[UIImage imageNamed:@"个人选中"] forState:UIControlStateSelected];
    allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [allBtn setBackgroundColor:[UIColor clearColor]];
    [allBtn addTarget:self action:@selector(allSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    allBtn.titleLabel.sd_layout
    .leftSpaceToView(allBtn.imageView, 6)
    .widthIs(70);
    _allBtn = allBtn;
    [bottomView addSubview:allBtn];
    
    
    
    UIButton * showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showBtn setTitle:@"取消展示" forState:UIControlStateNormal];
    showBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    showBtn.frame = CGRectMake(SCW - 89, 10, 76, 28);
    [showBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [showBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [bottomView addSubview:showBtn];
    showBtn.layer.cornerRadius = 15;
    
    [showBtn addTarget:self action:@selector(showSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    _showBtn = showBtn;
    
    
    //合计
    UILabel * totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW - 89 - 100, 10, 30, 30)];
    totalLabel.text = @"合计";
    totalLabel.textAlignment = NSTextAlignmentLeft;
    totalLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    totalLabel.font = [UIFont systemFontOfSize:12];
    [bottomView addSubview:totalLabel];
    
    //内容
    UILabel * totalContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totalLabel.frame), 10, 70, 30)];
    totalContentLabel.text = @"0颗";
    totalContentLabel.textAlignment = NSTextAlignmentLeft;
    totalContentLabel.textColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    totalContentLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:totalContentLabel];
     _totalContentLabel = totalContentLabel;
}



//展示和取消展示的按键
- (void)showSelectAction:(UIButton *)showBtn{
    if (self.contentArray.count > 0) {
        //展示
        if (self.isReSelect == true) {
            //反选
            /**
             类型    type    String     all  表示全选+反选列表 sel 表示选中列表
             状态    status    Int     0表示取消展示 1表示设置展示
             库存类型    stockType    String     SL 大板  BL荒料
             查询类    billViewFilter    BillViewFilter    与单据序时簿(单据列表)过滤同一个类,添加了加工厂查询字段
             反选列表    exceptArr    Array    [{blockNo:'2121',turnsNo:''}]
             
             选择列表    selectedArr    Array    [{mtlName: '白玉兰',blockNo:'2121',turnsNo:''}]
             */
            [SVProgressHUD showWithStatus:@"请求中..........."];
            [self.BLSpotDict setObject:[NSNumber numberWithInteger:1000000] forKey:@"pageSize"];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
            NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
            [phoneDict setObject:@"all" forKey:@"type"];
            [phoneDict setObject:self.BLSpotDict forKey:@"billViewFilter"];
            [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"status"];
            [phoneDict setObject:@"SL" forKey:@"stockType"];
            if (self.selectArray.count > 0) {
                NSMutableArray * exceptArr = [NSMutableArray array];
                for (int i = 0; i < self.selectArray.count; i++) {
                    RSSLSpotModel * slspotmodel = self.selectArray[i];
                    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                    [dict setObject:slspotmodel.blockNo forKey:@"blockNo"];
                    [dict setObject:slspotmodel.turnsNo forKey:@"turnsNo"];
                    [exceptArr addObject:dict];
                }
                [phoneDict setObject:exceptArr forKey:@"exceptArr"];
            }else{
                NSArray * exceptArr = @[];
                [phoneDict setObject:exceptArr forKey:@"exceptArr"];
            }
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            RSWeakself
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_PUBLICSTOCK_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL isresult = [json[@"success"] boolValue];
                    if (isresult) {
                        [SVProgressHUD dismiss];
                        [weakSelf reloadSLCompleteSpotNewData];
                        weakSelf.isReSelect = false;
                        weakSelf.isAllSelect = false;
                        [weakSelf.selectArray removeAllObjects];
                        weakSelf.allBtn.selected = false;
                        if ([weakSelf.delegate respondsToSelector:@selector(cancelSLShowBlockNewData)]) {
                            [weakSelf.delegate cancelSLShowBlockNewData];
                        }
                    }else{
                        [SVProgressHUD showInfoWithStatus:@"展示错误"];
                    }
                }else{
                    [SVProgressHUD showInfoWithStatus:@"展示错误"];
                }
            }];
        }else{
            //选择
            if (self.selectArray.count > 0) {
                /**
                 类型    type    String     all  表示全选+反选列表 sel 表示选中列表
                 状态    status    Int     0表示取消展示 1表示设置展示
                 库存类型    stockType    String     SL 大板  BL荒料
                 查询类    billViewFilter    BillViewFilter    与单据序时簿(单据列表)过滤同一个类,添加了加工厂查询字段
                 反选列表    exceptArr    Array    [{blockNo:'2121',turnsNo:''}]
                 
                 选择列表    selectedArr    Array    [{mtlName: '白玉兰',blockNo:'2121',turnsNo:''}]
                 */
                 [SVProgressHUD showWithStatus:@"请求中..........."];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
                NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
                [phoneDict setObject:@"sel" forKey:@"type"];
                [phoneDict setObject:self.BLSpotDict forKey:@"billViewFilter"];
                [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"status"];
                [phoneDict setObject:@"SL" forKey:@"stockType"];
                if (self.selectArray.count > 0) {
                    NSMutableArray * selectedArr = [NSMutableArray array];
                    for (int i = 0; i < self.selectArray.count; i++) {
                        RSSLSpotModel * slspotmodel = self.selectArray[i];
                        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                        [dict setObject:slspotmodel.blockNo forKey:@"blockNo"];
                        [dict setObject:slspotmodel.turnsNo forKey:@"turnsNo"];
                        [dict setObject:slspotmodel.mtlName forKey:@"mtlName"];
                        [selectedArr addObject:dict];
                    }
                    [phoneDict setObject:selectedArr forKey:@"selectedArr"];
                }
                NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
                NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                RSWeakself
                XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                [network getDataWithUrlString:URL_PUBLICSTOCK_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                    if (success) {
                        BOOL isresult = [json[@"success"] boolValue];
                        if (isresult) {
                            [SVProgressHUD dismiss];
                            [weakSelf reloadSLCompleteSpotNewData];
                            weakSelf.isReSelect = false;
                            weakSelf.isAllSelect = false;
                            [weakSelf.selectArray removeAllObjects];
                            weakSelf.allBtn.selected = false;
                            if ([weakSelf.delegate respondsToSelector:@selector(cancelSLShowBlockNewData)]) {
                                [weakSelf.delegate cancelSLShowBlockNewData];
                            }
                        }else{
                            [SVProgressHUD showInfoWithStatus:@"展示错误"];
                        }
                    }else{
                        [SVProgressHUD showInfoWithStatus:@"展示错误"];
                    }
                }];
            }else{
                [SVProgressHUD showInfoWithStatus:@"你没有选择要展示的数据"];
            }
        }
        
    }else{
    
        [SVProgressHUD showInfoWithStatus:@"当前没有数据"];
    
    }
    
   
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 255;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.cell = [tableView dequeueReusableCellWithIdentifier:SLSPOTSHOWAREACELLID];
    RSSLSpotModel * slspotmodel = self.contentArray[indexPath.row];
    if (self.isReSelect == true) {
        //点击全选的时候走的方法
        if (self.selectArray.count > 0) {
            for (int j = 0; j < self.selectArray.count; j++) {
                RSSLSpotModel * slspotmodel1 = self.selectArray[j];
                if (slspotmodel1.did == slspotmodel.did) {
                    _cell.selectedStutas = false;
                    break;
                }else{
                    _cell.selectedStutas = true;
                }
            }
        }else{
            _cell.selectedStutas = true;
        }
        self.totalContentLabel.text = [NSString stringWithFormat:@"%ld/%ld匝",(long)self.totalcount,(long)self.totalcount - (long)self.selectArray.count];
    }else{
        if (self.selectArray.count > 0) {
            //当再次选择搜索的时候
            for (int j = 0; j < self.selectArray.count; j++) {
                RSSLSpotModel * slspotmodel1 = self.selectArray[j];
                if (slspotmodel1.did == slspotmodel.did) {
                    _cell.selectedStutas = true;
                    break;
                }else{
                    _cell.selectedStutas = false;
                }
            }
        }else{
            _cell.selectedStutas = false;
        }
        self.totalContentLabel.text = [NSString stringWithFormat:@"%ld/%ld匝",(long)self.totalcount,(long)self.selectArray.count];
    }
    __weak typeof(self) weakSelf = self;
    self.cell.ChoseBtnBlock = ^(__weak UITableViewCell *tapCell, BOOL selected) {
        //使用model动态记录cell按钮选中情况
       // NSIndexPath *path = [tableView indexPathForCell:tapCell];
        //RSBlockModel *model = [weakSelf.tempArray objectAtIndex:path.row];
        if (weakSelf.isReSelect == true) {
            if (selected == false) {
                [weakSelf.selectArray addObject:slspotmodel];
                weakSelf.isAllSelect = false;
                weakSelf.allBtn.selected = false;
            }
            else{
                for (int i = 0; i < weakSelf.selectArray.count; i++) {
                    RSSLSpotModel * slspotmodel1 = weakSelf.selectArray[i];
                    if (slspotmodel1.did == slspotmodel.did) {
                        [weakSelf.selectArray removeObjectAtIndex:i];
                        break;
                    }
                }
                if (weakSelf.selectArray.count == 0) {
                    weakSelf.isAllSelect = true;
                    weakSelf.allBtn.selected = true;
                }
            }
            weakSelf.totalContentLabel.text = [NSString stringWithFormat:@"%ld/%ld匝",(long)weakSelf.totalcount,(long)weakSelf.totalcount - (long)weakSelf.selectArray.count];
        }else{
            //一步一步的选择
            if (selected == YES) {
                [weakSelf.selectArray addObject:slspotmodel];
                if (weakSelf.selectArray.count == self.totalcount) {
                    weakSelf.isAllSelect = true;
                    weakSelf.allBtn.selected = true;
                }
            }else{
                for (int i = 0; i < weakSelf.selectArray.count; i++) {
                    RSSLSpotModel * slspotmodel1 = weakSelf.selectArray[i];
                    if (slspotmodel1.did == slspotmodel.did) {
                        [weakSelf.selectArray removeObjectAtIndex:i];
                        break;
                    }
                }
                weakSelf.isAllSelect = false;
                weakSelf.allBtn.selected = false;
            }
            weakSelf.totalContentLabel.text = [NSString stringWithFormat:@"%ld/%ld匝",(long)weakSelf.totalcount,(long)weakSelf.selectArray.count];
        }
    };
    
    [_cell.completeBtn addTarget:self action:@selector(perfectPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    _cell.completeBtn.tag = indexPath.row + 10000;
    _cell.showProductLabel.text = slspotmodel.blockNo;
    _cell.showTurnLabel.text = [NSString stringWithFormat:@"匝号:%@",slspotmodel.turnsNo];
    _cell.showNameDetailLabel.text = slspotmodel.mtlName;
    _cell.showTypeDetailLabel.text = slspotmodel.mtltypeName;
    _cell.showShapeDetailLabel.text = [NSString stringWithFormat:@"%0.1lf | %0.1lf ",[slspotmodel.length floatValue],[slspotmodel.width floatValue]];
    _cell.showAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slspotmodel.height floatValue]];
    _cell.showWightDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slspotmodel.totalVaQty floatValue]];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return _cell;
}


- (void)perfectPictureAction:(UIButton *)completeBtn{
    RSSLSpotModel * slspotmodel = self.contentArray[completeBtn.tag - 10000];
    RSBLPerfectPictureViewController * blPerfectPictureVc = [[RSBLPerfectPictureViewController alloc]init];
    blPerfectPictureVc.usermodel = self.usermodel;
    blPerfectPictureVc.stockType = @"SL";
    blPerfectPictureVc.mtlName = slspotmodel.mtlName;
    blPerfectPictureVc.blockNo = slspotmodel.blockNo;
    blPerfectPictureVc.turnsNo = slspotmodel.turnsNo;
    [self.navigationController pushViewController:blPerfectPictureVc animated:YES];
    
}






@end
