//
//  RSNewRoleViewController.m
//  石来石往
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSNewRoleViewController.h"
#import "RSNewRoleHeaderView.h"
#import "RSNewRoleFootView.h"
#import "RSNewRoleFirstCell.h"
#import "RSNewRoleSecondCell.h"
#import "RSRSNewRoleThirdCell.h"

@interface RSNewRoleViewController ()

@property (nonatomic,strong)NSMutableDictionary * JurisdictionDict;

@property (nonatomic,strong)NSString * tempStr;


@end

@implementation RSNewRoleViewController

- (NSMutableDictionary *)JurisdictionDict{
    if (!_JurisdictionDict) {
        _JurisdictionDict = [NSMutableDictionary dictionary];
    }
    return _JurisdictionDict;
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
    self.title = @"新建角色";
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UIButton * saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    [saveBtn addTarget:self action:@selector(saveNewRoleAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;

    [self reloadRoleJurisdictionNewData];
    
 
}


- (void)saveNewRoleAction:(UIButton *)saveBtn{
   
    if (self.tempStr.length > 0) {
        NSString * str = [NSString string];
        if ([self.selectType isEqualToString:@"new"]) {
            //添加角色URL_ADDROLE_IOS
            str = URL_ADDROLE_IOS;
        }else{
            //修改角色  URL_UPDATEROLE_IOS
            str = URL_UPDATEROLE_IOS;
        }
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        if ([self.selectType isEqualToString:@"new"]) {
            //添加
            [phoneDict setObject:self.tempStr forKey:@"roleName"];
            [phoneDict setObject:self.JurisdictionDict forKey:@"accessTree"];
        }else{
            //修改
            [phoneDict setObject:self.JurisdictionDict forKey:@"accessTree"];
            [phoneDict setObject:self.tempStr forKey:@"roleName"];
            [phoneDict setObject:[NSNumber numberWithInteger:self.rolemodel.roleID] forKey:@"roleId"];
        }
        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:str withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                weakSelf.reload(true);
                [weakSelf.navigationController popViewControllerAnimated:YES];
                //[RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
            }else{
                weakSelf.reload(false);
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"你没有填入角色"];
    }
}



- (void)reloadRoleJurisdictionNewData{
 
    //URL_ROLEACCESS_IOS
    //新建为0
    //编辑是获取角色id
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
   
    if ([self.selectType isEqualToString:@"new"]) {
        [phoneDict setObject:[NSNumber numberWithInteger:0] forKey:@"roleId"];
    }else{
        [phoneDict setObject:[NSNumber numberWithInteger:self.rolemodel.roleID] forKey:@"roleId"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_ROLEACCESS_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresut = [json[@"success"]boolValue];
            if (isresut) {
                [weakSelf.JurisdictionDict removeAllObjects];
                NSString * jsonString = [weakSelf dictionaryToJson:json[@"data"]];
                weakSelf.JurisdictionDict = [weakSelf dictionaryWithJsonString:jsonString];
                 [weakSelf.tableview reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
           
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
    
    
    
}




//字典转json格式字符串：
- (NSString*)dictionaryToJson:(NSMutableDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//json格式字符串转字典：
- (NSMutableDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 4;
    }else if (section == 2){
        return 4;
    }else{
        return 1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else if(indexPath.section == 1){
        if (indexPath.row == 2) {
             return 83;
        }else if (indexPath.row == 3){
             return 149;
        }else{
             return 83;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 2) {
            return 83;
        }else{
            return 83;
        }
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else{
        return 0.001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        static NSString * NEWROLECELLFOOTID = @"NEWROLECELLFOOTID";
        RSNewRoleFootView * newRoleFootView = [[RSNewRoleFootView alloc]initWithReuseIdentifier:NEWROLECELLFOOTID];
        
        return newRoleFootView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section >= 1) {
        static NSString * NEWROLECELLHEADERID = @"NEWROLECELLHEADERID";
        RSNewRoleHeaderView  * newRoleHeaderView = [[RSNewRoleHeaderView alloc]initWithReuseIdentifier:NEWROLECELLHEADERID];
        if (section == 1) {
            newRoleHeaderView.label.text = @"荒料管理";
        }else if (section == 2){
             newRoleHeaderView.label.text = @"大板管理";
        }else if (section == 3){
             newRoleHeaderView.label.text = @"基础数据";
        }else{
             newRoleHeaderView.label.text = @"系统管理";
        }
        return newRoleHeaderView;
    }
    return nil;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section >= 1) {
//        return @"权限";
//    }
//    return @"";
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * NEWROLECELLID = @"NEWROLECELLID";
        RSNewRoleFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWROLECELLID];
        if (!cell) {
            cell = [[RSNewRoleFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWROLECELLID];
        }
        if (![self.selectType isEqualToString:@"new"]) {
            cell.titleTextfield.text = self.rolemodel.roleName;
            self.tempStr = cell.titleTextfield.text;
        }else{
             cell.titleTextfield.text = self.rolemodel.roleName;
             self.tempStr = cell.titleTextfield.text;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.titleTextfield addTarget:self action:@selector(newRoleTextFieldAction:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }else if(indexPath.section == 1){
        static NSString * NEWROLESECONDCELLID = @"NEWROLESECONDCELLID";
        RSNewRoleSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWROLESECONDCELLID];
        if (!cell) {
            cell = [[RSNewRoleSecondCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWROLESECONDCELLID];
        }
        cell.tag = indexPath.section;
        if (indexPath.row == 0) {
            cell.touLabel.text = @"荒料入库";
            cell.fristLabel.text = @"采购入库";
            cell.secondLabel.text = @"加工入库";
            cell.thirdLabel.text = @"盘盈入库";
            cell.fourLabel.hidden = YES;
            cell.fourBtn.hidden = YES;
            cell.fiveLabel.hidden = YES;
            cell.fiveBtn.hidden = YES;
            cell.sixBtn.hidden = YES;
            cell.sixLabel.hidden = YES;
            cell.sevenBtn.hidden = YES;
            cell.sevenLabel.hidden = YES;
            //HLGL_HLRK荒料入库
            //HLGL_HLRK_CGRK 荒料采购入库
            //HLGL_HLRK_JGRK 荒料加工入库
            //HLGL_HLRK_PYRK荒料盘盈入库
        
            BOOL isHLGL_HLRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK"] boolValue];
            if (isHLGL_HLRK) {
                cell.touBtn.selected = YES;
            }else{
                cell.touBtn.selected = NO;
            }
            BOOL isHLGL_HLRK_CGRK= [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_CGRK"] boolValue];
            if (isHLGL_HLRK_CGRK) {
                cell.fristBtn.selected = YES;
            }else{
                cell.fristBtn.selected = NO;
            }
            BOOL isHLGL_HLRK_JGRK= [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_JGRK"] boolValue];
            if (isHLGL_HLRK_JGRK) {
                cell.secondBtn.selected = YES;
            }else{
                cell.secondBtn.selected = NO;
            }
            BOOL isHLGL_HLRK_PYRK= [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_PYRK"] boolValue];
            if (isHLGL_HLRK_PYRK) {
                cell.thirdBtn.selected = YES;
            }else{
                cell.thirdBtn.selected = NO;
            }
            
            
            
            
            
        }else if (indexPath.row == 1){
            cell.touLabel.text = @"荒料出库";
            cell.fristLabel.text = @"销售出库";
            cell.secondLabel.text = @"加工出库";
            cell.thirdLabel.text = @"盘亏出库";
            cell.fourLabel.hidden = YES;
            cell.fourBtn.hidden = YES;
            cell.fiveLabel.hidden = YES;
            cell.fiveBtn.hidden = YES;
            cell.sixBtn.hidden = YES;
            cell.sixLabel.hidden = YES;
            cell.sevenBtn.hidden = YES;
            cell.sevenLabel.hidden = YES;
            //HLGL_HLCK 荒料出库
            //HLGL_HLCK_XSCK荒料销售出库
            //HLGL_HLCK_JGCK荒料加工出库
            //HLGL_HLCK_PKCK荒料盘亏出库
            
         
            BOOL isHLGL_HLCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK"] boolValue];
            if (isHLGL_HLCK) {
                cell.touBtn.selected = YES;
            }else{
                cell.touBtn.selected = NO;
            }
            BOOL isHLGL_HLCK_XSCK= [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_XSCK"] boolValue];
            if (isHLGL_HLCK_XSCK) {
                cell.fristBtn.selected = YES;
            }else{
                cell.fristBtn.selected = NO;
            }
            BOOL isHLGL_HLCK_JGCK= [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_JGCK"] boolValue];
            if (isHLGL_HLCK_JGCK) {
                cell.secondBtn.selected = YES;
            }else{
                cell.secondBtn.selected = NO;
            }
            BOOL isHLGL_HLCK_PKCK= [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_PKCK"] boolValue];
            if (isHLGL_HLCK_PKCK) {
                cell.thirdBtn.selected = YES;
            }else{
                cell.thirdBtn.selected = NO;
            }
            
            
            
           
        }else if (indexPath.row == 2){
            cell.touLabel.text = @"库存管理";
            cell.fristLabel.text = @"异常处理";
            cell.secondLabel.text = @"调拨";
            //cell.thirdLabel.hidden = YES;
            //cell.thirdBtn.hidden = YES;
            cell.thirdLabel.text = @"现货展示区";
            
            cell.fourLabel.hidden = YES;
            cell.fourBtn.hidden = YES;
            cell.fiveLabel.hidden = YES;
            cell.fiveBtn.hidden = YES;
            cell.sixBtn.hidden = YES;
            cell.sixLabel.hidden = YES;
            cell.sevenBtn.hidden = YES;
            cell.sevenLabel.hidden = YES;
            //HLGL_KCGL 库存管理
            //HLGL_KCGL_YCCL荒料异常处理
            //HLGL_KCGL_DB荒料调拨
            //HLGL_KCGL_XHZS 现货展示区
            
            BOOL isHLGL_KCGL = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL"] boolValue];
            if (isHLGL_KCGL) {
                cell.touBtn.selected = YES;
            }else{
                cell.touBtn.selected = NO;
            }
            BOOL isHLGL_KCGL_YCCL= [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_YCCL"] boolValue];
            if (isHLGL_KCGL_YCCL) {
                cell.fristBtn.selected = YES;
            }else{
                cell.fristBtn.selected = NO;
            }
            BOOL isHLGL_KCGL_DB= [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_DB"] boolValue];
            if (isHLGL_KCGL_DB) {
                cell.secondBtn.selected = YES;
            }else{
                cell.secondBtn.selected = NO;
            }
            
            
            BOOL isHLGL_KCGL_XHZS= [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_XHZS"] boolValue];
            if (isHLGL_KCGL_XHZS) {
                cell.thirdBtn.selected = YES;
            }else{
                cell.thirdBtn.selected = NO;
            }
            
            
            
           
        }else{
            
            cell.touLabel.text = @"报表中心";
            cell.fristLabel.text = @"库存余额";
            cell.secondLabel.text = @"库存流水";
            cell.thirdLabel.text = @"入库明细";
            cell.fourLabel.text = @"出库明细";
            cell.fiveLabel.text = @"加工跟单操作";
            cell.sixLabel.text = @"加工跟单查看";
            
            cell.sevenLabel.text = @"出材率";
            cell.fiveLabel.hidden = NO;
            cell.fiveBtn.hidden = NO;
            cell.sixBtn.hidden = NO;
            cell.sixLabel.hidden = NO;
            cell.sevenLabel.hidden = NO;
            cell.sevenBtn.hidden = NO;
            
            //HLGL_BBZX报表中心
            //HLGL_BBZX_KCYE荒料库存余额
            //HLGL_BBZX_KCLS荒料库存流水
            //HLGL_BBZX_RKMX荒料入库明细
            //HLGL_BBZX_CKMX 荒料出库明细
            
            BOOL isHLGL_BBZX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX"] boolValue];
            if (isHLGL_BBZX) {
                cell.touBtn.selected = YES;
            }else{
                cell.touBtn.selected = NO;
            }
            BOOL isHLGL_BBZX_KCYE= [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCYE"] boolValue];
            if (isHLGL_BBZX_KCYE) {
                cell.fristBtn.selected = YES;
            }else{
                cell.fristBtn.selected = NO;
            }
            BOOL isHLGL_BBZX_KCLS= [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCLS"] boolValue];
            if (isHLGL_BBZX_KCLS) {
                cell.secondBtn.selected = YES;
            }else{
                cell.secondBtn.selected = NO;
            }
            BOOL isHLGL_BBZX_RKMX= [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_RKMX"] boolValue];
            if (isHLGL_BBZX_RKMX) {
                cell.thirdBtn.selected = YES;
            }else{
                cell.thirdBtn.selected = NO;
            }
            BOOL isHLGL_BBZX_CKMX= [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CKMX"] boolValue];
            if (isHLGL_BBZX_CKMX) {
                cell.fourBtn.selected = YES;
            }else{
                cell.fourBtn.selected = NO;
            }
            
            
            BOOL isHLGL_BBZX_JGGDCZ = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCZ"]boolValue];
            if (isHLGL_BBZX_JGGDCZ) {
                cell.fiveBtn.selected = YES;
            }else{
                cell.fiveBtn.selected = NO;
            }
            
            BOOL isHLGL_BBZX_JGGDCK = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCK"]boolValue];
            if (isHLGL_BBZX_JGGDCK) {
                cell.sixBtn.selected = YES;
            }else{
                cell.sixBtn.selected = NO;
            }

            
            //出材率还没有
            //HLGL_BBZX_CCL
            BOOL isHLGL_BBZX_CCL = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CCL"]boolValue];
            if (isHLGL_BBZX_CCL) {
                cell.sevenBtn.selected = YES;
            }else{
                cell.sevenBtn.selected = NO;
            }
            
            
            
            
        }
        cell.touBtn.tag = indexPath.row + 100000000;
        cell.fristBtn.tag = indexPath.row + 100000000;
        cell.secondBtn.tag = indexPath.row + 100000000;
        cell.thirdBtn.tag = indexPath.row + 100000000;
        cell.fourBtn.tag = indexPath.row + 100000000;
        cell.fiveBtn.tag = indexPath.row + 100000000;
        cell.sixBtn.tag = indexPath.row + 100000000;
        cell.sevenBtn.tag = indexPath.row + 100000000;
        
        
        [cell.touBtn addTarget:self action:@selector(touSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fristBtn addTarget:self action:@selector(fristSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.secondBtn addTarget:self action:@selector(secondSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.thirdBtn addTarget:self action:@selector(thirdSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fourBtn addTarget:self action:@selector(fourSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fiveBtn addTarget:self action:@selector(fiveSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.sixBtn addTarget:self action:@selector(sixSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.sevenBtn addTarget:self action:@selector(sevenSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 2){
        static NSString * NEWROLEDABANCELLID = @"NEWROLEDABANCELLID";
        RSNewRoleSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWROLEDABANCELLID];
        if (!cell) {
            cell = [[RSNewRoleSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWROLEDABANCELLID];
        }
        cell.tag = indexPath.section;
        if (indexPath.row == 0) {
            cell.touLabel.text = @"大板入库";
            cell.fristLabel.text = @"采购入库";
            cell.secondLabel.text = @"加工入库";
            cell.thirdLabel.text = @"盘盈入库";
            cell.fourLabel.hidden = YES;
            cell.fourBtn.hidden = YES;
            cell.fiveLabel.hidden = YES;
            cell.fiveBtn.hidden = YES;
            cell.sixBtn.hidden = YES;
            cell.sixLabel.hidden = YES;
            cell.sevenBtn.hidden = YES;
            cell.sevenLabel.hidden = YES;
            //DBGL_DBRK大板入库
            //DBGL_DBRK_CGRK大板采购入库
            //DBGL_DBRK_JGRK大板加工入库
            //DBGL_DBRK_PYRK大板盘盈入库
            
            
            
            BOOL isDBGL_DBRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK"] boolValue];
            if (isDBGL_DBRK) {
                cell.touBtn.selected = YES;
            }else{
                cell.touBtn.selected = NO;
            }
            BOOL isDBGL_DBRK_CGRK= [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_CGRK"] boolValue];
            if (isDBGL_DBRK_CGRK) {
                cell.fristBtn.selected = YES;
            }else{
                cell.fristBtn.selected = NO;
            }
            BOOL isDBGL_DBRK_JGRK= [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_JGRK"] boolValue];
            if (isDBGL_DBRK_JGRK) {
                cell.secondBtn.selected = YES;
            }else{
                cell.secondBtn.selected = NO;
            }
            BOOL isDBGL_DBRK_PYRK= [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_PYRK"] boolValue];
            if (isDBGL_DBRK_PYRK) {
                cell.thirdBtn.selected = YES;
            }else{
                cell.thirdBtn.selected = NO;
            }
            
            
            
        }else if (indexPath.row == 1){
            cell.touLabel.text = @"大板出库";
            cell.fristLabel.text = @"销售出库";
            cell.secondLabel.text = @"加工出库";
            cell.thirdLabel.text = @"盘亏出库";
            cell.fourLabel.hidden = YES;
            cell.fourBtn.hidden = YES;
            cell.fiveLabel.hidden = YES;
            cell.fiveBtn.hidden = YES;
            cell.sixBtn.hidden = YES;
            cell.sixLabel.hidden = YES;
            cell.sevenBtn.hidden = YES;
            cell.sevenLabel.hidden = YES;
            //DBGL大板管理
            //DBGL_DBCK大板出库
            //DBGL_DBCK_XSCK大板销售出库
            //DBGL_DBCK_JGCK大板加工出库
            //DBGL_DBCK_PKCK大板盘亏出库
            
            BOOL isDBGL_DBCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK"] boolValue];
            if (isDBGL_DBCK) {
                cell.touBtn.selected = YES;
            }else{
                cell.touBtn.selected = NO;
            }
            BOOL isDBGL_DBCK_XSCK= [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_XSCK"] boolValue];
            if (isDBGL_DBCK_XSCK) {
                cell.fristBtn.selected = YES;
            }else{
                cell.fristBtn.selected = NO;
            }
            BOOL isDBGL_DBCK_JGCK= [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_JGCK"] boolValue];
            if (isDBGL_DBCK_JGCK) {
                cell.secondBtn.selected = YES;
            }else{
                cell.secondBtn.selected = NO;
            }
            BOOL isDBGL_DBCK_PKCK= [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_PKCK"] boolValue];
            if (isDBGL_DBCK_PKCK) {
                cell.thirdBtn.selected = YES;
            }else{
                cell.thirdBtn.selected = NO;
            }
        }else if (indexPath.row == 2){
            
            cell.touLabel.text = @"库存管理";
            cell.fristLabel.text = @"异常处理";
            cell.secondLabel.text = @"调拨";
            cell.thirdLabel.text = @"现货展示区";
            
            
            cell.fourLabel.hidden = YES;
            cell.fourBtn.hidden = YES;
            cell.fiveLabel.hidden = YES;
            cell.fiveBtn.hidden = YES;
            cell.sixBtn.hidden = YES;
            cell.sixLabel.hidden = YES;
            cell.sevenBtn.hidden = YES;
            cell.sevenLabel.hidden = YES;
            //DBGL_KCGL大板库存管理
            //DBGL_KCGL_YCCL大板异常处理
            //DBGL_KCGL_DB大板调拨
            //DBGL_KCGL_XHZS 现货展示区
            
            BOOL isDBGL_KCGL = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL"] boolValue];
            if (isDBGL_KCGL) {
                cell.touBtn.selected = YES;
            }else{
                cell.touBtn.selected = NO;
            }
            BOOL isDBGL_KCGL_YCCL= [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_YCCL"] boolValue];
            if (isDBGL_KCGL_YCCL) {
                cell.fristBtn.selected = YES;
            }else{
                cell.fristBtn.selected = NO;
            }
            BOOL isDBGL_KCGL_DB= [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_DB"] boolValue];
            if (isDBGL_KCGL_DB) {
                cell.secondBtn.selected = YES;
            }else{
                cell.secondBtn.selected = NO;
            }
            BOOL isDBGL_KCGL_XHZS= [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_XHZS"] boolValue];
            if (isDBGL_KCGL_XHZS) {
                cell.thirdBtn.selected = YES;
            }else{
                cell.thirdBtn.selected = NO;
            }
            
            
            
            
        }else{
            cell.touLabel.text = @"报表中心";
            cell.fristLabel.text = @"库存余额";
            cell.secondLabel.text = @"库存流水";
            cell.thirdLabel.text = @"入库明细";
            cell.fourLabel.text = @"出库明细";
            cell.fiveLabel.hidden = YES;
            cell.fiveBtn.hidden = YES;
            cell.sixBtn.hidden = YES;
            cell.sixLabel.hidden = YES;
            cell.sevenBtn.hidden = YES;
            cell.sevenLabel.hidden = YES;
            //DBGL_BBZX 大板报表中心
            //DBGL_BBZX_KCYE大板库存余额
            //DBGL_BBZX_KCLS大板库存流水
            //DBGL_BBZX_RKMX大板入库明细
            //DBGL_BBZX_CKMX大板出库明细
            
            
            BOOL isDBGL_BBZX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX"] boolValue];
            if (isDBGL_BBZX) {
                cell.touBtn.selected = YES;
            }else{
                cell.touBtn.selected = NO;
            }
            BOOL isDBGL_BBZX_KCYE= [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCYE"] boolValue];
            if (isDBGL_BBZX_KCYE) {
                cell.fristBtn.selected = YES;
            }else{
                cell.fristBtn.selected = NO;
            }
            BOOL isDBGL_BBZX_KCLS= [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCLS"] boolValue];
            if (isDBGL_BBZX_KCLS) {
                cell.secondBtn.selected = YES;
            }else{
                cell.secondBtn.selected = NO;
            }
            BOOL isDBGL_BBZX_RKMX= [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_RKMX"] boolValue];
            if (isDBGL_BBZX_RKMX) {
                cell.thirdBtn.selected = YES;
            }else{
                cell.thirdBtn.selected = NO;
            }
            BOOL isDBGL_BBZX_CKMX= [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_CKMX"] boolValue];
            if (isDBGL_BBZX_CKMX) {
                cell.fourBtn.selected = YES;
            }else{
                cell.fourBtn.selected = NO;
            }
            
            
            
        }
        cell.touBtn.tag = indexPath.row + 100000000;
        cell.fristBtn.tag = indexPath.row + 100000000;
        cell.secondBtn.tag = indexPath.row + 100000000;
        cell.thirdBtn.tag = indexPath.row + 100000000;
        cell.fourBtn.tag = indexPath.row + 100000000;
        
        [cell.touBtn addTarget:self action:@selector(touSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fristBtn addTarget:self action:@selector(fristSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.secondBtn addTarget:self action:@selector(secondSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.thirdBtn addTarget:self action:@selector(thirdSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fourBtn addTarget:self action:@selector(fourSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 3){
        static NSString * NEWROLEJCSJCELLID = @"NEWROLEJCSJCELLID";
        RSRSNewRoleThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWROLEJCSJCELLID];
        if (!cell) {
            cell = [[RSRSNewRoleThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWROLEJCSJCELLID];
        }
        
        //JCSJ基础数据
        //JCSJ_CKGL仓库管理
        //JCSJ_WLZD物料字典
        //JCSJ_JGC加工厂
        //TYQX通用权利
   
        
        cell.tag = indexPath.section;
        
        cell.fristBtn.tag = indexPath.row + 100000;
        cell.secondBtn.tag = indexPath.row + 100000;
        cell.thirdBtn.tag = indexPath.row + 100000;
        [cell.fristBtn addTarget:self action:@selector(fristOtherAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.secondBtn addTarget:self action:@selector(secondOtherAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.thirdBtn addTarget:self action:@selector(thirdOtherAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.fristLabel.text = @"物料字典";
        cell.secondLabel.text = @"仓库管理";
        cell.thirdLabel.text = @"加工厂";
        BOOL isJCSJ_WLZD= [[self.JurisdictionDict objectForKey:@"JCSJ_WLZD"] boolValue];
        if (isJCSJ_WLZD) {
            cell.fristBtn.selected = YES;
        }else{
            cell.fristBtn.selected = NO;
        }
        BOOL isJCSJ_CKGL= [[self.JurisdictionDict objectForKey:@"JCSJ_CKGL"] boolValue];
        if (isJCSJ_CKGL) {
            cell.secondBtn.selected = YES;
        }else{
            cell.secondBtn.selected = NO;
        }
        BOOL isJCSJ_JGC= [[self.JurisdictionDict objectForKey:@"JCSJ_JGC"] boolValue];
        if (isJCSJ_JGC) {
            cell.thirdBtn.selected = YES;
        }else{
            cell.thirdBtn.selected = NO;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString * NEWROLEXTGLCELLID = @"NEWROLEXTGLCELLID";
        RSRSNewRoleThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWROLEXTGLCELLID];
        if (!cell) {
            cell = [[RSRSNewRoleThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWROLEXTGLCELLID];
        }
         cell.tag = indexPath.section;
        
        //XTGL系统管理
        //XTGL_JSGL角色管理
        //XTGL_YHGL用户管理
        //XTGL_MBGL模板管理
        if (self.usermodel.pwmsUser.roleId == self.rolemodel.roleID) {
            //角色管理
            cell.secondBtn.enabled = NO;
        }else{
            cell.secondBtn.enabled = YES;
        }
        
        
        cell.fristLabel.text = @"用户管理";
        cell.secondLabel.text = @"角色管理";
        cell.thirdLabel.text = @"模板管理";
        BOOL isXTGL_YHGL= [[self.JurisdictionDict objectForKey:@"XTGL_YHGL"] boolValue];
        if (isXTGL_YHGL) {
            cell.fristBtn.selected = YES;
        }else{
            cell.fristBtn.selected = NO;
        }
        BOOL isXTGL_JSGL= [[self.JurisdictionDict objectForKey:@"XTGL_JSGL"] boolValue];
        if (isXTGL_JSGL) {
            cell.secondBtn.selected = YES;
        }else{
            cell.secondBtn.selected = NO;
        }
        
        BOOL isXTGL_MBGL= [[self.JurisdictionDict objectForKey:@"XTGL_MBGL"] boolValue];
        if (isXTGL_MBGL) {
            cell.thirdBtn.selected = YES;
        }else{
            cell.thirdBtn.selected = NO;
        }
        
        cell.fristBtn.tag = indexPath.row + 100000;
        cell.secondBtn.tag = indexPath.row + 100000;
        cell.thirdBtn.tag = indexPath.row + 100000;
        [cell.fristBtn addTarget:self action:@selector(fristOtherAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.secondBtn addTarget:self action:@selector(secondOtherAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.thirdBtn addTarget:self action:@selector(thirdOtherAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)fristOtherAction:(UIButton *)fristBtn{
    UIView *v = [fristBtn superview];//获取父类view
    RSRSNewRoleThirdCell * cell = (RSRSNewRoleThirdCell *)[v superview];
    
    if (cell.tag == 3) {
        //JCSJ基础数据
        //JCSJ_WLZD物料字典
        //JCSJ_CKGL仓库管理
        //TYQX通用权利
        
        fristBtn.selected = !fristBtn.selected;
        if (fristBtn.selected) {
            cell.fristBtn.selected = YES;
        }else{
            cell.fristBtn.selected = NO;
        }
        BOOL isJCSJ_WLZD= [[self.JurisdictionDict objectForKey:@"JCSJ_WLZD"] boolValue];
        isJCSJ_WLZD = cell.fristBtn.selected;
        [self.JurisdictionDict setObject:[NSNumber numberWithBool:isJCSJ_WLZD] forKey:@"JCSJ_WLZD"];
    }else{
        fristBtn.selected = !fristBtn.selected;
        //XTGL系统管理
        //XTGL_YHGL用户管理
        //XTGL_JSGL角色管理
         //XTGL_MBGL模板管理
        if (fristBtn.selected) {
            cell.fristBtn.selected = YES;
        }else{
            cell.fristBtn.selected = NO;
        }
        BOOL isXTGL_YHGL = [[self.JurisdictionDict objectForKey:@"XTGL_YHGL"] boolValue];
        isXTGL_YHGL = cell.fristBtn.selected;
        [self.JurisdictionDict setObject:[NSNumber numberWithBool:isXTGL_YHGL] forKey:@"XTGL_YHGL"];
    }
}

- (void)secondOtherAction:(UIButton *)secondBtn{
    UIView *v = [secondBtn superview];//获取父类view
    RSRSNewRoleThirdCell * cell = (RSRSNewRoleThirdCell *)[v superview];
    if (cell.tag == 3) {
        secondBtn.selected = !secondBtn.selected;
        //JCSJ基础数据
        //JCSJ_WLZD物料字典
        //JCSJ_CKGL仓库管理
        //TYQX通用权利
        if (secondBtn.selected) {
            cell.secondBtn.selected = YES;
        }else{
            cell.secondBtn.selected = NO;
        }
        BOOL isJCSJ_CKGL = [[self.JurisdictionDict objectForKey:@"JCSJ_CKGL"] boolValue];
        isJCSJ_CKGL = cell.secondBtn.selected;
        [self.JurisdictionDict setObject:[NSNumber numberWithBool:isJCSJ_CKGL] forKey:@"JCSJ_CKGL"];
    }else{
        secondBtn.selected = !secondBtn.selected;
        if (secondBtn.selected) {
            //XTGL系统管理
            //XTGL_YHGL用户管理
            //XTGL_JSGL角色管理
             //XTGL_MBGL模板管理
            cell.secondBtn.selected = YES;
        }else{
            cell.secondBtn.selected = NO;
        }
        BOOL isXTGL_JSGL = [[self.JurisdictionDict objectForKey:@"XTGL_JSGL"] boolValue];
        isXTGL_JSGL = cell.secondBtn.selected;
        [self.JurisdictionDict setObject:[NSNumber numberWithBool:isXTGL_JSGL] forKey:@"XTGL_JSGL"];
    }
}

- (void)thirdOtherAction:(UIButton *)thirdBtn{
    
    
    UIView *v = [thirdBtn superview];//获取父类view
    RSRSNewRoleThirdCell * cell = (RSRSNewRoleThirdCell *)[v superview];
    
    if (cell.tag == 3) {
        //JCSJ基础数据
        //JCSJ_WLZD物料字典
        //JCSJ_CKGL仓库管理
        //JCSJ_JGC加工厂
        //TYQX通用权利
        
        thirdBtn.selected = !thirdBtn.selected;
        if (thirdBtn.selected) {
            cell.thirdBtn.selected = YES;
        }else{
            cell.thirdBtn.selected = NO;
        }
        BOOL isJCSJ_JGC= [[self.JurisdictionDict objectForKey:@"JCSJ_JGC"] boolValue];
        isJCSJ_JGC = cell.thirdBtn.selected;
        [self.JurisdictionDict setObject:[NSNumber numberWithBool:isJCSJ_JGC] forKey:@"JCSJ_JGC"];

    }else{
        thirdBtn.selected = !thirdBtn.selected;
        //XTGL系统管理
        //XTGL_YHGL用户管理
        //XTGL_JSGL角色管理
         //XTGL_MBGL模板管理
        if (thirdBtn.selected) {
            cell.thirdBtn.selected = YES;
        }else{
            cell.thirdBtn.selected = NO;
        }
        BOOL isXTGL_MBGL = [[self.JurisdictionDict objectForKey:@"XTGL_MBGL"] boolValue];
        isXTGL_MBGL = cell.thirdBtn.selected;
        [self.JurisdictionDict setObject:[NSNumber numberWithBool:isXTGL_MBGL] forKey:@"XTGL_MBGL"];
    }
}



//头部点击
- (void)touSelectAction:(UIButton *)touBtn{
    UIView *v = [touBtn superview];//获取父类view
    RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v superview];
    //这边要判断是否有修改的值
   // RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v1 superview];
    if (cell.tag == 1) {
        switch (touBtn.tag) {
            case 100000000:
                touBtn.selected = !touBtn.selected;
                
                if (touBtn.selected) {
                    //选中
                    cell.fristBtn.selected = YES;
                    cell.secondBtn.selected = YES;
                    cell.thirdBtn.selected = YES;
                   // cell.fourBtn.selected = YES;
                    //HLGL_HLRK荒料入库
                    //HLGL_HLRK_CGRK 荒料采购入库
                    //HLGL_HLRK_JGRK 荒料加工入库
                    //HLGL_HLRK_PYRK荒料盘盈入库
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                    cell.secondBtn.selected = NO;
                    cell.thirdBtn.selected = NO;
                    //cell.fourBtn.selected = NO;
                }
                BOOL isHLGL_HLRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK"] boolValue];
                isHLGL_HLRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK] forKey:@"HLGL_HLRK"];
                BOOL isHLGL_HLRK_CGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_CGRK"] boolValue];
                isHLGL_HLRK_CGRK = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK_CGRK] forKey:@"HLGL_HLRK_CGRK"];
                BOOL isHLGL_HLRK_JGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_JGRK"] boolValue];
                isHLGL_HLRK_JGRK = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK_JGRK] forKey:@"HLGL_HLRK_JGRK"];
                BOOL isHLGL_HLRK_PYRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_PYRK"] boolValue];
                isHLGL_HLRK_PYRK = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK_PYRK] forKey:@"HLGL_HLRK_PYRK"];
                break;
            case 100000001:
                touBtn.selected = !touBtn.selected;
                if (touBtn.selected) {
                    
                    //HLGL_HLCK 荒料出库
                     //HLGL_HLCK_XSCK荒料销售出库
                    //HLGL_HLCK_JGCK荒料加工出库
                    //HLGL_HLCK_PKCK荒料盘亏出库
                    
                    //选中
                    cell.fristBtn.selected = YES;
                    cell.secondBtn.selected = YES;
                    cell.thirdBtn.selected = YES;
                    //cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                    cell.secondBtn.selected = NO;
                    cell.thirdBtn.selected = NO;
                   // cell.fourBtn.selected = NO;
                }
                BOOL isHLGL_HLCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK"] boolValue];
                isHLGL_HLCK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK] forKey:@"HLGL_HLCK"];
                
                BOOL isHLGL_HLCK_XSCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_XSCK"] boolValue];
                isHLGL_HLCK_XSCK = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK_XSCK] forKey:@"HLGL_HLCK_XSCK"];
                
                BOOL isHLGL_HLCK_JGCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_JGCK"] boolValue];
                isHLGL_HLCK_JGCK = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK_JGCK] forKey:@"HLGL_HLCK_JGCK"];
                
                BOOL isHLGL_HLCK_PKCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_PKCK"] boolValue];
                isHLGL_HLCK_PKCK = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK_PKCK] forKey:@"HLGL_HLCK_PKCK"];
                
                break;
            case 100000002:
                touBtn.selected = !touBtn.selected;
                if (touBtn.selected) {
                    
                    //HLGL_KCGL 库存管理
                    //HLGL_KCGL_YCCL荒料异常处理
                    //HLGL_KCGL_DB荒料调拨
                    //HLGL_KCGL_XHZS 荒料现货搜索
                    //选中
                    cell.fristBtn.selected = YES;
                    cell.secondBtn.selected = YES;
                    cell.thirdBtn.selected = YES;
                   // cell.thirdBtn.selected = YES;
                   // cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                    cell.secondBtn.selected = NO;
                    cell.thirdBtn.selected = NO;
                 //   cell.thirdBtn.selected = NO;
                  //  cell.fourBtn.selected = NO;
                }
                
                BOOL isHLGL_KCGL = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL"] boolValue];
                isHLGL_KCGL = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL] forKey:@"HLGL_KCGL"];
                
                BOOL isHLGL_KCGL_YCCL = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_YCCL"] boolValue];
                isHLGL_KCGL_YCCL = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL_YCCL] forKey:@"HLGL_KCGL_YCCL"];
                
                BOOL isHLGL_KCGL_DB = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_DB"] boolValue];
                isHLGL_KCGL_DB = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL_DB] forKey:@"HLGL_KCGL_DB"];
                
                
                BOOL isHLGL_KCGL_XHZS = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_XHZS"] boolValue];
                isHLGL_KCGL_XHZS = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL_XHZS] forKey:@"HLGL_KCGL_XHZS"];
                
                
                break;
            case 100000003:
                touBtn.selected = !touBtn.selected;
                if (touBtn.selected) {
                    
                    //HLGL_BBZX报表中心
                     //HLGL_BBZX_KCYE荒料库存余额
                    //HLGL_BBZX_KCLS荒料库存流水
                    //HLGL_BBZX_RKMX荒料入库明细
                    //HLGL_BBZX_CKMX 荒料出库明细
                     //加工出库单
                    //选中
                    cell.fristBtn.selected = YES;
                    cell.secondBtn.selected = YES;
                    cell.thirdBtn.selected = YES;
                    cell.fourBtn.selected = YES;
                    cell.fiveBtn.selected = YES;
                    cell.sixBtn.selected = YES;
                    cell.sevenBtn.selected = YES;
                    
                    
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                    cell.secondBtn.selected = NO;
                    cell.thirdBtn.selected = NO;
                    cell.fourBtn.selected = NO;
                    cell.fiveBtn.selected = NO;
                    
                    cell.sixBtn.selected = NO;
                    cell.sevenBtn.selected = NO;
                    
                    
                    
                    
                }
                BOOL isHLGL_BBZX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX"] boolValue];
                isHLGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX] forKey:@"HLGL_BBZX"];
                
                BOOL isHLGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCYE"] boolValue];
                isHLGL_BBZX_KCYE = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_KCYE] forKey:@"HLGL_BBZX_KCYE"];
                
                BOOL isHLGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCLS"] boolValue];
                isHLGL_BBZX_KCLS = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_KCLS] forKey:@"HLGL_BBZX_KCLS"];
                
                BOOL isHLGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_RKMX"] boolValue];
                isHLGL_BBZX_RKMX = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_RKMX] forKey:@"HLGL_BBZX_RKMX"];
                
                BOOL isHLGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CKMX"] boolValue];
                isHLGL_BBZX_CKMX = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_CKMX] forKey:@"HLGL_BBZX_CKMX"];
                
                
                BOOL isHLGL_BBZX_JGGDCZ = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCZ"] boolValue];
                isHLGL_BBZX_JGGDCZ = cell.fiveBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_JGGDCZ] forKey:@"HLGL_BBZX_JGGDCZ"];
                
                
                BOOL isHLGL_BBZX_JGGDCK = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCK"] boolValue];
                isHLGL_BBZX_JGGDCK = cell.sixBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_JGGDCK] forKey:@"HLGL_BBZX_JGGDCK"];
                //还有一个出材率
                
                BOOL isHLGL_BBZX_CCL = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CCL "] boolValue];
                isHLGL_BBZX_CCL = cell.sevenBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_JGGDCK] forKey:@"HLGL_BBZX_CCL "];
                
                
                break;
        }
    }else{
        switch (touBtn.tag) {
            case 100000000:
                touBtn.selected = !touBtn.selected;
                if (touBtn.selected) {
                  //DBGL_DBRK大板入库
                  //DBGL_DBRK_CGRK大板采购入库
                  //DBGL_DBRK_JGRK大板加工入库
                  //DBGL_DBRK_PYRK大板盘盈入库
                    
                  //选中
                  cell.fristBtn.selected = YES;
                  cell.secondBtn.selected = YES;
                  cell.thirdBtn.selected = YES;
                    //cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                    cell.secondBtn.selected = NO;
                    cell.thirdBtn.selected = NO;
                    //cell.fourBtn.selected = NO;
                }
                
                BOOL isDBGL_DBRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK"] boolValue];
                isDBGL_DBRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK] forKey:@"DBGL_DBRK"];
                
                BOOL isDBGL_DBRK_CGRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_CGRK"] boolValue];
                isDBGL_DBRK_CGRK = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK_CGRK] forKey:@"DBGL_DBRK_CGRK"];
                
                BOOL isDBGL_DBRK_JGRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_JGRK"] boolValue];
                isDBGL_DBRK_JGRK = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK_JGRK] forKey:@"DBGL_DBRK_JGRK"];
                
                BOOL isDBGL_DBRK_PYRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_PYRK"] boolValue];
                isDBGL_DBRK_PYRK = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK_PYRK] forKey:@"DBGL_DBRK_PYRK"];
                break;
            case 100000001:
                touBtn.selected = !touBtn.selected;
                if (touBtn.selected) {
                    //DBGL大板管理
                    //DBGL_DBCK大板出库
                    //DBGL_DBCK_XSCK大板销售出库
                    //DBGL_DBCK_JGCK大板加工出库
                    //DBGL_DBCK_PKCK大板盘亏出库

                    //选中
                    cell.fristBtn.selected = YES;
                    cell.secondBtn.selected = YES;
                    cell.thirdBtn.selected = YES;
                   // cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                    cell.secondBtn.selected = NO;
                    cell.thirdBtn.selected = NO;
                   // cell.fourBtn.selected = NO;
                }
                
                
                BOOL isDBGL_DBCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK"] boolValue];
                isDBGL_DBCK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK] forKey:@"DBGL_DBCK"];
                
                BOOL isDBGL_DBCK_XSCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_XSCK"] boolValue];
                isDBGL_DBCK_XSCK = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK_XSCK] forKey:@"DBGL_DBCK_XSCK"];
                
                BOOL isDBGL_DBCK_JGCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_JGCK"] boolValue];
                isDBGL_DBCK_JGCK = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK_JGCK] forKey:@"DBGL_DBCK_JGCK"];
                
                BOOL isDBGL_DBCK_PKCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_PKCK"] boolValue];
                isDBGL_DBCK_PKCK = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK_PKCK] forKey:@"DBGL_DBCK_PKCK"];
                break;
            case 100000002:
                touBtn.selected = !touBtn.selected;
                if (touBtn.selected) {
                    //DBGL_KCGL大板库存管理
                    //DBGL_KCGL_YCCL大板异常处理
                    //DBGL_KCGL_DB大板调拨
                    //DBGL_KCGL_XHZS 大板现货展示区
                    cell.fristBtn.selected = YES;
                    cell.secondBtn.selected = YES;
                    cell.thirdBtn.selected = YES;
                   // cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                    cell.secondBtn.selected = NO;
                    cell.thirdBtn.selected = NO;
                   // cell.fourBtn.selected = NO;
                }
                BOOL isDBGL_KCGL = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL"] boolValue];
                isDBGL_KCGL = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL] forKey:@"DBGL_KCGL"];
                
                BOOL isDBGL_KCGL_YCCL = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_YCCL"] boolValue];
                isDBGL_KCGL_YCCL = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL_YCCL] forKey:@"DBGL_KCGL_YCCL"];
                
                
                BOOL isDBGL_KCGL_DB = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_DB"] boolValue];
                isDBGL_KCGL_DB = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL_DB] forKey:@"DBGL_KCGL_DB"];
                
                
                
                BOOL isDBGL_KCGL_XHZS = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_XHZS"] boolValue];
                isDBGL_KCGL_XHZS = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL_XHZS] forKey:@"DBGL_KCGL_XHZS"];
                
                break;
            case 100000003:
                touBtn.selected = !touBtn.selected;
                if (touBtn.selected) {
                    //DBGL_BBZX 大板报表中心
                     //DBGL_BBZX_KCYE大板库存余额
                     //DBGL_BBZX_KCLS大板库存流水
                     //DBGL_BBZX_RKMX大板入库明细
                     //DBGL_BBZX_CKMX大板出库明细
                    //选中
                    cell.fristBtn.selected = YES;
                    cell.secondBtn.selected = YES;
                    cell.thirdBtn.selected = YES;
                    cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                    cell.secondBtn.selected = NO;
                    cell.thirdBtn.selected = NO;
                    cell.fourBtn.selected = NO;
                }
                BOOL isDBGL_BBZX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX"] boolValue];
                isDBGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX] forKey:@"DBGL_BBZX"];
                
                BOOL isDBGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCYE"] boolValue];
                isDBGL_BBZX_KCYE = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX_KCYE] forKey:@"DBGL_BBZX_KCYE"];
                
                BOOL isDBGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCLS"] boolValue];
                isDBGL_BBZX_KCLS = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX_KCLS] forKey:@"DBGL_BBZX_KCLS"];
                
                BOOL isDBGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_RKMX"] boolValue];
                isDBGL_BBZX_RKMX = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX_RKMX] forKey:@"DBGL_BBZX_RKMX"];
                
                BOOL isDBGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_CKMX"] boolValue];
                isDBGL_BBZX_CKMX = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX_CKMX] forKey:@"DBGL_BBZX_CKMX"];
                break;
        }
    }
}
//第一个按键
- (void)fristSelectAction:(UIButton *)fristBtn{
    UIView *v = [fristBtn superview];//获取父类view
    RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v superview];
    //这边要判断是否有修改的值
    // RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v1 superview];
    if (cell.tag == 1) {
        switch (fristBtn.tag) {
            case 100000000:
                fristBtn.selected = !fristBtn.selected;
                
                if (fristBtn.selected) {
                    //选中
                    cell.fristBtn.selected = YES;
                    //HLGL_HLRK荒料入库
                    //HLGL_HLRK_CGRK 荒料采购入库
                    //HLGL_HLRK_JGRK 荒料加工入库
                    //HLGL_HLRK_PYRK荒料盘盈入库
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                }
                BOOL isHLGL_HLRK_CGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_CGRK"] boolValue];
                isHLGL_HLRK_CGRK = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK_CGRK] forKey:@"HLGL_HLRK_CGRK"];
                BOOL isHLGL_HLRK_JGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_JGRK"] boolValue];
                BOOL isHLGL_HLRK_PYRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_PYRK"] boolValue];
                if (isHLGL_HLRK_CGRK || isHLGL_HLRK_JGRK || isHLGL_HLRK_PYRK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_HLRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK"] boolValue];
                isHLGL_HLRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK] forKey:@"HLGL_HLRK"];
                break;
            case 100000001:
                fristBtn.selected = !fristBtn.selected;
                if (fristBtn.selected) {
                    //HLGL_HLCK 荒料出库
                    //HLGL_HLCK_XSCK荒料销售出库
                    //HLGL_HLCK_JGCK荒料加工出库
                    //HLGL_HLCK_PKCK荒料盘亏出库
                    //选中
                    cell.fristBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                }
                BOOL isHLGL_HLCK_XSCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_XSCK"] boolValue];
                isHLGL_HLCK_XSCK = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK_XSCK] forKey:@"HLGL_HLCK_XSCK"];
                BOOL isHLGL_HLCK_JGCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_JGCK"] boolValue];
                BOOL isHLGL_HLCK_PKCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_PKCK"] boolValue];
                if (isHLGL_HLCK_XSCK || isHLGL_HLCK_JGCK || isHLGL_HLCK_PKCK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_HLCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK"] boolValue];
                isHLGL_HLRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK] forKey:@"HLGL_HLCK"];
                break;
            case 100000002:
                fristBtn.selected = !fristBtn.selected;
                if (fristBtn.selected) {
                    
                    //HLGL_KCGL 库存管理
                    //HLGL_KCGL_YCCL荒料异常处理
                    //HLGL_KCGL_DB荒料调拨
                    //选中
                    cell.fristBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                }
                BOOL isHLGL_KCGL_YCCL = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_YCCL"] boolValue];
                isHLGL_KCGL_YCCL = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL_YCCL] forKey:@"HLGL_KCGL_YCCL"];
                BOOL isHLGL_KCGL_DB = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_DB"] boolValue];
                
                
                BOOL isHLGL_KCGL_XHZS = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_XHZS"] boolValue];
                
                
                
                if (isHLGL_KCGL_YCCL || isHLGL_KCGL_DB || isHLGL_KCGL_XHZS) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_KCGL= [[self.JurisdictionDict objectForKey:@"HLGL_KCGL"] boolValue];
                isHLGL_KCGL = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL] forKey:@"HLGL_KCGL"];
                break;
            case 100000003:
                fristBtn.selected = !fristBtn.selected;
                if (fristBtn.selected) {
                    //HLGL_BBZX报表中心
                    //HLGL_BBZX_KCYE荒料库存余额
                    //HLGL_BBZX_KCLS荒料库存流水
                    //HLGL_BBZX_RKMX荒料入库明细
                    //HLGL_BBZX_CKMX 荒料出库明细
                    //选中
                    cell.fristBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                }
                BOOL isHLGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCYE"] boolValue];
                isHLGL_BBZX_KCYE = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_KCYE] forKey:@"HLGL_BBZX_KCYE"];
                BOOL isHLGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCLS"] boolValue];
                BOOL isHLGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_RKMX"] boolValue];
                BOOL isHLGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CKMX"] boolValue];
                
                
                BOOL isHLGL_BBZX_JGGDCK = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCK"]boolValue];
                
                BOOL isHLGL_BBZX_JGGDCZ = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCZ"]boolValue];
                
                //还有一个出材率
                BOOL isHLGL_BBZX_CCL = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CCL "] boolValue];
                
                if (isHLGL_BBZX_KCYE || isHLGL_BBZX_KCLS || isHLGL_BBZX_RKMX || isHLGL_BBZX_CKMX || isHLGL_BBZX_JGGDCK || isHLGL_BBZX_JGGDCZ || isHLGL_BBZX_CCL) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_BBZX= [[self.JurisdictionDict objectForKey:@"HLGL_BBZX"] boolValue];
                isHLGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX] forKey:@"HLGL_BBZX"];
                break;
        }
    }else{
        switch (fristBtn.tag) {
            case 100000000:
                fristBtn.selected = !fristBtn.selected;
                if (fristBtn.selected) {
                    //DBGL_DBRK大板入库
                    //DBGL_DBRK_CGRK大板采购入库
                    //DBGL_DBRK_JGRK大板加工入库
                    //DBGL_DBRK_PYRK大板盘盈入库
                    //选中
                    cell.fristBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                }
                BOOL isDBGL_DBRK_CGRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_CGRK"] boolValue];
                isDBGL_DBRK_CGRK = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK_CGRK] forKey:@"DBGL_DBRK_CGRK"];
                BOOL isDBGL_DBRK_JGRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_JGRK"] boolValue];
                BOOL isDBGL_DBRK_PYRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_PYRK"] boolValue];
                if (isDBGL_DBRK_CGRK || isDBGL_DBRK_JGRK || isDBGL_DBRK_PYRK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_DBRK= [[self.JurisdictionDict objectForKey:@"DBGL_DBRK"] boolValue];
                isDBGL_DBRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK] forKey:@"DBGL_DBRK"];
                break;
            case 100000001:
                fristBtn.selected = !fristBtn.selected;
                if (fristBtn.selected) {
                    //DBGL大板管理
                    //DBGL_DBCK大板出库
                    //DBGL_DBCK_XSCK大板销售出库
                    //DBGL_DBCK_JGCK大板加工出库
                    //DBGL_DBCK_PKCK大板盘亏出库
                    //选中
                    cell.fristBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                }
                BOOL isDBGL_DBCK_XSCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_XSCK"] boolValue];
                isDBGL_DBCK_XSCK = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK_XSCK] forKey:@"DBGL_DBCK_XSCK"];
                
                BOOL isDBGL_DBCK_JGCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_JGCK"] boolValue];
                BOOL isDBGL_DBCK_PKCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_PKCK"] boolValue];
                if (isDBGL_DBCK_XSCK || isDBGL_DBCK_JGCK || isDBGL_DBCK_PKCK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_DBCK= [[self.JurisdictionDict objectForKey:@"DBGL_DBCK"] boolValue];
                isDBGL_DBCK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK] forKey:@"DBGL_DBCK"];
                break;
            case 100000002:
                fristBtn.selected = !fristBtn.selected;
                if (fristBtn.selected) {
                    //DBGL_KCGL大板库存管理
                    //DBGL_KCGL_YCCL大板异常处理
                    //DBGL_KCGL_DB大板调拨
                    //选中
                    cell.fristBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                }
                BOOL isDBGL_KCGL_YCCL = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_YCCL"] boolValue];
                isDBGL_KCGL_YCCL = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL_YCCL] forKey:@"DBGL_KCGL_YCCL"];
                
                BOOL isDBGL_KCGL_XHZS = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_XHZS"] boolValue];
                
                BOOL isDBGL_KCGL_DB = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_DB"] boolValue];
  
                
                if (isDBGL_KCGL_YCCL || isDBGL_KCGL_DB || isDBGL_KCGL_XHZS) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_KCGL= [[self.JurisdictionDict objectForKey:@"DBGL_KCGL"] boolValue];
                isDBGL_KCGL = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL] forKey:@"DBGL_KCGL"];
                break;
            case 100000003:
                fristBtn.selected = !fristBtn.selected;
                if (fristBtn.selected) {
                    //DBGL_BBZX 大板报表中心
                    //DBGL_BBZX_KCYE大板库存余额
                    //DBGL_BBZX_KCLS大板库存流水
                    //DBGL_BBZX_RKMX大板入库明细
                    //DBGL_BBZX_CKMX大板出库明细
                    //选中
                    cell.fristBtn.selected = YES;
                }else{
                    //取消
                    cell.fristBtn.selected = NO;
                }
                BOOL isDBGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCYE"] boolValue];
                isDBGL_BBZX_KCYE = cell.fristBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX_KCYE] forKey:@"DBGL_BBZX_KCYE"];
                BOOL isDBGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCLS"] boolValue];
                BOOL isDBGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_RKMX"] boolValue];
                BOOL isDBGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_CKMX"] boolValue];
                if (isDBGL_BBZX_KCYE || isDBGL_BBZX_KCLS || isDBGL_BBZX_RKMX || isDBGL_BBZX_CKMX) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_BBZX= [[self.JurisdictionDict objectForKey:@"DBGL_BBZX"] boolValue];
                isDBGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX] forKey:@"DBGL_BBZX"];
                break;
        }
    }
}

//第二个按键

- (void)secondSelectAction:(UIButton *)secondBtn{
    UIView *v = [secondBtn superview];//获取父类view
    RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v superview];
    //这边要判断是否有修改的值
    // RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v1 superview];
    if (cell.tag == 1) {
        switch (secondBtn.tag) {
            case 100000000:
                secondBtn.selected = !secondBtn.selected;
                
                if (secondBtn.selected) {
                    //选中
                    cell.secondBtn.selected = YES;
                    //HLGL_HLRK荒料入库
                    //HLGL_HLRK_CGRK 荒料采购入库
                    //HLGL_HLRK_JGRK 荒料加工入库
                    //HLGL_HLRK_PYRK荒料盘盈入库
                }else{
                    //取消
                    cell.secondBtn.selected = NO;
                }
                BOOL isHLGL_HLRK_JGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_JGRK"] boolValue];
                isHLGL_HLRK_JGRK = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK_JGRK] forKey:@"HLGL_HLRK_JGRK"];
                
                BOOL isHLGL_HLRK_CGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_CGRK"] boolValue];
                BOOL isHLGL_HLRK_PYRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_PYRK"] boolValue];
                
                if (isHLGL_HLRK_CGRK || isHLGL_HLRK_JGRK || isHLGL_HLRK_PYRK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_HLRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK"] boolValue];
                isHLGL_HLRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK] forKey:@"HLGL_HLRK"];
                break;
            case 100000001:
                secondBtn.selected = !secondBtn.selected;
                if (secondBtn.selected) {
                    //HLGL_HLCK 荒料出库
                    //HLGL_HLCK_XSCK荒料销售出库
                    //HLGL_HLCK_JGCK荒料加工出库
                    //HLGL_HLCK_PKCK荒料盘亏出库
                    //选中
                    cell.secondBtn.selected = YES;
                }else{
                    //取消
                    cell.secondBtn.selected = NO;
                }
                BOOL isHLGL_HLCK_JGCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_JGCK"] boolValue];
                isHLGL_HLCK_JGCK = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK_JGCK] forKey:@"HLGL_HLCK_JGCK"];
                
                BOOL isHLGL_HLCK_XSCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_XSCK"] boolValue];
                BOOL isHLGL_HLCK_PKCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_PKCK"] boolValue];
                
                if (isHLGL_HLCK_XSCK || isHLGL_HLCK_JGCK || isHLGL_HLCK_PKCK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_HLCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK"] boolValue];
                isHLGL_HLRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK] forKey:@"HLGL_HLCK"];
                break;
            case 100000002:
                secondBtn.selected = !secondBtn.selected;
                if (secondBtn.selected) {
                    
                    //HLGL_KCGL 库存管理
                    //HLGL_KCGL_YCCL荒料异常处理
                    //HLGL_KCGL_DB荒料调拨
                    //HLGL_KCGL_XHZS 现货展示区
                    cell.secondBtn.selected = YES;
                }else{
                    //取消
                    cell.secondBtn.selected = NO;
                }
                BOOL isHLGL_KCGL_DB = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_DB"] boolValue];
                isHLGL_KCGL_DB = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL_DB] forKey:@"HLGL_KCGL_DB"];
                
                BOOL isHLGL_KCGL_YCCL = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_YCCL"] boolValue];
                
                BOOL isHLGL_KCGL_XHZS = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_XHZS"] boolValue];
                
                
                
                
                
                if (isHLGL_KCGL_YCCL || isHLGL_KCGL_DB || isHLGL_KCGL_XHZS) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_KCGL= [[self.JurisdictionDict objectForKey:@"HLGL_KCGL"] boolValue];
                isHLGL_KCGL = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL] forKey:@"HLGL_KCGL"];
                break;
            case 100000003:
                secondBtn.selected = !secondBtn.selected;
                if (secondBtn.selected) {
                    //HLGL_BBZX报表中心
                    //HLGL_BBZX_KCYE荒料库存余额
                    //HLGL_BBZX_KCLS荒料库存流水
                    //HLGL_BBZX_RKMX荒料入库明细
                    //HLGL_BBZX_CKMX 荒料出库明细
                    //选中
                    cell.secondBtn.selected = YES;
                }else{
                    //取消
                    cell.secondBtn.selected = NO;
                }
                BOOL isHLGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCLS"] boolValue];
                isHLGL_BBZX_KCLS = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_KCLS] forKey:@"HLGL_BBZX_KCLS"];
                
                BOOL isHLGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCYE"] boolValue];
                BOOL isHLGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_RKMX"] boolValue];
                BOOL isHLGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CKMX"] boolValue];
                
                BOOL isHLGL_BBZX_JGGDCK = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCK"]boolValue];
                
                BOOL isHLGL_BBZX_JGGDCZ = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCZ"]boolValue];
                
                //还有一个出材率
                BOOL isHLGL_BBZX_CCL = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CCL "] boolValue];
                
                
                if (isHLGL_BBZX_KCYE || isHLGL_BBZX_KCLS || isHLGL_BBZX_RKMX || isHLGL_BBZX_CKMX || isHLGL_BBZX_JGGDCK || isHLGL_BBZX_JGGDCZ || isHLGL_BBZX_CCL) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_BBZX= [[self.JurisdictionDict objectForKey:@"HLGL_BBZX"] boolValue];
                isHLGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX] forKey:@"HLGL_BBZX"];
                break;
        }
    }else{
        switch (secondBtn.tag) {
            case 100000000:
                secondBtn.selected = !secondBtn.selected;
                if (secondBtn.selected) {
                    //DBGL_DBRK大板入库
                    //DBGL_DBRK_CGRK大板采购入库
                    //DBGL_DBRK_JGRK大板加工入库
                    //DBGL_DBRK_PYRK大板盘盈入库
                    //选中
                    cell.secondBtn.selected = YES;
                }else{
                    //取消
                    cell.secondBtn.selected = NO;
                }
                BOOL isDBGL_DBRK_JGRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_JGRK"] boolValue];
                isDBGL_DBRK_JGRK = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK_JGRK] forKey:@"DBGL_DBRK_JGRK"];
                
                BOOL isDBGL_DBRK_CGRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_CGRK"] boolValue];
                BOOL isDBGL_DBRK_PYRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_PYRK"] boolValue];
                
                if (isDBGL_DBRK_CGRK || isDBGL_DBRK_JGRK || isDBGL_DBRK_PYRK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_DBRK= [[self.JurisdictionDict objectForKey:@"DBGL_DBRK"] boolValue];
                isDBGL_DBRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK] forKey:@"DBGL_DBRK"];
                break;
            case 100000001:
                secondBtn.selected = !secondBtn.selected;
                if (secondBtn.selected) {
                    //DBGL大板管理
                    //DBGL_DBCK大板出库
                    //DBGL_DBCK_XSCK大板销售出库
                    //DBGL_DBCK_JGCK大板加工出库
                    //DBGL_DBCK_PKCK大板盘亏出库
                    //选中
                    cell.secondBtn.selected = YES;
                }else{
                    //取消
                    cell.secondBtn.selected = NO;
                }
                BOOL isDBGL_DBCK_JGCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_JGCK"] boolValue];
                isDBGL_DBCK_JGCK = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK_JGCK] forKey:@"DBGL_DBCK_JGCK"];
                
                BOOL isDBGL_DBCK_XSCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_XSCK"] boolValue];
                BOOL isDBGL_DBCK_PKCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_PKCK"] boolValue];
                if (isDBGL_DBCK_XSCK || isDBGL_DBCK_JGCK || isDBGL_DBCK_PKCK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_DBCK= [[self.JurisdictionDict objectForKey:@"DBGL_DBCK"] boolValue];
                isDBGL_DBCK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK] forKey:@"DBGL_DBCK"];
                break;
            case 100000002:
                secondBtn.selected = !secondBtn.selected;
                if (secondBtn.selected) {
                    //DBGL_KCGL大板库存管理
                    //DBGL_KCGL_YCCL大板异常处理
                    //DBGL_KCGL_DB大板调拨
                    //选中
                    cell.secondBtn.selected = YES;
                }else{
                    //取消
                    cell.secondBtn.selected = NO;
                }
                BOOL isDBGL_KCGL_DB = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_DB"] boolValue];
                isDBGL_KCGL_DB = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL_DB] forKey:@"DBGL_KCGL_DB"];
                
                
                
                BOOL isDBGL_KCGL_YCCL = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_YCCL"] boolValue];
                
                
                BOOL isDBGL_KCGL_XHZS = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_XHZS"] boolValue];
                
                
                if (isDBGL_KCGL_YCCL || isDBGL_KCGL_DB || isDBGL_KCGL_XHZS) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_KCGL= [[self.JurisdictionDict objectForKey:@"DBGL_KCGL"] boolValue];
                isDBGL_KCGL = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL] forKey:@"DBGL_KCGL"];
                break;
            case 100000003:
                secondBtn.selected = !secondBtn.selected;
                if (secondBtn.selected) {
                    //DBGL_BBZX 大板报表中心
                    //DBGL_BBZX_KCYE大板库存余额
                    //DBGL_BBZX_KCLS大板库存流水
                    //DBGL_BBZX_RKMX大板入库明细
                    //DBGL_BBZX_CKMX大板出库明细
                    //选中
                    cell.secondBtn.selected = YES;
                }else{
                    //取消
                    cell.secondBtn.selected = NO;
                }
                BOOL isDBGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCLS"] boolValue];
                isDBGL_BBZX_KCLS = cell.secondBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX_KCLS] forKey:@"DBGL_BBZX_KCLS"];
                BOOL isDBGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCYE"] boolValue];
                BOOL isDBGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_RKMX"] boolValue];
                BOOL isDBGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_CKMX"] boolValue];
                if (isDBGL_BBZX_KCYE || isDBGL_BBZX_KCLS || isDBGL_BBZX_RKMX || isDBGL_BBZX_CKMX) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_BBZX= [[self.JurisdictionDict objectForKey:@"DBGL_BBZX"] boolValue];
                isDBGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX] forKey:@"DBGL_BBZX"];
                break;
        }
    }
    
}

//第三个按键
- (void)thirdSelectAction:(UIButton *)thirdBtn{
    UIView *v = [thirdBtn superview];//获取父类view
    RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v superview];
    //这边要判断是否有修改的值
    // RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v1 superview];
    if (cell.tag == 1) {
        switch (thirdBtn.tag) {
            case 100000000:
                thirdBtn.selected = !thirdBtn.selected;
                
                if (thirdBtn.selected) {
                    //选中
                    cell.thirdBtn.selected = YES;
                    //HLGL_HLRK荒料入库
                    //HLGL_HLRK_CGRK 荒料采购入库
                    //HLGL_HLRK_JGRK 荒料加工入库
                    //HLGL_HLRK_PYRK荒料盘盈入库
                }else{
                    //取消
                    cell.thirdBtn.selected = NO;
                }
                BOOL isHLGL_HLRK_PYRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_PYRK"] boolValue];
                isHLGL_HLRK_PYRK = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK_PYRK] forKey:@"HLGL_HLRK_PYRK"];
                
                BOOL isHLGL_HLRK_CGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_CGRK"] boolValue];
                BOOL isHLGL_HLRK_JGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_JGRK"] boolValue];
                
                if (isHLGL_HLRK_CGRK || isHLGL_HLRK_JGRK || isHLGL_HLRK_PYRK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_HLRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK"] boolValue];
                isHLGL_HLRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK] forKey:@"HLGL_HLRK"];
                break;
            case 100000001:
                thirdBtn.selected = !thirdBtn.selected;
                if (thirdBtn.selected) {
                    //HLGL_HLCK 荒料出库
                    //HLGL_HLCK_XSCK荒料销售出库
                    //HLGL_HLCK_JGCK荒料加工出库
                    //HLGL_HLCK_PKCK荒料盘亏出库
                    //选中
                    cell.thirdBtn.selected = YES;
                }else{
                    //取消
                    cell.thirdBtn.selected = NO;
                }
                BOOL isHLGL_HLCK_PKCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_PKCK"] boolValue];
                isHLGL_HLCK_PKCK = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK_PKCK] forKey:@"HLGL_HLCK_PKCK"];
                
                BOOL isHLGL_HLCK_XSCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_XSCK"] boolValue];
                BOOL isHLGL_HLCK_JGCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_JGCK"] boolValue];
                
                if (isHLGL_HLCK_XSCK || isHLGL_HLCK_JGCK || isHLGL_HLCK_PKCK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_HLCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK"] boolValue];
                isHLGL_HLRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK] forKey:@"HLGL_HLCK"];
                break;
            case 100000002:
                thirdBtn.selected = !thirdBtn.selected;
                if (thirdBtn.selected) {
                    
                    //HLGL_KCGL 库存管理
                    //HLGL_KCGL_YCCL荒料异常处理
                    //HLGL_KCGL_DB荒料调拨
                    //HLGL_KCGL_XHZS现货展示区
                    cell.thirdBtn.selected = YES;
                }else{
                    //取消
                    cell.thirdBtn.selected = NO;
                }
                
                
                BOOL isHLGL_KCGL_XHZS = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_XHZS"] boolValue];
                isHLGL_KCGL_XHZS = cell.thirdBtn.selected;
                
                
                
                
                BOOL isHLGL_KCGL_DB = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_DB"] boolValue];

                
                BOOL isHLGL_KCGL_YCCL = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_YCCL"] boolValue];
                
                
                
                if (isHLGL_KCGL_YCCL || isHLGL_KCGL_DB || isHLGL_KCGL_XHZS) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_KCGL= [[self.JurisdictionDict objectForKey:@"HLGL_KCGL"] boolValue];
                isHLGL_KCGL = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL] forKey:@"HLGL_KCGL"];
                break;
                
                
                
                
            case 100000003:
                thirdBtn.selected = !thirdBtn.selected;
                if (thirdBtn.selected) {
                    //HLGL_BBZX报表中心
                    //HLGL_BBZX_KCYE荒料库存余额
                    //HLGL_BBZX_KCLS荒料库存流水
                    //HLGL_BBZX_RKMX荒料入库明细
                    //HLGL_BBZX_CKMX 荒料出库明细
                    //选中
                    cell.thirdBtn.selected = YES;
                }else{
                    //取消
                    cell.thirdBtn.selected = NO;
                }
                BOOL isHLGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_RKMX"] boolValue];
                isHLGL_BBZX_RKMX = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_RKMX] forKey:@"HLGL_BBZX_RKMX"];
                
                BOOL isHLGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCYE"] boolValue];
                BOOL isHLGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCLS"] boolValue];
                BOOL isHLGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CKMX"] boolValue];
                
                
                BOOL isHLGL_BBZX_JGGDCK = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCK"]boolValue];
                
                BOOL isHLGL_BBZX_JGGDCZ = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCZ"]boolValue];
                
                //还有一个出材率
                BOOL isHLGL_BBZX_CCL = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CCL "] boolValue];
                
                
                
                if (isHLGL_BBZX_KCYE || isHLGL_BBZX_KCLS || isHLGL_BBZX_RKMX || isHLGL_BBZX_CKMX || isHLGL_BBZX_JGGDCK || isHLGL_BBZX_JGGDCZ || isHLGL_BBZX_CCL) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_BBZX= [[self.JurisdictionDict objectForKey:@"HLGL_BBZX"] boolValue];
                isHLGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX] forKey:@"HLGL_BBZX"];
                break;
        }
    }else{
        switch (thirdBtn.tag) {
            case 100000000:
                thirdBtn.selected = !thirdBtn.selected;
                if (thirdBtn.selected) {
                    //DBGL_DBRK大板入库
                    //DBGL_DBRK_CGRK大板采购入库
                    //DBGL_DBRK_JGRK大板加工入库
                    //DBGL_DBRK_PYRK大板盘盈入库
                    //选中
                    cell.thirdBtn.selected = YES;
                }else{
                    //取消
                    cell.thirdBtn.selected = NO;
                }
                BOOL isDBGL_DBRK_PYRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_PYRK"] boolValue];
                isDBGL_DBRK_PYRK = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK_PYRK] forKey:@"DBGL_DBRK_PYRK"];
                
                BOOL isDBGL_DBRK_CGRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_CGRK"] boolValue];
                BOOL isDBGL_DBRK_JGRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_JGRK"] boolValue];
                
                if (isDBGL_DBRK_CGRK || isDBGL_DBRK_JGRK || isDBGL_DBRK_PYRK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_DBRK= [[self.JurisdictionDict objectForKey:@"DBGL_DBRK"] boolValue];
                isDBGL_DBRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK] forKey:@"DBGL_DBRK"];
                break;
            case 100000001:
                thirdBtn.selected = !thirdBtn.selected;
                if (thirdBtn.selected) {
                    //DBGL大板管理
                    //DBGL_DBCK大板出库
                    //DBGL_DBCK_XSCK大板销售出库
                    //DBGL_DBCK_JGCK大板加工出库
                    //DBGL_DBCK_PKCK大板盘亏出库
                    //选中
                    cell.thirdBtn.selected = YES;
                }else{
                    //取消
                    cell.thirdBtn.selected = NO;
                }
                BOOL isDBGL_DBCK_PKCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_PKCK"] boolValue];
                isDBGL_DBCK_PKCK = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK_PKCK] forKey:@"DBGL_DBCK_PKCK"];
                
                BOOL isDBGL_DBCK_XSCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_XSCK"] boolValue];
                BOOL isDBGL_DBCK_JGCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_JGCK"] boolValue];
                if (isDBGL_DBCK_XSCK || isDBGL_DBCK_JGCK || isDBGL_DBCK_PKCK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_DBCK= [[self.JurisdictionDict objectForKey:@"DBGL_DBCK"] boolValue];
                isDBGL_DBCK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK] forKey:@"DBGL_DBCK"];
                break;
            case 100000002:
                
                
                thirdBtn.selected = !thirdBtn.selected;
                if (thirdBtn.selected) {
                    //DBGL_KCGL大板库存管理
                    //DBGL_KCGL_YCCL大板异常处理
                    //DBGL_KCGL_DB大板调拨
                    //DBGL_KCGL_XHZS现货展示
                    cell.thirdBtn.selected = YES;
                }else{
                    //取消
                    cell.thirdBtn.selected = NO;
                }
                BOOL isDBGL_KCGL_XHZS = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_XHZS"] boolValue];
                isDBGL_KCGL_XHZS = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL_XHZS] forKey:@"DBGL_KCGL_XHZS"];
                
                
                BOOL isDBGL_KCGL_DB = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_DB"] boolValue];

                
                BOOL isDBGL_KCGL_YCCL = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_YCCL"] boolValue];
                
                
                if (isDBGL_KCGL_YCCL || isDBGL_KCGL_DB || isDBGL_KCGL_XHZS) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_KCGL= [[self.JurisdictionDict objectForKey:@"DBGL_KCGL"] boolValue];
                isDBGL_KCGL = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL] forKey:@"DBGL_KCGL"];
                break;
            case 100000003:
                thirdBtn.selected = !thirdBtn.selected;
                if (thirdBtn.selected) {
                    //DBGL_BBZX 大板报表中心
                    //DBGL_BBZX_KCYE大板库存余额
                    //DBGL_BBZX_KCLS大板库存流水
                    //DBGL_BBZX_RKMX大板入库明细
                    //DBGL_BBZX_CKMX大板出库明细
                    //选中
                    cell.thirdBtn.selected = YES;
                }else{
                    //取消
                    cell.thirdBtn.selected = NO;
                }
                BOOL isDBGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_RKMX"] boolValue];
                isDBGL_BBZX_RKMX = cell.thirdBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX_RKMX] forKey:@"DBGL_BBZX_RKMX"];
                
                BOOL isDBGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCYE"] boolValue];
                BOOL isDBGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCLS"] boolValue];
                BOOL isDBGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_CKMX"] boolValue];
                if (isDBGL_BBZX_KCYE || isDBGL_BBZX_KCLS || isDBGL_BBZX_RKMX || isDBGL_BBZX_CKMX) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_BBZX= [[self.JurisdictionDict objectForKey:@"DBGL_BBZX"] boolValue];
                isDBGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX] forKey:@"DBGL_BBZX"];
                break;
        }
    }

}

//第四个按键
- (void)fourSelectAction:(UIButton *)fourBtn{
    UIView *v = [fourBtn superview];//获取父类view
    RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v superview];
    //这边要判断是否有修改的值
    // RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v1 superview];
    if (cell.tag == 1) {
        switch (fourBtn.tag) {
            case 100000000:
                //没有数据
                fourBtn.selected = !fourBtn.selected;
                if (fourBtn.selected) {
                    //选中
                    cell.fourBtn.selected = YES;
                    //HLGL_HLRK荒料入库
                    //HLGL_HLRK_CGRK 荒料采购入库
                    //HLGL_HLRK_JGRK 荒料加工入库
                    //HLGL_HLRK_PYRK荒料盘盈入库
                }else{
                    //取消
                    cell.fourBtn.selected = NO;
                }
                BOOL isHLGL_HLRK_PYRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_PYRK"] boolValue];
                isHLGL_HLRK_PYRK = cell.fourBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK_PYRK] forKey:@"HLGL_HLRK_PYRK"];
                
                BOOL isHLGL_HLRK_CGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_CGRK"] boolValue];
                BOOL isHLGL_HLRK_JGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_JGRK"] boolValue];
                
                if (isHLGL_HLRK_CGRK || isHLGL_HLRK_JGRK || isHLGL_HLRK_PYRK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_HLRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK"] boolValue];
                isHLGL_HLRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK] forKey:@"HLGL_HLRK"];
                break;
            case 100000001:
                //没有数据
                fourBtn.selected = !fourBtn.selected;
                if (fourBtn.selected) {
                    //HLGL_HLCK 荒料出库
                    //HLGL_HLCK_XSCK荒料销售出库
                    //HLGL_HLCK_JGCK荒料加工出库
                    //HLGL_HLCK_PKCK荒料盘亏出库
                    //选中
                    cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fourBtn.selected = NO;
                }
                BOOL isHLGL_HLCK_PKCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_PKCK"] boolValue];
                isHLGL_HLCK_PKCK = cell.fourBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK_PKCK] forKey:@"HLGL_HLCK_PKCK"];
                
                BOOL isHLGL_HLCK_XSCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_XSCK"] boolValue];
                BOOL isHLGL_HLCK_JGCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_JGCK"] boolValue];
                
                if (isHLGL_HLCK_XSCK || isHLGL_HLCK_JGCK || isHLGL_HLCK_PKCK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_HLCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK"] boolValue];
                isHLGL_HLRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK] forKey:@"HLGL_HLCK"];
                break;
            case 100000002:
                
                
                //这边没有
                fourBtn.selected = !fourBtn.selected;
                if (fourBtn.selected) {
                    
                    //HLGL_KCGL 库存管理
                    //HLGL_KCGL_YCCL荒料异常处理
                    //HLGL_KCGL_DB荒料调拨
                    //选中
                    cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fourBtn.selected = NO;
                }
                BOOL isHLGL_KCGL_DB = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_DB"] boolValue];
                isHLGL_KCGL_DB = cell.fourBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL_DB] forKey:@"HLGL_KCGL_DB"];
                
                BOOL isHLGL_KCGL_YCCL = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_YCCL"] boolValue];
                
                if (isHLGL_KCGL_YCCL || isHLGL_KCGL_DB) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_KCGL= [[self.JurisdictionDict objectForKey:@"HLGL_KCGL"] boolValue];
                isHLGL_KCGL = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL] forKey:@"HLGL_KCGL"];
                break;
                
                
                
                
            case 100000003:
                fourBtn.selected = !fourBtn.selected;
                if (fourBtn.selected) {
                    //HLGL_BBZX报表中心
                    //HLGL_BBZX_KCYE荒料库存余额
                    //HLGL_BBZX_KCLS荒料库存流水
                    //HLGL_BBZX_RKMX荒料入库明细
                    //HLGL_BBZX_CKMX 荒料出库明细
                    //HLGL_BBZX_JGGDCZ  加工跟单操作
                    //HLGL_BBZX_JGGDCK  加工跟单查看
                    //出材率
                    cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fourBtn.selected = NO;
                }
                BOOL isHLGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CKMX"] boolValue];
                isHLGL_BBZX_CKMX = cell.fourBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_CKMX] forKey:@"HLGL_BBZX_CKMX"];
                
                BOOL isHLGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCYE"] boolValue];
                BOOL isHLGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCLS"] boolValue];
                BOOL isHLGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_RKMX"] boolValue];
                
                 BOOL isHLGL_BBZX_JGGDCK = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCK"]boolValue];
                
                 BOOL isHLGL_BBZX_JGGDCZ = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCZ"]boolValue];
                
                
                //还有一个出材率
                BOOL isHLGL_BBZX_CCL = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CCL "] boolValue];
                
                
                if (isHLGL_BBZX_KCYE || isHLGL_BBZX_KCLS || isHLGL_BBZX_RKMX || isHLGL_BBZX_CKMX || isHLGL_BBZX_JGGDCK || isHLGL_BBZX_JGGDCZ || isHLGL_BBZX_CCL) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_BBZX= [[self.JurisdictionDict objectForKey:@"HLGL_BBZX"] boolValue];
                isHLGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX] forKey:@"HLGL_BBZX"];
                break;
        }
    }else{
        switch (fourBtn.tag) {
            case 100000000:
                 //这边没有
                fourBtn.selected = !fourBtn.selected;
                if (fourBtn.selected) {
                    //DBGL_DBRK大板入库
                    //DBGL_DBRK_CGRK大板采购入库
                    //DBGL_DBRK_JGRK大板加工入库
                    //DBGL_DBRK_PYRK大板盘盈入库
                    //选中
                    cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fourBtn.selected = NO;
                }
                BOOL isDBGL_DBRK_PYRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_PYRK"] boolValue];
                isDBGL_DBRK_PYRK = cell.fourBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK_PYRK] forKey:@"DBGL_DBRK_PYRK"];
                
                BOOL isDBGL_DBRK_CGRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_CGRK"] boolValue];
                BOOL isDBGL_DBRK_JGRK = [[self.JurisdictionDict objectForKey:@"DBGL_DBRK_JGRK"] boolValue];
                
                if (isDBGL_DBRK_CGRK || isDBGL_DBRK_JGRK || isDBGL_DBRK_PYRK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_DBRK= [[self.JurisdictionDict objectForKey:@"DBGL_DBRK"] boolValue];
                isDBGL_DBRK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBRK] forKey:@"DBGL_DBRK"];
                break;
            case 100000001:
                 //这边没有
                fourBtn.selected = !fourBtn.selected;
                if (fourBtn.selected) {
                    //DBGL大板管理
                    //DBGL_DBCK大板出库
                    //DBGL_DBCK_XSCK大板销售出库
                    //DBGL_DBCK_JGCK大板加工出库
                    //DBGL_DBCK_PKCK大板盘亏出库
                    //选中
                    cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fourBtn.selected = NO;
                }
                BOOL isDBGL_DBCK_PKCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_PKCK"] boolValue];
                isDBGL_DBCK_PKCK = cell.fourBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK_PKCK] forKey:@"DBGL_DBCK_PKCK"];
                
                BOOL isDBGL_DBCK_XSCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_XSCK"] boolValue];
                BOOL isDBGL_DBCK_JGCK = [[self.JurisdictionDict objectForKey:@"DBGL_DBCK_JGCK"] boolValue];
                if (isDBGL_DBCK_XSCK || isDBGL_DBCK_JGCK || isDBGL_DBCK_PKCK) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_DBCK= [[self.JurisdictionDict objectForKey:@"DBGL_DBCK"] boolValue];
                isDBGL_DBCK = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_DBCK] forKey:@"DBGL_DBCK"];
                break;
            case 100000002:
                
                //这边没有数据
                fourBtn.selected = !fourBtn.selected;
                if (fourBtn.selected) {
                    //DBGL_KCGL大板库存管理
                    //DBGL_KCGL_YCCL大板异常处理
                    //DBGL_KCGL_DB大板调拨
                    //选中
                    cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fourBtn.selected = NO;
                }
                BOOL isDBGL_KCGL_DB = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_DB"] boolValue];
                isDBGL_KCGL_DB = cell.fourBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL_DB] forKey:@"DBGL_KCGL_DB"];
                BOOL isDBGL_KCGL_YCCL = [[self.JurisdictionDict objectForKey:@"DBGL_KCGL_YCCL"] boolValue];
                if (isDBGL_KCGL_YCCL || isDBGL_KCGL_DB ) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_KCGL= [[self.JurisdictionDict objectForKey:@"DBGL_KCGL"] boolValue];
                isDBGL_KCGL = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_KCGL] forKey:@"DBGL_KCGL"];
                break;
            case 100000003:
                fourBtn.selected = !fourBtn.selected;
                if (fourBtn.selected) {
                    //DBGL_BBZX 大板报表中心
                    //DBGL_BBZX_KCYE大板库存余额
                    //DBGL_BBZX_KCLS大板库存流水
                    //DBGL_BBZX_RKMX大板入库明细
                    //DBGL_BBZX_CKMX大板出库明细
                    //选中
                    cell.fourBtn.selected = YES;
                }else{
                    //取消
                    cell.fourBtn.selected = NO;
                }
                BOOL isDBGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_CKMX"] boolValue];
                isDBGL_BBZX_CKMX = cell.fourBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX_CKMX] forKey:@"DBGL_BBZX_CKMX"];
                
                BOOL isDBGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCYE"] boolValue];
                BOOL isDBGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_KCLS"] boolValue];
                BOOL isDBGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"DBGL_BBZX_RKMX"] boolValue];
                if (isDBGL_BBZX_KCYE || isDBGL_BBZX_KCLS || isDBGL_BBZX_RKMX || isDBGL_BBZX_CKMX) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isDBGL_BBZX= [[self.JurisdictionDict objectForKey:@"DBGL_BBZX"] boolValue];
                isDBGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isDBGL_BBZX] forKey:@"DBGL_BBZX"];
                break;
        }
    }
}


- (void)fiveSelectAction:(UIButton *)fiveBtn{
    UIView *v = [fiveBtn superview];//获取父类view
    RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v superview];
    //这边要判断是否有修改的值
    // RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v1 superview];
    if (cell.tag == 1) {
        switch (fiveBtn.tag) {
//            case 100000000:
//                //没有数据
//                fiveBtn.selected = !fiveBtn.selected;
//                if (fiveBtn.selected) {
//                    //选中
//                    cell.fiveBtn.selected = YES;
//                    //HLGL_HLRK荒料入库
//                    //HLGL_HLRK_CGRK 荒料采购入库
//                    //HLGL_HLRK_JGRK 荒料加工入库
//                    //HLGL_HLRK_PYRK荒料盘盈入库
//                }else{
//                    //取消
//                    cell.fiveBtn.selected = NO;
//                }
//                BOOL isHLGL_HLRK_PYRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_PYRK"] boolValue];
//                isHLGL_HLRK_PYRK = cell.fourBtn.selected;
//                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK_PYRK] forKey:@"HLGL_HLRK_PYRK"];
//
//                BOOL isHLGL_HLRK_CGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_CGRK"] boolValue];
//                BOOL isHLGL_HLRK_JGRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK_JGRK"] boolValue];
//
//                if (isHLGL_HLRK_CGRK || isHLGL_HLRK_JGRK || isHLGL_HLRK_PYRK) {
//                    cell.touBtn.selected = YES;
//                }else{
//                    cell.touBtn.selected = NO;
//                }
//                BOOL isHLGL_HLRK = [[self.JurisdictionDict objectForKey:@"HLGL_HLRK"] boolValue];
//                isHLGL_HLRK = cell.touBtn.selected;
//                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLRK] forKey:@"HLGL_HLRK"];
//                break;
//            case 100000001:
//                //没有数据
//                fiveBtn.selected = !fiveBtn.selected;
//                if (fiveBtn.selected) {
//                    //HLGL_HLCK 荒料出库
//                    //HLGL_HLCK_XSCK荒料销售出库
//                    //HLGL_HLCK_JGCK荒料加工出库
//                    //HLGL_HLCK_PKCK荒料盘亏出库
//                    //选中
//                    cell.fiveBtn.selected = YES;
//                }else{
//                    //取消
//                    cell.fiveBtn.selected = NO;
//                }
//                BOOL isHLGL_HLCK_PKCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_PKCK"] boolValue];
//                isHLGL_HLCK_PKCK = cell.fourBtn.selected;
//                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK_PKCK] forKey:@"HLGL_HLCK_PKCK"];
//
//                BOOL isHLGL_HLCK_XSCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_XSCK"] boolValue];
//                BOOL isHLGL_HLCK_JGCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK_JGCK"] boolValue];
//
//                if (isHLGL_HLCK_XSCK || isHLGL_HLCK_JGCK || isHLGL_HLCK_PKCK) {
//                    cell.touBtn.selected = YES;
//                }else{
//                    cell.touBtn.selected = NO;
//                }
//                BOOL isHLGL_HLCK = [[self.JurisdictionDict objectForKey:@"HLGL_HLCK"] boolValue];
//                isHLGL_HLRK = cell.touBtn.selected;
//                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_HLCK] forKey:@"HLGL_HLCK"];
//                break;
//            case 100000002:
//
//
//                //这边没有
//                fiveBtn.selected = !fiveBtn.selected;
//                if (fiveBtn.selected) {
//
//                    //HLGL_KCGL 库存管理
//                    //HLGL_KCGL_YCCL荒料异常处理
//                    //HLGL_KCGL_DB荒料调拨
//                    //选中
//                    cell.fiveBtn.selected = YES;
//                }else{
//                    //取消
//                    cell.fiveBtn.selected = NO;
//                }
//                BOOL isHLGL_KCGL_DB = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_DB"] boolValue];
//                isHLGL_KCGL_DB = cell.fourBtn.selected;
//                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL_DB] forKey:@"HLGL_KCGL_DB"];
//
//                BOOL isHLGL_KCGL_YCCL = [[self.JurisdictionDict objectForKey:@"HLGL_KCGL_YCCL"] boolValue];
//
//                if (isHLGL_KCGL_YCCL || isHLGL_KCGL_DB) {
//                    cell.touBtn.selected = YES;
//                }else{
//                    cell.touBtn.selected = NO;
//                }
//                BOOL isHLGL_KCGL= [[self.JurisdictionDict objectForKey:@"HLGL_KCGL"] boolValue];
//                isHLGL_KCGL = cell.touBtn.selected;
//                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_KCGL] forKey:@"HLGL_KCGL"];
//                break;
//
//
//
                
            case 100000003:
                fiveBtn.selected = !fiveBtn.selected;
                if (fiveBtn.selected) {
                    //HLGL_BBZX报表中心
                    //HLGL_BBZX_KCYE荒料库存余额
                    //HLGL_BBZX_KCLS荒料库存流水
                    //HLGL_BBZX_RKMX荒料入库明细
                    //HLGL_BBZX_CKMX 荒料出库明细
                    //HLGL_BBZX_JGGDCZ  加工跟单操作
                    //HLGL_BBZX_JGGDCK  加工跟单查看
                    //出材率
                    cell.fiveBtn.selected = YES;
                }else{
                    //取消
                    cell.fiveBtn.selected = NO;
                }
                BOOL isHLGL_BBZX_JGGDCZ = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCZ"] boolValue];
                isHLGL_BBZX_JGGDCZ = cell.fiveBtn.selected;
                
                
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_JGGDCZ] forKey:@"HLGL_BBZX_JGGDCZ"];
                
                
                BOOL isHLGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCYE"] boolValue];
                BOOL isHLGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCLS"] boolValue];
                BOOL isHLGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_RKMX"] boolValue];
                BOOL isHLGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CKMX"] boolValue];
                
                
                BOOL isHLGL_BBZX_JGGDCK = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCK"]boolValue];
                
                //还有一个出材率
                BOOL isHLGL_BBZX_CCL = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CCL "] boolValue];
                
                
                
                if (isHLGL_BBZX_KCYE || isHLGL_BBZX_KCLS || isHLGL_BBZX_RKMX || isHLGL_BBZX_CKMX || isHLGL_BBZX_JGGDCK || isHLGL_BBZX_JGGDCZ || isHLGL_BBZX_CCL) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                BOOL isHLGL_BBZX= [[self.JurisdictionDict objectForKey:@"HLGL_BBZX"] boolValue];
                isHLGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX] forKey:@"HLGL_BBZX"];
                break;
        }
    }
}



- (void)sixSelectAction:(UIButton *)sixBtn{
    
    UIView *v = [sixBtn superview];//获取父类view
    RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v superview];
    //这边要判断是否有修改的值
    // RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v1 superview];
    if (cell.tag == 1) {
        switch (sixBtn.tag) {
            case 100000003:
                sixBtn.selected = !sixBtn.selected;
                if (sixBtn.selected) {
                    //HLGL_BBZX报表中心
                    //HLGL_BBZX_KCYE荒料库存余额
                    //HLGL_BBZX_KCLS荒料库存流水
                    //HLGL_BBZX_RKMX荒料入库明细
                    //HLGL_BBZX_CKMX 荒料出库明细
                    //HLGL_BBZX_JGGDCZ  加工跟单操作
                    //HLGL_BBZX_JGGDCK  加工跟单查看
                    //出材率
                    cell.sixBtn.selected = YES;
                }else{
                    //取消
                    cell.sixBtn.selected = NO;
                }
                BOOL isHLGL_BBZX_JGGDCK = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCK"] boolValue];
                isHLGL_BBZX_JGGDCK = cell.sixBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_JGGDCK] forKey:@"HLGL_BBZX_JGGDCK"];
                
                
                BOOL isHLGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCYE"] boolValue];
                BOOL isHLGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCLS"] boolValue];
                BOOL isHLGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_RKMX"] boolValue];
                BOOL isHLGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CKMX"] boolValue];
                
                
                BOOL isHLGL_BBZX_JGGDCZ = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCZ"]boolValue];
                
                //还有一个出材率
                BOOL isHLGL_BBZX_CCL = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CCL "] boolValue];
                
                
                
                if (isHLGL_BBZX_KCYE || isHLGL_BBZX_KCLS || isHLGL_BBZX_RKMX || isHLGL_BBZX_CKMX || isHLGL_BBZX_JGGDCK || isHLGL_BBZX_JGGDCZ || isHLGL_BBZX_CCL) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                
                BOOL isHLGL_BBZX= [[self.JurisdictionDict objectForKey:@"HLGL_BBZX"] boolValue];
                isHLGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX] forKey:@"HLGL_BBZX"];
                break;
        }
    }
}

- (void)sevenSelectAction:(UIButton *)sevenBtn{
    //出材率
    
    
    //BOOL isHLGL_BBZX_CCL = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CCL "] boolValue];
    UIView *v = [sevenBtn superview];//获取父类view
    RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v superview];
    //这边要判断是否有修改的值
    // RSNewRoleSecondCell * cell = (RSNewRoleSecondCell *)[v1 superview];
    if (cell.tag == 1) {
        switch (sevenBtn.tag) {
            case 100000003:
                sevenBtn.selected = !sevenBtn.selected;
                if (sevenBtn.selected) {
                    //HLGL_BBZX报表中心
                    //HLGL_BBZX_KCYE荒料库存余额
                    //HLGL_BBZX_KCLS荒料库存流水
                    //HLGL_BBZX_RKMX荒料入库明细
                    //HLGL_BBZX_CKMX 荒料出库明细
                    //HLGL_BBZX_JGGDCZ  加工跟单操作
                    //HLGL_BBZX_JGGDCK  加工跟单查看
                    //出材率
                    cell.sevenBtn.selected = YES;
                }else{
                    //取消
                    cell.sevenBtn.selected = NO;
                }
                BOOL isHLGL_BBZX_CCL = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CCL"] boolValue];
                isHLGL_BBZX_CCL = cell.sevenBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX_CCL] forKey:@"HLGL_BBZX_CCL"];
                BOOL isHLGL_BBZX_KCYE = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCYE"] boolValue];
                BOOL isHLGL_BBZX_KCLS = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_KCLS"] boolValue];
                BOOL isHLGL_BBZX_RKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_RKMX"] boolValue];
                BOOL isHLGL_BBZX_CKMX = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_CKMX"] boolValue];
                
                
                BOOL isHLGL_BBZX_JGGDCZ = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCZ"]boolValue];
                
                BOOL isHLGL_BBZX_JGGDCK = [[self.JurisdictionDict objectForKey:@"HLGL_BBZX_JGGDCK "] boolValue];
                
                if (isHLGL_BBZX_KCYE || isHLGL_BBZX_KCLS || isHLGL_BBZX_RKMX || isHLGL_BBZX_CKMX || isHLGL_BBZX_JGGDCK || isHLGL_BBZX_JGGDCZ || isHLGL_BBZX_CCL) {
                    cell.touBtn.selected = YES;
                }else{
                    cell.touBtn.selected = NO;
                }
                
                BOOL isHLGL_BBZX= [[self.JurisdictionDict objectForKey:@"HLGL_BBZX"] boolValue];
                isHLGL_BBZX = cell.touBtn.selected;
                [self.JurisdictionDict setObject:[NSNumber numberWithBool:isHLGL_BBZX] forKey:@"HLGL_BBZX"];
                break;
        }
    }
}




- (void)newRoleTextFieldAction:(UITextField *)titleTextfield{
    NSString *temp = [titleTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] > 0) {
        titleTextfield.text = temp;
        self.tempStr = temp;
    }else{
        titleTextfield.text = @"";
        self.tempStr = @"";
    }
}

- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


@end
