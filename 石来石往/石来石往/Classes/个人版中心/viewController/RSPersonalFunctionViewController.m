//
//  RSPersonalFunctionViewController.m
//  石来石往
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSPersonalFunctionViewController.h"
#import "RSPersonalFunctionCell.h"
#import "RSTextField.h"
#import "RSSalertView.h"

//荒料异常处理
#import "RSExceptionHandlingViewController.h"
//荒料入库
#import "RSStorageMaterialsViewController.h"
//荒料出库
#import "RSOutStockViewController.h"
//荒料调试
#import "RSBlockDispatchViewController.h"
//荒料入库（序模型）
#import "RSPersonalFunctionModel.h"

//大板入库
#import "RSSLStorageViewController.h"
//大板出库
#import "RSSLOutStorageViewController.h"




//大板异常处理
#import "RSDabanAbnormalViewController.h"

//大板调拨
#import "RSSLAllocationViewController.h"


@interface RSPersonalFunctionViewController ()<RSSalertViewDelegate,UITextFieldDelegate>
@property (nonatomic,assign)NSInteger pageNume;

@property (nonatomic,strong)NSMutableArray * personalArray;

@property (nonatomic,strong)RSSalertView * alertView;


@property (nonatomic,strong)NSMutableDictionary * personalDict;

@property (nonatomic,strong)RSTextField * textfield;
@end

@implementation RSPersonalFunctionViewController
- (NSMutableArray *)personalArray{
    if (!_personalArray) {
        _personalArray = [NSMutableArray array];
    }
    return _personalArray;
}

- (NSMutableDictionary *)personalDict{
    if (!_personalDict) {
        _personalDict = [NSMutableDictionary dictionary];
    }
    return _personalDict;
}

- (RSSalertView *)alertView
{
    if (!_alertView) {
        self.alertView = [[RSSalertView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 175.5, SCW - 66 , 351)];
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
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.pageNume = 2;
    
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addBtn setTitle:@"新增" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    [addBtn addTarget:self action:@selector(addFunctionAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    //搜索界面
    UIView * searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 63)];
    searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    RSTextField * textfield = [[RSTextField alloc]initWithFrame:CGRectMake(12, 11.5, SCW - 64, 40)];
    textfield.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8F8"];
    //textview.zw_placeHolder = @"请输入要匹配的仓库名";
    //textfield.borderStyle = UITextBorderStyleLine;
    textfield.placeholder = @"搜索物料名称";
    textfield.delegate = self;
    textfield.returnKeyType = UIReturnKeyDone;
    textfield.font = [UIFont systemFontOfSize:14];
    
    if ([UIDevice currentDevice].systemVersion.floatValue <= 12.0) {
        
        [textfield setValue:[UIColor colorWithHexColorStr:@"#D5D5D5"] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        
        
        NSMutableAttributedString * place = [[NSMutableAttributedString alloc]initWithString:textfield.text];
        
        [place addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexColorStr:@"#D5D5D5"] range:NSMakeRange(0, place.length)];
        
        textfield.attributedPlaceholder = place;
        
    }
    _textfield = textfield;
    UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(19, 14, 13, 13)];
                              //Image:[UIImage imageNamed:@"cxSearch"]];
    imageView.image = [UIImage imageNamed:@"cxSearch"];
    //imageView.frame = CGRectMake(-19, 14, 13, 13);
    textfield.leftView = imageView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    //textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //textview.zw_placeHolderColor = [UIColor colorWithHexColorStr:@"#D5D5D5"];
    [searchView addSubview:textfield];
    textfield.layer.cornerRadius = 20;
    
    UIButton * screenBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textfield.frame), 0, SCW - CGRectGetMaxX(textfield.frame), 63)];
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchView addSubview:screenBtn];
    [screenBtn addTarget:self  action:@selector(screenTimeAndProduct:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.personalDict setObject:@"2019-01-01" forKey:@"dateFrom"];
    [self.personalDict setObject:[self showCurrentTime] forKey:@"dateTo"];
    [self.personalDict setObject:@"" forKey:@"mtlName"];
    [self.personalDict setObject:[NSNumber numberWithInteger:0] forKey:@"mtlId"];
    [self.personalDict setObject:@"" forKey:@"blockNo"];
    [self.personalDict setObject:@"" forKey:@"whsName"];
    [self.personalDict setObject:[NSNumber numberWithInteger:0] forKey:@"whsId"];
    [self.personalDict setObject:@"1" forKey:@"pageNum"];
    [self.personalDict setObject:@"10" forKey:@"pageSize"];
    self.tableview.tableHeaderView = searchView;
    
    [self reloadNewData];
    
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadNewData];
    }];
    
    //向上刷新
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf reloadNewMoreData];
    }];

    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
      [weakSelf reloadNewData];
    }];
}

- (void)reloadNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    [phoneDict setObject:self.personalDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BILLLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.personalArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                for (int i = 0; i < array.count; i++) {
                    RSPersonalFunctionModel * storagemanagementmodel = [[RSPersonalFunctionModel alloc]init];
                    storagemanagementmodel.billDate = [[array objectAtIndex:i]objectForKey:@"billDate"];
                     storagemanagementmodel.billNo = [[array objectAtIndex:i]objectForKey:@"billNo"];
                    storagemanagementmodel.billType = [[array objectAtIndex:i]objectForKey:@"billType"];
                    storagemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.busType = [[array objectAtIndex:i]objectForKey:@"busType"];
                    storagemanagementmodel.status = [[[array objectAtIndex:i]objectForKey:@"status"] integerValue];
                    storagemanagementmodel.abType = [[array objectAtIndex:i]objectForKey:@"abType"];
                    storagemanagementmodel.mtlNames = [[array objectAtIndex:i]objectForKey:@"mtlNames"];
                    storagemanagementmodel.totalArea = [[array objectAtIndex:i]objectForKey:@"totalArea"];
                    storagemanagementmodel.totalQty = [[[array objectAtIndex:i]objectForKey:@"totalQty"]integerValue];
                    storagemanagementmodel.totalTurns = [[[array objectAtIndex:i]objectForKey:@"totalTurns"] integerValue];
                    storagemanagementmodel.totalVolume = [[array objectAtIndex:i]objectForKey:@"totalVolume"];
                     storagemanagementmodel.totalWeight = [[array objectAtIndex:i]objectForKey:@"totalWeight"];
                    storagemanagementmodel.warehouse = [[array objectAtIndex:i]objectForKey:@"warehouse"];
                    storagemanagementmodel.warehouseIn = [[array objectAtIndex:i]objectForKey:@"warehouseIn"];
                    [weakSelf.personalArray addObject:storagemanagementmodel];
                }
                weakSelf.pageNume = 2;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
                
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)reloadNewMoreData{
     [self.personalDict setObject:[NSNumber numberWithInteger:self.pageNume] forKey:@"pageNum"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    [phoneDict setObject:self.personalDict forKey:@"billViewFilter"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_BILLLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"list"];
                NSMutableArray * tempArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    RSPersonalFunctionModel * storagemanagementmodel = [[RSPersonalFunctionModel alloc]init];
                    storagemanagementmodel.billDate = [[array objectAtIndex:i]objectForKey:@"billDate"];
                    storagemanagementmodel.billNo = [[array objectAtIndex:i]objectForKey:@"billNo"];
                    storagemanagementmodel.billType = [[array objectAtIndex:i]objectForKey:@"billType"];
                    storagemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.busType = [[array objectAtIndex:i]objectForKey:@"busType"];
                    storagemanagementmodel.status = [[[array objectAtIndex:i]objectForKey:@"status"] integerValue];
                    storagemanagementmodel.abType = [[array objectAtIndex:i]objectForKey:@"abType"];
                    storagemanagementmodel.mtlNames = [[array objectAtIndex:i]objectForKey:@"mtlNames"];
                    storagemanagementmodel.totalArea = [[array objectAtIndex:i]objectForKey:@"totalArea"];
                    storagemanagementmodel.totalQty = [[[array objectAtIndex:i]objectForKey:@"totalQty"]integerValue];
                    storagemanagementmodel.totalTurns = [[[array objectAtIndex:i]objectForKey:@"totalTurns"] integerValue];
                    storagemanagementmodel.totalVolume = [[array objectAtIndex:i]objectForKey:@"totalVolume"];
                    storagemanagementmodel.totalWeight = [[array objectAtIndex:i]objectForKey:@"totalWeight"];
                    storagemanagementmodel.warehouse = [[array objectAtIndex:i]objectForKey:@"warehouse"];
                    storagemanagementmodel.warehouseIn = [[array objectAtIndex:i]objectForKey:@"warehouseIn"];
                    [tempArray addObject:storagemanagementmodel];
                }
                [weakSelf.personalArray addObjectsFromArray:tempArray];
                weakSelf.pageNume++;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_footer endRefreshing];
            }else{
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
               
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}

//新增
- (void)addFunctionAction:(UIButton *)addBtn{
     [_textfield resignFirstResponder];
  if ([self.selectType isEqualToString:@"huangliaoruku"]){
        RSStorageMaterialsViewController * storagematerialsVc = [[RSStorageMaterialsViewController alloc]init];
        storagematerialsVc.selectType = self.selectType;
        storagematerialsVc.usermodel = self.usermodel;
        storagematerialsVc.selectFunctionType = self.selectFunctionType;
        storagematerialsVc.showType = @"new";
        storagematerialsVc.selectShow = self.selectShow;
        [self.navigationController pushViewController:storagematerialsVc animated:YES];
        storagematerialsVc.reload = ^(BOOL isreload) {
            [self reloadNewData];
        };
    }else if ([self.selectType isEqualToString:@"huangliaochuku"]){
        RSOutStockViewController * outStockVc = [[RSOutStockViewController alloc]init];
        outStockVc.selectType = self.selectType;
        outStockVc.selectFunctionType = self.selectFunctionType;
        outStockVc.selectShow = self.selectShow;
        outStockVc.showType = @"new";
        outStockVc.usermodel = self.usermodel;
        [self.navigationController pushViewController:outStockVc animated:YES];
        outStockVc.reload = ^(BOOL isreload) {
            [self reloadNewData];
        };
    }else if ([self.selectType isEqualToString:@"kucunguanli"]) {
        if ([self.selectFunctionType isEqualToString:@"异常处理"]) {
            //荒料
            RSExceptionHandlingViewController * exceptionHandlingVc = [[RSExceptionHandlingViewController alloc]init];
            exceptionHandlingVc.selectType = self.selectType;
            exceptionHandlingVc.selectFunctionType = self.selectFunctionType;
            exceptionHandlingVc.selectShow = self.selectShow;
            exceptionHandlingVc.usermodel = self.usermodel;
            exceptionHandlingVc.showType = @"new";
            [self.navigationController pushViewController:exceptionHandlingVc animated:YES];
            exceptionHandlingVc.reload = ^(BOOL isreload) {
                [self reloadNewData];
            };
        }else  if ([self.selectFunctionType isEqualToString:@"调拨"]) {
            //荒料
            RSBlockDispatchViewController * blockDispatchVc = [[RSBlockDispatchViewController alloc]init];
            blockDispatchVc.usermodel = self.usermodel;
            blockDispatchVc.selectFunctionType = self.selectFunctionType;
            blockDispatchVc.selectType = self.selectType;
            blockDispatchVc.selectShow = self.selectShow;
            blockDispatchVc.showType = @"new";
            [self.navigationController pushViewController:blockDispatchVc animated:YES];
            blockDispatchVc.reload = ^(BOOL isreload) {
                [self reloadNewData];
            };
        }
    }else if ([self.selectType isEqualToString:@"dabanruku"]){
        //大板入库
        RSSLStorageViewController * slstorageVc = [[RSSLStorageViewController alloc]init];
        slstorageVc.selectFunctionType = self.selectFunctionType;
        slstorageVc.selectType = self.selectType;
        slstorageVc.usermodel = self.usermodel;
        slstorageVc.selectShow = self.selectShow;
        slstorageVc.showType = @"new";
        [self.navigationController pushViewController:slstorageVc animated:YES];
        slstorageVc.reload = ^(BOOL isreload) {
            [self reloadNewData];
        };
    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
         //大板出库
        RSSLOutStorageViewController * slOutStorageVc = [[RSSLOutStorageViewController alloc]init];
        slOutStorageVc.selectFunctionType = self.selectFunctionType;
        slOutStorageVc.selectType = self.selectType;
        slOutStorageVc.usermodel = self.usermodel;
        slOutStorageVc.selectShow = self.selectShow;
        slOutStorageVc.showType = @"new";
        [self.navigationController pushViewController:slOutStorageVc animated:YES];
        slOutStorageVc.reload = ^(BOOL isreload) {
            [self reloadNewData];
        };
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        if ([self.selectFunctionType isEqualToString:@"异常处理"]) {
            //异常处理
            RSDabanAbnormalViewController * dabanAbnormalViewVc = [[RSDabanAbnormalViewController alloc]init];
            dabanAbnormalViewVc.selectFunctionType = self.selectFunctionType;
            dabanAbnormalViewVc.selectType = self.selectType;
            dabanAbnormalViewVc.usermodel = self.usermodel;
            dabanAbnormalViewVc.selectShow = self.selectShow;
            dabanAbnormalViewVc.showType = @"new";
            [self.navigationController pushViewController:dabanAbnormalViewVc animated:YES];
            dabanAbnormalViewVc.reload = ^(BOOL isreload) {
                [self reloadNewData];
            };
        }else{
            //调拨
            RSSLAllocationViewController * dabanAbnormalViewVc = [[RSSLAllocationViewController alloc]init];
            dabanAbnormalViewVc.selectFunctionType = self.selectFunctionType;
            dabanAbnormalViewVc.selectType = self.selectType;
            dabanAbnormalViewVc.usermodel = self.usermodel;
            dabanAbnormalViewVc.selectShow = self.selectShow;
            dabanAbnormalViewVc.showType = @"new";
            [self.navigationController pushViewController:dabanAbnormalViewVc animated:YES];
            dabanAbnormalViewVc.reload = ^(BOOL isreload) {
                [self reloadNewData];
            };
        }
    }
}

//筛选
- (void)screenTimeAndProduct:(UIButton *)screenBtn{
    [_textfield resignFirstResponder];
    self.alertView.selectFunctionType = self.selectFunctionType;
    self.alertView.wareHouseTypeName = _textfield.text;
    [self.alertView showView];
}

- (void)screenFunctionWithWarehousingTime:(NSString *)warehousingTime andDeadline:(NSString *)deadlingTime andMaterialName:(NSString *)materialName andBlockNumber:(NSString *)blockNumber{
    [self.personalDict setObject:[self showDisplayTheTime:warehousingTime] forKey:@"dateFrom"];
    [self.personalDict setObject:[self showDisplayTheTime:deadlingTime] forKey:@"dateTo"];
    [self.personalDict setObject:materialName forKey:@"mtlName"];
    [self.personalDict setObject:blockNumber forKey:@"blockNo"];
    [self reloadNewData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.personalArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectType isEqualToString:@"kucunguanli"] || [self.selectType isEqualToString:@"kucunguanli1"]) {
        return 150;
    }else{
        return 130;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PERSONALFUNCTION = @"PERSONALFUNCTION";
    RSPersonalFunctionCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSONALFUNCTION];
    if (!cell) {
        cell = [[RSPersonalFunctionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PERSONALFUNCTION];
    }
    cell.personalFunctionmodel = self.personalArray[indexPath.row];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     [_textfield resignFirstResponder];
    RSPersonalFunctionModel * personalFunctionmodel = self.personalArray[indexPath.row];
    if ([self.selectType isEqualToString:@"huangliaoruku"]){
        RSStorageMaterialsViewController * storagematerialsVc = [[RSStorageMaterialsViewController alloc]init];
        storagematerialsVc.selectType = self.selectType;
        storagematerialsVc.usermodel = self.usermodel;
        storagematerialsVc.selectFunctionType = self.selectFunctionType;
        storagematerialsVc.showType = @"reload";
        storagematerialsVc.personalFunctionmodel = personalFunctionmodel;
        storagematerialsVc.selectShow = self.selectShow;
        [self.navigationController pushViewController:storagematerialsVc animated:YES];
        storagematerialsVc.reload = ^(BOOL isreload) {
            [self reloadNewData];
        };
    }else if ([self.selectType isEqualToString:@"huangliaochuku"]) {
        RSOutStockViewController * outStockVc = [[RSOutStockViewController alloc]init];
        outStockVc.selectType = self.selectType;
        outStockVc.selectFunctionType = self.selectFunctionType;
        outStockVc.selectShow = self.selectShow;
        outStockVc.showType = @"reload";
        outStockVc.personalFunctionmodel = personalFunctionmodel;
        outStockVc.usermodel = self.usermodel;
        [self.navigationController pushViewController:outStockVc animated:YES];
        outStockVc.reload = ^(BOOL isreload) {
            [self reloadNewData];
        };
    }else if ([self.selectType isEqualToString:@"kucunguanli"]){
        if ([self.selectFunctionType isEqualToString:@"异常处理"]) {
            RSExceptionHandlingViewController * exceptionHandlingVc = [[RSExceptionHandlingViewController alloc]init];
            exceptionHandlingVc.selectType = self.selectType;
            exceptionHandlingVc.selectFunctionType = self.selectFunctionType;
            exceptionHandlingVc.selectShow = self.selectShow;
            exceptionHandlingVc.usermodel = self.usermodel;
            exceptionHandlingVc.showType = @"reload";
            exceptionHandlingVc.personalFunctionmodel = personalFunctionmodel;
            [self.navigationController pushViewController:exceptionHandlingVc animated:YES];
            exceptionHandlingVc.reload = ^(BOOL isreload) {
                [self reloadNewData];
            };
        }else{
            RSBlockDispatchViewController * blockDispatchVc = [[RSBlockDispatchViewController alloc]init];
            blockDispatchVc.usermodel = self.usermodel;
            blockDispatchVc.selectFunctionType = self.selectFunctionType;
            blockDispatchVc.selectType = self.selectType;
            blockDispatchVc.selectShow = self.selectShow;
            blockDispatchVc.showType = @"reload";
            blockDispatchVc.personalFunctionmodel = personalFunctionmodel;
            [self.navigationController pushViewController:blockDispatchVc animated:YES];
            blockDispatchVc.reload = ^(BOOL isreload) {
                [self reloadNewData];
            };
        }
    }else if ([self.selectType isEqualToString:@"dabanruku"]){
        //大板入库
        RSSLStorageViewController * slstorageVc = [[RSSLStorageViewController alloc]init];
        slstorageVc.selectFunctionType = self.selectFunctionType;
        slstorageVc.selectType = self.selectType;
        slstorageVc.usermodel = self.usermodel;
        slstorageVc.selectShow = self.selectShow;
        slstorageVc.personalFunctionmodel = personalFunctionmodel;
         slstorageVc.showType = @"reload";
        slstorageVc.reload = ^(BOOL isreload) {
            [self reloadNewData];
        };
        [self.navigationController pushViewController:slstorageVc animated:YES];
    }else if ([self.selectType isEqualToString:@"dabanchuku"]){
        //大板出库
        RSSLOutStorageViewController * slOutStorageVc = [[RSSLOutStorageViewController alloc]init];
        slOutStorageVc.selectFunctionType = self.selectFunctionType;
        slOutStorageVc.selectType = self.selectType;
        slOutStorageVc.usermodel = self.usermodel;
        slOutStorageVc.selectShow = self.selectShow;
        slOutStorageVc.showType = @"reload";
        slOutStorageVc.personalFunctionmodel = personalFunctionmodel;
        [self.navigationController pushViewController:slOutStorageVc animated:YES];
        slOutStorageVc.reload = ^(BOOL isreload) {
            [self reloadNewData];
        };
    }else if ([self.selectType isEqualToString:@"kucunguanli1"]){
        if ([self.selectFunctionType isEqualToString:@"异常处理"]) {
            //异常处理
            RSDabanAbnormalViewController * dabanAbnormalViewVc = [[RSDabanAbnormalViewController alloc]init];
            dabanAbnormalViewVc.selectFunctionType = self.selectFunctionType;
            dabanAbnormalViewVc.selectType = self.selectType;
            dabanAbnormalViewVc.usermodel = self.usermodel;
            dabanAbnormalViewVc.selectShow = self.selectShow;
            dabanAbnormalViewVc.personalFunctionmodel = personalFunctionmodel;
            dabanAbnormalViewVc.showType = @"reload";
            [self.navigationController pushViewController:dabanAbnormalViewVc animated:YES];
            dabanAbnormalViewVc.reload = ^(BOOL isreload) {
                [self reloadNewData];
            };
        }else{
            //调拨
            RSSLAllocationViewController * dabanAbnormalViewVc = [[RSSLAllocationViewController alloc]init];
            dabanAbnormalViewVc.selectFunctionType = self.selectFunctionType;
            dabanAbnormalViewVc.selectType = self.selectType;
            dabanAbnormalViewVc.usermodel = self.usermodel;
            dabanAbnormalViewVc.selectShow = self.selectShow;
            dabanAbnormalViewVc.personalFunctionmodel = personalFunctionmodel;
            dabanAbnormalViewVc.showType = @"reload";
            [self.navigationController pushViewController:dabanAbnormalViewVc animated:YES];
            dabanAbnormalViewVc.reload = ^(BOOL isreload) {
                [self reloadNewData];
            };
        }
    }
}

- (NSString *)showDisplayTheTime:(NSString *)time{
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [dateFormatter dateFromString:time];
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    return currentDateString;
}

- (NSString *)showCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] < 1){
       _textfield.text = @"";
    }else{
        _textfield.text = temp;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.personalDict setObject:_textfield.text forKey:@"mtlName"];
    //[self.personalDict setObject:blockNumber forKey:@"blockNo"];
    [self reloadNewData];
    [textField resignFirstResponder];//取消第一响应者
    return YES;
}


@end
