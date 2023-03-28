//
//  RSHaixiMerchantsViewController.m
//  石来石往
//
//  Created by mac on 2021/10/23.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSHaixiMerchantsViewController.h"
#import "RSHaixiMerchatsCell.h"
#import "RSHaixiSearchDetailViewController.h"
#import "RSADPictureModel.h"
#import "RSHistoryCell.h"

#import "RSHistoryViewController.h"

@interface RSHaixiMerchantsViewController ()<RSSearchContentViewDelegate>

@property (nonatomic,strong)RSSearchContentView * searchContentView;


@property (nonatomic,strong)RSADPictureModel * adPictureModel;


//@property (nonatomic,strong)NSMutableArray * historyArray;
@end

//static NSString * tableviewID = @"tableviewID";
@implementation RSHaixiMerchantsViewController


- (RSSearchContentView *)searchContentView{
    if (!_searchContentView) {
        _searchContentView = [[RSSearchContentView alloc]initWithFrame:CGRectMake(0, 0, SCW, Height_Real(161)) andPlaceholder:@"请输入你要查找的石材" andShowQRCode:false andShopBusiness:false andIsEdit:false];
        _searchContentView.delegate = self;
    }
    return _searchContentView;
}

//- (NSMutableArray *)historyArray{
//    if (_historyArray == nil) {
//        _historyArray = [NSMutableArray array];
//    }
//    return _historyArray;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMarkData];
    
    [self.view addSubview:self.searchContentView];
    self.searchContentView.searchTextView.text = @"";
    self.searchContentView.searchTextView.placeholder = @"请输入你要查找的石材";
    self.collectionview.frame = CGRectMake(0, self.searchContentView.yj_y + self.searchContentView.yj_height + Height_Real(5), SCW, SCH - self.searchContentView.yj_y - self.searchContentView.yj_height - Height_Real(16) - Height_TabBar);
    self.collectionview.contentInset = UIEdgeInsetsMake(0, 0, Height_Real(177), 0);
//    self.collectionview.
    [self.view addSubview:self.collectionview];
    [self.collectionview registerClass:[RSHaixiMerchatsCell class] forCellWithReuseIdentifier:@"HAIXI"];
   
    
    
//    self.tableview.frame = CGRectMake(0, self.searchContentView.yj_y + self.searchContentView.yj_height + Height_Real(5), SCW, SCH - self.searchContentView.yj_y - self.searchContentView.yj_height - Height_Real(16) - Height_TabBar);
//
//    self.tableview.hidden = YES;
//    [self.view addSubview:self.tableview];
//    [self.tableview registerClass:[RSHistoryCell class] forCellReuseIdentifier:tableviewID];
    //textFieldChange
}


- (void)loadMarkData{
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInt:4] forKey:@"size"];
    [phoneDict setObject:@"1" forKey:@"versioncode"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey] == nil ? @"" : [UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_MARKETSTOCK_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL result = [json[@"Result"] boolValue];
            if (result) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"][@"marketInfo"];
                RSADPictureModel * adPictureModel = [[RSADPictureModel alloc]init];
                for (int i = 0 ; i < array.count; i++) {
                    adPictureModel.blockTotalMessage = [[array objectAtIndex:i]objectForKey:@"blockTotalMessage"];
                    adPictureModel.erpId = [[array objectAtIndex:i]objectForKey:@"erpId"];
                    adPictureModel.erpName = [[array objectAtIndex:i]objectForKey:@"erpName"];
                    adPictureModel.plateTotalMessage = [[array objectAtIndex:i]objectForKey:@"plateTotalMessage"];
                    adPictureModel.stoneTypeNum = [[array objectAtIndex:i]objectForKey:@"stoneTypeNum"];
                    weakSelf.adPictureModel = adPictureModel;
                }
                [weakSelf.collectionview reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


//- (void)rowNowSearchTextFieldStr:(NSString *)searchStr{
//    if(![searchStr isEqualToString:@""]){
//        self.tableview.hidden = NO;
//        //实时搜索
//        [self realTimeSearch:searchStr];
//    }else{
//        self.tableview.hidden = YES;
//    }
//}
- (void)jumpNewController{
    [UserManger checkLogin:self successBlock:^{
        RSHistoryViewController * historyVc = [[RSHistoryViewController alloc]init];
//        historyVc.hidesBottomBarWhenPushed = YES;
        historyVc.userModel = [UserManger getUserObject];
        [self.navigationController pushViewController:historyVc animated:YES];
    }];
}



#pragma mark -- 实时搜索
//- (void)realTimeSearch:(NSString *)str{
//
//    //URL_REALTIMESEARCH URL_HEADER_ATTION_SEARCH_IOS
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSString stringWithFormat:@"%@",str] forKey:@"search_text"];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey] ==  nil ? @"" :[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    RSWeakself
////    CLog(@"-------------------------------%@",parameters);
//    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//    [network getDataWithUrlString:URL_HEADER_ATTION_SEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
////        CLog(@"----------------3232---------------------%@",json);
//        if (success) {
//            BOOL Result = [json[@"Result"] boolValue];
//            if (Result) {
//                [weakSelf.historyArray removeAllObjects];
//                weakSelf.historyArray = [RSHistorySearchModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
//             [weakSelf.tableview reloadData];
//            }
//         }
//    }];
//}


//- (void)addCustomTableviewConntroller{
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - Height_NavBar) style:UITableViewStyleGrouped];
//    tableview.backgroundColor = [UIColor whiteColor];
//    tableview.delegate = self;
//    tableview.dataSource = self;
//    self.tableview = tableview;
//    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:tableview];
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
//        self.tableview.estimatedRowHeight = 0.01;
//        self.tableview.estimatedSectionHeaderHeight = 0.01;
//        self.tableview.estimatedSectionFooterHeight = 0.01;
//    }
//    self.tableview.hidden = true;
//}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return Height_Real(44);
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.historyArray.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    RSHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:tableviewID];
//
//    RSHistorySearchModel * historySearchModel = self.historyArray[indexPath.row];
//    NSMutableAttributedString * attributedstring =  [RSNSStringColorTool compareSearchAndModelStr:self.searchContentView.searchTextView.text andModelStr:historySearchModel.mtlname];
//    cell.nameLabel.attributedText = attributedstring;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//}
//
//
//
////FIXME:UITableviewCell点击
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.searchContentView.searchTextView resignFirstResponder];
//    RSHistorySearchModel * historySearchModel  = self.historyArray[indexPath.row];
//    self.searchContentView.searchTextView.text = [NSString stringWithFormat:@"%@",historySearchModel.mtlname];
//    self.tableview.hidden = YES;
//
////    CLog(@"=============================%@",historySearchModel.stoneId);
//
//    RSHaixiSearchDetailViewController * haiXiSearchDetailVc = [[RSHaixiSearchDetailViewController alloc]init];
//    haiXiSearchDetailVc.title = historySearchModel.stoneId;
//    [self.navigationController pushViewController:haiXiSearchDetailVc animated:true];
//
//    //点击之后俩个界面的变化
////    RSSCOwnerDetailViewController * SCContentVc =(RSSCOwnerDetailViewController *)self.childViewControllers[self.preBtn.tag];
////    SCContentVc.stoneName = historySearchModel.stoneId;
////    [SCContentVc newStoneSearchPageSize:10 andIsHead:true andStoneName:SCContentVc.stoneName];
//}



#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RSHaixiMerchatsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HAIXI" forIndexPath:indexPath];
    NSArray * imageArray = @[@"Frame 10.png",@"Frame 11.png",@"Frame 12.png"];
    cell.haixiMerchatImage.image = [UIImage imageNamed:imageArray[indexPath.row]];
    NSArray * titleArray = @[@"荒料总库存量",@"大板总库存量",@"品种数总量"];
    cell.namelabel.text = titleArray[indexPath.row];
    
    
//    NSArray * numLabelArray = @[self.adPictureModel.blockTotalMessage,self.adPictureModel.plateTotalMessage,self.adPictureModel.stoneTypeNum];
    //这边要进行设置宽度
//    cell.numStr = numLabelArray[indexPath.row];
    if (indexPath.row == 0) {
//        CLog(@"================%@",self.adPictureModel.blockTotalMessage);
        cell.numStr = self.adPictureModel.blockTotalMessage;
    }else if (indexPath.row == 1){
        cell.numStr = self.adPictureModel.plateTotalMessage;
    }else{
        cell.numStr = self.adPictureModel.stoneTypeNum;
    }
    NSArray * companyArray = @[@"m³",@"m²",@"种"];
    cell.companyLabel.text = companyArray[indexPath.row];
    
    return cell;
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:true];
}

// 返回每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //CLog(@"-------------------%lf-------------%lf--------------%lf-------------%lf--------------%lf----------%lf",SCW,SCH,Height_Real(250),SCH/667,667/SCH,250/(667/SCH));
    return CGSizeMake(SCW, Height_Real(145));
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, Width_Real(16), 0, Width_Real(16));
}

//动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


//- (void)jumpNewController{
//    CLog(@"==============================");
//
//}




//搜索框搜索的内容
//- (void)searchTextViewWithContentStr:(NSString *)searchStr{
//    CLog(@"=============%@",searchStr);
//    if (searchStr.length > 0) {
//        RSHaixiSearchDetailViewController * haiXiSearchDetailVc = [[RSHaixiSearchDetailViewController alloc]init];
//        haiXiSearchDetailVc.title = searchStr;
//        [self.navigationController pushViewController:haiXiSearchDetailVc animated:true];
//    }
//}






@end
