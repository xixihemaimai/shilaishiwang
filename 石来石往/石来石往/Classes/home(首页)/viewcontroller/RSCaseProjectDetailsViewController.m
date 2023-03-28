//
//  RSCaseProjectDetailsViewController.m
//  石来石往
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCaseProjectDetailsViewController.h"
#import "RSCaseProjectHeaderView.h"
#import "RSCaseProjectCustomCell.h"
#import "ZKImgRunLoopView.h"
#import "RSPublishingProjectCaseViewController.h"
#import "RSEngineeringCaseViewController.h"
#import "LXFloaintButton.h"
#import "RSLeftViewController.h"
#import "RSDraftViewController.h"
@interface RSCaseProjectDetailsViewController ()

//@property (nonatomic,strong)UITableView * tableview;
@property (nonatomic,strong)ZKImgRunLoopView *imgRunView;
@property (nonatomic,strong) RSProjectCaseModel * projectcasemodel;

@end

@implementation RSCaseProjectDetailsViewController
//- (UITableView *)tableview{
//    if (!_tableview) {
//        CGFloat bottomH = 0.0;
//        CGFloat Y = 0.0;
//        if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
//            bottomH = 34;
//            Y = 88;
//        }else{
//            bottomH = 0;
//            Y = 64;
//        }
//        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Y, SCW, SCH - bottomH - Y) style:UITableViewStylePlain];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//        //_tableview.contentSize = CGSizeMake(0, bottomH + 80);
//        _tableview.contentInset = UIEdgeInsetsMake(0, 0, bottomH + 40, 0);
//    }
//    return _tableview;
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.hidden = YES;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar - 40);
//    if (@available(iOS 11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.title = @"案例详情";
    [self loadCaseProjectDetail];
    // 图片
//    UIImageView * productImage = [[UIImageView alloc]init];
//    productImage.image = [UIImage imageNamed:@"1080-675"];
//    [headerview addSubview:productImage];
}

- (void)setUIProjectCase{
    //这边添加组头
    UIView * headerview =[[UIView alloc]init];
    headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    ZKImgRunLoopView *imgRunView = [[ZKImgRunLoopView alloc] initWithFrame:CGRectMake(0, 0, SCW, 275.5) placeholderImg:[UIImage imageNamed:@"01"]];
    imgRunView.pageControl.hidden = NO;
    [headerview addSubview:imgRunView];
    self.imgRunView = imgRunView;
    imgRunView.pageControl.PageControlStyle = JhPageControlContentModeLeft;
    imgRunView.pageControl.PageControlStyle = JhPageControlStyelDefault;
    imgRunView.pageControl.currentColor = [UIColor whiteColor];
    imgRunView.pageControl.otherColor = [UIColor colorWithHexColorStr:@"#f7f7f7" alpha:0.4];
     NSMutableArray * imageTempArray = [NSMutableArray array];
    if (self.projectcasemodel.IMG.count < 1) {
            for (int i = 0 ; i < 3; i++) {
                [imageTempArray addObject:[NSString stringWithFormat:@"1080-675"]];
            }
        imgRunView.imgUrlArray = imageTempArray;
    }else{
        for (int i = 0; i < self.projectcasemodel.IMG.count; i++) {
            RSProjectCaseImageModel * projectcaseimagemodel = self.projectcasemodel.IMG[i];
            //projectcaseimagemodel.imgUrl = [[tempArray objectAtIndex:j]objectForKey:@"imgUrl"];
            [imageTempArray addObject:projectcaseimagemodel.imgUrl];
        }
        imgRunView.imgUrlArray = imageTempArray;
    }
    //这边是点击每个广告图片要跳转的位置
    [imgRunView  touchImageIndexBlock:^(NSInteger index) {
        
        
    }];
    //产品
    UILabel * productLabel = [[UILabel alloc]init];
    productLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    productLabel.font = [UIFont systemFontOfSize:18];
    productLabel.textAlignment = NSTextAlignmentLeft;
    // productLabel.text = @"轻奢家装";
    productLabel.text = self.projectcasemodel.TITLE;
    [headerview addSubview:productLabel];
    
    //查询货主的头像和货主的昵称
    UIImageView * hzImage = [[UIImageView alloc]init];
    hzImage.image = [UIImage imageNamed:@"1080-675"];
    [headerview addSubview:hzImage];
    
    UILabel * hzLabel = [[UILabel alloc]init];
    hzLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    hzLabel.font = [UIFont systemFontOfSize:12];
    hzLabel.textAlignment = NSTextAlignmentLeft;
    hzLabel.text = self.projectcasemodel.USER_NAME;
    [headerview addSubview:hzLabel];
    
    //产品介绍
    UIView * productView = [[UIView alloc]init];
    productView.backgroundColor = [UIColor clearColor];
    [headerview addSubview:productView];
    
    //产品介绍里面的文字
    RSSFLabel * productDetailLabel = [[RSSFLabel alloc]init];
    productDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    productDetailLabel.font = [UIFont systemFontOfSize:14];
    productDetailLabel.textAlignment = NSTextAlignmentLeft;
   // productDetailLabel.text = @"石材天然、高贵、奢华，可以有造型和线条，甚至光度都可以控制……";
    productDetailLabel.text = self.projectcasemodel.CONTENT;
    productDetailLabel.numberOfLines = 0;
    [productView addSubview:productDetailLabel];
    
    imgRunView.sd_layout
    .leftSpaceToView(headerview, 0)
    .topSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .heightIs(275.5);
    
    productLabel.sd_layout
    .leftSpaceToView(headerview, 12)
    .rightSpaceToView(headerview, 12)
    .topSpaceToView(imgRunView, 16)
    .heightIs(17);
    
    hzImage.sd_layout
    .leftSpaceToView(headerview, 12)
    .topSpaceToView(productLabel, 8.5)
    .widthIs(12.5)
    .heightEqualToWidth();
    
    hzImage.layer.cornerRadius = hzImage.yj_width * 0.5;
    hzImage.layer.masksToBounds = YES;
    
    hzLabel.sd_layout
    .leftSpaceToView(hzImage, 3)
    .topSpaceToView(productLabel, 8.5)
    .rightSpaceToView(headerview, 12)
    .heightIs(12.5);
    
    productView.sd_layout
    .leftSpaceToView(headerview, 12)
    .rightSpaceToView(headerview, 12)
    .topSpaceToView(hzImage, 10.5)
    .heightIs(63);
    
    productDetailLabel.sd_layout
    .leftSpaceToView(productView, 0)
    .rightSpaceToView(productView, 0)
    .topSpaceToView(productView, 0)
    .heightIs(63);
    
    [productView setupAutoHeightWithBottomView:productDetailLabel bottomMargin:0];
    [headerview setupAutoHeightWithBottomView:productView bottomMargin:0];
    [headerview layoutSubviews];
    self.tableview.tableHeaderView = headerview;
    
//    CGFloat bottomH = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
//        bottomH = 34;
//    }else{
//        bottomH = 0;
//    }
    UIButton * deletBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCH - Height_NavBar - 40, SCW, 40)];
    [deletBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deletBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [deletBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    deletBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [deletBtn addTarget:self action:@selector(deleProjectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deletBtn];
    
    
    if ([[self.navigationController.viewControllers objectAtIndex:0]class] == [RSLeftViewController class]) {
        deletBtn.hidden = NO;
    }
    else{
        deletBtn.hidden = YES;
    }
    
    
}

- (void)deleProjectAction:(UIButton *)deleBtn{
    [SVProgressHUD showInfoWithStatus:@"正在删除改工程案例中,请等待中........"];
    //FIXME:删除或者恢复工程案例 status 删除传2  恢复的话传1 -- 还没有接的地方
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%@",self.ID] forKey:@"caseId"];
    [dict setObject:[NSString stringWithFormat:@"2"] forKey:@"status"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_CHANGEPROJECTCASESTATUS_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                [SVProgressHUD dismiss];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"removeProjectCase" object:nil];
            }else{
                [SVProgressHUD showInfoWithStatus:@"删除失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"删除失败"];
        }
    }];
}

- (void)loadCaseProjectDetail{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.usermodel.userID forKey:@"userId"];
    [phoneDict setObject:self.ID forKey:@"caseId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_GETPROJECTCASEDETAIL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableDictionary * mutableDict = [NSMutableDictionary dictionary];
                mutableDict = json[@"Data"];
                weakSelf.projectcasemodel = [[RSProjectCaseModel alloc]init];
               weakSelf.projectcasemodel.CREATE_TIME = mutableDict[@"CREATE_TIME"];
                 weakSelf.projectcasemodel.CONTENT = mutableDict[@"CONTENT"];
                 weakSelf.projectcasemodel.ID = mutableDict[@"ID"];
                 weakSelf.projectcasemodel.TITLE = mutableDict[@"TITLE"];
                 weakSelf.projectcasemodel.UPDATE_TIME = mutableDict[@"UPDATE_TIME"];
                weakSelf.projectcasemodel.USER_NAME = mutableDict[@"USER_NAME"];
                    NSMutableArray * tempArray = [NSMutableArray array];
                    NSMutableArray * imageArray = [NSMutableArray array];
                    tempArray = mutableDict[@"IMG"];
                    for (int j = 0; j < tempArray.count; j++) {
                        RSProjectCaseImageModel * projectcaseimagemodel = [[RSProjectCaseImageModel alloc]init];
                        projectcaseimagemodel.imgId = [[tempArray objectAtIndex:j]objectForKey:@"imgId"];
                        projectcaseimagemodel.imgUrl = [[tempArray objectAtIndex:j]objectForKey:@"imgUrl"];
                        [imageArray addObject:projectcaseimagemodel];
                    }
                     weakSelf.projectcasemodel.IMG = imageArray;
                    NSMutableArray * caseDetailArray = [NSMutableArray array];
                    NSMutableArray * caseTempArray = [NSMutableArray array];
                    caseDetailArray = mutableDict[@"CASESTONEIMG"];
                    for (int n = 0 ; n < caseDetailArray.count; n++) {
                        RSProjectCaseThirdModel * projectcasethirdmodel = [[RSProjectCaseThirdModel alloc]init];
                        projectcasethirdmodel.imgId = [[caseDetailArray objectAtIndex:n]objectForKey:@"imgId"];
                        projectcasethirdmodel.imgUrl = [[caseDetailArray objectAtIndex:n]objectForKey:@"imgUrl"];
                        projectcasethirdmodel.stoneId = [[caseDetailArray objectAtIndex:n]objectForKey:@"stoneId"];
                        projectcasethirdmodel.proName = [[caseDetailArray objectAtIndex:n]objectForKey:@"proName"];
                        [caseTempArray addObject:projectcasethirdmodel];
                    }
                     weakSelf.projectcasemodel.CASESTONEIMG = caseTempArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf setUIProjectCase];
                    [weakSelf.tableview reloadData];
                });
            }else{
                [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
            }
        }else{
             [SVProgressHUD showInfoWithStatus:@"获取数据失败"];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.projectcasemodel.CASESTONEIMG.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CASEPROJECTDETAILSCELL = @"CASEPROJECTDETAILSCELL";
    RSCaseProjectCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:CASEPROJECTDETAILSCELL];
    if (!cell) {
        cell = [[RSCaseProjectCustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CASEPROJECTDETAILSCELL];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     RSProjectCaseThirdModel * projectcasethirdmodel = self.projectcasemodel.CASESTONEIMG[indexPath.row];
    [cell.caseImage sd_setImageWithURL:[NSURL URLWithString:projectcasethirdmodel.imgUrl] placeholderImage:[UIImage imageNamed:@"1080-675"]];
    cell.caseLabel.text = projectcasethirdmodel.proName;
    return cell;
}






- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * RSCASEPROJECTHEADERVIEW = @"RSCASEPROJECTHEADERVIEW";
    RSCaseProjectHeaderView * caseProjectHeaderview = [[RSCaseProjectHeaderView alloc]initWithReuseIdentifier:RSCASEPROJECTHEADERVIEW];
    return caseProjectHeaderview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 65;
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//}


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
