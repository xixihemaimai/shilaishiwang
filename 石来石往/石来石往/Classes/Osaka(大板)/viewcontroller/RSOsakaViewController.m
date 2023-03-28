//
//  RSOsakaViewController.m
//  石来石往
//
//  Created by mac on 17/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSOsakaViewController.h"
#import "RSDriverViewController.h"
//大板的模型
#import "RSOsakaModel.h"
#import "RSOsakaCell.h"
#import "RSChoiceOsakaCell.h"
//大板里面选择片的模型
#import "RSTurnsCountModel.h"

#import "RSPiecesModel.h"
//出货的详细信息
#import "RSDetailOsakaViewController.h"
#import "EBDropdownListView.h"


#import "RSOsakaHeaderview.h"


//司机的模型，随便写的数据
#import "RSDirverContact.h"
//出货的信息
#import "RSGoodOutController.h"




@interface RSOsakaViewController ()<RSDetailOsakaViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *_searchfield;
    
    UIView *_menuview;
    
    
    UIImageView * _contentImageview;
    
}



@property (nonatomic,strong)UITableView *detailTableview;

@property (nonatomic,strong)NSMutableArray * searchCountArray;
/**搜索的类型blockNo/ mtlName  荒料号/物料名称  兼容未传默认按荒料号*/
@property (nonatomic,strong)NSString * searchType;
//购物车
@property (nonatomic,strong)UIButton *shopCarBtn;
//购物车有多少个商品
@property (nonatomic,strong)UIButton *shopCarCountBtn;

//@property (nonatomic,strong)UITableView *tableview;


@property (nonatomic,strong)RSOsakaModel *model;
/**购物车里面的数值*/
@property (nonatomic,assign)NSInteger count;
@end

@implementation RSOsakaViewController




- (NSMutableArray *)choiceOsakaArray{
    if (_choiceOsakaArray == nil) {
        _choiceOsakaArray = [NSMutableArray array];
    }
    return _choiceOsakaArray;
}


- (NSMutableArray *)searchCountArray{
    if (_searchCountArray == nil) {
        _searchCountArray = [NSMutableArray array];
    }
    return _searchCountArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //对购物车里面装有多少模型的进行初始化
    self.count = 0;
    self.searchType = @"blockNo";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self addCustomNavigationBarView];
    
//    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - Height_NavBar - 45) style:UITableViewStylePlain];
//    tableview.delegate = self;
//    tableview.dataSource = self;
//    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview = tableview;
    [self isAddjust];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self.view addSubview:self.tableview];
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar - Height_bottomSafeArea - 45);
    [self.tableview registerClass:[RSOsakaCell class] forCellReuseIdentifier:osakaCellID];
    
//    [self addContentview];
    
    [self addBottomContentview];
    
    
    
    UIImageView *contentImageview = [[UIImageView alloc]init];
    contentImageview.image = [UIImage imageNamed:@"img_outstore_search_emptyview"];
    [self.view addSubview:contentImageview];
    _contentImageview = contentImageview;
    contentImageview.contentMode = UIViewContentModeScaleAspectFill;
    contentImageview.sd_layout
    .centerYEqualToView(self.view)
    .centerXEqualToView(self.view)
    .heightRatioToView(self.view,0.45)
    .widthRatioToView(self.view,0.7);
}

- (void)getData{
    //URL_PLATE_SEARCH_RESULT
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.userID forKey:@"userId"];
    [dict setObject:self.searchType forKey:@"searchType"];
    [dict setObject:@"1" forKey:@"erpId"];
    [dict setObject:@"daban" forKey:@"type"];
    [dict setObject:_searchfield.text forKey:@"blockno"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BLOCK_SEARCH_RESULT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [weakSelf.searchCountArray removeAllObjects];
                NSMutableArray * array =nil;
                array = json[@"Data"];
//                NSLog(@"=-=======================%@",json);
                if (array.count < 1) {
                    _contentImageview.hidden = NO;
                    [SVProgressHUD showInfoWithStatus:@"没有数据"];
                }else{
                    for (int i = 0; i < array.count; i++) {
                        RSOsakaModel * osakamodel = [[RSOsakaModel alloc]init];
                        osakamodel.DID = [[array objectAtIndex:i] objectForKey:@"DID"];
                        osakamodel.blockClasses = [[array objectAtIndex:i]objectForKey:@"blockClasses"];
                        osakamodel.blockID = [[array objectAtIndex:i] objectForKey:@"blockID"];
                        osakamodel.blockLWH = [[array objectAtIndex:i]objectForKey:@"blockLWH"];
                        osakamodel.blockName = [[array objectAtIndex:i]objectForKey:@"blockName"];
                        osakamodel.blockVolume = [[array objectAtIndex:i]objectForKey:@"blockVolume"];
                        osakamodel.erpid = [[array objectAtIndex:i] objectForKey:@"erpid"];
                        osakamodel.imgpath = [[array objectAtIndex:i] objectForKey:@"imgpath"];
                        NSMutableArray * turnsArray = nil;
                        turnsArray = [[array objectAtIndex:i]objectForKey:@"turns"];
                        for (int i = 0; i < turnsArray.count; i++) {
                            RSTurnsCountModel * turnsModel = [[RSTurnsCountModel alloc]init];
                            turnsModel.turnsID = [turnsArray objectAtIndex:i][@"turnsID"];
                            NSMutableArray * piecesArray = nil;
                            piecesArray =  [[turnsArray objectAtIndex:i] objectForKey:@"pieces"];
                            for (int i = 0; i < piecesArray.count; i++) {
                                RSPiecesModel * piecesModel = [[RSPiecesModel alloc]init];
                                piecesModel.area = [piecesArray objectAtIndex:i][@"area"];
                                piecesModel.pieceID = [piecesArray objectAtIndex:i][@"pieceID"];
                                piecesModel.pieceNum = [piecesArray objectAtIndex:i][@"pieceNum"];
                                [turnsModel.pieces addObject:piecesModel];
                            }
                            [osakamodel.turns addObject:turnsModel];
                        }
                        [weakSelf.searchCountArray addObject:osakamodel];
                    }
                    _contentImageview.hidden = YES;
                }
                [weakSelf.tableview reloadData];
            }else{
            }
        }else{
            _contentImageview.hidden = NO;
        }
    }];
}




- (void)addCustomNavigationBarView{
   
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"矩形-4"] forState:UIControlStateHighlighted];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn setTintColor:[UIColor colorWithHexColorStr:@"#666666"]];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(seachSearchfeildContent:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    
    UIView *searchview = [[UIView alloc]init];
    searchview.frame = CGRectMake(0, 0, SCW/2 + 80, 32);
    searchview.layer.borderWidth = 1;
    searchview.layer.borderColor = [UIColor colorWithHexColorStr:@"#dadada"].CGColor;
    searchview.layer.cornerRadius = 5;
    searchview.layer.masksToBounds = YES;
    searchview.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = searchview;
    
   EBDropdownListItem *item1 = [[EBDropdownListItem alloc] initWithItem:@"1" itemName:@"荒料号"];
   EBDropdownListItem *item2 = [[EBDropdownListItem alloc] initWithItem:@"2" itemName:@"物料名称"];
    EBDropdownListView *dropdownListView = [[EBDropdownListView alloc] initWithDataSource:@[item1, item2]];
    dropdownListView.frame = CGRectMake(0, 0, 85, 35);
    //dropdownListView.dataSource = @[item1, item2, item3, item4];
    dropdownListView.selectedIndex = 0;
    [dropdownListView setViewBorder:0 borderColor:[UIColor whiteColor] cornerRadius:0];
    [searchview addSubview:dropdownListView];
    RSWeakself;
    [dropdownListView setDropdownListViewSelectedBlock:^(EBDropdownListView *dropdownListView) {
    //           NSString *msgString = [NSString stringWithFormat:
    //                                  @"selected name:%@  id:%@  index:%ld"
    //                                  , dropdownListView.selectedItem.itemName
    //                                  , dropdownListView.selectedItem.itemId
    //                                  , dropdownListView.selectedIndex];
        if ([dropdownListView.selectedItem.itemName isEqualToString:@"荒料号"]) {
            weakSelf.searchType = @"blockNo";
        }else{
            weakSelf.searchType = @"mtlName";
        }
    }];
    
    UIView * midview = [[UIView alloc]init];
    midview.frame = CGRectMake(CGRectGetMaxX(dropdownListView.frame) + 1, 4, 0.5, 27);
    midview.backgroundColor = [UIColor colorWithHexColorStr:@"#979797"];
    [searchview addSubview:midview];
    
    
    UITextField *searchfield = [[UITextField alloc]init];
    searchfield.borderStyle = UITextBorderStyleNone;
    //searchfield.placeholder = @"查询石材";
    [searchview addSubview:searchfield];
    //[searchfield addTarget:searchfield action:@selector(monitorTextfieldChang:) forControlEvents:UIControlEventEditingChanged];
    _searchfield = searchfield;
    
    
    searchfield.sd_layout
    .leftSpaceToView(midview, 5)
    .topSpaceToView(searchview, 0)
    .bottomSpaceToView(searchview, 0)
    .rightSpaceToView(searchview, 50);
    
    
}
#pragma mark -- 添加底部视图
- (void)addBottomContentview{
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, SCH - Height_NavBar - Height_bottomSafeArea - 45, SCW, 45)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f7f7f7"];
    [self.view addSubview:bottomview];
    UIButton * shopCarBtn = [[UIButton alloc]init];
    [shopCarBtn setImage:[UIImage imageNamed:@"货车"] forState:UIControlStateNormal];
    [bottomview addSubview:shopCarBtn];
    shopCarBtn.enabled = NO;
    self.shopCarBtn = shopCarBtn;
    self.shopCarBtn.tag = 0;
    [shopCarBtn addTarget:self action:@selector(showChoiceProduct:) forControlEvents:UIControlEventTouchUpInside];
    //用来对添加蒙板和detailtablview的判断
    UIButton * nextStepBtn = [[UIButton alloc]init];
    [nextStepBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
    [nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStepBtn addTarget:self action:@selector(nextViewController:) forControlEvents:UIControlEventTouchUpInside];
    nextStepBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [bottomview addSubview:nextStepBtn];
//    bottomview.sd_layout
//    .leftSpaceToView(self.view,0)
//    .rightSpaceToView(self.view,0)
//    .bottomSpaceToView(self.view,0)
//    .heightIs(45);
    
    shopCarBtn.sd_layout
    .centerYEqualToView(bottomview)
    .leftSpaceToView(bottomview,12)
    .widthIs(40)
    .heightIs(25);
    
    nextStepBtn.sd_layout
    .rightSpaceToView(bottomview,0)
    .topSpaceToView(bottomview,0)
    .bottomSpaceToView(bottomview,0)
    .widthRatioToView(bottomview,0.3);
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithHexColorStr:@"#dadada"];
    [bottomview addSubview:view];
    view.sd_layout
    .leftSpaceToView(bottomview,0)
    .rightSpaceToView(bottomview,0)
    .topSpaceToView(bottomview,0)
    .heightIs(1);
    
    
    UIButton * shopCarCountBtn = [[UIButton alloc]init];
    [shopCarCountBtn setBackgroundImage:[UIImage imageNamed:@"椭圆-1"] forState:UIControlStateNormal];
    [shopCarCountBtn setTitle:@"" forState:UIControlStateNormal];
    shopCarCountBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomview addSubview:shopCarCountBtn];
    self.shopCarCountBtn = shopCarCountBtn;
    self.shopCarCountBtn.hidden = YES;
    // self.shopCarCountBtn.enabled = NO;
    
    shopCarCountBtn.sd_layout
    .leftSpaceToView(shopCarBtn,-10)
    .topSpaceToView(bottomview,2)
    .widthIs(20)
    .heightIs(20);
    
}


static NSString *osakaCellID = @"osakacell";
static NSString *choiceCellID = @"choicecell";
//- (void)addContentview{
//    CGFloat bottomH;
//    if (iPhoneX_All) {
//        bottomH = 45+34;
//    }else{
//        bottomH = 45;
//    }
   
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableview) {
        return self.searchCountArray.count;
    }else{
        return self.choiceOsakaArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableview) {
       RSOsakaCell * cell = [tableView dequeueReusableCellWithIdentifier:osakaCellID];
        //RSOsakaCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        if (cell == nil) {
//            cell = [[RSOsakaCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:osakaCellID];
//        }
        RSOsakaModel *osakaModel = self.searchCountArray[indexPath.row];
        cell.osakaModel = osakaModel;
        if (self.choiceOsakaArray.count > 0) {
            //当再次选择搜索的时候
            for (int j = 0; j < self.choiceOsakaArray.count; j++) {
                RSOsakaModel * choiceosakaModel = self.choiceOsakaArray[j];
                if ([choiceosakaModel.blockID isEqualToString:osakaModel.blockID]) {
                    cell.userInteractionEnabled = NO;
                    cell.choicelabel.hidden = NO;
                    break;
                }else{
                    osakaModel.count = 0;
                    cell.userInteractionEnabled = YES;
                    cell.choicelabel.hidden = YES;
                }
            }
        }else{
            osakaModel.count = 0;
            cell.userInteractionEnabled = YES;
            cell.choicelabel.hidden = YES;
        }
//        if (osakaModel.count > 0) {
//            cell.userInteractionEnabled = NO;
//            cell.choicelabel.hidden =NO;
//        }else{
        //            cell.userInteractionEnabled = YES;
      //  cell.choicelabel.hidden = YES;

//        }
        

        // cell.tag = 1000+indexPath.row;
        //osakaModel.tag = cell.tag;
        return cell;
        
    }else{
        //用来显示购物车里面的东西cell的内容
        RSChoiceOsakaCell *cell = [[RSChoiceOsakaCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:choiceCellID];
        RSOsakaModel *osakaModel = self.choiceOsakaArray[indexPath.row];
        cell.osakaModel = osakaModel;

        CGFloat zongPi = 0.0;
        if (self.choiceOsakaArray.count > 0) {
            //按片
            if (self.styleModel == 2) {
                    for (int j = 0; j < osakaModel.turns.count; j++) {
                        RSTurnsCountModel * turnsModel = osakaModel.turns[j];
                            for (int n = 0; n < turnsModel.pieces.count; n++) {
                                RSPiecesModel * piecesModel = turnsModel.pieces[n];
                                if (piecesModel.status == 1) {
                                    zongPi += [piecesModel.area floatValue];
                        }
                    }
                }
            }else{
            //按匝
                   for (int j = 0; j < osakaModel.turns.count; j++) {
                       RSTurnsCountModel * turnsModel = osakaModel.turns[j];
                            if (turnsModel.turnsStatus == 1) {
                            for (int n = 0; n < turnsModel.pieces.count; n++) {
                                RSPiecesModel * piecesModel = turnsModel.pieces[n];
                                zongPi += [piecesModel.area floatValue];
                        }
                    }
                }
            }
        }
        cell.choiceCountLabel.text = [NSString stringWithFormat:@"%ld片  (%0.3fm²)",(long)osakaModel.count,zongPi];
       
        [cell.modifyBtn addTarget:self action:@selector(modifyChoiceCount:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.modifyBtn.tag = indexPath.row;
        //cell.tag = indexPath.row;
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableview) {
        return 105;
    }else{
        return 105;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableview) {
        //NSIndexPath *indexpath = [self.tableview indexPathForSelectedRow];
        RSOsakaModel *osakaModel = self.searchCountArray[indexPath.row];
        //跳转到每个cell的详情页面上面
        RSDetailOsakaViewController *detailOsakaVc = [[RSDetailOsakaViewController alloc]init];
        detailOsakaVc.styleModel = self.styleModel;
        //把你选择哪一行的模型里面的数据，进行setter的方法传递过来
        detailOsakaVc.osakaModel = osakaModel;
      // RSTurnsCountModel *turnsModel = osakaModel.turns[indexPath.row];
        detailOsakaVc.leixi = topicOsaka;
        detailOsakaVc.delegate = self;
        //这个是用来确定是哪个osakaModel的位置
        osakaModel.tag = indexPath.row;
        //detailOsakaVc.turnsModel = turnsModel;
        [self.navigationController pushViewController:detailOsakaVc animated:YES];
        
    }
    
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView != self.tableview) {
        
        static NSString * OSAKAHEADERVIEWID = @"OSAKAHEADERVIEWID";
        RSOsakaHeaderview * osakaHeaderview = [self.detailTableview dequeueReusableHeaderFooterViewWithIdentifier:OSAKAHEADERVIEWID];
        if (!osakaHeaderview) {
            osakaHeaderview = [[RSOsakaHeaderview alloc]initWithReuseIdentifier:OSAKAHEADERVIEWID];
        }
        if (self.choiceOsakaArray.count > 0) {
            CGFloat zongPi = 0.0;
            osakaHeaderview.zongPiLabel.hidden = NO;
           
            //按片
            if (self.styleModel == 2) {
                for (int i = 0; i < self.choiceOsakaArray.count; i++) {
                                RSOsakaModel *osakaModel = self.choiceOsakaArray[i];
                                for (int j = 0; j < osakaModel.turns.count; j++) {
                                    RSTurnsCountModel * turnsModel = osakaModel.turns[j];
                                    for (int n = 0; n < turnsModel.pieces.count; n++) {
                                        RSPiecesModel * piecesModel = turnsModel.pieces[n];
                                        if (piecesModel.status == 1) {
                                            zongPi += [piecesModel.area floatValue];
                                        }
                                    }
                                }
                            }
            }else{
             //按匝
            for (int i = 0; i < self.choiceOsakaArray.count; i++) {
                                RSOsakaModel *osakaModel = self.choiceOsakaArray[i];
                                for (int j = 0; j < osakaModel.turns.count; j++) {
                                    RSTurnsCountModel * turnsModel = osakaModel.turns[j];
                           if (turnsModel.turnsStatus == 1) {
                               for (int n = 0; n < turnsModel.pieces.count; n++) {
                               RSPiecesModel * piecesModel = turnsModel.pieces[n];
                               zongPi += [piecesModel.area floatValue];
                            }
                        }
                     }
                }
            }
            osakaHeaderview.zongPiLabel.text = [NSString stringWithFormat:@"总面积:%0.3fm²",zongPi];
            
            
        }else{
            osakaHeaderview.zongPiLabel.hidden = YES;
        }
        return osakaHeaderview;
        
    }
    return nil;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (tableView != self.tableview) {
//        return @"已选";
//    }
//    return @"";
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView != self.tableview) {
        return 50;
    }
    return 0.0001;
}




#pragma mark -- 要跳转到添加大板的页面
- (void)nextViewController:(UIButton *)btn{
    
    if (self.shopCarBtn.enabled == YES) {
        /*
        RSGoodOutController * goodVc = [[RSGoodOutController alloc]init];
        goodVc.shopNumberCountArray = self.choiceOsakaArray;
        goodVc.userID = self.userID;
        goodVc.userModel = self.userModel;
       // goodVc.contact = self.contact;
        goodVc.outStyle = @"daban";
        
        [self.navigationController pushViewController:goodVc animated:YES];
        
        */
        
        
        
        RSDriverViewController *driverVc = [[RSDriverViewController alloc]init];
        //这个是送到司机上面显示选择了多少片或者选择了多少匝
        //driverVc.shopCarNumberArray = self.shopCarInformationArray;
        driverVc.shopCarNumberArray = self.choiceOsakaArray;
        driverVc.userID = self.userID;
        driverVc.userModel = self.userModel;
        driverVc.outStyle = @"daban";
        [self.navigationController pushViewController:driverVc animated:YES];
         
        
         
    }else{
        [SVProgressHUD showErrorWithStatus:@"请选择商品"];
    }
    
    
    
}


#pragma mark -- 点击购物车的要做的动作
- (void)showChoiceProduct:(UIButton *)btn{
//    CGFloat Y = 0.0;
//    if (JH_isIPhone_IPhoneX_All) {
//        Y = 34;
//    }else{
//        Y = 0;
//    }
   
    if (btn.tag == 0) {
        UIView *menuview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH/2)];
        menuview.backgroundColor = [[UIColor darkGrayColor]colorWithAlphaComponent:0.4];
        [self.view addSubview:menuview];
        _menuview = menuview;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeMenuView)];
        [menuview addGestureRecognizer:tap];
        
        
        UITableView *detailTableview = [[UITableView alloc]init];
        detailTableview.delegate = self;
        detailTableview.dataSource = self;
        _detailTableview = detailTableview;
        _detailTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTableview.frame = CGRectMake(0, SCH /2, SCW,(SCH/2)- 45);
        [self.view addSubview:detailTableview];
        
        //注册
        [self.detailTableview registerClass:[RSChoiceOsakaCell class] forCellReuseIdentifier:choiceCellID];
        btn.tag = 1;
        
    }else{
        [_detailTableview removeFromSuperview];
        [_menuview removeFromSuperview];
        btn.tag = 0;
    }
}



#pragma mark -- 代理方法
- (void)choiceDataWithSendOsakaModel:(RSOsakaModel *)osakaModel{
    if (osakaModel.count > 0 ) {
        if (self.model != osakaModel) {
            [self.choiceOsakaArray addObject:osakaModel];
            self.shopCarBtn.enabled = YES;
            self.count++;
            [self.shopCarCountBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.count] forState:UIControlStateNormal];
            self.shopCarCountBtn.hidden = NO;
            //在进行对选中那个Cell进行不能选中的操作
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:osakaModel.tag inSection:0];
            RSOsakaCell *cell = [self.tableview cellForRowAtIndexPath:indexpath];
            if (cell.selected == YES) {
                cell.userInteractionEnabled = NO;
                cell.choicelabel.hidden = NO;
                [SVProgressHUD showInfoWithStatus:@"该行已选中"];
            }
        }
    }
    [self.detailTableview reloadData];
}







#pragma mark -- 当选择为0的时候
- (void)removeDataWithSendOsakaModel:(RSOsakaModel *)osakaModel{
    
    if (osakaModel.count == 0) {
        
            [self.choiceOsakaArray removeObject:osakaModel];
            
            if (self.choiceOsakaArray.count == 0) {
                self.shopCarBtn.enabled = NO;
                self.shopCarCountBtn.hidden = YES;
            }
            
            self.count--;
            [self.shopCarCountBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.count] forState:UIControlStateNormal];
            
            
            //在进行对选中那个Cell进行进行不能选中的操作
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:osakaModel.tag inSection:0];
            RSOsakaCell *cell = [self.tableview cellForRowAtIndexPath:indexpath];
            cell.userInteractionEnabled = YES;
            cell.choicelabel.hidden = YES;
            if (cell.selected == YES) {
                [SVProgressHUD showSuccessWithStatus:@"该行未选中"];
            }
        self.model = nil;
            
    }
    [self.tableview reloadData];
    [self.detailTableview reloadData];
    
}



#pragma mark --- 点击购物车里面的cell的修改按键
- (void)modifyChoiceCount:(UIButton *)btn{
    
           
    
            RSDetailOsakaViewController *detailVc = [[RSDetailOsakaViewController alloc]init];
    
    
            detailVc.styleModel = self.styleModel;
            
            //这里就是按片
            //把你选择哪一行的模型里面的数据，进行setter的方法传递过来
            RSOsakaModel *osakaModel = self.choiceOsakaArray[btn.tag];
            //用来进行判断的
            self.model = osakaModel;
            detailVc.osakaModel = osakaModel;
            detailVc.leixi = topicDetail;
//            RSTurnsCountModel *turnsModel = osakaModel.turns[osakaModel.tag];
            //detailVc.turnsModel = turnsModel;
            detailVc.delegate = self;
            [self.navigationController pushViewController:detailVc animated:YES];
        }
        
        
#pragma mark -- 移除购物车的方式
- (void)removeMenuView{
    [_menuview removeFromSuperview];
    [self.detailTableview removeFromSuperview];
   }
        
        
//#pragma mark -- 清空搜索框
//- (void)clearSearchfieldContent:(UIButton *)btn{

//    _contentImageview.hidden = NO;
//    
//            [_searchfield setText:@""];
//            [_searchfield endEditing:YES];
//}
        
#pragma mark -- 返回到大板出货的界面
//- (void)backOsakaViewController{
//    [self.navigationController popViewControllerAnimated:YES];
//}
        
        
#pragma mark -- 搜索的商品
- (void)seachSearchfeildContent:(UIButton *)btn{
            [_searchfield endEditing:YES];
            
            [self getData];
            
}
        
- (void)didReceiveMemoryWarning {
            [super didReceiveMemoryWarning];
            
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
}


@end
