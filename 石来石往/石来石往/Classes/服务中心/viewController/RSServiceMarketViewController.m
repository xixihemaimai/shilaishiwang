//
//  RSServiceMarketViewController.m
//  石来石往
//
//  Created by mac on 2018/3/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSServiceMarketViewController.h"
//#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "PhotoUploadHelper.h"
//#import "ZYQAssetPickerController.h"



#import <HUPhotoBrowser.h>
#define ECA 4
#define margin 10
//选择服务的时间
#import "CustomMyPickerView.h"
//模型
#import "RSServiceMarketModel.h"
//我的服务
#import "RSServiceMyServiceController.h"
//服务人员的服务中心
#import "RSPersonalServiceViewController.h"

#import "RSDispatchedPersonnelViewController.h"

#import "RSServiceCentreVViewController.h"

#import "RSMessageCenterController.h"


//ZYQAssetPickerControllerDelegate
//,UINavigationControllerDelegate,UIImagePickerControllerDelegate
@interface RSServiceMarketViewController ()<UITextFieldDelegate,UITextViewDelegate,CustomMyPickerViewDelegate,TZImagePickerControllerDelegate>

{
    UIButton   *_addPic;
  
    
    
    /**添加图片的label*/
    UILabel * _serviceImageLabel;

    
    //用来存储选择服务种类
    NSString * _temp;
    
}

//添加图片的数组
@property (nonatomic,strong)NSMutableArray * imageArray;

//@property (nonatomic,strong)UITableView * markettableview;


/**
 *按钮选中中间值
 */
@property(nonatomic,strong)UIButton * selectedBtn;


/**维修按键*/
@property (nonatomic,strong)UIButton * repairBtn;

/**其他按键*/
@property (nonatomic,strong)UIButton * otherBtn;


/**添加图片的View*/
@property (nonatomic,strong)UIView * pictureView;

/**tableview表头视图*/
@property (nonatomic,strong)UIView * headerview;


/**添加图片总view*/
@property (nonatomic,strong)UIView * serviceImageview;

/**服务时间UITextField*/
@property (nonatomic,strong)UIButton * serviceTimeBtn;

/**服务地址UITextField*/
@property (nonatomic,strong)UITextField * serviceAddressTextfield;

/**描述问题的情况*/
@property (nonatomic,strong)UITextView * serviceQuestiomView;
/**藐视问题的情况里面的Placeview*/
@property (nonatomic,strong)UILabel * serviceQuestuionLabel;

/**立即预约的按键*/
@property (nonatomic,strong)UIButton * reservationBtn;


@property (nonatomic,strong)CustomMyPickerView *customVC;

//@property (nonatomic,strong)NSMutableArray * marketArray;


@property (nonatomic,strong)UILabel * alertLabel;


/**服务电话*/
@property (nonatomic,strong)UITextField * servicePhoneTextfield;
/**打服务电话*/
@property (nonatomic,strong)UIButton * servicePhonePlayBtn;



@end

@implementation RSServiceMarketViewController



- (NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    _temp = @"";
    
    self.title = @"市场服务";
//    if (@available(iOS 11.0, *)) {
//        self.markettableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
   // [self reloadCurrentViewController];
  
    [self isAddjust];
    [self.view addSubview:self.tableview];
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_NavBar);
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    if ([self.jumpStr isEqualToString:@"1"]){
        
        if ([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]) {
            
            [self loadServiceMarketData];
            
        }else if ([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSPersonalServiceViewController class]){
            
            [self loadPersonlMarketServiceData];
        }
    }else{
        
        
        if ([[self.navigationController.viewControllers objectAtIndex:1]class] == [RSPersonalServiceViewController class]){
           
            [self loadPersonlMarketServiceData];
            
        }else if ([[self.navigationController.viewControllers objectAtIndex:1]class] == [RSDispatchedPersonnelViewController class]){
            [self loadServiceMarketData];
        }
        else if([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]){
            [self loadServiceMarketData];
        }
    }
    [self setServiceMarketUI];
}




- (void)setServiceMarketUI{
//    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStylePlain];
//    self.markettableview = tableview;
//    self.markettableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.markettableview.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
//    self.markettableview.showsHorizontalScrollIndicator = NO;
//    self.markettableview.showsVerticalScrollIndicator = NO;
//    self.markettableview.delegate = self;
//    self.markettableview.dataSource = self;
//    self.markettableview.contentInset = UIEdgeInsetsMake(0, 0, navY + navHeight, 0);
//    [self.view addSubview:self.markettableview];
    
    UIView * headerview = [[UIView alloc]init];
    headerview.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
    _headerview = headerview;
    //服务类型
    UIView * serviceStyleview = [[UIView alloc]init];
    serviceStyleview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:serviceStyleview];
    
    //服务类型
    UILabel * serviceStyleLabel = [[UILabel alloc]init];
    serviceStyleLabel.text = @"服务类型";
    serviceStyleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    serviceStyleLabel.font = [UIFont systemFontOfSize:15];
    serviceStyleLabel.textAlignment = NSTextAlignmentLeft;
    [serviceStyleview addSubview:serviceStyleLabel];
    
    
    //俩个按键
    //维修
    //选中
    UIButton * repairBtn = [[UIButton alloc]init];
    [repairBtn setTitle:@"维修" forState:UIControlStateNormal];
    [repairBtn setTitleColor:[UIColor colorWithHexColorStr:@"#D6D6D6"] forState:UIControlStateNormal];
    repairBtn.layer.cornerRadius = 3;
    repairBtn.layer.borderWidth = 1;
    [repairBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FA6A00"] forState:UIControlStateSelected];
    repairBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
    repairBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    repairBtn.layer.masksToBounds = YES;
    [serviceStyleview addSubview:repairBtn];
    [repairBtn addTarget:self action:@selector(choiceServiceStyle:) forControlEvents:UIControlEventTouchUpInside];
    _repairBtn = repairBtn;
    
    //其他
    UIButton * otherBtn = [[UIButton alloc]init];
    [otherBtn setTitle:@"保洁" forState:UIControlStateNormal];
    [otherBtn setTitleColor:[UIColor colorWithHexColorStr:@"#D6D6D6"] forState:UIControlStateNormal];
    otherBtn.layer.cornerRadius = 3;
    otherBtn.layer.borderWidth = 1;
    [otherBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FA6A00"] forState:UIControlStateSelected];
    otherBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
    otherBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    otherBtn.layer.masksToBounds = YES;
    [otherBtn addTarget:self action:@selector(choiceServiceStyle:) forControlEvents:UIControlEventTouchUpInside];
    [serviceStyleview addSubview:otherBtn];
    _otherBtn = otherBtn;
    
    
    
    
    //服务时间
    UIView * serviceTimeview = [[UIView alloc]init];
    serviceTimeview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:serviceTimeview];
    
    
    //服务时间
    UILabel * serviceTimeLabel = [[UILabel alloc]init];
    serviceTimeLabel.text = @"服务时间";
    serviceTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    serviceTimeLabel.font = [UIFont systemFontOfSize:15];
    serviceTimeLabel.textAlignment = NSTextAlignmentLeft;
    [serviceTimeview addSubview:serviceTimeLabel];
    
    
    //服务时间选择
    UIButton  * serviceTimeBtn = [[UIButton alloc]init];
    //    serviceTimeBtn settext = @"请选择服务时间";
    [serviceTimeBtn setTitle:@"请选择服务时间" forState:UIControlStateNormal];
    serviceTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [serviceTimeBtn setTitleColor:[UIColor colorWithRed:203/255.0 green:203/255.0 blue:209/255.0 alpha:1.0] forState:UIControlStateNormal];
    [serviceTimeview addSubview:serviceTimeBtn];
    
    [serviceTimeBtn addTarget:self action:@selector(choiceOutTime:) forControlEvents:UIControlEventTouchUpInside];
    _serviceTimeBtn = serviceTimeBtn;
    
    
    
    
    //服务地址
    UIView * serviceAddressview = [[UIView alloc]init];
    serviceAddressview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:serviceAddressview];
    
    
    
    
    //服务地址
    UILabel * serviceAddressLabel = [[UILabel alloc]init];
    serviceAddressLabel.text = @"服务地址";
    serviceAddressLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    serviceAddressLabel.font = [UIFont systemFontOfSize:15];
    serviceAddressLabel.textAlignment = NSTextAlignmentLeft;
    [serviceAddressview addSubview:serviceAddressLabel];
    
    
    //服务地址填入
    UITextField * serviceAddressTextfield = [[UITextField alloc]init];
    serviceAddressTextfield.placeholder = @"请填写服务地址";
    serviceAddressTextfield.borderStyle = UITextBorderStyleNone;
    [serviceAddressview addSubview:serviceAddressTextfield];
    serviceAddressTextfield.delegate = self;
    _serviceAddressTextfield =serviceAddressTextfield;
    
    
    //服务联系电话
    UIView * servicePhoneView = [[UIView alloc]init];
    servicePhoneView.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:servicePhoneView];
    
    
    //服务联系电话
    UILabel * servicePhoneLabel = [[UILabel alloc]init];
    servicePhoneLabel.text = @"联系电话";
    servicePhoneLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    servicePhoneLabel.font = [UIFont systemFontOfSize:15];
    servicePhoneLabel.textAlignment = NSTextAlignmentLeft;
    [servicePhoneView addSubview:servicePhoneLabel];
    
    
    
    //联系电话的按键
    UITextField * servicePhoneTextfield = [[UITextField alloc]init];
    servicePhoneTextfield.placeholder = @"请输入电话号码";
    servicePhoneTextfield.borderStyle = UITextBorderStyleNone;
    [servicePhoneView addSubview:servicePhoneTextfield];
    //servicePhoneTextfield.delegate = self;
    _servicePhoneTextfield = servicePhoneTextfield;
    [servicePhoneTextfield addTarget:self action:@selector(showPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    //是否打电话
    UIButton * servicePhonePlayBtn = [[UIButton alloc]init];
    [servicePhonePlayBtn setTitle:@"打电话" forState:UIControlStateNormal];
    [servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    [servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
    
    
    
    servicePhonePlayBtn.layer.cornerRadius = 5;
    servicePhonePlayBtn.layer.masksToBounds = YES;
    servicePhonePlayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [servicePhoneView addSubview:servicePhonePlayBtn];
    _servicePhonePlayBtn = servicePhonePlayBtn;
    
    [servicePhonePlayBtn addTarget:self action:@selector(serviceMarketPlayPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
    servicePhonePlayBtn.enabled = NO;
    
    
    
    //描述服务问题
    UITextView * serviceQuestionview = [[UITextView alloc]init];
    serviceQuestionview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:serviceQuestionview];
    serviceQuestionview.delegate = self;
    _serviceQuestiomView = serviceQuestionview;
    
    
    UILabel * serviceQuestuionLabel = [[UILabel alloc]init];
    serviceQuestuionLabel.text = @"请描述你遇到的问题";
    serviceQuestuionLabel.font = [UIFont systemFontOfSize:14];
    serviceQuestuionLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    [serviceQuestionview addSubview:serviceQuestuionLabel];
    _serviceQuestuionLabel = serviceQuestuionLabel;
    
    
    
    //服务的问题的图片
    
    UIView * serviceImageview = [[UIView alloc]init];
    serviceImageview.backgroundColor = [UIColor whiteColor];
    [headerview addSubview:serviceImageview];
    _serviceImageview = serviceImageview;
    
    
    
    UILabel * serviceImageLabel = [[UILabel alloc]init];
    serviceImageLabel.text = @"添加图片(提供问题截图)";
    serviceImageLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    serviceImageLabel.font = [UIFont systemFontOfSize:15];
    serviceImageLabel.textAlignment = NSTextAlignmentLeft;
    [serviceImageview addSubview:serviceImageLabel];
    _serviceImageLabel = serviceImageLabel;
    
    //先添加一个view来
    UIView * pictureView = [[UIView alloc]init];
    pictureView.backgroundColor = [UIColor whiteColor];
    [serviceImageview addSubview:pictureView];
    pictureView.userInteractionEnabled = YES;
    _pictureView = pictureView;
    
    //添加图片控件
    _addPic = [UIButton buttonWithType:UIButtonTypeCustom];
    //_addPic.frame = CGRectMake(0, 0, 62.5, 62.5);
    [_addPic setImage:[UIImage imageNamed:@"上传图片"] forState:UIControlStateNormal];
    [_addPic addTarget:self action:@selector(addQuestionPicEvent:) forControlEvents:UIControlEventTouchUpInside];
    [pictureView addSubview:_addPic];
    
    
    
    
    //立即预约
    UIButton * reservationBtn = [[UIButton alloc]init];
    [reservationBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [reservationBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    [reservationBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    reservationBtn.layer.cornerRadius = 22;
    reservationBtn.layer.masksToBounds = YES;
    reservationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [headerview addSubview:reservationBtn];
    [reservationBtn addTarget:self action:@selector(sendMarketServiceAction:) forControlEvents:UIControlEventTouchUpInside];
    _reservationBtn = reservationBtn;
    
    
    
    //提醒框
    UILabel * alertLabel = [[UILabel alloc]init];
    alertLabel.text = @"如需办理其他服务，请联系王女士：18120620202";
    alertLabel.textColor = [UIColor colorWithHexColorStr:@"#3385ff"];
    alertLabel.font = [UIFont systemFontOfSize:15];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    [headerview addSubview:alertLabel];
    _alertLabel = alertLabel;
    //服务类型
    serviceStyleview.sd_layout
    .leftSpaceToView(headerview, 0)
    .topSpaceToView(headerview, 10)
    .rightSpaceToView(headerview, 0)
    .heightIs(80);
    
    
    
    serviceStyleLabel.sd_layout
    .leftSpaceToView(serviceStyleview, 14)
    .topSpaceToView(serviceStyleview, 12)
    .rightSpaceToView(serviceStyleview, 12)
    .heightIs(14);
    
    
    repairBtn.sd_layout
    .leftEqualToView(serviceStyleLabel)
    .topSpaceToView(serviceStyleLabel, 11)
    .bottomSpaceToView(serviceStyleview, 14)
    .widthIs(95);
    
    otherBtn.sd_layout
    .leftSpaceToView(repairBtn, 11)
    .topEqualToView(repairBtn)
    .bottomEqualToView(repairBtn)
    .widthIs(95);
    
    
    //服务时间
    serviceTimeview.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(serviceStyleview, 9.5)
    .heightIs(45.5);
    
    
    serviceTimeLabel.sd_layout
    .leftSpaceToView(serviceTimeview, 14)
    .centerYEqualToView(serviceTimeview)
    .heightIs(14)
    .widthRatioToView(serviceTimeview, 0.2);
    
    
    serviceTimeBtn.sd_layout
    .leftSpaceToView(serviceTimeLabel, 10)
    .centerYEqualToView(serviceTimeview)
    .rightSpaceToView(serviceTimeview, 14)
    .topSpaceToView(serviceTimeview, 5)
    .bottomSpaceToView(serviceTimeview, 5);
    
    //服务地址
    serviceAddressview.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(serviceTimeview, 9.5)
    .heightIs(45.5);
    
    
    
    serviceAddressLabel.sd_layout
    .leftSpaceToView(serviceAddressview, 14)
    .centerYEqualToView(serviceAddressview)
    .heightIs(14)
    .widthRatioToView(serviceAddressview, 0.2);
    
    serviceAddressTextfield.sd_layout
    .leftSpaceToView(serviceAddressLabel, 10)
    .centerYEqualToView(serviceAddressview)
    .rightSpaceToView(serviceAddressview, 14)
    .topSpaceToView(serviceAddressview, 5)
    .bottomSpaceToView(serviceAddressview, 5);
    
    
    
    servicePhoneView.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(serviceAddressview, 9.5)
    .heightIs(45.5);
    
    
    servicePhoneLabel.sd_layout
    .leftSpaceToView(servicePhoneView, 14)
    .centerYEqualToView(servicePhoneView)
    .heightIs(14)
    .widthRatioToView(servicePhoneView, 0.2);
    
    
    servicePhoneTextfield.sd_layout
    .leftSpaceToView(servicePhoneLabel, 10)
    .centerYEqualToView(servicePhoneView)
    .widthRatioToView(servicePhoneView, 0.5)
    .topSpaceToView(servicePhoneView, 5)
    .bottomSpaceToView(servicePhoneView, 5);
    
    
    servicePhonePlayBtn.sd_layout
    .topEqualToView(servicePhoneTextfield)
    .bottomEqualToView(servicePhoneTextfield)
    .rightSpaceToView(servicePhoneView, 5)
    .widthIs(95);
    
    
    
    
    
    //描述服务问题
    serviceQuestionview.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(servicePhoneView, 9.5)
    .heightIs(105.5);
    
    serviceQuestuionLabel.sd_layout
    .leftSpaceToView(serviceQuestionview, 13)
    .topSpaceToView(serviceQuestionview, 8)
    .rightSpaceToView(serviceQuestionview, 14)
    .heightIs(14);
    
    //服务的图片
    serviceImageview.sd_layout
    .leftSpaceToView(headerview, 0)
    .rightSpaceToView(headerview, 0)
    .topSpaceToView(serviceQuestionview, 9.5)
    .autoHeightRatio(0);
    
    serviceImageLabel.sd_layout
    .leftSpaceToView(serviceImageview, 14)
    .rightSpaceToView(serviceImageview, 14)
    .topSpaceToView(serviceImageview, 14)
    .heightIs(14.5);
    
    pictureView.sd_layout
    .leftSpaceToView(serviceImageview, 0)
    .topSpaceToView(serviceImageLabel, 14)
    .rightSpaceToView(serviceImageview, 0)
    //.autoHeightRatio(0);
    .heightIs(62.5);
    
    _addPic.sd_layout
    .leftSpaceToView(pictureView, 14)
    .topSpaceToView(pictureView, 0)
    .widthIs(62.5)
    .heightIs(62.5);
    
    reservationBtn.sd_layout
    .leftSpaceToView(headerview, 37.5)
    .rightSpaceToView(headerview, 37.5)
    .topSpaceToView(serviceImageview, 20)
    .heightIs(45);
    
    
    
    alertLabel.sd_layout
    .leftSpaceToView(headerview, 12)
    .rightSpaceToView(headerview, 12)
    .topSpaceToView(reservationBtn, 20)
    .heightIs(15);
    
    [pictureView setupAutoHeightWithBottomView:_addPic bottomMargin:0];
    [serviceImageview setupAutoHeightWithBottomView:pictureView bottomMargin:14.5];
    [headerview setupAutoHeightWithBottomView:alertLabel bottomMargin:0];
    [headerview layoutSubviews];
    self.tableview.tableHeaderView = headerview;
}




//这边是货主的市场服务数据
- (void)loadServiceMarketData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userID forKey:@"userId"];
    
    [dict setObject:self.serviceId forKey:@"serviceId"];
    [dict setObject:self.type forKey:@"type"];
    [dict setObject:self.search forKey:@"search"];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SERVICESEARCH_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                [weakSelf.imageArray removeAllObjects];
                //[weakSelf.marketArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];
                if (array.count > 0) {
                    for (int i = 0; i < array.count; i++) {
                        NSArray * imgArray = [NSArray array];
                        imgArray = [[array objectAtIndex:i]objectForKey:@"img"];
                        if ([weakSelf.jumpStr isEqualToString:@"1"]) {
                            if ([[weakSelf.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]){
                                if ([weakSelf.modifyStatusStr isEqualToString:@"1"]) {
                                    //修改服务
                                    _repairBtn.enabled = YES;
                                    _otherBtn.enabled = YES;
                                    _serviceTimeBtn.enabled = YES;
                                    _serviceAddressTextfield.enabled = YES;
                                    _serviceQuestuionLabel.hidden = NO;
                                    _serviceQuestiomView.editable = YES;
                                    _reservationBtn.hidden = NO;
                                    _reservationBtn.enabled = YES;
                                    _addPic.enabled = YES;
                                    _servicePhoneTextfield.enabled = YES;
                                    //对立即预约的按键进行更改值
                                    [_reservationBtn setTitle:@"修改服务" forState:UIControlStateNormal];
                                    weakSelf.servicePhonePlayBtn.enabled = YES;
                                    [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                                    [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                                    _alertLabel.sd_layout
                                    .topSpaceToView(_reservationBtn, 20);
                                }else{
                                    _repairBtn.enabled = NO;
                                    _otherBtn.enabled = NO;
                                    _serviceTimeBtn.enabled = NO;
                                    _serviceAddressTextfield.enabled = NO;
                                    _serviceQuestuionLabel.hidden = YES;
                                    _serviceQuestiomView.editable = NO;
                                    _reservationBtn.hidden = YES;
                                    _reservationBtn.enabled = NO;
                                    _servicePhonePlayBtn.enabled = YES;
                                    _addPic.enabled = NO;
                                    _servicePhoneTextfield.enabled = NO;
                                    [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                                    [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                                    _alertLabel.sd_layout
                                    .topSpaceToView(_serviceImageview, 20);
                                }
                            }else{
                                _repairBtn.enabled = NO;
                                _otherBtn.enabled = NO;
                                _serviceTimeBtn.enabled = NO;
                                _serviceAddressTextfield.enabled = NO;
                                _serviceQuestuionLabel.hidden = YES;
                                _serviceQuestiomView.editable = NO;
                                _reservationBtn.hidden = YES;
                                _reservationBtn.enabled = NO;
                                _servicePhonePlayBtn.enabled = YES;
                                _addPic.enabled = NO;
                                _servicePhoneTextfield.enabled = NO;
                                [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                                [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                                _alertLabel.sd_layout
                                .topSpaceToView(_serviceImageview, 20);
                            }
                        }else{
                            if ([[weakSelf.navigationController.viewControllers objectAtIndex:1]class] == [RSDispatchedPersonnelViewController class]) {
                                
                                
                                _repairBtn.enabled = NO;
                                _otherBtn.enabled = NO;
                                _serviceTimeBtn.enabled = NO;
                                _serviceAddressTextfield.enabled = NO;
                                _serviceQuestuionLabel.hidden = YES;
                                _serviceQuestiomView.editable = NO;
                                _reservationBtn.hidden = YES;
                                _reservationBtn.enabled = NO;
                                _servicePhonePlayBtn.enabled = YES;
                                
                                _servicePhoneTextfield.enabled = NO;
                                [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                                [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                                _addPic.enabled = NO;
                                _alertLabel.sd_layout
                                .topSpaceToView(_serviceImageview, 20);
                            }else if ([[weakSelf.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]){
                                if ([weakSelf.modifyStatusStr isEqualToString:@"1"]) {
                                    //修改服务
                                    _repairBtn.enabled = YES;
                                    _otherBtn.enabled = YES;
                                    _serviceTimeBtn.enabled = YES;
                                    _serviceAddressTextfield.enabled = YES;
                                    _serviceQuestuionLabel.hidden = NO;
                                    _serviceQuestiomView.editable = YES;
                                    _reservationBtn.hidden = NO;
                                    _reservationBtn.enabled = YES;
                                    _addPic.enabled = YES;
                                    
                                    
                                    _servicePhoneTextfield.enabled = YES;
                                    //对立即预约的按键进行更改值
                                    [_reservationBtn setTitle:@"修改服务" forState:UIControlStateNormal];
                                    weakSelf.servicePhonePlayBtn.enabled = YES;
                                    [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                                    [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                                    _alertLabel.sd_layout
                                    .topSpaceToView(_reservationBtn, 20);
                                }else{
                                    _repairBtn.enabled = NO;
                                    _otherBtn.enabled = NO;
                                    _serviceTimeBtn.enabled = NO;
                                    _serviceAddressTextfield.enabled = NO;
                                    _serviceQuestuionLabel.hidden = YES;
                                    _serviceQuestiomView.editable = NO;
                                    _reservationBtn.hidden = YES;
                                    _reservationBtn.enabled = NO;
                                    _servicePhonePlayBtn.enabled = YES;
                                    _addPic.enabled = NO;
                                    _servicePhoneTextfield.enabled = NO;
                                    [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                                    [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                                    _alertLabel.sd_layout
                                    .topSpaceToView(_serviceImageview, 20);
                                }
                            }
                        }
                        if ([[[array objectAtIndex:i]objectForKey:@"serviceKind"] isEqualToString:@"维修"]) {
                            _repairBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FA6A00"].CGColor;
                            _otherBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
                            [_repairBtn setTitle:@"维修" forState:UIControlStateNormal];
                            [_repairBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FA6A00"] forState:UIControlStateNormal];
                            [_repairBtn setBackgroundImage:[UIImage imageNamed:@"选中2"] forState:UIControlStateNormal];
                            _temp = _repairBtn.currentTitle;
                        }else{
                            _repairBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
                            _otherBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FA6A00"].CGColor;
                            [_otherBtn setBackgroundImage:[UIImage imageNamed:@"选中2"] forState:UIControlStateNormal];
                            [_otherBtn setTitle:@"保洁" forState:UIControlStateNormal];
                            [_otherBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FA6A00"] forState:UIControlStateNormal];
                            _temp = _otherBtn.currentTitle;
                        }
                        [_serviceTimeBtn setTitle:[[array objectAtIndex:i]objectForKey:@"appointTime"] forState:UIControlStateNormal];
                        _serviceAddressTextfield.text = [[array objectAtIndex:i]objectForKey:@"address"];
                        _serviceQuestiomView.text = [[array objectAtIndex:i]objectForKey:@"serviceThing"];
                        _serviceQuestuionLabel.text = @"";
                        _servicePhoneTextfield.text = [[array objectAtIndex:i]objectForKey:@"phone"];
                        //[weakSelf.imageArray addObjectsFromArray:imgArray];
                        for (int j = 0; j < imgArray.count; j++) {
                            RSServiceMarketModel * serviceMarketmodel = [[RSServiceMarketModel alloc]init];
                            serviceMarketmodel.imgId = [[[imgArray objectAtIndex:j]objectForKey:@"imgId"] integerValue];
                            serviceMarketmodel.imgUrl = [[imgArray objectAtIndex:j]objectForKey:@"imgUrl"];
                            [weakSelf.imageArray addObject:serviceMarketmodel];
                        }
                    }
                }else{
                    _repairBtn.enabled = NO;
                    _otherBtn.enabled = NO;
                    _serviceTimeBtn.enabled = NO;
                    _serviceAddressTextfield.enabled = NO;
                    _serviceQuestuionLabel.hidden = YES;
                    _serviceQuestiomView.editable = NO;
                    _reservationBtn.hidden = YES;
                    _reservationBtn.enabled = NO;
                    _addPic.enabled = NO;
                    
                    
                    _servicePhoneTextfield.enabled = NO;
                    _servicePhonePlayBtn.enabled = YES;
                    
                    [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                    [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                    _alertLabel.sd_layout
                    .topSpaceToView(_serviceImageview, 20);
                }
                [weakSelf nineMarketGrid];
                [weakSelf.tableview reloadData];
                [SVProgressHUD dismiss];
            }else{
                _repairBtn.enabled = NO;
                _otherBtn.enabled = NO;
                _serviceTimeBtn.enabled = NO;
                _serviceAddressTextfield.enabled = NO;
                _serviceQuestuionLabel.hidden = YES;
                _serviceQuestiomView.editable = NO;
                _reservationBtn.hidden = YES;
                _reservationBtn.enabled = NO;
                _addPic.enabled = NO;
                
                _servicePhoneTextfield.enabled = NO;
                _servicePhonePlayBtn.enabled = YES;
                
                [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                _alertLabel.sd_layout
                .topSpaceToView(_serviceImageview, 20);
                
                [weakSelf.imageArray removeAllObjects];
                [SVProgressHUD dismiss];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }else{
            _repairBtn.enabled = NO;
            _otherBtn.enabled = NO;
            _serviceTimeBtn.enabled = NO;
            _serviceAddressTextfield.enabled = NO;
            _serviceQuestuionLabel.hidden = YES;
            _serviceQuestiomView.editable = NO;
            _reservationBtn.hidden = YES;
            _reservationBtn.enabled = NO;
            _addPic.enabled = NO;
            _servicePhonePlayBtn.enabled = YES;
            
            [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
            [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
            _alertLabel.sd_layout
            .topSpaceToView(_serviceImageview, 20);
             [weakSelf.imageArray removeAllObjects];
            [SVProgressHUD dismiss];
             [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}



- (void)serviceMarketData{
    
    [self setServiceMarketUI];
}



//这边是服务人员的市场服务界面
- (void)loadPersonlMarketServiceData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.status forKey:@"status"];
    [dict setObject:self.serviceId forKey:@"serviceId"];
    [dict setObject:self.type forKey:@"type"];
    [dict setObject:self.search forKey:@"search"];
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
                
                
               // [weakSelf.marketArray removeAllObjects];
                [weakSelf.imageArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"Data"];

                for (int i = 0; i < array.count; i++) {
//                    RSServiceMarketModel * serviceMarketmodel = [[RSServiceMarketModel alloc]init];
//                    serviceMarketmodel.address = [[array objectAtIndex:i]objectForKey:@"address"];
//                    serviceMarketmodel.appointTime = [[array objectAtIndex:i]objectForKey:@"appointTime"];
//                    serviceMarketmodel.commentTime = [[array objectAtIndex:i]objectForKey:@"commentTime"];
//                    serviceMarketmodel.dispatchTime = [[array objectAtIndex:i]objectForKey:@"dispatchTime"];
//                    serviceMarketmodel.endTime = [[array objectAtIndex:i]objectForKey:@"endTime"];
//                    serviceMarketmodel.outBoundNo = [[array objectAtIndex:i]objectForKey:@"outBoundNo"];
//                    serviceMarketmodel.sendTime = [[array objectAtIndex:i]objectForKey:@"sendTime"];
//                    serviceMarketmodel.serviceComment = [[array objectAtIndex:i]objectForKey:@"serviceComment"];
//                    serviceMarketmodel.serviceId = [[array objectAtIndex:i]objectForKey:@"serviceId"];
//                    serviceMarketmodel.serviceKind = [[array objectAtIndex:i]objectForKey:@"serviceKind"];
//                    serviceMarketmodel.serviceThing = [[array objectAtIndex:i]objectForKey:@"serviceThing"];
//                    serviceMarketmodel.serviceTime = [[array objectAtIndex:i]objectForKey:@"serviceTime"];
//                    serviceMarketmodel.starLevel = [[array objectAtIndex:i]objectForKey:@"starLevel"];
//                    serviceMarketmodel.img = [[array objectAtIndex:i]objectForKey:@"img"];
                   // [weakSelf.marketArray addObject:serviceMarketmodel];
                    
                    _repairBtn.enabled = NO;
                    _otherBtn.enabled = NO;
                    _serviceTimeBtn.enabled = NO;
                    _serviceAddressTextfield.enabled = NO;
                    _serviceQuestuionLabel.text = @"";
                    _serviceQuestuionLabel.hidden = YES;
                    _serviceQuestiomView.editable = NO;
                    _reservationBtn.hidden = YES;
                    _reservationBtn.enabled = NO;
                    _addPic.enabled = NO;
                    
                    _servicePhoneTextfield.enabled = NO;
                    
                    _servicePhonePlayBtn.enabled = YES;
                    
                    [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                    [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                    _alertLabel.sd_layout
                    .topSpaceToView(_serviceImageview, 20);
                    
                    NSArray * imgArray = [NSArray array];
                    imgArray = [[array objectAtIndex:i]objectForKey:@"img"];
                    
                    if ([[[array objectAtIndex:i]objectForKey:@"serviceKind"] isEqualToString:@"维修"]) {
                        _repairBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FA6A00"].CGColor;
                        _otherBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
                        [_repairBtn setTitle:@"维修" forState:UIControlStateNormal];
                        [_repairBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FA6A00"] forState:UIControlStateNormal];
                        [_repairBtn setBackgroundImage:[UIImage imageNamed:@"选中2"] forState:UIControlStateNormal];
                        _temp = _repairBtn.currentTitle;
                    }else{
                        _repairBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
                        _otherBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FA6A00"].CGColor;
                        [_otherBtn setBackgroundImage:[UIImage imageNamed:@"选中2"] forState:UIControlStateNormal];
                        [_otherBtn setTitle:@"保洁" forState:UIControlStateNormal];
                        [_otherBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FA6A00"] forState:UIControlStateNormal];
                        _temp = _otherBtn.currentTitle;
                    }
                    [_serviceTimeBtn setTitle:[[array objectAtIndex:i]objectForKey:@"appointTime"] forState:UIControlStateNormal];
                    _serviceAddressTextfield.text = [[array objectAtIndex:i]objectForKey:@"address"];
                    _serviceQuestiomView.text = [[array objectAtIndex:i]objectForKey:@"serviceThing"];
                    _servicePhoneTextfield.text = [[array objectAtIndex:i]objectForKey:@"phone"];
                    _serviceQuestuionLabel.text = @"";
                    for (int j = 0; j < imgArray.count; j++) {
                        
                        RSServiceMarketModel * serviceMarketmodel = [[RSServiceMarketModel alloc]init];
                        serviceMarketmodel.imgId = [[[imgArray objectAtIndex:j]objectForKey:@"imgId"] integerValue];
                        serviceMarketmodel.imgUrl = [[imgArray objectAtIndex:j]objectForKey:@"imgUrl"];
                        [weakSelf.imageArray addObject:serviceMarketmodel];
                    }
                   // [weakSelf.imageArray addObjectsFromArray:imgArray];
                }
                [weakSelf nineMarketGrid];
                [weakSelf.tableview reloadData];
                [SVProgressHUD dismiss];
            }
            else{
                _repairBtn.enabled = NO;
                _otherBtn.enabled = NO;
                _serviceTimeBtn.enabled = NO;
                _serviceAddressTextfield.enabled = NO;
                _serviceQuestuionLabel.text = @"";
                _serviceQuestuionLabel.hidden = YES;
                _serviceQuestiomView.editable = NO;
                _reservationBtn.hidden = YES;
                _reservationBtn.enabled = NO;
                _addPic.enabled = NO;
                
                _servicePhoneTextfield.enabled = NO;
                _servicePhonePlayBtn.enabled = YES;
                
                [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                _alertLabel.sd_layout
                .topSpaceToView(_serviceImageview, 20);
               [weakSelf.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD dismiss];
            }
        }else{
            _repairBtn.enabled = NO;
            _otherBtn.enabled = NO;
            _serviceTimeBtn.enabled = NO;
            _serviceAddressTextfield.enabled = NO;
            _serviceQuestuionLabel.text = @"";
            _serviceQuestuionLabel.hidden = YES;
            _serviceQuestiomView.editable = NO;
            _reservationBtn.hidden = YES;
            _reservationBtn.enabled = NO;
            _addPic.enabled = NO;
            _servicePhoneTextfield.enabled = NO;
            _servicePhonePlayBtn.enabled = YES;
            
            [_servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
            [_servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
            _alertLabel.sd_layout
            .topSpaceToView(_serviceImageview, 20);
             [weakSelf.navigationController popViewControllerAnimated:YES];
            [SVProgressHUD dismiss];
        }
    }];
}

//FIXME:发起市场服务
- (void)sendMarketServiceAction:(UIButton *)btn{
    if ([_temp isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请选择服务类型"];
        return;
    }
    if ([_serviceTimeBtn.currentTitle isEqualToString:@"请选择服务时间"]){
        [SVProgressHUD showInfoWithStatus:@"请选择服务时间"];
        return;
    }
    NSString *temp = [_serviceAddressTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp length] ==0) {
        [SVProgressHUD showInfoWithStatus:@"请填写服务地址"];
        return;
    }
    NSString *temp1 = [_serviceQuestiomView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp1 length] ==0) {
        [SVProgressHUD showInfoWithStatus:@"请填写出现问题的描述"];
        return;
    }
    
    NSString * temp2 = [_servicePhoneTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp2 length] == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写电话号码"];
        return;
    }else{
        if(![self isTrueMobile:self.servicePhoneTextfield.text])
        {
            [SVProgressHUD showInfoWithStatus:@"请输入正确的电话号码"];
            return;
        }
    }
    if ([_temp isEqualToString:@"维修"]) {
        if (self.imageArray.count < 1) {
          [SVProgressHUD showInfoWithStatus:@"请添加问题图片"];
          return;
       }
    }else{
        //保洁不需要图片
    }
    [SVProgressHUD showWithStatus:@"正在上传数据中.........."];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if ([btn.currentTitle isEqualToString:@"立即预约"]) {
        [dict setObject:self.usermodel.userID forKey:@"sendUserId"];
        [dict setObject:_serviceTimeBtn.currentTitle forKey:@"appointTime"];
        [dict setObject: _serviceAddressTextfield.text forKey:@"address"];
        [dict setObject:_serviceQuestiomView.text forKey:@"serviceThing"];
        [dict setObject:_servicePhoneTextfield.text forKey:@"phone"];
        [dict setObject:_temp forKey:@"serviceKing"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        if (self.imageArray.count < 1) {
            [network getDataWithUrlString:URL_STARTADDSERVICE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL Result = [json[@"Result"]boolValue];
                    if (Result) {
                        [SVProgressHUD dismiss];
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"发起失败"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"发起失败"];
                }
            }];
        }else{
            [network getMoreImageDataWithUrlString:URL_STARTADDSERVICE_IOS withParameters:parameters andDataArray:_imageArray withBlock:^(id json, BOOL success) {
                if (success) {
                    BOOL Result = [json[@"Result"]boolValue];
                    if (Result) {
                        [SVProgressHUD dismiss];
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"上传失败"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"上传失败"];
                }
            }];
        }
    }else{
        //myservicemodel.serviceThing
        /*
         当前服务Id    serviceId      String myservicemodel.serviceId
         // 服务种类   serviceKind    String myservicemodel.serviceKind
         // 地址      address        String
         // 指定时间   appointTime    myservicemodel.appointTime
         // 服务事项   serviceThing   myservicemodel.serviceThing
         // 用户id    userId         self.usermodel.userID
         // 电话号码   phone
         */
        [dict setObject:self.usermodel.userID forKey:@"userId"];
        [dict setObject:self.serviceId forKey:@"serviceId"];
        [dict setObject:_serviceTimeBtn.currentTitle forKey:@"appointTime"];
        [dict setObject: _serviceAddressTextfield.text forKey:@"address"];
        [dict setObject:_serviceQuestiomView.text forKey:@"serviceThing"];
        [dict setObject:_temp forKey:@"serviceKind"];
        [dict setObject:_servicePhoneTextfield.text forKey:@"phone"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_UPDATESERVICEFORUSER_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"]boolValue];
                if (Result) {
                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"修改失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
        }];
    }
}


#pragma mark -- 上传图片
- (void)loadServiceMarketPictureOwerData{
    //URL_SERVICEIMGSOPT_IOS
    [SVProgressHUD showWithStatus:@"上传中......."];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"1" forKey:@"optType"];
    [dict setObject:self.serviceId forKey:@"serviceId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    NSArray *avatarArray = [NSArray arrayWithObject:_photoEntityWillUpload.image];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSData *imageData;
    for (UIImage *avatar in avatarArray)
    {
        imageData = UIImageJPEGRepresentation(avatar, 1);
        [dataArray addObject:imageData];
    }
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getImageDataWithUrlString:URL_SERVICEIMGSOPT_IOS withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"]boolValue];
            if (Result) {
                RSServiceMarketModel * serviceMarketmodel = [[RSServiceMarketModel alloc]init];
                serviceMarketmodel.imgId = [json[@"Data"][@"imgId"] integerValue];
                serviceMarketmodel.imgUrl = json[@"Data"][@"imgUrl"];
                [weakSelf.imageArray addObject:serviceMarketmodel];
                [SVProgressHUD dismiss];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf nineMarketGrid];
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"上传失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * SERVICEMARKETID = @"SERVICEMARKETID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SERVICEMARKETID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SERVICEMARKETID];
    }
    return cell;
}

#pragma mark -- 服务类型
- (void)choiceServiceStyle:(UIButton *)serviceBtn{
    if(serviceBtn != self.selectedBtn){
        self.selectedBtn.selected = NO ;
        serviceBtn.selected = YES ;
        self.selectedBtn = serviceBtn;
        _temp = serviceBtn.currentTitle;
        if ([serviceBtn.currentTitle isEqualToString:_repairBtn.currentTitle]) {
            _repairBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FA6A00"].CGColor;
            _otherBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
            [_repairBtn setTitle:@"维修" forState:UIControlStateSelected];
            [_repairBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FA6A00"] forState:UIControlStateSelected];
            [_repairBtn setBackgroundImage:[UIImage imageNamed:@"选中2"] forState:UIControlStateSelected];
            [_otherBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [_otherBtn setTitleColor:[UIColor colorWithHexColorStr:@"#D6D6D6"] forState:UIControlStateNormal];
        }else{
            _repairBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#D6D6D6"].CGColor;
             _otherBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#FA6A00"].CGColor;
            [_otherBtn setBackgroundImage:[UIImage imageNamed:@"选中2"] forState:UIControlStateSelected];
            [_otherBtn setTitle:@"保洁" forState:UIControlStateSelected];
            [_otherBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FA6A00"] forState:UIControlStateSelected];
            [_repairBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
             [_repairBtn setTitleColor:[UIColor colorWithHexColorStr:@"#D6D6D6"] forState:UIControlStateNormal];
        }
    } else {
        self.selectedBtn.selected  =  YES ;
    }
}


- (NSString *)currentTime{
    
    NSDate * detaildate=[NSDate date];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}


//FIXME: 选择服务时间
- (void)choiceOutTime:(UIButton *)btn{
    NSMutableArray * timeArray = [NSMutableArray array];
    timeArray = [self recaptureTime:[self currentTime]];
    RSWeakself
    CustomMyPickerView *customVC  = [[CustomMyPickerView alloc] initWithComponentDataArray:timeArray titleDataArray:nil];
    customVC.delegate = self;
    customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        if ([compoentString isEqualToString:@"立刻送"]) {
            compoentString = [weakSelf getCurrentTime];
        }else{
            compoentString = [NSString stringWithFormat:@"%@:00",compoentString];
        }
        [weakSelf.serviceTimeBtn setTitle:[NSString stringWithFormat:@"%@ %@",titileString,compoentString] forState:UIControlStateNormal];
    };
    _customVC = customVC;
    [self.view addSubview:customVC];
}

- (void)compareTime:(NSString *)titleTimeStr{
    NSMutableArray * timeArray = [NSMutableArray array];
    timeArray = [self recaptureTime:titleTimeStr];
    _customVC.componentArray = timeArray;
    RSWeakself
    _customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        if ([compoentString isEqualToString:@"立刻送"]) {
            compoentString = [weakSelf getCurrentTime];
        }else{
            compoentString = [NSString stringWithFormat:@"%@:00",compoentString];
        }
        [weakSelf.serviceTimeBtn setTitle:[NSString stringWithFormat:@"%@ %@",titileString,compoentString] forState:UIControlStateNormal];
    };
    
    [_customVC.picerView reloadAllComponents];
}





//重新获取时间
- (NSMutableArray *)recaptureTime:(NSString *)titleString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"mm"];
    NSString * dateTime = [formatter stringFromDate:[NSDate date]];
    NSString * minute = [formatter1 stringFromDate:[NSDate date]];
    NSString * reloadYear = [self currentTime];
    NSString * time = [NSString stringWithFormat:@"%@:%@",dateTime,minute];
    NSMutableArray * timeArray = [NSMutableArray array];
    NSArray * choiceTimeArray = @[@"00:00",@"00:30",@"01:00",@"01:30",@"02:00",@"02:30",@"03:00",@"03:30",@"04:00",@"04:30",@"05:00",@"05:30",@"06:00",@"06:30",@"07:00",@"07:30",@"08:00",@"08:30",@"09:00",@"09:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",@"21:30",@"22:00",@"22:30",@"23:00",@"23:30"];
    NSString * rightNowStr = @"立刻送";
    [timeArray removeAllObjects];
    for (int i = 0; i < choiceTimeArray.count; i++) {
        NSString * timeStr = choiceTimeArray[i];
        BOOL resultYear = [titleString compare:reloadYear] == NSOrderedSame;
        if (resultYear) {
            BOOL result = [timeStr compare:time] == NSOrderedDescending;
            if (result == 1){
                [timeArray addObject:choiceTimeArray[i]];
            }
        }else{
            [timeArray addObject:choiceTimeArray[i]];
        }
    }
    [timeArray insertObject:rightNowStr atIndex:0];
    return timeArray;
}



#pragma mark -- 获取当前时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

#pragma mark -- 添加问题图片
- (void)addQuestionPicEvent:(UIButton *)addQuestionBtn{
    if (_imageArray.count >= 3) {
        [SVProgressHUD showInfoWithStatus:@"最多提交3张图片"];
    } else {
        
        
        RSSelectNeedImageTool * selectNeedTool = [[RSSelectNeedImageTool alloc]init];
        selectNeedTool.returnData = ^(XPhotoUploaderContentEntity * _Nonnull photoEntityWillUpload) {
            _photoEntityWillUpload = photoEntityWillUpload;
            if ([self.jumpStr isEqualToString:@"1"]) {
                if ([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]) {
                    
                    //上传单张图片
                    [self loadServiceMarketPictureOwerData];
                }else{
                    //这边是新增市场服务
                    
                    [self.imageArray addObject:_photoEntityWillUpload.image];
                    [self nineMarketGrid];
                }
            }else{
                if ( [[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]){
                    //下面是服务详情，还是修改服务
                    //             NSData * data = UIImageJPEGRepresentation(_photoEntityWillUpload.image, 1.0f);
                    //             NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                    //             RSServiceMarketModel * serviceMarketmodel = [[RSServiceMarketModel alloc]init];
                    //             serviceMarketmodel.imgId = 1000000000000000;
                    //             serviceMarketmodel.imgUrl = [NSString stringWithFormat:@"%@",encodedImageStr];
                    //             [weakSelf.imageArray addObject:serviceMarketmodel];
                    
                    //上传单张图片
                    [self loadServiceMarketPictureOwerData];
                }else{
                    //这边是新增市场服务
                    [self.imageArray addObject:_photoEntityWillUpload.image];
                    [self nineMarketGrid];
                }
            }
        };
        
        
        //RSWeakself
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //打开系统相机
           // [weakSelf openCamera];
            [selectNeedTool openCameraViewController:self];
            
        }];
        [alert addAction:action1];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([self.jumpStr isEqualToString:@"1"]) {
                if ([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]) {
                    // [self openPhotoAlbum];
                    
                    [selectNeedTool openPhotoAlbumViewController:self];
                }else{
                    [self selectPictures];
                }
            }else{
                //打开系统相册
                if ( [[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class])
                {
                    //[self openPhotoAlbum];
                    
                    [selectNeedTool openPhotoAlbumViewController:self];
                }else{
                    [self selectPictures];
                }
            }
        }];
        [alert addAction:action2];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //这边去取消操作
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action3];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                   
                   alert.modalPresentationStyle = UIModalPresentationFullScreen;
               }
        [self presentViewController:alert animated:YES completion:nil];
       
    }
}


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
//
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
//    }
//}
//
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
//
//#pragma mark -- 当用户选取完成后调用
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
//        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//        NSDictionary *mediaMetadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
//        if (mediaMetadata)
//        {
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
//             }];
//        }
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
//       //这边要区分开来，是添加市场服务,还是修改服务
//
//         if ([weakSelf.jumpStr isEqualToString:@"1"]) {
//             if ([[weakSelf.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]) {
//                 _photoEntityWillUpload = photo;
//                 //上传单张图片
//                 [weakSelf loadServiceMarketPictureOwerData];
//             }else{
//                 //这边是新增市场服务
//                 _photoEntityWillUpload = photo;
//                 [weakSelf.imageArray addObject:_photoEntityWillUpload.image];
//                 [weakSelf nineMarketGrid];
//             }
//         }else{
//             if ( [[weakSelf.navigationController.viewControllers objectAtIndex:2]class] == [RSServiceMyServiceController class]){
//                 //下面是服务详情，还是修改服务
//                 //             NSData * data = UIImageJPEGRepresentation(_photoEntityWillUpload.image, 1.0f);
//                 //             NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//                 //             RSServiceMarketModel * serviceMarketmodel = [[RSServiceMarketModel alloc]init];
//                 //             serviceMarketmodel.imgId = 1000000000000000;
//                 //             serviceMarketmodel.imgUrl = [NSString stringWithFormat:@"%@",encodedImageStr];
//                 //             [weakSelf.imageArray addObject:serviceMarketmodel];
//                 _photoEntityWillUpload = photo;
//                 //上传单张图片
//                 [weakSelf loadServiceMarketPictureOwerData];
//             }else{
//                 //这边是新增市场服务
//                 _photoEntityWillUpload = photo;
//                 [weakSelf.imageArray addObject:_photoEntityWillUpload.image];
//                 [weakSelf nineMarketGrid];
//             }
//         }
//     }
//     failedBlock:^(NSDictionary *errorInfo) {
//     }];
//}

//#pragma mark - ZYQAssetPickerController Delegate
//- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
//{
//    RSWeakself
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
//                   {
//                       for (int i=0; i<assets.count; i++)
//                       {
//                           ALAsset *asset = assets[i];
//                           //新增市场服务
//                               UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//                               [weakSelf.imageArray addObject:tempImg];
//                               dispatch_async(dispatch_get_main_queue(), ^{
//                                   [self nineMarketGrid];
//                               });
//                       }
//                   });
//}

//#pragma mark -- 对图片进行压缩
//- (UIImage *)scaleToSize:(UIImage *)img {
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    CGSize size = CGSizeMake(img.size.width*0.65, img.size.height*0.65);
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



// 本地相册选择多张照片
- (void)selectPictures
{
    
    TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:3 delegate:self];
    RSWeakself
    imagePickerVc.allowPickingVideo = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                       {
                           for (int i=0; i<photos.count; i++)
                           {
                               // = photos[i]
                               // ALAsset *asset = assets[i];
                               //UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                               UIImage * tempImg = photos[i];
                               [weakSelf.imageArray addObject:tempImg];
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [weakSelf nineMarketGrid];
                               });
                           }
                       });
        
        
    }];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
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
}




// 9宫格图片布局
- (void)nineMarketGrid
{
    for (UIImageView *imgv in _pictureView.subviews)
    {
        if ([imgv isKindOfClass:[UIImageView class]]) {
            [imgv removeFromSuperview];
        }
    }
    CGFloat width = 62.5;
    CGFloat height = 62.5;
    NSInteger count = self.imageArray.count;
    self.imageArray.count > 3 ? (count = 3) : (count = self.imageArray.count);
    if (count < 1) {
        _addPic.sd_layout
        .leftSpaceToView(_pictureView,14)
        .topSpaceToView(_pictureView, 0)
        .bottomEqualToView(_pictureView)
        .widthIs(62.5);
        [_pictureView setupAutoHeightWithBottomView:_addPic bottomMargin:0];
        [_serviceImageview setupAutoHeightWithBottomView:_pictureView bottomMargin:14.5];
       // [_headerview setupAutoHeightWithBottomView:_reservationBtn bottomMargin:0];
        [_headerview setupAutoHeightWithBottomView:_alertLabel bottomMargin:0];
    }else{
        for (int i=0; i<count; i++)
        {
            NSInteger row = i / ECA;
            NSInteger colom = i % ECA;
            UIImageView *imgv = [[UIImageView alloc] init];
            CGFloat imgX =  colom * (margin + width) + margin;
            CGFloat imgY =  row * (margin + height) + margin;
            imgv.frame = CGRectMake(imgX, imgY, width, height);
            RSServiceMarketModel * serviceMarketmodel = _imageArray[i];
            if ([self.jumpStr isEqualToString:@"1"]) {
                if ([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class] || [[self.navigationController.viewControllers objectAtIndex:3]class] == [RSPersonalServiceViewController class]) {
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:serviceMarketmodel.imgUrl]];
                    imgv.image = [UIImage imageWithData:data];
                }else{
                    imgv.image = self.imageArray[i];
                }
            }else{
                if ([[self.navigationController.viewControllers objectAtIndex:1]class] == [RSPersonalServiceViewController class] ||[[self.navigationController.viewControllers objectAtIndex:1]class] == [RSDispatchedPersonnelViewController class] || [[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class] ) {
                    
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:serviceMarketmodel.imgUrl]];
                    imgv.image = [UIImage imageWithData:data];
                    
                }else{
                    imgv.image = self.imageArray[i];
                }
            }
//            if ( [[self.navigationController.viewControllers objectAtIndex:2]class] == [RSServiceMyServiceController class] || [[self.navigationController.viewControllers objectAtIndex:1]class] == [RSPersonalServiceViewController class] || [[self.navigationController.viewControllers objectAtIndex:1]class] == [RSDispatchedPersonnelViewController class]) {
//                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:serviceMarketmodel.imgUrl]];
//                    imgv.image = [UIImage imageWithData:data];
//                }
//            }else{
//                imgv.image = self.imageArray[i];
//            }
            imgv.userInteractionEnabled = YES;
            [_pictureView addSubview:imgv];
            //添加手势
            imgv.tag = 100000+i;
        
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showQuestionPicture:)];
            tap.view.tag = 100000+i;
            [imgv addGestureRecognizer:tap];
            UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
            delete.frame = CGRectMake(width-16, 0, 16, 16);
            [delete setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
            [delete addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
            delete.tag = 10+i;
            [imgv addSubview:delete];
            if ([self.jumpStr isEqualToString:@"1"]) {
                if([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]){
                    if ([self.modifyStatusStr isEqualToString:@"1"]) {
                        delete.hidden = NO;
                        delete.enabled = YES;
                    }else{
                        delete.hidden = YES;
                        delete.enabled = NO;
                    }
                }else if ([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSPersonalServiceViewController class]){
                    delete.hidden = YES;
                    delete.enabled = NO;
                }else{
                    delete.hidden = YES;
                    delete.enabled = NO;
                }
            }else{
                if ([[self.navigationController.viewControllers objectAtIndex:1]class] == [RSDispatchedPersonnelViewController class]){
                    
                    delete.hidden = YES;
                    delete.enabled = NO;
                    
                    if ([self.modifyStatusStr isEqualToString:@"1"]) {
                        delete.hidden = NO;
                        delete.enabled = YES;
                    }else{
                        delete.hidden = YES;
                        delete.enabled = NO;
                    }
                }
                else if([[self.navigationController.viewControllers objectAtIndex:1]class] == [RSPersonalServiceViewController class]){
                    delete.hidden = YES;
                    delete.enabled = NO;
                }
                else if([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]){
                    if ([self.modifyStatusStr isEqualToString:@"1"]) {
                        delete.hidden = NO;
                        delete.enabled = YES;
                    }else{
                        delete.hidden = YES;
                        delete.enabled = NO;
                    }
                }
                else if([[self.navigationController.viewControllers objectAtIndex:2] class] == [RSServiceCentreVViewController class]){
                    delete.hidden = NO;
                    delete.enabled = YES;
                }else{
                    delete.hidden = YES;
                    delete.enabled = NO;
                }
            }
            _addPic.sd_layout
            .leftSpaceToView(imgv, margin)
            .topSpaceToView(imgv, imgY)
            .bottomEqualToView(imgv)
            .widthIs(62.5);
            [_pictureView setupAutoHeightWithBottomView:_addPic bottomMargin:0];
            //[_headerview setupAutoHeightWithBottomView:_reservationBtn bottomMargin:0];
            [_headerview setupAutoHeightWithBottomView:_alertLabel bottomMargin:0];
        }
    }
}

// 删除照片
- (void)deleteEvent:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([self.jumpStr isEqualToString:@"1"]) {
        
        if ([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]) {
            RSWeakself
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确实删除图片吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //这边还需要判断是本地图片还是网络图片
                NSIndexPath * indexptah = [NSIndexPath indexPathForRow:btn.tag - 10 inSection:0];
                [weakSelf deleteServiceMarketPictureOwerIndexpath:indexptah andTag:btn.tag - 10];
            }];
            [alert addAction:action1];
            UIAlertAction  * action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action2];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                   
                   alert.modalPresentationStyle = UIModalPresentationFullScreen;
               }
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            [_imageArray removeObjectAtIndex:btn.tag-10];
            [self nineMarketGrid];
        }
    }else{
        
        if ([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]){
            RSWeakself
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确实删除图片吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //这边还需要判断是本地图片还是网络图片
                NSIndexPath * indexptah = [NSIndexPath indexPathForRow:btn.tag - 10 inSection:0];
                [weakSelf deleteServiceMarketPictureOwerIndexpath:indexptah andTag:btn.tag - 10];
                
            }];
            [alert addAction:action1];
            UIAlertAction  * action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action2];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                
                alert.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            
            [_imageArray removeObjectAtIndex:btn.tag-10];
            [self nineMarketGrid];
        }
    }
}

#pragma mark --- 删除上传的图片
- (void)deleteServiceMarketPictureOwerIndexpath:(NSIndexPath *)indexpath andTag:(NSInteger)tag{
    if (self.imageArray.count < 2) {
        [SVProgressHUD showInfoWithStatus:@"最多要保存一张图片"];
    }else{
        RSServiceMarketModel * serviceMarketmodel = self.imageArray[tag];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"2" forKey:@"optType"];
        [dict setObject:self.serviceId forKey:@"serviceId"];
        [dict setObject:[NSString stringWithFormat:@"%ld",(long)serviceMarketmodel.imgId] forKey:@"imgId"];
        //    [dict setObject:self.search forKey:@"search"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        RSWeakself
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getDataWithUrlString:URL_SERVICEIMGSOPT_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"]boolValue];
                if (Result) {
                    [weakSelf.imageArray removeObjectAtIndex:tag];
                    [weakSelf nineMarketGrid];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"删除失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
        }];
    }
}

#pragma mark -- 点击显示的问题图片
- (void)showQuestionPicture:(UITapGestureRecognizer *)tap{
    if ([self.jumpStr isEqualToString:@"1"]) {
        if ([[self.navigationController.viewControllers objectAtIndex:3]class] == [RSPersonalServiceViewController class] || [[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]) {
            //这边是网络图片
            NSMutableArray * array = [NSMutableArray array];
            for (int i = 0; i < self.imageArray.count; i++) {
                RSServiceMarketModel * serviceMarketmodel = self.imageArray[i];
                [array addObject:serviceMarketmodel.imgUrl];
            }
            if (array.count > 0) {
     

                [HUPhotoBrowser showFromImageView:_pictureView.subviews[tap.view.tag - 100000] withURLStrings:array atIndex:tap.view.tag - 100000];

            }else{
                [SVProgressHUD showInfoWithStatus:@"获取不到图片信息"];
            }
        }else{

           
            [HUPhotoBrowser showFromImageView:_pictureView.subviews[tap.view.tag - 100000] withImages:self.imageArray atIndex:tap.view.tag - 100000 dismiss:nil];
        }
    }else{
        if ([[self.navigationController.viewControllers objectAtIndex:1]class] == [RSPersonalServiceViewController class] || [[self.navigationController.viewControllers objectAtIndex:1]class] == [RSDispatchedPersonnelViewController class] || [[self.navigationController.viewControllers objectAtIndex:3]class] == [RSServiceMyServiceController class]){
            
            
            //这边是网络图片
            NSMutableArray * array = [NSMutableArray array];
            for (int i = 0; i < self.imageArray.count; i++) {
                RSServiceMarketModel * serviceMarketmodel = self.imageArray[i];
                [array addObject:serviceMarketmodel.imgUrl];
            }
            if (array.count > 0) {
           
                
                
                  [HUPhotoBrowser showFromImageView:_pictureView.subviews[tap.view.tag - 100000] withURLStrings:array atIndex:tap.view.tag - 100000];
            }else{
                [SVProgressHUD showInfoWithStatus:@"获取不到图片信息"];
            }
        }else{
            
            [HUPhotoBrowser showFromImageView:_pictureView.subviews[tap.view.tag - 100000] withImages:self.imageArray atIndex:tap.view.tag - 100000 dismiss:nil];
            
        }
    }
}

#pragma mark --- uitextfieldDelegate
- (NSString *)delSpaceAndNewline:(NSString *)string;{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    /**时间_serviceTimeTextfield*/
//    if (textField == self.servicePhoneTextfield) {
//        NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        if ([temp length]!=0) {
//            NSString * temp1 = [self delSpaceAndNewline:temp];
//            self.servicePhoneTextfield.text = temp1;
//            if(![self isTrueMobile:self.servicePhoneTextfield.text])
//            {
//                self.servicePhonePlayBtn.enabled = NO;
//                [self.servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
//                [self.servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
//            }else{
//                self.servicePhonePlayBtn.enabled = YES;
//                [self.servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
//                [self.servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
//
//            }
//        }
//    }else{
        /**地址_serviceAddressTextfield*/
        NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([temp length]!=0) {
            //NSString * temp2 = [self delSpaceAndNewline:temp];
            //textField.text = temp2;
        }
    //}
    return YES;
}


- (void)showPhoneNumber:(UITextField *)servicePhoneTextfield{
        NSString *temp = [servicePhoneTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([temp length]!=0) {
            NSString * temp1 = [self delSpaceAndNewline:temp];
            self.servicePhoneTextfield.text = temp1;
            if(![self isTrueMobile:self.servicePhoneTextfield.text])
            {
                self.servicePhonePlayBtn.enabled = NO;
                [self.servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                [self.servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#d6d6d6"]];
            }else{
                self.servicePhonePlayBtn.enabled = YES;
                [self.servicePhonePlayBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
                [self.servicePhonePlayBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
            }
        }
}


#pragma mark -- uitextviewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp length]!=0) {
       // NSString * temp2 = [self delSpaceAndNewline:temp];
        //textView.text = temp2;
        _serviceQuestuionLabel.text = @"";
        _serviceQuestuionLabel.hidden = YES;
    }else{
        _serviceQuestuionLabel.text = @"请描述你遇到的问题";
        _serviceQuestuionLabel.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [_serviceQuestiomView resignFirstResponder];
    return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


//判断是不是电话号码
- (BOOL)isTrueMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^1(3|5|7|8|4)\\d{9}";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:mobile];
    //NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
     NSString * MOBILE = @"^((13[0-9])|(15[^4])|(18[0,1,2,3,5-9])|(17[0-8])|(19[8,9])|(166)|(147))\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobile];
}


//FIXME:打电话
- (void)serviceMarketPlayPhoneAction:(UIButton *)playBtn{
    
    [self setEditing:YES];
    
    if(![self isTrueMobile:self.servicePhoneTextfield.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
    }else{
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.servicePhoneTextfield.text];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
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
