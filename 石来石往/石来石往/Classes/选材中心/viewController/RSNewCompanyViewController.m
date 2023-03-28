//
//  RSNewCompanyViewController.m
//  石来石往
//
//  Created by mac on 2021/12/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSNewCompanyViewController.h"
#import "RSNewCompanyModel.h"
#import "RSCasesModel.h"

#import "RSNewCompanyCell.h"

#import "RSSCContentCaseCell.h"
#import "RSSCCaseDetailViewController.h"

@interface RSNewCompanyViewController ()
@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * newCompanyArray;
@end

@implementation RSNewCompanyViewController

- (NSMutableArray *)newCompanyArray{
    if (!_newCompanyArray) {
        _newCompanyArray = [NSMutableArray array];
    }
    return _newCompanyArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionview];
    self.pageNum = 1;
    
    if ([self.title isEqualToString:@"工程案例"]) {
        [self.collectionview registerClass:[RSSCContentCaseCell class] forCellWithReuseIdentifier:@"CASE"];
    }else{    
        [self.collectionview registerClass:[RSNewCompanyCell class] forCellWithReuseIdentifier:@"newCollectionview"];
    }
    
    
    [self loadNewCompanyDataWithPageSize:10 andIsHead:true];
    RSWeakself
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewCompanyDataWithPageSize:10 andIsHead:true];
    }];
    
    if ([self.title isEqualToString:@"工程案例"]) {
        self.collectionview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [weakSelf loadNewCompanyDataWithPageSize:10 andIsHead:false];
        }];
    }
}



#pragma mark 这边用来获取数据
- (void)loadNewCompanyDataWithPageSize:(NSInteger)pageSize andIsHead:(BOOL)isHead{
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:self.enterpriseId] forKey:@"enterpriseId"];
    NSString * url = @"";
    if ([self.title isEqualToString:@"新品"]) {
        [phoneDict setValue:@"0" forKey:@"category"];
        url = URL_ENTERPRISE_STONE_IOS;
    }else if ([self.title isEqualToString:@"主营石材"]){
        [phoneDict setValue:@"1" forKey:@"category"];
        url = URL_ENTERPRISE_STONE_IOS;
    }else{
        url = URL_CASE_QUERY_IOS;
        [phoneDict setObject:@"" forKey:@"subject"];
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
//            CLog(@"++++++++++++++++++++++++++++%@",json);
            BOOL Result = [json[@"success"] boolValue] ;
            if (Result) {
                
                if (isHead) {
                    [weakSelf.newCompanyArray removeAllObjects];
                    if ([self.title isEqualToString:@"新品"]) {
                        weakSelf.newCompanyArray = [RSNewCompanyModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    }else if ([self.title isEqualToString:@"主营石材"]){
                        weakSelf.newCompanyArray = [RSNewCompanyModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    }else{
                        weakSelf.newCompanyArray = [RSCasesModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    }
                    [weakSelf.collectionview.mj_header endRefreshing];
                }else{
                    
                    if ([self.title isEqualToString:@"新品"]) {
//                      tempArray = [RSNewCompanyModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    }else if ([self.title isEqualToString:@"主营石材"]){
//                        tempArray = [RSNewCompanyModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    }else{
                        NSMutableArray * tempArray = [NSMutableArray array];
                        tempArray = [RSCasesModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                        [weakSelf.newCompanyArray addObjectsFromArray:tempArray];
                    }
//                    if (weakSelf.pageNum > 2) {
//                        if (tempArray.count < pageSize - 1) {
//                           weakSelf.pageNum--;
//                        }
//                    }
                    
                    [weakSelf.collectionview.mj_footer endRefreshing];
                }
                [weakSelf.collectionview reloadData];
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



#pragma mark 垂直偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -Height_Real(100);
}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark 每一组多少
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.newCompanyArray.count;
}

#pragma mark 显示cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.title isEqualToString:@"工程案例"]) {
        //精选案例
        RSSCContentCaseCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CASE" forIndexPath:indexPath];
        cell.caseModel = self.newCompanyArray[indexPath.row];
        return cell;
    }else{
        RSNewCompanyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newCollectionview" forIndexPath:indexPath];
        cell.companyModel = self.newCompanyArray[indexPath.row];
        cell.layer.shadowColor = [UIColor colorWithHexColorStr:@"#000000" alpha:0.05].CGColor;
        cell.layer.shadowOffset = CGSizeMake(0,2);
        cell.layer.shadowOpacity = Width_Real(1);
        cell.layer.shadowRadius =Width_Real(3);
        cell.layer.borderWidth = Width_Real(0.5);
        cell.layer.borderColor = [UIColor colorWithHexColorStr:@"#F4F4F4"].CGColor;
        cell.contentView.layer.cornerRadius = Width_Real(6);
        cell.contentView.clipsToBounds = YES;
        return cell;
    }
}

#pragma mark 点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if ([self.title isEqualToString:@"工程案例"]) {
        RSCasesModel * casesModel = self.newCompanyArray[indexPath.row];
        RSSCCaseDetailViewController * caseVc = [[RSSCCaseDetailViewController alloc]init];
//            caseVc.enterpriseId = casesModel.enterpriseId;
        caseVc.casesModel = casesModel;
        [self.navigationController pushViewController:caseVc animated:true];
    }
}

#pragma mark 动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    
    if ([self.title isEqualToString:@"工程案例"]) {
        return UIEdgeInsetsMake(0,0,0,0);
    }else{    
        return UIEdgeInsetsMake(0, Width_Real(16), 0, Width_Real(16));
    }
}


#pragma mark 返回每个item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.title isEqualToString:@"工程案例"]) {
        //精选案例
        return CGSizeMake(SCW, Height_Real(260));
    }else{
        return CGSizeMake((SCW - 3 * Width_Real(16))/2, Height_Real(153));
    }
}
#pragma mark 动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.title isEqualToString:@"工程案例"]) {
        return 0;
    }else{
        return Width_Real(12);
    }
}

#pragma mark 动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.title isEqualToString:@"工程案例"]) {
        return 0;
    }else{
        return Height_Real(12);
    }
}


@end
