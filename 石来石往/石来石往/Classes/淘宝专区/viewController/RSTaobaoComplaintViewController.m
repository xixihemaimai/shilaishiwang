//
//  RSTaobaoComplaintViewController.m
//  石来石往
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaobaoComplaintViewController.h"

#import "SpecialAlertView.h"

#import "RSTaobaoComplaintCell.h"

#import "RSTaobaoComplaintFootView.h"

@interface RSTaobaoComplaintViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    BOOL _isFirst;
    
}
@property (nonatomic,strong)UITableView * tableview;


@end

@implementation RSTaobaoComplaintViewController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _isFirst = NO;
    if (@available(iOS 11.0, *)) {
           [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
       }else{
           self.automaticallyAdjustsScrollViewInsets = NO;
       }
    
    self.title = @"我要投诉";
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH) style:UITableViewStylePlain];
    self.tableview = tableview;
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 43;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 43;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"请选择投诉原因";
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 247;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString * TAOBAOCOMPLAINTFOOTVIEWID = @"TAOBAOCOMPLAINTFOOTVIEWID";
    RSTaobaoComplaintFootView * taobaoComplaintFootView = [[RSTaobaoComplaintFootView alloc]initWithReuseIdentifier:TAOBAOCOMPLAINTFOOTVIEWID];
    [taobaoComplaintFootView.sureSubmissionBtn addTarget:self action:@selector(sureSubmissionAction:) forControlEvents:UIControlEventTouchUpInside];
    return taobaoComplaintFootView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * TAOBAOCOMPLAINTCELLID = @"TAOBAOCOMPLAINTCELLID";
    RSTaobaoComplaintCell * cell = [tableView dequeueReusableCellWithIdentifier:TAOBAOCOMPLAINTCELLID];
    if (!cell) {
        cell = [[RSTaobaoComplaintCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TAOBAOCOMPLAINTCELLID];
    }
    cell.tag = indexPath.row;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"价格不合理";
        cell.selectComplaintImage.hidden = NO;
    }else if (indexPath.row == 1){
        cell.titleLabel.text = @"虚假货源";
        cell.selectComplaintImage.hidden = YES;
    }else if (indexPath.row == 2){
        cell.titleLabel.text = @"违法信息";
        cell.selectComplaintImage.hidden = YES;
    }else{
        cell.titleLabel.text = @"其他";
        cell.selectComplaintImage.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (int i = 0; i < 4; i++) {
        RSTaobaoComplaintCell * cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.tag == indexPath.row) {
            cell.selectComplaintImage.hidden = NO;
        }else{
            cell.selectComplaintImage.hidden = YES;
        }
    }
}



//提交
- (void)sureSubmissionAction:(UIButton *)sureSubmissionBtn{
    
    RSTaobaoComplaintFootView * taobaoComplaintFootView = (RSTaobaoComplaintFootView * )[self.tableview footerViewForSection:0];
//    if ([taobaoComplaintFootView.explainTextView.text length] < 1) {
//        [SVProgressHUD showInfoWithStatus:@"请填写投诉详细情况"];
//        return;
//    }

    NSString * str = [NSString string];
    for (int i = 0; i < 4; i++) {
        RSTaobaoComplaintCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.selectComplaintImage.hidden == NO) {
            str = cell.titleLabel.text;
            break;
        }
    }
    /**
     原因    reason    String    必填 价格不合理/虚假货源/违法信息/其他
     描述    describe    String    选填
     商铺ID    shopId    Int    必填
     商品（货物）ID    stoneId    Int    必填
    */
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:[NSNumber numberWithInteger:self.tsUserId] forKey:@"shopId"];
    [phoneDict setValue:[NSNumber numberWithInteger:self.productid] forKey:@"stoneId"];
    [phoneDict setValue:str forKey:@"reason"];
    [phoneDict setValue:taobaoComplaintFootView.explainTextView.text forKey:@"describe"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_FEEDBACK_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"] boolValue];
            if (isresult) {
                SpecialAlertView * special = [[SpecialAlertView alloc]initWithTitleImage:@"投诉打勾" messageTitle:@"投诉提交成功" messageString:@"工作人员将会在第一时间评估处理,                   感谢您的反馈" sureBtnTitle:@"确定" sureBtnColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] andTag:1];
                [special withSureClick:^(NSString *string) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"提交投诉失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"提交投诉失败"];
        }
    }];
}


- (BOOL)prefersStatusBarHidden{
    if (_isFirst == NO) {
        if (iphonex || iPhoneXSMax || iPhoneXR || iPhoneXS) {
            self.navigationController.navigationBar.frame = CGRectMake(0,44, SCW,44);
        }else{
            self.navigationController.navigationBar.frame = CGRectMake(0,20, SCW,44);
        }
        //_isFirst = YES;
    }else{
        self.navigationController.navigationBar.frame = CGRectMake(0,0, SCW,64);

    }
    return NO;
}


@end
