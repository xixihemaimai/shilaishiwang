//
//  RSWasteMaterialViewController.m
//  石来石往
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "RSWasteMaterialViewController.h"
#import <MJRefresh.h>
#import "RSPictureViewController.h"
#import "RSMaterialHeaderview.h"
#import "RSDetailStoneHouseCell.h"
#import "RSMasteMainModel.h"
#import "RSMasteDetailModel.h"
#import "RSWasteMaterialHeaderView.h"
#import "RSWasteMaterialCell.h"
//<UITableViewDelegate,UITableViewDataSource>
@interface RSWasteMaterialViewController ()
//页数
@property (nonatomic,assign)NSInteger pageNum;
//控件
//@property (nonatomic,strong)UITableView * tableview;
/**有多少组*/
@property (nonatomic,strong)NSMutableArray *MoreArr;
/**保存存储位置*/
@property (nonatomic,strong)NSString * tempStr;

@end

@implementation RSWasteMaterialViewController
- (NSMutableArray *)MoreArr{
    if (_MoreArr == nil) {
        _MoreArr = [NSMutableArray array];
    }
    return _MoreArr;
}

static  NSInteger newWasteSection = nil;
static NSString *MATERHEADID = @"materheaderid";
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isAddjust];
    [self.view addSubview:self.tableview];
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    //仓储位置
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    for (int i = 1; i <= 10; i++) {
//        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
//        [mDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"name"];
//        [self.MoreArr addObject:mDic];
//        [self.tempMArray addObject:@"0"];
//    }
//    if (iPhone4 || iPhone5) {
//        self.title = @"仓库位置";
//    }else{
    self.title = _titleNameLabel;
//    }
    self.pageNum = 2;
    //添加tableview
    [self addCustomTableview];
    //获取数据
    [self loadWasteNewData];
}

//下拉
- (void)loadWasteNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if ([self.dataSource isEqualToString:@"DZYC"]) {
        [dict setObject:self.dataSource forKey:@"dataSource"];
    }
    
    [dict setObject:self.erpCodeStr forKey:@"erpCode"];
   // [dict setObject:@"0" forKey:@"userId"];
    [dict setObject:self.tyle forKey:@"type"];
    [dict setObject:@"1" forKey:@"erpId"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //POST参数
    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_STOCK_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if(Result){
                [weakSelf.MoreArr removeAllObjects];
                weakSelf.MoreArr = [RSMasteMainModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
//                for (RSMasteMainModel * mastemainmodel in weakSelf.MoreArr) {
//                    _tempStr = mastemainmodel.storeArea;
//                }
                [self.tableview reloadData];
                [self.tableview.mj_header endRefreshing];
            }else{
                [self.tableview.mj_header endRefreshing];
            }
        }else{
            [SVProgressHUD dismiss];
            [self.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)addCustomTableview{
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Y, SCW, SCH - Y) style:UITableViewStylePlain];
//    self.tableview = tableview;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.dataSource = self;
//    self.tableview.delegate = self;
//    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
//    [self.view addSubview:self.tableview];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn bringSubviewToFront:self.view];
    [btn setImage:[UIImage imageNamed:@"地图"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(selcetMap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.sd_layout
    .rightSpaceToView(self.view, 12)
    .bottomSpaceToView(self.view, 64)
    .widthIs(50)
    .heightIs(50);
    //下拉
     RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadWasteNewData];
    }];
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf loadWasteNewData];
//    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.MoreArr.count;
   // return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSWasteMaterialHeaderView * wasteMaterialHeader = [[RSWasteMaterialHeaderView alloc]initWithReuseIdentifier:MATERHEADID];
    wasteMaterialHeader.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#CDE1FF"];
     RSMasteMainModel * masteMainModel  = self.MoreArr[section];
    wasteMaterialHeader.addressInformationLabel.text = masteMainModel.storeArea;
    return wasteMaterialHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    newWasteSection = section;
     RSMasteMainModel * masteMainModel  = self.MoreArr[newWasteSection];
     RSMasteMainModel * masteMainModel1 = [[RSMasteMainModel alloc]init];
    if (newWasteSection > 0) {
        // mySecondTimeModel = self.oweArray[section-1];
        masteMainModel1 = self.MoreArr[newWasteSection - 1];
    }
    if ([masteMainModel1.storeArea isEqualToString:masteMainModel.storeArea]) {
        return 0;
    }else{
        return 34;
    }
    /**
     newSection = section;
     RSHuangAndDaModel * huangAndDamodel = self.showArray[newSection];
     RSHuangAndDaModel * AhuangAndDamodel = [[RSHuangAndDaModel alloc]init];
     if (newSection > 0) {
     AhuangAndDamodel = self.showArray[newSection-1];
     }
     if ([huangAndDamodel.companyId isEqualToString:AhuangAndDamodel.companyId]) {
     return 0.1;
     }else{
     return 38;
     }
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * detailMaterialID = @"detailMaterialID";
    RSWasteMaterialCell * cell = [tableView dequeueReusableCellWithIdentifier:detailMaterialID];
    if (!cell) {
        cell = [[RSWasteMaterialCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detailMaterialID];
    }
    RSMasteMainModel * masteMainModel  = self.MoreArr[indexPath.section];
    cell.masteMainModel = masteMainModel;
    if ([self.tyle isEqualToString:@"huangliao"]) {
        cell.areaLabel.text = [NSString stringWithFormat:@"%@m³",masteMainModel.stoneTotalMessage];
        cell.numberLabel.text = masteMainModel.stoneNum;
    }else{
        cell.areaLabel.text = [NSString stringWithFormat:@"%@m²",masteMainModel.stoneTotalMessage];
        cell.numberLabel.text = [NSString stringWithFormat:@"%@片",masteMainModel.stoneNum];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)selcetMap:(UIButton *)btn{
    if ([self.tyle isEqualToString:@"huangliao"]) {
        //荒料的地图
        RSPictureViewController * pictureVc = [[RSPictureViewController alloc]init];
        pictureVc.mtypeStr = @"0";
        pictureVc.titleStr = @"荒料界面显示图片";
        [self.navigationController pushViewController:pictureVc animated:YES];
    }else{
        //大板的地图
        RSPictureViewController * pictureVc = [[RSPictureViewController alloc]init];
        pictureVc.mtypeStr = @"1";
        pictureVc.titleStr = @"大板界面显示图片";
        [self.navigationController pushViewController:pictureVc animated:YES];
    }
}



//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
