//
//  RSTaoBaoFisrtSearchViewController.m
//  石来石往
//
//  Created by mac on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoFisrtSearchViewController.h"
#import "RSSelectCollectionReusableView.h"
#import "RSSelectCollectionLayout.h"
#import "RSSearchCollectionViewCell.h"
#import "RSDBHandle.h"
#import "RSSearchSecondModel.h"
#import "RSSearchSectionModel.h"


//进店
#import "RSTaoBaoShopViewController.h"

#import "RSTaoBaoProductDetailsViewController.h"


#import "RSTaoBaoActivityCell.h"

@interface RSTaoBaoFisrtSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SelectCollectionCellDelegate,UICollectionReusableViewButtonDelegate,UITableViewDelegate,UITableViewDataSource>


/**存储网络请求的热搜，与本地缓存的历史搜索model数组*/
@property (nonatomic,strong)NSMutableArray * sectionArray;

/**搜索的数组字典*/
@property (nonatomic,strong)NSMutableArray * searchArray;

@property (nonatomic,strong)NSMutableArray * contentArray;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSString * searchStr;

@end

@implementation RSTaoBaoFisrtSearchViewController
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
        _tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}



- (NSMutableArray *)sectionArray{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

- (NSMutableArray *)searchArray{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fairReload) name:@"fairReload" object:nil];
}



static NSString *const rsSearchCollectionViewCell = @"rsTAPBAOSearchCollectionViewCell";

static NSString *const headerViewIden = @"TAOBAOHeadViewIden";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.pageNum = 2;
    _searchStr = @"";
    //搜索的界面
    
    [self addCustomRSSearchCollectionView];
    [self prepareData];
    self.tableview.hidden = YES;
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
}


- (void)reloadInTextContent:(NSString *)searchText{
//    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
//        //[self.rsSearchTextField resignFirstResponder];
//        return NO;
//    }
    
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    if ([searchText length] > 0) {
        if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:searchText forKey:@"content_name"]]) {
            self.tableview.hidden = YES;
            self.rsSearchCollectionView.hidden = YES;
        }
        self.tableview.hidden = NO;
        self.rsSearchCollectionView.hidden = YES;
        [self reloadData:searchText];
        
    }else{
        self.tableview.hidden = YES;
        self.rsSearchCollectionView.hidden = NO;
    }
}

- (void)reloadData:(NSString *)textString
{
    [self.searchArray addObject:[NSDictionary dictionaryWithObject:textString forKey:@"content_name"]];
    
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":self.searchArray};
    
    /***由于数据量并不大 这样每次存入再删除没问题  存数据库*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    [RSDBHandle saveStatuses:searchDict andParam:parmDict];
    
    RSSearchSectionModel *model = [[RSSearchSectionModel alloc]initWithDictionary:searchDict];
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
    }
    [self.sectionArray addObject:model];
    [self.rsSearchCollectionView reloadData];
    //self.rsSearchTextField.text = @"";
}


- (void)prepareData
{
    /**
     *  测试数据 ，字段暂时 只用一个 titleString，后续可以根据需求 相应加入新的字段
     */
    //,@{@"content_name":@"口红"},@{@"content_name":@"眼霜"},@{@"content_name":@"洗面奶"},@{@"content_name":@"防晒霜"},@{@"content_name":@"补水"},@{@"content_name":@"香水"},@{@"content_name":@"眉笔"}
    NSDictionary *testDict = @{@"section_id":@"1",@"section_title":@"热搜",@"section_content":@[@{@"content_name":@"奥特曼"},@{@"content_name":@"白玉兰"}]};
    NSMutableArray *testArray = [@[] mutableCopy];
    [testArray addObject:testDict];
    
    /***  去数据查看 是否有数据*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    NSDictionary *dbDictionary =  [RSDBHandle statusesWithParams:parmDict];
    
    if (dbDictionary.count) {
        [testArray addObject:dbDictionary];
        [self.searchArray addObjectsFromArray:dbDictionary[@"section_content"]];
    }
    
    for (NSDictionary *sectionDict in testArray) {
        RSSearchSectionModel *model = [[RSSearchSectionModel alloc]initWithDictionary:sectionDict];
        [self.sectionArray addObject:model];
    }
}






- (void)addCustomRSSearchCollectionView{
    self.rsSearchCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH) collectionViewLayout:[[RSSelectCollectionLayout alloc]init]];
    self.rsSearchCollectionView.backgroundColor = [UIColor whiteColor];
    self.rsSearchCollectionView.delegate= self;
    self.rsSearchCollectionView.dataSource = self;
    [self.rsSearchCollectionView registerClass:[RSSelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIden];
    [self.rsSearchCollectionView registerClass:[RSSearchCollectionViewCell class] forCellWithReuseIdentifier:rsSearchCollectionViewCell];
    
    [self.view addSubview:self.rsSearchCollectionView];
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    RSSearchSectionModel * sectionModel =  self.sectionArray[section];
    
    return sectionModel.section_contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RSSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:rsSearchCollectionViewCell forIndexPath:indexPath];
    RSSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    RSSearchSecondModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    [cell.contentButton setTitle:contentModel.content_name forState:UIControlStateNormal];
    cell.selectDelegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        RSSelectCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIden forIndexPath:indexPath];
        view.delectDelegate = self;
        RSSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        [view setText:sectionModel.section_title];
        /***  此处完全 也可以自定义自己想要的模型对应放入*/
        if(indexPath.section == 0)
        {
            [view setImage:@"cxCool"];
            view.delectButton.hidden = YES;
        }else{
            [view setImage:@"cxSearch"];
            view.delectButton.hidden = NO;
        }
        reusableview = view;
    }
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RSSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    if (sectionModel.section_contentArray.count > 0) {
        RSSearchSecondModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        return [RSSearchCollectionViewCell getSizeWithText:contentModel.content_name];
    }
    return CGSizeMake(80, 24);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


#pragma mark - SelectCollectionCellDelegate点击搜索过的
- (void)selectButttonClick:(RSSearchCollectionViewCell *)cell;
{
    
    NSIndexPath* indexPath = [self.rsSearchCollectionView indexPathForCell:cell];
    RSSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    RSSearchSecondModel * contentModel = sectionModel.section_contentArray[indexPath.row];
    // [self jumpSegmentViewController:contentModel.content_name];
    
    //self.rsSearchTextField.text  = [NSString stringWithFormat:@"%@",contentModel.content_name];
    // self.rsSearchCollectionView.hidden = YES;
    // self.contentScrollview.hidden = NO;
    //self.titleview.hidden = NO;
    
    self.rsSearchCollectionView.hidden = YES;
    self.tableview.hidden = NO;
    
    if ([self.delegate respondsToSelector:@selector(selectItemSearchContent:)]) {
        [self.delegate selectItemSearchContent:contentModel.content_name];
    }
    
    
    
    [self reloadShopInformationNewData:contentModel.content_name];
    
    
    
    //[self reloadChildViewController];
    
    //    RSSearchHuangAndDabanViewController * searchHuangAndDabanVc = [[RSSearchHuangAndDabanViewController alloc]init];
    //    searchHuangAndDabanVc.usermodel = self.userModel;
    //    searchHuangAndDabanVc.searchStr = self.rsSearchTextField.text;
    //    searchHuangAndDabanVc.title = self.rsSearchTextField.text;
    //    [self.navigationController pushViewController:searchHuangAndDabanVc animated:YES];
    
}


#pragma mark -- 长按需要做的事情
- (void)longSelectButttonClick:(UILongPressGestureRecognizer *)longPress{
    CGPoint location = [longPress locationInView:self.rsSearchCollectionView];
    NSIndexPath * indexpath = [self.rsSearchCollectionView indexPathForItemAtPoint:location];
    if (indexpath.section == 0) return;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你要对这个值进行删除吗" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    UIAlertAction * actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这边是要你删除的东西
        RSSearchSectionModel *sectionModel =  weakSelf.sectionArray[indexpath.section];
        RSSearchSecondModel *contentModel = sectionModel.section_contentArray[indexpath.row];
        for (int j=0; j<weakSelf.searchArray.count; j++) {
            
            if ([weakSelf.searchArray[j][@"content_name"] isEqualToString:contentModel.content_name]) {
                [weakSelf.searchArray removeObjectAtIndex:j];
                
            }
        }
        sectionModel.section_contentArray = [NSMutableArray arrayWithArray:self.searchArray];
        [weakSelf.rsSearchCollectionView reloadData];
        [weakSelf deleteSearchModelName:self.searchArray];
    }];
    [alert addAction:actionConfirm];
    UIAlertAction * cancelConfirm = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelConfirm];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
           
           alert.modalPresentationStyle = UIModalPresentationFullScreen;
       }
    [weakSelf presentViewController:alert animated:YES completion:nil];
   
}



#pragma mark -- 删除没有collectviewCell的东西
- (void)deleteSearchModelName:(NSArray *)array{
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":array};
    NSDictionary *parmDict  = @{@"category":@"1"};
    [RSDBHandle saveStatuses:searchDict andParam:parmDict];
    
    
    RSSearchSectionModel *model = [[RSSearchSectionModel alloc]initWithDictionary:searchDict];
    
    
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
        
    }
    [self.sectionArray addObject:model];
    [self.rsSearchCollectionView reloadData];
}




#pragma mark - UICollectionReusableViewButtonDelegate
- (void)delectData:(RSSelectCollectionReusableView *)view;
{
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
        [self.searchArray removeAllObjects];
        [self.rsSearchCollectionView reloadData];
        [RSDBHandle saveStatuses:@{} andParam:@{@"category":@"1"}];
    }
}






//获取店铺的数据
- (void)reloadShopInformationNewData:(NSString *)stoneName{
    if ([stoneName length] > 0) {
        _searchStr = stoneName;
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
        if ([verifykey length] < 1) {
               verifykey = @"";
           }
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        [phoneDict setObject:@"" forKey:@"stockType"];
        if ([stoneName isEqualToString:@""]) {
            [phoneDict setObject:@"" forKey:@"stoneName"];
        }else{
            [phoneDict setObject:stoneName forKey:@"stoneName"];
        }
        [phoneDict setObject:@"" forKey:@"orderField"];
        
        [phoneDict setObject:@"" forKey:@"orderMode"];
        
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"tsUserId"];
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"length"];
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"width"];
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"height"];
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"volume"];
        
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"area"];
        
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"widthType"];
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"heightType"];
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"volumeType"];
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
//                    NSMutableArray * array = [NSMutableArray array];
                    [weakSelf.contentArray removeAllObjects];
//                    array = json[@"data"][@"list"];
                    weakSelf.contentArray = [RSTaoBaoUserLikeModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    for (RSTaoBaoUserLikeModel * taobaoUserLikeModel in weakSelf.contentArray) {
                        taobaoUserLikeModel.imageList = [RSTaobaoVideoAndPictureModel mj_objectArrayWithKeyValuesArray:taobaoUserLikeModel.imageList];
                    }
//                    for (int i = 0; i < array.count; i++) {
//                        RSTaoBaoUserLikeModel * taobaoUserLikemodel = [[RSTaoBaoUserLikeModel alloc]init];
//                        taobaoUserLikemodel.actId = [[[array objectAtIndex:i]objectForKey:@"actId"]integerValue];
//                        taobaoUserLikemodel.collectionId =[[[array objectAtIndex:i]objectForKey:@"collectionId"]integerValue];
//                        taobaoUserLikemodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
//                        taobaoUserLikemodel.userLikeID = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
//                        taobaoUserLikemodel.identityId = [[array objectAtIndex:i]objectForKey:@"identityId"];
//                        taobaoUserLikemodel.inventory = [[array objectAtIndex:i]objectForKey:@"inventory"];
//                        taobaoUserLikemodel.isComplete = [[[array objectAtIndex:i]objectForKey:@"isComplete"]integerValue];
//                        taobaoUserLikemodel.originalPrice = [[array objectAtIndex:i]objectForKey:@"originalPrice"];
//                        taobaoUserLikemodel.price = [[array objectAtIndex:i]objectForKey:@"price"];
//                        taobaoUserLikemodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"]integerValue];
//                        taobaoUserLikemodel.shopName = [[array objectAtIndex:i]objectForKey:@"shopName"];
//                        taobaoUserLikemodel.status = [[[array objectAtIndex:i]objectForKey:@"status"]integerValue];
//                        taobaoUserLikemodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
//                        taobaoUserLikemodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
//                        taobaoUserLikemodel.tsUserId = [[[array objectAtIndex:i]objectForKey:@"tsUserId"]integerValue];
//                        taobaoUserLikemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
//                        taobaoUserLikemodel.imageUrl = [[array objectAtIndex:i]objectForKey:@"imageUrl"];
//                        taobaoUserLikemodel.unit = [[array objectAtIndex:i]objectForKey:@"unit"];
//                        taobaoUserLikemodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
//                        NSMutableArray * temp = [NSMutableArray array];
//                        temp = [[array objectAtIndex:i]objectForKey:@"imageList"];
//                        for (int j = 0; j < temp.count; j++) {
//                            RSTaobaoVideoAndPictureModel * videoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
//                            videoAndPicturemodel.imageId = [[[temp objectAtIndex:j]objectForKey:@"imageId"]integerValue];
//                            videoAndPicturemodel.videoId = [[[temp objectAtIndex:j]objectForKey:@"videoId"]integerValue];
//                            videoAndPicturemodel.imageUrl = [[temp objectAtIndex:j]objectForKey:@"imageUrl"];
//                            videoAndPicturemodel.videoUrl = [[temp objectAtIndex:j]objectForKey:@"videoUrl"];
//                            [taobaoUserLikemodel.imageList addObject:videoAndPicturemodel];
//                        }
//                        [weakSelf.contentArray addObject:taobaoUserLikemodel];
//                    }
//                    weakSelf.tableview.hidden = NO;
//                    weakSelf.rsSearchCollectionView.hidden = YES;
                    
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
    }else{
        self.tableview.hidden = YES;
        self.rsSearchCollectionView.hidden = NO;
    }
}


- (void)reloadShopInformationMoreNewData{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if ([verifykey length] < 1) {
           verifykey = @"";
       }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"" forKey:@"stockType"];
   
    [phoneDict setObject:_searchStr forKey:@"stoneName"];
    
    [phoneDict setObject:@"" forKey:@"orderField"];
    
    [phoneDict setObject:@"" forKey:@"orderMode"];
    
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"tsUserId"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"length"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"width"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"height"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"volume"];
    
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"area"];
    
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"lengthType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"widthType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"heightType"];
    [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"volumeType"];
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

- (void)fairReload{
    [self.tableview.mj_header beginRefreshing];
}





- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
