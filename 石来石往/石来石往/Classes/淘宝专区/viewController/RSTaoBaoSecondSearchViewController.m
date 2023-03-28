//
//  RSTaoBaoSecondSearchViewController.m
//  石来石往
//
//  Created by mac on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoSecondSearchViewController.h"
#import "RSTaoBaoShopViewController.h"

//模型
#import "RSTaoBaoUserLikeModel.h"
#import "RSTaoBaoProductDetailsViewController.h"
#import "RSTaoBaoActivityCell.h"

@interface RSTaoBaoSecondSearchViewController ()<DOPDropDownMenuDelegate,DOPDropDownMenuDataSource,UITableViewDelegate,UITableViewDataSource,RSTaobaoSearchScreenViewDelegate,RSTaobaoSearchFunctionScreenViewDelegate>

{
    //长
    NSDecimalNumber * _tempStr1;
    //宽
    NSDecimalNumber * _tempStr2;
    //高
    NSDecimalNumber * _tempStr3;
    //体积
    NSDecimalNumber * _tempStr4;
    //长的类型
    NSString * _btnStr1;
    //宽的类型
    NSString * _btnStr2;
    //高的类型
    NSString * _btnStr3;
    //体积的类型
    NSString * _btnStr4;

}



@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,strong)RSAllMessageUIButton * screenBtn;


@property (nonatomic, strong) NSArray *areas;

@property (nonatomic, strong) NSArray *sorts;

@property (nonatomic,strong) NSArray * bloks;


@property (nonatomic,strong)NSString * show_field;
@property (nonatomic,strong)NSString * show_mode;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * contentArray;

@property (nonatomic,strong)NSString * searchStr;

@end

@implementation RSTaoBaoSecondSearchViewController
- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fairReload) name:@"fairReload" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.pageNum = 2;
    _searchStr = @"";
    
    _tempStr1 = [NSDecimalNumber decimalNumberWithString:@"0"];
    _tempStr2 = [NSDecimalNumber decimalNumberWithString:@"0"];
    _tempStr3 = [NSDecimalNumber decimalNumberWithString:@"0"];
    _tempStr4 = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    _btnStr1 = @"0";
    _btnStr2 = @"0";
    _btnStr3 = @"0";
    _btnStr4 = @"0";
    
   
    self.areas = @[@"颗数",@"升序",@"降序"];
    self.sorts = @[@"立方数",@"升序",@"降序"];
    self.bloks = @[@"吨",@"升序",@"降序"];
    
    _show_field = @"";
    _show_mode = @"";
    
    
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setUI];

    
    [self reloadShopInformationNewData:@""];

}





//获取店铺的数据
- (void)reloadShopInformationNewData:(NSString *)stoneName{
    _searchStr = stoneName;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
           verifykey = @"";
       }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"huangliao" forKey:@"stockType"];
    if ([stoneName isEqualToString:@""]) {
        [phoneDict setObject:@"" forKey:@"stoneName"];
    }else{
        [phoneDict setObject:stoneName forKey:@"stoneName"];
    }
    [phoneDict setObject:_show_field forKey:@"orderField"];
    
    [phoneDict setObject:_show_mode forKey:@"orderMode"];
    
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"tsUserId"];
    [phoneDict setObject:_tempStr1 forKey:@"length"];
    [phoneDict setObject:_tempStr2 forKey:@"width"];
    [phoneDict setObject:_tempStr3 forKey:@"height"];
    [phoneDict setObject:_tempStr4 forKey:@"volume"];
    
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"area"];
    
    [phoneDict setObject:_btnStr1 forKey:@"lengthType"];
    [phoneDict setObject:_btnStr2 forKey:@"widthType"];
    [phoneDict setObject:_btnStr3 forKey:@"heightType"];
    [phoneDict setObject:_btnStr4 forKey:@"volumeType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"areaType"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_INVENTORYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
//                NSMutableArray * array = [NSMutableArray array];
                [weakSelf.contentArray removeAllObjects];
//                array = json[@"data"][@"list"];
                weakSelf.contentArray = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
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
//                    taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
//                    taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
//                    taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
//                    taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
//                    taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
//                    taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
//                    taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
//                    taobaoUserLikemodel.imageUrl = [[array objectAtIndex:i]objectForKey:@"imageUrl"];
//                    taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
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
                [SVProgressHUD showErrorWithStatus:@"获取列表失败"];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取列表失败"];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}




- (void)reloadShopInformationMoreNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
           verifykey = @"";
       }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"huangliao" forKey:@"stockType"];
    [phoneDict setObject:_searchStr forKey:@"stoneName"];
    [phoneDict setObject:_show_field forKey:@"orderField"];
    [phoneDict setObject:_show_mode forKey:@"orderMode"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"tsUserId"];
    [phoneDict setObject:_tempStr1 forKey:@"length"];
    [phoneDict setObject:_tempStr2 forKey:@"width"];
    [phoneDict setObject:_tempStr3 forKey:@"height"];
    [phoneDict setObject:_tempStr4 forKey:@"volume"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"area"];
    [phoneDict setObject:_btnStr1 forKey:@"lengthType"];
    [phoneDict setObject:_btnStr2 forKey:@"widthType"];
    [phoneDict setObject:_btnStr3 forKey:@"heightType"];
    [phoneDict setObject:_btnStr4 forKey:@"volumeType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"areaType"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_INVENTORYLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
//                NSMutableArray * array = [NSMutableArray array];
//                NSMutableArray * newTemp = [NSMutableArray array];
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
//                    taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
//                    taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
//                    taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
//                    taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
//                    taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
//                    taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
//                    taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
//                    taobaoUserLikemodel.imageUrl = [[array objectAtIndex:i]objectForKey:@"imageUrl"];
//                    taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
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
//                    [newTemp addObject:taobaoUserLikemodel];
//                }
                NSMutableArray * array = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in array) {
                    taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                }
                [weakSelf.contentArray addObjectsFromArray:array];
                weakSelf.pageNum++;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
            }else{

                
                [SVProgressHUD showErrorWithStatus:@"获取列表失败"];
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取列表失败"];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}





- (void)setUI{
    RSAllMessageUIButton * screenBtn = [[RSAllMessageUIButton alloc]initWithFrame:CGRectMake(0, 0, 115, 44)];
    [screenBtn setTitle:@"规格筛选" forState:UIControlStateNormal];
    screenBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [screenBtn setImage:[UIImage imageNamed:@"灰色向下三角形"] forState:UIControlStateNormal];
    [screenBtn setImage:[UIImage imageNamed:@"红色向下三角形"] forState:UIControlStateSelected];
    screenBtn.imageView.sd_layout
    .leftSpaceToView(screenBtn.titleLabel,3)
    .centerYEqualToView(screenBtn)
    .heightIs(12)
    .widthIs(12);
    [screenBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [screenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FF4B33"] forState:UIControlStateSelected];
    [self.view addSubview:screenBtn];
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [screenBtn addTarget:self action:@selector(screenRuleAction:) forControlEvents:UIControlEventTouchUpInside];
    _screenBtn = screenBtn;
    
    
    //CGRectGetMaxY(marketScrollview.frame) + 21
//    UIView * midview = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(screenBtn.frame), 11, 1, 22)];
//    midview.backgroundColor = [UIColor colorWithHexColorStr:@"#CDCDCD"];
//    [self.view addSubview:midview];
    
    //CGRectGetMaxY(marketScrollview.frame) + 10
    DOPDropDownMenu * menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(115, 0) andHeight:44 andTag:0];
    menu.delegate = self;
    menu.dataSource = self;
    menu.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    menu.separatorColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    menu.indicatorColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    menu.textSelectedColor = [UIColor colorWithHexColorStr:@"#FF4B33"];
    [self.view addSubview:menu];
    _menu = menu;
    
    
    
    //[self loadHuangDetailAndDaDetailNewData];
    
    
    
    
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(screenBtn.frame), SCW, self.view.frame.size.height - CGRectGetMaxY(screenBtn.frame)) style:UITableViewStylePlain];
    self.tableview = tableview;
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    
    CGRect rect2 = CGRectMake(0 , 0,SCW, self.view.frame.size.height);
    CGRect oldRect2 = rect2;
    oldRect2.size.width = SCW;
    UIBezierPath * maskPath2 = [UIBezierPath bezierPathWithRoundedRect:oldRect2 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer * maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.path = maskPath2.CGPath;
    maskLayer2.frame = oldRect2;
    self.view.layer.mask = maskLayer2;
    
    
    
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {

        self.tableview.estimatedRowHeight = 0;
        self.tableview.estimatedSectionHeaderHeight = 0;
        self.tableview.estimatedSectionFooterHeight = 0;
    }
    //
    // 设置tableView的内边距
    // self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    [self.view addSubview:self.tableview];
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadShopInformationNewData:_searchStr];
    }];
    
    
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf reloadShopInformationMoreNewData];
    }];
    
    
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
        [weakSelf reloadShopInformationNewData:_searchStr];
    }];
    
    
    //添加左边的视图
    _leftview = [[RSTaobaoSearchFunctionScreenView alloc]initWithSender:self];
    _leftview.backgroundColor = [UIColor whiteColor];
    _leftview.delegate = self;
    [self.view addSubview:_leftview];
    
    
    RSTaobaoSearchScreenView *showRightview = [[RSTaobaoSearchScreenView alloc]initWithFrame:CGRectMake(0, 44, 268,_leftview.bounds.size.height)];
    _showRightview = showRightview;
    _showRightview.delegate = self;
    _showRightview.searchType = @"huangliao";
    [_leftview setContentView:showRightview];
    
    
    _menu.ishideMenuBlock = ^{
        [_leftview hide];
        screenBtn.selected = NO;
    };
    
    
}






- (void)screenRuleAction:(UIButton *)btn{
    [_menu hideMenu];
    btn.selected = !btn.selected;
    if (btn.selected) {
        [_leftview show];
    }else{
        [_leftview hide];
    }
}


- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}


- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0){
        return self.areas.count;
    }else if(column == 1) {
        return self.sorts.count;
    }else{
        return self.bloks.count;
    }
}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.areas[indexPath.row];
    } else   if (indexPath.column == 1){
        return self.sorts[indexPath.row];
    }else{
        return self.bloks[indexPath.row];
    }
}


- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            _show_field = @"qty";
            _show_mode = @"";
        }else if (indexPath.row == 1){
            _show_field = @"qty";
            _show_mode = @"asc";
        }else if (indexPath.row == 2){
            _show_field = @"qty";
            _show_mode = @"desc";
        }
        
    }else if (indexPath.column == 1){
        if (indexPath.row == 0) {
            _show_field = @"inventory";
            _show_mode = @"";
        }else if (indexPath.row == 1){
            _show_field = @"inventory";
            _show_mode = @"asc";
        }
        else if (indexPath.row == 2){
            _show_field = @"inventory";
            _show_mode = @"desc";
        }
    }else{
        if (indexPath.row == 0) {
            _show_field = @"weight";
            _show_mode = @"";
        }else if (indexPath.row == 1){
            _show_field = @"weight";
            _show_mode = @"asc";
        }
        else if (indexPath.row == 2){
            _show_field = @"weight";
            _show_mode = @"desc";
        }
    }
    self.screenBtn.selected = NO;
    [self reloadShopInformationNewData:_searchStr];
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * TAOBAOSCCONTENTCELLID = @"TAOBAOSCCONTENTCELLID";
   
    RSTaoBaoActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:TAOBAOSCCONTENTCELLID];
    if (!cell) {
        cell = [[RSTaoBaoActivityCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TAOBAOSCCONTENTCELLID];
    }
    cell.taobaoUserlikemodel = self.contentArray[indexPath.row];

    cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    cell.rowNowRobBtn.hidden = YES;
    cell.showDisBtn.hidden = YES;
    cell.taoBaoSCBtn.tag = indexPath.row;
    [cell.taoBaoSCBtn addTarget:self action:@selector(inShopAction:) forControlEvents:UIControlEventTouchUpInside];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSTaoBaoUserLikeModel * taobaoUserlikemodel = self.contentArray[indexPath.row];
    RSTaoBaoProductDetailsViewController * taobaoProductDetailsVc = [[RSTaoBaoProductDetailsViewController alloc]init];
    taobaoProductDetailsVc.tsUserId = taobaoUserlikemodel.userLikeID;
    [self.navigationController pushViewController:taobaoProductDetailsVc animated:YES];
}


//进店
- (void)inShopAction:(UIButton *)taoBaoSCBtn{
    
    RSTaoBaoShopViewController * taoBaoShopVc = [[RSTaoBaoShopViewController alloc]init];
//    taoBaoShopVc.taobaoUsermodel = self.taobaoUsermodel;
    RSTaoBaoUserLikeModel * taobaoUserlikemodel = self.contentArray[taoBaoSCBtn.tag];
    taoBaoShopVc.tsUserId = taobaoUserlikemodel.tsUserId;
    [self.navigationController pushViewController:taoBaoShopVc animated:YES];
}

- (void)hideSetting{
    self.screenBtn.selected = NO;
}


- (void)screeningConditionStr1:(NSString *)tempStr1 andStr2:(NSString *)tempStr2 andStr3:(NSString *)tempStr3 andStr4:(NSString *)tempStr4 andBtn1:(NSString *)btnStr1 andBtn2:(NSString *)btnStr2 andBtn3:(NSString *)btnStr3 andBtnStr4:(NSString *)btnStr4 andYBScreenCell:(YBScreenCell *)cell andSearchType:(NSString *)searchType {
    
    [_leftview hide];
    
    _tempStr1 = [NSDecimalNumber decimalNumberWithString:tempStr1];
    _tempStr2 = [NSDecimalNumber decimalNumberWithString:tempStr2];
    _tempStr3 = [NSDecimalNumber decimalNumberWithString:tempStr3];
    _tempStr4 = [NSDecimalNumber decimalNumberWithString:tempStr4];
    _btnStr1 = btnStr1;
    _btnStr2 = btnStr2;
    _btnStr3 = btnStr3;
    _btnStr4 = btnStr4;

    [self reloadShopInformationNewData:_searchStr];
    
}



- (void)fairReload{
    [self.tableview.mj_header beginRefreshing];
}





- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
