//
//  RSTemplateViewController.m
//  石来石往
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSTemplateViewController.h"
#import "RSTemplateCell.h"
#import "RSNewTemplateViewController.h"
#import "RSTemplateModel.h"


@interface RSTemplateViewController ()
{
  
    UIView * _centerView;
}

@property (nonatomic,strong)NSMutableArray * templateArray;

@end

@implementation RSTemplateViewController

- (NSMutableArray *)templateArray{
    if (!_templateArray) {
        _templateArray = [NSMutableArray array];
    }
    return _templateArray;
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
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.title = @"码单模板";
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableview.estimatedRowHeight = 0;
        self.tableview.estimatedSectionFooterHeight = 0;
        self.tableview.estimatedSectionHeaderHeight = 0;
    }
    
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addBtn setTitle:@"新增" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    [addBtn addTarget:self action:@selector(addNewTemplateAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    self.tableview.hidden = NO;
    
    [self setNoNewDataView];

    [self reloadModelListNewData];
    [self.tableview setupEmptyDataText:@"暂无数据" tapBlock:^{
        
    }];
   
    
}

- (void)addNewTemplateAction:(UIButton *)addBtn{
    RSNewTemplateViewController * newTemplateVc = [[RSNewTemplateViewController alloc]init];
    //newTemplateVc.selectType = self.selectType;
    newTemplateVc.ismodifyStr = @"new";
    //newTemplateVc.selectType = self.selectType;
    [self.navigationController pushViewController:newTemplateVc animated:YES];
    newTemplateVc.reload = ^(BOOL isreload) {
        if (isreload) {
            [self reloadModelListNewData];
        }
    };
}

- (void)setNoNewDataView{
  
    UIView * centerView = [[UIView alloc]initWithFrame:CGRectMake(SCW/2 - 80, SCH/2 - 135, 160, 270)];
    centerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:centerView];
    _centerView = centerView;
    [centerView bringSubviewToFront:self.view];
    //图片
    UIImageView * centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 190,160)];
    centerImageView.image = [UIImage imageNamed:@"空箱子"];
    centerImageView.clipsToBounds = YES;
    centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [centerView addSubview:centerImageView];
    
    
    //文字
    UILabel * centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(centerImageView.frame) + 25, 160, 25)];
    centerLabel.text = @"暂无模板";
    centerLabel.font = [UIFont systemFontOfSize:18];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    [centerView addSubview:centerLabel];
    
    //按键
    UIButton * centerBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(centerLabel.frame) + 25, 110, 35)];
    [centerBtn setTitle:@"去新建" forState:UIControlStateNormal];
    [centerBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
   [centerBtn addTarget:self action:@selector(warehouseRunningAccountAction:) forControlEvents:UIControlEventTouchUpInside];
    [centerBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [centerView addSubview:centerBtn];
    centerBtn.layer.cornerRadius = 15;
}

- (void)warehouseRunningAccountAction:(UIButton *)centerBtn{
    RSNewTemplateViewController * newTemplateVc = [[RSNewTemplateViewController alloc]init];
//    newTemplateVc.selectType = self.selectType;
    newTemplateVc.ismodifyStr = @"new";
    [self.navigationController pushViewController:newTemplateVc animated:YES];
    newTemplateVc.reload = ^(BOOL isreload) {
        if (isreload) {
            [self reloadModelListNewData];
        }
    };
}

- (void)reloadModelListNewData{
//    NSString * str = [NSString string];
   // NSString * ulr = @"http://192.168.1.128:8080/slsw/pwms/modelList.do";
    //TableModel * tableModel = [[TableModel alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:@"ALL" forKey:@"modelType"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:dict forKey:@"tableModel"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_MODELLIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.templateArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"];
                for (int i = 0; i < array.count; i++) {
                    
                  RSTemplateModel * templatemodel = [[RSTemplateModel alloc]init];
                    templatemodel.tempID = [[[array objectAtIndex:i]objectForKey:@"id"]integerValue];
                    templatemodel.pwmsUserId = [[[array objectAtIndex:i]objectForKey:@"pwmsUserId"]integerValue];
                    templatemodel.isDefault = [[[array objectAtIndex:i]objectForKey:@"isDefault"]integerValue];
                        templatemodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                      templatemodel.createUser = [[array objectAtIndex:i]objectForKey:@"createUser"];
                      templatemodel.image = [[array objectAtIndex:i]objectForKey:@"image"];
                      templatemodel.model = [[array objectAtIndex:i]objectForKey:@"model"];
                      templatemodel.modelName = [[array objectAtIndex:i]objectForKey:@"modelName"];
                      templatemodel.modelType = [[array objectAtIndex:i]objectForKey:@"modelType"];
                      templatemodel.notes = [[array objectAtIndex:i]objectForKey:@"notes"];
                      templatemodel.status = [[array objectAtIndex:i]objectForKey:@"status"];
                      templatemodel.updateUser = [[array objectAtIndex:i]objectForKey:@"updateUser"];
                     templatemodel.updateTime = [[array objectAtIndex:i]objectForKey:@"updateTime"];
                    [weakSelf.templateArray addObject:templatemodel];
                }
                
                
                if (weakSelf.templateArray.count > 0) {
                    _centerView.hidden = YES;
                    
                }else{
                    _centerView.hidden = NO;
                }
                [weakSelf.tableview reloadData];
                
            }else{
                if (weakSelf.templateArray.count > 0) {
                    _centerView.hidden = YES;
                    
                }else{
                    _centerView.hidden = NO;
                }
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            if (weakSelf.templateArray.count > 0) {
                _centerView.hidden = YES;
                
            }else{
                _centerView.hidden = NO;
            }
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.templateArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * TEMPLATECELLID = @"TEMPLATECELLID";
    RSTemplateCell * cell = [tableView dequeueReusableCellWithIdentifier:TEMPLATECELLID];
    if (!cell) {
        cell = [[RSTemplateCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TEMPLATECELLID];
    }
    
    RSTemplateModel * templatemodel = self.templateArray[indexPath.row];
    cell.nameDetialLabel.text = templatemodel.modelName;
    if ([templatemodel.status integerValue] == 0) {
        
        cell.statusLabel.text = @"审核中";
        cell.statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FFBB04"];
        
    }else if ([templatemodel.status integerValue] == 1){
        
        cell.statusLabel.text = @"正常";
        cell.statusLabel.textColor = [UIColor colorWithHexColorStr:@"#13AB80"];
        
    }else if ([templatemodel.status integerValue] == 2){
        
        cell.statusLabel.text = @"删除";
        cell.statusLabel.textColor = [UIColor colorWithHexColorStr:@"#BA182C"];
        
    }else{
        cell.statusLabel.text = @"审核不通过";
        cell.statusLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    }
    cell.editBtn.tag = indexPath.row;
    cell.deleteBtn.tag = indexPath.row;
    [cell.editBtn addTarget:self action:@selector(editTmeplateAction:) forControlEvents:UIControlEventTouchUpInside];
     [cell.deleteBtn addTarget:self action:@selector(deleteTmeplateAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)editTmeplateAction:(UIButton *)editBtn{
    RSTemplateModel * templatemodel = self.templateArray[editBtn.tag];
    RSNewTemplateViewController * newTemplateVc = [[RSNewTemplateViewController alloc]init];
    newTemplateVc.ismodifyStr = @"modify";
    //newTemplateVc.selectType = self.selectType;
    newTemplateVc.templatemodel = templatemodel;
    [self.navigationController pushViewController:newTemplateVc animated:YES];
    newTemplateVc.reload = ^(BOOL isreload) {
        if (isreload) {
            [self reloadModelListNewData];
        }
    };
}


- (void)deleteTmeplateAction:(UIButton *)deleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该模板" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         RSTemplateModel * templatemodel = self.templateArray[deleteBtn.tag];
        [self modifyContent:templatemodel];
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


- (void)modifyContent:(RSTemplateModel *)templatemodel{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    
    NSMutableDictionary * modeldict = [NSMutableDictionary dictionary];
    [modeldict setObject:[NSNumber numberWithInteger:templatemodel.tempID] forKey:@"id"];
    [phoneDict setObject:modeldict forKey:@"tableModel"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DELETEMODEL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                if (weakSelf.templateArray.count > 0) {
                    _centerView.hidden = YES;
                    
                }else{
                    _centerView.hidden = NO;
                }
                [weakSelf reloadModelListNewData];
            }else{
                if (weakSelf.templateArray.count > 0) {
                    _centerView.hidden = YES;
                    
                }else{
                    _centerView.hidden = NO;
                }
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
        }else{
            if (weakSelf.templateArray.count > 0) {
                _centerView.hidden = YES;
                
            }else{
                _centerView.hidden = NO;
            }
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }
    }];
    
    
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
