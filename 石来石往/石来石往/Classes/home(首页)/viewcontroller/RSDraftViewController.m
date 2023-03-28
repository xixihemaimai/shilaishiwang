//
//  RSDraftViewController.m
//  石来石往
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSDraftViewController.h"
#import "RSCargoEngineeringCaseCell.h"
#import "RSPublishingProjectCaseViewController.h"
@interface RSDraftViewController ()<RSPublishingProjectCaseViewControllerDelegate>

//@property (nonatomic,strong)UITableView * tableview;
@property (nonatomic,assign)NSInteger projectNum;
@property (nonatomic,strong)NSMutableArray * projectArray;

@end
@implementation RSDraftViewController
- (NSMutableArray *)projectArray{
    if (!_projectArray) {
        _projectArray = [NSMutableArray array];
    }
    return _projectArray;
}

//- (UITableView *)tableview{
//    if (!_tableview) {
//        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//        CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    return _tableview;
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.title = @"工程草稿";
    [self isAddjust];
    self.projectNum = 2;
    [self.view addSubview:self.tableview];
    RSWeakself
    [self draftLoadNewData];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf draftLoadNewData];
    }];
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf draftLoadMoreNewData];
    }];
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf draftLoadNewData];
//    }];
}


- (void)draftLoadNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [phoneDict setObject:[NSString stringWithFormat:@"%d",1] forKey:@"nowPage"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"pageSize"];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:[NSString stringWithFormat:@"0"] forKey:@"status"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETPROJECTCASELIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD dismiss];
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = nil;
                array = json[@"Data"];
                [weakSelf.projectArray removeAllObjects];
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
                        [weakSelf.projectArray addObject:projectcasemodel];
                    }
                }else{
                }
                [weakSelf.tableview reloadData];
                weakSelf.projectNum = 2;
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)draftLoadMoreNewData{
    RSWeakself
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [phoneDict setObject:[NSString stringWithFormat:@"%ld",(long)self.projectNum] forKey:@"nowPage"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"pageSize"];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:[NSString stringWithFormat:@"0"] forKey:@"status"];
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
                            projectcaseimagemodel.imgId = [[tempArray objectAtIndex:i]objectForKey:@"imgId"];
                            projectcaseimagemodel.imgUrl = [[tempArray objectAtIndex:i]objectForKey:@"imgUrl"];
                            [imageArray addObject:projectcaseimagemodel];
                        }
                        projectcasemodel.CASESTONEIMG = nil;
                        projectcasemodel.IMG = imageArray;
                        [moreArray addObject:projectcasemodel];
                    }
                    [weakSelf.projectArray addObjectsFromArray:moreArray];
                }else{
                }
                [weakSelf.tableview reloadData];
                weakSelf.projectNum++;
                [weakSelf.tableview.mj_footer endRefreshing];
            }else{
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.projectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * DRAFTID = @"draftid";
    RSProjectCaseModel * projectcasemodel = self.projectArray[indexPath.row];
    RSProjectCaseImageModel * projectcaseimgemodel = projectcasemodel.IMG.lastObject;
    RSCargoEngineeringCaseCell *cell = [tableView dequeueReusableCellWithIdentifier:DRAFTID];
    if (!cell) {
        cell = [[RSCargoEngineeringCaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DRAFTID];
    }
    //    cell.textLabel.text = [NSString stringWithFormat:@"%@ section: %zd row:%zd", self.cellTitle ?: @"测试", indexPath.section, indexPath.row];
    [cell.enginerrImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",projectcaseimgemodel.imgUrl]] placeholderImage:[UIImage imageNamed:@"1080-675"]];
    cell.enginerrLabel.text = projectcasemodel.TITLE;
    cell.productLabel.text = projectcasemodel.CONTENT;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 258;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    RSProjectCaseModel * projectcasemodel = self.projectArray[indexPath.row];
  //  RSProjectCaseImageModel * projectcaseimgemodel = projectcasemodel.IMG.lastObject;
    RSPublishingProjectCaseViewController * publishingProjectCaseVc = [[RSPublishingProjectCaseViewController alloc]init];
    publishingProjectCaseVc.engineeringID = [projectcasemodel.ID integerValue];
    publishingProjectCaseVc.goodCreat = @"1";
    publishingProjectCaseVc.usermodel = self.usermodel;
    publishingProjectCaseVc.delegate = self;
    [self.navigationController pushViewController:publishingProjectCaseVc animated:YES];
}
//重新获取数据
- (void)reDraft{
    [self draftLoadNewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
