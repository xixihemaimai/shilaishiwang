//
//  RSSCContentViewController.m
//  石来石往
//
//  Created by mac on 2021/10/26.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCContentViewController.h"
#import "RSSCContentCollectionCell.h"
#import "RSSCContentCompanyCell.h"
#import "RSSCContentCaseCell.h"
#import "RSSCStoneHeaderView.h"
#import "RSSCCaseHeaderView.h"
#import "RSSCOwnerDetailViewController.h"
//点击精选案例cell
#import "RSSCCaseDetailViewController.h"
//点击企业cell
#import "RSSCCompanyViewController.h"
//石材模型
#import "RSSCContentModel.h"
#import "RSLocationModel.h"
//企业模型
#import "RSSCCompanyModel.h"
//精选案例模型
#import "RSCasesModel.h"
#import "RSCaseTypeModel.h"
@interface RSSCContentViewController ()<RSSCCaseHeaderViewDelegate>

@property (nonatomic,assign)NSInteger pageNum;


@property (nonatomic,strong)NSMutableArray * scContenetArray;


@property (nonatomic,strong)NSMutableArray * caseTypeArray;

//精选案例--案例选择需要的这个案例ID
@property (nonatomic,assign)NSInteger caseCategoryId;


@end

@implementation RSSCContentViewController

- (NSMutableArray *)caseTypeArray{
    if (!_caseTypeArray) {
        _caseTypeArray = [NSMutableArray array];
    }
    return _caseTypeArray;
}


- (NSMutableArray *)scContenetArray{
    if (!_scContenetArray) {
        _scContenetArray = [NSMutableArray array];
    }
    return _scContenetArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionview];
    //设置显示的可显示的访问
//    self.collectionview.contentSize = CGSizeMake(SCW, SCH);
    self.collectionview.contentInset = UIEdgeInsetsMake(0, 0, Height_Real(161) * 2, 0);
    self.pageNum = 1;
    if ([self.title isEqualToString:@"大理石"] || [self.title isEqualToString:@"花岗石"] || [self.title isEqualToString:@"莱姆石"] || [self.title isEqualToString:@"石材信息"]) {
        [self.collectionview registerClass:[RSSCContentCollectionCell class] forCellWithReuseIdentifier:@"STONE"];
        [self.collectionview registerClass:[RSSCStoneHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }else if ([self.title isEqualToString:@"企业"]){
        [self.collectionview registerClass:[RSSCContentCompanyCell class] forCellWithReuseIdentifier:@"COMPANY"];
    }else{
        //精选案例
        [self.collectionview registerClass:[RSSCContentCaseCell class] forCellWithReuseIdentifier:@"CASE"];
        [self.collectionview registerClass:[RSSCCaseHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CASEHEADER"];
        //这边还要在去请求案例分类
        if (self.type == 0) {        
            [self casesTypeQuery];
        }
    }
//    [self.collectionview.mj_header beginRefreshing];
    [self selectionCenterShowContentWithSearchType:@"0" andNameCn:self.nameCn andStoneName:self.stoneName andSubject:self.subject andPageSize:10 andIsHead:true];
    RSWeakself
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf selectionCenterShowContentWithSearchType:@"0" andNameCn:weakSelf.nameCn andStoneName:weakSelf.stoneName andSubject:self.subject andPageSize:10 andIsHead:true];
    }];
    
    self.collectionview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf selectionCenterShowContentWithSearchType:@"0" andNameCn:weakSelf.nameCn andStoneName:weakSelf.stoneName andSubject:self.subject andPageSize:10 andIsHead:false];
    }];
}


- (void)casesTypeQuery{
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey] == nil ? @"" : [UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    CLog(@"++++++++++++++23232323232323++++++++++++++%@",parameters);
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_CASE_TYPE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"success"] boolValue] ;
            if (Result) {
//                CLog(@"==============32323232323232323=========3======================%@",json);
                [weakSelf.caseTypeArray removeAllObjects];
                NSMutableArray * array = [RSCaseTypeModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                RSCaseTypeModel * caseTypeModel = [[RSCaseTypeModel alloc]init];
                caseTypeModel.nameCn = @"全部精选";
                RSCaseTypeModel * caseTypeModel1 = array[0];
                caseTypeModel.caseTypeId = 0;
                caseTypeModel.url = caseTypeModel1.url;
                [weakSelf.caseTypeArray addObject:caseTypeModel];
                [weakSelf.caseTypeArray addObjectsFromArray:array];
                [weakSelf.collectionview reloadData];
            }
        }
    }];
}



#pragma mark 网络请求
- (void)selectionCenterShowContentWithSearchType:(NSString *)stoneType andNameCn:(NSString *)nameCn andStoneName:(NSString *)stoneName andSubject:(NSString *)subject andPageSize:(NSInteger)pageSize andIsHead:(BOOL)isHead{
    //stoneType stoneName
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSString * url = @"";
    if ([self.title isEqualToString:@"大理石"] || [self.title isEqualToString:@"花岗石"] || [self.title isEqualToString:@"莱姆石"] || [self.title isEqualToString:@"石材信息"]){
        url = URL_SelectionCenter_Stone_IOS;
        NSString * stoneType = stoneType;
        if ([self.title isEqualToString:@"大理石"]) {
            stoneType = @"0";
        }else if ([self.title isEqualToString:@"花岗石"]){
            stoneType = @"1";
        }else if ([self.title isEqualToString:@"莱姆石"]){
            stoneType = @"2";
        }else{
            stoneType = @"";
        }
        
        [phoneDict setObject:stoneType forKey:@"stoneType"];
        [phoneDict setObject:stoneName forKey:@"stoneName"];
    }else if ([self.title isEqualToString:@"企业"]){
        url = URL_SelectionCenter_Company_IOS;
        //企业是nameCn
        [phoneDict setObject:nameCn forKey:@"nameCn"];
    }else if ([self.title isEqualToString:@"精选案例"]){
        url = URL_CASE_QUERY_IOS;
//        CLog(@"++++++++++++++++++++++++++++++++++++++++++%ld",self.caseCategoryId);
        /**
         企业ID    enterpriseId    Int    企业ID 传入查询单企业案例
         每页条数    pageSize    Int
         页码    pageNum    Int
         案例主题搜索    subject    String    模糊搜索
         */
//        CLog(@"====================================%@",subject);
        [phoneDict setObject:[NSNull null] forKey:@"enterpriseId"];
        [phoneDict setObject:subject forKey:@"subject"];
        //类型ID
        if (self.caseCategoryId != 0) {
            [phoneDict setObject:[NSString stringWithFormat:@"%ld",(long)self.caseCategoryId] forKey:@"caseCategoryId"];
        }
    }
    if (isHead) {
       self.pageNum = 1;
    }else{
       self.pageNum++;
    }
    //pageNum   pageSize 必须要的
    [phoneDict setObject:[NSString stringWithFormat:@"%ld",(long)self.pageNum] forKey:@"pageNum"];
    [phoneDict setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey] == nil ? @"" : [UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    CLog(@"++++++++++++++++++++++++++++%@",parameters);
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:url withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"success"] boolValue] ;
            if (Result) {
//                CLog(@"=============================================%@",json);
                if (isHead) {
                    //这边数组要全部进行删除
                    [weakSelf.scContenetArray removeAllObjects];
                    if ([weakSelf.title isEqualToString:@"大理石"] || [weakSelf.title isEqualToString:@"花岗石"] || [weakSelf.title isEqualToString:@"莱姆石"]|| [self.title isEqualToString:@"石材信息"]){
                        weakSelf.scContenetArray = [RSSCContentModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    }else if ([weakSelf.title isEqualToString:@"企业"]){
                        weakSelf.scContenetArray = [RSSCCompanyModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    }else if ([weakSelf.title isEqualToString:@"精选案例"]){
                        weakSelf.scContenetArray = [RSCasesModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    }
                    [weakSelf.collectionview reloadData];
                    [weakSelf.collectionview.mj_header endRefreshing];
                }
                else{
                    //添加数组
                    NSMutableArray * tempArray = [NSMutableArray array];
                    if ([weakSelf.title isEqualToString:@"大理石"] || [weakSelf.title isEqualToString:@"花岗石"] || [weakSelf.title isEqualToString:@"莱姆石"]|| [self.title isEqualToString:@"石材信息"]){
                        tempArray = [RSSCContentModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    }else if ([weakSelf.title isEqualToString:@"企业"]){
                        tempArray = [RSSCCompanyModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    }else if ([weakSelf.title isEqualToString:@"精选案例"]){
                        tempArray = [RSCasesModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    }
//                    CLog(@"++++++++++32323+++++++++++++++++++%ld",tempArray.count);
//                    if (weakSelf.pageNum > 2) {
//                        if (tempArray.count < pageSize - 1) {
//                           weakSelf.pageNum--;
//                        }
//                    }
                    [weakSelf.scContenetArray addObjectsFromArray:tempArray];
                    [weakSelf.collectionview reloadData];
                    [weakSelf.collectionview.mj_footer endRefreshing];
                }
                
            }
       }else{
            if (isHead) {
                [weakSelf.collectionview.mj_header endRefreshing];
            }else{
                [weakSelf.collectionview.mj_footer endRefreshing];
            }
        }
    }];
}
#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
#pragma mark 每一组多少
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.scContenetArray.count;
}
#pragma mark 显示cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.title isEqualToString:@"大理石"] || [self.title isEqualToString:@"花岗石"] || [self.title isEqualToString:@"莱姆石"] || [self.title isEqualToString:@"石材信息"]) {
        RSSCContentCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"STONE" forIndexPath:indexPath];
        cell.isExhibitionLocation = self.isExhibitionLocation;
        cell.sccontentModel = self.scContenetArray[indexPath.row];
        return cell;
    }else if([self.title isEqualToString:@"企业"]){
        RSSCContentCompanyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"COMPANY" forIndexPath:indexPath];
        cell.sccompanyModel = self.scContenetArray[indexPath.row];
        return cell;
    }else{
        //精选案例
        RSSCContentCaseCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CASE" forIndexPath:indexPath];
        cell.caseModel = self.scContenetArray[indexPath.row];
        return cell;
    }
}

#pragma mark 点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:true];
//    [UserManger checkLogin:self successBlock:^{
        if ([self.title isEqualToString:@"大理石"] || [self.title isEqualToString:@"花岗石"] || [self.title isEqualToString:@"莱姆石"] || [self.title isEqualToString:@"石材信息"]) {
            RSSCContentModel * sccontentModel = self.scContenetArray[indexPath.row];
            //货主详情
            RSSCOwnerDetailViewController * ownerVc = [[RSSCOwnerDetailViewController alloc]init];
            ownerVc.title = sccontentModel.stoneName;
            ownerVc.stoneName = sccontentModel.stoneName;
            ownerVc.enterpriseId = sccontentModel.enterpriseId;
            if ([self.title isEqualToString:@"大理石"]) {
                ownerVc.stoneType = @"0";
            }else if ([self.title isEqualToString:@"花岗石"]){
                ownerVc.stoneType = @"1";
            }else if ([self.title isEqualToString:@"莱姆石"]){
                ownerVc.stoneType = @"2";
            }
            else{
                ownerVc.stoneType = @"";
            }
            [self.navigationController pushViewController:ownerVc animated:YES];
        }else if ([self.title isEqualToString:@"企业"]){
            
           RSSCCompanyModel * scCompanyModel = self.scContenetArray[indexPath.row];
           RSSCCompanyViewController * scCompanyVc = [RSSCCompanyViewController suspendCenterPageVCWithEnterpriseId:scCompanyModel.sccompanyId];
           [self.navigationController pushViewController:scCompanyVc animated:true];
        }else
        {
            
            RSCasesModel * casesModel = self.scContenetArray[indexPath.row];
            RSSCCaseDetailViewController * caseVc = [[RSSCCaseDetailViewController alloc]init];
            caseVc.casesModel = casesModel;
            [self.navigationController pushViewController:caseVc animated:true];
        }
//    }];
}

#pragma mark 组头
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([self.title isEqualToString:@"大理石"] || [self.title isEqualToString:@"花岗石"] || [self.title isEqualToString:@"莱姆石"] || [self.title isEqualToString:@"石材信息"]) {
        if (self.type == 0) {
            RSSCStoneHeaderView * headerView = nil;
            if (kind == UICollectionElementKindSectionHeader) {
                  headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
                  return  headerView;
            }
        }else{
            return nil;
        }
    }else if ([self.title isEqualToString:@"精选案例"]){
        if (self.type == 0) {
            RSSCCaseHeaderView * headerView = nil;
            if (kind == UICollectionElementKindSectionHeader) {
                headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CASEHEADER" forIndexPath:indexPath];
                headerView.delegate = self;
                headerView.caseArray = self.caseTypeArray;
                return headerView;
            }
        }else{
            return nil;
        }
        
    }else{
        //企业
        return nil;
    }
    return nil;
}

#pragma mark 返回每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.title isEqualToString:@"大理石"] || [self.title isEqualToString:@"花岗石"] || [self.title isEqualToString:@"莱姆石"]|| [self.title isEqualToString:@"石材信息"]) {
        CGFloat wight = (SCW - Width_Real(32) - Width_Real(16))/2;
//        CGFloat height = Height_Real(191);
        return CGSizeMake(wight,  191);
    }else if([self.title isEqualToString:@"企业"]){
        RSSCCompanyModel * scCompanyModel = self.scContenetArray[indexPath.row];
        if (scCompanyModel.urlList.count > 0) {
            return CGSizeMake(SCW, Height_Real(196));
        }else{
            return CGSizeMake(SCW, Height_Real(110));
        }
    }else{
        //精选案例
        return CGSizeMake(SCW, Height_Real(260));
    }
}

#pragma mark 动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if ([self.title isEqualToString:@"大理石"] || [self.title isEqualToString:@"花岗石"] || [self.title isEqualToString:@"莱姆石"] || [self.title isEqualToString:@"石材信息"]) {
        return UIEdgeInsetsMake(Height_Real(16), Width_Real(16), 0, Width_Real(16));
    }else{
        return UIEdgeInsetsMake(0,0,0,0);
    }
}

#pragma mark 动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.title isEqualToString:@"大理石"] || [self.title isEqualToString:@"花岗石"] || [self.title isEqualToString:@"莱姆石"] || [self.title isEqualToString:@"石材信息"]) {
        return Width_Real(12);
    }else{
        return 0;
    }
}

#pragma mark 动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.title isEqualToString:@"大理石"] || [self.title isEqualToString:@"花岗石"] || [self.title isEqualToString:@"莱姆石"] || [self.title isEqualToString:@"石材信息"]) {
        return Height_Real(12);
    }else{
        return 0;
    }
}

#pragma mark 动态设置某个分区头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if ([self.title isEqualToString:@"大理石"] || [self.title isEqualToString:@"花岗石"] || [self.title isEqualToString:@"莱姆石"] || [self.title isEqualToString:@"石材信息"]) {
        if (self.type == 0) {
            return CGSizeMake(SCW, 128);
        }else{
            return CGSizeMake(0, 0);
        }
    }else if ([self.title isEqualToString:@"精选案例"]){
        if (self.type == 0) {
            return CGSizeMake(0, Height_Real(18) + Width_Real(80));
        }else{
            return CGSizeMake(0, 0);
        }
    }else{
        return CGSizeMake(0, 0);
    }
}


#pragma mark 动态设置某个分区尾视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}


#pragma mark 垂直偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -Height_Real(100);
}



#pragma mark RSSCCaseHeaderViewDelegate  酒店之类的按键
- (void)jumpCaseTypeIndex:(NSInteger)index{
//    CLog(@"----------------------------------%ld",index);
    RSCaseTypeModel * caseTypeModel = self.caseTypeArray[index];
    if ([caseTypeModel.nameCn isEqualToString:@"全部精选"]) {
        self.subject = @"";
    }else{
        self.subject = caseTypeModel.nameCn;
    }
    //类别ID
    self.caseCategoryId = caseTypeModel.caseTypeId;
//    self.enterpriseId = caseTypeModel.caseTypeId;
    [self selectionCenterShowContentWithSearchType:@"0" andNameCn:self.nameCn andStoneName:self.stoneName andSubject: self.subject andPageSize:10 andIsHead:true];
}


@end
