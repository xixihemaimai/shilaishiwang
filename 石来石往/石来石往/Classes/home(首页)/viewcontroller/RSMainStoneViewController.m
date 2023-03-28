//
//  RSMainStoneViewController.m
//  石来石往
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSMainStoneViewController.h"
#import "ZKImgRunLoopView.h"


#import "RSMainStoneHeaderView.h"
#import "RSMainStoneCell.h"
#import "RSStonePictureMangerViewController.h"


#import "RSDetailSegmentModel.h"
#import "RSLeftViewController.h"
@interface RSMainStoneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSString * searchType;

@property (nonatomic,strong)ZKImgRunLoopView *imgRunView;


@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,strong)NSMutableArray * mainStoneArray;

@end

@implementation RSMainStoneViewController

- (NSMutableArray *)mainStoneArray{
    if (!_mainStoneArray) {
        _mainStoneArray = [NSMutableArray array];
    }
    return _mainStoneArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchType = @"huangliao";
    
    //创建头部视图
    [self setUIMainStoneView];
    //创建底部视图
    [self setUIUITableview];
    
    
    [self loadDetailNewData];
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}


- (void)setUIMainStoneView{
    ZKImgRunLoopView *imgRunView = [[ZKImgRunLoopView alloc] initWithFrame:CGRectMake(0, 0, SCW, 224) placeholderImg:[UIImage imageNamed:@"01"]];
    imgRunView.pageControl.hidden = NO;
    [self.view addSubview:imgRunView];
    imgRunView.pageControl.PageControlStyle = JhPageControlContentModeLeft;
    imgRunView.pageControl.PageControlStyle = JhPageControlStyelRectangle;
    imgRunView.pageControl.currentColor = [UIColor whiteColor];
    imgRunView.pageControl.otherColor = [UIColor colorWithHexColorStr:@"#f7f7f7" alpha:0.4];
    imgRunView.pageControl.controlSpacing = 10;
    [imgRunView.imgUrlArray addObjectsFromArray:self.photos];
    _imgRunView = imgRunView;
    //这边是点击每个广告图片要跳转的位置
    [imgRunView  touchImageIndexBlock:^(NSInteger index) {
        
        
    }];
    UIButton * backImageBtn = [[UIButton alloc]init];
    //backImageBtn.image = [UIImage imageNamed:@"返回"];
    //backImageBtn.alpha = 0.5;
    [backImageBtn setImage:[UIImage imageNamed:@"上一页"] forState:UIControlStateNormal];
    backImageBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 11, 6, 11);
    [backImageBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#000000" alpha:0.5]];
    [backImageBtn addTarget:self action:@selector(backUpCargoMainVc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backImageBtn];
    [backImageBtn bringSubviewToFront:self.view];
    
    backImageBtn.sd_layout
    .leftSpaceToView(self.view, 13)
    .topSpaceToView(self.view, 31)
    .widthIs(32)
    .heightEqualToWidth();
    backImageBtn.layer.cornerRadius = backImageBtn.yj_width * 0.5;
    backImageBtn.layer.masksToBounds = YES;
    
    //石材编辑
    UIButton * editBtn = [[UIButton alloc]init];
    [editBtn setImage:[UIImage imageNamed:@"石材编辑"] forState:UIControlStateNormal];
    // editBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 11, 6, 11);
    // [editBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#000000" alpha:0.5]];
    [editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editBtn];
    [editBtn bringSubviewToFront:self.view];
    
    editBtn.sd_layout
    .rightSpaceToView(self.view, 12)
    .topSpaceToView(self.view, 30)
    .widthIs(34)
    .heightEqualToWidth();
    if ([[self.navigationController.viewControllers objectAtIndex:0]isKindOfClass:[RSLeftViewController class]]) {
        if (self.usermodel.appManage_tppp == 1) {
            editBtn.hidden = NO;
        }else{
            editBtn.hidden = YES;
        }
    }else{
        editBtn.hidden = YES;
    }
}


- (void)setUIUITableview{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgRunView.frame), SCW, SCH - CGRectGetMaxY(self.imgRunView.frame)) style:UITableViewStylePlain];
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDetailNewData];
    }];

    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
        [weakSelf loadDetailNewData];
    }];
}


- (void)loadDetailNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"-1" forKey:@"width_filter"];
    [dict setObject:@"-1" forKey:@"height_filter"];
    [dict setObject:@"-1" forKey:@"length_filter"];
    [dict setObject:@"-1" forKey:@"width"];
    [dict setObject:@"-1" forKey:@"height"];
    [dict setObject:@"-1" forKey:@"length"];
    [dict setObject:@"-1" forKey:@"volume_filter"];
    [dict setObject:@"-1" forKey:@"volume"];
//    [dict setObject:[NSString stringWithFormat:@"%@",self.companyName] forKey:@"companyName"];
    
    [dict setObject:[NSString stringWithFormat:@"%@%@",self.dataSource,self.erpCode] forKey:@"companyName"];
    
    [dict setObject:[NSString stringWithFormat:@"%@",self.stoneName] forKey:@"stoneName"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.usermodel.userCode] forKey:@"userId"];
    [dict setObject:@"" forKey:@"blockId"];
    [dict setObject:self.searchType forKey:@"search_type"];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //URL_SEARCHDETAIL
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_SEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
               [weakSelf.mainStoneArray removeAllObjects];
                weakSelf.mainStoneArray = [RSDetailSegmentModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return self.mainStoneArray.count;
}

static NSString * MAINSTONEHEADID = @"MAINSTONEHEADID";
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSMainStoneHeaderView * mainStoneHeader = [[RSMainStoneHeaderView alloc]initWithReuseIdentifier:MAINSTONEHEADID];
    mainStoneHeader.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    if ([self.searchType isEqualToString:@"huangliao"]) {
        [mainStoneHeader.huangliaoBtn setTitle:[NSString stringWithFormat:@"荒料(%ld)",self.mainStoneArray.count] forState:UIControlStateNormal];
        [mainStoneHeader.huangliaoBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        mainStoneHeader.huangliaoView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
        [mainStoneHeader.dabanBtn setTitle:@"大板" forState:UIControlStateNormal];
        [mainStoneHeader.dabanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        mainStoneHeader.dabanView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
        
        mainStoneHeader.huangliaoView.sd_layout
        .heightIs(2)
        .bottomSpaceToView(mainStoneHeader.CurrentView, 0);
        
        mainStoneHeader.dabanView.sd_layout
        .heightIs(1)
        .bottomSpaceToView(mainStoneHeader.CurrentView, 0);
    }else{
    
        [mainStoneHeader.huangliaoBtn setTitle:@"荒料" forState:UIControlStateNormal];
        [mainStoneHeader.huangliaoBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
        mainStoneHeader.huangliaoView.backgroundColor = [UIColor colorWithHexColorStr:@"#999999"];
        [mainStoneHeader.dabanBtn setTitle:[NSString stringWithFormat:@"大板(%ld)",self.mainStoneArray.count] forState:UIControlStateNormal];
        [mainStoneHeader.dabanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
        mainStoneHeader.dabanView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
        
        mainStoneHeader.huangliaoView.sd_layout
        .heightIs(1)
        .bottomSpaceToView(mainStoneHeader.CurrentView, 0);
        
        mainStoneHeader.dabanView.sd_layout
        .heightIs(2)
        .bottomSpaceToView(mainStoneHeader.CurrentView, 0);
    }
    
    
    [mainStoneHeader.huangliaoBtn addTarget:self action:@selector(changeHuangliaoSelectColor:) forControlEvents:UIControlEventTouchUpInside];
     [mainStoneHeader.dabanBtn addTarget:self action:@selector(changedabanSelectColor:) forControlEvents:UIControlEventTouchUpInside];
    return mainStoneHeader;
}


- (void)changeHuangliaoSelectColor:(UIButton *)huangliaoBtn{

    self.searchType = @"huangliao";
    [self loadDetailNewData];
    
}

- (void)changedabanSelectColor:(UIButton *)dabanBtn{

    self.searchType = @"daban";
    [self loadDetailNewData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * MAINSTONECELLID = @"MAINSTONECELLID";
    RSMainStoneCell * cell = [tableView dequeueReusableCellWithIdentifier:MAINSTONECELLID];
    if (!cell) {
        cell =  [[RSMainStoneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MAINSTONECELLID];
    }
    cell.mainStoneCollectionBtn.tag = indexPath.row;
    [cell.mainStoneCollectionBtn addTarget:self action:@selector(changeCollectionStatus:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RSDetailSegmentModel * detailModel = self.mainStoneArray[indexPath.row];
    //这边要获取模型
    if (detailModel.isCollect == 0) {
        self.isSelect = NO;
    }else{
        self.isSelect = YES;
    }
    if (self.isSelect == YES) {
        cell.mainStoneCollectionBtn.selected = YES;
        [cell.mainStoneCollectionBtn setImage:[UIImage imageNamed:@"nh-拷贝"] forState:UIControlStateNormal];
    }else{
        cell.mainStoneCollectionBtn.selected = NO;
        [cell.mainStoneCollectionBtn setImage:[UIImage imageNamed:@"nh-拷贝-2"] forState:UIControlStateNormal];
    }
    
    if (indexPath.row < 9) {
        cell.mainStoneNumberLabel.text = [NSString stringWithFormat:@"0%ld",(long)indexPath.row+1];
    }else{
        cell.mainStoneNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    }
    cell.huangliaoLabel.text = [NSString stringWithFormat:@"荒料号:%@",detailModel.stoneId];
    cell.ruleLabel.text = [NSString stringWithFormat:@"规  格:%@",detailModel.stoneMessage];
    if ([self.searchType isEqualToString:@"huangliao"]) {
        cell.areaLabel.text = [NSString stringWithFormat:@"体  积:%@m³",detailModel.stoneVolume];
        cell.weightLabel.text = [NSString stringWithFormat:@"重  量:%@吨",detailModel.stoneWeight];
    }else{
        cell.weightLabel.text = [NSString stringWithFormat:@"匝号:%@",detailModel.stoneturnsno];
        cell.areaLabel.text = [NSString stringWithFormat:@"面  积:%@m²",detailModel.stoneVolume];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79;
}

- (void)changeCollectionStatus:(UIButton *)mainStoneCollectionBtn{
    RSDetailSegmentModel *detailModel = self.mainStoneArray[mainStoneCollectionBtn.tag];
    //收藏
    if ([mainStoneCollectionBtn.currentImage isEqual:[UIImage imageNamed:@"nh-拷贝-2"]]) {
        if (detailModel.isCollect != 1) {
            //这边还要加模型的状态变成1
            self.isSelect = YES;
            [self collectProduct:detailModel andNSString:@"add" andUIButton:mainStoneCollectionBtn];
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        }
    }else{
        //取消收藏
        if (detailModel.isCollect == 1) {
            //这边还要把模型的状态变成0
            self.isSelect = NO;
            [self collectProduct:detailModel andNSString:@"del" andUIButton:mainStoneCollectionBtn];
            [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
        }
    }
}


#pragma mark -- 收藏和取消收藏的方法
- (void)collectProduct:(RSDetailSegmentModel *)detailModel andNSString:(NSString *)add andUIButton:(UIButton *)btn{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%@",detailModel.collectionID] forKey:@"collectionID"];
    [dict setObject:[NSString stringWithFormat:@"%@",add] forKey:@"operationType"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.usermodel.userID] forKey:@"userId"];
   // [dict setObject:[NSString stringWithFormat:@"%@",@"HxStock"] forKey:@"collType"];
    if ([self.dataSource isEqualToString:@"HXSC"]) {
        [dict setObject:[NSString stringWithFormat:@"%@",@"HXSC"] forKey:@"collType"];
    }else{
        [dict setObject:[NSString stringWithFormat:@"%@",@"DZYC"] forKey:@"collType"];
    }
    [dict setObject:[NSString stringWithFormat:@"%@",detailModel.stoneblno] forKey:@"stoneblno"];
    [dict setObject:[NSString stringWithFormat:@"%@",detailModel.stoneturnsno] forKey:@"stoneturnsno"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"erpId"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    // URL_COLLECTION
    [network getDataWithUrlString:URL_HEADER_TEXT_STONECO_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                if (detailModel.isCollect == 0) {
                    detailModel.isCollect = 1;
                    detailModel.collectionID = json[@"collectionID"];
                    [btn setImage:[UIImage imageNamed:@"nh-拷贝"] forState:UIControlStateNormal];
                    [weakSelf.mainStoneArray replaceObjectAtIndex:btn.tag withObject:detailModel];
                }else{
                    detailModel.isCollect = 0;
                    detailModel.collectionID = json[@"collectionID"];
                    [btn setImage:[UIImage imageNamed:@"nh-拷贝-2"] forState:UIControlStateNormal];
                    [weakSelf.mainStoneArray replaceObjectAtIndex:btn.tag withObject:detailModel];
                }
            }
        }
    }];
}



- (void)backUpCargoMainVc:(UIButton *)backImageBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editBtnAction:(UIButton *)editBtn{
    if (self.usermodel.appManage_tppp == 1) {
        RSStonePictureMangerViewController * stonePictureManagerVc = [[RSStonePictureMangerViewController alloc]init];
        stonePictureManagerVc.userModel = self.usermodel;
        [self.navigationController pushViewController:stonePictureManagerVc animated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:@"你没有这个权限"];
    }
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
