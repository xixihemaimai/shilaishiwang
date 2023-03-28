//
//  RSRecordViewController.m
//  石来石往
//
//  Created by mac on 17/7/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSRecordViewController.h"
#import "RSShipmentModel.h"
#import "RSShippingCell.h"

#import <MJRefresh.h>
#import "RSRecordDetailViewController.h"

//撤销记录
#import "RSRevokeProgressViewController.h"

@interface RSRecordViewController ()

@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic,strong)NSMutableArray * allArray;

@end

@implementation RSRecordViewController

- (NSMutableArray *)allArray{
    if (_allArray == nil) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reout) name:@"reout" object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 去掉添加的额外内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置tableView的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    //添加下来刷新和上拉加载更多
    [self setupRefreshView];
}
// 返回请求数据的类型
- (YJTopicType)type
{
    // 基类里随便返回一个值
    return 5;
}

- (RSUserModel *)usermodel{
    return nil;
}

#pragma mark - 添加下拉刷新和上拉加载更多view
- (void)setupRefreshView
{
    // 下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNetWorkData];
    }];
    // 程序一启动自动刷新
    [self.tableView.mj_header beginRefreshing];
//    // 上拉加载更多控件
//    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
//        
//    }];
//    
}

- (void)reout{
    
    [self.tableView.mj_header beginRefreshing];
    
}


#pragma mark -- 获取网络
- (void)getNetWorkData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
   // [dict setObject:[user objectForKey:@"userID"] forKey:@"userId"];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    //URL_OUTSTORE_HISTORY_IOS URL_OUTSTORE_HISTORY
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_OUTSTORE_HISTORY_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = nil;
                array = json[@"Data"];
                if (array.count == 0 ) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"没有数据出来" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:actionConfirm];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alert.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [weakSelf presentViewController:alert animated:YES completion:nil];

                }else{
                    [weakSelf.dataArray removeAllObjects];
                    [weakSelf.allArray removeAllObjects];
                    //NSInteger status = [json[@"outstoreStatus"] integerValue];
                    for (int i = 0; i < array.count; i++) {
                        RSShipmentModel * shipModel = [[RSShipmentModel alloc]init];
                        shipModel.outstoreStatus = [[[array objectAtIndex:i] objectForKey:@"outstoreStatus"] integerValue];
                        shipModel.outstoreDate = [[array objectAtIndex:i]objectForKey:@"outstoreDate"];
                        shipModel.outstoreId = [[array objectAtIndex:i]objectForKey:@"outstoreId"];
                        shipModel.csnPhone = [[array objectAtIndex:i]objectForKey:@"csnPhone"];
                        shipModel.csnName = [[array objectAtIndex:i]objectForKey:@"csnName"];
                        shipModel.isCancel = [[[array objectAtIndex:i]objectForKey:@"isCancel"]boolValue];
                        shipModel.serviceStatus = [[[array objectAtIndex:i]objectForKey:@"serviceStatus"] integerValue];
                        shipModel.cancelStatus = [[array objectAtIndex:i]objectForKey:@"cancelStatus"];
                        if (shipModel.outstoreStatus == self.type) {
                            [weakSelf.dataArray addObject:shipModel];
                        }
                        //这边是所有的模型，是在全部的界面里面
                        [weakSelf.allArray addObject:shipModel];
                    }
                }
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header endRefreshing];
            }else{
                [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
            }
        }else{
            [weakSelf.tableView.mj_header endRefreshing];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type == 5) {
        return self.allArray.count;
    }else{
       return self.dataArray.count; 
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * shippingID = @"shippingcell";
    RSShippingCell * cell = [tableView dequeueReusableCellWithIdentifier:shippingID];
    if (!cell) {
        cell = [[RSShippingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:shippingID];
    }
    cell.cancelBtn.tag = indexPath.row;
    [cell.cancelBtn addTarget:self action:@selector(cancelOutBoundAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.type == 5) {
        RSShipmentModel * shipModel = self.allArray[indexPath.row];
        if (shipModel.outstoreStatus == -1) {
            cell.detailStatusLabel.text = @"已失效";
            cell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#afd450"];
            cell.cancelBtn.hidden = YES;
        }
        if (shipModel.outstoreStatus == 2) {
            if (shipModel.isCancel == 0) {
                cell.detailStatusLabel.text = @"审核中";
                cell.cancelBtn.hidden = YES;
            }else{
                cell.detailStatusLabel.text = @"审核中";
                cell.cancelBtn.hidden = YES;
            }
            cell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#fbc376"];
        }
        if (shipModel.outstoreStatus == 3) {
            if (shipModel.isCancel == 0) {
                cell.detailStatusLabel.text = @"待发货";
                cell.cancelBtn.hidden = YES;
            }else{
                cell.detailStatusLabel.text = @"待发货";
                cell.cancelBtn.hidden = YES;
            }
            cell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#afd9ff"];
        }
        if (shipModel.outstoreStatus == 4) {
            cell.detailStatusLabel.text = @"部分发货";
            cell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#a4d4c8"];
            cell.cancelBtn.hidden = YES;
        }
        if (shipModel.outstoreStatus == 0) {
            cell.detailStatusLabel.text = @"已完成";
            cell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#e52c32"];
            cell.cancelBtn.hidden = YES;
        }
        cell.detailLibraryLabel.text = [NSString stringWithFormat:@"%@",shipModel.outstoreId];
        cell.detailDateLabel.text = [NSString stringWithFormat:@"%@",shipModel.outstoreDate];
    }else{
        RSShipmentModel * shipModel = self.dataArray[indexPath.row];
        if (shipModel.outstoreStatus == -1) {
            cell.detailStatusLabel.text = @"已失效";
            cell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#afd450"];
            cell.cancelBtn.hidden = YES;
        }
        if (shipModel.outstoreStatus == 2) {
            if (shipModel.isCancel == 0) {
                cell.detailStatusLabel.text = @"审核中";
                cell.cancelBtn.hidden = NO;
                [cell.cancelBtn setTitle:@"撤销出库" forState:UIControlStateNormal];
            }else{
                cell.detailStatusLabel.text = @"审核中";
                cell.cancelBtn.hidden = NO;
                 [cell.cancelBtn setTitle:@"撤销记录" forState:UIControlStateNormal];
            }
            cell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#fbc376"];
        }
        if (shipModel.outstoreStatus == 3) {
            if (shipModel.isCancel == 0) {
                cell.detailStatusLabel.text = @"待发货";
                cell.cancelBtn.hidden = NO;
                [cell.cancelBtn setTitle:@"撤销出库" forState:UIControlStateNormal];
            }else{
                cell.detailStatusLabel.text = @"待发货";
                cell.cancelBtn.hidden = NO;
                 [cell.cancelBtn setTitle:@"撤销记录" forState:UIControlStateNormal];
            }
            cell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#afd9ff"];
        }
        if (shipModel.outstoreStatus == 4) {
            cell.detailStatusLabel.text = @"部分发货";
            cell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#a4d4c8"];
            cell.cancelBtn.hidden = YES;
        }
        if (shipModel.outstoreStatus == 0) {
            cell.detailStatusLabel.text = @"已完成";
            cell.detailStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#e52c32"];
            cell.cancelBtn.hidden = YES;
        }
        cell.detailLibraryLabel.text = [NSString stringWithFormat:@"%@",shipModel.outstoreId];
        cell.detailDateLabel.text = [NSString stringWithFormat:@"%@",shipModel.outstoreDate];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  //cell.shipModel = shipModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 5) {
        //全部
        RSShipmentModel  * shipMentmodel = self.allArray[indexPath.row];
        RSRecordDetailViewController * recordDetailVc = [[RSRecordDetailViewController alloc]init];
        recordDetailVc.outBoundNo = shipMentmodel.outstoreId;
        recordDetailVc.usermodel = self.usermodel;
        recordDetailVc.cancelStatus = shipMentmodel.cancelStatus;
        [self.navigationController pushViewController:recordDetailVc animated:YES];
    }else{
        //其他类型
        RSShipmentModel  * shipMentmodel = self.dataArray[indexPath.row];
        RSRecordDetailViewController * recordDetailVc = [[RSRecordDetailViewController alloc]init];
        recordDetailVc.usermodel = self.usermodel;
        recordDetailVc.outBoundNo = shipMentmodel.outstoreId;
        recordDetailVc.cancelStatus = shipMentmodel.cancelStatus;
        recordDetailVc.cancelStatus = shipMentmodel.cancelStatus;
        [self.navigationController pushViewController:recordDetailVc animated:YES];
    }
}

- (void)cancelOutBoundAction:(UIButton *)cancelBtn{
    //只有审核中和待发货才能点击
    RSShipmentModel  * shipMentmodel = self.dataArray[cancelBtn.tag];
    if (shipMentmodel.serviceStatus == 1) {
//        [SVProgressHUD showErrorWithStatus:@"已发起服务的出库单无法发起撤销出库"];
        
        [JHSysAlertUtil presentAlertViewWithTitle:@"已发起服务的出库单无法发起撤销出库" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            
        } confirm:^{
            
        }];
        
        
        
    }else{
        if ([cancelBtn.currentTitle isEqualToString:@"撤销记录"]) {
            RSRevokeProgressViewController * revokeProgressVc = [[RSRevokeProgressViewController alloc]init];
            revokeProgressVc.outBoundNo = shipMentmodel.outstoreId;
            revokeProgressVc.cancelStatus = ^(BOOL isstatius) {
                [self.tableView.mj_header beginRefreshing];
            };
            
            [self.navigationController pushViewController:revokeProgressVc animated:YES];
            
              
        }else{
            RSWeakself
            [JHSysAlertUtil presentAlertViewWithTitle:@"是否撤销出库" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
                } confirm:^{
                    //网络请求
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
                //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    // [dict setObject:[user objectForKey:@"userID"] forKey:@"userId"];
            //        [dict setValue:verifyKey forKey:@"VerifyKey"];
            //        if (self.type == 5) {
            //              //全部
            //
            //              [dict setValue:shipMentmodel.outstoreId forKey:@"Data"];
            //          }else{
            //              //其他类型
            //              RSShipmentModel  * shipMentmodel = self.dataArray[cancelBtn.tag];
            //              [dict setValue:shipMentmodel.outstoreId forKey:@"Data"];
            //          }
                   //  NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
                  //   NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                     AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    NSDictionary *parameters = [NSDictionary dictionary];
                    if (self.type == 5) {
                        RSShipmentModel  * shipMentmodel = self.allArray[cancelBtn.tag];
                        parameters = @{@"key":[NSString get_uuid] ,@"Data":shipMentmodel.outstoreId,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                    }else{
                        RSShipmentModel  * shipMentmodel = self.dataArray[cancelBtn.tag];
                        parameters = @{@"key":[NSString get_uuid] ,@"Data":shipMentmodel.outstoreId,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                    }
                     //URL_OUTSTORE_HISTORY_IOS URL_OUTSTORE_HISTORY
                     XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                    [network getDataWithUrlString:URL_APPLYCANCEL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                        if (success) {
                            BOOL Result = [json[@"success"] boolValue];
                            if (Result) {
                                RSShippingCell * cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:cancelBtn.tag inSection:0]];
                                [cell.cancelBtn setTitle:@"撤销记录" forState:UIControlStateNormal];
                                cell.cancelBtn.hidden = NO;
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"撤销申请失败"];
                            }
                        }else{
                              [SVProgressHUD showErrorWithStatus:@"撤销申请失败"];
                        }
                    }];
                }];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82;
}



- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
