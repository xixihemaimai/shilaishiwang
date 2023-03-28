//
//  RSPersonalServiceViewController.m
//  石来石往
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPersonalServiceViewController.h"

#import "RSPersonServiceCell.h"

#import "RSPersonlServiceCompleteCell.h"


#import "RSAlreadyEvaluatedViewController.h"

#import "RSAddPictureMenView.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "PhotoUploadHelper.h"
//#import "ZYQAssetPickerController.h"



#import <HUPhotoBrowser.h>
//模型
#import "RSPersonlModel.h"
#import "RSPersonlNetworkPictureModel.h"


#import "RSStorehouseDetailsViewController.h"
#import "RSServiceMarketViewController.h"


#import "WWDViewController.h"
#define ECA 4
#define margin 10


//ZYQAssetPickerControllerDelegate
@interface RSPersonalServiceViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    //未完成按键
    UIButton * _incompleteBtn;
    //已完成按键
    UIButton * _completeBtn;
    
    //未完成下面的下划线
    UIView * _inView;
    //已完成下面的下划线
    UIView * _completeView;
    //用来判断是未完成的按键还是已完成的按键
    NSString * temp;
    //蒙版
    UIView * _menview;
    
    
    //蒙版中图片
    UIImageView * _centerImageview;
    //蒙版的功能文子
    UILabel * _centerLabel;
    //蒙版的功能文子描述
    UILabel * _serviceLabel;
    //蒙版的功能的选择--取消
    UIButton * _cancelBtn;
    //蒙版的功能的选择--确定
    UIButton * _sureBtn;
}


//@property (nonatomic,strong)UITableView * tableview;



// 用来存放Cell的唯一标示符未完成
@property (nonatomic, strong) NSMutableDictionary *cellPersonNoCompelteDic;

//用来存放已完成Cell唯一标示已完成
//@property (nonatomic, strong) NSMutableDictionary *cellPersonCompeletDic;


/**
 *按钮选中中间值
 */
@property(nonatomic,strong)UIButton * selectedBtn;



/**存储服务人员的数据的数组*/
@property (nonatomic,strong)NSMutableArray * personlArray;


 //用来存上传图片的数组
@property (nonatomic,strong)NSMutableArray * imageArray;

@property (nonatomic,strong)RSAddPictureMenView * addPictureMenView;

@end

@implementation RSPersonalServiceViewController


- (NSMutableArray *)personlArray{
    if (_personlArray == nil) {
        _personlArray = [NSMutableArray array];
    }
    return _personlArray;
}

-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    //self.hidesBottomBarWhenPushed = YES;
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];

    
    
    //去除导航栏下方的横线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.cellPersonNoCompelteDic = [[NSMutableDictionary alloc]init];
    //self.cellPersonCompeletDic = [[NSMutableDictionary alloc]init];
    
    self.title = @"服务中心";
    
    RSRightNavigationButton * showQRBtn = [[RSRightNavigationButton alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    [showQRBtn setImage:[UIImage imageNamed:@"扫二维码用的"] forState:UIControlStateNormal];
    [showQRBtn addTarget:self action:@selector(scanSecondAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:showQRBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    temp = @"0";
    //count =@"100000000000000";
    [self addPersonlServiceData];
    
    
    //总的界面
//    CGFloat Y = 0.0;
//    CGFloat bottomH = 0.0;
//    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
//        Y = 88;
//        bottomH = 34;
//    }else{
//        Y = 64;
//        bottomH = 0.0;
//    }
    
    
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
    
    
    //这边要添加一个视图
    UIView * choiceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 40)];
    choiceView.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
    choiceView.layer.borderWidth = 1;
    choiceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:choiceView];
    
    UIButton * incompleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (SCW/2) - 0.5, 38)];
    [incompleteBtn setTitle:@"未完结" forState:UIControlStateNormal];
    [incompleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
    incompleteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [choiceView addSubview:incompleteBtn];
    
    incompleteBtn.tag = 1000000001;
    [incompleteBtn addTarget:self action:@selector(choiceSecondServiceStyle:) forControlEvents:UIControlEventTouchUpInside];
    
    _incompleteBtn = incompleteBtn;
    
    //分隔线
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(incompleteBtn.frame), 6, 1, 28)];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#D6D6D6"];
    [choiceView addSubview:midView];
    
    
    
    UIButton * completeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midView.frame), 0, (SCW/2) - 0.5, 38)];
    [completeBtn setTitle:@"已完结" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#313131"] forState:UIControlStateNormal];
    completeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [choiceView addSubview:completeBtn];
    
    completeBtn.tag = 1000000002;
    [completeBtn addTarget:self action:@selector(choiceSecondServiceStyle:) forControlEvents:UIControlEventTouchUpInside];
    
    _completeBtn = completeBtn;
    UIView * inView = [[UIView alloc]init];
    inView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    
    CGFloat lineViewH = 1;
    
    inView.yj_height = lineViewH;
    inView.yj_y = CGRectGetMaxY(incompleteBtn.frame);
    inView.yj_width = 60;
    inView.yj_centerX = incompleteBtn.yj_centerX;
    [inView sizeToFit];
    // 设置下划线的宽度比文本内容宽度大10
    [choiceView addSubview:inView];
    inView.hidden = NO;
    _inView = inView;
    
    UIView * completeView = [[UIView alloc]init];
    
    completeView.backgroundColor = [UIColor colorWithHexColorStr:@"#3385FF"];
    completeView.yj_height = lineViewH;
    completeView.yj_y = CGRectGetMaxY(completeBtn.frame);
    completeView.yj_width = 60;
    completeView.yj_centerX = completeBtn.yj_centerX;
    [completeView sizeToFit];
    // 设置下划线的宽度比文本内容宽度大10
    [choiceView addSubview:completeView];
    completeView.hidden = YES;
    
    _completeView = completeView;
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(choiceView.frame), SCW, SCH - CGRectGetMaxY(choiceView.frame) - Height_NavBar);
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(choiceView.frame), SCW, SCH - CGRectGetMaxY(choiceView.frame) - bottomH ) style:UITableViewStylePlain];
//
//    self.tableview = tableview;
//
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
//    self.tableview.showsHorizontalScrollIndicator = NO;
//    self.tableview.showsVerticalScrollIndicator = NO;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    [self.view addSubview:self.tableview];
    //向下刷新
    RSWeakself
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf addPersonlServiceData];
    }];
    
    
    UIView * menview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    menview.backgroundColor = [UIColor colorWithHexColorStr:@"#000000" alpha:0.5];
    [self.view addSubview:menview];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiheSecondMenView:)];
    menview.userInteractionEnabled = YES;
    [menview addGestureRecognizer:tap];
    
    [menview bringSubviewToFront:self.view];
    _menview = menview;
    _menview.hidden = YES;
    UIView * centerView = [[UIView alloc]initWithFrame:CGRectMake(24, (SCH/2) - 80, SCW - 48, 160)];
    centerView.backgroundColor = [UIColor whiteColor];
    [menview addSubview:centerView];

    UIImageView * centerImageview = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 - 40, (SCH/2) - 120, 80, 80)];
    centerImageview.backgroundColor = [UIColor clearColor];
    centerImageview.image = [UIImage imageNamed:@"开始服务"];
    centerImageview.layer.cornerRadius = centerImageview.yj_width * 0.5;
    centerImageview.layer.masksToBounds = YES;
    [menview addSubview:centerImageview];
    _centerImageview = centerImageview;
    
    
    UILabel * centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, centerView.yj_width, 18)];
    centerLabel.text = @"开始服务";
    centerLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    centerLabel.font = [UIFont systemFontOfSize:18];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    [centerView addSubview:centerLabel];
    _centerLabel = centerLabel;
    
    
    
    UILabel * serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(centerLabel.frame) + 10, centerView.yj_width, 15)];
    serviceLabel.text = @"开始对此服务展开工作";
    serviceLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    serviceLabel.font = [UIFont systemFontOfSize:15];
    serviceLabel.textAlignment = NSTextAlignmentCenter;
    [centerView addSubview:serviceLabel];
    _serviceLabel = serviceLabel;
    
    
    UIView * serviceFengView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(serviceLabel.frame) + 15, centerView.yj_width, 1)];
    serviceFengView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
    [centerView addSubview:serviceFengView];
    
    
    UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(serviceFengView.frame),(centerView.yj_width/2) - 1, centerView.yj_height - CGRectGetMaxY(serviceFengView.frame))];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [centerView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelSecondChoiceAction:) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn = cancelBtn;
    
    
    
    UIView * midCenterView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(serviceFengView.frame), 1, cancelBtn.yj_height)];
    midCenterView.backgroundColor = [UIColor colorWithHexColorStr:@"#E9E9E9"];
    [centerView addSubview:midCenterView];
    
    
    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midCenterView.frame),CGRectGetMaxY(serviceFengView.frame), centerView.yj_width - cancelBtn.yj_width - midCenterView.yj_width, centerView.yj_height - CGRectGetMaxY(serviceFengView.frame))];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [centerView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureSecondChoiceAction:) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn = sureBtn;
    
    
    
    
    //self.navigationController.navigationBar.userInteractionEnabled = NO;
    _addPictureMenView = [[RSAddPictureMenView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    _addPictureMenView.backgroundColor = [UIColor colorWithHexColorStr:@"#000000" alpha:0.5];
    [_addPictureMenView.addPictureBtn addTarget:self action:@selector(addServicePicture:) forControlEvents:UIControlEventTouchUpInside];
//    [_addPictureMenView.uploadBtn addTarget:self action:@selector(addMenViewPictureUpload:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAddPictureMenview:)];
    _addPictureMenView.userInteractionEnabled = YES;
    
    //_addPictureMenView.uploadBtn.tag = btn.tag;
    
    [self.view addSubview:_addPictureMenView];
    [_addPictureMenView addGestureRecognizer:tap1];
    _addPictureMenView.hidden = YES;
    
    
    
}


//获取服务人员的列表
- (void)addPersonlServiceData{
    [SVProgressHUD showWithStatus:@"加载服务内容,请等待........"];
    _menview.hidden = YES;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    [dict setObject:@"0" forKey:@"search"];
    if (![temp isEqualToString:@"0"]){
         [dict setObject:temp forKey:@"status"];
    }
    else{
         [dict setObject:@"1" forKey:@"status"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_PERSONLSEARCHSERVICEFORWAITER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
                
                [weakSelf.personlArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                if (array.count > 0) {
                    for (int i = 0; i < array.count; i++) {
                        RSPersonlModel * personlmodel = [[RSPersonlModel alloc]init];
                        personlmodel.appointTime = [[array objectAtIndex:i]objectForKey:@"appointTime"];
                        personlmodel.orgName = [[array objectAtIndex:i]objectForKey:@"orgName"];
                        personlmodel.outBoundNo = [[array objectAtIndex:i]objectForKey:@"outBoundNo"];
                        personlmodel.serviceId = [[array objectAtIndex:i]objectForKey:@"serviceId"];
                        personlmodel.serviceThing = [[array objectAtIndex:i]objectForKey:@"serviceThing"];
                        personlmodel.serviceType = [[array objectAtIndex:i]objectForKey:@"serviceType"];
                        
                        personlmodel.serviceKind = [[array objectAtIndex:i]objectForKey:@"serviceKind"];
                        personlmodel.status = [[array objectAtIndex:i]objectForKey:@"status"];
                        personlmodel.starLevel = [[array objectAtIndex:i]objectForKey:@"starLevel"];
                        [weakSelf.personlArray addObject:personlmodel];
                    }
                }
                [SVProgressHUD dismiss];
                [weakSelf.tableview reloadData];
                [weakSelf.tableview.mj_header endRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
                [weakSelf.tableview.mj_header endRefreshing];
            }
        }else{
               [SVProgressHUD showErrorWithStatus:@"获取失败"];
             [weakSelf.tableview.mj_header endRefreshing];
        }
    }];
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.personlArray.count;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([temp isEqualToString:@"0"]) {
        return 172;
    }else{
       return 172;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSPersonlModel * personmodel = self.personlArray[indexPath.row];
    if ([temp isEqualToString:@"0"]) {
        NSString *identifier = [_cellPersonNoCompelteDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
        if (identifier == nil) {
            identifier = [NSString stringWithFormat:@"%@%@", @"PERSONLSERVICEID", [NSString stringWithFormat:@"%@", indexPath]];
            [_cellPersonNoCompelteDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 注册Cell
        }
      //static NSString * PERSONLSERVICEID = @"PERSONLSERVICEID";
        RSPersonServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[RSPersonServiceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        //服务详情
        cell.personlServiceModifyServiceBtn.tag = 1000000000 + indexPath.row;
        [cell.personlServiceModifyServiceBtn addTarget:self action:@selector(serviceDetail:) forControlEvents:UIControlEventTouchUpInside];
        //接受服务
        cell.personlServiceStartServiceBtn.tag = 1000000000 + indexPath.row;
        [cell.personlServiceStartServiceBtn addTarget:self action:@selector(starService:) forControlEvents:UIControlEventTouchUpInside];
        //上传图片
        cell.personlUploadPictureBtn.tag = 1000000000 + indexPath.row;
        [cell.personlUploadPictureBtn addTarget:self action:@selector(fristUploadPicture:) forControlEvents:UIControlEventTouchUpInside];
        if ([personmodel.serviceType isEqualToString:@"出库服务"]) {
            //出库服务
            cell.personlServiceImageView.image = [UIImage imageNamed:@"出库服务"];
            cell.personlServiceOutLabel.text = [NSString stringWithFormat:@"出库单:%@",personmodel.outBoundNo];
            
            
        }else{
            //市场服务
            cell.personlServiceImageView.image = [UIImage imageNamed:@"市场服务"];
            if ([personmodel.serviceKind isEqualToString:@""]) {
                cell.personlServiceOutLabel.text = [NSString stringWithFormat:@"类型:其他"];
            }else{
                cell.personlServiceOutLabel.text = [NSString stringWithFormat:@"类型:%@",personmodel.serviceKind];
            }
           cell.personlServiceModifyServiceBtn.sd_layout
            .widthIs(((SCW - 24)/2) - 1);
           cell.personlUploadPictureBtn.sd_layout
            .widthIs(0);
        }
        if ([personmodel.status isEqualToString:@"进行中"]) {

//            [cell.personlServiceStartServiceBtn setTitle:@"服务执行" forState:UIControlStateNormal];
//            cell.personlServiceStartServiceBtn.enabled = NO;
//            [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
//            [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
            [cell.personlServiceStartServiceBtn setTitle:@"服务完成" forState:UIControlStateNormal];
            cell.personlServiceStartServiceBtn.enabled = YES;
            [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor whiteColor]];
            [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
            cell.personlUploadPictureBtn.enabled = YES;
            [cell.personlUploadPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
            [cell.personlUploadPictureBtn setBackgroundColor:[UIColor whiteColor]];
            [cell.myServiceBtn setTitle:@"进行中" forState:UIControlStateNormal];
            [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#B3E49A"]];
            
            
            
            
            
        }else if ([personmodel.status isEqualToString:@"已受理"]){
            [cell.personlServiceStartServiceBtn setTitle:@"接收服务" forState:UIControlStateNormal];
            cell.personlServiceStartServiceBtn.enabled = YES;
            [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
            [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
            cell.personlUploadPictureBtn.enabled = NO;
            [cell.personlUploadPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
            [cell.personlUploadPictureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
            [cell.myServiceBtn setTitle:@"已受理" forState:UIControlStateNormal];
            [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FBCC81"]];
        }else if ([personmodel.status isEqualToString:@"未受理"]){

            [cell.personlServiceStartServiceBtn setTitle:@"接收服务" forState:UIControlStateNormal];
            cell.personlServiceStartServiceBtn.enabled = YES;
            [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
            [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
            
            
             cell.personlUploadPictureBtn.enabled = NO;
            [cell.personlUploadPictureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
            [cell.personlUploadPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
            
            [cell.myServiceBtn setTitle:@"未受理" forState:UIControlStateNormal];
            [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
        }else if ([personmodel.status isEqualToString:@"派遣中"]){
            
            if ([personmodel.serviceType isEqualToString:@"出库服务"]) {
                [cell.personlServiceStartServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
                [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor whiteColor]];
                [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
                cell.personlServiceStartServiceBtn.enabled = YES;

                cell.personlUploadPictureBtn.enabled = YES;
                [cell.personlUploadPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
                [cell.personlUploadPictureBtn setBackgroundColor:[UIColor whiteColor]];
                [cell.myServiceBtn setTitle:@"派遣中" forState:UIControlStateNormal];
                [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
            }else{
                [cell.personlServiceStartServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
                [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor whiteColor]];
                [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
                cell.personlServiceStartServiceBtn.enabled = YES;
             //   cell.personlUploadPictureBtn.enabled = YES;
//                [cell.personlUploadPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//                [cell.personlUploadPictureBtn setBackgroundColor:[UIColor whiteColor]];
                [cell.myServiceBtn setTitle:@"派遣中" forState:UIControlStateNormal];
                [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
            }
        }else{
            cell.personlServiceStartServiceBtn.enabled = NO;
            [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
            [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#f9f9f9"] forState:UIControlStateNormal];
            [cell.myServiceBtn setTitle:@"未受理" forState:UIControlStateNormal];
            [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f9f9f9"]];
        }
        cell.personlServiceLabel.text = [NSString stringWithFormat:@"%@",personmodel.serviceType];
        cell.personlServiceNameLabel.text = [NSString stringWithFormat:@"商户:%@",personmodel.orgName];
        cell.personlServiceTimeLabel.text = [NSString stringWithFormat:@"预约时间:%@",personmodel.appointTime];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        
//        NSString *identifier = [_cellPersonCompeletDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
//        if (identifier == nil) {
//            identifier = [NSString stringWithFormat:@"%@%@", @"PERSONLSERVICEID", [NSString stringWithFormat:@"%@", indexPath]];
//            [_cellPersonCompeletDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
//            // 注册Cell
//
//        }
        
        
       static NSString * PERSONLSERVICECOMPLETEID = @"PERSONLSERVICECOMPLETEID";
        RSPersonlServiceCompleteCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSONLSERVICECOMPLETEID];
        if (!cell) {
            cell = [[RSPersonlServiceCompleteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PERSONLSERVICECOMPLETEID];
        }
        //服务详情
        cell.personlCompleteModifyServiceBtn.tag = 1000000000 + indexPath.row;
        [cell.personlCompleteModifyServiceBtn addTarget:self action:@selector(serviceSecondDetail:) forControlEvents:UIControlEventTouchUpInside];
        //查看评价
        cell.personlCompleteEvaluationServiceBtn.tag = 1000000000 + indexPath.row;
        [cell.personlCompleteEvaluationServiceBtn addTarget:self action:@selector(viewEvaluation:) forControlEvents:UIControlEventTouchUpInside];
        //上传图片
        cell.personlCompleteUploadPictureBtn.tag = 1000000000 + indexPath.row;
        [cell.personlCompleteUploadPictureBtn addTarget:self action:@selector(secondCompleteUploadPicture:) forControlEvents:UIControlEventTouchUpInside];
        if ([personmodel.serviceType isEqualToString:@"出库服务"]) {
            //出库服务
            cell.personlCompleteImageView.image = [UIImage imageNamed:@"出库服务"];
            cell.personlCompleteOutLabel.text = [NSString stringWithFormat:@"出库单:%@",personmodel.outBoundNo];
            
            [cell.personlCompleteUploadPictureBtn setTitle:@"查看图片" forState:UIControlStateNormal];
            cell.personlCompleteModifyServiceBtn.sd_layout
            .widthIs(((SCW - 24)/3) - 1);
            cell.personlCompleteUploadPictureBtn.sd_layout
            .widthIs((SCW - 24)/3 - 1);
        }else{
            //市场服务
            cell.personlCompleteImageView.image = [UIImage imageNamed:@"市场服务"];
            cell.personlCompleteOutLabel.text = [NSString stringWithFormat:@"类型:%@",personmodel.serviceKind];
            cell.personlCompleteModifyServiceBtn.sd_layout
            .widthIs(((SCW - 24)/2) - 1);
            cell.personlCompleteUploadPictureBtn.sd_layout
            .widthIs(0);
        }
        cell.personlCompleteLabel.text = [NSString stringWithFormat:@"%@",personmodel.serviceType];
        cell.personlCompleteNameLabel.text = [NSString stringWithFormat:@"商户:%@",personmodel.orgName];
        cell.personlCompleteTimeLabel.text = [NSString stringWithFormat:@"预约时间:%@",personmodel.appointTime];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([personmodel.starLevel integerValue] > 0) {
            [cell.personlCompleteEvaluationServiceBtn setTitle:@"查看评价" forState:UIControlStateNormal];
            cell.personlCompleteEvaluationServiceBtn.enabled = YES;
            [cell.personlCompleteEvaluationServiceBtn setBackgroundColor:[UIColor whiteColor]];
            [cell.personlCompleteEvaluationServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
            
        }else{
            cell.personlCompleteEvaluationServiceBtn.enabled = NO;
            [cell.personlCompleteEvaluationServiceBtn setTitle:@"暂无评价" forState:UIControlStateNormal];
            [cell.personlCompleteEvaluationServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
            [cell.personlCompleteEvaluationServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
        }
        return cell;
    }
}

//FIXME:未完成的上传图片
- (void)fristUploadPicture:(UIButton *)btn{
    _addPictureMenView.tag = btn.tag;
    _addPictureMenView.hidden = NO;
     [_imageArray removeAllObjects];
    NSIndexPath * indexptah = [NSIndexPath indexPathForRow:btn.tag - 1000000000 inSection:0];
    [self obtainNetworkPictureDataIndexpath:indexptah];
    
}

//FIXME:已完成的上传图片
- (void)secondCompleteUploadPicture:(UIButton *)btn{
    _addPictureMenView.tag = btn.tag;
    _addPictureMenView.hidden = NO;
    [_imageArray removeAllObjects];
    NSIndexPath * indexptah = [NSIndexPath indexPathForRow:btn.tag - 1000000000 inSection:0];
    [self obtainNetworkPictureDataIndexpath:indexptah];
}

//#pragma mark --- 上传图片按键（蒙版里面的）
//- (void)addMenViewPictureUpload:(UIButton *)btn{
//    NSIndexPath * indexptah = [NSIndexPath indexPathForRow:btn.tag - 1000000000 inSection:0];
//    [self uploadQuestionPersonlPictureIndexpath:indexptah];
//    self.navigationController.navigationBar.userInteractionEnabled = YES;
//    [_addPictureMenView removeFromSuperview];
//}

#pragma mark -- 获取网络图片，也是查看图片
- (void)obtainNetworkPictureDataIndexpath:(NSIndexPath *)indexpath{
    [self.imageArray removeAllObjects];
    [self nineGrid];
    /*
     当前服务Id    serviceId    String
     标识    search    String    上传图片传4
    */
    [SVProgressHUD showWithStatus:@"获取图片中........"];
    RSPersonlModel * personlmodel = self.personlArray[indexpath.row];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:personlmodel.serviceId forKey:@"serviceId"];
    [dict setObject:@"4" forKey:@"search"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getMoreImageDataWithUrlString:URL_PERSONLSEARCHSERVICEFORWAITER_IOS withParameters:parameters andDataArray:_imageArray withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                 [SVProgressHUD dismiss];
                if (array.count > 0) {
                    for ( int i = 0; i < array.count; i++) {
                            RSPersonlNetworkPictureModel * personlNetworkPicturemodel = [[RSPersonlNetworkPictureModel alloc]init];
                            personlNetworkPicturemodel.imageId = [[[array objectAtIndex:i]objectForKey:@"id"] integerValue];
                            personlNetworkPicturemodel.img = [[array objectAtIndex:i]objectForKey:@"img"];
                            [weakSelf.imageArray addObject:personlNetworkPicturemodel];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf nineGrid];
                    });
                }else{
                   //[SVProgressHUD showErrorWithStatus:@"获取图片失败"];
                }
            }else{
                
                [SVProgressHUD showErrorWithStatus:@"获取图片失败"];
            }
        }else{
            
             [SVProgressHUD showErrorWithStatus:@"获取图片失败"];
        }
    }];
}






#pragma mark -- 上传图片
- (void)uploadQuestionPersonlPictureIndexpath{
    RSPersonlModel * personmodel = self.personlArray[_addPictureMenView.tag - 1000000000];
    [SVProgressHUD showWithStatus:@"图片正在上传中,请等待中......."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:personmodel.serviceId forKey:@"serviceId"];
    [dict setObject:@"1" forKey:@"search"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    NSArray *avatarArray = [NSArray arrayWithObject:_photoEntityWillUpload.image];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSData *imageData;
    for (UIImage *avatar in avatarArray)
    {
        imageData = UIImageJPEGRepresentation(avatar, 1);
        [dataArray addObject:imageData];
    }
    //RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getImageDataWithUrlString:URL_PERSONLSEARCHSERVICEFORWAITER_IOS withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [SVProgressHUD dismiss];
                _addPictureMenView.hidden = YES;
                
                
                
                
//                if ([temp isEqualToString:@"0"]) {
//                        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:_addPictureMenView.tag - 1000000000 inSection:0];
//                        //图片上传成功之后，开始服务就可以点击了
//                        RSPersonServiceCell * cell = [weakSelf.tableview cellForRowAtIndexPath:indexpath];
//
//                    if ([cell.myServiceBtn.currentTitle isEqualToString:@"进行中"]) {
//
//                        [cell.personlServiceStartServiceBtn setTitle:@"服务执行" forState:UIControlStateNormal];
//                        cell.personlServiceStartServiceBtn.enabled = NO;
//                        [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
//                        [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
//
//                    }else{
//                        [cell.personlServiceStartServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
//                        cell.personlServiceStartServiceBtn.enabled = YES;
//                        [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//                        [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor whiteColor]];
//
//                    }
//                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"上传失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
        }
    }];
}




- (void)addServicePicture:(UIButton *)btn{
    //NSLog(@"添加图片");
    if (_imageArray.count >= 3) {
        [SVProgressHUD showInfoWithStatus:@"最多提交3张图片"];
    } else {
        
        
        
        
        
        
        RSSelectNeedImageTool * selectTool = [[RSSelectNeedImageTool alloc]init];
        [selectTool openPhotoAlbumAndOpenCameraViewController:self];
        selectTool.returnData = ^(XPhotoUploaderContentEntity * _Nonnull photoEntityWillUpload) {
            _photoEntityWillUpload = photoEntityWillUpload;
            [self uploadQuestionPersonlPictureIndexpath];
        };
        
        
        
//        RSWeakself
//        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //打开系统相机
//            [weakSelf openCamera];
//        }];
//        [alert addAction:action1];
//        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //打开系统相册
//           // [weakSelf selectPictures];
//            [weakSelf openPhotoAlbum];
//
//        }];
//        [alert addAction:action2];
//
//
//        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //这边去取消操作
//            [alert dismissViewControllerAnimated:YES completion:nil];
//        }];
//        [alert addAction:action3];
//        [self presentViewController:alert animated:YES completion:nil];
    }
}

//
//#pragma mark -- 使用系统的方式打开相册
//- (void)openPhotoAlbum{
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.delegate = self;
//    //设置选择后的图片可被编辑
//    picker.allowsEditing = YES;
//    [self presentViewController:picker animated:YES completion:nil];
//}
//
//
//#pragma mark -- 当用户选取完成后调用
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
//
//        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//        NSDictionary *mediaMetadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
//        if (mediaMetadata)
//        {
//
//        } else {
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            __block NSDictionary *blockMediaMetadata = mediaMetadata;
//            __block UIImage *blockImage = pickedImage;
//            [library
//             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
//             resultBlock: ^ (ALAsset *asset) {
//                 ALAssetRepresentation *representation = [asset defaultRepresentation];
//                 blockMediaMetadata = [representation metadata];
//                 [picker dismissViewControllerAnimated:YES completion:nil];
//                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
//             }
//             failureBlock: ^ (NSError *error) {
//
//             }];
//        }
//
//        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//        {
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            __block NSDictionary *blockMediaMetadata = mediaMetadata;
//            __block UIImage *blockImage = pickedImage;
//            [library
//             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
//             resultBlock: ^ (ALAsset *asset) {
//                 ALAssetRepresentation *representation = [asset defaultRepresentation];
//                 blockMediaMetadata = [representation metadata];
//                 [picker dismissViewControllerAnimated:YES completion:nil];
//                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
//             }
//             failureBlock: ^ (NSError *error) {
//             }];
//            [picker dismissViewControllerAnimated:YES completion:nil];
//        } else {
//
//        }
//    }
//}
//
//- (void)processingPickedImage:(UIImage *)pickedImage mediaMetadata:(NSDictionary *)mediaMetadata
//{
//    //[[RSMessageView shareMessageView] showMessageWithType:@"努力加载中" messageType:kRSMessageTypeIndicator];
//    RSWeakself
//    [PhotoUploadHelper
//     processPickedUIImage:[self scaleToSize:pickedImage ]
//     withMediaMetadata:mediaMetadata
//     completeBlock:^(XPhotoUploaderContentEntity *photo) {
//         _photoEntityWillUpload = photo;
////         NSData * data = UIImageJPEGRepresentation(_photoEntityWillUpload.image, 1.0f);
////         NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
////         RSPersonlNetworkPictureModel * personlNetworkPicturemodel = [[RSPersonlNetworkPictureModel alloc]init];
////         personlNetworkPicturemodel.img = [NSString stringWithFormat:@"%@",encodedImageStr];
////         personlNetworkPicturemodel.imageId = 100000000000000;
////
////         [_imageArray addObject:personlNetworkPicturemodel];
////         [weakSelf nineGrid];
//         [weakSelf uploadQuestionPersonlPictureIndexpath];
//     }
//     failedBlock:^(NSDictionary *errorInfo) {
//
//     }];
//}

//#pragma mark -- 对图片进行压缩
//- (UIImage *)scaleToSize:(UIImage *)img {
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    CGSize size = CGSizeMake(img.size.width*0.65, img.size.height*0.65);
//
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    //返回新的改变大小后的图片
//    return scaledImage;
//}



//// 本地相册选择多张照片
//- (void)selectPictures
//{
//    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
//    picker.maximumNumberOfSelection = 3 -_imageArray.count;
//    picker.assetsFilter = [ALAssetsFilter allPhotos];
//    picker.showEmptyGroups = NO;
//    picker.delegate = self;
//    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings)
//                              {
//                                  if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
//                                  {
//                                      NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
//                                      return duration >= 5;
//                                  } else {
//                                      return YES;
//                                  }
//                              }];
//    [self presentViewController:picker animated:YES completion:NULL];
//}



// 删除照片
- (void)deleteEvent:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
   
    //btn.tag 和cell.tag中的一样
     //_addPictureMenView.uploadBtn.tag - 1000000000
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确实删除图片吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSIndexPath * indexptah = [NSIndexPath indexPathForRow:_addPictureMenView.tag - 1000000000 inSection:0];
        [self deleteServiceQuestionPictureIndexpath:indexptah andTag:btn.tag - 1000000000];
        
    }];
    [alert addAction:action1];
    UIAlertAction  * action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action2];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        alert.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:alert animated:YES completion:nil];
//    [self.imageArray removeObjectAtIndex:btn.tag - 1000000000];
//    [self nineGrid];
    
}




- (void)deleteServiceQuestionPictureIndexpath:(NSIndexPath *)indexpath andTag:(NSInteger)tag{
    /*
     当前服务Id    serviceId    String
     当前删除的图片Id    imgId    String
     标识    search    String    上传图片传4
     */
    
    if (self.imageArray.count < 2) {
        [SVProgressHUD showInfoWithStatus:@"最少都要保存一张图片"];
    }else{
        RSPersonlNetworkPictureModel * personlNetworkPicturemodel = self.imageArray[tag];
        //    if (personlNetworkPicturemodel.imageId == 100000000000000) {
        //        //获取删除按键的位置和数组的位置
        //        [self.imageArray removeObjectAtIndex:tag];
        //    }else{
        [SVProgressHUD showWithStatus:@"删除图片中......"];
        RSPersonlModel * personlmodel = self.personlArray[indexpath.row];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:personlmodel.serviceId forKey:@"serviceId"];
        [dict setObject:@"5" forKey:@"search"];
        [dict setObject:[NSString stringWithFormat:@"%ld",(long)personlNetworkPicturemodel.imageId] forKey:@"imgId"];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        //URL_PERSONLSEARCHSERVICEFORWAITER_IOS
        [network getDataWithUrlString:URL_PERSONLSEARCHSERVICEFORWAITER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                    [weakSelf.imageArray removeObjectAtIndex:tag];
                    [weakSelf nineGrid];
                    [SVProgressHUD dismiss];
//                    if ([temp isEqualToString:@"0"]) {
//                        if (weakSelf.imageArray.count > 0) {
//                            //图片上传成功之后，开始服务就可以点击了
//                            RSPersonServiceCell * cell = [weakSelf.tableview cellForRowAtIndexPath:indexpath];
//                            if ([cell.myServiceBtn.currentTitle isEqualToString:@"进行中"]) {
//                                RSPersonServiceCell * cell = [weakSelf.tableview cellForRowAtIndexPath:indexpath];
//                                [cell.personlServiceStartServiceBtn setTitle:@"服务执行" forState:UIControlStateNormal];
//                                cell.personlServiceStartServiceBtn.enabled = NO;
//                                [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
//                                [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
//                            }else{
//                                [cell.personlServiceStartServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
//                                cell.personlServiceStartServiceBtn.enabled = YES;
//                                [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//                                [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor whiteColor]];
//                            }
//                        }else{
//                            RSPersonServiceCell * cell = [weakSelf.tableview cellForRowAtIndexPath:indexpath];
//                            [cell.personlServiceStartServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
//                            cell.personlServiceStartServiceBtn.enabled = YES;
//                            [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
//                            [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor whiteColor]];
//                        }
//                }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"删除失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
        }];
    }
    
 
}





// 9宫格图片布局
- (void)nineGrid
{
    for (UIImageView *imgv in _addPictureMenView.addPictureView.subviews)
    {
        if ([imgv isKindOfClass:[UIImageView class]]) {
            [imgv removeFromSuperview];
            // [_addPic removeFromSuperview];
        }
    }
    
    CGFloat width = 62.5;
    CGFloat height = 62.5;
    NSInteger count = _imageArray.count;
    _imageArray.count > 3 ? (count = 3) : (count = _imageArray.count);
    
    if (count < 1) {
        _addPictureMenView.addPictureBtn.sd_layout
        .centerYEqualToView(_addPictureMenView.addPictureView)
        .leftSpaceToView(_addPictureMenView.addPictureView, 12)
        .topSpaceToView(_addPictureMenView.addPictureView, 8.75)
        .bottomSpaceToView(_addPictureMenView.addPictureView, 8.75)
        .widthIs(62.5);
//        _addPictureMenView.uploadBtn.enabled = NO;
//        [_addPictureMenView.uploadBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
    }else{
//        _addPictureMenView.uploadBtn.enabled = YES;
//        [_addPictureMenView.uploadBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"3385ff"]];
        
        for (int i=0; i<count; i++)
        {
            NSInteger row = i / ECA;
            NSInteger colom = i % ECA;
            //WithFrame:CGRectMake(14+(width+widthSpace)*(i%4), (i/4)*(width+heightSpace)+14, width, width)
            UIImageView *imgv = [[UIImageView alloc] init];
            CGFloat imgX =  colom * (margin + width) + margin;
            CGFloat imgY =  row * (margin + height) + margin;
            imgv.frame = CGRectMake(imgX, imgY, width, height);
            //imgv.image = _imageArray[i];
            
            RSPersonlNetworkPictureModel * personlNetworkPicturemodel = _imageArray[i];
//            if (personlNetworkPicturemodel.imageId == 100000000000000) {
//
//                //NSData * decodedImageData = [[NSData alloc]initWithBase64Encoding:personlNetworkPicturemodel.img];
//                NSData * decodedImageData = [[NSData alloc]initWithBase64EncodedString:personlNetworkPicturemodel.img options:NSDataBase64DecodingIgnoreUnknownCharacters];
//                UIImage * decodedImage = [UIImage imageWithData:decodedImageData];
//                imgv.image = decodedImage;

//
//            }else{
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:personlNetworkPicturemodel.img]];
                imgv.image = [UIImage imageWithData:data];
//            }
            imgv.userInteractionEnabled = YES;
            [_addPictureMenView.addPictureView addSubview:imgv];
            //添加手势
            imgv.tag = 100000+i;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showQuestionPicture:)];
            [imgv addGestureRecognizer:tap];
            tap.view.tag = 100000+i;
            
            
            
            
            //这边是已完成的状态
            if ([temp isEqualToString:@"5"]) {
                
                _addPictureMenView.addPictureBtn.hidden = YES;
                _addPictureMenView.addPictureBtn.enabled = NO;
            }else{
                
                _addPictureMenView.addPictureBtn.hidden = NO;
                _addPictureMenView.addPictureBtn.enabled = YES;
                UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
                delete.frame = CGRectMake(width-16, 0, 16, 16);
                //        delete.backgroundColor = [UIColor greenColor];
                [delete setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
                [delete addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
                delete.tag = 1000000000+i;
                [imgv addSubview:delete];
                // [_pictureView addSubview:_addPic];
                //            _pictureView.sd_layout
                //            .autoHeightRatio(0);
                _addPictureMenView.addPictureBtn.sd_layout
                .leftSpaceToView(imgv, margin)
                //.topEqualToView(imgv)
                .topSpaceToView(imgv, imgY)
                .bottomEqualToView(imgv)
                .widthIs(62.5);
            }
            //[_pictureView setupAutoHeightWithBottomView:_addPic bottomMargin:0];
            //[_headerview setupAutoHeightWithBottomView:_reservationBtn bottomMargin:0];
        }
    }
}



//#pragma mark - ZYQAssetPickerController Delegate
//
//- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
//{
//    RSWeakself
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
//                   {
//                       for (int i=0; i<assets.count; i++)
//                       {
//                           ALAsset *asset = assets[i];
//                           UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//
////                           NSData * data = UIImageJPEGRepresentation(tempImg, 1.0f);
////                           NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
////                           RSPersonlNetworkPictureModel * personlNetworkPicturemodel = [[RSPersonlNetworkPictureModel alloc]init];
////                           personlNetworkPicturemodel.img = [NSString stringWithFormat:@"%@",encodedImageStr];
////                           personlNetworkPicturemodel.imageId = 100000000000000;
////                           [_imageArray addObject:personlNetworkPicturemodel];
//
//
//                           //[_imageArray addObject:tempImg];
////                           dispatch_async(dispatch_get_main_queue(), ^{
////                               [self nineGrid];
////                           });
//                           [weakSelf uploadQuestionPersonlPictureIndexpath:tempImg];
//                       }
//                   });
//}



#pragma mark -- 点击上传的问题图片
- (void)showQuestionPicture:(UITapGestureRecognizer *)tap{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < self.imageArray.count; i++) {
        RSPersonlNetworkPictureModel * personlNetworkPicturemodel = self.imageArray[i];
            [array addObject:personlNetworkPicturemodel.img];
    }
    if (array.count > 0) {

        [HUPhotoBrowser showFromImageView:tap.view.subviews[tap.view.tag - 100000] withURLStrings:array atIndex:tap.view.tag - 100000];
    }else{
        [SVProgressHUD showInfoWithStatus:@"获取不到图片信息"];
    }
}





//#pragma mark -- 使用系统的方式打开相机
//- (void)openCamera{
//    //调用系统的相机的功能
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        picker.delegate = self;
//        //设置拍照后的图片可被编辑
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        //先检查相机可用是否
//        BOOL cameraIsAvailable = [self checkCamera];
//        if (YES == cameraIsAvailable) {
//            [self presentViewController:picker animated:YES completion:nil];
//        }else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
//            [alert show];
//        }
//
//    }
//
//}
//#pragma mark -- 检查相机是否可用
//- (BOOL)checkCamera
//{
//    NSString *mediaType = AVMediaTypeVideo;
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//    if(AVAuthorizationStatusRestricted == authStatus ||
//       AVAuthorizationStatusDenied == authStatus)
//    {
//        //相机不可用
//        return NO;
//    }
//    //相机可用
//    return YES;
//}

//FIXME:取消添加图片视图
- (void)cancelAddPictureMenview:(UITapGestureRecognizer *)tap{
    _addPictureMenView.hidden = YES;
    //[_imageArray removeAllObjects];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}

//FIXME:隐藏蒙版
- (void)hiheSecondMenView:(UITapGestureRecognizer *)tap{
    _menview.hidden = YES;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}

//FIXME:取消
- (void)cancelSecondChoiceAction:(UIButton *)btn{
    if ([btn.currentTitle isEqualToString:@"取消"]) {
        _menview.hidden = YES;
        self.navigationController.navigationBar.userInteractionEnabled = YES;
    }else{
        _menview.hidden = YES;
        self.navigationController.navigationBar.userInteractionEnabled = YES;
    }
}

//FIXME:确定
- (void)sureSecondChoiceAction:(UIButton *)btn{
    btn.tag = _menview.tag;
    NSIndexPath * indexptah = [NSIndexPath indexPathForRow:btn.tag - 1000000000 inSection:0];
    if ([btn.currentTitle isEqualToString:@"确定"]) {
        //接收服务
        [self acceptanceOfServiceIndexpath:indexptah];
    }else{
        //这边是服务完成的网络请求
        [self completeServiceLoadData:indexptah];
    }
    _menview.hidden = YES;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}





//FIXME:接受服务
- (void)acceptanceOfServiceIndexpath:(NSIndexPath *)indexpath{
    RSPersonlModel * personlmodel = self.personlArray[indexpath.row];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:personlmodel.serviceId forKey:@"serviceId"];
    [dict setObject:@"2" forKey:@"search"];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    
    [network getDataWithUrlString:URL_PERSONLSEARCHSERVICEFORWAITER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                //indexpath
                if ([personlmodel.serviceType isEqualToString:@"出库服务"]) {
                    RSPersonServiceCell * cell = [weakSelf.tableview cellForRowAtIndexPath:indexpath];
                    personlmodel.status = @"派遣中";
                    [cell.myServiceBtn setTitle:@"派遣中" forState:UIControlStateNormal];
                    [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                    [cell.personlServiceStartServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
                    cell.personlServiceStartServiceBtn.enabled = YES;
                    [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
                    [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor whiteColor]];
                    [cell.personlUploadPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
                    [cell.personlUploadPictureBtn setBackgroundColor:[UIColor whiteColor]];
                    cell.personlUploadPictureBtn.enabled = YES;
                    
                }
                else{
                    //市场服务
                    RSPersonServiceCell * cell = [weakSelf.tableview cellForRowAtIndexPath:indexpath];
                    personlmodel.status = @"派遣中";
                    [cell.myServiceBtn setTitle:@"派遣中" forState:UIControlStateNormal];
                    [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                    [cell.personlServiceStartServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
                    cell.personlServiceStartServiceBtn.enabled = YES;
                    [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
                    [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor whiteColor]];
                }
            }else{
                
                [weakSelf addPersonlServiceData];
             //[SVProgressHUD showErrorWithStatus:@"接受任务失败"];
            }
         }else{
             [weakSelf addPersonlServiceData];
             //[SVProgressHUD showErrorWithStatus:@"接受任务失败"];
         }
    }];
}

//FIXME:执行任务
- (void)executionOfServicesIndexpath:(NSIndexPath *)indexpath{
    RSPersonlModel * personlmodel = self.personlArray[indexpath.row];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:personlmodel.serviceId forKey:@"serviceId"];
    [dict setObject:@"3" forKey:@"search"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_PERSONLSEARCHSERVICEFORWAITER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                    RSPersonServiceCell * cell = [weakSelf.tableview cellForRowAtIndexPath:indexpath];
                    personlmodel.status = @"进行中";
                    [cell.myServiceBtn setTitle:@"进行中" forState:UIControlStateNormal];
                    [cell.myServiceBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#B3E49A"]];
                    [cell.personlServiceStartServiceBtn setTitle:@"服务完成" forState:UIControlStateNormal];
                    cell.personlServiceStartServiceBtn.enabled = YES;
                [cell.personlServiceStartServiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
                    [cell.personlServiceStartServiceBtn setBackgroundColor:[UIColor whiteColor]];
            }else{
                 [SVProgressHUD showErrorWithStatus:@"执行任务失败"];
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"执行任务失败"];
        }
    }];
}

//FIXME:服务详情
- (void)serviceDetail:(UIButton *)btn{
    RSPersonlModel * personlmodel = self.personlArray[btn.tag - 1000000000];
    if ([personlmodel.serviceType isEqualToString:@"出库服务"]) {
        //出库服务
        RSStorehouseDetailsViewController * storeHouseDetailVc = [[RSStorehouseDetailsViewController alloc]init];
        storeHouseDetailVc.usermodel = self.usermodel;
        storeHouseDetailVc.serviceId = personlmodel.serviceId;
        storeHouseDetailVc.type = @"ckfw";
        storeHouseDetailVc.search = @"0";
        storeHouseDetailVc.status = temp;
        [self.navigationController pushViewController:storeHouseDetailVc animated:YES];
    }else{
        //市场服务
        [SVProgressHUD showWithStatus:@"加载市场服务内容,请等待........"];
        RSServiceMarketViewController * serviceMarketVc = [[RSServiceMarketViewController alloc]init];
        serviceMarketVc.usermodel = self.usermodel;
        serviceMarketVc.serviceId = personlmodel.serviceId;
        serviceMarketVc.type = @"scfw";
        serviceMarketVc.search = @"0";
        serviceMarketVc.status = temp;
        //界面跳转的地方进行判断
        serviceMarketVc.jumpStr = self.jumpStr;
        [self.navigationController pushViewController:serviceMarketVc animated:YES];
    }
}

//FIXME:已完成服务详情
- (void)serviceSecondDetail:(UIButton *)btn{
    RSPersonlModel * personlmodel = self.personlArray[btn.tag - 1000000000];
    if ([personlmodel.serviceType isEqualToString:@"出库服务"]) {
        //出库服务
        RSStorehouseDetailsViewController * storeHouseDetailVc = [[RSStorehouseDetailsViewController alloc]init];
        storeHouseDetailVc.usermodel = self.usermodel;
        storeHouseDetailVc.serviceId = personlmodel.serviceId;
        storeHouseDetailVc.type = @"ckfw";
        storeHouseDetailVc.search = @"0";
        storeHouseDetailVc.status = temp;
        [self.navigationController pushViewController:storeHouseDetailVc animated:YES];
        
    }else{
        
        //市场服务
        [SVProgressHUD showWithStatus:@"加载市场服务内容,请等待........"];
        RSServiceMarketViewController * serviceMarketVc = [[RSServiceMarketViewController alloc]init];
        serviceMarketVc.usermodel = self.usermodel;
        serviceMarketVc.serviceId = personlmodel.serviceId;
        serviceMarketVc.type = @"scfw";
        serviceMarketVc.search = @"0";
        serviceMarketVc.status = temp;
        serviceMarketVc.jumpStr = self.jumpStr;
        [self.navigationController pushViewController:serviceMarketVc animated:YES];
    }
}

//FIXME:(未完成)接受服务
- (void)starService:(UIButton *)btn{
    if ([btn.currentTitle isEqualToString:@"接收服务"]) {
        //接收服务
        _menview.hidden = NO;
        _centerImageview.image = [UIImage imageNamed:@"开始服务"];
        _centerLabel.text = @"开始服务";
        _serviceLabel.text = @"开始对此服务展开工作";
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        self.navigationController.navigationBar.userInteractionEnabled = NO;
        _menview.tag = btn.tag;
    }else if ([btn.currentTitle isEqualToString:@"开始服务"]){
        
        //这边是开始服务
        NSIndexPath * indexptah = [NSIndexPath indexPathForRow:btn.tag - 1000000000 inSection:0];
        [self executionOfServicesIndexpath:indexptah];
        
    }else{
        //这边是服务完成时候
        _menview.hidden = NO;
        _centerImageview.image = [UIImage imageNamed:@"服务完成"];
        _centerLabel.text = @"服务完成";
        _serviceLabel.text = @"服务人员已完成当前服务";
        [_cancelBtn setTitle:@"取消服务完成" forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确定服务完成" forState:UIControlStateNormal];
        self.navigationController.navigationBar.userInteractionEnabled = NO;
        _menview.tag = btn.tag;
    }
}

//服务完成的网络请求
- (void)completeServiceLoadData:(NSIndexPath *)indexpath{
    RSPersonlModel * personlmodel = self.personlArray[indexpath.row];
    NSString * serviceStyle = [NSString string];
    if ([personlmodel.serviceType isEqualToString:@"出库服务"]) {
        serviceStyle = @"ckfw";
    }else{
        serviceStyle = @"scfw";
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    [dict setObject:personlmodel.serviceId forKey:@"serviceId"];
    [dict setObject:serviceStyle forKey:@"type"];
    [dict setObject:@"6" forKey:@"search"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_PERSONLSEARCHSERVICEFORWAITER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [weakSelf addPersonlServiceData];
            }else{
//                [SVProgressHUD showErrorWithStatus:@"服务完成失败"];
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"MSG_CODE"]]];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"服务完成失败"];
        }
    }];
}

//FIXME:查看评价
- (void)viewEvaluation:(UIButton *)btn{
    RSPersonlModel * personlmodel = self.personlArray[btn.tag - 1000000000];
    //查看评价
    RSAlreadyEvaluatedViewController * alreadEvaluatedVc = [[RSAlreadyEvaluatedViewController alloc]init];
    alreadEvaluatedVc.usermodel = self.usermodel;
    alreadEvaluatedVc.serviceId = personlmodel.serviceId;
    [self.navigationController pushViewController:alreadEvaluatedVc animated:YES];
}

//FIXME:按键的选择的方式
- (void)choiceSecondServiceStyle:(UIButton *)btn{
    if(btn != self.selectedBtn){
        self.selectedBtn.selected = NO ;
        btn.selected = YES ;
        self.selectedBtn = btn;
        //这边要对存的数组进行处理
        [_imageArray removeAllObjects];
        if (btn.tag == 1000000001) {
            [_incompleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
            _inView.hidden = NO;
            _completeView.hidden = YES;
            [_completeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#313131"] forState:UIControlStateNormal];
            temp = @"0";
        }else{
            [_completeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385FF"] forState:UIControlStateNormal];
            _inView.hidden = YES;
            _completeView.hidden = NO;
            [_incompleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#313131"] forState:UIControlStateNormal];
            temp = @"5";
        }
        [self addPersonlServiceData];
    } else {
        self.selectedBtn.selected  =  YES ;
    }
    
    
}

- (void)scanSecondAction{
    //FIXME:扫一扫
        MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeAll onFinish:^(NSString *result, NSError *error) {
            if (error) {
               // NSLog(@"error: %@",error);
            } else {
               // NSLog(@"扫描结果：%@",result);
                [self showInfo:result];
            }
        }];
        [self.navigationController pushViewController:scanVc animated:YES];
}


#pragma mark - Error handle
- (void)showInfo:(NSString*)str {
    //URL_ISQRCODEEXISTS_IOS
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:str forKey:@"qrCode"];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_ISQRCODEEXISTS_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                //在进行中的方式
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                WWDViewController * wwvc = [story instantiateViewControllerWithIdentifier:@"WWDViewController"];
                wwvc.outStr = str;
                [self.navigationController pushViewController:wwvc animated:YES];
            }else{
//                [SVProgressHUD showErrorWithStatus:@"扫描失败"];
//                [SVProgressHUD showErrorWithStatus:json[@"msg"]];
                [JHSysAlertUtil presentAlertViewWithTitle:@"无效二维码" message:nil confirmTitle:@"确定" handler:^{
                }];
            }
        }else{
//             [SVProgressHUD showErrorWithStatus:@"扫描失败"];
            [JHSysAlertUtil presentAlertViewWithTitle:@"无效二维码" message:nil confirmTitle:@"确定" handler:^{
            }];
        }
    }];
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
