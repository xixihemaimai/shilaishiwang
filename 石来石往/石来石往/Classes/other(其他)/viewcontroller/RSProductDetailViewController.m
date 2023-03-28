//
//  RSProductDetailViewController.m
//  石来石往
//
//  Created by mac on 2017/8/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSProductDetailViewController.h"
#import "ZKImgRunLoopView.h"

#import "RSProductStoneCell.h"


#import "RSMyRingViewController.h"

#import "RSCargoCenterBusinessViewController.h"


#import "RSProductHeaderModel.h"

#import "RSPicturePathModel.h"


#import <HUPhotoBrowser.h>

//<UITableViewDelegate,UITableViewDataSource>
@interface RSProductDetailViewController ()

{
    //大板货主的底下的view
    UIView * _daview;
    //荒料货主底下的view
    UIView * _huangview;
    //大板的按键
    UIButton * _daBanBtn;
    //荒料的按键
    UIButton * _huangLiaoBtn;
    
    
    
}

@property (nonatomic,strong)NSMutableArray * pictureArray;

/**自定义tableview*/
//@property (nonatomic,strong)UITableView * tableview;



@property (nonatomic,strong) ZKImgRunLoopView *imgRunView;
@end

@implementation RSProductDetailViewController

- (NSMutableArray *)pictureArray{
    if (_pictureArray == nil) {
        _pictureArray = [NSMutableArray array];
    }
    return _pictureArray;
}



//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//   // self.hidesBottomBarWhenPushed = YES;
//    self.navigationController.navigationBar.hidden = NO;
//}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
//    if (@available(iOS 11.0, *)) {
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
    self.title = _productNameLabel;
    [self loadHeaderTableviewData];
   
}




- (void)loadHeaderTableviewData{
    
    
    //URL_ADANDDAHUANGLIAONUM_IOS 参数PRO_NAME
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.productNameLabel forKey:@"PRO_NAME"];
    if (verifyKey.length < 1) {
        verifyKey = @"";
    }
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_ADANDDAHUANGLIAONUM_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                RSProductHeaderModel * productHeadermodel = [[RSProductHeaderModel alloc]init];
                productHeadermodel.BLOCKNUM = json[@"Data"][@"BLOCKNUM"];
                //productHeadermodel.PATHLIST = json[@"Data"][@"PATHLIST"];
                NSMutableArray * array = nil;
                array = json[@"Data"][@"PATHLIST"]; 
                for (int i = 0; i < array.count; i++) {
                    NSString * path = [[array objectAtIndex:i]objectForKey:@"img"];
                    [productHeadermodel.PATHLIST addObject:path];
                }
                productHeadermodel.SLABNUM = json[@"Data"][@"SLABNUM"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf addCustomTableviewRSProductHeaderModel:productHeadermodel];
                    [weakSelf loadTableviewNewData];
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        }
    }];
}



- (void)loadTableviewNewData{
   //[[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.productNameLabel forKey:@"PRO_NAME"];
    [phoneDict setObject:self.WLTYPE forKey:@"STOCK_TYPE"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //,@"ps":@"20",@"pi":@"1",@"tp":@"bymonth"
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_CHECSE_STONE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                NSMutableArray * array = json[@"Data"];
                [weakSelf.pictureArray removeAllObjects];
                if (array.count >= 1) {
                    for (int j = 0 ; j < array.count; j++) {
                        RSPicturePathModel * picturepathmodel = [[RSPicturePathModel alloc]init];
                        picturepathmodel.name = [[array objectAtIndex:j]objectForKey:@"name"];
                        picturepathmodel.num = [[array objectAtIndex:j]objectForKey:@"num"];
                        picturepathmodel.phone = [[array objectAtIndex:j]objectForKey:@"phone"];
                        picturepathmodel.usercode = [[array objectAtIndex:j]objectForKey:@"usercode"];
                        picturepathmodel.usercodeID = [[array objectAtIndex:j]objectForKey:@"id"];
                       // picturepathmodel.logo = [[array objectAtIndex:j]objectForKey:@"logo"];
                        NSMutableArray * tempImgs = nil;
                        tempImgs = [[array objectAtIndex:j]objectForKey:@"logo"];
                        NSMutableArray * tempPictures = [NSMutableArray array];
                        for (int n = 0; n < tempImgs.count; n++) {
                            NSString * url = [tempImgs objectAtIndex:n];
                            [tempPictures addObject:url];
                        }
                        picturepathmodel.logo = tempPictures;
                        [weakSelf.pictureArray addObject:picturepathmodel];
                    }
                }
                [weakSelf.tableview reloadData];
            }
        }
    }];
}




- (void)addCustomTableviewRSProductHeaderModel:(RSProductHeaderModel *)productHeadermodel{
//    CGFloat bottomH = 0.0;
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        bottomH = 34;
//        Y = 88;
//    }else{
//        bottomH = 0.0;
//        Y = 64;
//    }
//
//
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Y, SCW, SCH - Y - bottomH) style:UITableViewStylePlain];
//    tableview.delegate = self;
//    tableview.dataSource = self;
//    self.tableview = tableview;
//
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    [self addCustonTableviewHeaderViewRSProductHeaderModel:productHeadermodel];
}






#pragma mark-- 添加表头的内容
- (void)addCustonTableviewHeaderViewRSProductHeaderModel:(RSProductHeaderModel *)productHeadermodel{
    //总的view
    UIView * headerview = [[UIView alloc]init];
    headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
    NSMutableArray *mutableArray = nil;
    mutableArray = productHeadermodel.PATHLIST;
    
    if (mutableArray.count < 1) {
        
            for (int n = 0; n < 3; n++) {
                [mutableArray addObject:[NSString stringWithFormat:@"0%d",n]];
            }
    }
    ZKImgRunLoopView *imgRunView = [[ZKImgRunLoopView alloc] initWithFrame:CGRectMake(0, 0, SCW, 180) placeholderImg:[UIImage imageNamed:@"01"]];
    imgRunView.pageControl.hidden = NO;
    self.imgRunView = imgRunView;
    imgRunView.pageControl.PageControlStyle = JhPageControlContentModeLeft;
    imgRunView.pageControl.PageControlStyle = JhPageControlStyelDefault;
    imgRunView.pageControl.currentColor = [UIColor whiteColor];
    imgRunView.pageControl.otherColor = [UIColor colorWithHexColorStr:@"#f7f7f7" alpha:0.4];
    imgRunView.imgUrlArray = mutableArray;
    //这边是点击每个广告图片要跳转的位置
    [imgRunView  touchImageIndexBlock:^(NSInteger index) {
    }];
    [headerview addSubview:imgRunView];
    //这边是显示我的大板或者我的荒料
    UIView * showMessageview = [[UIView alloc]init];
    showMessageview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:showMessageview];
    
    //这边是要做的是你选中的是荒料货主还是大板货主
    UIView * oweview = [[UIView alloc]init];
    oweview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:oweview];
    
    
    //这边是我的大板和我的荒料的里面的界面
    
    //中间的左边的view
    UIView * midLeftview = [[UIView alloc]init];
    midLeftview.backgroundColor = [UIColor whiteColor];
    [showMessageview addSubview:midLeftview];
    
    
    //右边的view
    UIView * midRightview = [[UIView alloc]init];
    midRightview.backgroundColor = [UIColor whiteColor];
    [showMessageview addSubview:midRightview];
    
    
    //中间的view
    UIView * midMidview = [[UIView alloc]init];
    midMidview.backgroundColor = [UIColor colorWithHexColorStr:@"#f3f3f3"];
    [showMessageview addSubview:midMidview];
    
    
    //左边的view里面的内容
    UIImageView * leftImageview = [[UIImageView alloc]init];
    leftImageview.image = [UIImage imageNamed:@"荒料库存"];
    [midLeftview addSubview:leftImageview];
    
    
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.text = [NSString stringWithFormat:@"%@m³",productHeadermodel.BLOCKNUM];
    leftLabel.textColor = [UIColor colorWithHexColorStr:@"#FC5808"];
    leftLabel.font = [UIFont systemFontOfSize:15];
    [midLeftview addSubview:leftLabel];
    
    
    UILabel  * huangStoneHomeLabel = [[UILabel alloc]init];
    huangStoneHomeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    huangStoneHomeLabel.font = [UIFont systemFontOfSize:12];
    huangStoneHomeLabel.text = @"荒料库存";
    [midLeftview addSubview:huangStoneHomeLabel];
    
    
    //右边的中间的view的内容
    UIImageView * rightImageview = [[UIImageView alloc]init];
    rightImageview.image = [UIImage imageNamed:@"大板库存"];
    [midRightview addSubview:rightImageview];
    
    
    UILabel * rightLabel = [[UILabel alloc]init];
    rightLabel.text = [NSString stringWithFormat:@"%@m²",productHeadermodel.SLABNUM];
    rightLabel.textColor = [UIColor colorWithHexColorStr:@"#FC5808"];
    rightLabel.font = [UIFont systemFontOfSize:15];
    [midRightview addSubview:rightLabel];
    
    
    UILabel  * daBanStoneHomeLabel = [[UILabel alloc]init];
    daBanStoneHomeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    daBanStoneHomeLabel.font = [UIFont systemFontOfSize:12];
    daBanStoneHomeLabel.text = @"大板库存";
    [midRightview addSubview:daBanStoneHomeLabel];
    
    
    //这边荒料货主和大板货主里面的界面
    
    
    
    UIView *leftview = [[UIView alloc]init];
    leftview.backgroundColor = [UIColor whiteColor];
    [oweview addSubview:leftview];
    
    
    
    UIView * rightview = [[UIView alloc]init];
    rightview.backgroundColor = [UIColor whiteColor];
    [oweview addSubview:rightview];
    
    
    
    
    
    UIButton * huangLiaoBtn = [[UIButton alloc]init];
    huangLiaoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [huangLiaoBtn setTitle:@"荒料货主" forState:UIControlStateNormal];
    [huangLiaoBtn setTitleColor:[UIColor colorWithHexColorStr:@"#000000"] forState:UIControlStateNormal];
    [leftview addSubview:huangLiaoBtn];
    [huangLiaoBtn addTarget:self action:@selector(choiceHuange:) forControlEvents:UIControlEventTouchUpInside];
    _huangLiaoBtn = huangLiaoBtn;
    
    UIView * huangview = [[UIView alloc]init];
    _huangview = huangview;
    huangview.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    [leftview addSubview:huangview];
    
    UIButton * daBanBtn = [[UIButton alloc]init];
    daBanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [daBanBtn setTitle:@"大板货主" forState:UIControlStateNormal];
    [daBanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#000000"] forState:UIControlStateNormal];
    
    [daBanBtn addTarget:self action:@selector(choiceDaBan:) forControlEvents:UIControlEventTouchUpInside];
    
    _daBanBtn = daBanBtn;
    [rightview addSubview:daBanBtn];
    
    UIView * daview = [[UIView alloc]init];
    _daview = daview;
    daview.backgroundColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    [rightview addSubview:daview];
     
    
    if ([self.WLTYPE isEqualToString:@"huangliao"]) {
        _huangview.hidden = NO;
        _huangLiaoBtn.selected = NO;
        _daBanBtn.selected = YES;
        _daview.hidden = YES;
        
        
    }else{
        
        _huangview.hidden = YES;
        _huangLiaoBtn.selected = YES;
        _daBanBtn.selected = NO;
        _daview.hidden = NO;
        
    }
    
    UIView * bottomview = [[UIView alloc]init];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f3f3f3"];
    [oweview addSubview:bottomview];
    
    
    
    showMessageview.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(imgRunView, 0)
    .heightIs(64);
    
    
    oweview.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(showMessageview, 11)
    .heightIs(37);
    
    
    
    
    
    
    midLeftview.sd_layout
    .leftSpaceToView(showMessageview, 0)
    .topSpaceToView(showMessageview, 0)
    .bottomSpaceToView(showMessageview, 0)
    .widthIs((SCW/2)-1);
    
    
    
    midMidview.sd_layout
    .leftSpaceToView(midLeftview, 0)
    .topSpaceToView(showMessageview, 16)
    .bottomSpaceToView(showMessageview, 13)
    .widthIs(1);
    
    
    
    midRightview.sd_layout
    .leftSpaceToView(midMidview, 0)
    .rightSpaceToView(showMessageview, 0)
    .topSpaceToView(showMessageview, 0)
    .bottomSpaceToView(showMessageview, 0);
    
    
    
    
    
    leftImageview.sd_layout
    .leftSpaceToView(midLeftview, 19)
    .topSpaceToView(midLeftview, 15)
    .bottomSpaceToView(midLeftview, 16)
    .widthIs(33);
    
    leftLabel.sd_layout
    .leftSpaceToView(leftImageview, 10)
    .topEqualToView(leftImageview)
    .rightSpaceToView(midLeftview, 5)
    .heightIs(16.5);
    
    huangStoneHomeLabel.sd_layout
    .leftEqualToView(leftLabel)
    .topSpaceToView(leftLabel, 0)
    .rightEqualToView(leftLabel)
    .bottomEqualToView(leftImageview);
    
    
    
    rightImageview.sd_layout
    .leftSpaceToView(midRightview, 19)
    .topSpaceToView(midRightview, 15)
    .bottomSpaceToView(midRightview, 16)
    .widthIs(33);
    
    rightLabel.sd_layout
    .leftSpaceToView(rightImageview, 10)
    .topEqualToView(rightImageview)
    .rightSpaceToView(midRightview, 5)
    .heightIs(16.5);
    
    
    daBanStoneHomeLabel.sd_layout
    .leftEqualToView(rightLabel)
    .topSpaceToView(rightLabel, 0)
    .bottomEqualToView(rightImageview)
    .rightEqualToView(rightLabel);
    

    
    leftview.sd_layout
    .leftSpaceToView(oweview, 0)
    .rightSpaceToView(oweview, SCW/2)
    .topSpaceToView(oweview, 0)
    .bottomSpaceToView(oweview, 0);
    
    
    
    
    
    
    huangLiaoBtn.sd_layout
    .leftSpaceToView(leftview, 0)
    .topSpaceToView(leftview, 0)
    .rightSpaceToView(leftview, 0)
    .heightIs(34);
    
    
    huangview.sd_layout
    .topSpaceToView(huangLiaoBtn, 0)
    
    .leftSpaceToView(leftview, 12)
    .rightSpaceToView(leftview, 12)
    .heightIs(2);
    
    
    
    
    rightview.sd_layout
    .leftSpaceToView(leftview, 0)
    .topSpaceToView(oweview, 0)
    .bottomSpaceToView(oweview, 0)
    .rightSpaceToView(oweview, 0);
    
    
    daBanBtn.sd_layout
    .leftSpaceToView(rightview, 0)
    .rightSpaceToView(rightview, 0)
    .topSpaceToView(rightview, 0)
    .heightIs(34);
    
    
    daview.sd_layout
    .rightSpaceToView(rightview, 12)
    .leftSpaceToView(rightview, 12)
    .topSpaceToView(daBanBtn, 0)
    .heightIs(2);
    
    
    
    bottomview.sd_layout
    .leftSpaceToView(oweview, 0)
    .rightSpaceToView(oweview, 0)
    .topSpaceToView(huangview, 0)
    .topSpaceToView(daview, 0)
    .bottomSpaceToView(oweview, 0);
    
    [headerview setupAutoHeightWithBottomView:oweview bottomMargin:0];
    [headerview layoutSubviews];
    self.tableview.tableHeaderView = headerview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pictureArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PRODUCTID = @"productID";
    RSProductStoneCell * cell = [tableView dequeueReusableCellWithIdentifier:PRODUCTID];
    if (!cell) {
        cell = [[RSProductStoneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PRODUCTID];
    }
    RSPicturePathModel * picturepathmodel = self.pictureArray[indexPath.row];
    cell.picturepathmodel = picturepathmodel;
    [cell.playPhoneBtn addTarget:self action:@selector(playPhone:) forControlEvents:UIControlEventTouchUpInside];
    cell.playPhoneBtn.tag = 10000+indexPath.row;
    cell.imageview.tag = 10000+indexPath.row;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showProductPicture:)];
    [cell.imageview addGestureRecognizer:tap];
    if ([self.WLTYPE isEqualToString:@"huangliao"]) {
        cell.numLabel.text = [NSString stringWithFormat:@"总体积:%@m³",picturepathmodel.num];
    }else{
        cell.numLabel.text = [NSString stringWithFormat:@"总面积:%@m²",picturepathmodel.num];
    }
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}




- (void)showProductPicture:(UITapGestureRecognizer *)tap{
    //图片浏览器
    //获得当前手势触发的在UITableView中的坐标
    CGPoint location = [tap locationInView:self.tableview];
    //获得当前坐标对应的indexPath
    NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:location];
    RSProductStoneCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
    RSPicturePathModel * picturepathmodel = self.pictureArray[tap.view.tag - 10000];
    [HUPhotoBrowser showFromImageView:cell.imageView withURLStrings:picturepathmodel.logo atIndex:0];
}

#pragma mark -- 打电话
- (void)playPhone:(UIButton *)btn{
    RSPicturePathModel * picturepathmodel = self.pictureArray[btn.tag - 10000];
    //要改是里面的值
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",picturepathmodel.phone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

#pragma mark -- 选择荒料货主
- (void)choiceHuange:(UIButton *)btn{
    _huangview.hidden = NO;
    _daview.hidden = YES;
    btn.selected = YES;
    _daBanBtn.selected = NO;
    self.WLTYPE = @"huangliao";
    [self loadTableviewNewData];
}

#pragma mark -- 选择大板货主
- (void)choiceDaBan:(UIButton *)btn{
    _huangview.hidden = YES;
    _huangLiaoBtn.selected = NO;
    btn.selected = YES;
    _daview.hidden = NO;
    self.WLTYPE = @"daban";
    [self loadTableviewNewData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     RSPicturePathModel *  picturepathmodel = self.pictureArray[indexPath.row];
    if ([self.userModel.userType isEqualToString:@"hxhz"]) {
        RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:picturepathmodel.usercode andCreat_userIDStr:picturepathmodel.usercodeID andUserIDStr:picturepathmodel.usercodeID];
        [self.navigationController pushViewController:cargoCenterVc animated:YES];
    }else{
        //这边要怎么拿到首页中的friend的数据
        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
        myRingVc.erpCodeStr = picturepathmodel.usercode;
        myRingVc.userIDStr = picturepathmodel.usercodeID;
        myRingVc.creat_userIDStr = picturepathmodel.usercodeID;
        //新增的属性
      //  myRingVc.userType = @"hxhz";
        myRingVc.userModel = self.userModel;
        [self.navigationController pushViewController:myRingVc animated:YES];
    }
}





//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//   // self.navigationController.navigationBar.hidden = YES;
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
