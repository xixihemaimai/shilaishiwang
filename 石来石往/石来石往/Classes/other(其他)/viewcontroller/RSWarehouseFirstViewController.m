//
//  RSWarehouseFirstViewController.m
//  石来石往
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSWarehouseFirstViewController.h"
#import "RSHSStockCell.h"
#import "RSHSStockSectionHeaderView.h"

#import "RSHotStoneModel.h"
#import "RSBrandEnterPriseModel.h"
#import "RSCargoCenterBusinessViewController.h"
#import "RSADPictureModel.h"
#import "RSSearchHuangAndDabanViewController.h"
#import "RSLoginViewController.h"
#import "ZKImgRunLoopView.h"
#import "RSHSStockFourCell.h"

//更多的品牌货主
#import "RSMoreBrandEnterprisesViewController.h"

//大众云仓的个人主页
#import "RSDZYCMainCargoCenterViewController.h"

//UITableViewDelegate,UITableViewDataSource,
@interface RSWarehouseFirstViewController ()<RSHSStockFourCellDelegate,RSHSStockCellDelegate>

@property (nonatomic,strong)NSMutableArray * adArray;

@property (nonatomic,strong)NSMutableArray * companyArray;

@property (nonatomic,strong)NSMutableArray * stoneArray;

//@property (nonatomic,strong)UITableView * tableview;
@end

@implementation RSWarehouseFirstViewController

- (NSMutableArray *)adArray{
    if (!_adArray) {
        _adArray = [NSMutableArray array];
    }
    return _adArray;
}

- (NSMutableArray *)companyArray{
    if (!_companyArray) {
        _companyArray = [NSMutableArray array];
    }
    return _companyArray;
}


- (NSMutableArray *)stoneArray{
    if (!_stoneArray) {
        _stoneArray = [NSMutableArray array];
    }
    return _stoneArray;
}

//- (UITableView *)tableview{
//    if (!_tableview) {
//        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH - 206) style:UITableViewStyleGrouped];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
//        _tableview.estimatedRowHeight = 0;
//        _tableview.estimatedSectionFooterHeight = 0;
//        _tableview.estimatedSectionHeaderHeight = 0;
//        _tableview.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
//        _tableview.backgroundColor = [UIColor whiteColor];
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    return _tableview;
//}

static NSString * HSSTOCKSECTIONHEADERID = @"HSSTOCKSECTIONHEADERID";
- (void)viewDidLoad {
    [super viewDidLoad];
  
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:self.tableview];
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - 206);
    [self loadHotStoneNewData];
    [self brandEnterpriseListNewData];
    [self loadMarkData];
}


- (void)setCustomTableview:(NSArray *)array{
    UIView * pictureView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 255)];
    pictureView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.tableview.tableHeaderView = pictureView;
    
    ZKImgRunLoopView *imgRunView = [[ZKImgRunLoopView alloc] initWithFrame:CGRectMake(12, 19, SCW - 24, 153) placeholderImg:[UIImage imageNamed:@"广告"]];
    imgRunView.pageControl.hidden = NO;
    [pictureView addSubview:imgRunView];
    imgRunView.pageControl.PageControlContentMode =  JhPageControlContentModeCenter;
    imgRunView.pageControl.PageControlStyle = JhPageControlStyelDefault;
    imgRunView.pageControl.currentColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    imgRunView.pageControl.otherColor = [UIColor colorWithHexColorStr:@"#ffffff" alpha:0.5];
    imgRunView.pageControl.controlSpacing = 10;
    imgRunView.pageControl.yj_y = 191 - 37 -19;
    imgRunView.pageControl.yj_centerX = self.view.yj_centerX;
    //海西市场的详情情况
    UIView * haixiView = [[UIView alloc]initWithFrame:CGRectMake(12, 196, SCW - 24, 45)];
    haixiView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [pictureView addSubview:haixiView];
    
    SXMarquee * mar2 = [[SXMarquee alloc]initWithFrame:CGRectMake(0, 0, SCW - 24, 45) speed:4 Msg:@"111" bgColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] txtColor:[UIColor colorWithHexColorStr:@"#333333"]];
    //_mar2 = mar2;
    [haixiView addSubview:mar2];
    
    
    haixiView.layer.shadowColor = [UIColor colorWithHexColorStr:@"#000000" alpha:0.07].CGColor;
    haixiView.layer.shadowOffset = CGSizeMake(0,0);
    haixiView.layer.shadowOpacity = 1;
    haixiView.layer.shadowRadius = 14;
    haixiView.layer.cornerRadius = 3;
    
    //海西市场
    UIImageView * haixiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 183, 72, 72)];
    haixiImageView.contentMode = UIViewContentModeScaleAspectFill;
    haixiImageView.clipsToBounds = YES;
    haixiImageView.image = [UIImage imageNamed:@"海西市场"];
    [pictureView addSubview:haixiImageView];
    [haixiImageView bringSubviewToFront:pictureView];
    
    for (int i = 0; i < array.count; i++) {
        RSADPictureModel * adPictureModel = array[i];
        if (adPictureModel.sliderImgs.count > 0) {
           imgRunView.imgUrlArray =  [NSMutableArray arrayWithArray:adPictureModel.sliderImgs];
        }
        mar2.msg = [NSString stringWithFormat:@"荒料总库存:%@m³ 大板总库存:%@m² 品种数:%@",adPictureModel.blockTotalMessage,adPictureModel.plateTotalMessage,adPictureModel.stoneTypeNum];
    }
    UIFont * font1 = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [mar2 changeMarqueeLabelFont:font1];
    [mar2 start];
}



//广告数据
- (void)loadMarkData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    if (verifyKey.length < 1) {
        verifyKey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInt:4] forKey:@"size"];
    [phoneDict setObject:@"1" forKey:@"versioncode"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_MARKETSTOCK_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL result = [json[@"Result"] boolValue];
            if (result) {
                [weakSelf.adArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"][@"marketInfo"];
                 RSADPictureModel * adPictureModel = [[RSADPictureModel alloc]init];
                for (int i = 0 ; i < array.count; i++) {
                    adPictureModel.blockTotalMessage = [[array objectAtIndex:i]objectForKey:@"blockTotalMessage"];
                    adPictureModel.erpId = [[array objectAtIndex:i]objectForKey:@"erpId"];
                    adPictureModel.erpName = [[array objectAtIndex:i]objectForKey:@"erpName"];
                    adPictureModel.plateTotalMessage = [[array objectAtIndex:i]objectForKey:@"plateTotalMessage"];
                    adPictureModel.stoneTypeNum = [[array objectAtIndex:i]objectForKey:@"stoneTypeNum"];
                }
                adPictureModel.sliderImgs = json[@"Data"][@"sliderImgs"];
                [weakSelf.adArray addObject:adPictureModel];
                
                [weakSelf setCustomTableview:weakSelf.adArray];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}

//热门石种
- (void)loadHotStoneNewData{
    NSMutableString * str = [NSMutableString string];
    if (self.stoneArray.count < 1) {
        str = [NSMutableString stringWithFormat:@""];
    }else{
        for (int i = 0; i < self.stoneArray.count; i++) {
            RSHotStoneModel * hotStoneModel = self.stoneArray[i];
            if (i == self.stoneArray.count - 1) {
                 [str appendString:hotStoneModel.stoneName];
            }
            else{
                [str appendString:[NSString stringWithFormat:@"%@,",hotStoneModel.stoneName]];
            }
        }
        [self.stoneArray removeAllObjects];
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    if (verifyKey.length < 1) {
        verifyKey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInt:4] forKey:@"size"];
    [phoneDict setObject:str forKey:@"excludeList"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HOTSTOME_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL result = [json[@"Result"] boolValue];
            if (result) {
                [weakSelf.stoneArray removeAllObjects];
                weakSelf.stoneArray = [RSHotStoneModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                [weakSelf.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }else{
                 [weakSelf.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else{
             [weakSelf.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

//品牌企业
- (void)brandEnterpriseListNewData{
  //URL_BRANDENTERPRISELIST_IOS
    NSMutableString * str = [NSMutableString string];
//    if (self.companyArray.count < 1) {
        str = [NSMutableString stringWithFormat:@""];
//    }else{
//        for (int i = 0; i < self.companyArray.count; i++) {
//            RSBrandEnterPriseModel * brandEnterPriseModel = self.companyArray[i];
//            if (i == self.companyArray.count - 1) {
//                [str appendString:brandEnterPriseModel.sysUserId];
//            }
//            else{
//                [str appendString:[NSString stringWithFormat:@"%@,",brandEnterPriseModel.sysUserId]];
//            }
//        }
//    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    if (verifyKey.length < 1) {
        verifyKey = @"";
    }
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    //[phoneDict setObject:[NSNumber numberWithInt:4] forKey:@"size"];
    //[phoneDict setObject:str forKey:@"excludeList"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:6] forKey:@"pageSize"];
    
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
                [weakSelf.companyArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = [RSBrandEnterPriseModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                [weakSelf.companyArray addObjectsFromArray:array];
//                if (array.count > 0) {
//                    [weakSelf.companyArray removeAllObjects];
//                    [weakSelf.companyArray addObjectsFromArray:array];
//                }
                [weakSelf.tableview reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }else{
                 [weakSelf.tableview reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else{
             [weakSelf.tableview reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 392;
    }else{
        //return 121;
        return 392;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * HSSTOCKCELLID = @"HSSTOCKCELLID";
        RSHSStockCell * cell = [tableView dequeueReusableCellWithIdentifier:HSSTOCKCELLID];
        if (!cell) {
            cell = [[RSHSStockCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:HSSTOCKCELLID];
        }
        cell.array = self.stoneArray;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString * STONECELLFOURID = @"STONECELLFOURID";
        RSHSStockFourCell * cell  = [tableView dequeueReusableCellWithIdentifier:STONECELLFOURID];
        if (!cell) {
            cell = [[RSHSStockFourCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:STONECELLFOURID];
        }
        cell.array = self.companyArray;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSHSStockSectionHeaderView * hsstockSectionHeaderview = [[RSHSStockSectionHeaderView alloc]initWithReuseIdentifier:HSSTOCKSECTIONHEADERID];
    if (section == 0) {
      hsstockSectionHeaderview.sectionHaederLabel.text = @"热门石种";
      hsstockSectionHeaderview.changeBtn.tag = 1;
      [hsstockSectionHeaderview.changeBtn setTitle:@"换一换" forState:UIControlStateNormal];
    }else if (section == 1){
      hsstockSectionHeaderview.sectionHaederLabel.text = @"品牌企业";
      hsstockSectionHeaderview.changeBtn.tag = 2;
      [hsstockSectionHeaderview.changeBtn setTitle:@"更多" forState:UIControlStateNormal];
        [hsstockSectionHeaderview.changeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    [hsstockSectionHeaderview.changeBtn addTarget:self action:@selector(changeOtherData:) forControlEvents:UIControlEventTouchUpInside];
    return hsstockSectionHeaderview;
}

//换一换
- (void)changeOtherData:(UIButton *)changBtn{
    if (changBtn.tag == 1) {
        [self loadHotStoneNewData];
    }else{
        //更多
       // [self brandEnterpriseListNewData];
//        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//        NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
//        if (VERIFYKEY.length < 1 ) {
//            RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//            loginVc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:loginVc animated:YES];
//        }else{
//            RSMoreBrandEnterprisesViewController * moreBrandEnterprisesVc = [[RSMoreBrandEnterprisesViewController alloc]init];
//            moreBrandEnterprisesVc.usermodel = self.userModel;
//            [self.navigationController pushViewController:moreBrandEnterprisesVc animated:YES];
//        }
        
        
        [UserManger checkLogin:self successBlock:^{
            RSMoreBrandEnterprisesViewController * moreBrandEnterprisesVc = [[RSMoreBrandEnterprisesViewController alloc]init];
            moreBrandEnterprisesVc.usermodel = self.userModel;
            [self.navigationController pushViewController:moreBrandEnterprisesVc animated:YES];
        }];
        
    }
}

//品牌货主要跳转的界面
- (void)jumpCompanyMainWebViewWithIndex:(NSInteger)index{
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
//    if (VERIFYKEY.length < 1 ) {
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//        loginVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginVc animated:YES];
//    }else{
//        RSBrandEnterPriseModel * brandEnterPriseModel = self.companyArray[index - 10000];
//        if ([brandEnterPriseModel.dataSource isEqualToString:@"DZYC"]) {
//            //个人版的界面
//            RSDZYCMainCargoCenterViewController * cargoCenterVc = [RSDZYCMainCargoCenterViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:brandEnterPriseModel.sysUserId andCreat_userIDStr:brandEnterPriseModel.sysUserId andUserIDStr:brandEnterPriseModel.sysUserId andDataSoure:brandEnterPriseModel.dataSource];
//            cargoCenterVc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:cargoCenterVc animated:YES];
//        }else{
//            //HXSC个人主页
//            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:@"" andCreat_userIDStr:brandEnterPriseModel.sysUserId andUserIDStr:brandEnterPriseModel.sysUserId];
//            cargoCenterVc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:cargoCenterVc animated:YES];
//        }
//    }
    
    [UserManger checkLogin:self successBlock:^{
        RSBrandEnterPriseModel * brandEnterPriseModel = self.companyArray[index - 10000];
        if ([brandEnterPriseModel.dataSource isEqualToString:@"DZYC"]) {
            //个人版的界面
//            NSLog(@"------------------------------");
            RSDZYCMainCargoCenterViewController * cargoCenterVc = [RSDZYCMainCargoCenterViewController suspendCenterPageVCUserModel:[UserManger getUserObject] andErpCodeStr:brandEnterPriseModel.sysUserId andCreat_userIDStr:brandEnterPriseModel.sysUserId andUserIDStr:brandEnterPriseModel.sysUserId andDataSoure:brandEnterPriseModel.dataSource];
//            cargoCenterVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
        }else{
            //HXSC个人主页
            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:[UserManger getUserObject] andErpCodeStr:@"" andCreat_userIDStr:brandEnterPriseModel.sysUserId andUserIDStr:brandEnterPriseModel.sysUserId];
//            cargoCenterVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
        }

    }];
}

- (void)jumpSearchAndDabanViewControllerIndex:(NSInteger)index{
    [UserManger checkLogin:self successBlock:^{
        RSHotStoneModel * hotStoneModel = self.stoneArray[index - 10000];
        RSSearchHuangAndDabanViewController * searchHuangAndDabanVc = [[RSSearchHuangAndDabanViewController alloc]init];
        searchHuangAndDabanVc.usermodel = self.userModel;
        searchHuangAndDabanVc.searchStr = hotStoneModel.stoneName;
        searchHuangAndDabanVc.title = hotStoneModel.stoneName;
//         searchHuangAndDabanVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchHuangAndDabanVc animated:YES]; 
    }];
    
    
    
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * VERIFYKEY = [user objectForKey:@"VERIFYKEY"];
//    if (VERIFYKEY.length < 1 ) {
//       RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//        loginVc.hidesBottomBarWhenPushed = YES;
//       [self.navigationController pushViewController:loginVc animated:YES];
//
//
//    }else{
//       RSHotStoneModel * hotStoneModel = self.stoneArray[index - 10000];
//       RSSearchHuangAndDabanViewController * searchHuangAndDabanVc = [[RSSearchHuangAndDabanViewController alloc]init];
//       searchHuangAndDabanVc.usermodel = self.userModel;
//       searchHuangAndDabanVc.searchStr = hotStoneModel.stoneName;
//       searchHuangAndDabanVc.title = hotStoneModel.stoneName;
//        searchHuangAndDabanVc.hidesBottomBarWhenPushed = YES;
//       [self.navigationController pushViewController:searchHuangAndDabanVc animated:YES];
//    }
}

@end
