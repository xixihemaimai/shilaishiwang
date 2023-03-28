//
//  RSHuangDetailAndDaDetailViewController.m
//  石来石往
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSHuangDetailAndDaDetailViewController.h"

#import "RSHuangAndDaModel.h"
#import "RSSegmentHeaderView.h"
#import "RSSegmentCell.h"


#import "RSMyRingViewController.h"

#import "RSCargoCenterBusinessViewController.h"


#import "RSScreenButton.h"


#import "RSDetailSegmentViewController.h"




@interface RSHuangDetailAndDaDetailViewController ()<UITableViewDelegate,UITableViewDataSource,RSLeftScreenViewDelegate,DOPDropDownMenuDelegate,DOPDropDownMenuDataSource>
{
    
    
    UILabel * _label;
    
    
}

@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,assign)BOOL isrefresh;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * showArray;


/**筛选的按键*/
@property (nonatomic,strong)RSScreenButton * screenBtn;

@property (nonatomic,strong)NSString * show_type;



@property (nonatomic, strong) NSArray *areas;

@property (nonatomic, strong) NSArray *sorts;

@property (nonatomic,strong) NSArray * bloks;

@end

@implementation RSHuangDetailAndDaDetailViewController

- (NSMutableArray *)showArray{
    if (_showArray == nil) {
        _showArray = [NSMutableArray array];
    }
    return _showArray;
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifykey andViewController:self];
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
     if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
     }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
     }
     self.title = @"商品";
     self.pageNum = 2;
     _btnStr1 = @"2";
     _btnStr2 = @"2";
     _btnStr3 = @"2";
     _btnStr4 = @"2";
     _tempStr1 = @"-1";
     _tempStr2 = @"-1";
     _tempStr3 = @"-1";
     _tempStr4 = @"-1";
     _show_type = @"";
     [self addHuangDetailAndDaDetailCustomTableView];
     [self loadHuangDetailAndDaDetailNewData];
}

- (void)showScreenView:(RSScreenButton *)screenBtn{
    [_menu hideMenu];
    //打开
     [_leftview switchMenu];
}

- (void)addHuangDetailAndDaDetailCustomTableView{
    CGFloat Y = 0.0;
    CGFloat bottomH = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
        bottomH = 34.0;
    }else{
        Y = 64;
        bottomH = 0.0;
    }
    if ([self.searchType isEqualToString:@"huangliao"]) {
        self.areas = @[@"颗数",@"从大到小",@"从小到大"];
        self.sorts = @[@"立方数",@"从大到小",@"从小到大"];
        self.bloks = @[@"吨数",@"从小到大",@"从大到小"];
    }else{
        self.areas = @[@"匝数",@"从大到小",@"从小到大"];
        self.sorts = @[@"面积数",@"从大到小",@"从小到大"];
       // self.bloks = @[];
    }
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, Y) andHeight:44 andTag:1];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;
    _menu.finishedBlock=^(DOPIndexPath *indexPath){
        if (indexPath.item >= 0) {
          //  NSLog(@"+++++++++++收起:点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
        }else {
            
            //NSLog(@"-----------收起:点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
        }
    };
    UIView * midview = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(menu.frame), Y, 1, CGRectGetHeight(menu.frame))];
    midview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
    [self.view addSubview:midview];
    
    UIView * topview = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midview.frame), Y, SCW - CGRectGetMaxX(midview.frame), 1)];
    topview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
    [self.view addSubview:topview];

    RSScreenButton * screenBtn = [[RSScreenButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midview.frame),CGRectGetMaxY(topview.frame), SCW - CGRectGetMaxX(midview.frame), CGRectGetHeight(midview.frame) - 1)];
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    [screenBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [screenBtn setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
    [screenBtn addTarget:self action:@selector(showScreenView:) forControlEvents:UIControlEventTouchUpInside];
   screenBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:screenBtn];
    _screenBtn = screenBtn;
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midview.frame),CGRectGetMaxY(midview.frame) - 1, SCW - CGRectGetMaxX(midview.frame), 1)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
    [self.view addSubview:bottomview];
    
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(menu.frame), SCW, SCH - CGRectGetMaxY(menu.frame)) style:UITableViewStyleGrouped];
    self.tableview = tableview;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
        self.tableview.estimatedRowHeight = 0.01;
        self.tableview.estimatedSectionHeaderHeight = 0.01;
        self.tableview.estimatedSectionFooterHeight = 0.01;
    }
    // 设置tableView的内边距
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    [self.view addSubview:self.tableview];
    
    UILabel * label = [[UILabel alloc]init];
    _label = label;
    label.text = @"你搜索的条件，暂时没有内容";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.hidden = YES;
    
    label.sd_layout
    .centerXEqualToView(self.tableview)
    .centerYEqualToView(self.tableview)
    .widthIs(SCW)
    .heightIs(45);
    [self.tableview addSubview:label];
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHuangDetailAndDaDetailNewData];
    }];
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadHuangMoreNewData];
    }];
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
        [weakSelf loadHuangDetailAndDaDetailNewData];
    }];
    //添加左边的视图
    _leftview = [[RSLeftFunctionScreenView alloc]initWithSender:self];
    _leftview.backgroundColor = [UIColor whiteColor];
    //_leftview.lefttap.delegate = self;
    [self.view addSubview:_leftview];
    
    RSLeftScreenView *showRightview = [[RSLeftScreenView alloc]initWithFrame:CGRectMake(0, 0, 268,SCH)];
    _showRightview = showRightview;
    _showRightview.delegate = self;
    _showRightview.searchType = self.searchType;
    [_leftview setContentView:showRightview];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    if ([self.searchType isEqualToString:@"huangliao"]) {
        return 3;
    }else{
        return 2;
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if ([self.searchType isEqualToString:@"huangliao"]) {
        if (column == 0){
            return self.areas.count;
        }else if(column == 1) {
            return self.sorts.count;
        }else{
            return self.bloks.count;
        }
    }else{
        if (column == 0){
            return self.areas.count;
        }else{
            return self.sorts.count;
        }
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if ([self.searchType isEqualToString:@"huangliao"]) {
        if (indexPath.column == 0) {
            return self.areas[indexPath.row];
        } else   if (indexPath.column == 1){
            return self.sorts[indexPath.row];
        }else{
            return self.bloks[indexPath.row];
        }
    }else{
        if (indexPath.column == 0) {
            return self.areas[indexPath.row];
        } else{
            return self.sorts[indexPath.row];
        }
    }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
       // NSLog(@"+++++++++++点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        //NSLog(@"-----------点击了 %ld +++++- %ld 项目",indexPath.column,indexPath.row);
        if ([self.searchType isEqualToString:@"huangliao"]) {
            /*
             荒料
             升序
             立方数：SUM (VAQTY) asc,
             颗数：SUM (Qty)  asc,
             重量：SUM (WEIGHT)  asc,
             降序
             立方数：SUM (VAQTY) DESC,
             颗数：SUM (Qty)  DESC,
             重量：SUM (WEIGHT)  DESC,
             self.areas = @[@"颗数",@"从大到小",@"从小到大"];
             self.sorts = @[@"立方数",@"从大到小",@"从小到大"];
             self.bloks = @[@"吨数",@"从小到大",@"从大到小"];
             */
            if (indexPath.column == 0) {
                if (indexPath.row == 0) {
                    _show_type = @"";
                }else if (indexPath.row == 1){
                    _show_type = @"SUM (Qty)  DESC,";
                }else{
                    _show_type = @"SUM (Qty)  asc,";
                }
            }else if (indexPath.column == 1){
                if (indexPath.row == 0) {
                    _show_type = @"";
                }else if (indexPath.row == 1){
                    _show_type = @"SUM (VAQTY) DESC,";
                }else{
                    _show_type = @"SUM (VAQTY) asc,";
                }
            }else{
                if (indexPath.row == 0) {
                    _show_type = @"";
                }else if (indexPath.row == 1){
                    _show_type = @"SUM (WEIGHT)  DESC,";
                }else{
                    _show_type = @"SUM (WEIGHT)  asc,";
                }
            }
        }else{
            /*
             升序
             匝数：SUM (Qty) asc,
             面积数：SUM (VAQTY) asc,
             降序
             匝数：SUM (Qty) DESC,
             面积数：SUM (VAQTY) DESC,
             self.areas = @[@"匝数",@"从大到小",@"从小到大"];
             self.sorts = @[@"面积数",@"从大到小",@"从小到大"];
             self.bloks = @[@"吨数",@"从小到大",@"从大到小"];
             */
            if (indexPath.column == 0) {
                if (indexPath.row == 0) {
                    _show_type = @"";
                }else if (indexPath.row == 1){
                    _show_type = @"SUM (Qty) DESC,";
                }else{
                    _show_type = @"SUM (Qty) asc,";
                }
            }else if (indexPath.column == 1){
                if (indexPath.row == 0) {
                    _show_type = @"";
                }else if (indexPath.row == 1){
                    _show_type = @"SUM (VAQTY) DESC,";
                }else{
                    _show_type = @"SUM (VAQTY) asc,";
                }
            }else{
                _show_type = @"";
                [SVProgressHUD showInfoWithStatus:@"现在还没有开放这个功能"];
            }
        }
        [self loadHuangDetailAndDaDetailNewData];
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    //    if (indexPath.column == 0 || indexPath.column == 1) {
    //        return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.row];
    //    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    //    if (indexPath.column == 0 && indexPath.item >= 0) {
    //        return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.item];
    //    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    //    if (indexPath.column < 2) {
    //        return [@(arc4random()%1000) stringValue];
    //    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    // return [@(arc4random()%1000) stringValue];
    return nil;
}

- (void)loadHuangDetailAndDaDetailNewData{
    self.isrefresh = true;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.searchStr forKey:@"search_text"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr2] forKey:@"width_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr3] forKey:@"height_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr1] forKey:@"length_filter"];
    if ([self.searchType isEqualToString:@"huangliao"]) {
        //荒料
        [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr4] forKey:@"volume_filter"];
        [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr4] forKey:@"volume"];
    }else{
        //大板
        [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr4] forKey:@"volume_filter"];
        [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr4] forKey:@"volume"];
    }
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr2] forKey:@"width"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr3] forKey:@"height"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr1] forKey:@"length"];
    //[dict setObject:[NSString stringWithFormat:@"%@",@"0"] forKey:@"show_type"];
    [dict setObject:[NSNumber numberWithBool:self.isrefresh] forKey:@"is_refresh"];
    [dict setObject:[NSString stringWithFormat:@"%@",@"1"] forKey:@"page_num"];
    [dict setObject:[NSString stringWithFormat:@"%@",@"10"] forKey:@"item_num"];
    [dict setObject:self.searchType forKey:@"search_type"];
    [dict setObject:self.show_type forKey:@"show_type"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_HUANGANDDADETAILSEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
         BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [weakSelf.showArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                if (array.count > 0) {
                    for (int j = 0 ; j < array.count; j++) {
                        RSHuangAndDaModel * huangAndDamodel = [[RSHuangAndDaModel alloc]init];
                        huangAndDamodel.companyId = [[array objectAtIndex:j]objectForKey:@"companyId"];
                        huangAndDamodel.companyName = [[array objectAtIndex:j]objectForKey:@"companyName"];
                        huangAndDamodel.companyUrl = [[array objectAtIndex:j]objectForKey:@"companyUrl"];
                        
                        huangAndDamodel.dataSource = [[array objectAtIndex:j]objectForKey:@"dataSource"];
                        
                        huangAndDamodel.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                        huangAndDamodel.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                        huangAndDamodel.stoneId = [[array objectAtIndex:j]objectForKey:@"stoneId"];
                        huangAndDamodel.stoneName = [[array objectAtIndex:j]objectForKey:@"stoneName"];
                        huangAndDamodel.stoneNum = [[array objectAtIndex:j]objectForKey:@"stoneNum"];
                        huangAndDamodel.stoneTotalMessage = [[array objectAtIndex:j]objectForKey:@"stoneTotalMessage"];
                        huangAndDamodel.stoneWeight = [[array objectAtIndex:j]objectForKey:@"stoneWeight"];
                        huangAndDamodel.totalNum = [[array objectAtIndex:j]objectForKey:@"totalNum"];
                        huangAndDamodel.phone = [[array objectAtIndex:j]objectForKey:@"phone"];
                        NSMutableArray * images = nil;
                        NSMutableArray * tempImages = [NSMutableArray array];
                        images = [[array objectAtIndex:j]objectForKey:@"imgUrl"];
                        for (int n = 0; n < images.count; n++) {
                            NSString * url = [images objectAtIndex:n];
                            [tempImages addObject:url];
                        }
                        huangAndDamodel.imgUrl = tempImages;
                        [weakSelf.showArray addObject:huangAndDamodel];
                    }
                    _label.hidden = YES;
                }else{
                    _label.hidden = NO;
                }
                weakSelf.pageNum = 2;
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview reloadData];
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
                _label.hidden = NO;
            }
        }else{
            _label.hidden = NO;
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)loadHuangMoreNewData{
    self.isrefresh = false;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.searchStr forKey:@"search_text"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr2] forKey:@"width_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr3] forKey:@"height_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr1] forKey:@"length_filter"];
    if ([self.searchType isEqualToString:@"huangliao"]) {
        //荒料
        [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr4] forKey:@"volume_filter"];
        [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr4] forKey:@"volume"];
    }else{
        //大板
        [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr4] forKey:@"volume_filter"];
        [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr4] forKey:@"volume"];
    }
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr2] forKey:@"width"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr3] forKey:@"height"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr1] forKey:@"length"];
   // [dict setObject:[NSString stringWithFormat:@"%@",@"0"] forKey:@"show_type"];
    [dict setObject:[NSNumber numberWithBool:self.isrefresh] forKey:@"is_refresh"];
    [dict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"page_num"];
    [dict setObject:[NSString stringWithFormat:@"%@",@"10"] forKey:@"item_num"];
    [dict setObject:self.searchType forKey:@"search_type"];
    [dict setObject:self.show_type forKey:@"show_type"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_HUANGANDDADETAILSEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                if (array.count > 0) {
                     NSMutableArray * tempArray = [NSMutableArray array];
                    for (int j = 0; j < array.count; j++) {
                        RSHuangAndDaModel * huangAndDamodel = [[RSHuangAndDaModel alloc]init];
                        huangAndDamodel.companyId = [[array objectAtIndex:j]objectForKey:@"companyId"];
                        huangAndDamodel.companyName = [[array objectAtIndex:j]objectForKey:@"companyName"];
                        huangAndDamodel.companyUrl = [[array objectAtIndex:j]objectForKey:@"companyUrl"];
                        huangAndDamodel.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                        huangAndDamodel.pagerank = [[array objectAtIndex:j]objectForKey:@"pagerank"];
                        huangAndDamodel.stoneId = [[array objectAtIndex:j]objectForKey:@"stoneId"];
                        huangAndDamodel.stoneName = [[array objectAtIndex:j]objectForKey:@"stoneName"];
                        huangAndDamodel.stoneNum = [[array objectAtIndex:j]objectForKey:@"stoneNum"];
                        huangAndDamodel.stoneTotalMessage = [[array objectAtIndex:j]objectForKey:@"stoneTotalMessage"];
                        huangAndDamodel.stoneWeight = [[array objectAtIndex:j]objectForKey:@"stoneWeight"];
                        huangAndDamodel.totalNum = [[array objectAtIndex:j]objectForKey:@"totalNum"];
                        huangAndDamodel.phone = [[array objectAtIndex:j]objectForKey:@"phone"];
                        huangAndDamodel.dataSource = [[array objectAtIndex:j]objectForKey:@"dataSource"];
                        NSMutableArray * images = nil;
                        NSMutableArray * tempImages = [NSMutableArray array];
                        images = [[array objectAtIndex:j]objectForKey:@"imgUrl"];
                        for (int n = 0; n < images.count; n++) {
                            NSString * url = [images objectAtIndex:n];
                            [tempImages addObject:url];
                        }
                        huangAndDamodel.imgUrl = tempImages;
                        [tempArray addObject:huangAndDamodel];
                    }
                    [weakSelf.showArray addObjectsFromArray:tempArray];
                    _label.hidden = YES;
                    weakSelf.isrefresh = true;
                    weakSelf.pageNum++;
                    [weakSelf.tableview.mj_footer endRefreshing];
                    [weakSelf.tableview reloadData];
                }else{
                    _label.hidden = YES;
                    [weakSelf.tableview.mj_footer endRefreshing];
                }
            }else{
                [weakSelf.tableview.mj_footer endRefreshing];
                _label.hidden = YES;
            }
        }else{
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}

static  NSInteger oldSection = nil;
static NSInteger newSection = nil;
static NSString * HEADERID = @"huangDetailAndDaDetailID";
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.showArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSSegmentHeaderView * segmentview = [[RSSegmentHeaderView alloc]initWithReuseIdentifier:HEADERID];
    RSHuangAndDaModel * huangAndDamodel = self.showArray[section];
    segmentview.conmpanyLabel.text = huangAndDamodel.companyName;
    segmentview.contentView.backgroundColor = [UIColor whiteColor];
    segmentview.userInteractionEnabled = YES;
    newSection = section;
    RSHuangAndDaModel * AhuangAndDamodel = [[RSHuangAndDaModel alloc]init];
    if (newSection > 0) {
        AhuangAndDamodel = self.showArray[newSection-1];
    }
    if ([huangAndDamodel.companyId isEqualToString:AhuangAndDamodel.companyId]) {
        segmentview.hidden = YES;
    }else{
        segmentview.hidden = NO;
    }
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor clearColor]];
    btn.frame = CGRectMake(0, 0, SCW, 38);
    btn.tag = 1000+section;
    [segmentview.contentView addSubview:btn];
    [btn addTarget:self action:@selector(jumpH5Content:) forControlEvents:UIControlEventTouchUpInside];
    return segmentview;
}

- (void)jumpH5Content:(UIButton *)btn{
    RSHuangAndDaModel * huangAndDamodel = self.showArray[btn.tag - 1000];
    if ([self.userModel.userType isEqualToString:@"hxhz"]) {
        RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:huangAndDamodel.erpCode andCreat_userIDStr:@"-1" andUserIDStr:@"-1"];
        [self.navigationController pushViewController:cargoCenterVc animated:YES];
    }else{
        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
        myRingVc.erpCodeStr = huangAndDamodel.erpCode;
        myRingVc.userIDStr = @"-1";
        myRingVc.creat_userIDStr = @"-1";
        myRingVc.userModel = self.userModel;
        //myRingVc.userType = @"hxhz";
        [self.navigationController pushViewController:myRingVc animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * HUANDETAILANDDADETAILCELLID = @"huangdetailanddadetialcellid";
    RSSegmentCell * cell = [tableView dequeueReusableCellWithIdentifier:HUANDETAILANDDADETAILCELLID];
    if (!cell) {
        cell = [[RSSegmentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:HUANDETAILANDDADETAILCELLID];
    }
    RSHuangAndDaModel * huangAndDamodel = self.showArray[indexPath.section];
    cell.huangAndDamodel = huangAndDamodel;
    if ([self.searchType isEqualToString:@"huangliao"]) {
        cell.tiLabel.text = [NSString stringWithFormat:@"%@m³",huangAndDamodel.stoneTotalMessage];
        cell.weightLabel.hidden = NO;
        cell.weightLabel.text = [NSString stringWithFormat:@"%@吨",huangAndDamodel.stoneWeight];
        cell.keLabel.text = [NSString stringWithFormat:@"%@颗",huangAndDamodel.stoneNum];
    }else{
        cell.tiLabel.text = [NSString stringWithFormat:@"%@m²",huangAndDamodel.stoneTotalMessage];
        cell.weightLabel.hidden = YES;
        cell.weightLabel.text = [NSString stringWithFormat:@"%@吨",huangAndDamodel.stoneWeight];
        cell.keLabel.text = [NSString stringWithFormat:@"%@匝",huangAndDamodel.stoneNum];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    oldSection = section;
    RSHuangAndDaModel * huangAndDamodel = self.showArray[oldSection];
    RSHuangAndDaModel * AhuangAndDamodel = [[RSHuangAndDaModel alloc]init];
    if (oldSection + 1 <= self.showArray.count - 1) {
        AhuangAndDamodel = self.showArray[oldSection+1];
        if ([huangAndDamodel.companyName isEqualToString:AhuangAndDamodel.companyName]) {
            return 0.1;
        }
        return 10;
    }else{
        return 10;
    }   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //这边要是俩个相同的
            newSection = section;
            RSHuangAndDaModel * huangAndDamodel = self.showArray[newSection];
    RSHuangAndDaModel * AhuangAndDamodel = [[RSHuangAndDaModel alloc]init];
            if (newSection > 0) {
                AhuangAndDamodel = self.showArray[newSection-1];
            }
            if ([huangAndDamodel.companyId isEqualToString:AhuangAndDamodel.companyId]) {
                return 0.1;
            }else{
                return 38;
            }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RSHuangAndDaModel * huangAndDamodel = self.showArray[indexPath.section];
    RSDetailSegmentViewController * detailVc = [[RSDetailSegmentViewController alloc]init];
    detailVc.tempStr1 = self.tempStr1;
    detailVc.tempStr2 = self.tempStr2;
    detailVc.tempStr3 = self.tempStr3;
    detailVc.tempStr4 = self.tempStr4;
    detailVc.btnStr1 = self.btnStr1;
    detailVc.btnStr2 = self.btnStr2;
    detailVc.btnStr3 = self.btnStr3;
    detailVc.btnStr4 = self.btnStr4;
    detailVc.imageUrl = huangAndDamodel.imgUrl[0];
    detailVc.shitouName = huangAndDamodel.stoneName;
    detailVc.keAndZaStr = huangAndDamodel.stoneNum;
    detailVc.piAndFangStr = huangAndDamodel.stoneTotalMessage;
    detailVc.title = huangAndDamodel.stoneName;
    detailVc.phone = huangAndDamodel.phone;
    detailVc.weight = huangAndDamodel.stoneWeight;
    detailVc.userModel = self.userModel;
    detailVc.searchType = self.searchType;
    detailVc.erpCode = huangAndDamodel.erpCode;
    detailVc.titleStr = @"";
    detailVc.companyName = huangAndDamodel.companyName;
    detailVc.stoneName = huangAndDamodel.stoneId;
    [self.navigationController pushViewController:detailVc animated:YES];
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

- (void)screeningConditionStr1:(NSString *)tempStr1 andStr2:(NSString *)tempStr2 andStr3:(NSString *)tempStr3 andStr4:(NSString *)tempStr4 andBtn1:(NSString *)btnStr1 andBtn2:(NSString *)btnStr2 andBtn3:(NSString *)btnStr3 andBtnStr4:(NSString *)btnStr4 andYBScreenCell:(YBScreenCell *)cell andSearchType:(NSString *)searchType {
    
    
    
    [_leftview hide];
    
    _tempStr1 = tempStr1;
    _tempStr2 = tempStr2;
    _tempStr3 = tempStr3;
    _tempStr4 = tempStr4;
    _btnStr1 = btnStr1;
    _btnStr2 = btnStr2;
    _btnStr3 = btnStr3;
    _btnStr4 = btnStr4;
    
    
    
    
    [self loadHuangDetailAndDaDetailNewData];
}



@end
