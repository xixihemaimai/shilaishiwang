//
//  RSTaoBaoShopManagementViewController.m
//  石来石往
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoShopManagementViewController.h"


#import "RSTaoBaoShopManagementCell.h"

#import "RSTaoBaoProdectDetailViewController.h"


//模型
#import "RSTaoBaoMangementModel.h"

@interface RSTaoBaoShopManagementViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    CAShapeLayer * _maskLayer2;
    
    CAShapeLayer * _maskLayer;
    
    
    UILabel * _totalProductLabel;
}

@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,strong) UIButton * onShelfBtn;

@property (nonatomic,strong)UIButton * noShelfBtn;

@property (nonatomic,strong)NSMutableArray * contentArray;


@property (nonatomic,assign)NSInteger pageNum;


@property (nonatomic,assign)NSInteger selectType;

@end

@implementation RSTaoBaoShopManagementViewController
- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNotificationAction:) name:@"saveAndUpdate" object:nil];
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNum = 2;
    
    self.selectType = 1;
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH) style:UITableViewStylePlain];
    self.tableview = tableview;
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
    
    [self setTableViewCustomHeaderView];
    
    
    [self loadNewData];
    
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadNewMoreData];
    }];
    
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
        [weakSelf loadNewData];
    }];
    
    
    
    
    
}


- (void)getNotificationAction:(NSNotification *)notification{
//    NSDictionary * infoDic = [notification object];
//    // 这样就得到了我们在发送通知时候传入的字典了
//    if ([infoDic objectForKey:@"Type"]) {
//        
//        
//    }
    [self loadNewData];
}


- (void)loadNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    //URL_TAOBAOGETINVENTORYLIST_IOS
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSString * str = [NSString string];
    if ([self.title isEqualToString:@"荒料"]) {
        str = @"huangliao";
    }else{
        str = @"daban";
    }
    [phoneDict setObject:str forKey:@"stockType"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.selectType] forKey:@"status"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_TAOBAOGETINVENTORYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            [weakSelf.contentArray removeAllObjects];
            if (isresult) {
//                NSMutableArray * array = [NSMutableArray array];
//                array = json[@"data"][@"list"];
//                for (int i = 0; i < array.count; i++) {
//                    RSTaoBaoMangementModel * taobaoManagementmodel = [[RSTaoBaoMangementModel alloc]init];
//                    taobaoManagementmodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
//                    taobaoManagementmodel.mangementID = [[[array objectAtIndex:i]objectForKey:@"id"] integerValue];
//                    taobaoManagementmodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
//                    taobaoManagementmodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
//                    taobaoManagementmodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
//                    taobaoManagementmodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
//                    taobaoManagementmodel.status = [[[array  objectAtIndex:i]objectForKey:@"status"]integerValue];
//                    taobaoManagementmodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
//                    taobaoManagementmodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
//                    taobaoManagementmodel.tsUserId = [[array objectAtIndex:i]objectForKey:@"tsUserId"];
//                    taobaoManagementmodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
//                    taobaoManagementmodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
//                    taobaoManagementmodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
//                    taobaoManagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
//                    NSMutableArray * temp = [NSMutableArray array];
//                    temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
//                    for (int j = 0; j < temp.count; j++) {
//                        //[taobaoManagementmodel.imageList addObject:temp[j]];
//                        RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
//                        taobaoVideoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"] integerValue];
//                        taobaoVideoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
//                        taobaoVideoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"] integerValue];
//                        taobaoVideoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
//                        [taobaoManagementmodel.imageList addObject:taobaoVideoAndPicturemodel];
//                    }
//                    [weakSelf.contentArray addObject:taobaoManagementmodel];
//                }
                weakSelf.contentArray = [RSTaoBaoMangementModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                for (RSTaoBaoMangementModel * taobaoManagementmodel in weakSelf.contentArray) {
                    taobaoManagementmodel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoManagementmodel.imageList];
                }
                _totalProductLabel.text = [NSString stringWithFormat:@"共%@个商品",json[@"data"][@"count"]];
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


- (void)loadNewMoreData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSString * str = [NSString string];
    if ([self.title isEqualToString:@"荒料"]) {
        str = @"huangliao";
    }else{
        str = @"daban";
    }
    [phoneDict setObject:str forKey:@"stockType"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.selectType] forKey:@"status"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_TAOBAOGETINVENTORYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
//                NSMutableArray * contentTemp = [NSMutableArray array];
//                NSMutableArray * array = [NSMutableArray array];
//                array = json[@"data"][@"list"];
//                for (int i = 0; i < array.count; i++) {
//                    RSTaoBaoMangementModel * taobaoManagementmodel = [[RSTaoBaoMangementModel alloc]init];
//                    taobaoManagementmodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
//                    taobaoManagementmodel.mangementID = [[[array objectAtIndex:i]objectForKey:@"id"] integerValue];
//                    taobaoManagementmodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
//                    taobaoManagementmodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
//                    taobaoManagementmodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
//                    taobaoManagementmodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
//                    taobaoManagementmodel.status = [[[array  objectAtIndex:i]objectForKey:@"status"]integerValue];
//                    taobaoManagementmodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
//                    taobaoManagementmodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
//                    taobaoManagementmodel.tsUserId = [[array objectAtIndex:i]objectForKey:@"tsUserId"];
//                    taobaoManagementmodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
//                    taobaoManagementmodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
//                    taobaoManagementmodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
//                    taobaoManagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
//                    NSMutableArray * temp = [NSMutableArray array];
//                    temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
//                    for (int j = 0; j < temp.count; j++) {
//                        //[taobaoManagementmodel.imageList addObject:temp[j]];
//                        RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
//                        taobaoVideoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"] integerValue];
//                        taobaoVideoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
//                        taobaoVideoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"] integerValue];
//                        taobaoVideoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
//                        [taobaoManagementmodel.imageList addObject:taobaoVideoAndPicturemodel];
//                    }
//                    [contentTemp addObject:taobaoManagementmodel];
//                }
                NSMutableArray * array = [RSTaoBaoMangementModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                for (RSTaoBaoMangementModel * taobaoManagementmodel in array) {
                    taobaoManagementmodel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoManagementmodel.imageList];
                }
                [weakSelf.contentArray addObjectsFromArray:array];
                _totalProductLabel.text = [NSString stringWithFormat:@"共%@个商品",json[@"data"][@"count"]];
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









- (void)setTableViewCustomHeaderView{
    
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    
    
    
    UILabel * totalProductLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 11, SCW/2, 17)];
    totalProductLabel.text = @"共0个商品";
    totalProductLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    totalProductLabel.textAlignment = NSTextAlignmentLeft;
    totalProductLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:totalProductLabel];
    _totalProductLabel = totalProductLabel;
    
    
    //添加
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(SCW/2 + 10, 11, 50, 20);
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    addBtn.layer.cornerRadius = 10;
    addBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#979797"].CGColor;
    addBtn.layer.borderWidth = 1;
    
    
    
    
    
    //按键的view
//    UIView * btnView = [[UIView alloc]initWithFrame:CGRectMake(SCW - 12 - 100, 11, 100, 20)];
//    btnView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    [headerView addSubview:btnView];
//    btnView.layer.cornerRadius = 10;
//    btnView.layer.borderWidth = 1;
//    btnView.layer.borderColor = [UIColor colorWithHexColorStr:@"#979797"].CGColor;
//
    
    
   
    //已上架
    UIButton * onShelfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [onShelfBtn setTitle:@"已上架" forState:UIControlStateNormal];
    [onShelfBtn setTitleColor:[UIColor colorWithHexColorStr:@"#D3D3D3"] forState:UIControlStateNormal];
    [onShelfBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateSelected];
    [onShelfBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#fEfEfE"]];
    onShelfBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    onShelfBtn.selected = true;
    [onShelfBtn addTarget:self action:@selector(onShelfAcion:) forControlEvents:UIControlEventTouchUpInside];
    _onShelfBtn = onShelfBtn;
    
    
    
    //未上架
    UIButton * noShelfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [noShelfBtn setTitle:@"未上架" forState:UIControlStateNormal];
    [noShelfBtn setTitleColor:[UIColor colorWithHexColorStr:@"#D3D3D3"] forState:UIControlStateNormal];
    [noShelfBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateSelected];
    noShelfBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [noShelfBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    noShelfBtn.selected = false;
    [noShelfBtn addTarget:self action:@selector(noShelfAcion:) forControlEvents:UIControlEventTouchUpInside];
    _noShelfBtn = noShelfBtn;
    
    
    onShelfBtn.frame = CGRectMake(SCW - 12 - 100, 11, 50, 20);
    noShelfBtn.frame = CGRectMake(SCW - 12 - 50 , 11 , 50, 20);
 
    
    [headerView addSubview:onShelfBtn];
    [headerView addSubview:noShelfBtn];
    

    
    UIBezierPath * maskPath2 = [UIBezierPath bezierPathWithRoundedRect:onShelfBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft  cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer * maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.path = maskPath2.CGPath;
    maskLayer2.frame = onShelfBtn.bounds;
   // maskLayer2.lineWidth = 1;
    maskLayer2.fillColor = [UIColor clearColor].CGColor;
    maskLayer2.strokeColor = [UIColor colorWithHexColorStr:@"#979797"].CGColor;
    [onShelfBtn.layer addSublayer:maskLayer2];
    _maskLayer2 = maskLayer2;
    
    CGRect rect = CGRectMake(0.2, 0, 50, 20);
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight  cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = rect;
    //maskLayer.lineWidth = 1;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.strokeColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
    [noShelfBtn.layer addSublayer:maskLayer];
    _maskLayer = maskLayer;

    
    [headerView setupAutoHeightWithBottomView:totalProductLabel bottomMargin:11];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    
}


//已上架
- (void)onShelfAcion:(UIButton *)onshelfBtn{
    [_onShelfBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#fefefe"]];
    [_noShelfBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    _onShelfBtn.selected = YES;
    _noShelfBtn.selected = NO;
    _maskLayer2.strokeColor = [UIColor colorWithHexColorStr:@"#979797"].CGColor;
    _maskLayer.strokeColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
    self.selectType = 1;
    [self loadNewData];
    
}

//未上架
- (void)noShelfAcion:(UIButton *)noshelfBtn{
    [_noShelfBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#fefefe"]];
    [_onShelfBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    _noShelfBtn.selected = YES;
    _onShelfBtn.selected = NO;
    _maskLayer2.strokeColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
    _maskLayer.strokeColor = [UIColor colorWithHexColorStr:@"#979797"].CGColor;
    self.selectType = 0;
    [self loadNewData];
}


//上面的添加
- (void)addAction:(UIButton *)addBtn{
    RSTaoBaoProdectDetailViewController * taobaoProductDetailVc = [[RSTaoBaoProdectDetailViewController alloc]init];
    taobaoProductDetailVc.type = self.title;
    if ([self.title isEqualToString:@"荒料"]) {
        taobaoProductDetailVc.joinType = 0;
    }else{
        taobaoProductDetailVc.joinType = 3;
    }
    taobaoProductDetailVc.typeStatus = @"未上架";
    taobaoProductDetailVc.taobaoUsermodel = self.taobaoUsermodel;
    [self.navigationController pushViewController:taobaoProductDetailVc animated:YES];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 106;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * TAOBAOSHOPMANGEMENTCELLID = @"TAOBAOSHOPMANGEMENTCELLID";
    RSTaoBaoMangementModel * taobaomangementmodel = self.contentArray[indexPath.row];
    RSTaoBaoShopManagementCell * cell = [tableView dequeueReusableCellWithIdentifier:TAOBAOSHOPMANGEMENTCELLID];
    if (!cell) {
        cell = [[RSTaoBaoShopManagementCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TAOBAOSHOPMANGEMENTCELLID];
    }
    cell.taobaomanagementmodel = taobaomangementmodel;
    cell.noShelfBtn.tag = indexPath.row;
    cell.editBtn.tag = indexPath.row;
    cell.deleteBtn.tag = indexPath.row;
    if (taobaomangementmodel.status == 1) {
        cell.deleteBtn.hidden = YES;
        [cell.noShelfBtn setTitle:@"下架" forState:UIControlStateNormal];
        [cell.editBtn setTitle:@"详情" forState:UIControlStateNormal];
    }else{
        cell.deleteBtn.hidden = NO;
        [cell.noShelfBtn setTitle:@"上架" forState:UIControlStateNormal];
        [cell.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    [cell.noShelfBtn addTarget:self action:@selector(noShelfAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}






//下架
- (void)noShelfAction:(UIButton *)noShelfBtn{
    RSTaoBaoMangementModel * taobaomangementmodel = self.contentArray[noShelfBtn.tag];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    //URL_TAOBAOGETINVENTORYLIST_IOS
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSMutableArray * array = [NSMutableArray array];
    [array addObject:[NSNumber numberWithInteger:taobaomangementmodel.mangementID]];
    [phoneDict setObject:array forKey:@"ids"];
    if ([noShelfBtn.currentTitle isEqualToString:@"下架"]) {
        //下架
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"status"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_TAOBAOUPDATEINVENTORYST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    [weakSelf loadNewData];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"下架失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"下架失败"];
            }
        }];
    }else{
        //上架
        if (taobaomangementmodel.isComplete == 1) {
            [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"status"];
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            RSWeakself
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_TAOBAOUPDATEINVENTORYST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL isresult = [json[@"success"]boolValue];
                    if (isresult) {
                        [weakSelf loadNewData];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"该商品数据不完整，请填充完整后再上架"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"该商品数据不完整，请填充完整后再上架"];
                }
            }];
        }
    else{
            [SVProgressHUD showInfoWithStatus:@"该商品数据不完整，请填充完整后再上架"];
        }
    }
}

//编辑
- (void)editAction:(UIButton *)editBtn{
    //跳转到下一个页面
    RSTaoBaoMangementModel * taobaomangementmodel = self.contentArray[editBtn.tag];
    RSTaoBaoProdectDetailViewController * taobaoProdectDetailVc = [[RSTaoBaoProdectDetailViewController alloc]init];
    taobaoProdectDetailVc.taobaoUsermodel = self.taobaoUsermodel;
    taobaoProdectDetailVc.taobaomangementmodel = taobaomangementmodel;
    taobaoProdectDetailVc.type = self.title;
    if ([self.title isEqualToString:@"荒料"]) {
        taobaoProdectDetailVc.joinType = 1;
    }else{
        taobaoProdectDetailVc.joinType = 4;
    }
    if (taobaomangementmodel.status == 1) {
      taobaoProdectDetailVc.typeStatus = @"已上架";
    }else{
      taobaoProdectDetailVc.typeStatus = @"未上架";
    }
    [self.navigationController pushViewController:taobaoProdectDetailVc animated:YES];
}


//删除
- (void)deleteAction:(UIButton *)deleteBtn{
    RSWeakself
    [JHSysAlertUtil presentAlertViewWithTitle:@"提示" message:@"确实要删除该物料吗?" cancelTitle:@"确定" defaultTitle:@"取消" distinct:true cancel:^{
        [weakSelf cancelCurrentInformation:deleteBtn.tag];
    } confirm:^{   
    }];
//    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料吗?" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alertView addAction:alert];
//    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }];
//    [alertView addAction:alert1];
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//
//           alertView.modalPresentationStyle = UIModalPresentationFullScreen;
//       }
//    [self presentViewController:alertView animated:YES completion:nil];
//
}


- (void)cancelCurrentInformation:(NSInteger)index{
    RSTaoBaoMangementModel * taobaomangementmodel = self.contentArray[index];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
        //URL_TAOBAOGETINVENTORYLIST_IOS
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        NSMutableArray * array = [NSMutableArray array];
        [array addObject:[NSNumber numberWithInteger:taobaomangementmodel.mangementID]];
        [phoneDict setObject:array forKey:@"ids"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_TAOBAODELETEINVENTORY_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    [weakSelf.contentArray removeObjectAtIndex:index];
                    [weakSelf.tableview reloadData];
                    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"删除失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
        }];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
