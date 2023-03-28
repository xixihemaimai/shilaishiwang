//
//  RSAuditStatusViewController.m
//  石来石往
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAuditStatusViewController.h"

#import "RSAuditStatusCustomTableViewCell.h"

#import "RSShowAuditStatusView.h"

/**模型*/
#import "RSAuditStatusModel.h"

@interface RSAuditStatusViewController ()

//@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,strong)NSMutableArray * statusArray;
/**审核状态*/
@property (nonatomic,strong)NSString * billStatus;
/**钱的情况*/
@property (nonatomic,strong)NSString * feeMsg;
/**保存高度*/
@property (nonatomic,strong)UIView * titleView;
// 用来存放Cell的唯一标示符未完成
@property (nonatomic, strong) NSMutableDictionary *cellPersonNoCompelteDic;


@end

@implementation RSAuditStatusViewController

- (NSMutableArray *)statusArray{
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    return _statusArray;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self isAddjust];
    
    self.title = @"审核状态";
    [self obtainOwnerAuditStatusMoney];
}




- (void)loadAuditStatusNetworkData{
    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.outBoundNo forKey:@"outBoundNo"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETERPAPPROVALINFO_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
//            CLog(@"=========================%@",json);
//            CLog(@"=========================%@",json[@"Data"][@"billStatus"]);
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
               [weakSelf.statusArray removeAllObjects];
//                NSMutableArray * array = [NSMutableArray array];
//                array = json[@"Data"][@"list"];
                weakSelf.billStatus = json[@"Data"][@"billStatus"];
                weakSelf.statusArray = [RSAuditStatusModel mj_objectArrayWithKeyValuesArray:json[@"Data"][@"list"]];
//                for (int i = 0; i < array.count; i++) {
//                    RSAuditStatusModel * auditStatusmodel = [[RSAuditStatusModel alloc]init];
//                    auditStatusmodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
//                    auditStatusmodel.workItemName = [[array objectAtIndex:i]objectForKey:@"workItemName"];
//                    auditStatusmodel.finishTime = [[array objectAtIndex:i]objectForKey:@"finishTime"];
//                    auditStatusmodel.userName = [[array objectAtIndex:i]objectForKey:@"userName"];
//                    auditStatusmodel.userPhone = [[array objectAtIndex:i]objectForKey:@"userPhone"];
//                    auditStatusmodel.userInfo = [[array objectAtIndex:i]objectForKey:@"userInfo"];
//                    auditStatusmodel.resultInfo = [[array objectAtIndex:i]objectForKey:@"resultInfo"];
//                    auditStatusmodel.workItemId = [[array objectAtIndex:i]objectForKey:@"workItemId"];
//                    [weakSelf.statusArray addObject:auditStatusmodel];
//                }
//                CLog(@"================================%ld",weakSelf.statusArray.count);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf setAuditStatusCustomTableview];
                });
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview reloadData];
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
                [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)obtainOwnerAuditStatusMoney{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    [dict setObject:@"1" forKey:@"erpId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
   RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_ERPFEE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
//            CLog(@"========23=======================%@",json);
            if (Result) {
                
                //仓储超期欠款 deaStorageOverFee ¥ （截止至：deaStorageDay），加工超期欠款deaMachiningOverFee¥（截止至：deaMachiningDay）
                //@"仓储超期欠款%@¥(截止至:%@),加工超期欠款%@¥(截止至:%@)",json[@"Data"][@"deaStorageOverFee"],json[@"Data"][@"deaStorageDay"],json[@"Data"][@"deaMachiningOverFee"],json[@"Data"][@"deaMachiningDay"]
                weakSelf.feeMsg = [NSString stringWithFormat:@"仓储欠款:%@元\n加工欠款:%@元",json[@"Data"][@"currentWarehouseCharge"],json[@"Data"][@"currentProcessCharge"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf setCustomTitleView];
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}

- (void)setCustomTitleView{
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
    /**显示*/
    UIView * titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor colorWithHexColorStr:@"#ff943d"];
    [self.view addSubview:titleView];
    _titleView = titleView;
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.numberOfLines = 2;
//    titleLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ff943d"];
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    titleLabel.text = self.feeMsg;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleView addSubview:titleLabel];
    CGRect textFrame = titleLabel.frame;
    CGSize size = CGSizeMake(SCW , MAXFLOAT);
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:titleLabel.font, NSFontAttributeName,nil];
    textFrame = [titleLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesDeviceMetrics attributes:dic context:nil];

//    NSLog(@"=======================%f--------%f",textFrame.size.width,textFrame.size.height);
    
    titleView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(textFrame.size.height);
    
    
    
    titleLabel.sd_layout
    .topSpaceToView(titleView, 0)
    .centerXEqualToView(titleView)
    .heightIs(textFrame.size.height)
    .widthIs(textFrame.size.width);
    
     [self loadAuditStatusNetworkData];
}



//FIXME:这边是设置UItableview
- (void)setAuditStatusCustomTableview{
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, self.titleView.yj_height + navY + navHeight, SCW, SCH - (navY + navHeight + self.titleView.yj_height)) style:UITableViewStylePlain];
//    self.tableview = tableview;
//
//    self.tableview.showsHorizontalScrollIndicator = NO;
//    self.tableview.showsVerticalScrollIndicator = NO;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableview];
//
    
    [self.view addSubview:self.tableview];
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame), SCW, SCH - Height_NavBar - self.titleView.yj_height);
    
    //涮新
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadAuditStatusNetworkData];
    }];
    
    //这边设置表视图头
    UIView * auditStatusHeaderview = [[UIView alloc]init];
    auditStatusHeaderview.backgroundColor = [UIColor whiteColor];
    
    
    RSShowAuditStatusView * showAudioStatusview = [[RSShowAuditStatusView alloc]init];
    [auditStatusHeaderview addSubview:showAudioStatusview];
    
    
//    showAudioStatusview.auditStatusLabelview.sd_layout
//    .leftSpaceToView(showAudioStatusview.centerView, 16)
//    .bottomEqualToView(showAudioStatusview.firstLabel)
//    .heightIs(30)
//    .widthIs(60);
//    showAudioStatusview.firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#ff943d"];
//    showAudioStatusview.firstLabel.hidden = YES;
    //showAudioStatusview.auditStatusLabelview.titleLabel.text = @"提交";
    
    
    
//    showAudioStatusview.auditStatusLabelview.sd_layout
//    .centerXEqualToView(showAudioStatusview.centerView)
//    .bottomEqualToView(showAudioStatusview.secondLabel)
//    .widthIs(60)
//    .heightIs(30);
  //  showAudioStatusview.secondLabel.hidden = YES;
    //showAudioStatusview.firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#ff943d"];
     //showAudioStatusview.auditStatusLabelview.titleLabel.text = @"审核中";
    
    
    CGFloat x = 0.0;
    if ([self.billStatus isEqualToString:@"提交"]) {
        showAudioStatusview.firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#ff943d"];
        showAudioStatusview.firstLabel.hidden = YES;
        showAudioStatusview.auditStatusLabelview.titleLabel.text = @"提交";
        x = 12 + 35;
    }else if ([self.billStatus isEqualToString:@"审核中"]){
        showAudioStatusview.secondLabel.hidden = YES;
        showAudioStatusview.secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#ff943d"];
        showAudioStatusview.auditStatusLabelview.titleLabel.text = @"审核中";
        x = (SCW - (24))/2;
    }else if([self.billStatus isEqualToString:@"完成"]){
        showAudioStatusview.thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#ff943d"];
        showAudioStatusview.thirdLabel.hidden = YES;
        showAudioStatusview.auditStatusLabelview.titleLabel.text = @"完成";
        x = SCW - (24 + 40 + 7.5);
    }else{
        showAudioStatusview.auditStatusLabelview.titleLabel.text = @"";
        showAudioStatusview.auditStatusLabelview.hidden = YES;
        x = 0;
    }
    
    CABasicAnimation * baseanimation = [CABasicAnimation animationWithKeyPath:@"position"];
    baseanimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0,76 - 45)];
    baseanimation.toValue = [NSValue valueWithCGPoint:CGPointMake(x ,76 - 45)];
    baseanimation.duration = 1.0f;
    baseanimation.fillMode = kCAFillModeForwards;
    baseanimation.removedOnCompletion = NO;
    [showAudioStatusview.auditStatusLabelview.layer addAnimation:baseanimation forKey:@"positionAnimation"];

    showAudioStatusview.auditStatusLabelview.sd_layout
    // .rightSpaceToView(showAudioStatusview.centerView, 16)
    // .bottomEqualToView(showAudioStatusview.thirdLabel)
    .heightIs(30)
    .widthIs(60);
 
    showAudioStatusview.sd_layout
    .leftSpaceToView(auditStatusHeaderview, 0)
    .rightSpaceToView(auditStatusHeaderview, 0)
    .topSpaceToView(auditStatusHeaderview, 0)
    .heightIs(100);
    
    [auditStatusHeaderview setupAutoHeightWithBottomView:showAudioStatusview bottomMargin:0];
    [auditStatusHeaderview layoutSubviews];
    self.tableview.tableHeaderView = auditStatusHeaderview;

}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [_cellPersonNoCompelteDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%@%@", @"AUDITSTATUSCELLID", [NSString stringWithFormat:@"%@", indexPath]];
        [_cellPersonNoCompelteDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        // 注册Cell
    }
    RSAuditStatusCustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RSAuditStatusCustomTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //这边是要对第一个cell的显示并显示内容进行设置
    if (indexPath.row == 0) {
        cell.upView.hidden = YES;
        [cell.centerBtn setTitle:@"提" forState:UIControlStateNormal];
    }else{
        [cell.centerBtn setTitle:@"审" forState:UIControlStateNormal];
    }
    //这边怎么去判断显示的颜色
    RSAuditStatusModel * auditStatusmodel = self.statusArray[indexPath.row];
    RSAuditStatusModel * auditStatusNextmodel = [[RSAuditStatusModel alloc]init];
    if ((indexPath.row + 1) <= self.statusArray.count - 1) {
      auditStatusNextmodel  = self.statusArray[indexPath.row + 1];
    }
    if ([auditStatusmodel.resultInfo isEqualToString:@"通过"]) {
        //这边是通过的
        [cell.centerBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#7bd020"]];
        cell.upView.backgroundColor = [UIColor colorWithHexColorStr:@"#7bd020"];
        cell.timeLabel.hidden = NO;
        if ([auditStatusmodel.resultInfo isEqualToString:auditStatusNextmodel.resultInfo]) {
            cell.lowView.backgroundColor = [UIColor colorWithHexColorStr:@"#7bd020"];
            
        }else{
            if ([auditStatusNextmodel.resultInfo isEqualToString:@"不通过"]) {
                 cell.lowView.backgroundColor = [UIColor redColor];
            }else{
                 cell.lowView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
            }
        }
    }else if([auditStatusmodel.resultInfo isEqualToString:@"不通过"]){
        //这边是不通过的
        cell.timeLabel.hidden = NO;
        [cell.centerBtn setBackgroundColor:[UIColor redColor]];
        cell.upView.backgroundColor = [UIColor colorWithHexColorStr:@"#e71c1c"];
        if ([auditStatusmodel.resultInfo isEqualToString:auditStatusNextmodel.resultInfo]) {
            cell.lowView.backgroundColor = [UIColor colorWithHexColorStr:@"#e71c1c"];
        }else{
            if ([auditStatusNextmodel.resultInfo isEqualToString:@"通过"]) {
                cell.lowView.backgroundColor = [UIColor colorWithHexColorStr:@"#7bd020"];
            }else{
                cell.lowView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
            }
        }
    }
    else{
        cell.timeLabel.hidden = YES;
        [cell.centerBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#cfcfcf"]];
        cell.upView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        cell.lowView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
    }
    //控制最后一个cell的lowview显示不显示，并对要显示什么
    if (indexPath.row == (self.statusArray.count - 1)) {
        cell.lowView.hidden = YES;
        [cell.centerBtn setTitle:@"" forState:UIControlStateNormal];
        [cell.centerBtn setImage:[UIImage imageNamed:@"对"] forState:UIControlStateNormal];
    }
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",auditStatusmodel.workItemName];
    cell.contactLabel.text = [NSString stringWithFormat:@"联系人:%@%@",auditStatusmodel.userName,auditStatusmodel.userPhone];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",auditStatusmodel.finishTime];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
