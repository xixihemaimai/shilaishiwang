//
//  RSRevokeProgressViewController.m
//  石来石往
//
//  Created by mac on 2020/4/1.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSRevokeProgressViewController.h"
#import "RSRevokeCell.h"
#import "RSRevokeModel.h"

@interface RSRevokeProgressViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,strong)NSMutableArray * statusArray;

@end

@implementation RSRevokeProgressViewController

- (NSMutableArray *)statusArray{
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    return _statusArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"撤销记录";
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setTableView];
    //    [self setCustomTitleView];
}

- (void)setCustomTitleView{
    //    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    //    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
    /**显示*/
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    //    [self.view addSubview:headerView];
    //    _titleView = titleView;
    
    UILabel * titleLabel = [[UILabel alloc]init];
    //    titleLabel.numberOfLines = 0;
    //    titleLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ff943d"];
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:titleLabel];
    
    UILabel * statusLabel = [[UILabel alloc]init];
    statusLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    statusLabel.text = @"状态:状态";
    statusLabel.numberOfLines = 0;
    statusLabel.font = [UIFont systemFontOfSize:16];
    statusLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:statusLabel];
    
    UILabel * showLabel = [[UILabel alloc]init];
    showLabel.textColor = [UIColor redColor];
    showLabel.text = @"撤销审核中";
    showLabel.numberOfLines = 0;
    showLabel.font = [UIFont systemFontOfSize:16];
    showLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:showLabel];
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
    [headerView addSubview:midView];
    
    RSRevokeModel * revokemodel = self.statusArray[0];
    titleLabel.text = [NSString stringWithFormat:@"出库单号:%@",revokemodel.outBoundNo];
    statusLabel.text = [NSString stringWithFormat:@"状态:%@",revokemodel.optType];
    
    titleLabel.sd_layout
    .leftSpaceToView(headerView, 12)
    .rightSpaceToView(headerView, 12)
    .topSpaceToView(headerView, 0)
    .heightIs(20);
    
    CGSize size = CGSizeMake(SCW - 24 , MAXFLOAT);
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:statusLabel.font, NSFontAttributeName,nil];
    CGRect textFrame = [statusLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesDeviceMetrics attributes:dic context:nil];
    
    statusLabel.sd_layout
    .leftEqualToView(titleLabel)
    .rightEqualToView(titleLabel)
    .topSpaceToView(titleLabel, 5)
    .heightIs(textFrame.size.height);
    
    if ([revokemodel.optType isEqualToString:@"申请撤销"]) {
        showLabel.hidden = NO;
        showLabel.sd_layout
        .leftEqualToView(statusLabel)
        .rightEqualToView(statusLabel)
        .topSpaceToView(statusLabel, 5)
        .heightIs(20);
    }else{
        showLabel.hidden = YES;
        showLabel.sd_layout
        .leftEqualToView(statusLabel)
        .rightEqualToView(statusLabel)
        .topSpaceToView(statusLabel, 5)
        .heightIs(0);
    }
    
    midView.sd_layout
    .leftSpaceToView(headerView, 0)
    .rightSpaceToView(headerView, 0)
    .heightIs(5)
    .topSpaceToView(showLabel, 0);
    
    [headerView setupAutoHeightWithBottomView:midView bottomMargin:0];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
}

- (void)loadAuditStatusNetworkData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":self.outBoundNo,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_CANCELLOG_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"success"] boolValue];
            if (Result) {
                [weakSelf.statusArray removeAllObjects];
                weakSelf.statusArray = [RSRevokeModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf setCustomTitleView];
                    [weakSelf setCustomBottomView];
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

- (void)setCustomBottomView{
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FCAF1B"]];
    [cancelBtn setTitle:@"撤销出库" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelOutBoundAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    [cancelBtn bringSubviewToFront:self.view];
    RSRevokeModel * revokemodel = self.statusArray[0];
    if ([revokemodel.optType isEqualToString:@"撤销驳回"]) {
        cancelBtn.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 0)
        .heightIs(50);
    }else{
        cancelBtn.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 0)
        .heightIs(0);
    }
}

- (void)cancelOutBoundAction:(UIButton *)cancelBtn{
    //只有审核中和待发货才能点击
    RSWeakself
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否撤销出库" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
    } confirm:^{
        //网络请求
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = [NSDictionary dictionary];
        parameters = @{@"key":[NSString get_uuid] ,@"Data":self.outBoundNo,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_APPLYCANCEL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"success"] boolValue];
                if (Result) {
                    if (weakSelf.cancelStatus) {
                        weakSelf.cancelStatus(true);
                    }
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    //这边要怎么做的
                    //RSShippingCell * cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:cancelBtn.tag inSection:0]];
                    //[cell.cancelBtn setTitle:@"撤销记录" forState:UIControlStateNormal];
                    //cell.cancelBtn.hidden = NO;
                }else{
                    [SVProgressHUD showErrorWithStatus:@"撤销申请失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"撤销申请失败"];
            }
        }];
    }];
}

- (void)setTableView{
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame), SCW, SCH)  style:UITableViewStylePlain];
    self.tableview = tableview;
    self.tableview.showsHorizontalScrollIndicator = NO;
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    [self.view addSubview:self.tableview];
    //涮新
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadAuditStatusNetworkData];
    }];
    [self.tableview.mj_header beginRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELL = @"CCECC";
    RSRevokeCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if (!cell) {
        cell = [[RSRevokeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL];
    }
    
    RSRevokeModel * auditStatusmodel = self.statusArray[indexPath.row];
    if (self.statusArray.count <= 1) {
        cell.upView.hidden = YES;
        cell.lowView.hidden = YES;
        cell.titleLabel.text = [NSString stringWithFormat:@"%@ 发起",auditStatusmodel.createUserName];
        cell.contactLabel.text = [NSString stringWithFormat:@"%@",auditStatusmodel.optType];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@",auditStatusmodel.createTime];
        cell.titleLabel.textColor = [UIColor colorWithHexColorStr:@"#FCAF1B"];
        cell.contactLabel.textColor = [UIColor colorWithHexColorStr:@"#FCAF1B"];
        cell.timeLabel.textColor = [UIColor colorWithHexColorStr:@"#FCAF1B"];
        cell.midView.backgroundColor =  [UIColor colorWithHexColorStr:@"#FCAF1B"];
    }else{
        if (indexPath.row == 0) {
            cell.timeLabel.text = [NSString stringWithFormat:@"%@",auditStatusmodel.createTime];
            cell.timeLabel.textColor = [UIColor colorWithHexColorStr:@"#FCAF1B"];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",auditStatusmodel.optType];
            cell.titleLabel.textColor = [UIColor colorWithHexColorStr:@"#FCAF1B"];
            
            if ([auditStatusmodel.optDescribe isEqualToString:@""]) {
                cell.contactLabel.hidden = YES;
                cell.timeLabel.sd_layout
                .topSpaceToView(cell.titleLabel, 0);
            }else{
                cell.contactLabel.hidden = NO;
                cell.contactLabel.text = [NSString stringWithFormat:@"原因:%@",auditStatusmodel.optDescribe];
                cell.timeLabel.sd_layout
                .topSpaceToView(cell.contactLabel, 0);
            }
            
            cell.contactLabel.textColor = [UIColor colorWithHexColorStr:@"#FCAF1B"];
            cell.upView.hidden = YES;
            cell.midView.backgroundColor =  [UIColor colorWithHexColorStr:@"#FCAF1B"];
        }else if (indexPath.row  == self.statusArray.count - 1){
            cell.titleLabel.text = [NSString stringWithFormat:@"%@ 发起",auditStatusmodel.createUserName];
            cell.contactLabel.text = [NSString stringWithFormat:@"%@",auditStatusmodel.optType];
            cell.timeLabel.text = [NSString stringWithFormat:@"%@",auditStatusmodel.createTime];
            cell.lowView.hidden = YES;
            cell.bottomview.hidden = YES;
            cell.timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
            cell.titleLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
            cell.contactLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        }else{
            cell.timeLabel.text = [NSString stringWithFormat:@"%@",auditStatusmodel.createTime];
            cell.timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",auditStatusmodel.optType];
            cell.titleLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
            cell.contactLabel.text = [NSString stringWithFormat:@"%@",auditStatusmodel.optDescribe];
            cell.contactLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
            cell.contactLabel.hidden = YES;
            cell.timeLabel.sd_layout
            .topSpaceToView(cell.titleLabel, 0);
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//- (NSString *)getTimeFromTimestamp:(NSString *)newtime{
//    //将对象类型的时间转换为NSDate类型
//    double time = [newtime doubleValue];
//    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
//    //设置时间格式
//    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    //将时间转换为字符串
//    NSString * timeStr=[formatter stringFromDate:myDate];
//    return timeStr;
//}

@end
