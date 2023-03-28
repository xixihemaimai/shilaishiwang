//
//  RSHuangThirdDetailViewController.m
//  石来石往
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSHuangThirdDetailViewController.h"
#import "RSDetailSegmentViewController.h"
#import "RSHuangAndDaModel.h"
#import "RSSegmentCell.h"
#import "RSSegmentHeaderView.h"
#import "RSMyRingViewController.h"
#import "RSCargoCenterBusinessViewController.h"
#import "RSDZYCMainCargoCenterViewController.h"
#import "RSChoiceMarketView.h"
#import "RSHuangAndDabanMarketModel.h"


//空的界面
#import "RSEmptyDataView.h"

#define ECA 2
#define margin 20
@interface RSHuangThirdDetailViewController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDelegate,UITableViewDataSource,RSLeftScreenViewDelegate,RSLeftFunctionScreenViewDelegate,RSEmptyDataViewDelegate>
@property (nonatomic, strong) NSArray *areas;

@property (nonatomic, strong) NSArray *sorts;

@property (nonatomic,strong) UITableView * tableview;

@property (nonatomic,strong)RSAllMessageUIButton * screenBtn;

//@property (nonatomic,strong) NSArray * bloks;


@property (nonatomic,assign)BOOL isrefresh;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * showArray;


/**选择市场视图*/
@property (nonatomic,strong)UIScrollView * marketScrollview;
@property (nonatomic,strong)NSMutableArray * marketArray;


/**选中的按键*/
@property (nonatomic,assign)NSInteger selectIndex;


/**市场选择的中间值*/
@property (nonatomic,strong)NSString * selectMarketTemp;


@property (nonatomic,strong)RSEmptyDataView * emptyDataView;
@end

@implementation RSHuangThirdDetailViewController



- (NSMutableArray *)showArray{
    if (_showArray == nil) {
        _showArray = [NSMutableArray array];
    }
    return _showArray;
}

- (NSMutableArray *)marketArray{
    
    if (!_marketArray) {
        _marketArray = [NSMutableArray array];
    }
    return _marketArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    self.areas = @[@"匝数",@"从大到小",@"从小到大"];
    self.sorts = @[@"面积数",@"从大到小",@"从小到大"];
    
    
    
    self.pageNum = 2;
    self.selectIndex = 0;
    _btnStr1 = @"2";
    _btnStr2 = @"2";
    _btnStr3 = @"2";
    _btnStr4 = @"2";
    
    
    _tempStr1 = @"-1";
    _tempStr2 = @"-1";
    _tempStr3 = @"-1";
    _tempStr4 = @"-1";
    _show_type = @"";
   AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _selectMarketTemp = applegate.ERPID;
    
    [self loadDabanMoreMarketNewData];
    
    //[self loadDabanDetailAndDaDetailNewData];
    
    
   
    
    
}


- (void)selectItemContentTitle:(NSString *)currentTitle andType:(NSInteger)type{
    self.searchStr = currentTitle;
    
    self.pageNum = 2;
    self.selectIndex = 0;
    
    _btnStr1 = @"2";
    _btnStr2 = @"2";
    _btnStr3 = @"2";
    _btnStr4 = @"2";
          
    _tempStr1 = @"-1";
    _tempStr2 = @"-1";
    _tempStr3 = @"-1";
    _tempStr4 = @"-1";
    _show_type = @"";
    [self loadDabanMoreMarketNewData];
//    [self loadDabanDetailAndDaDetailNewData];
    if ([self.delegate respondsToSelector:@selector(selectKeywordContentTitle:andType:)]) {
        [self.delegate selectKeywordContentTitle:currentTitle andType:type];
    }
    
}



- (void)loadDabanMoreMarketNewData{
    for (UIView * view in self.view.subviews) {
        [view removeFromSuperview];
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.searchStr forKey:@"search_text"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr2] forKey:@"width_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr3] forKey:@"height_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr1] forKey:@"length_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr4] forKey:@"volume_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr4] forKey:@"volume"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr2] forKey:@"width"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr3] forKey:@"height"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr1] forKey:@"length"];
    [dict setObject:@"daban" forKey:@"search_type"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GROUPSEARCHCOUNT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [weakSelf.marketArray removeAllObjects];
//                NSMutableArray * array = [NSMutableArray array];
//                array = json[@"Data"];
                
                weakSelf.marketArray = [RSHuangAndDabanMarketModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                
                
//                for (int i = 0 ; i < array.count; i++) {
//                    RSHuangAndDabanMarketModel * huangAndDabanmarketmodel = [[RSHuangAndDabanMarketModel alloc]init];
//                    huangAndDabanmarketmodel.erpId = [[array objectAtIndex:i]objectForKey:@"erpId"];
//                    huangAndDabanmarketmodel.erpName = [[array objectAtIndex:i]objectForKey:@"erpName"];
//                    huangAndDabanmarketmodel.stoneTotalMessage = [[array objectAtIndex:i]objectForKey:@"stoneTotalMessage"];
//                    [weakSelf.marketArray addObject:huangAndDabanmarketmodel];
//                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf setUI];
                });
            }else{
                [SVProgressHUD showInfoWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"获取失败"];
        }
    }];
}


- (void)setUI{
    
    
    UIScrollView * marketScrollview =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCW, 88)];
    
    marketScrollview.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    
    marketScrollview.delegate = self;
    [self.view addSubview:marketScrollview];
    marketScrollview.pagingEnabled = NO;
    marketScrollview.showsHorizontalScrollIndicator = NO;
    // 去掉弹簧效果
    marketScrollview.bounces = NO;
    _marketScrollview = marketScrollview;
    //[self addMartketScrollviewContentView];
    
    CGFloat choiceMarkerviewW = (SCW  - ((ECA + 1)*margin))/ECA;
    CGFloat choiceMarketviewH = 62;
    
    for (int i = 0; i < self.marketArray.count; i++) {
        // NSInteger colom1 = i % ECA;
        // CGFloat choiceMarkerviewX =  colom1 * (margin + choiceMarkerviewW) + margin;
        RSChoiceMarketView * choiceMarketview = [[RSChoiceMarketView alloc]init];
        choiceMarketview.choiceBtn.tag = i;
        choiceMarketview.tag = i;
        choiceMarketview.frame = CGRectMake(i * choiceMarkerviewW + i * margin + margin, 13, choiceMarkerviewW, choiceMarketviewH);
        choiceMarketview.layer.cornerRadius = 6;
        choiceMarketview.layer.masksToBounds = NO;
        RSHuangAndDabanMarketModel * huangAndDabanmarketmodel = self.marketArray[i];
        if (i == self.selectIndex) {
            choiceMarketview.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
            choiceMarketview.currentMartketBtn.hidden = NO;
            CGMutablePathRef shadowpath = CGPathCreateMutable();
            CGPathAddRect(shadowpath, NULL, choiceMarketview.bounds);
            choiceMarketview.layer.shadowPath = shadowpath;
            CGPathRelease(shadowpath);
            choiceMarketview.layer.shadowColor = [UIColor colorWithHexColorStr:@"#759FFC"].CGColor;
            choiceMarketview.layer.shadowRadius = 6;
            choiceMarketview.layer.shadowOffset = CGSizeMake(0, 1);
            choiceMarketview.layer.shadowOpacity = 0.5;
            
            
            
        }else{
            
            choiceMarketview.backgroundColor = [UIColor colorWithHexColorStr:@"#D0D0D0"];
            choiceMarketview.currentMartketBtn.hidden = YES;
            
        }
        choiceMarketview.numeberLabel.text = [NSString stringWithFormat:@"%@m²",huangAndDabanmarketmodel.stoneTotalMessage];
        choiceMarketview.marketLabel.text = [NSString stringWithFormat:@"%@",huangAndDabanmarketmodel.erpName];
        [choiceMarketview.choiceBtn addTarget:self action:@selector(choiceStoneMarket:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.marketScrollview addSubview:choiceMarketview];
        //self.contentScrollview.contentOffset = CGPointMake(i * choiceMarketview.yj_width, 0);
    }
    //self.scrollview.contentSize = CGSizeMake(count * self.yj_width, 0);
    self.marketScrollview.contentSize = CGSizeMake(self.marketArray.count * choiceMarkerviewW + (self.marketArray.count + 1) * margin , 0);
    self.marketScrollview.hidden = YES;
    //这边添加一个涮选的按键
    //CGRectGetMaxY(marketScrollview.frame) + 10
    RSAllMessageUIButton * screenBtn = [[RSAllMessageUIButton alloc]initWithFrame:CGRectMake(0, 0, 115, 44)];
    [screenBtn setTitle:@"规格筛选" forState:UIControlStateNormal];
    screenBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [screenBtn setImage:[UIImage imageNamed:@"蓝色下放三角号"] forState:UIControlStateNormal];
    [screenBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [screenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    [self.view addSubview:screenBtn];
    [screenBtn addTarget:self action:@selector(screenRuleAction:) forControlEvents:UIControlEventTouchUpInside];
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    _screenBtn = screenBtn;
    //CGRectGetMaxY(marketScrollview.frame) + 21
    UIView * midview = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(screenBtn.frame), 11, 1, 22)];
    midview.backgroundColor = [UIColor colorWithHexColorStr:@"#CDCDCD"];
    [self.view addSubview:midview];
    
    //CGRectGetMaxY(marketScrollview.frame) + 10
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(116, 0) andHeight:41 andTag:1];
    
    menu.delegate = self;
    menu.dataSource = self;
    menu.separatorColor = [UIColor colorWithHexColorStr:@"#CDCDCD"];
    [self.view addSubview:menu];
    _menu = menu;
    
    _menu.finishedBlock=^(DOPIndexPath *indexPath){
        if (indexPath.item >= 0) {
            
            //  NSLog(@"+++++++++++收起:点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
        }else {
            
            //NSLog(@"-----------收起:点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
        }
    };
    
    
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(menu.frame), SCW, 0.5)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#CDCDCD"];
    [self.view addSubview:bottomview];
    
    [self loadDabanDetailAndDaDetailNewData];
    
    
    CGFloat Y = 0.0f;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
    }else{
        Y = 64;
    }
    
    
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bottomview.frame), SCW, self.view.frame.size.height - CGRectGetMaxY(bottomview.frame)) style:UITableViewStyleGrouped];
    self.tableview = tableview;
    // self.tableview.backgroundColor = [UIColor redColor];
    
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
        
        self.tableview.estimatedRowHeight = 0;
        self.tableview.estimatedSectionHeaderHeight = 0;
        self.tableview.estimatedSectionFooterHeight = 0;
    }
    // 设置tableView的内边距
    // self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    [self.view addSubview:self.tableview];
    
    
    
    
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDabanDetailAndDaDetailNewData];
    }];
    
    
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadDabanMoreNewData];
    }];
    
    
    
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf loadDabanDetailAndDaDetailNewData];
//    }];
    
    
    RSEmptyDataView * emptyDataView = [[RSEmptyDataView alloc]initWithFrame:CGRectMake(0, SCH/2 - 200, SCW, SCH - 100)];
    emptyDataView.delegate = self;
    emptyDataView.type = 1;
    emptyDataView.hidden = YES;
    [self.view addSubview:emptyDataView];
    _emptyDataView = emptyDataView;
    
    
    //添加左边的视图
    _leftview = [[RSLeftFunctionScreenView alloc]initWithSender:self];
    _leftview.backgroundColor = [UIColor whiteColor];
    _leftview.delegate = self;
    [self.view addSubview:_leftview];
    
    
//    if (_leftview.bounds.size.height < 100) {
//        //_leftview.bounds.size.height = 1000.0;
//        CGFloat height = _leftview.bounds.size.height + 100;
//        _leftview.bounds.size.height
//    }
    
    RSLeftScreenView *showRightview = [[RSLeftScreenView alloc]initWithFrame:CGRectMake(0, 41, 268,_leftview.bounds.size.height)];
    _showRightview = showRightview;
    _showRightview.delegate = self;
    _showRightview.searchType = @"daban";
    [_leftview setContentView:showRightview];
    
    _menu.ishideMenuBlock = ^{
        [_leftview hide];
        screenBtn.selected = NO;
    };
    
    
    
    
}

- (void)choiceStoneMarket:(UIButton *)btn{
    
    self.selectIndex = btn.tag;
    for (RSChoiceMarketView * choiceMarketview in self.marketScrollview.subviews) {
        for (UIButton * choiceBtn in choiceMarketview.subviews) {
            if (choiceBtn.tag == btn.tag) {
                choiceMarketview.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
                choiceMarketview.currentMartketBtn.hidden = NO;
                CGMutablePathRef shadowpath = CGPathCreateMutable();
                CGPathAddRect(shadowpath, NULL, choiceMarketview.bounds);
                choiceMarketview.layer.shadowPath = shadowpath;
                CGPathRelease(shadowpath);
                choiceMarketview.layer.shadowColor = [UIColor colorWithHexColorStr:@"#759FFC"].CGColor;
                choiceMarketview.layer.shadowRadius = 6;
                choiceMarketview.layer.shadowOffset = CGSizeMake(0, 1);
                choiceMarketview.layer.shadowOpacity = 0.5;
                
                RSHuangAndDabanMarketModel * huangAndDabanmarketmodel = self.marketArray[btn.tag];
                _selectMarketTemp = huangAndDabanmarketmodel.erpId;
                
                
            }else{
                choiceMarketview.backgroundColor = [UIColor colorWithHexColorStr:@"#D0D0D0"];
                choiceMarketview.currentMartketBtn.hidden = YES;
                
                //                    CGMutablePathRef shadowpath = CGPathCreateMutable();
                //                    CGPathAddRect(shadowpath, NULL, choiceMarketview.bounds);
                //                    choiceMarketview.layer.shadowPath = shadowpath;
                //                    CGPathRelease(shadowpath);
                choiceMarketview.layer.shadowColor = [UIColor redColor].CGColor;
                choiceMarketview.layer.shadowRadius = 6;
                choiceMarketview.layer.shadowOffset = CGSizeMake(0, 0);
                choiceMarketview.layer.shadowOpacity = 0;
            }
        }
    }
    
    
    //[self loadDabanMoreMarketNewData];
    
    
    [self loadDabanDetailAndDaDetailNewData];
}





- (void)loadDabanDetailAndDaDetailNewData{
    
    
    
    self.isrefresh = true;
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.searchStr forKey:@"search_text"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr2] forKey:@"width_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr3] forKey:@"height_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr1] forKey:@"length_filter"];
    //    if ([self.searchType isEqualToString:@"huangliao"]) {
    //荒料
    //[dict setObject:[NSString stringWithFormat:@"%@",self.btnStr4] forKey:@"volume_filter"];
   // [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr4] forKey:@"volume"];
    //    }else{
    //        //大板
            [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr4] forKey:@"volume_filter"];
            [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr4] forKey:@"volume"];
    //    }
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr2] forKey:@"width"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr3] forKey:@"height"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr1] forKey:@"length"];
    //[dict setObject:[NSString stringWithFormat:@"%@",@"0"] forKey:@"show_type"];
    [dict setObject:[NSNumber numberWithBool:self.isrefresh] forKey:@"is_refresh"];
    [dict setObject:[NSString stringWithFormat:@"%@",@"1"] forKey:@"page_num"];
    [dict setObject:[NSString stringWithFormat:@"%@",@"10"] forKey:@"item_num"];
    [dict setObject:@"daban" forKey:@"search_type"];
    [dict setObject:self.show_type forKey:@"show_type"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
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
                        NSMutableArray * images = [NSMutableArray array];
                        NSMutableArray * tempImages = [NSMutableArray array];
                        images = [[array objectAtIndex:j]objectForKey:@"imgUrl"];
                        for (int n = 0; n < images.count; n++) {
                            NSString * url = [images objectAtIndex:n];
                            [tempImages addObject:url];
                        }
                        huangAndDamodel.imgUrl = tempImages;
                        [weakSelf.showArray addObject:huangAndDamodel];
                    }
                    // _label.hidden = YES;
                }else{
                    // _label.hidden = NO;
                }
                if (self.showArray.count > 0) {
                    weakSelf.emptyDataView.hidden = YES;
                    weakSelf.tableview.hidden = NO;
                }else{
                    NSMutableArray * array = [NSMutableArray array];
                    array = json[@"recommend"];
                    NSMutableArray * tempArray = [NSMutableArray array];
                                                            
                                                            for (int i = 0; i < array.count; i++) {
                                                                NSString * keyword = array[i];
                                                                if (i < 10) {
                                                                    [tempArray addObject:keyword];
                                                                    
                                                                }else{
                                                                    break;
                                                                }
                                                            }
                    
                    for (UIView * view in weakSelf.emptyDataView.btnsView.subviews) {
                        if ([view isKindOfClass:[UIButton class]]) {
                            [view removeFromSuperview];
                        }
                    }
                    
                    [weakSelf.emptyDataView addKeywordArray:tempArray];
                    weakSelf.emptyDataView.hidden = NO;
                    weakSelf.tableview.hidden = YES;
                }
                weakSelf.pageNum = 2;
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview reloadData];
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
                //  _label.hidden = NO;
            }
        }else{
            //_label.hidden = NO;
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}


- (void)loadDabanMoreNewData{
    self.isrefresh = false;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.searchStr forKey:@"search_text"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr2] forKey:@"width_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr3] forKey:@"height_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr1] forKey:@"length_filter"];
    //    if ([self.searchType isEqualToString:@"huangliao"]) {
    //荒料
   // [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr4] forKey:@"volume_filter"];
   // [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr4] forKey:@"volume"];
    //    }else{
    //        //大板
            [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr4] forKey:@"volume_filter"];
            [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr4] forKey:@"volume"];
    //    }
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr2] forKey:@"width"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr3] forKey:@"height"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr1] forKey:@"length"];
    // [dict setObject:[NSString stringWithFormat:@"%@",@"0"] forKey:@"show_type"];
    [dict setObject:[NSNumber numberWithBool:self.isrefresh] forKey:@"is_refresh"];
    [dict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"page_num"];
    [dict setObject:[NSString stringWithFormat:@"%@",@"10"] forKey:@"item_num"];
    [dict setObject:@"daban" forKey:@"search_type"];
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
                        NSMutableArray * images = [NSMutableArray array];
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
                    //   _label.hidden = YES;
                    if (self.showArray.count > 0) {
                        weakSelf.emptyDataView.hidden = YES;
                        weakSelf.tableview.hidden = NO;
                    }else{
                        NSMutableArray * array = [NSMutableArray array];
                        array = json[@"recommend"];
                        NSMutableArray * tempArray = [NSMutableArray array];
                        
                        for (int i = 0; i < array.count; i++) {
                            NSString * keyword = array[i];
                            if (i < 10) {
                                [tempArray addObject:keyword];
                                
                            }else{
                                break;
                            }
                        }
                        
                        for (UIView * view in weakSelf.emptyDataView.btnsView.subviews) {
                            if ([view isKindOfClass:[UIButton class]]) {
                                [view removeFromSuperview];
                            }
                        }
                        
                        [weakSelf.emptyDataView addKeywordArray:tempArray];
                        weakSelf.emptyDataView.hidden = NO;
                        weakSelf.tableview.hidden = YES;
                    }
                    weakSelf.isrefresh = true;
                    weakSelf.pageNum++;
                    [weakSelf.tableview.mj_footer endRefreshing];
                    [weakSelf.tableview reloadData];
                    
                }else{
                    // _label.hidden = YES;
                    [weakSelf.tableview.mj_footer endRefreshing];
                }
                
            }else{
                [weakSelf.tableview.mj_footer endRefreshing];
                //      _label.hidden = YES;
            }
        }else{
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
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

- (void)hideSetting{
    self.screenBtn.selected = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.showArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * SEGMENTDABANCELL = @"SEGMENTDABANCELL";
    RSSegmentCell * cell = [tableView dequeueReusableCellWithIdentifier:SEGMENTDABANCELL];
    if (!cell) {
        cell = [[RSSegmentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SEGMENTDABANCELL];
    }
    RSHuangAndDaModel * huangAndDamodel = self.showArray[indexPath.section];
    
    cell.huangAndDamodel = huangAndDamodel;
    cell.tiLabel.text = [NSString stringWithFormat:@"%@m²",huangAndDamodel.stoneTotalMessage];
    cell.weightLabel.hidden = YES;
    cell.weightLabel.text = [NSString stringWithFormat:@"%@吨",huangAndDamodel.stoneWeight];
    cell.keLabel.text = [NSString stringWithFormat:@"%@匝",huangAndDamodel.stoneNum];
    return cell;
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
    //数量
    detailVc.keAndZaStr = huangAndDamodel.stoneNum;
    detailVc.piAndFangStr = huangAndDamodel.stoneTotalMessage;
    
    detailVc.title = huangAndDamodel.stoneName;
    detailVc.phone = huangAndDamodel.phone;
    detailVc.weight = huangAndDamodel.stoneWeight;
    detailVc.userModel = self.userModel;
    detailVc.searchType = @"daban";
    detailVc.erpCode = huangAndDamodel.erpCode;
    detailVc.titleStr = @"";
    detailVc.companyName = huangAndDamodel.companyName;
    detailVc.stoneName = huangAndDamodel.stoneId;
    detailVc.dataSource = huangAndDamodel.dataSource;
    
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

static  NSInteger DABANoldSection = nil;
static NSInteger DABANnewSection = nil;
static NSString * DABANHEADERID = @"DABANDetailAndDaDetailID";

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    RSSegmentHeaderView * segmentview = [[RSSegmentHeaderView alloc]initWithReuseIdentifier:DABANHEADERID];
    RSHuangAndDaModel * huangAndDamodel = self.showArray[section];
    segmentview.conmpanyLabel.text = huangAndDamodel.companyName;
    segmentview.contentView.backgroundColor = [UIColor whiteColor];
    segmentview.userInteractionEnabled = YES;
    
    
    DABANnewSection = section;
    
    
    //RSHuangAndDaModel * huangAndDamodel = self.showArray[newSection];
    
    RSHuangAndDaModel * AhuangAndDamodel = [[RSHuangAndDaModel alloc]init];
    
    
    if (DABANnewSection > 0) {
        AhuangAndDamodel = self.showArray[DABANnewSection-1];
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
    [btn addTarget:self action:@selector(jumpDabanContent:) forControlEvents:UIControlEventTouchUpInside];
    return segmentview;
}



- (void)jumpDabanContent:(UIButton *)btn{
     RSHuangAndDaModel * huangAndDamodel = self.showArray[btn.tag - 1000];
    if ([self.userModel.userType isEqualToString:@"hxhz"]) {
        if ([huangAndDamodel.dataSource isEqualToString:@"DZYC"]) {
            //有问题
            RSDZYCMainCargoCenterViewController  * cargoCenterVc = [RSDZYCMainCargoCenterViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:huangAndDamodel.erpCode andCreat_userIDStr:@"-1" andUserIDStr:@"-1" andDataSoure:huangAndDamodel.dataSource];
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
        }else{
            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:huangAndDamodel.erpCode andCreat_userIDStr:@"-1" andUserIDStr:@"-1"];
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
        }
    }else{
        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
        myRingVc.erpCodeStr = huangAndDamodel.erpCode;
        myRingVc.userIDStr = @"-1";
        myRingVc.creat_userIDStr = @"-1";
        myRingVc.userModel = self.userModel;
        myRingVc.userType = @"hxhz";
        [self.navigationController pushViewController:myRingVc animated:YES];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    DABANoldSection = section;
    RSHuangAndDaModel * huangAndDamodel = self.showArray[DABANoldSection];
    RSHuangAndDaModel * AhuangAndDamodel = [[RSHuangAndDaModel alloc]init];
    if (DABANoldSection + 1 <= self.showArray.count - 1) {
        AhuangAndDamodel = self.showArray[DABANoldSection+1];
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
    DABANnewSection = section;
    
    
    RSHuangAndDaModel * huangAndDamodel = self.showArray[DABANnewSection];
    
    RSHuangAndDaModel * AhuangAndDamodel = [[RSHuangAndDaModel alloc]init];
    
    
    if (DABANnewSection > 0) {
        AhuangAndDamodel = self.showArray[DABANnewSection-1];
    }
    if ([huangAndDamodel.companyId isEqualToString:AhuangAndDamodel.companyId]) {
        return 0.1;
    }else{
        return 38;
    }
    
}



- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 2;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
        if (column == 0){
            return self.areas.count;
        }else{
            return self.sorts.count;
        }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
        
        if (indexPath.column == 0) {
            
            return self.areas[indexPath.row];
        } else{
            return self.sorts[indexPath.row];
        }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
    
    
    
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
    
    
    [self loadDabanDetailAndDaDetailNewData];
    
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

// new datasource

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

- (void)dabanscreeningConditionStr1:(NSString *)tempStr1 andStr2:(NSString *)tempStr2 andStr3:(NSString *)tempStr3 andStr4:(NSString *)tempStr4 andBtn1:(NSString *)btnStr1 andBtn2:(NSString *)btnStr2 andBtn3:(NSString *)btnStr3 andBtnStr4:(NSString *)btnStr4 andYBScreenCell:(YBScreenCell *)cell andSearchType:(NSString *)searchType {
    [_leftview hide];
    
    _tempStr1 = tempStr1;
    _tempStr2 = tempStr2;
    _tempStr3 = tempStr3;
    _tempStr4 = tempStr4;
    _btnStr1 = btnStr1;
    _btnStr2 = btnStr2;
    _btnStr3 = btnStr3;
    _btnStr4 = btnStr4;

    [self loadDabanDetailAndDaDetailNewData];
}




@end
