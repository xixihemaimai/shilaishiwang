//
//  RSAttentionAndFansViewController.m
//  石来石往
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSAttentionAndFansViewController.h"
#import "RSFansCell.h"
#import "RSAttentionCell.h"
#import "RSAttentionModel.h"
#import "RSMyRingViewController.h"
#import "RSCargoCenterBusinessViewController.h"

@interface RSAttentionAndFansViewController ()

//@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSString * typeStr;
@property (nonatomic,strong)NSMutableArray * attentionArray;

@end

@implementation RSAttentionAndFansViewController
- (NSMutableArray *)attentionArray{
    if (!_attentionArray) {
        _attentionArray = [NSMutableArray array];
    }
    return _attentionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
    [self isAddjust];
    [self.view addSubview:self.tableview];
//    [self setUITableViewUi];
    [self loadAttenteionAndFansNetworkData];
}

//- (void)setUITableViewUi{
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navHeight + navY, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//    self.tableView = tableView;
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableView];
//    RSWeakself
//    [self.tableView setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf loadAttenteionAndFansNetworkData];
//    }];
//}

#pragma mark --- 获得数据
- (void)loadAttenteionAndFansNetworkData{
    NSString * typeStr = [NSString string];
    if ([self.title isEqualToString:@"关注"]) {
        typeStr = @"gz";
        _typeStr = typeStr;
    }else{
        typeStr = @"fans";
        _typeStr = typeStr;
    }
    [self reloadAttentionAndFansDataStr:typeStr];
}

#pragma mark -- 获取粉丝和关注的数据
- (void)reloadAttentionAndFansDataStr:(NSString *)typeStr{
    //URL_ATTENETIONANDFANS_IOS
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[UserManger getUserObject].userID forKey:@"userId"];
    [phoneDict setObject:typeStr forKey:@"type"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_ATTENETIONANDFANS_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [weakSelf.attentionArray removeAllObjects];
                NSMutableArray * array = [RSAttentionModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                weakSelf.attentionArray = array;
                [weakSelf.tableview reloadData];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.attentionArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.title isEqualToString:@"粉丝"]) {
        static NSString * FANSCELLID = @"fanscellid";
        RSFansCell * cell = [tableView dequeueReusableCellWithIdentifier:FANSCELLID];
        if (!cell) {
            cell = [[RSFansCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:FANSCELLID];
        }
           RSAttentionModel * attentionModel = self.attentionArray[indexPath.row];
           [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_IMAGEURL_PING_IOS,attentionModel.userLogo]]];
           cell.fansLable.text = [NSString stringWithFormat:@"%@",attentionModel.userName];
        if ([attentionModel.attStatus isEqualToString:@"相互关注"]) {
           [cell.fansBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
           cell.fansBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#3385FF"].CGColor;
           [cell.fansBtn setTitle:[NSString stringWithFormat:@"相互关注"] forState:UIControlStateNormal];
        }else{
           [cell.fansBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FF8200"] forState:UIControlStateNormal];
           cell.fansBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FF8200"].CGColor;
           [cell.fansBtn setTitle:@"加关注" forState:UIControlStateNormal];
        }
           cell.fansBtn.tag = indexPath.row + 100000;
           [cell.fansBtn addTarget:self action:@selector(addAttentionAction:) forControlEvents:UIControlEventTouchUpInside];
           return cell;
    }else{
           static NSString * ATTENTIONCELLID = @"attentioncellid";
           RSAttentionCell * cell = [tableView dequeueReusableCellWithIdentifier:ATTENTIONCELLID];
           if (!cell) {
            cell = [[RSAttentionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ATTENTIONCELLID];
           }
           RSAttentionModel * attentionModel = self.attentionArray[indexPath.row];
           cell.fansLable.text = attentionModel.userName;
           [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_IMAGEURL_PING_IOS,attentionModel.userLogo]]];
           cell.attentionBtn.tag = 1000000 + indexPath.row;
           [cell.attentionBtn addTarget:self action:@selector(cancelAttentionAction:) forControlEvents:UIControlEventTouchUpInside];
           return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     myRingVc.erpCodeStr = self.erpCode;
     myRingVc.userIDStr = @"-1";
     myRingVc.creat_userIDStr = @"-1";
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSAttentionModel * attentionModel = self.attentionArray[indexPath.row];
    if ([[UserManger getUserObject].userType isEqualToString:@""]) {
        RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:[UserManger getUserObject] andErpCodeStr:@"" andCreat_userIDStr:attentionModel.attentionID andUserIDStr:attentionModel.attentionID];
        [self.navigationController pushViewController:cargoCenterVc animated:YES];
    }else{
        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
       // myRingVc.userType = attentionModel.userType;
        myRingVc.userModel = [UserManger getUserObject];
        myRingVc.erpCodeStr =@"" ;
        myRingVc.userIDStr = attentionModel.attentionID;
        myRingVc.creat_userIDStr = attentionModel.attentionID;
        [self.navigationController pushViewController:myRingVc animated:YES];
    }
}

#pragma mark -- 添加关注和互相关注
- (void)addAttentionAction:(UIButton *)fansBtn{
    RSAttentionModel * attentionModel = self.attentionArray[fansBtn.tag - 100000];
    RSWeakself
    if ([fansBtn.currentTitle isEqualToString:@"已关注"] || [fansBtn.currentTitle isEqualToString:@"相互关注"]) {
        [JHSysAlertUtil presentAlertViewWithTitle:@"是否取消关注" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        } confirm:^{
             [weakSelf deleteAttiationAndFasAttentionStr:attentionModel.attentionID];
        }];
    }else{
         [self deleteAttiationAndFasAttentionStr:attentionModel.attentionID];
    }
}

#pragma mark -- 已关注的现在取消关注
- (void)cancelAttentionAction:(UIButton *)attentionBtn{
    RSAttentionModel * attentionModel = self.attentionArray[attentionBtn.tag - 1000000];

    RSWeakself
    if ([attentionBtn.currentTitle isEqualToString:@"已关注"] || [attentionBtn.currentTitle isEqualToString:@"互相关注"]) {
        [JHSysAlertUtil presentAlertViewWithTitle:@"是否取消关注" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        } confirm:^{
            //这边要去删除你取消关注的Cell的位置的数据
            [weakSelf.attentionArray removeObjectAtIndex:attentionBtn.tag - 1000000];
            [weakSelf deleteAttiationAndFasAttentionStr:attentionModel.attentionID];
        }];
    }else{
        //这边要去删除你取消关注的Cell的位置的数据
        [self.attentionArray removeObjectAtIndex:attentionBtn.tag - 1000000];
        [self deleteAttiationAndFasAttentionStr:attentionModel.attentionID];
    }
}

- (void)deleteAttiationAndFasAttentionStr:(NSString * )attentionStr{
    //URL_MESSAGECENTERATTTIONANDFANSDELECT_IOS
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[UserManger getUserObject].userID forKey:@"userId"];
    [phoneDict setObject:attentionStr forKey:@"attId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_MESSAGECENTERATTTIONANDFANSDELECT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                //这边要去让关注和粉丝重新获取
                if ([weakSelf.typeStr isEqualToString:@"fans"]) {
                    [weakSelf reloadAttentionAndFansDataStr:weakSelf.typeStr];
                }else{
                    [weakSelf.tableview reloadData];
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:@"attentAndFansNumberMessageCenter" object:nil];
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshData" object:nil];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
