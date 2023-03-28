//
//  RSMoreBrandEnterprisesViewController.m
//  石来石往
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSMoreBrandEnterprisesViewController.h"
#import "RSMoreBrandCell.h"
#import "RSBrandEnterPriseModel.h"
#import "RSCargoCenterBusinessViewController.h"

//大众云仓的个人主页
#import "RSDZYCMainCargoCenterViewController.h"
@interface RSMoreBrandEnterprisesViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,strong)UICollectionView * collectionview;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * companyArray;

@end

@implementation RSMoreBrandEnterprisesViewController
- (NSMutableArray *)companyArray{
    if (!_companyArray) {
        _companyArray = [NSMutableArray array];
    }
    return _companyArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
}


static NSString * MOREBRANDID = @"MOREBRANDID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"品牌企业";
    self.pageNum = 2;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (SCW - (2 + 1)*12)/2;
    CGFloat itemHeight = itemWidth * 2/3;
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    // 设置列间距
    layout.minimumInteritemSpacing = 12;
    // 设置行间距
    layout.minimumLineSpacing = 12;
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH) collectionViewLayout:layout];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    self.collectionview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionview];
    [self.collectionview registerClass:[RSMoreBrandCell class] forCellWithReuseIdentifier:MOREBRANDID];
    [self brandEnterpriseListNewData];
    RSWeakself
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf brandEnterpriseListNewData];
    }];
    //向上刷新
    self.collectionview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf brandEnterpriseListMoreNewData];
    }];
}


- (void)brandEnterpriseListNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    if (verifyKey.length < 1) {
        verifyKey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    //[phoneDict setObject:[NSNumber numberWithInt:4] forKey:@"size"];
    //[phoneDict setObject:str forKey:@"excludeList"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BRANDENTERPRISELIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
//            NSLog(@"======================%@",json);
            BOOL result = [json[@"Result"] boolValue];
            if (result) {
                [weakSelf.companyArray removeAllObjects];
                //NSMutableArray * array = [NSMutableArray array];
                weakSelf.companyArray = [RSBrandEnterPriseModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                
                weakSelf.pageNum = 2;
                [weakSelf.collectionview reloadData];
                [weakSelf.collectionview.mj_header endRefreshing];
                
            }else{
                [weakSelf.collectionview reloadData];
                [weakSelf.collectionview.mj_header endRefreshing];
            }
        }else{
            [weakSelf.collectionview reloadData];
            [weakSelf.collectionview.mj_header endRefreshing];
        }
    }];
}

- (void)brandEnterpriseListMoreNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    if (verifyKey.length < 1) {
        verifyKey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    //[phoneDict setObject:[NSNumber numberWithInt:4] forKey:@"size"];
    //[phoneDict setObject:str forKey:@"excludeList"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BRANDENTERPRISELIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL result = [json[@"Result"] boolValue];
            if (result) {
                NSMutableArray * array = [NSMutableArray array];
                array = [RSBrandEnterPriseModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                [weakSelf.companyArray addObjectsFromArray:array];
                weakSelf.pageNum++;
                [weakSelf.collectionview reloadData];
                [weakSelf.collectionview.mj_footer endRefreshing];
                
            }else{
                [weakSelf.collectionview reloadData];
                [weakSelf.collectionview.mj_footer endRefreshing];
            }
        }else{
            [weakSelf.collectionview reloadData];
            [weakSelf.collectionview.mj_footer endRefreshing];
        }
    }];
}






- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.companyArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RSMoreBrandCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MOREBRANDID forIndexPath:indexPath];
//    HUImageItem *item = self.images[indexPath.row];
//    cell.imageView.image = item.image;
//    cell.didSelected = item.selected;
    
    RSBrandEnterPriseModel * brandEnterPrisemodel = self.companyArray[indexPath.row];
    [cell.contentImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",brandEnterPrisemodel.logo]] placeholderImage:[UIImage imageNamed:@"512"]];
    
    return cell;
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RSBrandEnterPriseModel * brandEnterPrisemodel = self.companyArray[indexPath.row];
    
    if ([brandEnterPrisemodel.dataSource isEqualToString:@"DZYC"]) {
        //个人版的界面
        RSDZYCMainCargoCenterViewController * cargoCenterVc = [RSDZYCMainCargoCenterViewController suspendCenterPageVCUserModel:self.usermodel andErpCodeStr:brandEnterPrisemodel.sysUserId andCreat_userIDStr:brandEnterPrisemodel.sysUserId andUserIDStr:brandEnterPrisemodel.sysUserId andDataSoure:brandEnterPrisemodel.dataSource];
//        cargoCenterVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cargoCenterVc animated:YES];
        
        
    }else{
        //HXSC个人主页
        RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.usermodel andErpCodeStr:@"" andCreat_userIDStr:brandEnterPrisemodel.sysUserId andUserIDStr:brandEnterPrisemodel.sysUserId];
        [self.navigationController pushViewController:cargoCenterVc animated:YES];
    }
}






@end
