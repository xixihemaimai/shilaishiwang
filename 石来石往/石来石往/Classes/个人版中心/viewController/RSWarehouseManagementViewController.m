//
//  RSWarehouseManagementViewController.m
//  石来石往
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 mac. All rights reserved.
//
#import "RSWarehouseManagementViewController.h"
#import "RSWarehouseManamentCell.h"
#import "RSSalertView.h"
#import "RSWarehouseModel.h"


@interface RSWarehouseManagementViewController ()<RSSalertViewDelegate>
@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)RSSalertView * alertView;
/**仓库数据库的数组*/
@property (nonatomic,strong)NSMutableArray * warehouseArray;

@end

@implementation RSWarehouseManagementViewController
- (NSMutableArray *)warehouseArray{
    if (!_warehouseArray) {
            if (_warehouseArray == nil) {
                _warehouseArray = [NSMutableArray array];
            }
    }
    return _warehouseArray;
}

- (RSSalertView *)alertView
{
    if (!_alertView) {
        self.alertView = [[RSSalertView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 139.5, SCW - 66 , 279)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.delegate = self;
        self.alertView.layer.cornerRadius = 15;
    }
    return _alertView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.title = @"仓库管理";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    UIButton * warehouseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [warehouseBtn setTitle:@"新增" forState:UIControlStateNormal];
    [warehouseBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    warehouseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:warehouseBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    [warehouseBtn addTarget:self action:@selector(warehouseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tableview];
    self.pageNum = 2;
    if ([[self.navigationController.viewControllers objectAtIndex:1] isKindOfClass:[self class]]) {
        //从服务器里面那数据，然后在添加到数据库里面的仓库数据表里面
        //URL_DICLOAD_IOS
        [self reloadServiceWareHouseNewData];
    }else{
        //这边直接就从仓库数据表里面拿
        RSPersonlPublishDB * personlPublishDB = [[RSPersonlPublishDB alloc]initWithCreatTypeList:WAREHOUSERSQL];
        if ([self.selectType isEqualToString:@"dabanruku"] || [self.selectType isEqualToString:@"dabanchuku"] || [self.selectType isEqualToString:@"kucunguanli1"]) {
            self.warehouseArray = [personlPublishDB getAllContent:@"SL"];
        }else{
            self.warehouseArray = [personlPublishDB getAllContent:@"BL"];
        }
    }
    [self.tableview setupEmptyDataText:@"暂无数据" tapBlock:^{
        
    }];
}

- (void)reloadServiceWareHouseNewData{
    //页码    pageNum    Int
    //每页条数    itemNum    Int
    //用户id    userId    String
    //字典添加标识    dicKey    String    字典添加标识：WareHouse
    //URL_DICLOAD_IOS
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10000] forKey:@"itemNum"];
    [phoneDict setObject:@"WareHouse" forKey:@"dicKey"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DICLOAD_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"] boolValue];
            if (isresult) {
                [weakSelf.warehouseArray removeAllObjects];
                 weakSelf.warehouseArray = [RSWarehouseModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]]; 
                  //这边怎么添加数据库里面
                RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Warehouselist.sqlite"];
                if ([[weakSelf.navigationController.viewControllers objectAtIndex:1] isKindOfClass:[weakSelf class]]) {
                    [db deleteAllContent];
                    [db batchAddMutableArray:weakSelf.warehouseArray];
                }else{
                    //这边直接就从仓库数据表里面拿
                    [db deleteAllContent];
                    [db batchAddMutableArray:weakSelf.warehouseArray];
                    if ([weakSelf.selectType isEqualToString:@"dabanruku"] || [weakSelf.selectType isEqualToString:@"dabanchuku"] || [weakSelf.selectType isEqualToString:@"kucunguanli1"]) {
                        weakSelf.warehouseArray = [db getAllContent:@"SL"];
                    
                    }else{
                        weakSelf.warehouseArray = [db getAllContent:@"BL"];
                    }
                    
                }
                  weakSelf.pageNum = 2;
                 [weakSelf.tableview reloadData];
            }else{
                weakSelf.pageNum = 2;
                [weakSelf.tableview reloadData];
            }
        }else{
            weakSelf.pageNum = 2;
            [weakSelf.tableview reloadData];
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.warehouseArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * WAREHOUSEMANANMENTID = @"WAREHOUSEMANANMENTID";
    RSWarehouseManamentCell * cell = [tableView dequeueReusableCellWithIdentifier:WAREHOUSEMANANMENTID];
    if (!cell) {
        cell = [[RSWarehouseManamentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:WAREHOUSEMANANMENTID];
    }
    RSWarehouseModel * warehousermodel = self.warehouseArray[indexPath.row];
    if ([warehousermodel.whstype isEqualToString:@"BL"]) {
         cell.warehouseImageView.image = [UIImage imageNamed:@"荒"];
         cell.warehouseTyleLabel.text = @"荒料仓";
    }else{
         cell.warehouseImageView.image = [UIImage imageNamed:@"板"];
         cell.warehouseTyleLabel.text = @"大板仓";
    }
    cell.warehouseLabel.text = warehousermodel.name;
    cell.editBtn.tag = indexPath.row;
    cell.cancelBtn.tag = indexPath.row;
    [cell.cancelBtn addTarget:self action:@selector(warehouseManagementAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editBtn addTarget:self action:@selector(warehouseManagementAction:) forControlEvents:UIControlEventTouchUpInside];
    UIColor *color = [UIColor colorWithHexColorStr:@"#ffffff"];//通过RGB来定义自己的颜色
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];//这句不可省略
    cell.selectedBackgroundView.backgroundColor = color;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)warehouseSelectName:(NSString *)selectName andWarehouseName:(NSString *)warehouseName andSelectType:(nonnull NSString *)selectType andTag:(NSInteger)tag{
        // 仓库名    name    String
        // 仓库类型    whsType    String    大板：SL 荒料：BL
        // 字典添加标识    dicKey    String    字典添加标识：'WareHouse'
    if ([selectType isEqualToString:@"edit"]) {
        // 动作标识    actKey    String    更新:update
        // 删除：delete
        // 要更改的仓库类型    whsType    String
        //  要更改的名字    name    String    当动作标识为删除的时候则可以不传
        //  当前id    id    Int
        //  字典添加标识    dicKey    String    字典添加标识：WareHouse
        RSWarehouseModel * warehousemodel = self.warehouseArray[tag];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        [phoneDict setObject:@"update" forKey:@"actKey"];
        [phoneDict setObject:warehouseName forKey:@"name"];
        NSString * str = [NSString string];
        if ([selectName isEqualToString:@"荒料仓"]) {
            str = @"BL";
        }else{
            str = @"SL";
        }
        [phoneDict setObject:str forKey:@"whsType"];
        [phoneDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID]forKey:@"id"];
        [phoneDict setObject:@"WareHouse" forKey:@"dicKey"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_DICUPDATE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    [weakSelf reloadServiceWareHouseNewData];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"修改失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
        }];

    }else{
        // 仓库名    name    String
        // 仓库类型    whsType    String    大板：SL 荒料：BL
        // 字典添加标识    dicKey    String    字典添加标识：'WareHouse'
        //URL_DICADD_IOS
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        [phoneDict setObject:warehouseName forKey:@"name"];
        NSString * str = [NSString string];
        if ([selectName isEqualToString:@"荒料仓"]) {
            str = @"BL";
        }else{
            str = @"SL";
        }
        [phoneDict setObject:str forKey:@"whsType"];
        [phoneDict setObject:@"WareHouse" forKey:@"dicKey"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_DICADD_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresutl = [json[@"success"]boolValue];
                if (isresutl) {
                    [weakSelf reloadServiceWareHouseNewData];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"新增失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"新增失败"];
            }
        }];
    }
}



- (void)warehouseManagementAction:(UIButton *)btn{
    if (self.usermodel.pwmsUser.JCSJ_CKGL == 0) {
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"你当前没有仓库管理权限,不能进行增删改操作" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertView animated:YES completion:nil];
       
    }else{
        RSWarehouseModel * warehousemodel = self.warehouseArray[btn.tag];
        if ([self.selectType isEqualToString:@"kucunguanli"] || [self.selectType isEqualToString:@"kucunguanli1"]) {
            if ([btn.currentTitle isEqualToString:@"编辑"]) {
                if ([warehousemodel.name isEqualToString:self.whsName] || [warehousemodel.name isEqualToString:self.whsInName]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"该仓库已使用,无法编辑" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];
                    
                }else{
                    //编辑
                    self.alertView.selectFunctionType = @"添加仓库";
                    self.alertView.wareHouseTypeName = @"荒料仓";
                    self.alertView.wareHouseProductName = warehousemodel.name;
                    NSArray * array = @[@"荒料仓",@"大板仓"];
                    self.alertView.typeArray = array;
                    self.alertView.indextag = btn.tag;
                    self.alertView.selectType = @"edit";
                    [self.alertView showView];
                }
            }else{
                if ([warehousemodel.name isEqualToString:self.whsName] || [warehousemodel.name isEqualToString:self.whsInName]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"该仓库已使用,无法删除" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];
                
                    
                }else{
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该项" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //删除    actKey          // 删除：delete
                        //URL_DICUPDATE_IOS
                        //要更改的仓库类型    whsType    String
                        //   要更改的名字    name    String    当动作标识为删除的时候则可以不传
                        //   当前id    id    Int
                        //  字典添加标识    dicKey    String    字典添加标识：WareHouse
                        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
                        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
                        [phoneDict setObject:@"delete" forKey:@"actKey"];
                        [phoneDict setObject:@"" forKey:@"name"];
                        [phoneDict setObject:warehousemodel.whstype forKey:@"whsType"];
                        [phoneDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID]forKey:@"id"];
                        [phoneDict setObject:@"WareHouse" forKey:@"dicKey"];
                        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
                        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
                        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                        RSWeakself
                        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                        [network getDataWithUrlString:URL_DICUPDATE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                            if (success) {
                                BOOL isresult = [json[@"success"]boolValue];
                                if (isresult) {
                                    [weakSelf reloadServiceWareHouseNewData];
                                }else{
                                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                    }];
                                    [alertView addAction:alert];
                                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                                    }
                                    [weakSelf presentViewController:alertView animated:YES completion:nil];
                                    
                                }
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"删除失败"];
                            }
                        }];
                    }];
                    [alertView addAction:alert];
                    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert1];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];
                    
                }
            }
        }else if ([self.selectType isEqualToString:@"huangliaoruku"] || [self.selectType isEqualToString:@"huangliaochuku"] || [self.selectType isEqualToString:@"dabanruku"] || [self.selectType isEqualToString:@"dabanchuku"]){
            if ([btn.currentTitle isEqualToString:@"编辑"]) {
                if ([self.selectName isEqualToString:warehousemodel.name]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"该仓库已使用,无法编辑" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];
                   
                }else{
                    //编辑
                    self.alertView.selectFunctionType = @"添加仓库";
                    self.alertView.wareHouseTypeName = @"荒料仓";
                    self.alertView.wareHouseProductName = warehousemodel.name;
                    NSArray * array = @[@"荒料仓",@"大板仓"];
                    self.alertView.typeArray = array;
                    self.alertView.indextag = btn.tag;
                    self.alertView.selectType = @"edit";
                    [self.alertView showView];
                }
            }else{
                if ([self.selectName isEqualToString:warehousemodel.name]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"该仓库已使用,无法删除" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];
                   
                    
                }else{
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该项" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //删除    actKey          // 删除：delete
                        //URL_DICUPDATE_IOS
                        //要更改的仓库类型    whsType    String
                        //   要更改的名字    name    String    当动作标识为删除的时候则可以不传
                        //   当前id    id    Int
                        //  字典添加标识    dicKey    String    字典添加标识：WareHouse
                        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
                        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
                        [phoneDict setObject:@"delete" forKey:@"actKey"];
                        [phoneDict setObject:@"" forKey:@"name"];
                        [phoneDict setObject:warehousemodel.whstype forKey:@"whsType"];
                        [phoneDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID]forKey:@"id"];
                        [phoneDict setObject:@"WareHouse" forKey:@"dicKey"];
                        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
                        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
                        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                        RSWeakself
                        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                        [network getDataWithUrlString:URL_DICUPDATE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                            if (success) {
                                BOOL isresult = [json[@"success"]boolValue];
                                if (isresult) {
                                    [weakSelf reloadServiceWareHouseNewData];
                                }else{
                                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                        
                                    }];
                                    [alertView addAction:alert];
                                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                                    }
                                    [weakSelf presentViewController:alertView animated:YES completion:nil];
                                }
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"删除失败"];
                            }
                        }];
                    }];
                    [alertView addAction:alert];
                    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert1];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];
                   
                }
            }
        }
        else{
            if ([btn.currentTitle isEqualToString:@"编辑"]) {
                if ([self.selectName isEqualToString:warehousemodel.name]) {
                    [SVProgressHUD showInfoWithStatus:@"使用中不能编辑"];
                }else{
                    //编辑
                    self.alertView.selectFunctionType = @"添加仓库";
                    self.alertView.wareHouseTypeName = @"荒料仓";
                    self.alertView.wareHouseProductName = warehousemodel.name;
                    NSArray * array = @[@"荒料仓",@"大板仓"];
                    self.alertView.typeArray = array;
                    self.alertView.indextag = btn.tag;
                    self.alertView.selectType = @"edit";
                    [self.alertView showView];
                }
            }else{
                if ([self.selectName isEqualToString:warehousemodel.name]) {
                    [SVProgressHUD showInfoWithStatus:@"使用中不能删除"];
                }else{
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该项" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //删除    actKey          // 删除：delete
                        //URL_DICUPDATE_IOS
                        //要更改的仓库类型    whsType    String
                        //   要更改的名字    name    String    当动作标识为删除的时候则可以不传
                        //   当前id    id    Int
                        //  字典添加标识    dicKey    String    字典添加标识：WareHouse
                        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
                        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
                        [phoneDict setObject:@"delete" forKey:@"actKey"];
                        [phoneDict setObject:@"" forKey:@"name"];
                        [phoneDict setObject:warehousemodel.whstype forKey:@"whsType"];
                        [phoneDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID]forKey:@"id"];
                        [phoneDict setObject:@"WareHouse" forKey:@"dicKey"];
                        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
                        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
                        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                        RSWeakself
                        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                        [network getDataWithUrlString:URL_DICUPDATE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                            if (success) {
                                BOOL isresult = [json[@"success"]boolValue];
                                if (isresult) {
                                    [weakSelf reloadServiceWareHouseNewData];
                                }else{
                                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                        
                                    }];
                                    [alertView addAction:alert];
                                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                                    }
                                    [weakSelf presentViewController:alertView animated:YES completion:nil];
                                    
                                }
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"删除失败"];
                            }
                        }];
                    }];
                    [alertView addAction:alert];
                    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert1];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];

                }
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSWarehouseModel * warehousemodel = self.warehouseArray[indexPath.row];
    if ([[self.navigationController.viewControllers objectAtIndex:1] isKindOfClass:[self class]]) {
        //从服务器里面那数据，然后在添加到数据库里面的仓库数据表里面
        //URL_DICLOAD_IOS
    }else{
        if ([self.selectType isEqualToString:@"kucunguanli"] || [self.selectType isEqualToString:@"kucunguanli1"]) {
            if ([self.selectFunctionType isEqualToString:@"调拨"]) {
                if ([warehousemodel.name isEqualToString:self.whsName] || [warehousemodel.name isEqualToString:self.whsInName]) {
                    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"调拨仓库，不能与调出仓库相同" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertView addAction:alert];
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                    }
                    [self presentViewController:alertView animated:YES completion:nil];
                   
                }else{
                    //这边要选择调出仓库，调入仓库
                    if ([self.inputAndOutStr isEqualToString:@"out"]) {
                        if (self.inputAndOutselect) {
                            self.inputAndOutselect(self.inputAndOutStr, warehousemodel);
                        }
                    }else{
                        if (self.inputAndOutselect) {
                            self.inputAndOutselect(self.inputAndOutStr, warehousemodel);
                        }
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }else if([self.selectType isEqualToString:@"huangliaoruku"] || [self.selectType isEqualToString:@"huangliaochuku"] || [self.selectType isEqualToString:@"dabanruku"] || [self.selectType isEqualToString:@"dabanchuku"]){
//            if ([self.selectName isEqualToString:warehousemodel.name]) {
//                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"该仓库已使用,无法选择" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                }];
//                [alertView addAction:alert];
//                [self presentViewController:alertView animated:YES completion:nil];
//            }else{
                if (self.select) {
                    self.select(YES, warehousemodel);
                    [self.navigationController popViewControllerAnimated:YES];
                }
//            }
        }
    }
}

//新增
- (void)warehouseAction:(UIButton *)warehouseBtn{
     if (self.usermodel.pwmsUser.JCSJ_CKGL == 0) {
         UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"你当前没有仓库管理权限,不能进行增删改操作" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         }];
         [alertView addAction:alert];
         if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
             alertView.modalPresentationStyle = UIModalPresentationFullScreen;
         }
         [self presentViewController:alertView animated:YES completion:nil];
        
     }else{
         self.alertView.selectFunctionType = @"添加仓库";
         self.alertView.wareHouseTypeName = @"荒料仓";
         self.alertView.wareHouseProductName = @"请输入仓库名称";
         self.alertView.selectType = @"new";
         NSArray * array = @[@"荒料仓",@"大板仓"];
         self.alertView.indextag = self.warehouseArray.count;
         self.alertView.typeArray = array;
         self.alertView.index = 0;
         [self.alertView showView];
     }
}

@end
