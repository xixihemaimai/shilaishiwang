//
//  RSBlockOutViewController.m
//  石来石往
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSBlockOutViewController.h"
#import "RSBlockOutCell.h"
#import "RSDriverViewController.h"
#import "RSBlockModel.h"
//#import "RSShopCarViewController.h"
#import "RSShopCarCell.h"

#import "RSBlockHeaderview.h"
#import "EBDropdownListView.h"



//司机的模型，随便写的数据
#import "RSDirverContact.h"
//出货的信息
#import "RSGoodOutController.h"


static NSString *blockoutID = @"blockoutcell";
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(100)]
@interface RSBlockOutViewController ()<RSShopCarCellDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField * _searchfield;
    UIView *_menuview;
    UIImageView * _contentImageview;
}
/**搜索的类型blockNo/ mtlName  荒料号/物料名称  兼容未传默认按荒料号*/
@property (nonatomic,strong)NSString * searchType;
/**点击购物车出来的tableview*/
@property (nonatomic,strong)UITableView *detailTableview;
/**购物车*/
@property (nonatomic,strong)UIButton * shopCarBtn;
//从网上获取数据出来的值
@property (nonatomic,strong)NSMutableArray *tempArray;

//@property (nonatomic,strong)UITableView *tablview;

@property (nonatomic,assign)NSInteger count;


@property (nonatomic,strong)UIButton * shopCarCountBtn;

@property (nonatomic,strong)RSBlockOutCell *cell;

@end

@implementation RSBlockOutViewController



- (NSMutableArray *)tempArray{
    if (_tempArray == nil) {
        _tempArray = [NSMutableArray array];
    }
    return _tempArray;
    
}

- (NSMutableArray *)shopCarInformationArray{
    if (_shopCarInformationArray == nil) {
        _shopCarInformationArray = [NSMutableArray array];
    }
    return _shopCarInformationArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    //对返回按钮的隐藏
//    [self.navigationItem setHidesBackButton:YES];
    //对购物车计算
     self.count = self.shopCarInformationArray.count;
    [self.shopCarCountBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.count] forState:UIControlStateNormal];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}



static NSString * BLOCKHEADERVIEWID = @"BLOCKHEADERVIEWID";
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.searchType = @"blockNo";
    
    //添加tableview来显示出从服务器里面获取的数据
//    [self addCustomTableview];
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar - Height_bottomSafeArea - 45);
    
//    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - Height_NavBar - bottomH) style:UITableViewStylePlain];
//    tableview.delegate = self;
//    tableview.dataSource = self;
//    self.tablview = tableview;
//
//    self.tablview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.tableview registerClass:[RSBlockOutCell class] forCellReuseIdentifier:blockoutID];
    
    //添加自定义导航栏
    [self addCustomNavigationBarView];
    
   
    
    //添加底部视图
    [self addBottomContentview];
    
    UIImageView *contentImageview = [[UIImageView alloc]init];
    contentImageview.image = [UIImage imageNamed:@"img_outstore_search_emptyview"];
    [self.view addSubview:contentImageview];
    contentImageview.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageview = contentImageview;
    contentImageview.sd_layout
    .centerYEqualToView(self.view)
    .centerXEqualToView(self.view)
    .heightRatioToView(self.view,0.45)
    .widthRatioToView(self.view,0.7);
}

- (void)getData{
    //URL_BLOCK_SEARCH_RESULT
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.searchType forKey:@"searchType"];
    [dict setObject:[UserManger getUserObject].userID forKey:@"userId"];
    [dict setObject:_searchfield.text forKey:@"blockno"];
    [dict setObject:@"1" forKey:@"erpId"];
    [dict setObject:@"huangliao" forKey:@"type"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    //URL_BLOCK_SEARCH_RESULT_IOS URL_BLOCK_SEARCH_RESULT
//    __weak typeof(self) weakSelf = self;
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BLOCK_SEARCH_RESULT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
//            NSLog(@"------------------------%@",json);
            if (Result) {
                _contentImageview.hidden = YES;
                NSMutableArray *array = nil;
                array = json[@"Data"];
                [weakSelf.tempArray removeAllObjects];
                if (array.count  < 1) {
                    [SVProgressHUD showInfoWithStatus:@"没有数据"];
                    _contentImageview.hidden = NO;
                }else{
                    for (int i = 0; i < array.count; i++) {
                        RSBlockModel *blockModel = [[RSBlockModel alloc]init];
                        blockModel.DID = [[array objectAtIndex:i]objectForKey:@"DID"];
                        blockModel.blockClasses = [[array objectAtIndex:i]objectForKey:@"blockClasses"];
                        blockModel.blockID = [[array objectAtIndex:i]objectForKey:@"blockID"];
                        blockModel.blockLWH = [[array objectAtIndex:i]objectForKey:@"blockLWH"];
                        blockModel.blockName = [[array objectAtIndex:i]objectForKey:@"blockName"];
                        blockModel.blockVolume = [[array objectAtIndex:i]objectForKey:@"blockVolume"];
                        blockModel.erpid = [[array objectAtIndex:i]objectForKey:@"erpid"];
                        blockModel.imgpath = [[array objectAtIndex:i]objectForKey:@"imgpath"];
                        blockModel.turns = [[array objectAtIndex:i]objectForKey:@"turns"];
                        blockModel.isSelected = 0;
                        [weakSelf.tempArray addObject:blockModel];
                    }
                     _contentImageview.hidden = YES;
                }
                [weakSelf.tableview reloadData];
            }else{
                _contentImageview.hidden = NO;
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"搜索结果失败"];
            _contentImageview.hidden = NO;
        }
    }];
}

- (void)addCustomNavigationBarView{
//    UIView *navigationview = [[UIView alloc]init];
//    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
//        navigationview.frame = CGRectMake(0, 0, SCW, 64);
//    }else{
//        navigationview.frame = CGRectMake(0, 0, SCW, 88);
//    }
//    navigationview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
//    [self.view addSubview:navigationview];
    
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"矩形-4"] forState:UIControlStateHighlighted];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn setTintColor:[UIColor colorWithHexColorStr:@"#666666"]];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(seachSearchfeildContent:) forControlEvents:UIControlEventTouchUpInside];
//
//
     
//    RSNavigationButton  * backItem = [[RSNavigationButton alloc]init];
//    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
//        backItem.frame = CGRectMake(12, 30, 40, 30);
//    }else{
//        backItem.frame = CGRectMake(12, 50, 40, 30);
//    }
//    [backItem setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//    [backItem addTarget:self action:@selector(backStockViewController) forControlEvents:UIControlEventTouchUpInside];
//    [navigationview addSubview:backItem];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    
    UIView *searchview = [[UIView alloc]init];
    searchview.frame = CGRectMake(0, 0, SCW/2 + 80, 32);
    searchview.layer.borderWidth = 1;
    searchview.layer.borderColor = [UIColor colorWithHexColorStr:@"#dadada"].CGColor;
    searchview.layer.cornerRadius = 5;
    searchview.layer.masksToBounds = YES;
    searchview.backgroundColor = [UIColor whiteColor];
//    [navigationview addSubview:searchview];
    self.navigationItem.titleView = searchview;
    
    
//    if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
//        searchview.sd_layout
//        .centerXEqualToView(navigationview)
////        .topSpaceToView(navigationview, 26.5)
////        .widthRatioToView(navigationview, 0.7)
//        .heightIs(35);
//    }else{
//        searchview.sd_layout
//        .centerXEqualToView(navigationview)
//        .topSpaceToView(navigationview, 48.5)
//        .widthRatioToView(navigationview, 0.7)
//        .heightIs(35);
//    }
    
    
    
    
//    UIImageView * searchimageview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 7.5, 20, 20)];
//    searchimageview.image = [UIImage imageNamed:@"放大镜"];
//    [searchview addSubview:searchimageview];
    
    
    
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

    
//
//    searchBtn.sd_layout
//    .topEqualToView(searchview)
//    .bottomEqualToView(searchview)
//    .leftSpaceToView(searchfield, 10)
//    .rightSpaceToView(searchview, 0);
    
    
    //UIBarButtonItem * righitem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    //self.navigationItem.rightBarButtonItem = righitem;
    
    /*
    UIView * bottomDLview = [[UIView alloc]init];
    bottomDLview.backgroundColor = [UIColor colorWithHexColorStr:@"#d6d6d6"];
    [navigationview addSubview:bottomDLview];
    
    
    navigationview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(64);
    
    backItem.sd_layout
    .leftSpaceToView(navigationview,8)
    .topSpaceToView(navigationview,27)
    .widthIs(40)
    .heightIs(30);
    
     */
   
    
    

    
    
    /*
    bottomDLview.sd_layout
    .leftSpaceToView(navigationview,0)
    .rightSpaceToView(navigationview,0)
    .bottomSpaceToView(navigationview,0)
    .heightIs(1);
     */
    
}


#pragma mark -- 添加底部视图
- (void)addBottomContentview{
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, SCH - Height_NavBar - Height_bottomSafeArea - 45 , SCW, 45)];
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
    [nextStepBtn addTarget:self action:@selector(nextStepViewController:) forControlEvents:UIControlEventTouchUpInside];
    nextStepBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [bottomview addSubview:nextStepBtn];
    
    
    
//    bottomview.sd_layout
//    .leftSpaceToView(self.view,0)
//    .rightSpaceToView(self.view,0)
//    .heightIs(45)
//    if (iphonex) {
//    .bottomSpaceToView(self.view,34);
//    }else{
//    .bottomSpaceToView(self.view,0);
//    }
    
    
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



#pragma mark -- 添加自己tableview
//- (void)addCustomTableview{
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
        return self.tempArray.count;
    }else{
        return self.shopCarInformationArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableview) {
//        self.cell.contentView.backgroundColor = [UIColor whiteColor];
        self.cell = [tableView dequeueReusableCellWithIdentifier:blockoutID];
        // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        RSBlockModel *blockModel = self.tempArray[indexPath.row];
//        _cell.productLabel.text = blockModel.productStr;
//        _cell.psLabel.text = blockModel.psStr;
//        _cell.numberlabel.text = blockModel.numberStr;
        _cell.numberlabel.text = [NSString stringWithFormat:@"%@/%@",blockModel.erpid,blockModel.blockID];
        _cell.productLabel.text = [NSString stringWithFormat:@"%@",blockModel.blockName];
        _cell.psLabel.text = [NSString stringWithFormat:@"%@",blockModel.blockLWH];
        _cell.selectedStutas = blockModel.isSelected;
        _cell.tag = 1000 + indexPath.row;
        blockModel.tag = _cell.tag;
        if (self.shopCarInformationArray.count > 0) {
            //当再次选择搜索的时候
            for (int j = 0; j < self.shopCarInformationArray.count; j++) {
                RSBlockModel * shopBlockModel = self.shopCarInformationArray[j];
                if ([shopBlockModel.blockID isEqualToString:blockModel.blockID]) {
                    _cell.selectedStutas = YES;
                    break;
                }else{
                    _cell.selectedStutas = false;
                }
            }
        }else{
             _cell.selectedStutas = false;
        }
        __weak typeof(self) weakSelf = self;
        self.cell.ChoseBtnBlock = ^(__weak UITableViewCell *tapCell, BOOL selected) {
            //使用model动态记录cell按钮选中情况
            NSIndexPath *path = [tableView indexPathForCell:tapCell];
            RSBlockModel *model = [weakSelf.tempArray objectAtIndex:path.row];
            model.isSelected = selected;
            //shopCarBtn购物车的按键
            //shopCarCountBtn购物车上面的按键
            if (selected == YES) {
                weakSelf.count++;
                weakSelf.shopCarCountBtn.hidden = NO;
                [weakSelf.shopCarCountBtn setTitle:[NSString stringWithFormat:@"%ld",(long)weakSelf.count] forState:UIControlStateNormal];
                //这边还需要确定是哪个模型，增加模型
                [weakSelf.shopCarInformationArray addObject:model];
                if (weakSelf.shopCarInformationArray.count > 0) {
                   weakSelf.shopCarBtn.enabled = YES;
                }
            }else{
                if (weakSelf.shopCarInformationArray.count > 0) {
                    
                    //这边要对购物车里面的数据进行对比，在进行删除
                    for (int j = 0; j < weakSelf.shopCarInformationArray.count ; j++) {
                        RSBlockModel * blockModel = weakSelf.shopCarInformationArray[j];
                        if ([blockModel.blockID isEqualToString:model.blockID]  ) {
                            [weakSelf.shopCarInformationArray removeObjectAtIndex:j];
                            weakSelf.count--;
                            [weakSelf.shopCarCountBtn setTitle:[NSString stringWithFormat:@"%ld",(long)weakSelf.count] forState:UIControlStateNormal];
                            if ([weakSelf.shopCarCountBtn.currentTitle isEqualToString:@"0"]) {
                                weakSelf.shopCarCountBtn.hidden = YES;
                            }
                            //这边还需要确定是哪个模型，减去哪个模型
                            [weakSelf.shopCarInformationArray removeObject:model];
                            if (weakSelf.shopCarInformationArray.count <= 0) {
                                weakSelf.shopCarBtn.enabled = NO;
                            }
                            break;
                        }
                    }
                }else{
                    weakSelf.count--;
                    [weakSelf.shopCarCountBtn setTitle:[NSString stringWithFormat:@"%ld",(long)weakSelf.count] forState:UIControlStateNormal];
                    if ([weakSelf.shopCarCountBtn.currentTitle isEqualToString:@"0"]) {
                        weakSelf.shopCarCountBtn.hidden = YES;
                    }
                    //这边还需要确定是哪个模型，减去哪个模型
                    [weakSelf.shopCarInformationArray removeObject:model];
                    if (weakSelf.shopCarInformationArray.count <= 0) {
                        weakSelf.shopCarBtn.enabled = NO;
                    }
                }
            }
        };
         _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _cell;
    }else{
        RSShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:shopCarID];
        RSBlockModel *blockModel = self.shopCarInformationArray[indexPath.row];
        cell.numberlabel.text = [NSString stringWithFormat:@"%@/%@",blockModel.erpid,blockModel.blockID];
        cell.productLabel.text = [NSString stringWithFormat:@"%@",blockModel.blockName];
        cell.psLabel.text = [NSString stringWithFormat:@"%@",blockModel.blockLWH];
        cell.removeBtn.tag = indexPath.row;
        cell.delegate = self;
        cell.tiDetailLabel.text = [NSString stringWithFormat:@"%@m³",blockModel.blockVolume];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (tableView == self.tablview) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        RSBlockModel *model = [self.tempArray objectAtIndex:indexPath.row];
//        model.isSelected = !model.isSelected;
//        //刷新当前哪一组，哪一行
//        [self.tablview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]]  withRowAnimation:UITableViewRowAnimationNone];
//        //[self calculateWhetherFutureGenerations];
//    }
//    
//    
//}



//#pragma mark -- 监测输入框的值
//- (void)monitorTextfieldChang:(UITextField *)textfield{
//    BOOL isText = [self isnstring:textfield.text];
//    if (!isText) {
//        [SVProgressHUD showErrorWithStatus:@"请输入字符串"];
//        return;
//    }
//}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableview) {
         return 107.5;
    }else{
        return 140;
    }
    
    
   
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   if (tableView == self.detailTableview) {
        RSBlockHeaderview * blockHeaderview = [self.detailTableview dequeueReusableHeaderFooterViewWithIdentifier:BLOCKHEADERVIEWID];
        if (!blockHeaderview) {
            blockHeaderview = [[RSBlockHeaderview alloc]initWithReuseIdentifier:BLOCKHEADERVIEWID];
        }
       if (self.shopCarInformationArray.count > 0) {
           blockHeaderview.zongLiLabel.hidden = NO;
           CGFloat zongLi = 0.0;
           for (int i = 0; i < self.shopCarInformationArray.count; i++) {
               RSBlockModel *blockModel = self.shopCarInformationArray[i];
               zongLi += [blockModel.blockVolume floatValue];
           }
           blockHeaderview.zongLiLabel.text = [NSString stringWithFormat:@"总体积:%0.3fm³",zongLi];
       }else{
           blockHeaderview.zongLiLabel.hidden = YES;
       }
     return blockHeaderview;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.detailTableview) {
        return 50;
    }
    return 0.00001;
}


- (void)removeDetailTableviewCell:(NSInteger)tag{
   
    

    //对购物车的选择的模型里面的isSelect的设置,改为不被选择，这样的model也不会添加到购物车里面的模型里面
    //由于是增加进来的数组不是规律的，所以添加进来的中的模型，在self.tempArray不是利用Tag来
    
    
    if (self.shopCarInformationArray.count > 0) {
        RSBlockModel *blockmodel = self.shopCarInformationArray[tag];
        //RSBlockOutCell *cell = [self.cell viewWithTag:blockmodel.tag];
        for (int i =1000; i < 1000+self.tempArray.count; i++) {
            if (blockmodel.tag == i) {
                blockmodel.isSelected = NO;
                self.cell.choiceBtn.selected = NO;
                [self.tableview reloadData];
                self.count--;
                [self.shopCarCountBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.count] forState:UIControlStateNormal];
                if (self.count == 0) {
                    self.shopCarBtn.enabled = NO;
                }
                
            }
        }
        
        
    }
    
    //移除你需要的哪个一个模型数组的位置
    [self.shopCarInformationArray removeObjectAtIndex:tag];
    
    //重新设置位置
    _detailTableview.frame = CGRectMake(0, SCH/2, SCW, (SCH/2) -45);
    
    
    
    //对数组为0的时候进行判断
    if (self.shopCarInformationArray.count <= 0) {
        [_menuview removeFromSuperview];
        [_detailTableview removeFromSuperview];
    }
    
    //对购物车的改变
    [self.shopCarCountBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.shopCarInformationArray.count] forState:UIControlStateNormal];
    if (self.shopCarInformationArray.count <= 0) {
        self.shopCarCountBtn.hidden =  YES;
    }
    
    //重新刷新
    [self.detailTableview reloadData];
    
    
    
    
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_menuview removeFromSuperview];
    [self.detailTableview removeFromSuperview];
    
    
    
}


#pragma mark -- 返回跳转的视图
//- (void)backStockViewController{
//    [self.navigationController popViewControllerAnimated:YES
//     ];
//}



//#pragma mark -- 清除搜索框中的内容
//- (void)clearSearchfieldContent:(UIButton *)btn{
//    NSLog(@"清除搜索框中的内容");
//    _contentImageview.hidden = NO;
//     [_searchfield setText:@""];
//    [_searchfield endEditing:YES];
//}

#pragma mark -- 搜索搜索框中的内容
- (void)seachSearchfeildContent:(UIButton *)btn{
   
    //通过获取搜索框中的字符，来进行发送到服务器里面拿到里面的东西
    
    [_searchfield endEditing:YES];
    
    
    [self getData];
   
    
}

#pragma mark -- 跳转到司机的界面
- (void)nextStepViewController:(UIButton *)btn{
    if (self.shopCarBtn.enabled == YES) {
//
//        RSGoodOutController * goodVc = [[RSGoodOutController alloc]init];
//        goodVc.shopNumberCountArray = self.shopCarInformationArray;
//        goodVc.userID = self.userID;
//        goodVc.userModel = self.userModel;
//       // goodVc.contact = self.contact;
//        goodVc.outStyle = @"huangliao";
//
//        [self.navigationController pushViewController:goodVc animated:YES];
        
        
        RSDriverViewController *driverVc = [[RSDriverViewController alloc]init];
        
        driverVc.shopCarNumberArray = self.shopCarInformationArray;
        driverVc.userID = [UserManger getUserObject].userID;
        driverVc.userModel = [UserManger getUserObject];
        driverVc.outStyle = @"huangliao";
        
        [self.navigationController pushViewController:driverVc animated:YES];
         
         
         
         
    }else{
        [SVProgressHUD showErrorWithStatus:@"请选择商品"];
    }
    
}


static NSString *shopCarID = @"shopcar";

#pragma mark -- 显示选中的商品详细信息
- (void)showChoiceProduct:(UIButton *)btn{
   
    CGFloat Y = 0.0;
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
        detailTableview.frame = CGRectMake(0, SCH / 2 , SCW, (SCH/2) - 45);
        [self.view addSubview:detailTableview];
        
        //注册
        [self.detailTableview registerClass:[RSShopCarCell class] forCellReuseIdentifier:shopCarID];
        
        
        btn.tag = 1;

    }else{
        [_detailTableview removeFromSuperview];
        [_menuview removeFromSuperview];
        btn.tag = 0;
    }
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
}



- (void)removeMenuView{
    
    [_menuview removeFromSuperview];
    [_detailTableview removeFromSuperview];
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
