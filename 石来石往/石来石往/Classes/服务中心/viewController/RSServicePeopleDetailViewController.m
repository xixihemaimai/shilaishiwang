//
//  RSServicePeopleDetailViewController.m
//  石来石往
//
//  Created by mac on 2018/4/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServicePeopleDetailViewController.h"

#import "RSServicePepleModel.h"
#import "RSServicePersonListCell.h"

@interface RSServicePeopleDetailViewController ()

//@property (nonatomic,strong)UITableView * tableview;


@property (nonatomic,strong)NSMutableArray * servicepeopleDetailArray;


@end

@implementation RSServicePeopleDetailViewController

- (NSMutableArray *)servicepeopleDetailArray{
    if (_servicepeopleDetailArray == nil) {
        _servicepeopleDetailArray = [NSMutableArray array];
    }
    return _servicepeopleDetailArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务人员";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self isAddjust];
    [self.view addSubview:self.tableview];
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//    [self setUiServicePeopleDetailCustomTableview];
    [self loadServicePepoleDetailNetWorkDataType];
}

//- (void)setUiServicePeopleDetailCustomTableview{
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//    self.tableview = tableview;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    [self.view addSubview:self.tableview];
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    RSWeakself
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//        [weakSelf loadServicePepoleDetailNetWorkDataType];
//    }];
//}

//服务人员获取网络请求
- (void)loadServicePepoleDetailNetWorkDataType{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    [dict setObject:self.serviceId forKey:@"serviceId"];
    [dict setObject:self.type forKey:@"type"];
    [dict setObject:@"1" forKey:@"search"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SERVICESEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [weakSelf.servicepeopleDetailArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                for (int i = 0; i < array.count; i++) {
                    RSServicePepleModel * servicePeplemdodel = [[RSServicePepleModel alloc]init];
                    servicePeplemdodel.img = [[array objectAtIndex:i]objectForKey:@"img"];
                    servicePeplemdodel.phone = [[array objectAtIndex:i]objectForKey:@"phone"];
                    servicePeplemdodel.userName = [[array objectAtIndex:i]objectForKey:@"userName"];
                    servicePeplemdodel.serviceUserId = [[array objectAtIndex:i]objectForKey:@"serviceUserId"];
                    [weakSelf.servicepeopleDetailArray addObject:servicePeplemdodel];
                }
                [weakSelf.tableview reloadData];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.servicepeopleDetailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * SERVICEPOPLEDETAILID = @"SERVICEPOPLEDETAILID";
    RSServicePersonListCell * cell = [tableView dequeueReusableCellWithIdentifier:SERVICEPOPLEDETAILID];
    if (!cell) {
        cell = [[RSServicePersonListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SERVICEPOPLEDETAILID];
    }
    RSServicePepleModel * servicePeplemdodel = self.servicepeopleDetailArray[indexPath.row];    
    //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:servicePeplemdodel.img] placeholderImage:[UIImage imageNamed:@"图片加载失败"]];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:servicePeplemdodel.img]];
    cell.touImage.image = [UIImage imageWithData:data];
    cell.touImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.touImage.clipsToBounds = YES;
    cell.nameLabel.text = servicePeplemdodel.userName;
    cell.phoneLabel.text = servicePeplemdodel.phone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否打电话给该服务人员" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    RSWeakself
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        RSServicePepleModel * servicePeplemdodel = self.servicepeopleDetailArray[indexPath.row];
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",servicePeplemdodel.phone];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [weakSelf.view addSubview:callWebview];
    }];
     [alert addAction:action1];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action2];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        alert.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:alert animated:YES completion:nil];
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
