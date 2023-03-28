//
//  RSDriverViewController.m
//  石来石往
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSDriverViewController.h"
#import "RSAddDriverViewController.h"
#import "RSDriverInformationCell.h"
#import "RSCustomButton.h"
#import "RSGoodOutController.h"

//第三方框架
#import <MJExtension.h>



#import "RSBlockOutViewController.h"
#import "RSOsakaViewController.h"

@interface RSDriverViewController ()<RSAddDriverViewControllerDelegate,UISearchBarDelegate>
//{
//    UIImageView *_contentImageview;
//
//}

@property (nonatomic,strong)RSAddDriverViewController *addDriverVc;

//@property (nonatomic,strong)UITableView *tableview;


@property (nonatomic,strong) UISearchBar * search;

@end

@implementation RSDriverViewController
//SingerM(RSDriverViewController);
-(NSMutableArray *)driverArray{
    if (_driverArray == nil) {
        _driverArray = [NSMutableArray array];
    }
    return _driverArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}


static NSString *driverInformationID = @"driverinformation";
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor co];
    
    [self isAddjust];
    self.title = @"选择提货人";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getServerDriverInformation) name:@"saveDataRefresh" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh) name:@"contactDataRefresh" object:nil];
    
    
   
    
    [self addCustomTableview];
    
    
    [self addBottomContentView];
//    UIImageView *contentImageview = [[UIImageView alloc]init];
//    contentImageview.image = [UIImage imageNamed:@"矢量智能对象1"];
//    [self.view addSubview:contentImageview];
//    _contentImageview = contentImageview;
//    contentImageview.sd_layout
//    .centerYEqualToView(self.view)
//    .centerXEqualToView(self.view)
//    .widthIs(SCW - 48)
//    .heightEqualToWidth();
    
    //获取服务器上面的司机信息
    [self getServerDriverInformation];
    
}

- (void)refresh{
    //重新获取数据
    [self getServerDriverInformation];
}


- (void)getServerDriverInformation{
    //URL_GET_HAIXI_USER_DRIVER_MESSAGE
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.userModel.userID forKey:@"userId"];
    /**
     提货人接口在原接口（/findcsn.do
     ）上添加参数 searchText（可选 有传 返回手机号或者名称符合的相关提货人）  和userId放在同一层
     */
    [dict setObject:_search.text forKey:@"searchText"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(self) weakSelf = self;
    XLAFNetworkingBlock *network =[[XLAFNetworkingBlock alloc]init];
    //URL_DELIVERPERSON_LIST_IOS URL_GET_HAIXI_USER_DRIVER_MESSAGE
    [network getDataWithUrlString:URL_DELIVERPERSON_LIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            [weakSelf.driverArray removeAllObjects];
            if (Result) {
                //mj_objectArrayWithKeyValuesArray:dictArray
                weakSelf.driverArray = [RSDirverContact mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                if (self.driverArray.count == 0) {
//                    _contentImageview.hidden = NO;
                }else{
//                    _contentImageview.hidden = YES;
                }
                [weakSelf.tableview reloadData];
            }else{
                //[RSLoginValidity LoginValiditWithVerifyKey:verifykey andViewController:weakSelf];
//                _contentImageview.hidden = NO;
            }
        }
    }];
}




- (void)addCustomTableview{
//    CGFloat Y = 0.0;
//    CGFloat bottomH = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//        bottomH = 34;
//    }else{
//        Y = 64;
//        bottomH = 0.0;
//    }
    //这边添加一个搜索框
    UISearchBar * search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCW, 45)];
    _search = search;
    _search.text = @"";
    search.delegate = self;
    search.placeholder = @"搜索";
    [self.view addSubview:search];
    
   [self.view addSubview:self.tableview];
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(_search.frame), SCW, SCH - Height_NavBar - Height_bottomSafeArea - 45 - search.yj_height);

   [self.tableview registerClass:[RSDriverInformationCell class] forCellReuseIdentifier:driverInformationID];
}





- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //[self loadHzName:searchBar.text];
    [self getServerDriverInformation];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.3 animations:^{
        searchBar.showsCancelButton = YES;
        for (id obj in [searchBar subviews]) {
            if ([obj isKindOfClass:[UIView class]]) {
                for (id obj2 in [obj subviews]) {
                    if ([obj2 isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)obj2;
                        [btn setTitle:@"取消" forState:UIControlStateNormal];
                        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }
                }
            }
        }
    }];
}

#pragma mark -- 点击取消按键
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
    UIButton *cancelBtn = [searchBar valueForKeyPath:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES;
    [self getServerDriverInformation];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.driverArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSDriverInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:driverInformationID];
    RSDirverContact *contact = self.driverArray[indexPath.row];
    cell.contact = contact;
    [cell.removeBtn addTarget:self action:@selector(removeDriverInformation:) forControlEvents:UIControlEventTouchUpInside];
    cell.removeBtn.tag = indexPath.row;
   // [cell.editBtn addTarget:self action:@selector(editBtnInformation:) forControlEvents:UIControlEventTouchUpInside];
    //cell.editBtn.tag = indexPath.row;
//    if ([[self.navigationController.viewControllers objectAtIndex:2]class] == [RSOsakaViewController class] ||[[self.navigationController.viewControllers objectAtIndex:2]class] == [RSBlockOutViewController class] ){
//
//        cell.editBtn.hidden = YES;
//        cell.removeBtn.hidden = NO;
//        cell.editBtn.enabled = NO;
//        cell.removeBtn.enabled = YES;
//       cell.editBtn.sd_layout
//        .centerYEqualToView(cell.editview)
//        .topEqualToView(cell.removeBtn)
//        .bottomEqualToView(cell.removeBtn)
//        .rightSpaceToView(cell.removeBtn,5)
//        .widthIs(60);
//
//
//    }else{
//        cell.editBtn.hidden = NO;
//        cell.removeBtn.hidden = YES;
//        cell.removeBtn.enabled = NO;
//        cell.editBtn.enabled = YES;
//        cell.editBtn.sd_layout
//        .centerYEqualToView(cell.editview)
//        .rightSpaceToView(cell.editview,12)
//        .topSpaceToView(cell.editview,10)
//        .bottomSpaceToView(cell.editview,10)
//        .widthIs(60);
//
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -- 删除司机信息
- (void)removeDriverInformation:(RSCustomButton *)btn{
    //URL_DELETE_DRIVER_MESSAGE
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你确定需要删除该行的数据吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RSDirverContact *contact = self.driverArray[btn.tag];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *verifykey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
       // [dict setObject:self.userID forKey:@"erpcode"];
        [dict setObject:contact.driverID forKey:@"csnId"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_DELDELIVERYPERSON_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL  Result = [json[@"Result"] boolValue];
                if (Result) {
                    //移除数组的那个位置
                    [self.driverArray removeObjectAtIndex:btn.tag];
                    [self.tableview reloadData];
                    [SVProgressHUD showSuccessWithStatus:@"成功删除"];
                }
            }
        }];
    }];
    [alert addAction:action];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD showSuccessWithStatus:@"你取消了删除改行数据"];
    }];
    [alert addAction:action1];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                           alert.modalPresentationStyle = UIModalPresentationFullScreen;
                       }
    [self presentViewController:alert animated:YES completion:nil];
}

//#pragma mark -- 编辑客户信息
//- (void)editBtnInformation:(RSCustomButton *)btn{
//    //这里要把需要的数据发给到添加司机的界面
//    RSDirverContact *contact = self.driverArray[btn.tag];
//
//    RSAddDriverViewController *addDriverVc = [[RSAddDriverViewController alloc]init];
//    self.addDriverVc = addDriverVc;
//    addDriverVc.contact = contact;
//    addDriverVc.tag = btn.tag;
//    //addDriverVc.driverViewVC = self;
//    addDriverVc.userID = self.userID;
//    addDriverVc.userModel = self.userModel;
//    //这边是出货记录界面里面的数组
//    addDriverVc.chuArray = self.shopCarNumberArray;
//
//
//    //当前存储用户提货人的所有的信息的数组
//   // addDriverVc.driverArray = self.driverArray;
//    addDriverVc.deleagate = self;
//    [self.navigationController pushViewController:addDriverVc animated:YES];
//}

- (void)transmitConsigneeName:(NSString *)csnName andConsigneePhone:(NSString *)csnPhone{
    if ([self.delegate respondsToSelector:@selector(modifyConsigneeName:andConsigneePhone:)]) {
        [self.delegate modifyConsigneeName:csnName andConsigneePhone:csnPhone];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.navigationController.viewControllers objectAtIndex:2]class] == [RSOsakaViewController class] ||[[self.navigationController.viewControllers objectAtIndex:2]class] == [RSBlockOutViewController class] ) {
        RSDirverContact  * contact = self.driverArray[indexPath.row];
        RSGoodOutController *goodOutVc = [[RSGoodOutController alloc]init];
        //选择那一行里面的模型的数据
        goodOutVc.contact = contact;
        goodOutVc.userID = self.userID;
        goodOutVc.userModel = self.userModel;
        goodOutVc.outStyle =  self.outStyle;
        //接收到了购物车里面的数组，里面的模型数据
        goodOutVc.shopNumberCountArray = self.shopCarNumberArray;
        goodOutVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:goodOutVc animated:YES];
    }else{
        //这边修改出库记录单子里面的提货人
        RSDirverContact *contact = self.driverArray[indexPath.row];
        RSAddDriverViewController *addDriverVc = [[RSAddDriverViewController alloc]init];
        self.addDriverVc = addDriverVc;
        addDriverVc.contact = contact;
        addDriverVc.tag =indexPath.row;
        //addDriverVc.driverViewVC = self;
        addDriverVc.userID = self.userID;
        addDriverVc.userModel = self.userModel;
        addDriverVc.hidesBottomBarWhenPushed = YES;
        //    addDriverVc.driverArray = self.driverArray;
//        if ([[self.navigationController.viewControllers objectAtIndex:2]class] != [RSOsakaViewController class] ||[[self.navigationController.viewControllers objectAtIndex:2]class] != [RSBlockOutViewController class] ) {
            addDriverVc.chuArray = self.shopCarNumberArray;
            addDriverVc.deleagate = self;
//        }
        //当前存储用户提货人的所有的信息的数组
//        addDriverVc.driverArray = self.driverArray;
        [self.navigationController pushViewController:addDriverVc animated:YES];
    }
}

- (void)addBottomContentView{
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 34;
//    }else{
//        Y = 0;
//    }
    UIButton * bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCH - Height_NavBar - Height_bottomSafeArea - 45, SCW, 45)];
    [bottomBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ff5f04"]];
    [self.view addSubview:bottomBtn];
    [bottomBtn addTarget:self action:@selector(jumpAddDriverViewController) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *addimageivew = [[UIImageView alloc]init];
    addimageivew.image = [UIImage imageNamed:@"multiwindow_bottombar_add_disable"];
    [bottomBtn addSubview:addimageivew];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"添加新司机";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    [bottomBtn addSubview:label];

//    bottomBtn.sd_layout
//    .bottomSpaceToView(self.view,0)
//    .rightSpaceToView(self.view,0)
//    .leftSpaceToView(self.view,0)
//    .heightIs(45);
    
    label.sd_layout
    .centerXEqualToView(bottomBtn)
    .centerYEqualToView(bottomBtn)
    .widthRatioToView(bottomBtn,0.25)
    .heightIs(45);

    addimageivew.sd_layout
    .rightSpaceToView(label,10)
    .topSpaceToView(bottomBtn,15)
    .bottomSpaceToView(bottomBtn,15)
    .widthRatioToView(bottomBtn,0.05);
}

#pragma mark -- 跳转到添加司机的界面
- (void)jumpAddDriverViewController{
    RSAddDriverViewController *addDriverVc = [[RSAddDriverViewController alloc]init];
    addDriverVc.userID = self.userID;
    addDriverVc.userModel = self.userModel;
    self.addDriverVc = addDriverVc;
//    addDriverVc.driverArray = self.driverArray;
    if ([[self.navigationController.viewControllers objectAtIndex:2]class] != [RSOsakaViewController class] ||[[self.navigationController.viewControllers objectAtIndex:2]class] != [RSBlockOutViewController class] ) {
        addDriverVc.chuArray = self.shopCarNumberArray;
        addDriverVc.deleagate = self;
    }
    [self.navigationController pushViewController:addDriverVc animated:YES];
}

//- (void)addViewController:(RSAddDriverViewController *)RSAddDriverViewController contact:(RSDirverContact *)contact{
//    [self.driverArray addObject:contact];
//    _contentImageview.hidden = YES;
//    [self.tableview reloadData];
//}

//- (void)revampDriverViewController:(RSAddDriverViewController *)RSRSAddDriverViewController contact:(RSDirverContact *)contact{
//}



- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
