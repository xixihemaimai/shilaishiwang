//
//  RSGongChenViewController.m
//  石来石往
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSGongChenViewController.h"
//#import <UIViewController+YNPageExtend.h>
#import "RSCargoEngineeringCaseCell.h"
#import "YJFastButton.h"
#import "RSCaseProjectDetailsViewController.h"
#import "RSPublishingProjectCaseViewController.h"
#import "RSLeftViewController.h"
#import "RSProjectCaseModel.h"
#import "RSProjectCaseImageModel.h"
#import "RSEngineeringCaseViewController.h"
#import "RSCargoMainHeaderView.h"
@interface RSGongChenViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray * oweArray;
@property (nonatomic,strong)UIView * centerloadImageView;
@property (nonatomic,strong)YJFastButton * fastBtn;
/**获取工程案例列表的也是*/
@property (nonatomic,assign)NSInteger projectNum;

@end

@implementation RSGongChenViewController
- (NSMutableArray *)oweArray{
    if (!_oweArray) {
        _oweArray = [NSMutableArray array];
    }
    return _oweArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
    //removeProjectCase
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeProjectCase) name:@"removeProjectCase" object:nil];
}

static NSString * MYCARGOMAINHEAERVIEWFOOD = @"MYCARGOMAINHEAERVIEWFOOD";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self isAddjust];
    [self.view addSubview:self.tableview];
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.projectNum = 2;
    [self addTableViewRefresh];
//    [self.tableview.mj_header beginRefreshing];
    
    [self loadCargoEngineerNewData];
}

- (void)removeProjectCase{
    [self loadCargoEngineerNewData];
}

- (void)addTableViewRefresh{
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCW,SCH) style:UITableViewStyleGrouped];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableView];
//    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
//
//
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadCargoEngineerNewData];
    }];
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf loadCargoEngineerMoreNewData];
//    }];
    
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadCargoEngineerMoreNewData];
    }];
    
    
    self.centerloadImageView = [[UIView alloc]initWithFrame:CGRectMake(SCW/2 - 50, 5, 100, 100)];
    self.centerloadImageView.backgroundColor = [UIColor clearColor];
    [self.tableview addSubview:self.centerloadImageView];
    YJFastButton * fastBtn = [[YJFastButton alloc]initWithFrame:CGRectMake(0, 0, 100, 70)];
    [fastBtn setImage:[UIImage imageNamed:@"矢量智能对象1"] forState:UIControlStateNormal];
    [fastBtn setTitle:@"暂无案例" forState:UIControlStateNormal];
    [fastBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    fastBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.centerloadImageView addSubview:fastBtn];
    
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fastBtn.frame), 100, 100 - CGRectGetMaxY(fastBtn.frame))];
    [addBtn setTitle:@"增加工程案例" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#f4f4f4"].CGColor;
    addBtn.layer.borderWidth = 1;
    addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    addBtn.layer.cornerRadius = 5;
    addBtn.layer.masksToBounds = YES;
    [addBtn addTarget:self action:@selector(addCargoEngineerPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerloadImageView addSubview:addBtn];
    if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[RSLeftViewController class]]) {
        
        if (self.usermodel.appManage_gcal == 1) {
            addBtn.hidden = NO;
        }else{
            addBtn.hidden = YES;
        }
    }else{
        addBtn.hidden = YES;
    }
    if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]){
            self.centerloadImageView.hidden = NO;
    }
}

- (void)addCargoEngineerPicture:(UIButton *)addBtn{
    RSEngineeringCaseViewController * engineeringCaseVc = [[RSEngineeringCaseViewController alloc]init];
    engineeringCaseVc.usermodel = self.usermodel;
    engineeringCaseVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:engineeringCaseVc animated:YES];
    //self.hidesBottomBarWhenPushed = NO;
}

- (void)loadCargoEngineerNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    if (verifykey.length > 0) {
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        RSWeakself
            [phoneDict setObject:[NSString stringWithFormat:@"%d",1] forKey:@"nowPage"];
            [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"pageSize"];
            [phoneDict setObject:self.userIDStr forKey:@"userId"];
            [phoneDict setObject:self.erpCodeStr forKey:@"erpCode"];
            [phoneDict setObject:@"1" forKey:@"status"];
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_GETPROJECTCASELIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    [SVProgressHUD dismiss];
                    BOOL Result = [json[@"Result"] boolValue];
                    if (Result) {
                        NSMutableArray * array = nil;
                        array = json[@"Data"];
                        [weakSelf.oweArray removeAllObjects];
                        if (array.count >= 1) {
                            for (int i = 0; i < array.count; i++) {
                                RSProjectCaseModel * projectcasemodel = [[RSProjectCaseModel alloc]init];
                                projectcasemodel.CREATE_TIME = [[array objectAtIndex:i]objectForKey:@"CREATE_TIME"];
                                projectcasemodel.CONTENT = [[array objectAtIndex:i]objectForKey:@"CONTENT"];
                                projectcasemodel.ID = [[array objectAtIndex:i]objectForKey:@"ID"];
                                projectcasemodel.UPDATE_TIME = [[array objectAtIndex:i]objectForKey:@"UPDATE_TIME"];
                                projectcasemodel.TITLE = [[array objectAtIndex:i]objectForKey:@"TITLE"];
                                NSMutableArray * tempArray = [NSMutableArray array];
                                NSMutableArray * imageArray = [NSMutableArray array];
                                tempArray = [[array objectAtIndex:i]objectForKey:@"IMG"];
                                for (int j = 0; j < tempArray.count; j++) {
                                    RSProjectCaseImageModel * projectcaseimagemodel = [[RSProjectCaseImageModel alloc]init];
                                    projectcaseimagemodel.imgId = [[tempArray objectAtIndex:j]objectForKey:@"imgId"];
                                    projectcaseimagemodel.imgUrl = [[tempArray objectAtIndex:j]objectForKey:@"imgUrl"];
                                    [imageArray addObject:projectcaseimagemodel];
                                }
                                projectcasemodel.CASESTONEIMG = nil;
                                projectcasemodel.IMG = imageArray;
                                [weakSelf.oweArray addObject:projectcasemodel];
                            }
                            weakSelf.centerloadImageView.hidden = YES;
                        }else{
                            weakSelf.centerloadImageView.hidden = NO;
                        }
                        [weakSelf.tableview reloadData];
                        weakSelf.projectNum = 2;
                        [weakSelf.tableview.mj_header endRefreshing];
                    }else{
                        weakSelf.centerloadImageView.hidden = NO;
                        [weakSelf.tableview.mj_header endRefreshing];
                    }
                }else{
                    weakSelf.centerloadImageView.hidden = NO;
                    [weakSelf.tableview.mj_header endRefreshing];
                }
            }];
        }
}

- (void)loadCargoEngineerMoreNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    RSWeakself
        [phoneDict setObject:[NSString stringWithFormat:@"%ld",(long)self.projectNum] forKey:@"nowPage"];
        [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"pageSize"];
        [phoneDict setObject:self.userIDStr forKey:@"userId"];
        [phoneDict setObject:self.erpCodeStr forKey:@"erpCode"];
        [phoneDict setObject:@"1" forKey:@"status"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_GETPROJECTCASELIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                [SVProgressHUD dismiss];
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    NSMutableArray * array = nil;
                    array = json[@"Data"];
                    if (array.count >= 1) {
                        NSMutableArray * moreArray = [NSMutableArray array];
                        for (int i = 0; i < array.count; i++) {
                            RSProjectCaseModel * projectcasemodel = [[RSProjectCaseModel alloc]init];
                            projectcasemodel.CREATE_TIME = [[array objectAtIndex:i]objectForKey:@"CREATE_TIME"];
                            projectcasemodel.CONTENT = [[array objectAtIndex:i]objectForKey:@"CONTENT"];
                            projectcasemodel.ID = [[array objectAtIndex:i]objectForKey:@"ID"];
                            projectcasemodel.UPDATE_TIME = [[array objectAtIndex:i]objectForKey:@"UPDATE_TIME"];
                            projectcasemodel.TITLE = [[array objectAtIndex:i]objectForKey:@"TITLE"];
                            NSMutableArray * tempArray = [NSMutableArray array];
                            NSMutableArray * imageArray = [NSMutableArray array];
                            tempArray = [[array objectAtIndex:i]objectForKey:@"IMG"];
                            for (int j = 0; j < tempArray.count; j++) {
                                RSProjectCaseImageModel * projectcaseimagemodel = [[RSProjectCaseImageModel alloc]init];
                                projectcaseimagemodel.imgId = [[tempArray objectAtIndex:j]objectForKey:@"imgId"];
                                projectcaseimagemodel.imgUrl = [[tempArray objectAtIndex:j]objectForKey:@"imgUrl"];
                                [imageArray addObject:projectcaseimagemodel];
                            }
                            projectcasemodel.CASESTONEIMG = nil;
                            projectcasemodel.IMG = imageArray;
                            [moreArray addObject:projectcasemodel];
                        }
                        [weakSelf.oweArray addObjectsFromArray:moreArray];
                        if (weakSelf.oweArray.count > 0) {
                            weakSelf.centerloadImageView.hidden = YES;
                        }else{
                            weakSelf.centerloadImageView.hidden = NO;
                        }
                        weakSelf.projectNum++;
                    }else{
                        if (weakSelf.oweArray.count > 0) {
                            weakSelf.centerloadImageView.hidden = YES;
                        }else{
                            weakSelf.centerloadImageView.hidden = NO;
                        }
                    }
                    [weakSelf.tableview reloadData];
                    [weakSelf.tableview.mj_footer endRefreshing];
                }else{
                    if (weakSelf.oweArray.count > 0) {
                        weakSelf.centerloadImageView.hidden = YES;
                    }else{
                        weakSelf.centerloadImageView.hidden = NO;
                    }
                    [weakSelf.tableview.mj_footer endRefreshing];
                }
            }else{
                if (weakSelf.oweArray.count > 0) {
                    weakSelf.centerloadImageView.hidden = YES;
                }else{
                    weakSelf.centerloadImageView.hidden = NO;
                }
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.oweArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 254;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[RSLeftViewController class]]) {
        if (self.oweArray.count > 0) {
            if (self.usermodel.appManage_gcal == 1) {
                return 38;
            }else{
                return 0.01;
            }
        }else{
            return 0.01;
        }
    }else{
        return 0.01;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *RSCARGOENGINEERINGCASECELL = @"RSCargoEngineeringCaseCell";
    RSProjectCaseModel * projectCasemodel = self.oweArray[indexPath.row];
    RSProjectCaseImageModel * projectcaseimgemodel = projectCasemodel.IMG.lastObject;
    RSCargoEngineeringCaseCell *cell = [tableView dequeueReusableCellWithIdentifier:RSCARGOENGINEERINGCASECELL];
    if (!cell) {
        cell = [[RSCargoEngineeringCaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSCARGOENGINEERINGCASECELL];
    }
    [cell.enginerrImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",projectcaseimgemodel.imgUrl]] placeholderImage:[UIImage imageNamed:@"1080-675"]];
    cell.enginerrLabel.text = projectCasemodel.TITLE;
    cell.productLabel.text = projectCasemodel.CONTENT;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSProjectCaseModel * projectcasemodel = self.oweArray[indexPath.row];
        RSCaseProjectDetailsViewController * caseProjectVc = [[RSCaseProjectDetailsViewController alloc]init];
        caseProjectVc.ID = projectcasemodel.ID;
        caseProjectVc.usermodel = self.usermodel;
        [self.navigationController pushViewController:caseProjectVc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    RSCargoMainHeaderView * carMainFootView = [[RSCargoMainHeaderView alloc]initWithReuseIdentifier:MYCARGOMAINHEAERVIEWFOOD];
    if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[RSLeftViewController class]]) {
        if (self.oweArray.count > 0) {
            if (self.usermodel.appManage_gcal == 1) {
                carMainFootView.addBtn.hidden = NO;
            }else{
                carMainFootView.addBtn.hidden = YES;
            }
        }else{
            carMainFootView.addBtn.hidden = YES;
        }
    }else{
        carMainFootView.addBtn.hidden = YES;
    }
        [carMainFootView.addBtn addTarget:self action:@selector(addNewCargoMain:) forControlEvents:UIControlEventTouchUpInside];
    return carMainFootView;
}

- (void)addNewCargoMain:(UIButton *)add{
    RSEngineeringCaseViewController * engineeringCaseVc = [[RSEngineeringCaseViewController alloc]init];
    engineeringCaseVc.usermodel = self.usermodel;
    engineeringCaseVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:engineeringCaseVc animated:YES];
   // self.hidesBottomBarWhenPushed = NO;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return false;
}


@end
