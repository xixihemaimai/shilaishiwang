//
//  RSSLStorageViewController.m
//  石来石往
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLStorageViewController.h"
#import "RSRightPitureButton.h"
//合计
#import "RSSaveAlertView.h"
//扫描界面
#import "MADCameraCaptureController.h"
//选择仓库
#import "RSWarehouseManagementViewController.h"
//编辑
#import "RSBigBoardChangeViewController.h"

//模型
#import "RSSLStoragemanagementModel.h"
//仓库模型
#import "RSWarehouseModel.h"
#import "RSBillHeadModel.h"

//组头
#import "RSDabanPurchaseHeaderView.h"
//组尾
#import "RSDabanPurchaseFootView.h"


#import "RSTemplateModel.h"
//cell
#import "RSDabanPurchaseCell.h"
#import "RSSalertView.h"


@interface RSSLStorageViewController ()<RSSalertViewDelegate>
{
    
    
    //入库时间
    UIButton * _timeBtn;
    //入库时间显示
    UILabel * _timeShowLabel;
    
    
    /**批改*/
    UIButton * _rightBtn;
    /**选择仓库*/
    UIButton * _addBtn;
    /**扫描*/
    UIButton * _scanBtn;
    /**查看全部，新建保存*/
    UIView * _bottomview;
    /**查看全部*/
    UIButton * _checkAllBtn;
    /**新建保存*/
    UIButton * _savebottomBtn;
    /**编辑，删除，确定入库的view*/
    UIView * _editSureView;
    /**删除*/
    UIButton * _deleteBtn;
    /**编辑*/
    UIButton * _editBtn;
    /**确认入库*/
    UIButton * _sureBtn;
    /**取消编辑，查看全部，修改保存view*/
    UIView * _allView;
    /**取消编辑*/
    UIButton * _cancelEditBtn;
    /**查看全部*/
    UIButton * _checkcancelAllBtn;
    /**修改保存*/
    UIButton * _saveBtn;
    /**取消入库*/
    UIButton * _cancelBtn;
    
    //仓库
    UILabel * _warehouseDetailLabel;
    /**输入ID*/
//    UITextField * _modelTextfield;
    /**合计*/
    RSRightPitureButton * _rightPictureBtn;
    
}

@property (nonatomic,strong)RSSaveAlertView * saveAlertView;
//本地扫描的数组
@property (nonatomic,strong)NSMutableArray * dataArray;
//查看全部的数组
@property (nonatomic,strong)NSMutableArray * allArray;


//保存选择的按键的类型
@property (nonatomic,strong)NSString * btnType;

@property (nonatomic,strong)NSString * secondBtnType;

/**仓库的模型*/
@property (nonatomic,strong)RSWarehouseModel * warehousermodel;
/**仓库的选择的位置*/
@property (nonatomic,strong)RSBillHeadModel * billheadmodel;

@property (nonatomic,strong)NSMutableArray * templateArray;

@property (nonatomic,strong)RSSalertView * alertView;

@end

@implementation RSSLStorageViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}
- (RSSalertView *)alertView{
    if (!_alertView) {
        self.alertView = [[RSSalertView alloc] initWithFrame:CGRectMake(33, (SCH/2) - 100, SCW - 66 , 200)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.delegate = self;
        self.alertView.layer.cornerRadius = 15;
    }
    return _alertView;
}



- (NSMutableArray *)templateArray{
    if (!_templateArray) {
        _templateArray = [NSMutableArray array];
    }
    return _templateArray;
}


- (RSSaveAlertView *)saveAlertView{
    if (!_saveAlertView) {
        _saveAlertView = [[RSSaveAlertView alloc]initWithFrame:CGRectMake(0, SCH - 50 - 168, SCW,168)];   
    }
    return _saveAlertView;
}


- (RSWarehouseModel *)warehousermodel{
    if (!_warehousermodel) {
        _warehousermodel = [[RSWarehouseModel alloc]init];
    }
    return _warehousermodel;
}

- (RSBillHeadModel *)billheadmodel{
    if (!_billheadmodel) {
        _billheadmodel = [[RSBillHeadModel alloc]init];
    }
    return _billheadmodel;
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)allArray{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

static NSString * DABANPURCHASEFOOTVIEW = @"DABANPURCHASEFOOTVIEW";
static NSString * DABANPURCHASEHEADERVIEW = @"DABANPURCHASEHEADERVIEW";
- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义导航栏
    [self setCustomNavigaionView];
    //底下部分
    [self setDabanUI];
    //合计
    [self setTotalUI];
    //查看全部，本次扫描 ，新建保存
    [self setUIBottomView];
    //编辑，删除，确定入库
    [self seteditAndSureUI];
    //取消编辑，查看全部，修改保存
    [self setUICancelEditAndAllAndSaveSetUI];
    //取消入库
    [self cancelSetUI];
    /**
     选择仓库
    UIButton * _addBtn;
    扫描
    UIButton * _scanBtn;
    查看全部，新建保存
    UIView * _bottomview;
    查看全部
    UIButton * _checkAllBtn;
    新建保存
    UIButton * _savebottomBtn;
    编辑，删除，确定入库的view
    UIView * _editSureView;
    删除
    UIButton * _deleteBtn;
    编辑
    UIButton * _editBtn;
    确认入库
    UIButton * _sureBtn;
    取消编辑，查看全部，修改保存view
    UIView * _allView;
    取消编辑
    UIButton * _cancelEditBtn;
    查看全部
    UIButton * _checkcancelAllBtn;
    修改保存
    UIButton * _saveBtn;
    取消入库
    UIButton * _cancelBtn;
     */
    
    
    self.secondBtnType = @"thisCheck";
    if ([self.showType isEqualToString:@"new"]) {
        //点击新建的界面
        _addBtn.hidden = NO;
        _scanBtn.hidden = NO;
        _bottomview.hidden = NO;
        _checkAllBtn.hidden = NO;
        _savebottomBtn.hidden = NO;
        
        _editSureView.hidden = YES;
        _editBtn.hidden = YES;
        _sureBtn.hidden = YES;
        _deleteBtn.hidden = YES;
        
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _checkcancelAllBtn.hidden = YES;
        _saveBtn.hidden = YES;
        _cancelBtn.hidden = YES;
        self.btnType = @"edit";
        
        _timeBtn.hidden = NO;
        _timeShowLabel.text = [self showCurrentTime];
        
        [self reloadModelListNewData];
    }else{
        //点击cell跳转过来的值，要去加载数据
        _addBtn.hidden = YES;
        _scanBtn.hidden = YES;
        
        _bottomview.hidden = YES;
        _checkAllBtn.hidden = YES;
        _savebottomBtn.hidden = YES;
        
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _checkcancelAllBtn.hidden = YES;
        
        _saveBtn.hidden = YES;
      
        if (self.personalFunctionmodel.status == 0) {
            _cancelBtn.hidden = YES;
            
            _editSureView.hidden = NO;
            _editBtn.hidden = NO;
            _sureBtn.hidden = NO;
            _deleteBtn.hidden = NO;
        }else{
            _cancelBtn.hidden = NO;
            _editSureView.hidden = YES;
            _editBtn.hidden = YES;
            _sureBtn.hidden = YES;
            _deleteBtn.hidden = YES;
        }
        self.btnType = @"save";
        
        _timeBtn.hidden = YES;
        
        [self reloadOldSaveNewData];
        [self reloadModelListNewData];
    }
}


- (void)reloadModelListNewData{
    // NSString * ulr = @"http://192.168.1.128:8080/slsw/pwms/modelList.do";
    //TableModel * tableModel = [[TableModel alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:@"SL" forKey:@"modelType"];
    [dict setObject:@"1" forKey:@"status"];
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
                
                //大板的缓存用户选中的tempID的值
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                NSInteger SL = [[user objectForKey:@"SL"] integerValue];
//                if (SL == nil) {
//                    [user setObject:@"" forKey:@"SL"];
//                    [user synchronize];
//                }
                if (weakSelf.templateArray.count < 1) {
                    [user setObject:@"" forKey:@"SL"];
                    [user synchronize];
                }else{
                    for (int i = 0; i < weakSelf.templateArray.count; i++) {
                        RSTemplateModel * templatemodel = weakSelf.templateArray[i];
                        if (templatemodel.tempID == SL) {
                            [user setObject:[NSNumber numberWithInteger:templatemodel.tempID] forKey:@"SL"];
                            [user synchronize];
                            break;
                        }else{
                            if (i == 0) {
                                [user setObject:[NSNumber numberWithInteger:templatemodel.tempID] forKey:@"SL"];
                                [user synchronize];
                            }
                        }
                    }
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取失败"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


- (void)setCustomNavigaionView{
    
    CGFloat H = 0.0;
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        H = 88;
        Y = 49;
    }else{
        H = 64;
        Y = 25;
    }
    UIView * navigaionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, H)];
    navigaionView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:navigaionView];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(12, Y - 5, 40, 40);
    [leftBtn addTarget:self action:@selector(backUpFunctionAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [navigaionView addSubview:leftBtn];
    
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(SCW - 80 - 12, Y - 5, 80, 40);
    [rightBtn setTitleColor:[UIColor colorWithHexColorStr:@"#3385ff"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"厚度修改" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(changeScanContentAction:) forControlEvents:UIControlEventTouchUpInside];
    [navigaionView addSubview:rightBtn];
    _rightBtn = rightBtn;
    _rightBtn.hidden = YES;
    
    
    
    UILabel * contentTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW/2 - 50, Y + 5, 100, 23)];
     contentTitleLabel.text = self.selectFunctionType;
    contentTitleLabel.font = [UIFont systemFontOfSize:17];
    contentTitleLabel.textColor = [UIColor blackColor];
    contentTitleLabel.textAlignment = NSTextAlignmentCenter;
    [navigaionView addSubview:contentTitleLabel];
    
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, H - 1, SCW, 1)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [navigaionView addSubview:bottomview];

}

//批改
- (void)changeScanContentAction:(UIButton *)rightBtn{
   //这边是修改大板批量修改厚度
    if (self.dataArray.count > 0) {
        //只有一个吗？
        //self.alertView.selectFunctionType = self.selectFunctionType;
        //self.alertView.wareHouseTypeName = _textfield.text;
        self.alertView.selectFunctionType = @"修改厚度";
        [self.alertView showView];
        _rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
        [self.saveAlertView closeView];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请先添加物料"];
    }
}

- (void)changHeightNumber:(NSString *)heightNumber{
    for (int i = 0; i < self.dataArray.count; i++) {
        NSMutableArray * array = self.dataArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
            slstoragemanagementmodel.height = [NSDecimalNumber decimalNumberWithString:heightNumber];
        }
    }
    self.secondBtnType = @"thisCheck";
    [self.tableview reloadData];
}


//大板填写入库单
- (void)setDabanUI{
    //添加tableview头部视图
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 174)];
    topView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    self.tableview.tableHeaderView = topView;
    
    
    //时间
    UIView * timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 50)];
    timeView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:timeView];
    UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 31, 21)];
    timeLabel.text = @"日期";
    timeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [timeView addSubview:timeLabel];
    
    //时间label
    UILabel * timeShowLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame) + 17, 0, SCW - CGRectGetMaxX(timeLabel.frame) + 10, 50)];
    
    timeShowLabel.text = @"请选择时间";
    
    timeShowLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    timeShowLabel.font = [UIFont systemFontOfSize:15];
    timeShowLabel.textAlignment = NSTextAlignmentLeft;
    [timeView addSubview:timeShowLabel];
    _timeShowLabel = timeShowLabel;
    //时间按键
    UIButton * timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
    [timeBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    [timeView addSubview:timeBtn];
    [timeBtn addTarget:self action:@selector(choiceChangeTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    timeBtn.layer.cornerRadius = timeBtn.yj_width * 0.5;
    _timeBtn = timeBtn;
    
    
    
    //选择仓库
    UIView * fristView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(timeView.frame) + 9, SCW, 49)];
    fristView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:fristView];
    
    UILabel * warehouseLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 31, 21)];
    warehouseLabel.text = @"仓库";
    warehouseLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    warehouseLabel.font = [UIFont systemFontOfSize:15];
    warehouseLabel.textAlignment = NSTextAlignmentLeft;
    [fristView addSubview:warehouseLabel];
    
    
    UILabel * warehouseDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(warehouseLabel.frame) + 17, 13, SCW/2, 21)];
    warehouseDetailLabel.text = @"请选择仓库";
    warehouseDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    warehouseDetailLabel.font = [UIFont systemFontOfSize:15];
    warehouseDetailLabel.textAlignment = NSTextAlignmentLeft;
    [fristView addSubview:warehouseDetailLabel];
    _warehouseDetailLabel = warehouseDetailLabel;
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
    [addBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    //[addBtn setTitle:@"+" forState:UIControlStateNormal];
    //[addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [fristView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addWarehouseAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.layer.cornerRadius = addBtn.yj_width * 0.5;
    _addBtn = addBtn;
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fristView.frame) + 9, SCW, 49)];
    secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [topView addSubview:secondView];
    
    
    UILabel * materialLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 62, 21)];
    materialLabel.text = @"物料信息";
    materialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    materialLabel.font = [UIFont systemFontOfSize:15];
    materialLabel.textAlignment = NSTextAlignmentLeft;
    [secondView addSubview:materialLabel];
    
    UIButton * scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake(SCW - 12 - 62, 13, 62, 28);
    // scanLabel.text = @"扫描";
    [scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    //scanLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
    [scanBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FDAD32"]];
    [scanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    //scanLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    //scanLabel.font = [UIFont systemFontOfSize:14];
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    //scanLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:scanBtn];
    [scanBtn addTarget:self action:@selector(scanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    scanBtn.layer.cornerRadius = 14;
    scanBtn.layer.masksToBounds = YES;
    _scanBtn = scanBtn;
    
//    UIView * thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame) + 10, SCW, 40)];
//    thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    [topView addSubview:thirdView];
    
//    UILabel * modelLabel = [[UILabel alloc]init];
//    modelLabel.frame = CGRectMake(12, 0, 50, 40);
//    modelLabel.text = @"模板ID:";
//    modelLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//    modelLabel.font = [UIFont systemFontOfSize:14];
//    modelLabel.textAlignment = NSTextAlignmentLeft;
//    [thirdView addSubview:modelLabel];
//
//
//    UITextField * modelTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(modelLabel.frame), 0, SCW -CGRectGetMaxX(modelLabel.frame) , 40)];
//    modelTextfield.keyboardType = UIKeyboardTypeNumberPad;
//    modelTextfield.placeholder = @"输入模板ID";
//    [modelTextfield addTarget:self action:@selector(inputModelidAction:) forControlEvents:UIControlEventEditingDidEnd];
//    [thirdView addSubview:modelTextfield];
//    _modelTextfield = modelTextfield;
}

//改变时间
- (void)choiceChangeTimeAction:(UIButton *)timeBtn{
    NSDate * date = [self nsstringConversionNSDate:_timeShowLabel.text];
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:date CompleteBlock:^(NSDate *selectDate) {
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        //结束时间
        //[timeBtn setTitle:date forState:UIControlStateNormal];
        _timeShowLabel.text = date;
    }];
    //    datepicker.maxLimitDate = [NSDate date];
    // datepicker.minLimitDate = [self currentMinTime];
    [datepicker show];
}






//输入模板ID;
- (void)inputModelidAction:(UITextField *)textfield{
    NSString *temp = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] > 0) {
        textfield.text = temp;
    }else{
        textfield.text = @"";
    }
}


- (void)setTotalUI{
    RSRightPitureButton * rightPictureBtn = [RSRightPitureButton buttonWithType:UIButtonTypeCustom];
    rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
    [rightPictureBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
    [rightPictureBtn setTitle:@"合计" forState:UIControlStateNormal];
    [rightPictureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FFFFFF"]];
    [rightPictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    rightPictureBtn.layer.shadowOffset =  CGSizeMake(1, 1);
    rightPictureBtn.layer.shadowOpacity = 0.8;
    rightPictureBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
    rightPictureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightPictureBtn addTarget:self action:@selector(openAndCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightPictureBtn];
    _rightPictureBtn = rightPictureBtn;
}



//底部视图
- (void)setUIBottomView{
    
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, SCH - 50, SCW, 50)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    bottomview.userInteractionEnabled = YES;
    [self.view addSubview:bottomview];
    _bottomview = bottomview;
    
    UIButton * checkAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkAllBtn.frame = CGRectMake(0, 0, SCW/2 - 0.5, 50);
    [checkAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [checkAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [checkAllBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    checkAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
   [checkAllBtn addTarget:self action:@selector(checkAllAndScanAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomview addSubview:checkAllBtn];
    _checkAllBtn = checkAllBtn;
    
    UIButton * savebottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savebottomBtn.frame = CGRectMake(SCW/2 + 1, 0, SCW/2 - 0.5, 50);
    [savebottomBtn setTitle:@"保存" forState:UIControlStateNormal];
    [savebottomBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [savebottomBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    savebottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [savebottomBtn addTarget:self action:@selector(saveCurrentDataAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomview addSubview:savebottomBtn];
    _savebottomBtn = savebottomBtn;
}


//编辑和确认入库
- (void)seteditAndSureUI{
    
    UIView * editSureView = [[UIView alloc]init];
    editSureView.frame = CGRectMake(0, SCH - 50, SCW, 50);
    editSureView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:editSureView];
    _editSureView = editSureView;
    editSureView.hidden = YES;
    
    //删除
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(0, 0, SCW/3 -1, 50);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [editSureView addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn = deleteBtn;
    deleteBtn.hidden = YES;
    
    
    //编辑
    UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(CGRectGetMaxX(deleteBtn.frame) + 1, 0, SCW/3 - 1, 50);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [editBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [editBtn addTarget:self action:@selector(editSureViewAndEditAction:) forControlEvents:UIControlEventTouchUpInside];
    [editSureView addSubview:editBtn];
    _editBtn = editBtn;
    editBtn.hidden = YES;
    //确认入库
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(CGRectGetMaxX(editBtn.frame) + 1, 0, SCW/3, 50);
    [sureBtn setTitle:@"确认入库" forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
   [sureBtn addTarget:self action:@selector(editSureViewAndSureAction:) forControlEvents:UIControlEventTouchUpInside];
    [editSureView addSubview:sureBtn];
    _sureBtn = sureBtn;
    sureBtn.hidden = YES;
}


//取消编辑 查看全部 保存
- (void)setUICancelEditAndAllAndSaveSetUI{
    
    UIView * allView = [[UIView alloc]init];
    allView.frame = CGRectMake(0, SCH - 50, SCW, 50);
    allView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:allView];
    _allView = allView;
    allView.hidden = YES;
    
    UIButton * cancelEditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelEditBtn.frame = CGRectMake(0, 0, SCW/3 - 1, 50);
    [cancelEditBtn setTitle:@"取消编辑" forState:UIControlStateNormal];
    [cancelEditBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [cancelEditBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    cancelEditBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelEditBtn addTarget:self action:@selector(allViewCancelEditBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [allView addSubview:cancelEditBtn];
    _cancelEditBtn = cancelEditBtn;
    cancelEditBtn.hidden = YES;
    
    UIButton * checkcancelAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkcancelAllBtn.frame = CGRectMake(CGRectGetMaxX(cancelEditBtn.frame) + 1 , 0, SCW/3 - 1, 50);
    [checkcancelAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [checkcancelAllBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    checkcancelAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [allView addSubview:checkcancelAllBtn];
    [checkcancelAllBtn addTarget:self action:@selector(allViewcheckCancelAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _checkcancelAllBtn = checkcancelAllBtn;
    checkcancelAllBtn.hidden = YES;
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(CGRectGetMaxX(checkcancelAllBtn.frame) + 1 , 0, SCW/3, 50);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
   [saveBtn addTarget:self action:@selector(allViewchecksaveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [allView addSubview:saveBtn];
    _saveBtn = saveBtn;
    saveBtn.hidden = YES;
}



//取消入库
- (void)cancelSetUI{
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitle:@"取消入库" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    cancelBtn.hidden = YES;
}


- (void)backUpFunctionAction:(UIButton *)leftBtn{
    if ([self.showType isEqualToString:@"new"]) {
        if ([self.btnType isEqualToString:@"edit"] && self.dataArray.count > 0) {
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"你的数据未保存,需要返回吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertView addAction:alert];
            UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertView addAction:alert1];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                
                alertView.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:alertView animated:YES completion:nil];
            
        } else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        if ([self.btnType isEqualToString:@"edit"] && self.dataArray.count > 0) {
            UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"你的数据未保存,需要返回吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
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
        else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}



//选择仓库
- (void)addWarehouseAction:(UIButton *)addBtn{
    _rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
    [self.saveAlertView closeView];
    RSWarehouseManagementViewController * warehouseManagementVc = [[RSWarehouseManagementViewController alloc]init];
    warehouseManagementVc.usermodel = self.usermodel;
    warehouseManagementVc.selectName =  _warehouseDetailLabel.text;
    warehouseManagementVc.selectType = self.selectType;
    warehouseManagementVc.selectFunctionType = self.selectFunctionType;
    [self.navigationController pushViewController:warehouseManagementVc animated:YES];
    warehouseManagementVc.select = ^(BOOL isSelect, RSWarehouseModel * _Nonnull warehousemodel) {
        if (isSelect) {
            _warehouseDetailLabel.text = warehousemodel.name;
            self.warehousermodel = warehousemodel;
            self.billheadmodel.whsName = warehousemodel.name;
            self.billheadmodel.whsId = warehousemodel.WareHouseID;
        }
    };
}

//新建保存
- (void)saveCurrentDataAction:(UIButton *)savebottomBtn{
    if (self.dataArray.count > 0) {
        if ([self testingDataComplete]) {
//            [_modelTextfield resignFirstResponder];
            _rightBtn.hidden = YES;
            [self.allArray addObjectsFromArray:self.dataArray];
            self.btnType = @"save";
            [self newSaveBillNewData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"数据不完整"];
        }
    }else if (self.allArray.count > 0){
        _rightBtn.hidden = YES;
        self.btnType = @"save";
        [self newSaveBillNewData];
    }else{
        [SVProgressHUD showInfoWithStatus:@"数据不完整"];
    }
}


//删除
- (void)deleteAction:(UIButton *)deleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteSureStorageBillNewData];
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

//编辑
- (void)editSureViewAndEditAction:(UIButton *)editBtn{
    
    _addBtn.hidden = NO;
    _scanBtn.hidden = NO;
    _timeBtn.hidden = NO;
    
    _bottomview.hidden = YES;
    _checkAllBtn.hidden = YES;
    _savebottomBtn.hidden = YES;
    
    
    _editSureView.hidden = YES;
    _editBtn.hidden = YES;
    _sureBtn.hidden = YES;
    _deleteBtn.hidden = YES;
    
    _allView.hidden = NO;
    _cancelEditBtn.hidden = NO;
    _checkcancelAllBtn.hidden = NO;
    _saveBtn.hidden = NO;
    
    _cancelBtn.hidden = YES;
    
    _rightBtn.hidden = YES;
    //这边编辑可以让仓库cell编辑
    self.btnType = @"edit";
    [self.tableview reloadData];
    _checkcancelAllBtn.selected = NO;
    [_checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    _addBtn.enabled = YES;
    
}

//确认入库
- (void)editSureViewAndSureAction:(UIButton *)sureBtn{
    self.btnType = @"save";
    //URL_CONFIRMBILL_IOS
    _rightBtn.hidden = YES;
    [self sureStorageBillNewData];
}

//取消编辑
- (void)allViewCancelEditBtnAction:(UIButton *)cancelEditBtn{
    
    _addBtn.hidden = YES;
    _scanBtn.hidden = YES;
    _timeBtn.hidden = YES;
    
    _bottomview.hidden = YES;
    _checkAllBtn.hidden = YES;
    _savebottomBtn.hidden = YES;
    
    _editSureView.hidden = NO;
    _editBtn.hidden = NO;
    _sureBtn.hidden = NO;
    _deleteBtn.hidden = NO;
    
    _allView.hidden = YES;
    _cancelEditBtn.hidden = YES;
    _checkcancelAllBtn.hidden = YES;
    _saveBtn.hidden = YES;
    
    _cancelBtn.hidden = YES;

    
    _rightBtn.hidden = YES;
    self.btnType = @"save";
    [self.allArray removeAllObjects];
    
    [self reloadOldSaveNewData];
    
}

//修改的查看全部，和当前
- (void)allViewcheckCancelAllBtnAction:(UIButton *)checkcancelAllBtn{
    if ([self testingDataComplete]) {
        checkcancelAllBtn.selected = !checkcancelAllBtn.selected;
        if (checkcancelAllBtn.selected) {
            // self.btnType = @"checkAll";
            self.secondBtnType = @"checkAll";
            _rightBtn.hidden = YES;
            [self.allArray addObjectsFromArray:self.dataArray];
            [self.dataArray removeAllObjects];
            [checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1A63CE"]];
        }else{
            // self.btnType = @"thisCheck";
            self.secondBtnType = @"thisCheck";
            _rightBtn.hidden = YES;
            [checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        }
        [self.tableview reloadData];
    }else{
        [SVProgressHUD showInfoWithStatus:@"数据不完整"];
    }
}


//修改保存
- (void)allViewchecksaveBtnAction:(UIButton *)saveBtn{
    if (self.dataArray.count > 0) {
        if ([self testingDataComplete]) {
            [self.allArray addObjectsFromArray:self.dataArray];
            self.btnType = @"save";
            _rightBtn.hidden = YES;
            [self modifyAndSaveNewData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"数据不完整"];
        }
    }else if(self.allArray.count > 0){
        self.btnType = @"save";
        _rightBtn.hidden = YES;
        [self modifyAndSaveNewData];
    }else{
        [SVProgressHUD showInfoWithStatus:@"数据不完整"];
    }
//    if (self.dataArray.count < 1) {
//        [_modelTextfield resignFirstResponder];
//        self.btnType = @"save";
//        [self modifyAndSaveNewData];
//    }else{
//        if ([self testingDataComplete]) {
//            [self.allArray addObjectsFromArray:self.dataArray];
//            self.btnType = @"save";
//            [self modifyAndSaveNewData];
//        }else{
//            [SVProgressHUD showInfoWithStatus:@"数据不完整"];
//        }
//    }
}

//取消入库
- (void)cancelBtnAction:(UIButton *)cancelBtn{
    self.btnType = @"save";
     _rightBtn.hidden = YES;
    //URL_UNCONFIRMBILL_IOS
    [self cancelStorageBillNewData];
}

//FIXME:点击扫描
- (void)scanPurchaseAction:(UIButton *)scanBtn{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSInteger SL = [[user objectForKey:@"SL"] integerValue];
    //&& SL != nil
    if (self.templateArray.count > 0 ) {
         if (![_warehouseDetailLabel.text isEqualToString:@"请选择仓库"]) {
             //这边要判断数据是否完整性
            // [_modelTextfield resignFirstResponder];
             
             _rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
             [self.saveAlertView closeView];
             //荒料入库
             if (self.dataArray.count < 1) {
                 MADCameraCaptureController *vc = [[MADCameraCaptureController alloc] init];
                 vc.selectType = self.selectType;
                 
                // vc.modelId = templatemodel.tempID;
                 vc.modelId = SL;
                 vc.templateArray = self.templateArray;
                 [self.navigationController pushViewController:vc animated:YES];
//                 if (![_modelTextfield.text isEqualToString:@""]) {
//                     vc.modelId = [_modelTextfield.text integerValue];
//                 }else{
//                     vc.modelId = 0;
//                 }
                 RSWeakself
                 vc.scanHuangLuSuccess = ^(NSArray *array) {
                      [weakSelf.dataArray removeAllObjects];
                     [SVProgressHUD dismiss];
                     if ([self.showType isEqualToString:@"new"]) {
                         
                         _rightBtn.hidden = NO;
                         //self.btnType = @"thisCheck";
                         self.secondBtnType = @"thisCheck";
                         //[_checkAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                         [_checkAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
                     }else{
                         //self.btnType = @"thisCheck";
                         _rightBtn.hidden = NO;
                         self.secondBtnType = @"thisCheck";
                         [_checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                         _checkcancelAllBtn.selected = NO;
                     }
                     RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:MATERIALSQL];
                     //self.dataArray = [db searchNameContent:array];
                     NSMutableArray * tempArray = [db searchSLNameContent:array];
                     self.dataArray = [self changeArrayRule:tempArray];
                     [self.tableview reloadData];
                 };
             }else{
                 if ([self testingDataComplete]) {
                     //成功
                     [self.allArray addObjectsFromArray:self.dataArray];
                     MADCameraCaptureController *vc = [[MADCameraCaptureController alloc] init];
                     vc.selectType = self.selectType;
                     //RSTemplateModel * templatemodel = self.templateArray[0];
                     vc.modelId = SL;
                     vc.templateArray = self.templateArray;
                     [self.navigationController pushViewController:vc animated:YES];
//                     if (![_modelTextfield.text isEqualToString:@""]) {
//                         vc.modelId = [_modelTextfield.text integerValue];
//                     }else{
//                         vc.modelId = 0;
//                     }
                     RSWeakself
                     vc.scanHuangLuSuccess = ^(NSArray *array) {
                         [weakSelf.dataArray removeAllObjects];
                         [SVProgressHUD dismiss];
                         if ([self.showType isEqualToString:@"new"]) {
                             // self.btnType = @"thisCheck";
                             
                             _rightBtn.hidden = NO;
                             
                             self.secondBtnType = @"thisCheck";
                             //[_checkAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                             [_checkAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
                         }else{
                             //self.btnType = @"thisCheck";
                             _rightBtn.hidden = NO;
                             
                             self.secondBtnType = @"thisCheck";
                             [_checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                             _checkcancelAllBtn.selected = NO;
                         }
                         RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:MATERIALSQL];
                         // self.dataArray = [db searchNameContent:array];
                         //这边要去对数据库之后在进行数组的结构的变化，相同的弄在一个数组
                         NSMutableArray * tempArray = [db searchSLNameContent:array];
                         self.dataArray = [self changeArrayRule:tempArray];
                         [self.tableview reloadData];
                     };
                 }else{
                     //不成功
                     [SVProgressHUD showInfoWithStatus:@"数据不完整"];
                 }
             }
         }else{
             [SVProgressHUD showInfoWithStatus:@"请先选择仓库"];
         }
     }else{
         [SVProgressHUD showInfoWithStatus:@"您当前暂无可用模板，请添加模板并审核通过后再进行扫描入库"];
     }
}


//新建的查看全部和本次扫描
- (void)checkAllAndScanAction:(UIButton *)checkAllBtn{
    if ([checkAllBtn.currentTitle isEqualToString:@"查看全部"]) {
         _rightBtn.hidden = YES;
        //查看全部
        [self.allArray addObjectsFromArray:self.dataArray];
        [self.dataArray removeAllObjects];
        [checkAllBtn setTitle:@"本次扫描" forState:UIControlStateNormal];
        //self.btnType = @"checkAll";
        self.secondBtnType = @"checkAll";
    }else{
        //本地扫描
        //self.btnType = @"thisCheck";
        _rightBtn.hidden = YES;
        self.secondBtnType = @"thisCheck";
        [checkAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    }
    [self.tableview reloadData];
}

- (NSMutableArray *)changeArrayRule:(NSArray *)contentarray{
    NSMutableArray *dateMutablearray = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray arrayWithArray:contentarray];
    for (int i = 0; i < array.count; i ++) {
        RSSLStoragemanagementModel * slstoragemanagementmodel = array[i];
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObject:slstoragemanagementmodel];
        for (int j = i+1;j < array.count; j ++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel1 = array[j];
            if([slstoragemanagementmodel1.mtlName isEqualToString:slstoragemanagementmodel.mtlName] && [slstoragemanagementmodel1.turnsNo isEqualToString:slstoragemanagementmodel.turnsNo] && [slstoragemanagementmodel1.blockNo isEqualToString:slstoragemanagementmodel.blockNo]){
                [tempArray addObject:slstoragemanagementmodel1];
                [array removeObjectAtIndex:j];
                j = j - 1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    return dateMutablearray;
}

//判断完整性
- (BOOL)testingDataComplete{
    //荒料里面需要原始 平方数/立方数dedVaqty没有匝号和板号，原始 平方数/立方数也不需要 preVaqty,大板有匝号和板号原始 平方数/立方数需要 preVaqty但是不要// 原始 平方数/立方数dedVaqty
    //NSMutableArray * array = self.dataArray[section];
   // RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
    //|| [slstoragemanagementmodel.dedArea doubleValue] <= 0.000
    for (int i = 0; i < self.dataArray.count; i++) {
        NSMutableArray * array = self.dataArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
            if ([slstoragemanagementmodel.mtlName isEqualToString:@""] || [slstoragemanagementmodel.mtltypeName isEqualToString:@""] || [slstoragemanagementmodel.turnsNo isEqualToString:@""] || [slstoragemanagementmodel.slNo isEqualToString:@""] || [slstoragemanagementmodel.preArea doubleValue] <= 0.000  ||
                [slstoragemanagementmodel.area doubleValue] <= 0.000 ||
                [slstoragemanagementmodel.blockNo isEqualToString:@""] ||  [slstoragemanagementmodel.length doubleValue] <= 0.000 ||  [slstoragemanagementmodel.width doubleValue]<= 0.000 || [slstoragemanagementmodel.height doubleValue]<= 0.000 || slstoragemanagementmodel.qty < 1 ) {
                return NO;
            }
        }
    }
    return YES;
}





//这边是合计的按键
- (void)openAndCloseAction:(UIButton *)rightPictureBtn{
    rightPictureBtn.selected = !rightPictureBtn.selected;
    if (rightPictureBtn.selected) {
        self.saveAlertView.selectFunctionType = self.selectFunctionType;
        self.saveAlertView.selectType = self.selectType;
        //NSInteger totalNumber = 0;
//        //原始面积
//        NSDecimalNumber * totalPreArea;
//        //扣尺面积
//        NSDecimalNumber * totalDedArea;
//        //实际面积
//        NSDecimalNumber * totalArea;

        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            
            NSInteger totalNumber = 0;
            NSInteger totalTurnsQty = 0;
            // NSDecimalNumber * totalArea;
            // NSDecimalNumber * totalPreArea;
            // NSDecimalNumber * totalDedArea;
            double newPreArea = 0.0;
            double newArea = 0.0;
            double newDedArea = 0.0;
//            double newPreArea =0.0;
//            double newDedArea = 0.0;
//            double newArea = 0.0;
            for (int i = 0 ; i < self.allArray.count; i++) {
                NSMutableArray * array = self.allArray[i];
                for (int j = 0; j < array.count; j++) {
                    RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                    newPreArea += [slstoragemanagementmodel.preArea doubleValue];
                    totalNumber += slstoragemanagementmodel.qty;
                    newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
                    newArea += [slstoragemanagementmodel.area doubleValue];
                }
            }
            
             totalTurnsQty = self.allArray.count;
//            totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
//            totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
//            totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
            self.saveAlertView.totalNumber = [NSString stringWithFormat:@"%ld",(long)totalNumber];
            self.saveAlertView.totalWeight = [NSString stringWithFormat:@"%ld",(long)totalTurnsQty];
            
            self.saveAlertView.totalPreArea = [self number:newPreArea preciseDecimal:3];
            //[NSString stringWithFormat:@"%@",totalPreArea];
            
            self.saveAlertView.totalDedArea = [self number:newDedArea preciseDecimal:3];
            //[NSString stringWithFormat:@"%@",totalDedArea];
            
            self.saveAlertView.totalArea = [self number:newArea preciseDecimal:3];
            
        }else{
            
            
            NSInteger totalNumber = 0;
            NSInteger totalTurnsQty = 0;
            // NSDecimalNumber * totalArea;
            // NSDecimalNumber * totalPreArea;
            // NSDecimalNumber * totalDedArea;
            double newPreArea = 0.0;
            double newArea = 0.0;
            double newDedArea = 0.0;
            for (int i = 0 ; i < self.dataArray.count; i++) {
                NSMutableArray * array = self.dataArray[i];
                for (int j = 0; j < array.count; j++) {
                    RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
                    newPreArea += [slstoragemanagementmodel.preArea doubleValue];
                    totalNumber += slstoragemanagementmodel.qty;
                    newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
                    newArea += [slstoragemanagementmodel.area doubleValue];
                }
            }
             totalTurnsQty = self.dataArray.count;
            self.saveAlertView.totalNumber = [NSString stringWithFormat:@"%ld",(long)totalNumber];
            self.saveAlertView.totalWeight = [NSString stringWithFormat:@"%ld",(long)totalTurnsQty];
            
            self.saveAlertView.totalPreArea = [self number:newPreArea preciseDecimal:3];
            //[NSString stringWithFormat:@"%@",totalPreArea];
            
            self.saveAlertView.totalDedArea = [self number:newDedArea preciseDecimal:3];
            //[NSString stringWithFormat:@"%@",totalDedArea];
            
            self.saveAlertView.totalArea = [self number:newArea preciseDecimal:3];
//            totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
//            totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
//            totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
        }
        
        
        
        
//        self.saveAlertView.totalNumber = [NSString stringWithFormat:@"%0.3lf",[totalPreArea doubleValue]];
//        self.saveAlertView.totalArea = [NSString stringWithFormat:@"%0.3lf",[totalDedArea doubleValue]];
//        self.saveAlertView.totalWeight = [NSString stringWithFormat:@"%0.3lf",[totalArea doubleValue]];
        
        [self.saveAlertView showView];
        rightPictureBtn.frame = CGRectMake(0, SCH - 86 - 168, SCW, 36);
    }else{
        rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
        [self.saveAlertView closeView];
    }
}



- (NSString *)number:(double)x preciseDecimal:(NSUInteger)p {
    //    四舍五入
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:p raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:x];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    //    生成需要精确的小数点格式，
    //    比如精确到小数点第3位，格式为“0.000”；精确到小数点第4位，格式为“0.0000”；
    //    也就是说精确到第几位，小数点后面就有几个“0”
    NSMutableString *formatterString = [NSMutableString stringWithString:@"0."];
    for (NSInteger i = 0; i < p; ++i) {
        [formatterString appendString:@"0"];
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //    设置生成好的格式，
    [formatter setPositiveFormat:formatterString];
    //    然后把这个number 对象格式化成我们需要的格式，
    //    最后以string 类型返回结果。
    return [formatter stringFromNumber:roundedOunces];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.showType isEqualToString:@"new"]) {
        //        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            return self.allArray.count;
        }else{
            return self.dataArray.count;
        }
        //新建
    }else{
        //加载
        //        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            return self.allArray.count;
        }else{
            return self.dataArray.count;
        }
    }
   // return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 108;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([self.showType isEqualToString:@"new"]) {
        //        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            //return self.allArray.count;
            NSMutableArray * array = self.allArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if (slstoragemanagementmodel.isbool) {
                return 10;
            }else{
                return 0.001;
            }
        }else{
            NSMutableArray * array = self.dataArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if (slstoragemanagementmodel.isbool) {
                return 10;
            }else{
                return 0.001;
            }
        }
        //新建
    }else{
        //加载
        //        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
           // return self.allArray.count;
            NSMutableArray * array = self.allArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if (slstoragemanagementmodel.isbool) {
                return 10;
            }else{
                return 0.001;
            }
        }else{
            NSMutableArray * array = self.dataArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if (slstoragemanagementmodel.isbool) {
                return 10;
            }else{
                return 0.001;
            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    RSDabanPurchaseFootView * dabanPurchaseFootView = [[RSDabanPurchaseFootView alloc]initWithReuseIdentifier:DABANPURCHASEFOOTVIEW];
    if ([self.showType isEqualToString:@"new"]) {
        //        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            //return self.allArray.count;
           
            NSMutableArray * array = self.allArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            dabanPurchaseFootView.slstoragemanagementmodel = slstoragemanagementmodel;
            
        }else{
            NSMutableArray * array = self.dataArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            dabanPurchaseFootView.slstoragemanagementmodel = slstoragemanagementmodel;
        }
        //新建
    }else{
        //加载
        //        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            // return self.allArray.count;
            NSMutableArray * array = self.allArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            dabanPurchaseFootView.slstoragemanagementmodel = slstoragemanagementmodel;
            
        }else{
            NSMutableArray * array = self.dataArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            dabanPurchaseFootView.slstoragemanagementmodel = slstoragemanagementmodel;
        }
    }
    return dabanPurchaseFootView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   // NSMutableArray * array = self.dataArray[section];
   // RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
    RSDabanPurchaseHeaderView * dabanPurchaseHeaderView = [[RSDabanPurchaseHeaderView alloc]initWithReuseIdentifier:DABANPURCHASEHEADERVIEW];
    dabanPurchaseHeaderView.downBtn.tag = section;
    dabanPurchaseHeaderView.productDeleteBtn.tag = section;
    dabanPurchaseHeaderView.productEidtBtn.tag = section;
    if ([self.showType isEqualToString:@"new"]) {
        //        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            //return self.allArray.count;
            
            NSMutableArray * array = self.allArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            dabanPurchaseHeaderView.slstoragemanagementmodel = slstoragemanagementmodel;
            
        }else{
             NSMutableArray * array = self.dataArray[section];
             RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            dabanPurchaseHeaderView.slstoragemanagementmodel = slstoragemanagementmodel;
        }
        //新建
    }else{
        //加载
        //        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            // return self.allArray.count;
            NSMutableArray * array = self.allArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            dabanPurchaseHeaderView.slstoragemanagementmodel = slstoragemanagementmodel;
            
        }else{
            NSMutableArray * array = self.dataArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            dabanPurchaseHeaderView.slstoragemanagementmodel = slstoragemanagementmodel;
        }
    }
    //展开和关闭
    [dabanPurchaseHeaderView.downBtn addTarget:self action:@selector(showAndHideDabanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    //编辑
    [dabanPurchaseHeaderView.productEidtBtn addTarget:self action:@selector(dabanPurchAseProductEidtAction:) forControlEvents:UIControlEventTouchUpInside];
    //删除
    [dabanPurchaseHeaderView.productDeleteBtn addTarget:self action:@selector(dabanPurchAseProductdDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.btnType isEqualToString:@"edit"] ) {
        dabanPurchaseHeaderView.productEidtBtn.enabled = YES;
        dabanPurchaseHeaderView.productDeleteBtn.enabled = YES;
        dabanPurchaseHeaderView.productDeleteBtn.hidden = NO;
        dabanPurchaseHeaderView.productEidtBtn.hidden = NO;
    }
    else{
        dabanPurchaseHeaderView.productDeleteBtn.enabled = NO;
        dabanPurchaseHeaderView.productDeleteBtn.hidden = YES;
        dabanPurchaseHeaderView.productEidtBtn.hidden = YES;
        dabanPurchaseHeaderView.productEidtBtn.enabled = NO;
    }
    return dabanPurchaseHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.showType isEqualToString:@"new"]) {
        //        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            //return self.allArray.count;
            NSMutableArray * array = self.allArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if (slstoragemanagementmodel.isbool) {
                return array.count;
            }else{
                return 0;
            }
        }else{
            NSMutableArray * array = self.dataArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if (slstoragemanagementmodel.isbool) {
                return array.count;
            }else{
                return 0;
            }
        }
        //新建
    }else{
        //加载
        //        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            // return self.allArray.count;
            NSMutableArray * array = self.allArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if (slstoragemanagementmodel.isbool) {
                return array.count;
            }else{
                return 0;
            }
        }else{
            NSMutableArray * array = self.dataArray[section];
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[0];
            if (slstoragemanagementmodel.isbool) {
                return array.count;
            }else{
                return 0;
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.showType isEqualToString:@"new"]) {
        //新建
        NSString *identifier = [NSString stringWithFormat:@"DABANPURCHASECELLID%ld%ld",(long)indexPath.section,(long)indexPath.row];
        //static NSString * DABANPURCHASECELLID = @"DABANPURCHASECELLID";
        RSDabanPurchaseCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[RSDabanPurchaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        cell.indexPath = indexPath;
        if ([self.btnType isEqualToString:@"edit"]) {
            cell.mainScrollView.userInteractionEnabled = YES;
        }else{
            cell.mainScrollView.userInteractionEnabled = NO;
        }
        
          if ([self.secondBtnType isEqualToString:@"checkAll"]) {
              
              NSMutableArray * array = self.allArray[indexPath.section];
              RSSLStoragemanagementModel * slstoragemanagementmodel = array[indexPath.row];
              
              cell.filmNumberLabel.text = [NSString stringWithFormat:@"%@",slstoragemanagementmodel.slNo];
              
              cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]];
              
              CGSize  size1 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]] andFont:[UIFont systemFontOfSize:14]];
              cell.longDetailLabel.sd_layout
              .widthIs(size1.width);
              
              
              cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]];
              
              CGSize size2 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]] andFont:[UIFont systemFontOfSize:14]];
              cell.wideDetialLabel.sd_layout
              .widthIs(size2.width);
              
              
              cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]];
              
              CGSize size3 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]] andFont:[UIFont systemFontOfSize:14]];
              cell.thickDeitalLabel.sd_layout
              .widthIs(size3.width);
              
            
              
              
              cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]];
              CGSize size5 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
              cell.deductionAreaDetailLabel.sd_layout
              .widthIs(size5.width);
              
              
              cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]];
              CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] andFont:[UIFont systemFontOfSize:14]];
              cell.actualAreaDetailLabel.sd_layout
              .widthIs(size6.width);
              
              
              
              RSWeakself
              cell.deleteAction = ^(NSIndexPath *indexPath) {
                  UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料信息吗?" preferredStyle:UIAlertControllerStyleAlert];
                  UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      NSMutableArray * array = weakSelf.allArray[indexPath.section];
                      //RSSLStoragemanagementModel * slstoragemanagementmodel = array[indexPath.row];
                      [array removeObjectAtIndex:indexPath.row];
                      if (array.count < 1) {
                          [weakSelf.allArray removeObjectAtIndex:indexPath.section];
                      }
                      
                      RSDabanPurchaseCell * cell1 = [weakSelf.tableview cellForRowAtIndexPath:indexPath];
                      [cell1.mainScrollView setContentOffset:CGPointMake(0, 0)];
                      [weakSelf.tableview reloadData];

                  }];
                  [alertView addAction:alert];
                  UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  }];
                  [alertView addAction:alert1];
                  if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                      
                      alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                  }
                  [weakSelf presentViewController:alertView animated:YES completion:nil];
                  
              
              
              };
              cell.scrollAction = ^{
                  for (RSDabanPurchaseCell * tableViewCell in weakSelf.tableview.visibleCells) {
                      /// 当屏幕滑动时，关闭不是当前滑动的cell
                      if (tableViewCell.isOpen == YES && tableViewCell != cell) {
                          [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                      }
                  }
              };
          }else{
              NSMutableArray * array = self.dataArray[indexPath.section];
              RSSLStoragemanagementModel * slstoragemanagementmodel = array[indexPath.row];
              cell.filmNumberLabel.text = [NSString stringWithFormat:@"%@",slstoragemanagementmodel.slNo];
              if ([slstoragemanagementmodel.slNo isEqualToString:@""]) {
                  cell.filmNumberLabel.textColor = [UIColor redColor];
              }else{
                  cell.filmNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
              }
              
              cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]];
              CGSize  size1 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]] andFont:[UIFont systemFontOfSize:14]];
              cell.longDetailLabel.sd_layout
              .widthIs(size1.width);
              
              if ([slstoragemanagementmodel.length doubleValue] <= 0.000) {
                  cell.longDetailLabel.textColor = [UIColor redColor];
              }else{
                  cell.longDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
              }
              
              cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]];
              
              CGSize size2 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]] andFont:[UIFont systemFontOfSize:14]];
              cell.wideDetialLabel.sd_layout
              .widthIs(size2.width);
              
              if ([slstoragemanagementmodel.width doubleValue] <= 0.000) {
                  cell.wideDetialLabel.textColor = [UIColor redColor];
              }else{
                  cell.wideDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
              }
              
              
              
              cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]];
              
              CGSize size3 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]] andFont:[UIFont systemFontOfSize:14]];
              cell.thickDeitalLabel.sd_layout
              .widthIs(size3.width);
              
              
              if ([slstoragemanagementmodel.height doubleValue] <= 0.000) {
                  cell.thickDeitalLabel.textColor = [UIColor redColor];
              }else{
                  cell.thickDeitalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
              }
              
              
              cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]];
              CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
              cell.originalAreaDetailLabel.sd_layout
              .widthIs(size4.width);
              
             
              
              
 
              cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]];
              CGSize size5 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
              cell.deductionAreaDetailLabel.sd_layout
              .widthIs(size5.width);
              
              
//              if ([slstoragemanagementmodel.dedArea doubleValue] <= 0.000) {
//                  cell.deductionAreaDetailLabel.textColor = [UIColor redColor];
//              }else{
                  cell.deductionAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//              }
              
              
              cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]];
              CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] andFont:[UIFont systemFontOfSize:14]];
              cell.actualAreaDetailLabel.sd_layout
              .widthIs(size6.width);
              
              
              if ([slstoragemanagementmodel.area doubleValue] <= 0.000) {
                  cell.actualAreaDetailLabel.textColor = [UIColor redColor];
              }else{
                  cell.actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
              }
              
              if ([slstoragemanagementmodel.preArea doubleValue]  >= 0.001) {
                  
                  
                  cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]];
                  CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
                  cell.originalAreaDetailLabel.sd_layout
                  .widthIs(size4.width);
                  
                  if ([slstoragemanagementmodel.preArea doubleValue] <= 0.000) {
                      cell.originalAreaDetailLabel.textColor = [UIColor redColor];
                  }else{
                      cell.originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                  }
                
                  
              }else{
                  
                  
                  cell.originalAreaDetailLabel.text = [self calculateByMultiplying:slstoragemanagementmodel.length secondNumber:slstoragemanagementmodel.width];
                  slstoragemanagementmodel.preArea = [NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
                  CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
                  
                  cell.originalAreaDetailLabel.sd_layout
                  .widthIs(size4.width);
                  if ([slstoragemanagementmodel.preArea doubleValue] <= 0.000) {
                      cell.originalAreaDetailLabel.textColor = [UIColor redColor];
                  }else{
                      cell.originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                  }
              }
              
              
              
              if ([slstoragemanagementmodel.area doubleValue] >= 0.001) {
                  cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]];
                  CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] andFont:[UIFont systemFontOfSize:14]];
                  cell.actualAreaDetailLabel.sd_layout
                  .widthIs(size6.width);
                  
                  if ([slstoragemanagementmodel.area doubleValue] <= 0.000) {
                      cell.actualAreaDetailLabel.textColor = [UIColor redColor];
                  }else{
                      cell.actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                  }
              }else{
                  cell.actualAreaDetailLabel.text = [self calculateDecimalByMultiplying:slstoragemanagementmodel.preArea secondNumber:slstoragemanagementmodel.dedArea];
                  
                  slstoragemanagementmodel.area = [NSDecimalNumber decimalNumberWithString:cell.actualAreaDetailLabel.text];
                  
                  CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] andFont:[UIFont systemFontOfSize:14]];
                  cell.actualAreaDetailLabel.sd_layout
                  .widthIs(size6.width);
                  if ([slstoragemanagementmodel.area doubleValue] <= 0.000) {
                      cell.actualAreaDetailLabel.textColor = [UIColor redColor];
                  }else{
                      cell.actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                  }
                  
                  
            
              }
              RSWeakself
              cell.deleteAction = ^(NSIndexPath *indexPath) {
                  
                  UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料信息吗?" preferredStyle:UIAlertControllerStyleAlert];
                  UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      NSMutableArray * array = weakSelf.dataArray[indexPath.section];
                      //RSSLStoragemanagementModel * slstoragemanagementmodel = array[indexPath.row];
                      [array removeObjectAtIndex:indexPath.row];
                      if (array.count < 1) {
                          [weakSelf.dataArray removeObjectAtIndex:indexPath.section];
                      }
                      RSDabanPurchaseCell * cell1 = [weakSelf.tableview cellForRowAtIndexPath:indexPath];
                      [cell1.mainScrollView setContentOffset:CGPointMake(0, 0)];
                      [weakSelf.tableview reloadData];
                  
                  }];
                  [alertView addAction:alert];
                  UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  }];
                  [alertView addAction:alert1];
                  if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                      
                      alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                  }
                  [weakSelf presentViewController:alertView animated:YES completion:nil];
                  
              };
              cell.scrollAction = ^{
                  for (RSDabanPurchaseCell * tableViewCell in weakSelf.tableview.visibleCells) {
                      /// 当屏幕滑动时，关闭不是当前滑动的cell
                      if (tableViewCell.isOpen == YES && tableViewCell != cell) {
                          [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                      }
                  }
              };
          }
        return cell;
    }else{
       //加载
        NSString *identifier = [NSString stringWithFormat:@"DABANPURCHASECELLSECONDID%ld%ld",(long)indexPath.section,(long)indexPath.row];
        //static NSString * DABANPURCHASECELLID = @"DABANPURCHASECELLID";
        RSDabanPurchaseCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[RSDabanPurchaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        cell.indexPath = indexPath;
        
        if ([self.btnType isEqualToString:@"edit"]) {
            
            cell.mainScrollView.userInteractionEnabled = YES;
        }else{
            cell.mainScrollView.userInteractionEnabled = NO;
        }
         if ([self.secondBtnType isEqualToString:@"checkAll"]) {
             
             NSMutableArray * array = self.allArray[indexPath.section];
             RSSLStoragemanagementModel * slstoragemanagementmodel = array[indexPath.row];
             
             cell.filmNumberLabel.text = [NSString stringWithFormat:@"%@",slstoragemanagementmodel.slNo];
             
             cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]];
             
             CGSize  size1 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]] andFont:[UIFont systemFontOfSize:14]];
             cell.longDetailLabel.sd_layout
             .widthIs(size1.width);
             
             
             cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]];
             
             CGSize size2 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]] andFont:[UIFont systemFontOfSize:14]];
             cell.wideDetialLabel.sd_layout
             .widthIs(size2.width);
             
             
             cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]];
             
             CGSize size3 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]] andFont:[UIFont systemFontOfSize:14]];
             cell.thickDeitalLabel.sd_layout
             .widthIs(size3.width);
             
             cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]];
             CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
             cell.originalAreaDetailLabel.sd_layout
             .widthIs(size4.width);
             
             
             
             cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]];
             CGSize size5 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
             cell.deductionAreaDetailLabel.sd_layout
             .widthIs(size5.width);
             
             
             cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]];
             CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] andFont:[UIFont systemFontOfSize:14]];
             cell.actualAreaDetailLabel.sd_layout
             .widthIs(size6.width);
             
//             if ([slstoragemanagementmodel.preArea doubleValue] <= 0.000) {
//                 cell.originalAreaDetailLabel.text = [self calculateByMultiplying:slstoragemanagementmodel.length secondNumber:slstoragemanagementmodel.width];
//             }
//
             RSWeakself
             cell.deleteAction = ^(NSIndexPath *indexPath) {
                 UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料信息吗?" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     NSMutableArray * array = weakSelf.allArray[indexPath.section];
                     //RSSLStoragemanagementModel * slstoragemanagementmodel = array[indexPath.row];
                     [array removeObjectAtIndex:indexPath.row];
                     if (array.count < 1) {
                         [weakSelf.allArray removeObjectAtIndex:indexPath.section];
                     }
                     RSDabanPurchaseCell * cell1 = [weakSelf.tableview cellForRowAtIndexPath:indexPath];
                     [cell1.mainScrollView setContentOffset:CGPointMake(0, 0)];
                     [weakSelf.tableview reloadData];
                 }];
                 [alertView addAction:alert];
                 UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 }];
                 [alertView addAction:alert1];
                 if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                     
                     alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                 }
                 [weakSelf presentViewController:alertView animated:YES completion:nil];
                 
               
             };
             cell.scrollAction = ^{
                 for (RSDabanPurchaseCell * tableViewCell in weakSelf.tableview.visibleCells) {
                     /// 当屏幕滑动时，关闭不是当前滑动的cell
                     if (tableViewCell.isOpen == YES && tableViewCell != cell) {
                         [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                     }
                 }
             };
             
         }else{
             NSMutableArray * array = self.dataArray[indexPath.section];
             RSSLStoragemanagementModel * slstoragemanagementmodel = array[indexPath.row];
             
             cell.filmNumberLabel.text = [NSString stringWithFormat:@"%@",slstoragemanagementmodel.slNo];
             
             if ([slstoragemanagementmodel.slNo isEqualToString:@""]) {
                 cell.filmNumberLabel.textColor = [UIColor redColor];
             }else{
                 cell.filmNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
             }
 
             cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]];
             CGSize  size1 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.length doubleValue]] andFont:[UIFont systemFontOfSize:14]];
             cell.longDetailLabel.sd_layout
             .widthIs(size1.width);
             
             if ([slstoragemanagementmodel.length doubleValue] <= 0.000) {
                 cell.longDetailLabel.textColor = [UIColor redColor];
             }else{
                 cell.longDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
             }
             
             cell.wideDetialLabel.text = [NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]];
             CGSize size2 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.1lf",[slstoragemanagementmodel.width doubleValue]] andFont:[UIFont systemFontOfSize:14]];
             cell.wideDetialLabel.sd_layout
             .widthIs(size2.width);
             
             if ([slstoragemanagementmodel.width doubleValue] <= 0.000) {
                 cell.wideDetialLabel.textColor = [UIColor redColor];
             }else{
                 cell.wideDetialLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
             }
             
             
             cell.thickDeitalLabel.text = [NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]];
             CGSize size3 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.2lf",[slstoragemanagementmodel.height doubleValue]] andFont:[UIFont systemFontOfSize:14]];
             cell.thickDeitalLabel.sd_layout
             .widthIs(size3.width);
             
             if ([slstoragemanagementmodel.height doubleValue] <= 0.000) {
                 cell.thickDeitalLabel.textColor = [UIColor redColor];
             }else{
                 cell.thickDeitalLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
             }
             
             
             
             cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]];
             CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
             cell.originalAreaDetailLabel.sd_layout
             .widthIs(size4.width);
//             if ([slstoragemanagementmodel.preArea doubleValue] <= 0.000) {
//                 cell.originalAreaDetailLabel.textColor = [UIColor redColor];
//             }else{
//                 cell.originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//             }
             cell.deductionAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]];
             CGSize size5 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.dedArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
             cell.deductionAreaDetailLabel.sd_layout
             .widthIs(size5.width);
//             if ([slstoragemanagementmodel.dedArea doubleValue] <= 0.000) {
//                 cell.deductionAreaDetailLabel.textColor = [UIColor redColor];
//             }else{
                 cell.deductionAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//             }
             if ([slstoragemanagementmodel.preArea doubleValue] >= 0.001) {
                 
                 cell.originalAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]];
                 CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
                 cell.originalAreaDetailLabel.sd_layout
                 .widthIs(size4.width);
                 
                 if ([slstoragemanagementmodel.preArea doubleValue] <= 0.000) {
                     cell.originalAreaDetailLabel.textColor = [UIColor redColor];
                 }else{
                     cell.originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                 }
             }else{
                 cell.originalAreaDetailLabel.text = [self calculateByMultiplying:slstoragemanagementmodel.length secondNumber:slstoragemanagementmodel.width];
                 slstoragemanagementmodel.preArea = [NSDecimalNumber decimalNumberWithString:cell.originalAreaDetailLabel.text];
                 CGSize size4 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.preArea doubleValue]] andFont:[UIFont systemFontOfSize:14]];
                 cell.originalAreaDetailLabel.sd_layout
                 .widthIs(size4.width);
                 
                 if ([slstoragemanagementmodel.preArea doubleValue] <= 0.000) {
                     cell.originalAreaDetailLabel.textColor = [UIColor redColor];
                 }else{
                     cell.originalAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                 }
             }
             if ([slstoragemanagementmodel.area doubleValue] >= 0.001) {
                 cell.actualAreaDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]];
                 CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] andFont:[UIFont systemFontOfSize:14]];
                 cell.actualAreaDetailLabel.sd_layout
                 .widthIs(size6.width);
                 
                 if ([slstoragemanagementmodel.area doubleValue] <= 0.000) {
                     cell.actualAreaDetailLabel.textColor = [UIColor redColor];
                 }else{
                     cell.actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                 }
               
             }else{
                 
                 
                 cell.actualAreaDetailLabel.text = cell.actualAreaDetailLabel.text = [self calculateDecimalByMultiplying:slstoragemanagementmodel.preArea secondNumber:slstoragemanagementmodel.dedArea];
                 slstoragemanagementmodel.area = [NSDecimalNumber decimalNumberWithString:cell.actualAreaDetailLabel.text];
                 CGSize size6 = [self obtainLabelTextSize:[NSString stringWithFormat:@"%0.3lf",[slstoragemanagementmodel.area doubleValue]] andFont:[UIFont systemFontOfSize:14]];
                 cell.actualAreaDetailLabel.sd_layout
                 .widthIs(size6.width);
                 if ([cell.actualAreaDetailLabel.text doubleValue] <= 0.000) {
                     cell.actualAreaDetailLabel.textColor = [UIColor redColor];
                 }else{
                     cell.actualAreaDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                 }
             }
             RSWeakself
             cell.deleteAction = ^(NSIndexPath *indexPath) {
                 UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该物料信息吗?" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     NSMutableArray * array = weakSelf.dataArray[indexPath.section];
                     [array removeObjectAtIndex:indexPath.row];
                     if (array.count < 1) {
                         [weakSelf.dataArray removeObjectAtIndex:indexPath.section];
                     }
                     RSDabanPurchaseCell * cell1 = [weakSelf.tableview cellForRowAtIndexPath:indexPath];
                     [cell1.mainScrollView setContentOffset:CGPointMake(0, 0)];
                     [weakSelf.tableview reloadData];
                 }];
                 [alertView addAction:alert];
                 UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 }];
                 [alertView addAction:alert1];
                 if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                     
                     alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                 }
                 [weakSelf presentViewController:alertView animated:YES completion:nil];
                 
             };
             cell.scrollAction = ^{
                 for (RSDabanPurchaseCell * tableViewCell in weakSelf.tableview.visibleCells) {
                     /// 当屏幕滑动时，关闭不是当前滑动的cell
                     if (tableViewCell.isOpen == YES && tableViewCell != cell) {
                         [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                     }
                 }
             };
         }
        return cell;
    }
}

- (CGSize)obtainLabelTextSize:(NSString *)text andFont:(UIFont *)font{
    CGSize size = [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil].size;
    return size;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (RSDabanPurchaseCell * tableViewCell in self.tableview.visibleCells) {
        /// 当屏幕滑动时，关闭被打开的cell
        if (tableViewCell.isOpen == YES) {
           [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
     }
}


-(NSString *)calculateDecimalByMultiplying:(NSDecimalNumber *)number1 secondNumber:(NSDecimalNumber *)number2{
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber * multiplyingNum = [number1 decimalNumberBySubtracting:number2 withBehavior:Handler];
    return [multiplyingNum stringValue];
}






-(NSString *)calculateByMultiplying:(NSDecimalNumber *)number1 secondNumber:(NSDecimalNumber *)number2
{
    
    NSDecimalNumberHandler * Handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    //NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    //NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber *multiplyingNum = [number1 decimalNumberByMultiplyingBy:number2];
    // NSDecimalNumber * newNum = [multiplyingNum decimalNumberByMultiplyingBy:num3];
    NSDecimalNumber *num4 = [NSDecimalNumber decimalNumberWithString:@"10000"];
    //NSDecimalNumber * dividingNum = [newNum decimalNumberByDividingBy:num4];
    NSDecimalNumber * dividingNum =[multiplyingNum decimalNumberByDividingBy:num4 withBehavior:Handler];
    return [dividingNum stringValue];
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    _rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
    [self.saveAlertView closeView];
    
}




//展开和关闭
- (void)showAndHideDabanPurchaseAction:(UIButton *)downBtn{
    
    if ([self.secondBtnType isEqualToString:@"checkAll"]) {
        NSMutableArray * array = self.allArray[downBtn.tag];
        downBtn.selected = !downBtn.selected;
        for (int i = 0 ; i < array.count; i++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[i];
            slstoragemanagementmodel.isbool = !slstoragemanagementmodel.isbool;
        }
        //choosingInventorymodel.isBool = !choosingInventorymodel.isBool;
        NSIndexSet * set = [NSIndexSet indexSetWithIndex:downBtn.tag];
        [self.tableview reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    }else{
        NSMutableArray * array = self.dataArray[downBtn.tag];
        downBtn.selected = !downBtn.selected;
        for (int i = 0 ; i < array.count; i++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[i];
            slstoragemanagementmodel.isbool = !slstoragemanagementmodel.isbool;
        }
        //choosingInventorymodel.isBool = !choosingInventorymodel.isBool;
        NSIndexSet * set = [NSIndexSet indexSetWithIndex:downBtn.tag];
        [self.tableview reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)dabanPurchAseProductEidtAction:(UIButton *)productEidtBtn{
    _rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
    [self.saveAlertView closeView];
    if ([self.secondBtnType isEqualToString:@"checkAll"]) {
        RSBigBoardChangeViewController * bigBoardChangeVc = [[RSBigBoardChangeViewController alloc]init];
        bigBoardChangeVc.selectType = self.selectType;
        bigBoardChangeVc.currentTitle = self.selectFunctionType;
        bigBoardChangeVc.title = [NSString stringWithFormat:@"%@",self.selectFunctionType];
        bigBoardChangeVc.index = productEidtBtn.tag;
        bigBoardChangeVc.selectFunctionType = self.selectFunctionType;
        bigBoardChangeVc.usermodel = self.usermodel;
        NSMutableArray * array = self.allArray[productEidtBtn.tag];
        NSMutableArray * tempArray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            RSSLStoragemanagementModel * slstoragemanageementmodel = array[i];
            RSSLStoragemanagementModel * slstoragemanageementmodel1 = [[RSSLStoragemanagementModel alloc]init];
            slstoragemanageementmodel1.billdtlid = slstoragemanageementmodel.billdtlid;
            slstoragemanageementmodel1.billid = slstoragemanageementmodel.billid;
            slstoragemanageementmodel1.blockNo = slstoragemanageementmodel.blockNo;
            slstoragemanageementmodel1.mtlName = slstoragemanageementmodel.mtlName;
            slstoragemanageementmodel1.storeareaId = slstoragemanageementmodel.storeareaId;
            slstoragemanageementmodel1.storeareaName = slstoragemanageementmodel.storeareaName;
            slstoragemanageementmodel1.turnsNo = slstoragemanageementmodel.turnsNo;
            slstoragemanageementmodel1.slNo = slstoragemanageementmodel.slNo;
            
            slstoragemanageementmodel1.mtltypeName = slstoragemanageementmodel.mtltypeName;
            slstoragemanageementmodel1.mtltypeId = slstoragemanageementmodel.mtltypeId;
            slstoragemanageementmodel1.mtlId = slstoragemanageementmodel.mtlId;
            
            slstoragemanageementmodel1.qty = slstoragemanageementmodel.qty;
            slstoragemanageementmodel1.length = slstoragemanageementmodel.length;
            slstoragemanageementmodel1.width = slstoragemanageementmodel.width;
            slstoragemanageementmodel1.height = slstoragemanageementmodel.height;
            slstoragemanageementmodel1.area = slstoragemanageementmodel.area;
            slstoragemanageementmodel1.dedArea = slstoragemanageementmodel.dedArea;
            slstoragemanageementmodel1.preArea = slstoragemanageementmodel.preArea;
            slstoragemanageementmodel1.dedLengthOne = slstoragemanageementmodel.dedLengthOne;
            slstoragemanageementmodel1.dedWidthOne = slstoragemanageementmodel.dedWidthOne;
            slstoragemanageementmodel1.dedLengthTwo = slstoragemanageementmodel.dedLengthTwo;
            slstoragemanageementmodel1.dedWidthTwo = slstoragemanageementmodel.dedWidthTwo;
            slstoragemanageementmodel1.dedLengthThree = slstoragemanageementmodel.dedLengthThree;
            slstoragemanageementmodel1.dedWidthThree = slstoragemanageementmodel.dedWidthThree;
            slstoragemanageementmodel1.dedLengthFour = slstoragemanageementmodel.dedLengthFour;
            slstoragemanageementmodel1.dedWidthFour = slstoragemanageementmodel.dedWidthFour;
            
            slstoragemanageementmodel1.isbool = false;
            [tempArray addObject:slstoragemanageementmodel1];
        }
        bigBoardChangeVc.contentArray = tempArray;
        [self.navigationController pushViewController:bigBoardChangeVc animated:YES];
        bigBoardChangeVc.newSaveData = ^(NSMutableArray * _Nonnull contentArray, NSInteger index) {
            [self.allArray replaceObjectAtIndex:index withObject:contentArray];
            [self.tableview reloadData];
        };
    }else{
        RSBigBoardChangeViewController * bigBoardChangeVc = [[RSBigBoardChangeViewController alloc]init];
        bigBoardChangeVc.selectType = self.selectType;
        bigBoardChangeVc.currentTitle = self.selectFunctionType;
        bigBoardChangeVc.title = [NSString stringWithFormat:@"%@",self.selectFunctionType];
        bigBoardChangeVc.index = productEidtBtn.tag;
        bigBoardChangeVc.selectFunctionType = self.selectFunctionType;
        bigBoardChangeVc.usermodel = self.usermodel;
        NSMutableArray * array = self.dataArray[productEidtBtn.tag];
        //bigBoardChangeVc.contentArray = array;
         NSMutableArray * tempArray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            RSSLStoragemanagementModel * slstoragemanageementmodel = array[i];
            
            RSSLStoragemanagementModel * slstoragemanageementmodel1 = [[RSSLStoragemanagementModel alloc]init];
            slstoragemanageementmodel1.billdtlid = slstoragemanageementmodel.billdtlid;
            slstoragemanageementmodel1.billid = slstoragemanageementmodel.billid;
            slstoragemanageementmodel1.blockNo = slstoragemanageementmodel.blockNo;
            slstoragemanageementmodel1.mtlName = slstoragemanageementmodel.mtlName;
            slstoragemanageementmodel1.storeareaId = slstoragemanageementmodel.storeareaId;
            slstoragemanageementmodel1.storeareaName = slstoragemanageementmodel.storeareaName;
            slstoragemanageementmodel1.turnsNo = slstoragemanageementmodel.turnsNo;
            slstoragemanageementmodel1.slNo = slstoragemanageementmodel.slNo;
           
            slstoragemanageementmodel1.mtltypeName = slstoragemanageementmodel.mtltypeName;
            slstoragemanageementmodel1.mtltypeId = slstoragemanageementmodel.mtltypeId;
            slstoragemanageementmodel1.mtlId = slstoragemanageementmodel.mtlId;
            
            slstoragemanageementmodel1.qty = slstoragemanageementmodel.qty;
            slstoragemanageementmodel1.length = slstoragemanageementmodel.length;
            slstoragemanageementmodel1.width = slstoragemanageementmodel.width;
            slstoragemanageementmodel1.height = slstoragemanageementmodel.height;
            slstoragemanageementmodel1.area = slstoragemanageementmodel.area;
            slstoragemanageementmodel1.dedArea = slstoragemanageementmodel.dedArea;
            
            slstoragemanageementmodel1.preArea = slstoragemanageementmodel.preArea;
            
            slstoragemanageementmodel1.dedLengthOne = slstoragemanageementmodel.dedLengthOne;
            
            slstoragemanageementmodel1.dedWidthOne = slstoragemanageementmodel.dedWidthOne;
            
            
            slstoragemanageementmodel1.dedLengthTwo = slstoragemanageementmodel.dedLengthTwo;
            
            slstoragemanageementmodel1.dedWidthTwo = slstoragemanageementmodel.dedWidthTwo;
            
            
            slstoragemanageementmodel1.dedLengthThree = slstoragemanageementmodel.dedLengthThree;
            
            slstoragemanageementmodel1.dedWidthThree = slstoragemanageementmodel.dedWidthThree;
            
            
            slstoragemanageementmodel1.dedLengthFour = slstoragemanageementmodel.dedLengthFour;
            
            slstoragemanageementmodel1.dedWidthFour = slstoragemanageementmodel.dedWidthFour;
            slstoragemanageementmodel1.isbool = false;
 
            [tempArray addObject:slstoragemanageementmodel1];
        }
        bigBoardChangeVc.contentArray = tempArray;
        [self.navigationController pushViewController:bigBoardChangeVc animated:YES];
        bigBoardChangeVc.newSaveData = ^(NSMutableArray * _Nonnull contentArray, NSInteger index) {
            [self.dataArray replaceObjectAtIndex:index withObject:contentArray];
            [self.tableview reloadData];
        };
    }
}

//大板入库头部删除的方法
- (void)dabanPurchAseProductdDeleteAction:(UIButton *)productDeleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.showType isEqualToString:@"new"]) {
            //新建
            //            if ([self.btnType isEqualToString:@"checkAll"]) {
            if ([self.secondBtnType isEqualToString:@"checkAll"]) {
                [self.allArray removeObjectAtIndex:productDeleteBtn.tag];
            }else{
                [self.dataArray removeObjectAtIndex:productDeleteBtn.tag];
            }
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [self.tableview reloadData];
//            [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }else{
            //加载
            //            if ([self.btnType isEqualToString:@"checkAll"]) {
            if ([self.secondBtnType isEqualToString:@"checkAll"]) {
                [self.allArray removeObjectAtIndex:productDeleteBtn.tag];
            }else{
                [self.dataArray removeObjectAtIndex:productDeleteBtn.tag];
            }
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [self.tableview reloadData];
          //  [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
        }
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


//删除
- (void)deleteSureStorageBillNewData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    if ([self.showType isEqualToString:@"new"]) {
        [phoneDict setObject:[NSNumber numberWithInteger:self.billheadmodel.billid] forKey:@"billid"];
    }else{
        [phoneDict setObject:[NSNumber numberWithInteger:self.personalFunctionmodel.billid] forKey:@"billid"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_DELETEBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            }else{
                
                 _addBtn.hidden = NO;
                 _scanBtn.hidden = NO;
                _timeBtn.hidden = NO;
                
                
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                _editSureView.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _deleteBtn.hidden = NO;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
                 _rightBtn.hidden = YES;

                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
               
            }
        }else{
            _addBtn.hidden = NO;
            _scanBtn.hidden = NO;
            _timeBtn.hidden = NO;
            
            _bottomview.hidden = YES;
            _checkAllBtn.hidden = YES;
            _savebottomBtn.hidden = YES;
            
            _editSureView.hidden = NO;
            _editBtn.hidden = NO;
            _sureBtn.hidden = NO;
            _deleteBtn.hidden = NO;
            
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _checkcancelAllBtn.hidden = YES;
            _saveBtn.hidden = YES;
            
            _cancelBtn.hidden = YES;
            
             _rightBtn.hidden = YES;
           [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


//确认入库
- (void)sureStorageBillNewData{
    // 单据类型    billType    String
    // 单据ID    billid    Int
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    if ([self.showType isEqualToString:@"new"]) {
        [phoneDict setObject:[NSNumber numberWithInteger:self.billheadmodel.billid] forKey:@"billid"];
    }else{
        [phoneDict setObject:[NSNumber numberWithInteger:self.personalFunctionmodel.billid] forKey:@"billid"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_CONFIRMBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.tableview reloadData];
                
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                _editSureView.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _deleteBtn.hidden = YES;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = NO;
                
                _rightBtn.hidden = YES;
               
                //[weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                   [SVProgressHUD showSuccessWithStatus:@"确认入库成功"];
            }else{
                
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                _editSureView.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _deleteBtn.hidden = NO;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
                
                _rightBtn.hidden = YES;
                
                //[SVProgressHUD showErrorWithStatus:@"入库失败"];
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
                
            }
        }else{
            
            _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _timeBtn.hidden = YES;
            
            _bottomview.hidden = YES;
            _checkAllBtn.hidden = YES;
            _savebottomBtn.hidden = YES;
            
            _editSureView.hidden = NO;
            _editBtn.hidden = NO;
            _sureBtn.hidden = NO;
            _deleteBtn.hidden = NO;
            
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _checkcancelAllBtn.hidden = YES;
            _saveBtn.hidden = YES;
            
            _cancelBtn.hidden = YES;
            
            _rightBtn.hidden = YES;
            [SVProgressHUD showErrorWithStatus:@"入库失败"];
        }
    }];
}


//取消入库
- (void)cancelStorageBillNewData{
    // 单据类型    billType    String
    // 单据ID    billid    Int
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    if ([self.showType isEqualToString:@"new"]) {
        [phoneDict setObject:[NSNumber numberWithInteger:self.billheadmodel.billid] forKey:@"billid"];
    }else{
        [phoneDict setObject:[NSNumber numberWithInteger:self.personalFunctionmodel.billid] forKey:@"billid"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_UNCONFIRMBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                _editSureView.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _deleteBtn.hidden = NO;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
                
                _rightBtn.hidden = YES;
 
                [weakSelf.tableview reloadData];
             //   [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                   [SVProgressHUD showSuccessWithStatus:@"取消入库成功"];
            }else{
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                _editSureView.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _deleteBtn.hidden = YES;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = NO;
                
                _rightBtn.hidden = YES;
               
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
               
            }
        }else{
            
            _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _timeBtn.hidden = YES;
            
            _bottomview.hidden = YES;
            _checkAllBtn.hidden = YES;
            _savebottomBtn.hidden = YES;
            
            
            _editSureView.hidden = YES;
            _editBtn.hidden = YES;
            _sureBtn.hidden = YES;
            _deleteBtn.hidden = YES;
            
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _checkcancelAllBtn.hidden = YES;
            _saveBtn.hidden = YES;
            
            _cancelBtn.hidden = NO;
            
            _rightBtn.hidden = YES;
           
         [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}

//加载数据
//URL_LOADBILL_IOS
- (void)reloadOldSaveNewData{
    // 单据类型    billType    String    操作的单据类型  对应表详细见 单据类型对应
    // 单据ID    billid    Int
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    if ([self.showType isEqualToString:@"new"]) {
        [phoneDict setObject:[NSNumber numberWithInteger:self.billheadmodel.billid] forKey:@"billid"];
    }else{
        [phoneDict setObject:[NSNumber numberWithInteger:self.personalFunctionmodel.billid] forKey:@"billid"];
    }
    //[phoneDict setObject:[NSNumber numberWithInteger:self.personalFunctionmodel.billid] forKey:@"billid"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_LOADBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
               [weakSelf.dataArray removeAllObjects];
               weakSelf.secondBtnType = @"thisCheck";
                weakSelf.billheadmodel.billDate = json[@"data"][@"billHead"][@"billDate"];
                weakSelf.billheadmodel.billNo = json[@"data"][@"billHead"][@"billNo"];
                weakSelf.billheadmodel.billType = json[@"data"][@"billHead"][@"billType"];
                weakSelf.billheadmodel.billid = [json[@"data"][@"billHead"][@"billid"] integerValue];
                weakSelf.billheadmodel.blockNos = json[@"data"][@"billHead"][@"blockNos"];
                weakSelf.billheadmodel.createTime = json[@"data"][@"billHead"][@"createTime"];
                weakSelf.billheadmodel.createUser = [json[@"data"][@"billHead"][@"createUser"]integerValue];
                weakSelf.billheadmodel.mtlNames = json[@"data"][@"billHead"][@"mtlNames"];
                weakSelf.billheadmodel.pwmsUserId = [json[@"data"][@"billHead"][@"pwmsUserId"] integerValue];
                weakSelf.billheadmodel.status = [json[@"data"][@"billHead"][@"status"] integerValue];
                weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                //新增的4个值
                weakSelf.billheadmodel.totalTurnsQty = [json[@"data"][@"billHead"][@"totalTurnsQty"] integerValue];
                weakSelf.billheadmodel.totalDedArea = json[@"data"][@"billHead"][@"totalDedArea"];
                weakSelf.billheadmodel.totalArea = json[@"data"][@"billHead"][@"totalArea"];
                weakSelf.billheadmodel.totalPreArea = json[@"data"][@"billHead"][@"totalPreArea"];
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                
                NSMutableArray * temp = [NSMutableArray array];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                    slstoragemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    slstoragemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    slstoragemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slstoragemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slstoragemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    slstoragemanagementmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    slstoragemanagementmodel.slNo = [[array objectAtIndex:i]objectForKey:@"slNo"];
                    slstoragemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    slstoragemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    slstoragemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    
                    slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    slstoragemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    slstoragemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    slstoragemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    /**实际面积*/
                     slstoragemanagementmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    /**扣尺面积*/
                     slstoragemanagementmodel.dedArea = [[array objectAtIndex:i]objectForKey:@"dedArea"];
                    /**原始面积*/
                     slstoragemanagementmodel.preArea = [[array objectAtIndex:i]objectForKey:@"preArea"];
                    /**扣尺长1*/
                     slstoragemanagementmodel.dedLengthOne = [[array objectAtIndex:i]objectForKey:@"dedLengthOne"];
                    /**扣尺宽1*/
                     slstoragemanagementmodel.dedWidthOne = [[array objectAtIndex:i]objectForKey:@"dedWidthOne"];
                    
                    /**扣尺长2*/
                    slstoragemanagementmodel.dedLengthTwo = [[array objectAtIndex:i]objectForKey:@"dedLengthTwo"];
                    /**扣尺宽2*/
                    slstoragemanagementmodel.dedWidthTwo = [[array objectAtIndex:i]objectForKey:@"dedWidthTwo"];
                    
                    /**扣尺长3*/
                    slstoragemanagementmodel.dedLengthThree = [[array objectAtIndex:i]objectForKey:@"dedLengthThree"];
                    /**扣尺宽3*/
                    slstoragemanagementmodel.dedWidthThree = [[array objectAtIndex:i]objectForKey:@"dedWidthThree"];
                    
                    /**扣尺长4*/
                    slstoragemanagementmodel.dedLengthFour = [[array objectAtIndex:i]objectForKey:@"dedLengthFour"];
                    /**扣尺宽4*/
                    slstoragemanagementmodel.dedWidthFour = [[array objectAtIndex:i]objectForKey:@"dedWidthFour"];
                    slstoragemanagementmodel.isbool = false;
                    [temp addObject:slstoragemanagementmodel];
                }
                // [weakSelf.allArray addObjectsFromArray:weakSelf.dataArray];
                self.dataArray = [weakSelf changeArrayRule:temp];
                [weakSelf.tableview reloadData];
            }else{
                // [SVProgressHUD showErrorWithStatus:@"请求失败"];
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
                
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"请求失败"];
        }
    }];
}


- (void)newSaveBillNewData{
    NSInteger totalNumber = 0;
    NSInteger totalTurnsQty = 0;
    NSDecimalNumber * totalArea;
    NSDecimalNumber * totalPreArea;
    NSDecimalNumber * totalDedArea;
    double newPreArea = 0.0;
    double newArea = 0.0;
    double newDedArea = 0.0;
    for (int i = 0 ; i < self.allArray.count; i++) {
       NSMutableArray * array = self.allArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
            newPreArea += [slstoragemanagementmodel.preArea doubleValue];
            newArea += [slstoragemanagementmodel.area doubleValue];
            totalNumber += slstoragemanagementmodel.qty;
            newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
        }
    }
    totalTurnsQty = self.allArray.count;
    totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
    totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
     totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
    //,@"blockNos":@""
    NSDictionary * billHeadDict = @{@"billid":@"",@"billType":@"",@"pwmsUserId":@"",@"billNo":@"",@"billDate":_timeShowLabel.text,@"mtlNames":@"",@"SLockNos":@"",@"status":@"",@"whsId":@(self.warehousermodel.WareHouseID),@"storageType":@"",@"totalQty":@(totalNumber),@"totalTurnsQty":@(totalTurnsQty),@"totalPreArea":totalPreArea,@"totalDedArea":totalDedArea,@"totalArea":totalArea,@"createUser":@"",@"createTime":@"",@"updateUser":@"",@"updateTime":@"",@"checkUser":@"",@"checkTime":@"",@"whsName":self.warehousermodel.name};
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    for (int i = 0; i < self.allArray.count; i++) {
       NSMutableArray * tempArray = self.allArray[i];
        for (int j = 0; j < tempArray.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = tempArray[j];
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setObject:@"" forKey:@"billid"];
            [dict setObject:@"" forKey:@"billdtlid"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.mtlId] forKey:@"mtlId"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.storeareaId] forKey:@"storeareaId"];
            [dict setObject:slstoragemanagementmodel.blockNo forKey:@"blockNo"];
            [dict setObject:slstoragemanagementmodel.turnsNo forKey:@"turnsNo"];
            [dict setObject:slstoragemanagementmodel.slNo forKey:@"slNo"];
            //[dict setObject:slstoragemanagementmodel.SLockNo forKey:@"SLockNo"];
//            if (slstoragemanagementmodel.SLockNo == NULL) {
//                [dict setObject:@"" forKey:@"SLockNo"];
//            }else{
//                [dict setObject:slstoragemanagementmodel.SLockNo forKey:@"SLockNo"];
//            }
            [dict setObject:[NSNumber numberWithDouble:slstoragemanagementmodel.qty] forKey:@"qty"];
            [dict setObject:slstoragemanagementmodel.length forKey:@"length"];
            [dict setObject:slstoragemanagementmodel.width forKey:@"width"];
            [dict setObject:slstoragemanagementmodel.height forKey:@"height"];
            [dict setObject:slstoragemanagementmodel.preArea forKey:@"preArea"];
            [dict setObject:slstoragemanagementmodel.dedArea forKey:@"dedArea"];
            [dict setObject:slstoragemanagementmodel.area forKey:@"area"];
            [dict setObject:slstoragemanagementmodel.mtlName forKey:@"mtlName"];
            [dict setObject:slstoragemanagementmodel.mtltypeName forKey:@"mtltypeName"];
            [dict setObject:slstoragemanagementmodel.storeareaName forKey:@"storeareaName"];
            //[dict setObject:slstoragemanagementmodel.dedLengthOne forKey:@"dedLengthOne"];
            //[dict setObject:slstoragemanagementmodel.dedWidthOne forKey:@"dedWidthOne"];
            //[dict setObject:slstoragemanagementmodel.dedLengthTwo forKey:@"dedLengthTwo"];
            //[dict setObject:slstoragemanagementmodel.dedWidthTwo forKey:@"dedWidthTwo"];
            //[dict setObject:slstoragemanagementmodel.dedLengthThree forKey:@"dedLengthThree"];
            //[dict setObject:slstoragemanagementmodel.dedWidthThree forKey:@"dedWidthThree"];
            //[dict setObject:slstoragemanagementmodel.dedLengthFour forKey:@"dedLengthFour"];
            //[dict setObject:slstoragemanagementmodel.dedWidthFour forKey:@"dedWidthFour"];
            //[dict setObject:slstoragemanagementmodel.weight forKey:@"weight"];
            [array addObject:dict];
        }
    }
    [phoneDict setObject:array forKey:@"billDtl"];
    NSMutableArray * twoarray = [NSMutableArray array];
    [phoneDict setObject:twoarray forKey:@"billDtl2"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_SAVEBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.allArray removeAllObjects];
                weakSelf.secondBtnType = @"thisCheck";
                
                weakSelf.billheadmodel.billDate = json[@"data"][@"billHead"][@"billDate"];
                weakSelf.billheadmodel.billNo = json[@"data"][@"billHead"][@"billNo"];
                weakSelf.billheadmodel.billType = json[@"data"][@"billHead"][@"billType"];
                weakSelf.billheadmodel.billid = [json[@"data"][@"billHead"][@"billid"] integerValue];
                weakSelf.billheadmodel.blockNos = json[@"data"][@"billHead"][@"blockNos"];
                weakSelf.billheadmodel.createTime = json[@"data"][@"billHead"][@"createTime"];
                weakSelf.billheadmodel.createUser = [json[@"data"][@"billHead"][@"createUser"]integerValue];
                weakSelf.billheadmodel.mtlNames = json[@"data"][@"billHead"][@"mtlNames"];
                weakSelf.billheadmodel.pwmsUserId = [json[@"data"][@"billHead"][@"pwmsUserId"] integerValue];
                weakSelf.billheadmodel.status = [json[@"data"][@"billHead"][@"status"] integerValue];
                weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                
                //新增的4个值
                weakSelf.billheadmodel.totalTurnsQty = [json[@"data"][@"billHead"][@"totalTurnsQty"] integerValue];
                weakSelf.billheadmodel.totalDedArea = json[@"data"][@"billHead"][@"totalDedArea"];
                weakSelf.billheadmodel.totalArea = json[@"data"][@"billHead"][@"totalArea"];
                weakSelf.billheadmodel.totalPreArea = json[@"data"][@"billHead"][@"totalPreArea"];
   
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                
                 _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                
                
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                _editSureView.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _deleteBtn.hidden = NO;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
                
                
                _rightBtn.hidden = YES;
                
                
                NSMutableArray * temp = [NSMutableArray array];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                    slstoragemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    slstoragemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    slstoragemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slstoragemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slstoragemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    slstoragemanagementmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    slstoragemanagementmodel.slNo = [[array objectAtIndex:i]objectForKey:@"slNo"];
                    
                    slstoragemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    
                    slstoragemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    
                    slstoragemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    
                    slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    slstoragemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    slstoragemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    slstoragemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
//                    slstoragemanagementmodel.SLockNo =  [[array objectAtIndex:i]objectForKey:@"SLockNo"];
                    /**实际面积*/
                    slstoragemanagementmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    /**扣尺面积*/
                    slstoragemanagementmodel.dedArea = [[array objectAtIndex:i]objectForKey:@"dedArea"];
                    /**原始面积*/
                    slstoragemanagementmodel.preArea = [[array objectAtIndex:i]objectForKey:@"preArea"];
                    /**扣尺长1*/
                    slstoragemanagementmodel.dedLengthOne = [[array objectAtIndex:i]objectForKey:@"dedLengthOne"];
                    /**扣尺宽1*/
                    slstoragemanagementmodel.dedWidthOne = [[array objectAtIndex:i]objectForKey:@"dedWidthOne"];
                    
                    /**扣尺长2*/
                    slstoragemanagementmodel.dedLengthTwo = [[array objectAtIndex:i]objectForKey:@"dedLengthTwo"];
                    /**扣尺宽2*/
                    slstoragemanagementmodel.dedWidthTwo = [[array objectAtIndex:i]objectForKey:@"dedWidthTwo"];
                    
                    /**扣尺长3*/
                    slstoragemanagementmodel.dedLengthThree = [[array objectAtIndex:i]objectForKey:@"dedLengthThree"];
                    /**扣尺宽3*/
                    slstoragemanagementmodel.dedWidthThree = [[array objectAtIndex:i]objectForKey:@"dedWidthThree"];
                    
                    /**扣尺长4*/
                    slstoragemanagementmodel.dedLengthFour = [[array objectAtIndex:i]objectForKey:@"dedLengthFour"];
                    /**扣尺宽4*/
                    slstoragemanagementmodel.dedWidthFour = [[array objectAtIndex:i]objectForKey:@"dedWidthFour"];
                    slstoragemanagementmodel.isbool = false;
                    [temp addObject:slstoragemanagementmodel];
                }
                // [weakSelf.allArray addObjectsFromArray:weakSelf.dataArray];
                weakSelf.dataArray = [weakSelf changeArrayRule:temp];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                
                [weakSelf.tableview reloadData];
            }else{
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _addBtn.enabled = YES;
                _timeBtn.hidden = YES;
                
                _bottomview.hidden = NO;
                _checkAllBtn.hidden = NO;
                _savebottomBtn.hidden = NO;
                
                _editSureView.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _deleteBtn.hidden = YES;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
              
                 _rightBtn.hidden = YES;
               
                
                //  [SVProgressHUD showErrorWithStatus:@"获取失败"];
                
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
            }
        }else{
            _addBtn.enabled = YES;
            _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _timeBtn.hidden = YES;
            
            _bottomview.hidden = NO;
            _checkAllBtn.hidden = NO;
            _savebottomBtn.hidden = NO;
            
            _editSureView.hidden = YES;
            _editBtn.hidden = YES;
            _sureBtn.hidden = YES;
            _deleteBtn.hidden = YES;
            
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _checkcancelAllBtn.hidden = YES;
            _saveBtn.hidden = YES;
            
            _cancelBtn.hidden = YES;
            
            
            _rightBtn.hidden = YES;
            //[SVProgressHUD showErrorWithStatus:@"获取失败"];
           [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}



- (void)modifyAndSaveNewData{
    NSInteger totalNumber = 0;
    NSInteger totalTurnsQty = 0;
    NSDecimalNumber * totalArea;
    NSDecimalNumber * totalPreArea;
    NSDecimalNumber * totalDedArea;
    double newPreArea = 0.0;
    double newArea = 0.0;
    double newDedArea = 0.0;
    for (int i = 0 ; i < self.allArray.count; i++) {
        NSMutableArray * array = self.allArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = array[j];
            newPreArea += [slstoragemanagementmodel.preArea doubleValue];
            newArea += [slstoragemanagementmodel.area doubleValue];
            totalNumber += slstoragemanagementmodel.qty;
            newDedArea += [slstoragemanagementmodel.dedArea doubleValue];
        }
    }
    totalTurnsQty = self.allArray.count;
    totalPreArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newPreArea]];
    totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newArea]];
    totalDedArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newDedArea]];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    //@"blockNos":self.billheadmodel.blockNos
    NSDictionary * billHeadDict = @{@"billid":@(self.billheadmodel.billid),@"billType":self.billheadmodel.billType,@"pwmsUserId":@(self.billheadmodel.pwmsUserId),@"billNo":self.billheadmodel.billNo,@"billDate":_timeShowLabel.text,@"mtlNames":self.billheadmodel.mtlNames,@"SLockNos":@"",@"status":@(self.billheadmodel.status),@"whsId":@(self.billheadmodel.whsId),@"storageType":self.billheadmodel.storageType,@"totalQty":@(totalNumber),@"totalTurnsQty":@(totalTurnsQty),@"totalPreArea":totalPreArea,@"totalDedArea":totalDedArea,@"totalArea":totalArea,@"createUser":@(self.billheadmodel.createUser),@"createTime":self.billheadmodel.createTime,@"updateUser":@(self.billheadmodel.updateUser),@"updateTime":self.billheadmodel.updateTime,@"checkUser":@"",@"checkTime":@"",@"whsName":self.billheadmodel.whsName};
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    for (int i = 0; i < self.allArray.count; i++) {
        NSMutableArray * tempArray = self.allArray[i];
        for (int j = 0; j < tempArray.count; j++) {
            RSSLStoragemanagementModel * slstoragemanagementmodel = tempArray[j];
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.billid] forKey:@"billid"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.billdtlid] forKey:@"billdtlid"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.mtlId] forKey:@"mtlId"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
            [dict setObject:[NSNumber numberWithInteger:slstoragemanagementmodel.storeareaId] forKey:@"storeareaId"];
            [dict setObject:slstoragemanagementmodel.blockNo forKey:@"blockNo"];
            [dict setObject:slstoragemanagementmodel.turnsNo forKey:@"turnsNo"];
            [dict setObject:slstoragemanagementmodel.slNo forKey:@"slNo"];
//            if (slstoragemanagementmodel.SLockNo == NULL) {
//               [dict setObject:@"" forKey:@"SLockNo"];
//            }else{
//               [dict setObject:slstoragemanagementmodel.SLockNo forKey:@"SLockNo"];
//            }
            [dict setObject:[NSNumber numberWithDouble:slstoragemanagementmodel.qty] forKey:@"qty"];
            [dict setObject:slstoragemanagementmodel.length forKey:@"length"];
            [dict setObject:slstoragemanagementmodel.width forKey:@"width"];
            [dict setObject:slstoragemanagementmodel.height forKey:@"height"];
            [dict setObject:slstoragemanagementmodel.preArea forKey:@"preArea"];
            [dict setObject:slstoragemanagementmodel.dedArea forKey:@"dedArea"];
            [dict setObject:slstoragemanagementmodel.area forKey:@"area"];
            [dict setObject:slstoragemanagementmodel.mtlName forKey:@"mtlName"];
            [dict setObject:slstoragemanagementmodel.mtltypeName forKey:@"mtltypeName"];
            [dict setObject:slstoragemanagementmodel.storeareaName forKey:@"storeareaName"];
//            [dict setObject:slstoragemanagementmodel.dedLengthOne forKey:@"dedLengthOne"];
//            [dict setObject:slstoragemanagementmodel.dedWidthOne forKey:@"dedWidthOne"];
//            [dict setObject:slstoragemanagementmodel.dedLengthTwo forKey:@"dedLengthTwo"];
//            [dict setObject:slstoragemanagementmodel.dedWidthTwo forKey:@"dedWidthTwo"];
//            [dict setObject:slstoragemanagementmodel.dedLengthThree forKey:@"dedLengthThree"];
//            [dict setObject:slstoragemanagementmodel.dedWidthThree forKey:@"dedWidthThree"];
//            [dict setObject:slstoragemanagementmodel.dedLengthFour forKey:@"dedLengthFour"];
//            [dict setObject:slstoragemanagementmodel.dedWidthFour forKey:@"dedWidthFour"];
            //[dict setObject:slstoragemanagementmodel.weight forKey:@"weight"];
            [array addObject:dict];
        }
    }
    [phoneDict setObject:array forKey:@"billDtl"];
    NSMutableArray * twoarray = [NSMutableArray array];
    [phoneDict setObject:twoarray forKey:@"billDtl2"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_UPDATEBILL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.allArray removeAllObjects];
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                _editSureView.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _addBtn.enabled = NO;
                _deleteBtn.hidden = NO;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                _cancelBtn.hidden = YES;
                
                 _rightBtn.hidden = YES;
               
                weakSelf.secondBtnType = @"thisCheck";
                weakSelf.billheadmodel.billDate = json[@"data"][@"billHead"][@"billDate"];
                weakSelf.billheadmodel.billNo = json[@"data"][@"billHead"][@"billNo"];
                weakSelf.billheadmodel.billType = json[@"data"][@"billHead"][@"billType"];
                weakSelf.billheadmodel.billid = [json[@"data"][@"billHead"][@"billid"] integerValue];
                weakSelf.billheadmodel.blockNos = json[@"data"][@"billHead"][@"blockNos"];
                weakSelf.billheadmodel.createTime = json[@"data"][@"billHead"][@"createTime"];
                weakSelf.billheadmodel.createUser = [json[@"data"][@"billHead"][@"createUser"]integerValue];
                weakSelf.billheadmodel.mtlNames = json[@"data"][@"billHead"][@"mtlNames"];
                weakSelf.billheadmodel.pwmsUserId = [json[@"data"][@"billHead"][@"pwmsUserId"] integerValue];
                weakSelf.billheadmodel.status = [json[@"data"][@"billHead"][@"status"] integerValue];
                weakSelf.billheadmodel.storageType = json[@"data"][@"billHead"][@"storageType"];
                weakSelf.billheadmodel.totalQty = [json[@"data"][@"billHead"][@"totalQty"] integerValue];
                
                //新增的4个值
                weakSelf.billheadmodel.totalTurnsQty = [json[@"data"][@"billHead"][@"totalTurnsQty"] integerValue];
                weakSelf.billheadmodel.totalDedArea = json[@"data"][@"billHead"][@"totalDedArea"];
                weakSelf.billheadmodel.totalArea = json[@"data"][@"billHead"][@"totalArea"];
                weakSelf.billheadmodel.totalPreArea = json[@"data"][@"billHead"][@"totalPreArea"];
                
                //                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];
                //                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];
                
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                 _timeShowLabel.text = [NSString stringWithFormat:@"%@",json[@"data"][@"billHead"][@"billDate"]];
                NSMutableArray * temp = [NSMutableArray array];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSSLStoragemanagementModel * slstoragemanagementmodel = [[RSSLStoragemanagementModel alloc]init];
                    slstoragemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    slstoragemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    slstoragemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slstoragemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slstoragemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    slstoragemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    slstoragemanagementmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    slstoragemanagementmodel.slNo = [[array objectAtIndex:i]objectForKey:@"slNo"];
                    // slstoragemanagementmodel.preVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    // slstoragemanagementmodel.dedVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    // slstoragemanagementmodel.vaqty = [[array objectAtIndex:i]objectForKey:@"0.00"];
                    // slstoragemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    // slstoragemanagementmodel.name = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slstoragemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    slstoragemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    // slstoragemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    slstoragemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    
                    slstoragemanagementmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    slstoragemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    slstoragemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    slstoragemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
//                    slstoragemanagementmodel.SLockNo =  [[array objectAtIndex:i]objectForKey:@"SLockNo"];
                    /**实际面积*/
                    slstoragemanagementmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    /**扣尺面积*/
                    slstoragemanagementmodel.dedArea = [[array objectAtIndex:i]objectForKey:@"dedArea"];
                    /**原始面积*/
                    slstoragemanagementmodel.preArea = [[array objectAtIndex:i]objectForKey:@"preArea"];
                    /**扣尺长1*/
                    slstoragemanagementmodel.dedLengthOne = [[array objectAtIndex:i]objectForKey:@"dedLengthOne"];
                    /**扣尺宽1*/
                    slstoragemanagementmodel.dedWidthOne = [[array objectAtIndex:i]objectForKey:@"dedWidthOne"];
                    
                    /**扣尺长2*/
                    slstoragemanagementmodel.dedLengthTwo = [[array objectAtIndex:i]objectForKey:@"dedLengthTwo"];
                    /**扣尺宽2*/
                    slstoragemanagementmodel.dedWidthTwo = [[array objectAtIndex:i]objectForKey:@"dedWidthTwo"];
                    
                    /**扣尺长3*/
                    slstoragemanagementmodel.dedLengthThree = [[array objectAtIndex:i]objectForKey:@"dedLengthThree"];
                    /**扣尺宽3*/
                    slstoragemanagementmodel.dedWidthThree = [[array objectAtIndex:i]objectForKey:@"dedWidthThree"];
                    
                    /**扣尺长4*/
                    slstoragemanagementmodel.dedLengthFour = [[array objectAtIndex:i]objectForKey:@"dedLengthFour"];
                    /**扣尺宽4*/
                    slstoragemanagementmodel.dedWidthFour = [[array objectAtIndex:i]objectForKey:@"dedWidthFour"];
                    slstoragemanagementmodel.isbool = false;
                    [temp addObject:slstoragemanagementmodel];
                }
                // [weakSelf.allArray addObjectsFromArray:weakSelf.dataArray];
                weakSelf.dataArray = [weakSelf changeArrayRule:temp];
                [weakSelf.tableview reloadData];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                
            }else{
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _timeBtn.hidden = YES;
                
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                _editSureView.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _deleteBtn.hidden = YES;
                
                _allView.hidden = NO;
                _cancelEditBtn.hidden = NO;
                _checkcancelAllBtn.hidden = NO;
                _saveBtn.hidden = NO;
                
                _cancelBtn.hidden = YES;
                
                 _rightBtn.hidden = YES;
                
                //[SVProgressHUD showErrorWithStatus:@"获取失败"];
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
            }
        }else{
            _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _timeBtn.hidden = YES;
            
            _bottomview.hidden = YES;
            _checkAllBtn.hidden = YES;
            _savebottomBtn.hidden = YES;
            
            _editSureView.hidden = YES;
            _editBtn.hidden = YES;
            _sureBtn.hidden = YES;
            _deleteBtn.hidden = YES;
            
            _allView.hidden = NO;
            _cancelEditBtn.hidden = NO;
            _checkcancelAllBtn.hidden = NO;
            _saveBtn.hidden = NO;
            
            _cancelBtn.hidden = YES;
            
             _rightBtn.hidden = YES;
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


@end
