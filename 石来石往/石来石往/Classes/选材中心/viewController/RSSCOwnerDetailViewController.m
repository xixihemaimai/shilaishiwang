//
//  RSSCOwnerDetailViewController.m
//  石来石往
//
//  Created by mac on 2021/10/28.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSSCOwnerDetailViewController.h"
#import "RSSCOwnerCell.h"

#import "RSSCContentModel.h"
#import "RSLocationModel.h"

#import "RSSCCompanyViewController.h"

#import "RSOwnerStoneModel.h"


@interface RSSCOwnerDetailViewController ()

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * scStoneNameArray;


@end

@implementation RSSCOwnerDetailViewController
-(NSMutableArray *)scStoneNameArray{
    if (!_scStoneNameArray) {
        _scStoneNameArray = [NSMutableArray array];
    }
    return _scStoneNameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.pageNum = 1;
//    self.tableview.frame = CGRectMake(0, Height_NavBar, SCW, SCH - Height_NavBar);
//    self.title = @"货品名称";
    [self.tableview registerClass:[RSSCOwnerCell class] forCellReuseIdentifier:@"OWNER"];
    
//    [self loadSCContentStoneNamePageSize:10 andIsHead:true];
    
    if ([self.title isEqualToString:@"大板"] || [self.title isEqualToString:@"荒料"]) {
        [self newStoneSearchPageSize:10 andIsHead:true andStoneName:self.stoneName];
    }else{
        [self loadSCContentStoneNamePageSize:10 andIsHead:true andEnterpriseId:self.enterpriseId andStoneName:self.stoneName andStoneType:self.stoneType];
    }
   
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([weakSelf.title isEqualToString:@"大板"] || [weakSelf.title isEqualToString:@"荒料"]) {
            [weakSelf newStoneSearchPageSize:10 andIsHead:true andStoneName:self.stoneName];
        }else{
            [weakSelf loadSCContentStoneNamePageSize:10 andIsHead:true andEnterpriseId:weakSelf.enterpriseId andStoneName:weakSelf.stoneName andStoneType:weakSelf.stoneType];
        }
    }];
    

    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        if ([weakSelf.title isEqualToString:@"大板"] || [weakSelf.title isEqualToString:@"荒料"]) {
            [weakSelf newStoneSearchPageSize:10 andIsHead:false andStoneName:self.stoneName];
        }else{
            [weakSelf loadSCContentStoneNamePageSize:10 andIsHead:false andEnterpriseId:weakSelf.enterpriseId andStoneName:weakSelf.stoneName andStoneType:weakSelf.stoneType];
        }
    }];
}

//URL_SelectionCenter_StoneName_IOS
- (void)loadSCContentStoneNamePageSize:(NSInteger)pageSize andIsHead:(BOOL)isHead andEnterpriseId:(NSInteger)enterpriseId andStoneName:(NSString *)stoneName andStoneType:(NSString *)stoneType{
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:stoneType forKey:@"stoneType"];
    [phoneDict setObject:stoneName forKey:@"stoneName"];
    [phoneDict setObject:[NSNumber numberWithInteger:enterpriseId] forKey:@"selectedEnterpriseId"];
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
    [network getDataWithUrlString:URL_SelectionCenter_StoneName_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"success"] boolValue] ;
            if (Result) {
//                CLog(@"=============================================%@",json);
//                                CLog(@"======================11111=======================%@",json[@"MSG_CODE"]);
                if (isHead) {
                    //这边数组要全部进行删除
                    [weakSelf.scStoneNameArray removeAllObjects];
                    
                    weakSelf.scStoneNameArray = [RSSCContentModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    [weakSelf.tableview reloadData];
                    [weakSelf.tableview.mj_header endRefreshing];
                }else{
                    //添加数组
                    NSMutableArray * tempArray = [NSMutableArray array];
                    tempArray = [RSSCContentModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    //                    CLog(@"++++++++++32323+++++++++++++++++++%ld",tempArray.count);
//                    if (weakSelf.pageNum > 2) {
//                        if (tempArray.count < pageSize - 1) {
//                           weakSelf.pageNum--;
//                        }
//                    }
                    [weakSelf.tableview reloadData];
                    [weakSelf.scStoneNameArray addObjectsFromArray:tempArray];
                    [weakSelf.tableview.mj_footer endRefreshing];
                }
                
            }
        }else{
            if (isHead) {
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }
    }];
}


//新的现货搜索URL_OWNER_STONE_IOS
- (void)newStoneSearchPageSize:(NSInteger)pageSize andIsHead:(BOOL)isHead andStoneName:(NSString *)stoneName{
    /**
     石种名称    stoneName    String
     库存类型    stockType    String
     每页条数    pageSize    Int
     页码    pageNum    Int
     */
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:stoneName forKey:@"stoneName"];
    if (isHead) {
       self.pageNum = 1;
    }else{
       self.pageNum++;
    }
    if ([self.title isEqualToString:@"荒料"]) {
        [phoneDict setObject:@(1) forKey:@"stockType"];
    }else if([self.title isEqualToString:@"大板"]){
        [phoneDict setObject:@(2) forKey:@"stockType"];
    }
    //pageNum   pageSize 必须要的
    [phoneDict setObject:[NSString stringWithFormat:@"%ld",(long)self.pageNum] forKey:@"pageNum"];
    [phoneDict setObject:[NSString stringWithFormat:@"%ld",pageSize] forKey:@"pageSize"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey] == nil ? @"" : [UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//    CLog(@"++++++++++++++++++++++++++++%@",parameters);
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_OWNER_STONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"success"] boolValue] ;
            if (Result) {
//                CLog(@"=============================================%@",json);
                //                CLog(@"======================11111=======================%@",json[@"MSG_CODE"]);
                if (isHead) {
                    //这边数组要全部进行删除
                    [weakSelf.scStoneNameArray removeAllObjects];
                    weakSelf.scStoneNameArray = [RSOwnerStoneModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    [weakSelf.tableview.mj_header endRefreshing];
                }else{
                    //添加数组
                    
                    NSMutableArray * tempArray = [NSMutableArray array];
                    tempArray = [RSOwnerStoneModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                    
                    [weakSelf.scStoneNameArray addObjectsFromArray:tempArray];
                    [weakSelf.tableview.mj_footer endRefreshing];
                }
                [weakSelf.tableview reloadData];
            }
        }else{
            if (isHead) {
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }
    }];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Height_Real(0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.scStoneNameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]) {
        return Height_Real(106);
    }else{
        return Height_Real(120);
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSSCOwnerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OWNER"];
    cell.companyAddressBtn.tag = indexPath.row;
    [cell.companyAddressBtn addTarget:self action:@selector(jumpCompanyAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.companyPhoneNumberBtn addTarget:self action:@selector(playPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]) {
        cell.ownerStoneModel = self.scStoneNameArray[indexPath.row];
        cell.companyPhoneNumberBtn.hidden = false;
        cell.companyAddressBtn.hidden = true;
        cell.stoneWarehouse.hidden = true;
//        cell.companyAddressLabel.text = @"存储位置:大板市场C09 l C10 l C13 l C15";
    }else{
        cell.sccontentModel = self.scStoneNameArray[indexPath.row];
        cell.companyPhoneNumberBtn.hidden = false;
        cell.companyAddressBtn.hidden = false;
        cell.stoneWarehouse.hidden = false;
//        cell.companyAddressLabel.text = @"经营地址:南安 水头镇 海 西石材城";
    }
    cell.signLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    if (indexPath.row < 3) {
        cell.signImage.image = [UIImage imageNamed:@"Rectangle 13.png"];
    }else{
        cell.signImage.image = [UIImage imageNamed:@"Rectangle 132.png"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.companyAddressBtn.tag = indexPath.row;
    return cell;
}


//打电话
- (void)playPhoneAction:(UIButton *)playPhoneBtn{
    NSString * phoneNum = @"";
    if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]) {
        RSOwnerStoneModel * ownerStoneModel = self.scStoneNameArray[playPhoneBtn.tag];
        phoneNum = ownerStoneModel.ownerPhone;
    }else{
        RSSCContentModel * sccontentModel = self.scStoneNameArray[playPhoneBtn.tag];
        phoneNum = sccontentModel.contactNumber;
    }
    RSWeakself
    [UserManger checkLogin:self successBlock:^{
        //    CLog(@"打电话");
        [JHSysAlertUtil presentAlertViewWithTitle:@"温馨提示" message:@"确认是否给对方拨打电话" cancelTitle:@"确定" defaultTitle:@"取消" distinct:true cancel:^{
            
            
            NSMutableDictionary * phoneDict = [NSMutableDictionary dictionary];
            //这边还需要添加一个发送短信接口
            [phoneDict setObject:phoneNum forKey:@"toTel"];
    //            URL_SEND_CALL_PHONESMS
            [phoneDict setObject:[UserManger getUserObject].userPhone forKey:@"fromTel"];
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey] == nil ? @"" : [UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_SEND_CALL_PHONESMS withParameters:parameters withBlock:^(id json, BOOL success) {
    //            NSLog(@"+++++++++++++++++++++++++++");
            }];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phoneNum]] options:@{} completionHandler:^(BOOL success) {
                NSLog(@"%d",success);
                if(!success) return ;
            }];
        } confirm:^{
        }];
    }];
}

/**
 
 URL_SEND_CALL_PHONESMS
       [phoneDict setObject:[UserManger getUserObject].userPhone forKey:@"fromTel"];
       NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
       NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
       AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
       NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey] == nil ? @"" : [UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
   //    CLog(@"++++++++++++++++++++++++++++%@",parameters);
       XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
       [network getDataWithUrlString:URL_SEND_CALL_PHONESMS withParameters:parameters withBlock:^(id json, BOOL success) {
           if (success){
//                    NSLog(@"=================================");
           }
       }];
 */



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if ([self.title isEqualToString:@"荒料"] || [self.title isEqualToString:@"大板"]) {
        
        //还是需要看下
//        RSOwnerStoneModel * ownerStoneModel = self.scStoneNameArray[indexPath.row];
//        RSSCCompanyViewController * scCompanyVc = [RSSCCompanyViewController suspendCenterPageVCWithEnterpriseId:ownerStoneModel.deaCode];
//        [self.navigationController pushViewController:scCompanyVc animated:true];
        
    }else{
        RSSCContentModel * scContentModel = self.scStoneNameArray[indexPath.row];
        RSSCCompanyViewController * scCompanyVc = [RSSCCompanyViewController suspendCenterPageVCWithEnterpriseId:scContentModel.enterpriseId];
        [self.navigationController pushViewController:scCompanyVc animated:true];
    }
}



#pragma mark 跳转到第三方地图APP
- (void)jumpCompanyAddressAction:(UIButton *)jumpAddressBtn{
    RSSCContentModel * sccontentModel = self.scStoneNameArray[jumpAddressBtn.tag];
//    sccontentModel.address
    [self navigationLocationTitle:sccontentModel.address latitudeText:[NSString stringWithFormat:@"%lf",sccontentModel.location.lat] longitudeText:[NSString stringWithFormat:@"%lf",sccontentModel.location.lon]];
}




@end
