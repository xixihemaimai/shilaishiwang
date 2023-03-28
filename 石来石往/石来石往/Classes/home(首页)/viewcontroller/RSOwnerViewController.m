//
//  RSOwnerViewController.m
//  石来石往
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSOwnerViewController.h"
#import "RSOwerModel.h"
#import "RSMyRingViewController.h"
#import "RSCargoCenterBusinessViewController.h"

@interface RSOwnerViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *indexs;         //索引数组
    NSMutableArray *_titleArray;
    UILabel * _label;
}
@property (nonatomic,strong)UITableView * tableview;
@property (nonatomic,strong)UISearchBar * search;
@end

@implementation RSOwnerViewController
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}



static NSString * OWNERCELL = @"OWNERCELLID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"货主";
    if (@available(iOS 11.0, *)) {
      self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
      self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableview];
    _titleArray = [NSMutableArray array];
    indexs = [NSMutableArray array];
    NSString * str = [NSString string];
    str = @"";
    [self loadHzName:str];
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
    UISearchBar * search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCW, 45)];
    _search = search;
    search.delegate = self;
    search.placeholder = @"搜索";
    [self.view addSubview:search];
//    [self addCustomTableview];
    UILabel * label = [[UILabel alloc]init];
    [label bringSubviewToFront:self.view];
    label.backgroundColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.hidden = YES;
    [self.view addSubview:label];
    _label = label;
    _label.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .widthIs(50)
    .heightIs(50);
    
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(search.frame), SCW, SCH - CGRectGetMaxY(search.frame));
}

- (void)loadHzName:(NSString *)searchStr{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifkey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:searchStr forKey:@"search_text"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifkey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HZSEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
//            CLog(@"---------------------------------%@",json);
            if (Result) {
                [indexs removeAllObjects];
                [_titleArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                NSMutableArray * temp = [NSMutableArray array];
//                NSMutableArray * temPA = [NSMutableArray array];
//                NSMutableArray * temPB = [NSMutableArray array];
//                NSMutableArray * temPC = [NSMutableArray array];
//                NSMutableArray * temPD = [NSMutableArray array];
//                NSMutableArray * temPE = [NSMutableArray array];
//                NSMutableArray * temPF = [NSMutableArray array];
//                NSMutableArray * temPG = [NSMutableArray array];
//                NSMutableArray * temPH = [NSMutableArray array];
//                NSMutableArray * temPI = [NSMutableArray array];
//                NSMutableArray * temPJ = [NSMutableArray array];
//                NSMutableArray * temPK = [NSMutableArray array];
//                NSMutableArray * temPL = [NSMutableArray array];
//                NSMutableArray * temPM = [NSMutableArray array];
//                NSMutableArray * temPN = [NSMutableArray array];
//                NSMutableArray * temPO = [NSMutableArray array];
//                NSMutableArray * temPP = [NSMutableArray array];
//                NSMutableArray * temPQ = [NSMutableArray array];
//                NSMutableArray * temPR = [NSMutableArray array];
//                NSMutableArray * temPS = [NSMutableArray array];
//                NSMutableArray * temPT = [NSMutableArray array];
//                NSMutableArray * temPU = [NSMutableArray array];
//                NSMutableArray * temPV = [NSMutableArray array];
//                NSMutableArray * temPW = [NSMutableArray array];
//                NSMutableArray * temPX = [NSMutableArray array];
//                NSMutableArray * temPY = [NSMutableArray array];
//                NSMutableArray * temPZ = [NSMutableArray array];
//                NSMutableArray * temP$ = [NSMutableArray array];
                for (int j = 0; j < array.count;j++) {
//                    NSMutableArray * temP = [NSMutableArray array];
                    RSOwerModel * owerModel = [[RSOwerModel alloc]init];
                    owerModel.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                    owerModel.letter =  [[array objectAtIndex:j]objectForKey:@"letter"];
                    owerModel.userName = [[array objectAtIndex:j]objectForKey:@"userName"];
                    NSString * Letter = owerModel.letter;
                    [temp addObject:owerModel];
                    if (![indexs containsObject:Letter]) {
                        [indexs addObject:Letter];
                    }
//                    if ([Letter isEqualToString:@"A"]) {
//                        [temPA addObject:owerModel];
//                    }else if ([Letter isEqualToString:@"B"]) {
//                        [temPB addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"C"]) {
//                        [temPC addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"D"]) {
//                        [temPD addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"E"]) {
//                        [temPE addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"F"]) {
//                        [temPF addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"G"]) {
//                        [temPG addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"H"]) {
//                        [temPH addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"I"]) {
//                        [temPI addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"J"]) {
//                        [temPJ addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"K"]) {
//                        [temPK addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"L"]) {
//                        [temPL addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"M"]) {
//                        [temPM addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"N"]) {
//                        [temPN addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"O"]) {
//                        [temPO addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"P"]) {
//                        [temPP addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"Q"]) {
//                        [temPQ addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"R"]) {
//                        [temPR addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"S"]) {
//                        [temPS addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"T"]) {
//                        [temPT addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"U"]) {
//                        [temPU addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"V"]) {
//                        [temPV addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"W"]) {
//                        [temPW addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"X"]) {
//                        [temPX addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"Y"]) {
//                        [temPY addObject:owerModel];
//                    }
//                    else if ([Letter isEqualToString:@"Z"]) {
//                        [temPZ addObject:owerModel];
//                    }
//                    else {
//                        [temP$ addObject:owerModel];
//                    }
                }
                
                
                //这边要进行区分添加到总的数组和标识数组
                //对相同的数组的标识进行区分
               NSMutableArray * setArray = [NSMutableArray arrayWithArray:temp];
//                NSMutableArray *dateMutablearray = [@[] mutableCopy];
                for (int i = 0; i < setArray.count; i ++) {
                    RSOwerModel * owerModel = setArray[i];
                        NSMutableArray * tempArray = [@[] mutableCopy];
                        [tempArray addObject:owerModel];
                        for (int j = i+1; j < setArray.count; j ++) {
                            RSOwerModel * owerModel1 = setArray[j];
                            if([owerModel.letter isEqualToString:owerModel1.letter]){
                                [tempArray addObject:owerModel1];
                                [setArray removeObjectAtIndex:j];
                                j -= 1;
                            }
                        }
//                        [dateMutablearray addObject:tempArray];
                    [_titleArray addObject:tempArray];
                }
                
                
                
//                if (temPA.count > 0) {
//                    [indexs addObject:@"A"];
//                    [_titleArray addObject:temPA];
//                }
//                if (temPB.count > 0) {
//                    [indexs addObject:@"B"];
//                    [_titleArray addObject:temPB];
//                }
//                if (temPC.count > 0) {
//                    [indexs addObject:@"C"];
//                    [_titleArray addObject:temPC];
//                }
//                if (temPD.count > 0) {
//                    [indexs addObject:@"D"];
//                    [_titleArray addObject:temPD];
//                }
//                if (temPE.count > 0) {
//                    [indexs addObject:@"E"];
//                    [_titleArray addObject:temPE];
//                }
//                if (temPF.count > 0) {
//                    [indexs addObject:@"F"];
//                    [_titleArray addObject:temPF];
//                }
//                if (temPG.count > 0) {
//                    [indexs addObject:@"G"];
//                    [_titleArray addObject:temPG];
//                }
//                if (temPH.count > 0) {
//                    [indexs addObject:@"H"];
//                    [_titleArray addObject:temPH];
//                }
//                if (temPI.count > 0) {
//                    [indexs addObject:@"I"];
//                    [_titleArray addObject:temPI];
//                }
//                if (temPJ.count > 0) {
//                    [indexs addObject:@"J"];
//                    [_titleArray addObject:temPJ];
//                }
//                if (temPK.count > 0) {
//                    [indexs addObject:@"K"];
//                    [_titleArray addObject:temPK];
//                }
//                if (temPL.count > 0) {
//                    [indexs addObject:@"L"];
//                    [_titleArray addObject:temPL];
//                }
//                if (temPM.count > 0) {
//                    [indexs addObject:@"M"];
//                    [_titleArray addObject:temPM];
//                }
//                if (temPN.count > 0) {
//                    [indexs addObject:@"N"];
//                    [_titleArray addObject:temPN];
//                }
//                if (temPO.count > 0) {
//                    [indexs addObject:@"O"];
//                    [_titleArray addObject:temPO];
//                }if (temPP.count > 0) {
//                    [indexs addObject:@"P"];
//                    [_titleArray addObject:temPP];
//                }if (temPQ.count > 0) {
//                    [indexs addObject:@"Q"];
//                    [_titleArray addObject:temPQ];
//                }if (temPR.count > 0) {
//                    [indexs addObject:@"R"];
//                    [_titleArray addObject:temPR];
//                }
//                if (temPS.count > 0) {
//                    [indexs addObject:@"S"];
//                    [_titleArray addObject:temPS];
//                }
//                if (temPT.count > 0) {
//                    [indexs addObject:@"T"];
//                    [_titleArray addObject:temPT];
//                }if (temPU.count > 0) {
//                    [indexs addObject:@"U"];
//                    [_titleArray addObject:temPU];
//                }if (temPV.count > 0) {
//                    [indexs addObject:@"V"];
//                    [_titleArray addObject:temPV];
//                }if (temPW.count > 0) {
//                    [indexs addObject:@"W"];
//                    [_titleArray addObject:temPW];
//                }if (temPX.count > 0) {
//                    [indexs addObject:@"X"];
//                    [_titleArray addObject:temPX];
//                }if (temPY.count > 0) {
//                    [indexs addObject:@"Y"];
//                    [_titleArray addObject:temPY];
//                }if (temPZ.count > 0) {
//                    [indexs addObject:@"Z"];
//                    [_titleArray addObject:temPZ];
//                }
//                if (temP$.count > 0) {
//                    [indexs addObject:@"#"];
//                    [_titleArray addObject:temP$];
//                }
                [self.tableview reloadData];
            }
        }
    }];
}

//- (void)addCustomTableview{
//    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_search.frame), SCW, SCH - CGRectGetMaxY(_search.frame)) style:UITableViewStylePlain];
//    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
//    self.tableview.showsVerticalScrollIndicator = NO;
//    self.tableview.sectionIndexColor = [UIColor blueColor];
//    self.tableview.sectionIndexTrackingBackgroundColor = [UIColor grayColor];
//    self.tableview.sectionIndexBackgroundColor = [UIColor clearColor];
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    [self.view addSubview:self.tableview];
//}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self loadHzName:searchBar.text];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.3 animations:^{
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
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
    UIButton *cancelBtn = [searchBar valueForKeyPath:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES;
    [self loadHzName:searchBar.text];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:OWNERCELL];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:OWNERCELL];
    }
    NSMutableArray * array = _titleArray[indexPath.section];
    RSOwerModel * owermodel = array[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",owermodel.userName];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray * array = _titleArray[section];
    return array.count;
}

//返回索引数组
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return indexs;
}

//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    _label.text = title;
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = [UIColor whiteColor];
    _label.hidden = NO;
    [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:0.3];
    NSInteger count = 0;
    [_search resignFirstResponder];
    for (NSString *character in indexs) {
        if ([[character uppercaseString] hasPrefix:title]) {
            return count;
        }
        count++;
    }
    return  0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *  array = _titleArray[indexPath.section];
    RSOwerModel * owermodel = array[indexPath.row];
        //self.hidesBottomBarWhenPushed = YES;
    RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:[UserManger getUserObject] andErpCodeStr:owermodel.erpCode andCreat_userIDStr:@"-1" andUserIDStr:@"-1"];
     cargoCenterVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cargoCenterVc animated:YES];
}
//返回每个索引的内容
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [indexs objectAtIndex:section];
}

//返回section的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [indexs count];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    NSString * title =  indexs[section];
    _label.hidden = NO;
    _label.text = title;
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = [UIColor whiteColor];
    [self performSelector:@selector(hiddenLabel) withObject:nil afterDelay:0.2];
}

- (void)hiddenLabel{
    _label.hidden = YES;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
   _label.hidden = YES;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_search resignFirstResponder];
    return indexPath;
}
// 滑动的时候 searchBar 回收键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_search resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
