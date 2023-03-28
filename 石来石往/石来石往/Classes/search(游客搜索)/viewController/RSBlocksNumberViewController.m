//
//  RSBlocksNumberViewController.m
//  石来石往
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSBlocksNumberViewController.h"
#import "RSNewSearchFirstCell.h"
#import "RSNewSearchThirdCell.h"
#import "RSNewSearchSecondCell.h"
#import "RSCompanyAndStoneModel.h"
#import "RSHuangDetailAndDaDetailViewController.h"
#import "RSDetailSegmentViewController.h"
#import "RSFriendDetailController.h"
#import "RSSearchNavigationButton.h"

@interface RSBlocksNumberViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
/**搜索框*/
@property (nonatomic,strong)UISearchBar * search;
/**显示更多的数据*/
@property (nonatomic,strong)UITableView * tableview;
/**数组*/
@property (nonatomic,strong)NSMutableArray * moreArray;
/**页数*/
@property (nonatomic,assign)NSInteger page_num;
@end

@implementation RSBlocksNumberViewController

- (NSMutableArray *)moreArray{
    if (_moreArray == nil) {
        _moreArray = [NSMutableArray array];
    }
    return _moreArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifykey andViewController:self];
    //self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.page_num = 2;
    [self addCustiomBlocksNumberNavigation];
    [self addCustomBlockSNumberTableview];
    [self loadMoreBlockNumberNewData];
}



- (void)addCustiomBlocksNumberNavigation{
//    UIView * searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW * 0.75, 30)];
//    searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    searchView.layer.cornerRadius = 5;
//    searchView.layer.masksToBounds = YES;
//    self.navigationItem.titleView = searchView;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW - 40, 30)];
    view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = view;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    UISearchBar * search = [[UISearchBar alloc]init];
    search.tintColor = [UIColor colorWithHexColorStr:@"#3385ff"];      //设置光标颜色为橘色
    //search.barTintColor = [UIColor whiteColor];
    for (UIView *subView in search.subviews) {
        if ([subView isKindOfClass:[UIView  class]]) {
            [[subView.subviews objectAtIndex:0] removeFromSuperview];
        }
    }
    search.backgroundColor = [UIColor clearColor];
    search.delegate = self;
    search.text = self.searchStr;
    _search = search;
    [view addSubview:search];
    
    search.sd_layout
    .leftSpaceToView(view, 0)
    .topSpaceToView(view, 0)
    .bottomSpaceToView(view, 0)
    .rightSpaceToView(view, 0);
    search.layer.cornerRadius = 5;
    search.layer.masksToBounds = YES;
}

- (void)loadMoreBlockNumberNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"20"] forKey:@"item_num"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [phoneDict setObject:applegate.ERPID forKey:@"erpId"];
    [phoneDict setObject:self.searchStr forKey:@"text"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.searchType] forKey:@"searchType"];
    [phoneDict setObject:self.classifyStr forKey:@"type"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_TRANSITION_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [weakSelf.moreArray removeAllObjects];
//                NSMutableArray * array = [NSMutableArray array];
//                array = json[@"Data"];
                weakSelf.moreArray = [RSCompanyAndStoneModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
//                if (array.count > 0) {
//                    for (int j = 0 ; j < array.count; j++) {
//                        RSCompanyAndStoneModel * companyAndStoneModel = [[RSCompanyAndStoneModel alloc]init];
//                        companyAndStoneModel.blockId = [[array objectAtIndex:j]objectForKey:@"blockId"];
//                        companyAndStoneModel.content = [[array objectAtIndex:j]objectForKey:@"content"];
//                        companyAndStoneModel.createTime = [[array objectAtIndex:j]objectForKey:@"createTime"];
//                        companyAndStoneModel.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
//                        companyAndStoneModel.imgUrl = [[array objectAtIndex:j]objectForKey:@"imgUrl"];
//                        companyAndStoneModel.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
//                        companyAndStoneModel.qty = [[array objectAtIndex:j]objectForKey:@"qty"];
//                        companyAndStoneModel.stockType = [[array objectAtIndex:j]objectForKey:@"stockType"];
//                        companyAndStoneModel.stoneId = [[array objectAtIndex:j]objectForKey:@"stoneId"];
//                        companyAndStoneModel.turnsQty = [[array objectAtIndex:j]objectForKey:@"turnsQty"];
//                        companyAndStoneModel.type = [[array objectAtIndex:j]objectForKey:@"type"];
//                        companyAndStoneModel.vaqty = [[array objectAtIndex:j]objectForKey:@"vaqty"];
//                        companyAndStoneModel.companyName = [[array objectAtIndex:j]objectForKey:@"companyName"];
//                        companyAndStoneModel.phone = [[array objectAtIndex:j]objectForKey:@"phone"];
//                        companyAndStoneModel.weight = [[array objectAtIndex:j]objectForKey:@"weight"];
//                        [weakSelf.moreArray addObject:companyAndStoneModel];
//                    }
//                }
                self.page_num = 2;
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview reloadData];
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }
    }];
}

- (void) loadMoreBlockNumberMoreNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    
    [phoneDict setObject:[NSNumber numberWithInteger:self.page_num] forKey:@"page_num"];
    [phoneDict setObject:[NSString stringWithFormat:@"20"] forKey:@"item_num"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [phoneDict setObject:applegate.ERPID forKey:@"erpId"];
    
    [phoneDict setObject:self.searchStr forKey:@"text"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.searchType] forKey:@"searchType"];
    [phoneDict setObject:self.classifyStr forKey:@"type"];
    
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_TRANSITION_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
               // NSMutableArray *array = [NSMutableArray array];
                NSMutableArray *tempArray = [NSMutableArray array];
                //array = json[@"Data"];
                
                tempArray = [RSCompanyAndStoneModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                
//                if (array.count > 0) {
//                    for (int j = 0; j < array.count; j++) {
//                        RSCompanyAndStoneModel * companyAndStoneModel = [[RSCompanyAndStoneModel alloc]init];
//                        companyAndStoneModel.blockId = [[array objectAtIndex:j]objectForKey:@"blockId"];
//                        companyAndStoneModel.content = [[array objectAtIndex:j]objectForKey:@"content"];
//                        companyAndStoneModel.createTime = [[array objectAtIndex:j]objectForKey:@"createTime"];
//                        companyAndStoneModel.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
//                        companyAndStoneModel.imgUrl = [[array objectAtIndex:j]objectForKey:@"imgUrl"];
//                        companyAndStoneModel.friendId = [[array objectAtIndex:j]objectForKey:@"friendId"];
//                        companyAndStoneModel.qty = [[array objectAtIndex:j]objectForKey:@"qty"];
//                        companyAndStoneModel.stockType = [[array objectAtIndex:j]objectForKey:@"stockType"];
//                        companyAndStoneModel.stoneId = [[array objectAtIndex:j]objectForKey:@"stoneId"];
//                        companyAndStoneModel.turnsQty = [[array objectAtIndex:j]objectForKey:@"turnsQty"];
//                        companyAndStoneModel.type = [[array objectAtIndex:j]objectForKey:@"type"];
//                        companyAndStoneModel.vaqty = [[array objectAtIndex:j]objectForKey:@"vaqty"];
//                        companyAndStoneModel.companyName = [[array objectAtIndex:j]objectForKey:@"companyName"];
//                        companyAndStoneModel.phone = [[array objectAtIndex:j]objectForKey:@"phone"];
//                        companyAndStoneModel.weight = [[array objectAtIndex:j]objectForKey:@"weight"];
//                        [tempArray addObject:companyAndStoneModel];
//                    }
                    [weakSelf.moreArray addObjectsFromArray:tempArray];
                    weakSelf.page_num++;
                    [weakSelf.tableview.mj_footer endRefreshing];
                    [weakSelf.tableview reloadData];
//                }else{
//
//                  [weakSelf.tableview.mj_footer endRefreshing];
//                }
            }else{
              [weakSelf.tableview.mj_footer endRefreshing];
            }
        }
    }];
}

- (void)addCustomBlockSNumberTableview{
    CGFloat Y = 0.0;
    CGFloat bttom = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
        bttom = 34;
    }else{
        bttom = 0.0;
        Y = 64;
    }
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Y, SCW, SCH - Y - bttom) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.delegate = self;
    tableview.dataSource = self;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11) {
        self.tableview.estimatedRowHeight = 0;
        self.tableview.estimatedSectionHeaderHeight = 0;
        self.tableview.estimatedSectionFooterHeight = 0;
    }
    self.tableview = tableview;
    [self.view addSubview:self.tableview];
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadMoreBlockNumberNewData];
    }];
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreBlockNumberMoreNewData];
    }];
    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
        [weakSelf loadMoreBlockNumberNewData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.moreArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchType == 2) {
        static NSString * DETAILBLOCKSNUMBERID = @"detailblocksnumberid";
        RSNewSearchFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:DETAILBLOCKSNUMBERID];
        if (!cell) {
            cell = [[RSNewSearchFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DETAILBLOCKSNUMBERID];
        }
        RSCompanyAndStoneModel * companyAndStonemodel = self.moreArray[indexPath.row];
        cell.companyAndStonemodel = companyAndStonemodel;
        NSMutableAttributedString * attributedstring =  [RSNSStringColorTool compareSearchAndModelStr:self.searchStr andModelStr:companyAndStonemodel.blockId];
        cell.fristHuangliaoLabel.attributedText = attributedstring;
        return cell;
    }else if (self.searchType == 1){
        //第二种为名称的Cell
        static NSString * NEWSEARCHTHIRSTID = @"newsearchthirdid";
        RSNewSearchThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWSEARCHTHIRSTID];
        if (!cell) {
            cell = [[RSNewSearchThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWSEARCHTHIRSTID];
            
        }
        RSCompanyAndStoneModel * companyAndStonemodel = self.moreArray[indexPath.row];
        cell.companyAndStonemodel = companyAndStonemodel;
        NSMutableAttributedString * attributedstring =  [RSNSStringColorTool compareSearchAndModelStr:self.searchStr andModelStr:companyAndStonemodel.stoneId];
        cell.fristHuangliaoLabel.attributedText = attributedstring;
        return cell;
    }else{
        static NSString * NEWSEARCHSECONDID = @"newsearchsearchdid";
        RSNewSearchSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWSEARCHSECONDID];
        if (!cell) {
            cell = [[RSNewSearchSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWSEARCHSECONDID];
        }
        RSCompanyAndStoneModel * companyAndStonemodel = self.moreArray[indexPath.row];
        cell.companyAndStonemodel = companyAndStonemodel;
        NSString  * str =  [self delSpaceAndNewline:companyAndStonemodel.content];
        NSMutableAttributedString * attributedstring =  [RSNSStringColorTool compareSearchAndModelStr:self.searchStr andModelStr:str];
        cell.textview.attributedText = attributedstring;
        return cell;
    }
}

- (NSString *)delSpaceAndNewline:(NSString *)string;{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchType == 1) {
        RSCompanyAndStoneModel * companyAndStonemodel = self.moreArray[indexPath.row];
        RSHuangDetailAndDaDetailViewController * huangDeatilAndDatailVc = [[RSHuangDetailAndDaDetailViewController alloc]init];
        huangDeatilAndDatailVc.userModel = self.userModel;
        huangDeatilAndDatailVc.searchType = companyAndStonemodel.stockType;
        huangDeatilAndDatailVc.searchStr = companyAndStonemodel.stoneId;
        [self.navigationController pushViewController:huangDeatilAndDatailVc animated:YES];
    }else if (self.searchType == 2){
        RSCompanyAndStoneModel * companyAndStonemodel = self.moreArray[indexPath.row];
        RSDetailSegmentViewController * detailVc = [[RSDetailSegmentViewController alloc]init];
        //detailVc.companyAndStoneModel = companyAndStonemodel;
        detailVc.tempStr1 =@"-1";
        detailVc.tempStr2 = @"-1";
        detailVc.tempStr3 = @"-1";
        detailVc.tempStr4 = @"-1";
        detailVc.btnStr1 = @"-1";
        detailVc.btnStr2 = @"-1";
        detailVc.btnStr3 = @"-1";
        detailVc.btnStr4 = @"-1";
        detailVc.imageUrl = companyAndStonemodel.imgUrl;
        detailVc.shitouName = companyAndStonemodel.stoneId;
        //数量
        detailVc.keAndZaStr = companyAndStonemodel.turnsQty;
        detailVc.piAndFangStr = companyAndStonemodel.vaqty;
        detailVc.title = companyAndStonemodel.stoneId;
        detailVc.phone = companyAndStonemodel.phone;
        detailVc.weight = companyAndStonemodel.weight;
        detailVc.stoneName = companyAndStonemodel.stoneId;
        detailVc.companyName = companyAndStonemodel.companyName;
        detailVc.searchType = companyAndStonemodel.stockType;
        detailVc.titleStr = companyAndStonemodel.blockId;
        detailVc.userModel = self.userModel;
        detailVc.erpCode = companyAndStonemodel.erpCode;
        [self.navigationController pushViewController:detailVc animated:YES];
    }else{
        RSCompanyAndStoneModel * companyAndStonemodel = self.moreArray[indexPath.row];
        RSFriendDetailController * freindDeatilVc = [[RSFriendDetailController alloc]init];
        freindDeatilVc.friendID = companyAndStonemodel.friendId;
        freindDeatilVc.titleStyle = @"";
        freindDeatilVc.selectStr = @"";
        freindDeatilVc.title =companyAndStonemodel.companyName;
        freindDeatilVc.userModel = self.userModel;
        [self.navigationController pushViewController:freindDeatilVc animated:YES];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchStr = searchBar.text;
    [self loadMoreBlockNumberNewData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.3 animations:^{
        //        self.navigationController.navigationBarHidden = YES;
        //        _searchBar.frame = CGRectMake(0, 20, kScreenWidth, 44);
        searchBar.showsCancelButton = YES;
        
        for (id obj in [searchBar subviews]) {
            if ([obj isKindOfClass:[UIView class]]) {
                for (id obj2 in [obj subviews]) {
                    if ([obj2 isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)obj2;
                        [btn setTitle:@"取消" forState:UIControlStateNormal];
                        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }
                }
            }
        }
    }];
}

#pragma mark -- 点击取消按键
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
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
