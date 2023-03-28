//
//  RSProcessingFactoryViewController.m
//  石来石往
//
//  Created by mac on 2019/6/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSProcessingFactoryViewController.h"

#import "RSMaterialDetailsSecondCell.h"
#import "RSSalertView.h"

@interface RSProcessingFactoryViewController ()<RSSalertViewDelegate>
/**加工厂数据库的数组*/
@property (nonatomic,strong)NSMutableArray * factoryArray;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)RSSalertView * salertview;


@end

@implementation RSProcessingFactoryViewController


- (RSSalertView *)salertview{
    if (!_salertview) {
        self.salertview = [[RSSalertView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 100, SCW - 66 , 200)];
        self.salertview.backgroundColor = [UIColor whiteColor];
        self.salertview.delegate = self;
        self.salertview.layer.cornerRadius = 15;
    }
    return _salertview;
}



- (NSMutableArray *)factoryArray{
    if (!_factoryArray) {
        _factoryArray = [NSMutableArray array];
    }
    return _factoryArray;
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
    self.title = @"加工厂";
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    UIButton * warehouseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [warehouseBtn setTitle:@"新增" forState:UIControlStateNormal];
    [warehouseBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    warehouseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:warehouseBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    [warehouseBtn addTarget:self action:@selector(factoryNewAddAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tableview];
    self.pageNum = 2;
    if ([[self.navigationController.viewControllers objectAtIndex:1] isKindOfClass:[self class]]) {
        //从服务器里面那数据，然后在添加到数据库里面的加工厂数据表里面
        //URL_GETPROCESSBLOCKLIST_IOS
        [self reloadServiceWareHouseNewData];
    }else{
        RSPersonlPublishDB * personlPublishDB = [[RSPersonlPublishDB alloc]initWithCreatTypeList:FACTORY];
        self.factoryArray = [personlPublishDB getAllContent];
        [self.tableview reloadData];
    }
    [self.tableview setupEmptyDataText:@"暂无数据" tapBlock:^{
        
    }];
    
}




- (void)reloadServiceWareHouseNewData{
    //页码    pageNum    Int
    //每页条数    itemNum    Int
    //用户id    userId    String
    //字典添加标识    dicKey    String    字典添加标识：WareHouse
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
//    [phoneDict setObject:@"" forKey:@"name"];
    [phoneDict setObject:[NSNumber numberWithInteger:1] forKey:@"pageNum"];
    [phoneDict setObject:[NSNumber numberWithInteger:10000] forKey:@"itemNum"];
    [phoneDict setObject:@"Factory" forKey:@"dicKey"];
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
                [weakSelf.factoryArray removeAllObjects];
                weakSelf.factoryArray = [RSWarehouseModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                
                //这边怎么添加数据库里面
                RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:@"Factory.sqlite"];
//                if ([[weakSelf.navigationController.viewControllers objectAtIndex:1] isKindOfClass:[weakSelf class]]) {
                    [db deleteAllContent];
                    [db batchAddMutableArray:weakSelf.factoryArray];
//                }else{
//                    [db deleteAllContent];
//                    [db batchAddMutableArray:weakSelf.factoryArray];
//                }
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
    return self.factoryArray.count;
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
    static NSString * FACTORYCELLID = @"FACTORYCELLID";
    RSMaterialDetailsSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:FACTORYCELLID];
    if (!cell) {
        cell = [[RSMaterialDetailsSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:FACTORYCELLID];
    }
    // cell.titleLabel.text = self.titleArray[indexPath.row];
    //cell.materiaTypeLabel.text = self.detailArray[indexPath.row];
    RSWarehouseModel * rolemodel = self.factoryArray[indexPath.row];
    cell.nameDetialLabel.text = rolemodel.name;
    cell.editBtn.tag = indexPath.row;
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(factoryDetailsDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editBtn addTarget:self action:@selector(factoryDetailsEditAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    UIColor *color = [UIColor colorWithHexColorStr:@"#ffffff"];//通过RGB来定义自己的颜色
//    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];//这句不可省略
//    cell.selectedBackgroundView.backgroundColor = color;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSWarehouseModel * warehousemodel = self.factoryArray[indexPath.row];
    if ([[self.navigationController.viewControllers objectAtIndex:1] isKindOfClass:[self class]]) {
        
        
    }else{
        if ([warehousemodel.name isEqualToString:self.selectName] && warehousemodel.WareHouseID == self.selectID) {
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"该加工厂已使用,无法使用" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertView addAction:alert];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                alertView.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:alertView animated:YES completion:nil];

        }else{
            if (self.select) {
                self.select(YES, warehousemodel);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}



//删除
- (void)factoryDetailsDeleteAction:(UIButton *)deleteBtn{
    if (self.usermodel.pwmsUser.JCSJ_JGC == 0) {
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"你当前没有加工厂管理权限,不能进行增删改操作" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertView animated:YES completion:nil];
    }else{
        RSWarehouseModel * wareHousemodel = self.factoryArray[deleteBtn.tag];
        if ([wareHousemodel.name isEqualToString:self.selectName] && wareHousemodel.WareHouseID == self.selectID) {
            
            
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"该加工厂已使用,无法删除" preferredStyle:UIAlertControllerStyleAlert];
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
                [phoneDict setObject:wareHousemodel.name forKey:@"name"];
                [phoneDict setObject:[NSNumber numberWithInteger:wareHousemodel.WareHouseID]forKey:@"id"];
                [phoneDict setObject:@"Factory" forKey:@"dicKey"];
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


//编辑
- (void)factoryDetailsEditAction:(UIButton *)editBtn{
        RSWarehouseModel * warehousemodel = self.factoryArray[editBtn.tag];
    if ([warehousemodel.name isEqualToString:self.selectName] && warehousemodel.WareHouseID == self.selectID) {
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:@"该加工已使用,无法编辑" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertView animated:YES completion:nil];
    }else{
        //编辑
        //self.alertView.indextag = btn.tag;
        self.salertview.selectFunctionType = @"加工厂";
        self.salertview.wareHouseTypeName = warehousemodel.name;
        self.salertview.selectType = @"edit";
        self.salertview.indextag = editBtn.tag;
        [self.salertview showView];
    }
}

//这边是加工厂的新增
- (void)factoryNewAddAction:(UIButton *)wareHouseBtn{
    if (self.usermodel.pwmsUser.JCSJ_JGC == 0) {
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"你当前没有加工厂管理权限,不能进行增删改操作" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertView addAction:alert];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertView.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertView animated:YES completion:nil];
    }else{
        self.salertview.selectFunctionType = @"加工厂";
        //self.salertview.wareHouseTypeName = @"荒料仓";
        self.salertview.wareHouseTypeName = @"";
        self.salertview.selectType = @"new";
        [self.salertview showView];
    }
}


- (void)reloadFactoryName:(NSString *)name andType:(NSString *)selectType andTag:(NSInteger)tag{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    if ([selectType isEqualToString:@"new"]) {
     //新增
        [phoneDict setObject:name forKey:@"name"];
        [phoneDict setObject:@"Factory" forKey:@"dicKey"];
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
        
    }else{
     //编辑
        RSWarehouseModel * warehousemodel = self.factoryArray[tag];
        [phoneDict setObject:name forKey:@"name"];
         [phoneDict setObject:@"update" forKey:@"actKey"];
        [phoneDict setObject:[NSNumber numberWithInteger:warehousemodel.WareHouseID]forKey:@"id"];
        [phoneDict setObject:@"Factory" forKey:@"dicKey"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_DICUPDATE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
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

@end
