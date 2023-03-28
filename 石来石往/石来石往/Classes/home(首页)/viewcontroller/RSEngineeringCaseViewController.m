//
//  RSEngineeringCaseViewController.m
//  石来石往
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSEngineeringCaseViewController.h"
#import "RSCargoEngineeringCaseCell.h"
#import "RSPublishingProjectCaseViewController.h"
#import "RSCaseProjectDetailsViewController.h"
#import "RSLeftViewController.h"
#import "LXFloaintButton.h"
#import "RSDraftViewController.h"
#import "RSCaseTitleView.h"

@interface RSEngineeringCaseViewController ()<RSCaseTitleViewDelegate>

//@property (nonatomic,strong)UITableView * tableview;
@property (nonatomic,assign)NSInteger projectNum;
@property (nonatomic,strong)NSMutableArray * projectArray;
@property (nonatomic,strong)RSCaseTitleView * caseTitleview;

@end

@implementation RSEngineeringCaseViewController
- (NSMutableArray *)projectArray{
    if (!_projectArray) {
        _projectArray = [NSMutableArray array];
    }
    return _projectArray;
}

//- (UITableView *)tableview{
//    if (!_tableview) {
//        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//        CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    return _tableview;
//}

- (RSCaseTitleView *)caseTitleview{
    if (!_caseTitleview) {
        _caseTitleview = [[RSCaseTitleView alloc]initWithFrame:CGRectMake(0, 0 , SCW, SCH)];
        _caseTitleview.userInteractionEnabled = YES;
        _caseTitleview.hidden = YES;
        _caseTitleview.delegate = self;
    }
    return _caseTitleview;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.hidden = YES;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeProjectCase) name:@"removeProjectCase" object:nil];
}

- (void)removeProjectCase{
    [self engineerLoadNewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.title = @"工程案例";
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.projectNum = 2;
    [self engineerLoadNewData];
    if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]) {
        //新增的按钮和草稿
        UIView * addAndDraftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        addAndDraftView.backgroundColor = [UIColor clearColor];

        UIButton * publishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        [publishBtn setTitle:@"草稿箱" forState:UIControlStateNormal];
        [publishBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        publishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [publishBtn addTarget:self action:@selector(newDraftAction:) forControlEvents:UIControlEventTouchUpInside];
        [addAndDraftView addSubview:publishBtn];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(CGRectGetMaxX(publishBtn.frame),0,50, 30);
        [button setTitle:@"新增" forState:UIControlStateNormal];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
        
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addNewAction:) forControlEvents:UIControlEventTouchUpInside];
        [addAndDraftView addSubview:button];
        UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:addAndDraftView];
        self.navigationItem.rightBarButtonItem = rightitem;
    }
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf engineerLoadNewData];
    }];
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
       [weakSelf engineerLoadMoreNewData];
    }];
//    [self.tableview setupEmptyDataText:@"重新加载数据" tapBlock:^{
//       [weakSelf engineerLoadNewData];
//    }];
     [self.navigationController.view addSubview:self.caseTitleview];
}
//草稿
- (void)newDraftAction:(UIButton *)btn{
    
    RSDraftViewController * draftVc =[[RSDraftViewController alloc]init];
    draftVc.usermodel = self.usermodel;
    [self.navigationController pushViewController:draftVc animated:YES];
}

- (void)draftAction:(UIButton *)btn{
    
    RSDraftViewController * draftVc = [[RSDraftViewController alloc]init];
    draftVc.usermodel = self.usermodel;
    [self.navigationController pushViewController:draftVc animated:YES];
}

//FIXME:新增
- (void)addNewAction:(UIButton *)newAddBtn{
    self.caseTitleview.hidden = NO;
}
/**隐藏蒙版的代理方法*/
- (void)hiddeMenuView{
    self.caseTitleview.hidden = YES;
    self.caseTitleview.textfield.text = @"";
    [self.caseTitleview endEditing:YES];
}
/**这边是蒙版输入标题内容的代理方法*/
- (void)sendCaseTitleString:(NSString *)caseTitleStr{
    self.caseTitleview.hidden = YES;
    self.caseTitleview.textfield.text = @"";
    [self.caseTitleview endEditing:YES];
    [self reloadProjectCaseServiceID:caseTitleStr];
}
//获取id
- (void)reloadProjectCaseServiceID:(NSString *)projectid{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:projectid forKey:@"title"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_ADDPROJECTCASE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSInteger engineeringID = [json[@"Data"] integerValue];
                RSPublishingProjectCaseViewController * publishingProjectCaseVc = [[RSPublishingProjectCaseViewController alloc]init];
                publishingProjectCaseVc.engineeringID = engineeringID;
                publishingProjectCaseVc.usermodel = weakSelf.usermodel;
                publishingProjectCaseVc.goodCreat = @"0";
                publishingProjectCaseVc.loadtitle = projectid;
                [weakSelf.navigationController pushViewController:publishingProjectCaseVc animated:YES];
            }else{
                [SVProgressHUD showInfoWithStatus:@"创建工程案例失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"创建工程案例失败"];
        }
    }];
}

- (void)engineerLoadNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [phoneDict setObject:[NSString stringWithFormat:@"%d",1] forKey:@"nowPage"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"pageSize"];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"status"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETPROJECTCASELIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD dismiss];
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = nil;
                array = json[@"Data"];
                [weakSelf.projectArray removeAllObjects];
                if (array.count >= 1) {
                    for (int i = 0; i < array.count; i++) {
                        RSProjectCaseModel * projectcasemodel = [[RSProjectCaseModel alloc]init];
                        projectcasemodel.CREATE_TIME = [[array objectAtIndex:i]objectForKey:@"CREATE_TIME"];
                        projectcasemodel.CONTENT = [[array objectAtIndex:i]objectForKey:@"CONTENT"];
                        projectcasemodel.ID = [[array objectAtIndex:i]objectForKey:@"ID"];
                        projectcasemodel.UPDATE_TIME = [[array objectAtIndex:i]objectForKey:@"UPDATE_TIME"];
                        projectcasemodel.TITLE = [[array objectAtIndex:i]objectForKey:@"TITLE"];
                        NSMutableArray * tempArray = [NSMutableArray array];
                        NSMutableArray * imageArray = [NSMutableArray array];
                        tempArray = [[array objectAtIndex:i]objectForKey:@"IMG"];
                        for (int j = 0; j < tempArray.count; j++) {
                            RSProjectCaseImageModel * projectcaseimagemodel = [[RSProjectCaseImageModel alloc]init];
                            projectcaseimagemodel.imgId = [[tempArray objectAtIndex:j]objectForKey:@"imgId"];
                            projectcaseimagemodel.imgUrl = [[tempArray objectAtIndex:j]objectForKey:@"imgUrl"];
                            [imageArray addObject:projectcaseimagemodel];
                        }
                        projectcasemodel.CASESTONEIMG = nil;
                        projectcasemodel.IMG = imageArray;
                        [weakSelf.projectArray addObject:projectcasemodel];
                    }
                }else{
                }
                [weakSelf.tableview reloadData];
                weakSelf.projectNum = 2;
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (void)engineerLoadMoreNewData{
    RSWeakself
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [phoneDict setObject:[NSString stringWithFormat:@"%ld",(long)self.projectNum] forKey:@"nowPage"];
    [phoneDict setObject:[NSString stringWithFormat:@"10"] forKey:@"pageSize"];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:[NSString stringWithFormat:@"1"] forKey:@"status"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETPROJECTCASELIST_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD dismiss];
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = nil;
                array = json[@"Data"];
                if (array.count >= 1) {
                    NSMutableArray * moreArray = [NSMutableArray array];
                    for (int i = 0; i < array.count; i++) {
                        RSProjectCaseModel * projectcasemodel = [[RSProjectCaseModel alloc]init];
                        projectcasemodel.CREATE_TIME = [[array objectAtIndex:i]objectForKey:@"CREATE_TIME"];
                        projectcasemodel.CONTENT = [[array objectAtIndex:i]objectForKey:@"CONTENT"];
                        projectcasemodel.ID = [[array objectAtIndex:i]objectForKey:@"ID"];
                        projectcasemodel.UPDATE_TIME = [[array objectAtIndex:i]objectForKey:@"UPDATE_TIME"];
                        projectcasemodel.TITLE = [[array objectAtIndex:i]objectForKey:@"TITLE"];
                        NSMutableArray * tempArray = [NSMutableArray array];
                        NSMutableArray * imageArray = [NSMutableArray array];
                        tempArray = [[array objectAtIndex:i]objectForKey:@"IMG"];
                        for (int j = 0; j < tempArray.count; j++) {
                            RSProjectCaseImageModel * projectcaseimagemodel = [[RSProjectCaseImageModel alloc]init];
                            projectcaseimagemodel.imgId = [[tempArray objectAtIndex:i]objectForKey:@"imgId"];
                            projectcaseimagemodel.imgUrl = [[tempArray objectAtIndex:i]objectForKey:@"imgUrl"];
                            [imageArray addObject:projectcaseimagemodel];
                        }
                        projectcasemodel.CASESTONEIMG = nil;
                        projectcasemodel.IMG = imageArray;
                        [moreArray addObject:projectcasemodel];
                    }
                    [weakSelf.projectArray addObjectsFromArray:moreArray];
                }else{
                }
                [weakSelf.tableview reloadData];
                weakSelf.projectNum++;
                [weakSelf.tableview.mj_footer endRefreshing];
            }else{
                [weakSelf.tableview.mj_footer endRefreshing];
            }
        }else{
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    }];
}

#pragma mark -- 显示键盘
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = kbHeight;
    //258
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.caseTitleview.titleView.frame  = CGRectMake(0.0f,SCH - offset - 45, SCW, 45);
        }];
    }
}

#pragma mark ---- 当键盘消失后，视图需要恢复原状
///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.caseTitleview.titleView.frame = CGRectMake(0, SCH - 45, SCW, SCH);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.projectArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSProjectCaseModel * projectcasemodel = self.projectArray[indexPath.row];
    if (projectcasemodel.CONTENT.length > 16) {
         return 258;
    }else{
        return 240;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *RSENGINEERINGCASECELL = @"RSEngineeringCaseCell";
    RSProjectCaseModel * projectcasemodel = self.projectArray[indexPath.row];
    RSProjectCaseImageModel * projectcaseimgemodel = projectcasemodel.IMG.lastObject;
    RSCargoEngineeringCaseCell *cell = [tableView dequeueReusableCellWithIdentifier:RSENGINEERINGCASECELL];
    if (!cell) {
        cell = [[RSCargoEngineeringCaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RSENGINEERINGCASECELL];
    }
    //    cell.textLabel.text = [NSString stringWithFormat:@"%@ section: %zd row:%zd", self.cellTitle ?: @"测试", indexPath.section, indexPath.row];
    [cell.enginerrImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",projectcaseimgemodel.imgUrl]] placeholderImage:[UIImage imageNamed:@"1080-675"]];
    cell.enginerrLabel.text = projectcasemodel.TITLE;
    cell.productLabel.text = projectcasemodel.CONTENT;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    RSProjectCaseModel * projectcasemodel = self.projectArray[indexPath.row];
    RSCaseProjectDetailsViewController * caseProjectDetailsVc = [[RSCaseProjectDetailsViewController alloc]init];
    caseProjectDetailsVc.ID = projectcasemodel.ID;
    caseProjectDetailsVc.usermodel = self.usermodel;
    [self.navigationController pushViewController:caseProjectDetailsVc animated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"removeProjectCase" object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
