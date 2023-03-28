//
//  RSCargoMainCampViewController.m
//  石来石往
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCargoMainCampViewController.h"
#import "RSCargoMainCampModel.h"
#import "RSCargoMainCampCell.h"

#import "YJFastButton.h"

#import "RSLeftViewController.h"
#import "RSMainStoneViewController.h"
#import "RSStonePictureMangerViewController.h"
@interface RSCargoMainCampViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)NSMutableArray * collocectArray;
@property (nonatomic,strong)UIView * centerloadImageView;
@property (nonatomic,strong)YJFastButton * fastBtn;
@end

@implementation RSCargoMainCampViewController
- (NSMutableArray *)collocectArray{
    if (!_collocectArray) {
        _collocectArray = [NSMutableArray array];
    }
    return _collocectArray;
}

static NSString * RSCARGOMAINCAMPCELL = @"RSCargoMainCampCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[RSCargoMainCampCell class] forCellWithReuseIdentifier:RSCARGOMAINCAMPCELL];
    self.centerloadImageView = [[UIView alloc]initWithFrame:CGRectMake(SCW/2 - 50, 5, 100, 100)];
    self.centerloadImageView.backgroundColor = [UIColor clearColor];
    [_collectionView addSubview:self.centerloadImageView];
    self.centerloadImageView.hidden = NO;
    YJFastButton * fastBtn = [[YJFastButton alloc]initWithFrame:CGRectMake(0, 0, 100, 70)];
    [fastBtn setImage:[UIImage imageNamed:@"矢量智能对象1"] forState:UIControlStateNormal];
    if ([self.dataSoure isEqualToString:@"DZYC"]) {
        [fastBtn setTitle:@"暂无数据" forState:UIControlStateNormal];
    }else{
        [fastBtn setTitle:@"暂无案例" forState:UIControlStateNormal];
    }
    [fastBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    fastBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.centerloadImageView addSubview:fastBtn];
    
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fastBtn.frame), 100, 100 - CGRectGetMaxY(fastBtn.frame))];
    [addBtn setTitle:@"增加主营石材" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#f4f4f4"].CGColor;
    addBtn.layer.borderWidth = 1;
    addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    addBtn.layer.cornerRadius = 5;
    addBtn.layer.masksToBounds = YES;
    [addBtn addTarget:self action:@selector(addCargoManinPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerloadImageView addSubview:addBtn];
    if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[RSLeftViewController class]]) {
        if (self.usermodel.appManage_tppp == 1) {
            addBtn.hidden = NO;
        }else{
            addBtn.hidden = YES;
        }
        
    }else{
        addBtn.hidden = YES;
    }
    [self addCollectionViewRefresh];
   //  [self loadCargoMainCampNewData];  
}

//添加主营石材
- (void)addCargoManinPicture:(UIButton *)addBtn{
    if (self.usermodel.appManage_tppp == 1) {
        RSStonePictureMangerViewController * stoneVc = [[RSStonePictureMangerViewController alloc]init];
        stoneVc.userModel =self.usermodel;
        [self.navigationController pushViewController:stoneVc animated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:@"你没有权限进入"];
    }
}



- (void)addCollectionViewRefresh {
    
//    __weak typeof (self) weakSelf = self;
    
   RSWeakself
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf loadCargoMainCampNewData];
      //  });
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [weakSelf.collectionView.mj_footer endRefreshing];
         });
    }];
    
//    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.collectionView.mj_footer endRefreshing];
//        });
//    }];
//
   [self.collectionView.mj_header beginRefreshing];
    
}




- (void)loadCargoMainCampNewData{
    //URL_USERSTOCK_IOS
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    if (verifyKey.length > 0) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        // [dict setObject:self.usermodel.userID forKey:@"userId"];
        if ([self.dataSoure isEqualToString:@"DZYC"]) {
         
            [dict setObject:self.dataSoure forKey:@"dataSource"];
        }
        [dict setObject:self.userIDStr forKey:@"userId"];
        [dict setObject:self.erpCodeStr forKey:@"erpCode"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_USERSTOCK_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    NSMutableArray * array = json[@"Data"];
                    [weakSelf.collocectArray removeAllObjects];
                    if (array.count > 0) {
                        for (int j = 0 ; j < array.count; j++) {
                            RSCargoMainCampModel * cargoMainCampmodel = [[RSCargoMainCampModel alloc]init];
                            cargoMainCampmodel.blockTotalMessage = [[array objectAtIndex:j]objectForKey:@"blockTotalMessage"];
                            cargoMainCampmodel.plateTotalMessage = [[array objectAtIndex:j]objectForKey:@"plateTotalMessage"];
                            cargoMainCampmodel.erpUserName = [[array objectAtIndex:j]objectForKey:@"erpUserName"];
                            cargoMainCampmodel.proName = [[array objectAtIndex:j]objectForKey:@"proName"];
                            // picturepathmodel.logo = [[array objectAtIndex:j]objectForKey:@"logo"];
                            cargoMainCampmodel.erpCode = [[array objectAtIndex:j]objectForKey:@"erpCode"];
                            NSMutableArray * tempImgs = [NSMutableArray array];
                            tempImgs = [[array objectAtIndex:j]objectForKey:@"imgUrl"];
                            NSMutableArray * tempPictures = [NSMutableArray array];
                            for (int n = 0; n < tempImgs.count; n++) {
                                NSString * url = [tempImgs objectAtIndex:n];
                                [tempPictures addObject:url];
                            }
                            cargoMainCampmodel.imgUrl = tempPictures;
                            [weakSelf.collocectArray addObject:cargoMainCampmodel];
                        }
                        self.centerloadImageView.hidden = YES;
                    }else{
                        self.centerloadImageView.hidden = NO;
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.collectionView reloadData];
                        [weakSelf.collectionView.mj_header endRefreshing];
                    });
                }
                else{
                    self.centerloadImageView.hidden = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.collectionView reloadData];
                        [weakSelf.collectionView.mj_header endRefreshing];
                    });
                    
                }
            }else{
                self.centerloadImageView.hidden = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.collectionView reloadData];
                    [weakSelf.collectionView.mj_header endRefreshing];
                });
            }
        }];
    }
   
}




#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.collocectArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RSCargoMainCampCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RSCARGOMAINCAMPCELL forIndexPath:indexPath];
    RSCargoMainCampModel * cargomaincampmodel = self.collocectArray[indexPath.row];
    [cell.productImageview sd_setImageWithURL:[NSURL URLWithString:cargomaincampmodel.imgUrl[0]] placeholderImage:[UIImage imageNamed:@"512"]];
    cell.dabanProductLabel.text = [NSString stringWithFormat:@"大板:%@m²",cargomaincampmodel.plateTotalMessage];
    cell.productLabel.text =cargomaincampmodel.proName;
    cell.huangProductLabel.text =[NSString stringWithFormat:@"荒料:%@m³",cargomaincampmodel.blockTotalMessage];
    cell.layer.shadowColor = [UIColor colorWithHexColorStr:@"#000000" alpha:0.05].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0,2);
    cell.layer.shadowOpacity = 1;
    cell.layer.shadowRadius = 3;
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [UIColor colorWithHexColorStr:@"#F4F4F4"].CGColor;
    cell.contentView.layer.cornerRadius = 6;
    cell.contentView.layer.masksToBounds = YES;
   // cell.layer.masksToBounds = YES;
    return cell;
}




//内容整体边距设置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsMake(0, 12, 0, 12);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeMake(SCW, 14);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCW/2 - 16.5), 190);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 9;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    RSCargoMainCampModel * cargoMainCampmodel = self.collocectArray[indexPath.row];
    RSMainStoneViewController * mainStoneVc = [[RSMainStoneViewController alloc]init];
    mainStoneVc.usermodel = self.usermodel;
    mainStoneVc.stoneName = cargoMainCampmodel.proName;
    mainStoneVc.companyName = cargoMainCampmodel.erpUserName;
    mainStoneVc.photos = cargoMainCampmodel.imgUrl;
    if ([self.dataSoure isEqualToString:@"DZYC"]) {
        mainStoneVc.dataSource = self.dataSoure;
    }else{
        mainStoneVc.dataSource = @"HXSC";
    }
    mainStoneVc.erpCode = cargoMainCampmodel.erpCode;
    [self.navigationController pushViewController:mainStoneVc animated:YES];
    
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2 - 18,197);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
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
