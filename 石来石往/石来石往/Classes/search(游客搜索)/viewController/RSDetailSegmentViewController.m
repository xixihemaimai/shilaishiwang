//
//  RSDetailSegmentViewController.m
//  石来石往
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "RSDetailSegmentViewController.h"
#import "RSDetailSegmentHeaderview.h"
#import "RSDetailSegmentCell.h"
#import "RSDetailSegmentModel.h"
//地图
#import "RSPictureViewController.h"
#import <MJRefresh.h>
#import "RSCompayWebviewViewController.h"
#import "RSMyRingViewController.h"
#import "RSCargoCenterBusinessViewController.h"
#import "RSDZYCMainCargoCenterViewController.h"




@interface RSDetailSegmentViewController ()
{
    UIView * _naviBarview;
}


@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,strong)NSMutableArray * detailArray;



@end

@implementation RSDetailSegmentViewController


- (NSMutableArray *)detailArray{
    if (_detailArray == nil) {
        _detailArray = [NSMutableArray array];
    }
    return _detailArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
//    if (@available(iOS 11.0, *)) {
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    //self.title = self.titleStr;
    [self addCustomTabelview];
    
    [self loadDetailNewData];
    
    UIButton * mapBtn = [[UIButton alloc]init];
    [mapBtn bringSubviewToFront:self.view];
    [mapBtn setImage:[UIImage imageNamed:@"地图"] forState:UIControlStateNormal];
    [mapBtn addTarget:self action:@selector(JumphuangliaoMapViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:mapBtn];
    mapBtn.sd_layout
    .rightSpaceToView(self.view, 12)
    .centerYIs(SCH - 100)
    .widthIs(50)
    .heightIs(50);
}

- (void)addCustomTabelview{
//    CGFloat Y = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//    }else{
//        Y = 64;
//    }
//    UITableView * tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCW, SCH - CGRectGetMaxY(self.navigationController.navigationBar.frame)) style:UITableViewStylePlain];
//    tableview.delegate = self;
//    tableview.dataSource = self;
//    self.tableview = tableview;
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDetailNewData];
    }];
}

- (void)loadDetailNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr2] forKey:@"width_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr3] forKey:@"height_filter"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr1] forKey:@"length_filter"];
    if ([self.searchType isEqualToString:@"huangliao"]) {
        //荒料
        [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr4] forKey:@"volume_filter"];
        //tempStr4要变，变任何值
        [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr4] forKey:@"volume"];
    }else{
        //大板
        //btnStr要变 变成-1
        [dict setObject:[NSString stringWithFormat:@"%@",self.btnStr4] forKey:@"volume_filter"];
        [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr4] forKey:@"volume"];
    }
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr2] forKey:@"width"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr3] forKey:@"height"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.tempStr1] forKey:@"length"];
//    NSLog(@"=====================%@",self.dataSource);
    [dict setObject:[NSString stringWithFormat:@"%@%@",self.dataSource,self.erpCode] forKey:@"companyName"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.stoneName] forKey:@"stoneName"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.userModel.userCode] forKey:@"userId"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.titleStr] forKey:@"blockId"];
    [dict setObject:self.searchType forKey:@"search_type"];
    [dict setObject:self.userModel.userID forKey:@"userId"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //URL_SEARCHDETAIL
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
//    NSLog(@"-------------------%@",parameters);
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_HEADER_SEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
//            NSLog(@"-------------------%@",json);
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                 [weakSelf.detailArray removeAllObjects];
//                NSMutableArray * array = nil;
//                array = json[@"Data"];
                
                weakSelf.detailArray = [RSDetailSegmentModel mj_objectArrayWithKeyValuesArray:json[@"Data"]];
                
                
//                if (array.count >= 1) {
//                    [weakSelf.detailArray removeAllObjects];
//                    for ( int i = 0; i < array.count; i++) {
//                        RSDetailSegmentModel * detailSegmentModel = [[RSDetailSegmentModel alloc]init];
//                        detailSegmentModel.collectionID = [[array objectAtIndex:i]objectForKey:@"collectionID"];
//                        detailSegmentModel.companyName = [[array objectAtIndex:i]objectForKey:@"companyName"];
//                        detailSegmentModel.isCollect = [[[array objectAtIndex:i]objectForKey:@"isCollect"] boolValue];
//                        detailSegmentModel.phone = [[array objectAtIndex:i]objectForKey:@"phone"];
//                        detailSegmentModel.stoneId = [[array objectAtIndex:i]objectForKey:@"stoneId"];
//                        detailSegmentModel.stoneMessage = [[array objectAtIndex:i]objectForKey:@"stoneMessage"];
//                        detailSegmentModel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
//                        detailSegmentModel.stoneType = [[[array objectAtIndex:i]objectForKey:@"stoneType"] integerValue];
//                        detailSegmentModel.stoneVolume = [[array objectAtIndex:i]objectForKey:@"stoneVolume"];
//                        detailSegmentModel.stoneWeight = [[array objectAtIndex:i]objectForKey:@"stoneWeight"];
//                        detailSegmentModel.stoneblno = [[array objectAtIndex:i]objectForKey:@"stoneblno"];
//                        detailSegmentModel.stoneturnsno = [[array objectAtIndex:i]objectForKey:@"stoneturnsno"];
//                        detailSegmentModel.storerreaName = [[array objectAtIndex:i]objectForKey:@"storerreaName"];
//                        [weakSelf.detailArray addObject:detailSegmentModel];
//                    }
//                }
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
            [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"CE";
    RSDetailSegmentCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[RSDetailSegmentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RSDetailSegmentModel * detailModel = self.detailArray[indexPath.row];
    cell.detailSegmnetModel = detailModel;
    cell.searchType = self.searchType;
    if ([_searchType isEqualToString:@"huangliao"]) {
        //荒料
        cell.tijiLabel.text = [NSString stringWithFormat:@"%@m³",detailModel.stoneVolume];
        cell.zhongLabel.text = [NSString stringWithFormat:@"%@吨",detailModel.stoneWeight];
        cell.cangkuLabel.text = [NSString stringWithFormat:@"%@",detailModel.storerreaName];
    }else{
        //大板
        cell.tijiLabel.text = [NSString stringWithFormat:@"%@m²",detailModel.stoneVolume];
        cell.zhongLabel.text = [NSString stringWithFormat:@"%@",detailModel.stoneturnsno];
        cell.cangkuLabel.text = [NSString stringWithFormat:@"%@",detailModel.storerreaName];
    }
    cell.huangliaoLabel.text = [NSString stringWithFormat:@"%@",detailModel.stoneId];
    cell.guiLabel.text = [NSString stringWithFormat:@"%@",detailModel.stoneMessage];
    if (indexPath.row < 9) {
        cell.countLabel.text = [NSString stringWithFormat:@"0%ld",(long)indexPath.row+1];
    }else{
        cell.countLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    }
    cell.loveBtn.tag = indexPath.row;
     [cell.loveBtn addTarget:self action:@selector(enshrineProduct:) forControlEvents:UIControlEventTouchUpInside];
     //这边要获取模型
    if (detailModel.isCollect == 0) {
        self.isSelect = NO;
    }else{
        self.isSelect = YES;
    }
    if (self.isSelect == YES) {
        cell.loveBtn.selected = YES;
         [cell.loveBtn setImage:[UIImage imageNamed:@"nh-拷贝"] forState:UIControlStateNormal];
    }else{
        cell.loveBtn.selected = NO;
         [cell.loveBtn setImage:[UIImage imageNamed:@"nh-拷贝-2"] forState:UIControlStateNormal];
    }
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 115;
}

static NSString *HEADID = @"headerID";
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    RSDetailSegmentHeaderview *  detaHeaderview = [[RSDetailSegmentHeaderview alloc]initWithReuseIdentifier:HEADID];
   // detaHeaderview.companyAndStoneModel = self.companyAndStoneModel;
    /*
     //立方
     @property (nonatomic,strong)UILabel * tiLabel;
     //颗数
     @property (nonatomic,strong)UILabel * keLabel;
     //图片
     @property (nonatomic,strong)UIImageView * imageview;
     
     //石头名字
     @property (nonatomic,strong)UILabel * productLabel;
     
     */
    detaHeaderview.companyLabel.text = self.companyName;
    detaHeaderview.numberPhoneLabel.text = self.phone;
    detaHeaderview.productLabel.text = self.shitouName;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showCompanyH5View:)];
    detaHeaderview.companyLabel.userInteractionEnabled = YES;
    [detaHeaderview.companyLabel addGestureRecognizer:tap];
    [detaHeaderview.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imageUrl]] placeholderImage:[UIImage imageNamed:@"512"]];
    if ([self.searchType isEqualToString:@"huangliao"]) {
        detaHeaderview.weightLabel.text = [NSString stringWithFormat:@"%@吨",self.weight];
         detaHeaderview.tiLabel.text = [NSString stringWithFormat:@"%@m³",self.piAndFangStr];
        detaHeaderview.keLabel.text = [NSString stringWithFormat:@"%@颗",self.keAndZaStr];
        detaHeaderview.weightLabel.hidden = NO;
    }else{
        detaHeaderview.weightLabel.hidden = YES;
         detaHeaderview.tiLabel.text = [NSString stringWithFormat:@"%@m²",self.piAndFangStr];
         detaHeaderview.keLabel.text = [NSString stringWithFormat:@"%@匝",self.keAndZaStr];
    }
    [detaHeaderview.playPhoneBtn addTarget:self action:@selector(playPhone:) forControlEvents:UIControlEventTouchUpInside];
    return detaHeaderview;
}


- (void)showCompanyH5View:(UITapGestureRecognizer *)tap{
    /*
    RSCompayWebviewViewController * companyVc = [[RSCompayWebviewViewController alloc]init];
    companyVc.showRightBtn = NO;
    companyVc.urlStr = [NSString stringWithFormat:@"%@",self.companyAndStoneModel.companyUrl];
    companyVc.titleStr = [NSString stringWithFormat:@"%@",self.companyAndStoneModel.companyName];
    [self presentViewController:companyVc animated:YES completion:nil];
    */
   
    if ([self.userModel.userType isEqualToString:@"hxhz"]) {
        if ([self.dataSource isEqualToString:@"DZYC"]) {
            
            //有问题
            RSDZYCMainCargoCenterViewController  * cargoCenterVc = [RSDZYCMainCargoCenterViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:self.erpCode andCreat_userIDStr:@"-1" andUserIDStr:@"-1" andDataSoure:self.dataSource];
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
            
        }else{
            
            RSCargoCenterBusinessViewController * cargoCenterVc = [RSCargoCenterBusinessViewController suspendCenterPageVCUserModel:self.userModel andErpCodeStr:self.erpCode andCreat_userIDStr:@"-1" andUserIDStr:@"-1"];
            [self.navigationController pushViewController:cargoCenterVc animated:YES];
        }
        
    }else{
        RSMyRingViewController * myRingVc = [[RSMyRingViewController alloc]init];
        myRingVc.erpCodeStr = self.erpCode;
        myRingVc.userIDStr = @"-1";
        myRingVc.creat_userIDStr = @"-1";
        //新增的属性
        //myRingVc.userType = @"hxhz";
        myRingVc.userModel = self.userModel;
        [self.navigationController pushViewController:myRingVc animated:YES];
    }
}


- (void)playPhone:(UIButton *)btn{
    
    
    
    
    
    //打电话
//    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.phone];
//    UIWebView *callWebview = [[UIWebView alloc] init];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    [self.view addSubview:callWebview];
    RSWeakself
    [UserManger checkLogin:self successBlock:^{
        //    CLog(@"打电话");
        [JHSysAlertUtil presentAlertViewWithTitle:@"温馨提示" message:@"确认是否给对方拨打电话" cancelTitle:@"确定" defaultTitle:@"取消" distinct:true cancel:^{
            
            NSMutableDictionary * phoneDict = [NSMutableDictionary dictionary];
            //这边还需要添加一个发送短信接口
            [phoneDict setObject:weakSelf.phone forKey:@"toTel"];
    //            URL_SEND_CALL_PHONESMS
            [phoneDict setObject:[UserManger getUserObject].userPhone forKey:@"fromTel"];
            NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":[UserManger Verifykey] == nil ? @"" : [UserManger Verifykey],@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
            XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
            [network getDataWithUrlString:URL_SEND_CALL_PHONESMS withParameters:parameters withBlock:^(id json, BOOL success) {
            }];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",weakSelf.phone]] options:@{} completionHandler:^(BOOL success) {
                NSLog(@"%d",success);
                if(!success) return ;
            }];
            
            
            
            //打电话
//            UIWebView *webview = [[UIWebView alloc]init];
//            [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",weakSelf.phone]]]];
//            [weakSelf.view addSubview:webview];
           
        } confirm:^{
        }];
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

#pragma mark  -- 收藏的接口
- (void)enshrineProduct:(UIButton *)btn{
    //这边要对模型进行替换掉，也要对复用出现的问题，
    RSDetailSegmentModel *detailModel = self.detailArray[btn.tag];
    //收藏
    if ([btn.currentImage isEqual:[UIImage imageNamed:@"nh-拷贝-2"]]) {
        if (detailModel.isCollect != 1) {
           // detailModel.isCollect = 1;
            //这边还要加模型的状态变成1
            self.isSelect = YES;
            [self collectProduct:detailModel andNSString:@"add" andUIButton:btn];
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
           // [btn setImage:[UIImage imageNamed:@"nh-拷贝"] forState:UIControlStateNormal];
            //[self.detailArray replaceObjectAtIndex:btn.tag withObject:detailModel];
        }
    }else{
         //取消收藏
        if (detailModel.isCollect == 1) {
            //这边还要把模型的状态变成0
            self.isSelect = NO;
            [self collectProduct:detailModel andNSString:@"del" andUIButton:btn];
            [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
        }
    }
}

#pragma mark -- 收藏和取消收藏的方法
- (void)collectProduct:(RSDetailSegmentModel *)detailModel andNSString:(NSString *)add andUIButton:(UIButton *)btn{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%@",detailModel.collectionID] forKey:@"collectionID"];
    [dict setObject:[NSString stringWithFormat:@"%@",add] forKey:@"operationType"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.userModel.userID] forKey:@"userId"];
    if ([self.dataSource isEqualToString:@"HXSC"]) {
         [dict setObject:[NSString stringWithFormat:@"%@",@"HXSC"] forKey:@"collType"];
    }else{
         [dict setObject:[NSString stringWithFormat:@"%@",@"DZYC"] forKey:@"collType"];
    }
    [dict setObject:[NSString stringWithFormat:@"%@",detailModel.stoneblno] forKey:@"stoneblno"];
    [dict setObject:[NSString stringWithFormat:@"%@",detailModel.stoneturnsno] forKey:@"stoneturnsno"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"erpId"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    // URL_COLLECTION
    [network getDataWithUrlString:URL_HEADER_TEXT_STONECO_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                if (detailModel.isCollect == 0) {
                    detailModel.isCollect = 1;
                     detailModel.collectionID = json[@"collectionID"];
                    [btn setImage:[UIImage imageNamed:@"nh-拷贝"] forState:UIControlStateNormal];
                    [weakSelf.detailArray replaceObjectAtIndex:btn.tag withObject:detailModel];
                }else{
                    detailModel.isCollect = 0;
                    detailModel.collectionID = json[@"collectionID"];
                    [btn setImage:[UIImage imageNamed:@"nh-拷贝-2"] forState:UIControlStateNormal];
                    [weakSelf.detailArray replaceObjectAtIndex:btn.tag withObject:detailModel];
                }
            }
        }
    }];
}

#pragma mark -- 跳转地图
- (void)JumphuangliaoMapViewController:(UIButton *)btn{
    if ([self.searchType isEqualToString:@"huangliao"]) {
        //这边要添加一个地图显示
        RSPictureViewController * pictureVc = [[RSPictureViewController alloc]init];
        pictureVc.mtypeStr = @"0";
        pictureVc.titleStr = @"荒料界面显示图片";
        //[self presentViewController:pictureVc animated:YES completion:nil];
        [self.navigationController pushViewController:pictureVc animated:YES];
    }else{
        //地图隐藏起来
        RSPictureViewController * pictureVc = [[RSPictureViewController alloc]init];
        pictureVc.mtypeStr = @"1";
        pictureVc.titleStr = @"大板界面显示图片";
        //[self presentViewController:pictureVc animated:YES completion:nil];
        [self.navigationController pushViewController:pictureVc animated:YES];
    }
}

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
