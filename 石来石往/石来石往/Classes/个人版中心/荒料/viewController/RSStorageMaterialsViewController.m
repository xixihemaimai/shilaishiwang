//
//  RSStorageMaterialsViewController.m
//  石来石往
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSStorageMaterialsViewController.h"
//荒料入库添加荒料
#import "RSAddingBlocksViewController.h"
//仓库界面
#import "RSWarehouseManagementViewController.h"
//扫描的界面
#import "MADCameraCaptureController.h"

//荒料入库扫描返回的模型
#import "RSOcrBlockJsonModel.h"
#import "RSOcrBlockDetailModel.h"

//荒料入库的模型
#import "RSSelectiveInventoryModel.h"

//荒料入库的cell
#import "RSExceptionHandlingSecondDetailCell.h"
#import "RSExceptionHanlingSecondCell.h"
#import "RSExceptionHandlingThirdCell.h"

#import "RSRightPitureButton.h"
#import "RSSaveAlertView.h"

//仓库的模型
#import "RSWarehouseModel.h"
//加载模型头部
#import "RSBillHeadModel.h"
//加载模型数据
#import "RSStoragemanagementModel.h"

#import "RSTemplateModel.h"
//新增单据保存，修改单据保存,加载单据

@interface RSStorageMaterialsViewController ()
/**仓库数据库的数组*/
//@property (nonatomic,strong)NSMutableArray * warehouseArray;
/**物料名称数据库的数组*/
//@property (nonatomic,strong)NSMutableArray * materiallArray;
{
    
    //入库时间
    UIButton * _timeBtn;
    //入库时间显示
    UILabel * _timeShowLabel;
    
    
    //这边是选择显示仓库的label
    UILabel * _warehouseDetailLabel;
    //这边是选择仓库界面跳转的按键
    UIButton * _addBtn;
    //扫描的按键
    UIButton * _scanBtn;
    //添加单条物料的按键
    UIButton * _addSecondBtn;
    
    //输入模板ID的
    //UITextField * _modelTextfield;
    
    //编辑和确认入库
    UIView * _editSureView;
    /**编辑*/
    UIButton * _editBtn;
    
    UIButton * _sureBtn;
    
    UIButton * _deleteBtn;
    
    //取消编辑 查看全部 保存
    UIView * _allView;
    
    UIButton * _cancelEditBtn;
  
    /**查看全部*/
    UIButton * _checkcancelAllBtn;
    /**保存*/
    UIButton * _saveBtn;
    
    //底部视图 查看全部 保存
    UIView * _bottomview;
    
    UIButton * _checkAllBtn;
    
    UIButton * _savebottomBtn;
    
    //取消入库
    UIButton * _cancelBtn;
    //合计
    RSRightPitureButton * _rightPictureBtn;
}

//本地扫描的数组
@property (nonatomic,strong)NSMutableArray * dataArray;
//查看全部的数组
@property (nonatomic,strong)NSMutableArray * allArray;
//荒料入库扫描的返回的模型
@property (nonatomic,strong)RSOcrBlockJsonModel * ocrBlockJsonModel;

@property (nonatomic,strong)RSSaveAlertView * saveAlertView;

//保存选择的按键的类型
@property (nonatomic,strong)NSString * btnType;

@property (nonatomic,strong)NSString * secondBtnType;

/**仓库的模型*/
@property (nonatomic,strong)RSWarehouseModel * warehousermodel;
/**仓库的选择的位置*/
@property (nonatomic,strong)RSBillHeadModel * billheadmodel;

@property (nonatomic,strong)NSMutableArray * templateArray;

@end

@implementation RSStorageMaterialsViewController

- (NSMutableArray *)templateArray{
    if (!_templateArray) {
        _templateArray = [NSMutableArray array];
    }
    return _templateArray;
}


- (RSBillHeadModel *)billheadmodel{
    if (!_billheadmodel) {
        _billheadmodel = [[RSBillHeadModel alloc]init];
    }
    return _billheadmodel;
}

- (NSMutableArray *)allArray{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

- (RSSaveAlertView *)saveAlertView{
    if (!_saveAlertView) {
         _saveAlertView = [[RSSaveAlertView alloc]initWithFrame:CGRectMake(0, SCH - 50 - 112, SCW, 112)];
    }
    return _saveAlertView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (RSWarehouseModel *)warehousermodel{
    if (!_warehousermodel) {
        _warehousermodel = [[RSWarehouseModel alloc]init];
    }
    return _warehousermodel;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.selectFunctionType;
    [self setUI];
    [self setTotalUI];
    //底部视图
    [self setUIBottomView];
    //编辑和确认入库
    [self seteditAndSureUI];
    //取消入库
    [self cancelSetUI];
    //取消编辑 查看全部 保存
    [self setUICancelEditAndAllAndSaveSetUI];
    
    //创建自定义导航栏
    [self setCustomNavigaionView];
    
    self.secondBtnType = @"thisCheck";
    if ([self.showType isEqualToString:@"new"]) {
        //点击新建的界面
        _bottomview.hidden = NO;
        _checkAllBtn.hidden = NO;
        _savebottomBtn.hidden = NO;
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _checkcancelAllBtn.hidden = YES;
        _saveBtn.hidden = YES;
        _cancelBtn.hidden = YES;
        _editSureView.hidden = YES;
        _editBtn.hidden = YES;
        _sureBtn.hidden = YES;
        _deleteBtn.hidden = YES;
        _addBtn.hidden = NO;
        _scanBtn.hidden = NO;
        _addSecondBtn.hidden = NO;
         self.btnType = @"edit";
        
        
        //新建是显示当前时间
        
        _timeShowLabel.text = [self showCurrentTime];
        _timeBtn.hidden = NO;
        
        [self reloadModelListNewData];
    }else{
        //点击cell跳转过来的值，要去加载数据
        _bottomview.hidden = YES;
        _checkAllBtn.hidden = YES;
        _savebottomBtn.hidden = YES;
        _allView.hidden = YES;
        _cancelEditBtn.hidden = YES;
        _checkcancelAllBtn.hidden = YES;
        _saveBtn.hidden = NO;
        _addBtn.hidden = YES;
        _scanBtn.hidden = YES;
        _addSecondBtn.hidden = YES;
        
        
        
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
        
        //新增
        _timeBtn.hidden = YES;
        
        
        [self reloadOldSaveNewData];
        
        [self reloadModelListNewData];
    }
}





- (void)reloadModelListNewData{
    // NSString * ulr = @"http://192.168.1.128:8080/slsw/pwms/modelList.do";
    //TableModel * tableModel = [[TableModel alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:@"BL" forKey:@"modelType"];
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
                NSInteger BL = [[user objectForKey:@"BL"] integerValue];
                //                if (SL == nil) {
                //                    [user setObject:@"" forKey:@"SL"];
                //                    [user synchronize];
                //                }
                if (weakSelf.templateArray.count < 1) {
                    [user setObject:@"" forKey:@"BL"];
                    [user synchronize];
                }else{
                    for (int i = 0; i < weakSelf.templateArray.count; i++) {
                        RSTemplateModel * templatemodel = weakSelf.templateArray[i];
                        if (templatemodel.tempID == BL) {
                            [user setObject:[NSNumber numberWithInteger:templatemodel.tempID] forKey:@"BL"];
                            [user synchronize];
                            break;
                        }else{
                            if (i == 0) {
                                [user setObject:[NSNumber numberWithInteger:templatemodel.tempID] forKey:@"BL"];
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


//荒料填写入库单和荒料填写入库单 copy2
- (void)setUI{
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
    // [addBtn setTitle:@"+" forState:UIControlStateNormal];
    // [addBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
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
    scanBtn.frame = CGRectMake(SCW - 50 - 62, 13, 62, 28);
    // scanLabel.text = @"扫描";
    [scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    //scanLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
    [scanBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FDAD32"]];
    [scanBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    //scanLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    //scanLabel.font = [UIFont systemFontOfSize:14];
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [scanBtn addTarget:self action:@selector(scanPurchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    //scanLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:scanBtn];
    scanBtn.layer.cornerRadius = 14;
    scanBtn.layer.masksToBounds = YES;
    _scanBtn = scanBtn;
    
    
    UIButton * addSecondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addSecondBtn.frame = CGRectMake(SCW - 12 - 28, 13, 28, 28);
    [addSecondBtn setImage:[UIImage imageNamed:@"个人版添加"] forState:UIControlStateNormal];
    // [addSecondBtn setTitle:@"+" forState:UIControlStateNormal];
    // [addSecondBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385FF"]];
    [secondView addSubview:addSecondBtn];
    addSecondBtn.layer.cornerRadius = addSecondBtn.yj_width * 0.5;
    [addSecondBtn addTarget:self action:@selector(addScanContentAction:) forControlEvents:UIControlEventTouchUpInside];
    _addSecondBtn = addSecondBtn;
    
    
    
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
    _editSureView.hidden = YES;
    
    //删除
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(0, 0, SCW/3 -1, 50);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [_editSureView addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn = deleteBtn;
     _deleteBtn.hidden = YES;
    
    
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
    _editBtn.hidden = YES;
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
    _sureBtn.hidden = YES;
}


//取消编辑 查看全部 保存
- (void)setUICancelEditAndAllAndSaveSetUI{
    
    UIView * allView = [[UIView alloc]init];
    allView.frame = CGRectMake(0, SCH - 50, SCW, 50);
    allView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:allView];
    _allView = allView;
    _allView.hidden = YES;
    
    UIButton * cancelEditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelEditBtn.frame = CGRectMake(0, 0, SCW/3 - 1, 50);
    [cancelEditBtn setTitle:@"取消编辑" forState:UIControlStateNormal];
    [cancelEditBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [cancelEditBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    cancelEditBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelEditBtn addTarget:self action:@selector(allViewCancelEditBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [allView addSubview:cancelEditBtn];
    _cancelEditBtn = cancelEditBtn;
    _cancelEditBtn.hidden = YES;
    
    UIButton * checkcancelAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkcancelAllBtn.frame = CGRectMake(CGRectGetMaxX(cancelEditBtn.frame) + 1 , 0, SCW/3 - 1, 50);
    [checkcancelAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [checkcancelAllBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    checkcancelAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [allView addSubview:checkcancelAllBtn];
    [checkcancelAllBtn addTarget:self action:@selector(allViewcheckCancelAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _checkcancelAllBtn = checkcancelAllBtn;
    _checkcancelAllBtn.hidden = YES;
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(CGRectGetMaxX(checkcancelAllBtn.frame) + 1 , 0, SCW/3, 50);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
       [saveBtn addTarget:self action:@selector(allViewchecksaveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [allView addSubview:saveBtn];
    _saveBtn = saveBtn;
    _saveBtn.hidden = YES;
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
    _cancelBtn.hidden = YES;
}




//新建查看全部
- (void)checkAllAndScanAction:(UIButton *)checkAllBtn{
    if ([checkAllBtn.currentTitle isEqualToString:@"查看全部"]) {
        //查看全部
        [self.allArray addObjectsFromArray:self.dataArray];
        [self.dataArray removeAllObjects];
        [checkAllBtn setTitle:@"本次扫描" forState:UIControlStateNormal];
        //self.btnType = @"checkAll";
        self.secondBtnType = @"checkAll";
    }else{
        //本地扫描
        //self.btnType = @"thisCheck";
        self.secondBtnType = @"thisCheck";
        [checkAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    }
    [self.tableview reloadData];
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
                
                _timeBtn.hidden = YES;
                
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                _editSureView.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _deleteBtn.hidden = NO;
                _addBtn.hidden = NO;
                _scanBtn.hidden = NO;
                _addSecondBtn.hidden = YES;
                
                
                
                UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"错误提醒" message:[NSString stringWithFormat:@"%@",json[@"msg"]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertView addAction:alert];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [weakSelf presentViewController:alertView animated:YES completion:nil];
            }
        }else{
            _timeBtn.hidden = YES;
            _bottomview.hidden = YES;
            _checkAllBtn.hidden = YES;
            _savebottomBtn.hidden = YES;
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _checkcancelAllBtn.hidden = YES;
            _saveBtn.hidden = YES;
            _cancelBtn.hidden = YES;
            _editSureView.hidden = NO;
            _editBtn.hidden = NO;
            _sureBtn.hidden = NO;
            _deleteBtn.hidden = NO;
            _addBtn.hidden = NO;
            _scanBtn.hidden = NO;
            _addSecondBtn.hidden = YES;
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


//编辑和确认入库中的编辑
- (void)editSureViewAndEditAction:(UIButton *)editBtn{
    _bottomview.hidden = YES;
    _checkAllBtn.hidden = YES;
    _savebottomBtn.hidden = YES;
    _allView.hidden = NO;
    _cancelEditBtn.hidden = NO;
    _checkcancelAllBtn.hidden = NO;
    _saveBtn.hidden = NO;
    _cancelBtn.hidden = YES;
    _editSureView.hidden = YES;
    _editBtn.hidden = YES;
    _sureBtn.hidden = YES;
    _deleteBtn.hidden = YES;
    _addBtn.hidden = NO;
    _scanBtn.hidden = NO;
    _addSecondBtn.hidden = NO;
    
    _timeBtn.hidden = NO;
    //这边编辑可以让仓库cell编辑
    self.btnType = @"edit";
    [self.tableview reloadData];
    
    _checkcancelAllBtn.selected = NO;
    [_checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    _addBtn.enabled = YES;

}

//编辑和确认入库中的确认入库
- (void)editSureViewAndSureAction:(UIButton *)sureBtn{
    self.btnType = @"save";
    //这边调用确认单据接口
//    _bottomview.hidden = YES;
//    _checkAllBtn.hidden = YES;
//    _savebottomBtn.hidden = YES;
//    _allView.hidden = YES;
//    _cancelEditBtn.hidden = YES;
//    _checkcancelAllBtn.hidden = YES;
//    _saveBtn.hidden = NO;
//    _cancelBtn.hidden = NO;
//    _editSureView.hidden = YES;
//    _editBtn.hidden = YES;
//    _sureBtn.hidden = YES;
//     _deleteBtn.hidden = YES;
//    _addBtn.hidden = YES;
//    _scanBtn.hidden = YES;
//    _addSecondBtn.hidden = YES;
    //这边有一个接口
    //URL_CONFIRMBILL_IOS
    [self sureStorageBillNewData];
}



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
                
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                
                
                _cancelBtn.hidden = NO;
                _editSureView.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _deleteBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                
                
                _timeBtn.hidden = YES;
               // [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                
                [SVProgressHUD showSuccessWithStatus:@"确认入库成功"];
                
            }else{
                
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                
                _editSureView.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _deleteBtn.hidden = NO;
                
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                
                _timeBtn.hidden = YES;
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
            
            _bottomview.hidden = YES;
            _checkAllBtn.hidden = YES;
            _savebottomBtn.hidden = YES;
            
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _checkcancelAllBtn.hidden = YES;
            _saveBtn.hidden = YES;
            _cancelBtn.hidden = YES;
            
            _editSureView.hidden = NO;
            _editBtn.hidden = NO;
            _sureBtn.hidden = NO;
            _deleteBtn.hidden = NO;
            
            _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _addSecondBtn.hidden = YES;
            _timeBtn.hidden = YES;
            [SVProgressHUD showErrorWithStatus:@"入库失败"];
        }
    }];
}


//取消入库中的取消入库的按键
- (void)cancelBtnAction:(UIButton *)cancelBtn{
      self.btnType = @"save";
    // 这边调用取消确认单据接口
//    _bottomview.hidden = YES;
//    _checkAllBtn.hidden = YES;
//    _savebottomBtn.hidden = YES;
//    _allView.hidden = YES;
//    _cancelEditBtn.hidden = YES;
//    _checkcancelAllBtn.hidden = YES;
//    _saveBtn.hidden = YES;
//    _cancelBtn.hidden = YES;
//    _editSureView.hidden = NO;
//    _editBtn.hidden = NO;
//    _sureBtn.hidden = NO;
//     _deleteBtn.hidden = NO;
//    _addBtn.hidden = YES;
//    _scanBtn.hidden = YES;
//    _addSecondBtn.hidden = YES;
    //这边有一个接口
     //URL_UNCONFIRMBILL_IOS
    [self cancelStorageBillNewData];
}

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
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                _editSureView.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _deleteBtn.hidden = NO;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                _timeBtn.hidden = YES;
                
                [weakSelf.tableview reloadData];
               // [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                  [SVProgressHUD showSuccessWithStatus:@"取消入库成功"];
            }else{
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = NO;
                _editSureView.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                _deleteBtn.hidden = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                _timeBtn.hidden = YES;
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
            _bottomview.hidden = YES;
            _checkAllBtn.hidden = YES;
            _savebottomBtn.hidden = YES;
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _checkcancelAllBtn.hidden = YES;
            _saveBtn.hidden = YES;
            _cancelBtn.hidden = NO;
            _editSureView.hidden = YES;
            _editBtn.hidden = YES;
            _sureBtn.hidden = YES;
            _deleteBtn.hidden = YES;
            _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _addSecondBtn.hidden = YES;
            _timeBtn.hidden = YES;
           [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}



//新建的保存
- (void)saveCurrentDataAction:(UIButton *)savebottomBtn{
    
    if (self.dataArray.count > 0) {
        if ([self testingDataComplete]) {
            //[_modelTextfield resignFirstResponder];
            [self.allArray addObjectsFromArray:self.dataArray];
            self.btnType = @"save";
            [self newSaveBillNewData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"数据不完整"];
        }
    }else if (self.allArray.count > 0){
        self.btnType = @"save";
        [self newSaveBillNewData];
    }else{
        [SVProgressHUD showInfoWithStatus:@"数据不完整"];
    }
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
               // weakSelf.dataArray = [RSPersonalFunctionModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
               // weakSelf.billheadmodel = [RSBillHeadModel mj_objectWithKeyValues:json[@"data"][@"billHead"]];
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
                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];
                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                 weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                 weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                 weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@", json[@"data"][@"billHead"][@"billDate"]];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    storagemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    storagemanagementmodel.turnsNo = @"";
                    storagemanagementmodel.slNo = @"";
                    storagemanagementmodel.preVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.dedVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.vaqty = [[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    storagemanagementmodel.name = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.qty =  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    storagemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    [weakSelf.dataArray addObject:storagemanagementmodel];
                }

                [weakSelf.tableview reloadData];
//                [weakSelf.allArray addObjectsFromArray:weakSelf.dataArray];
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                
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
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                _timeBtn.hidden = YES;
            }
        }else{
             _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _addSecondBtn.hidden = YES;
            _timeBtn.hidden = YES;
           [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}





//URL_SAVEBILL_IOS 新增单据保存
- (void)newSaveBillNewData{
    NSInteger totalNumber = 0;
    NSDecimalNumber * totalArea;
    NSDecimalNumber * totalWeight;
    double newWeight = 0.0;
    double newVolume = 0.0;
    for (int i = 0 ; i < self.allArray.count; i++) {
        RSStoragemanagementModel * storagemanagementmodel = self.allArray[i];
        newWeight += [storagemanagementmodel.weight doubleValue];
        newVolume += [storagemanagementmodel.volume doubleValue];
        totalNumber += storagemanagementmodel.qty;
    }
    totalWeight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newWeight]];
    totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newVolume]];
    NSDictionary * billHeadDict = @{@"billid":@"",@"billType":@"",@"pwmsUserId":@"",@"billNo":@"",@"billDate":_timeShowLabel.text,@"storageType":@"",@"mtlNames":@"",@"blockNos":@"",@"status":@"",@"whsId":@(self.warehousermodel.WareHouseID),@"whsName":self.warehousermodel.name,@"totalVolume":totalArea,@"totalWeight":totalWeight,@"createUser":@"",@"createTime":@"",@"updateUser":@"",@"updateTime":@"",@"checkUser":@"",@"checkTime":@"",@"totalQty":@(totalNumber)};
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    
    for (int i = 0; i < self.allArray.count; i++) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            RSStoragemanagementModel * storagemanagementmodel = self.allArray[i];
            [dict setObject:@"" forKey:@"billid"];
            [dict setObject:@"" forKey:@"billdtlid"];
            [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.materialId] forKey:@"mtlId"];
            [dict setObject:@"-1" forKey:@"storeareaId"];
            [dict setObject:storagemanagementmodel.mtlName forKey:@"mtlName"];
            [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
            [dict setObject:storagemanagementmodel.mtltypeName forKey:@"mtltypeName"];
            [dict setObject:@"" forKey:@"storeareaName"];
            [dict setObject:storagemanagementmodel.blockNo forKey:@"blockNo"];
            [dict setObject:[NSNumber numberWithDouble:storagemanagementmodel.qty] forKey:@"qty"];
            [dict setObject:storagemanagementmodel.length forKey:@"length"];
            [dict setObject:storagemanagementmodel.width forKey:@"width"];
            [dict setObject:storagemanagementmodel.height forKey:@"height"];
            [dict setObject:storagemanagementmodel.vaqty forKey:@"volume"];
            [dict setObject:storagemanagementmodel.weight forKey:@"weight"];
            [array addObject:dict];
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
                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];
                
                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];
                
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                _warehouseDetailLabel.text = self.billheadmodel.whsName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@", json[@"data"][@"billHead"][@"billDate"]];
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                _editSureView.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                 _deleteBtn.hidden = NO;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                _timeBtn.hidden = YES;
               //weakSelf.dataArray = [RSStoragemanagementModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"billDtl"]];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    storagemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    storagemanagementmodel.turnsNo = @"";
                    storagemanagementmodel.slNo = @"";
                    storagemanagementmodel.preVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.dedVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.vaqty = [[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    storagemanagementmodel.name = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                     storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                     storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.qty =  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    storagemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    [weakSelf.dataArray addObject:storagemanagementmodel];
                }
                [weakSelf.tableview reloadData];
                if (weakSelf.reload) {
                    weakSelf.reload(true);
                }
                _addBtn.enabled = NO;
            }else{
                _bottomview.hidden = NO;
                _checkAllBtn.hidden = NO;
                _savebottomBtn.hidden = NO;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                _editSureView.hidden = YES;
                _editBtn.hidden = YES;
                _sureBtn.hidden = YES;
                 _deleteBtn.hidden = YES;
                _addBtn.enabled = YES;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                _timeBtn.hidden = YES;
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
            _bottomview.hidden = NO;
            _checkAllBtn.hidden = NO;
            _savebottomBtn.hidden = NO;
            _allView.hidden = YES;
            _cancelEditBtn.hidden = YES;
            _checkcancelAllBtn.hidden = YES;
            _saveBtn.hidden = YES;
            _cancelBtn.hidden = YES;
            _editSureView.hidden = YES;
            _editBtn.hidden = YES;
            _sureBtn.hidden = YES;
             _deleteBtn.hidden = YES;
            _addBtn.enabled = YES;
            _addBtn.hidden = YES;
            _scanBtn.hidden = YES;
            _addSecondBtn.hidden = YES;
            _timeBtn.hidden = YES;
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}


//取消编辑 查看全部 保存----取消编辑
- (void)allViewCancelEditBtnAction:(UIButton *)cancelEditBtn{
    _bottomview.hidden = YES;
    _checkAllBtn.hidden = YES;
    _savebottomBtn.hidden = YES;
    _allView.hidden = YES;
    _cancelEditBtn.hidden = YES;
    _checkcancelAllBtn.hidden = YES;
    _saveBtn.hidden = YES;
    _cancelBtn.hidden = YES;
    _editSureView.hidden = NO;
    _editBtn.hidden = NO;
    _sureBtn.hidden = NO;
     _deleteBtn.hidden = NO;
    _addBtn.hidden = YES;
    _scanBtn.hidden = YES;
    _addSecondBtn.hidden = YES;
    _timeBtn.hidden = YES;
    self.btnType = @"save";
    [self.allArray removeAllObjects];
    [self reloadOldSaveNewData];
   // [self.tableview reloadData];
}




//取消编辑 查看全部 保存----查看全部
- (void)allViewcheckCancelAllBtnAction:(UIButton *)checkcancelAllBtn{
    if ([self testingDataComplete]) {
        checkcancelAllBtn.selected = !checkcancelAllBtn.selected;
        if (checkcancelAllBtn.selected) {
//            self.btnType = @"checkAll";
            self.secondBtnType = @"checkAll";
            [self.allArray addObjectsFromArray:self.dataArray];
            [self.dataArray removeAllObjects];
            [checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#1A63CE"]];
        }else{
//            self.btnType = @"thisCheck";
            self.secondBtnType = @"thisCheck";
            [checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        }
        [self.tableview reloadData];
    }else{
        
        [SVProgressHUD showInfoWithStatus:@"数据不完整"];
    }
}

//取消编辑 查看全部 保存----保存
- (void)allViewchecksaveBtnAction:(UIButton *)saveBtn{
     //这边按键要调用修改单据保存接口
    if (self.dataArray.count > 0) {
        if ([self testingDataComplete]) {
            [self.allArray addObjectsFromArray:self.dataArray];
            self.btnType = @"save";
            [self modifyAndSaveNewData];
        }
    }else if(self.allArray.count > 0){
        self.btnType = @"save";
        [self modifyAndSaveNewData];
    }else{
        
        [SVProgressHUD showInfoWithStatus:@"数据不完整"];
    }
}

//修改保存网路请求
- (void)modifyAndSaveNewData{
    NSInteger totalNumber = 0;
    NSDecimalNumber * totalVolume;
    NSDecimalNumber * totalWeight;
    double newWeight = 0.0;
    double newVolume = 0.0;
    for (int i = 0 ; i < self.allArray.count; i++) {
        RSStoragemanagementModel * storagemanagementmodel = self.allArray[i];
        newWeight += [storagemanagementmodel.weight doubleValue];
        newVolume += [storagemanagementmodel.volume doubleValue];
        totalNumber += storagemanagementmodel.qty;
    }
    totalWeight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newWeight]];
    totalVolume = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newVolume]];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:self.selectShow forKey:@"billType"];
    NSDictionary * billHeadDict = @{@"billid":@(self.billheadmodel.billid),@"billType":self.billheadmodel.billType,@"pwmsUserId":@(self.billheadmodel.pwmsUserId),@"billNo":self.billheadmodel.billNo,@"billDate":_timeShowLabel.text,@"storageType":self.billheadmodel.storageType,@"mtlNames":self.billheadmodel.mtlNames,@"blockNos":self.billheadmodel.blockNos,@"status":@(self.billheadmodel.status),@"whsId":@(self.billheadmodel.whsId),@"whsName":self.billheadmodel.whsName,@"totalVolume":totalVolume,@"totalWeight":totalWeight,@"createUser":@(self.billheadmodel.createUser),@"createTime":self.billheadmodel.createTime,@"updateUser":@(self.billheadmodel.updateUser),@"updateTime":self.billheadmodel.updateTime,@"checkUser":@"",@"checkTime":@"",@"totalQty":@(totalNumber)};
    [phoneDict setObject:billHeadDict forKey:@"billHead"];
    NSMutableArray  * array = [NSMutableArray array];
    for (int i = 0; i < self.allArray.count; i++) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            RSStoragemanagementModel * storagemanagementmodel = self.allArray[i];
            [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.billid] forKey:@"billid"];
            [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.billdtlid] forKey:@"billdtlid"];
            [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtlId] forKey:@"mtlId"];
            [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.storeareaId] forKey:@"storeareaId"];
            [dict setObject:storagemanagementmodel.mtlName forKey:@"mtlName"];
            [dict setObject:storagemanagementmodel.mtltypeName forKey:@"mtltypeName"];
        if (storagemanagementmodel.storeareaName == NULL) {
             [dict setObject:@"" forKey:@"storeareaName"];
        }else{
             [dict setObject:storagemanagementmodel.storeareaName forKey:@"storeareaName"];
        }
        [dict setObject:storagemanagementmodel.blockNo forKey:@"blockNo"];
            [dict setObject:[NSNumber numberWithInteger:storagemanagementmodel.mtltypeId] forKey:@"mtltypeId"];
            [dict setObject:[NSNumber numberWithDouble:storagemanagementmodel.qty] forKey:@"qty"];
            [dict setObject:storagemanagementmodel.length forKey:@"length"];
            [dict setObject:storagemanagementmodel.width forKey:@"width"];
            [dict setObject:storagemanagementmodel.height forKey:@"height"];
            [dict setObject:storagemanagementmodel.volume forKey:@"volume"];
            [dict setObject:storagemanagementmodel.weight forKey:@"weight"];
            [array addObject:dict];
    }
    [phoneDict setObject:array forKey:@"billDtl"];
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
                weakSelf.secondBtnType = @"thisCheck";
                _bottomview.hidden = YES;
                _checkAllBtn.hidden = YES;
                _savebottomBtn.hidden = YES;
                _allView.hidden = YES;
                _cancelEditBtn.hidden = YES;
                _checkcancelAllBtn.hidden = YES;
                _saveBtn.hidden = YES;
                _cancelBtn.hidden = YES;
                _editSureView.hidden = NO;
                _editBtn.hidden = NO;
                _sureBtn.hidden = NO;
                _addBtn.enabled = NO;
                 _deleteBtn.hidden = NO;
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
                _timeBtn.hidden = YES;
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
                
                weakSelf.billheadmodel.totalVolume = json[@"data"][@"billHead"][@"totalVolume"];
                
                weakSelf.billheadmodel.totalWeight = json[@"data"][@"billHead"][@"totalWeight"];
                
                weakSelf.billheadmodel.updateTime = json[@"data"][@"billHead"][@"updateTime"];
                weakSelf.billheadmodel.updateUser = [json[@"data"][@"billHead"][@"updateUser"] integerValue];
                weakSelf.billheadmodel.whsId = [json[@"data"][@"billHead"][@"whsId"] integerValue];
                weakSelf.billheadmodel.whsName = json[@"data"][@"billHead"][@"whsName"];
                _warehouseDetailLabel.text = weakSelf.billheadmodel.whsName;
                _timeShowLabel.text = [NSString stringWithFormat:@"%@", json[@"data"][@"billHead"][@"billDate"]];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"][@"billDtl"];
                for (int i = 0; i < array.count; i++) {
                    RSStoragemanagementModel * storagemanagementmodel = [[RSStoragemanagementModel alloc]init];
                    storagemanagementmodel.billdtlid = [[[array objectAtIndex:i]objectForKey:@"billdtlid"]integerValue];
                    storagemanagementmodel.billid = [[[array objectAtIndex:i]objectForKey:@"billid"] integerValue];
                    storagemanagementmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.storeareaId = [[[array objectAtIndex:i]objectForKey:@"storeareaId"]integerValue];
                    storagemanagementmodel.storeareaName = [[array objectAtIndex:i]objectForKey:@"storeareaName"];
                    storagemanagementmodel.turnsNo = @"";
                    storagemanagementmodel.slNo = @"";
                    storagemanagementmodel.preVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.dedVaqty =[[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.vaqty = [[array objectAtIndex:i]objectForKey:@"0.00"];
                    storagemanagementmodel.volume = [[array objectAtIndex:i]objectForKey:@"volume"];
                    storagemanagementmodel.name = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    storagemanagementmodel.mtltypeName = [[array objectAtIndex:i]objectForKey:@"mtltypeName"];
                    storagemanagementmodel.mtltypeId = [[[array objectAtIndex:i]objectForKey:@"mtltypeId"] integerValue];
                    storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.mtlId = [[[array objectAtIndex:i]objectForKey:@"mtlId"] integerValue];
                    storagemanagementmodel.qty =  storagemanagementmodel.materialId = [[[array objectAtIndex:i]objectForKey:@"qty"] integerValue];
                    storagemanagementmodel.length =  [[array objectAtIndex:i]objectForKey:@"length"];
                    storagemanagementmodel.width = [[array objectAtIndex:i]objectForKey:@"width"];
                    storagemanagementmodel.height = [[array objectAtIndex:i]objectForKey:@"height"];
                    storagemanagementmodel.weight = [[array objectAtIndex:i]objectForKey:@"weight"];
                    [weakSelf.dataArray addObject:storagemanagementmodel];
                }
                [weakSelf.tableview reloadData];
            }else{
                _addBtn.hidden = YES;
                _scanBtn.hidden = YES;
                _addSecondBtn.hidden = YES;
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
                _cancelBtn.hidden = NO;
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
            _addSecondBtn.hidden = YES;
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
            _cancelBtn.hidden = NO;
           [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    }];
}




- (void)openAndCloseAction:(UIButton *)rightPictureBtn{
    rightPictureBtn.selected = !rightPictureBtn.selected;
    if (rightPictureBtn.selected) {
        NSInteger totalNumber = 0;
        NSDecimalNumber * totalWeight;
          NSDecimalNumber * totalArea;
//        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
              totalNumber =self.allArray.count;
            double newWeight =0.0;
            double newVolume = 0.0;
            for (int i = 0 ; i < self.allArray.count; i++) {
                RSStoragemanagementModel * storagemanagementmodel = self.allArray[i];
                newWeight += [storagemanagementmodel.weight doubleValue];
                newVolume += [storagemanagementmodel.volume doubleValue];
            }
            totalWeight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newWeight]];
            totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newVolume]];
        }else{
             totalNumber =self.dataArray.count;
            double newWeight =0.0;
            double newVolume = 0.0;
            for (int i = 0 ; i < self.dataArray.count; i++) {
                RSStoragemanagementModel * storagemanagementmodel = self.dataArray[i];
                newWeight += [storagemanagementmodel.weight doubleValue];
                newVolume += [storagemanagementmodel.volume doubleValue];
            }
            totalWeight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newWeight]];
             totalArea = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.3lf",newVolume]];
        }
        self.saveAlertView.totalNumber = [NSString stringWithFormat:@"%ld",(long)totalNumber];
        self.saveAlertView.totalArea = [NSString stringWithFormat:@"%0.3lf",[totalArea doubleValue]];
        self.saveAlertView.totalWeight = [NSString stringWithFormat:@"%0.3lf",[totalWeight doubleValue]];
        self.saveAlertView.selectFunctionType = self.selectFunctionType;
        self.saveAlertView.selectType = self.selectType;
        [self.saveAlertView showView];
        rightPictureBtn.frame = CGRectMake(0, SCH - 86 - 112, SCW, 36);
    }else{
        rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
        [self.saveAlertView closeView];
    }
}



//荒料入库-采购入库
- (void)addScanContentAction:(UIButton *)addSecondBtn{
    if (self.dataArray.count < 1) {
        RSAddingBlocksViewController * addingBlocksVc = [[RSAddingBlocksViewController alloc]init];
        addingBlocksVc.entryType = @"new";
        addingBlocksVc.usermodel = self.usermodel;
        addingBlocksVc.selectType = self.selectType;
        addingBlocksVc.selectFunctionType = self.selectFunctionType;
        [self.navigationController pushViewController:addingBlocksVc animated:YES];
        addingBlocksVc.newModel = ^(RSStoragemanagementModel * _Nonnull storagemanagementmodel, NSString * _Nonnull entryType, NSInteger index, NSString * _Nonnull newreload) {
            //是添加那个数组中
          //  if ([self.btnType isEqualToString:@"checkAll"]) {
            if ([self.secondBtnType isEqualToString:@"checkAll"]) {
                //查看全部的时候
                [self.allArray addObject:storagemanagementmodel];
                [self.tableview reloadData];
            }else{
                //当前数组
                [self.dataArray addObject:storagemanagementmodel];
                [self.tableview reloadData];
            }
        };
    }else{
        if ([self testingDataComplete]) {
            if (![_warehouseDetailLabel.text isEqualToString:@"请选择仓库"]) {
                RSAddingBlocksViewController * addingBlocksVc = [[RSAddingBlocksViewController alloc]init];
                addingBlocksVc.entryType = @"new";
                addingBlocksVc.usermodel = self.usermodel;
                addingBlocksVc.selectType = self.selectType;
                addingBlocksVc.selectFunctionType = self.selectFunctionType;
                [self.navigationController pushViewController:addingBlocksVc animated:YES];
                addingBlocksVc.newModel = ^(RSStoragemanagementModel * _Nonnull storagemanagementmodel, NSString * _Nonnull entryType, NSInteger index, NSString * _Nonnull newreload) {
                    //是添加那个数组中
//                    if ([self.btnType isEqualToString:@"checkAll"]) {
                  if ([self.secondBtnType isEqualToString:@"checkAll"]) {
                        //查看全部的时候
                        [self.allArray addObject:storagemanagementmodel];
                        [self.tableview reloadData];
                    }else{
                        //当前数组
                        [self.dataArray addObject:storagemanagementmodel];
                        [self.tableview reloadData];
                    }
                };
            }else{
                [SVProgressHUD showInfoWithStatus:@"请先选择仓库"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"数据不完整"];
        }
    }
}
//荒料入库的编辑按钮
- (void)exceptionHandlingProductEidtAction:(UIButton *)productEidtBtn{
//    if ([self.btnType isEqualToString:@"checkAll"]) {
    if ([self.secondBtnType isEqualToString:@"checkAll"]) {
        RSStoragemanagementModel * storagemanagementmodel = self.allArray[productEidtBtn.tag];
        RSAddingBlocksViewController * addingBlocksVc = [[RSAddingBlocksViewController alloc]init];
        addingBlocksVc.storagemanagementmodel = storagemanagementmodel;
        addingBlocksVc.usermodel = self.usermodel;
        addingBlocksVc.entryType = @"edit";
        addingBlocksVc.index = productEidtBtn.tag;
        addingBlocksVc.selectType = self.selectType;
        addingBlocksVc.selectFunctionType = self.selectFunctionType;
        [self.navigationController pushViewController:addingBlocksVc animated:YES];
        addingBlocksVc.newModel = ^(RSStoragemanagementModel * _Nonnull storagemanagementmodel, NSString * _Nonnull entryType, NSInteger index, NSString * _Nonnull newreload) {
//            if ([self.btnType isEqualToString:@"checkAll"]) {
         if ([self.secondBtnType isEqualToString:@"checkAll"]) {
                //查看全部的时候
                [self.allArray replaceObjectAtIndex:index withObject:storagemanagementmodel];
                [self.tableview reloadData];
            }else{
                //当前数组
                [self.dataArray replaceObjectAtIndex:index withObject:storagemanagementmodel];
                [self.tableview reloadData];
            }
        };
    }else{
        RSStoragemanagementModel * storagemanagementmodel = self.dataArray[productEidtBtn.tag];
        RSAddingBlocksViewController * addingBlocksVc = [[RSAddingBlocksViewController alloc]init];
        addingBlocksVc.storagemanagementmodel = storagemanagementmodel;
        addingBlocksVc.usermodel = self.usermodel;
        addingBlocksVc.entryType = @"edit";
        addingBlocksVc.index = productEidtBtn.tag;
        addingBlocksVc.selectType = self.selectType;
        addingBlocksVc.selectFunctionType = self.selectFunctionType;
        [self.navigationController pushViewController:addingBlocksVc animated:YES];
        addingBlocksVc.newModel = ^(RSStoragemanagementModel * _Nonnull storagemanagementmodel, NSString * _Nonnull entryType, NSInteger index, NSString * _Nonnull newreload) {
//            if ([self.btnType isEqualToString:@"checkAll"]) {
            if ([self.secondBtnType isEqualToString:@"checkAll"]) {
                //查看全部的时候
                [self.allArray replaceObjectAtIndex:index withObject:storagemanagementmodel];
                [self.tableview reloadData];
            }else{
                //当前数组
                [self.dataArray replaceObjectAtIndex:index withObject:storagemanagementmodel];
                [self.tableview reloadData];
            }
        };
    }
}

//仓库
- (void)addWarehouseAction:(UIButton *)addBtn{
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

//扫描
- (void)scanPurchaseAction:(UIButton *)scanBtn{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSInteger BL = [[user objectForKey:@"BL"] integerValue];
    
    //&& BL != [NSNull null]
    if (self.templateArray.count > 0) {
        if (![_warehouseDetailLabel.text isEqualToString:@"请选择仓库"]) {
            //这边要判断数据是否完整性
//            [_modelTextfield resignFirstResponder];
            //荒料入库
            if (self.dataArray.count < 1) {
                MADCameraCaptureController *vc = [[MADCameraCaptureController alloc] init];
                vc.selectType = self.selectType;
                vc.modelId = BL;
                vc.templateArray = self.templateArray;
                [self.navigationController pushViewController:vc animated:YES];
                //if (![_modelTextfield.text isEqualToString:@""]) {
                  //  vc.modelId = [_modelTextfield.text integerValue];
                //}else{
//                    vc.modelId = 0;
                //}
               
                RSWeakself
                vc.scanHuangLuSuccess = ^(NSArray *array) {
                    [SVProgressHUD dismiss];
                    [weakSelf.dataArray removeAllObjects];
                    if ([self.showType isEqualToString:@"new"]) {
                        //self.btnType = @"thisCheck";
                        self.secondBtnType = @"thisCheck";
                        //[_checkAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                        [_checkAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
                    }else{
                        //self.btnType = @"thisCheck";
                        self.secondBtnType = @"thisCheck";
                        [_checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                        _checkcancelAllBtn.selected = NO;
                    }
                    RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:MATERIALSQL];
                    self.dataArray = [db searchNameContent:array];
                    [self.tableview reloadData];
                };
            }else{
                if ([self testingDataComplete]) {
                    //成功
                    [self.allArray addObjectsFromArray:self.dataArray];
                    MADCameraCaptureController *vc = [[MADCameraCaptureController alloc] init];
                    vc.selectType = self.selectType;
                    
                    vc.templateArray = self.templateArray;
                    vc.modelId = BL;
                    [self.navigationController pushViewController:vc animated:YES];
                  
//                    if (![_modelTextfield.text isEqualToString:@""]) {
//                        vc.modelId = [_modelTextfield.text integerValue];
//                    }else{
//                        vc.modelId = 0;
//                    }
                    RSWeakself
                    vc.scanHuangLuSuccess = ^(NSArray *array) {
                        [weakSelf.dataArray removeAllObjects];
                        [SVProgressHUD dismiss];
                        
                        if ([self.showType isEqualToString:@"new"]) {
                            
                            //                              self.btnType = @"thisCheck";
                            self.secondBtnType = @"thisCheck";
                            //[_checkAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                            [_checkAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
                            
                        }else{
                            
                            //                              self.btnType = @"thisCheck";
                            self.secondBtnType = @"thisCheck";
                            [_checkcancelAllBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
                            _checkcancelAllBtn.selected = NO;
                        }
                        
                        
                        RSPersonlPublishDB * db = [[RSPersonlPublishDB alloc]initWithCreatTypeList:MATERIALSQL];
                        self.dataArray = [db searchNameContent:array];
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


//- (BOOL)testAllArrayDataComplete{
//    for (int i = 0; i < self.allArray.count; i++){
//        RSStoragemanagementModel * storagemanagementmodel = self.allArray[i];
//        if ([storagemanagementmodel.mtlName isEqualToString:@""] || [storagemanagementmodel.mtltypeName isEqualToString:@""] || [storagemanagementmodel.blockNo isEqualToString:@""] || [storagemanagementmodel.length doubleValue] <= 0.000 ||  [storagemanagementmodel.width doubleValue] <= 0.00 || [storagemanagementmodel.height doubleValue]<= 0.000 || storagemanagementmodel.qty < 1  || [storagemanagementmodel.volume doubleValue]<= 0.000 || [storagemanagementmodel.weight doubleValue] <= 0.000) {
//            return NO;
//        }
//    }
//    return YES;
//}


- (BOOL)testingDataComplete{
    //荒料里面需要原始 平方数/立方数dedVaqty没有匝号和板号，原始 平方数/立方数也不需要 preVaqty,大板有匝号和板号原始 平方数/立方数需要 preVaqty但是不要// 原始 平方数/立方数dedVaqty
    for (int i = 0; i < self.dataArray.count; i++) {
        //|| [storagemanagementmodel.weight doubleValue] <= 0.000
        RSStoragemanagementModel * storagemanagementmodel = self.dataArray[i];
        if ([storagemanagementmodel.mtlName isEqualToString:@""] || [storagemanagementmodel.mtltypeName isEqualToString:@""] || [storagemanagementmodel.blockNo isEqualToString:@""] || [storagemanagementmodel.length doubleValue] <= 0.000 ||  [storagemanagementmodel.width doubleValue]<= 0.000 || [storagemanagementmodel.height doubleValue]<= 0.000 || storagemanagementmodel.qty < 1  || [storagemanagementmodel.volume doubleValue]<= 0.000 ) {
                return NO;
        }
    }
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 217;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)exceptionHandlingProductDeleteAction:(UIButton *)productDeleteBtn{
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"是否删除该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.showType isEqualToString:@"new"]) {
            //新建
//            if ([self.btnType isEqualToString:@"checkAll"]) {
              if ([self.secondBtnType isEqualToString:@"checkAll"]) {
                [self.allArray removeObjectAtIndex:productDeleteBtn.tag];
            }else{
                //self.btnType = @"new";
                [self.dataArray removeObjectAtIndex:productDeleteBtn.tag];
            }
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [self.tableview reloadData];
            [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }else{
            //加载
//            if ([self.btnType isEqualToString:@"checkAll"]) {
              if ([self.secondBtnType isEqualToString:@"checkAll"]) {
                [self.allArray removeObjectAtIndex:productDeleteBtn.tag];
            }else{
                //self.btnType = @"new";
                [self.dataArray removeObjectAtIndex:productDeleteBtn.tag];
            }
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [self.tableview reloadData];
             [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.showType isEqualToString:@"new"]) {
        //static NSString * EXCEPTIONHANDLINGFILLID = @"EXCEPTIONHANDLINGFILLID";
        
        NSString *identifier = [NSString stringWithFormat:@"EXCEPTIONHANDLINGFILLID%ld%ld",(long)indexPath.section,(long)indexPath.row];
        RSExceptionHandlingSecondDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[RSExceptionHandlingSecondDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
//        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            RSStoragemanagementModel * storagemanagementmodel = self.allArray[indexPath.row];
            cell.storagemaanagementmodel = storagemanagementmodel;
        }else{
            RSStoragemanagementModel * storagemanagementmodel = self.dataArray[indexPath.row];
            cell.storagemaanagementmodel = storagemanagementmodel;
        }
        cell.productEidtBtn.tag = indexPath.row;
        cell.productDeleteBtn.tag = indexPath.row;
        [cell.productEidtBtn addTarget:self action:@selector(exceptionHandlingProductEidtAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.productDeleteBtn addTarget:self action:@selector(exceptionHandlingProductDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        //|| [self.btnType isEqualToString:@"checkAll"] || [self.btnType isEqualToString:@"thisCheck"]
        if ([self.btnType isEqualToString:@"edit"] ) {
            cell.productEidtBtn.enabled = YES;
            cell.productDeleteBtn.enabled = YES;
            cell.productDeleteBtn.hidden = NO;
            cell.productEidtBtn.hidden = NO;
        }
        else{
            cell.productDeleteBtn.enabled = NO;
            cell.productDeleteBtn.hidden = YES;
            cell.productEidtBtn.hidden = YES;
            cell.productEidtBtn.enabled = NO;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        //加载老数据
        //static NSString * OLDEXCEPTIONHANLINGLLID = @"OLDEXCEPTIONHANLINGLLID";
        
         NSString *identifier = [NSString stringWithFormat:@"OLDEXCEPTIONHANLINGLLID%ld%ld",(long)indexPath.section,(long)indexPath.row];
        
        RSExceptionHandlingSecondDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[RSExceptionHandlingSecondDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
//        if ([self.btnType isEqualToString:@"checkAll"]) {
        if ([self.secondBtnType isEqualToString:@"checkAll"]) {
            RSStoragemanagementModel * storagemanagementmodel = self.allArray[indexPath.row];
            cell.storagemaanagementmodel = storagemanagementmodel;
        }else{
            RSStoragemanagementModel * storagemanagementmodel = self.dataArray[indexPath.row];
            cell.storagemaanagementmodel = storagemanagementmodel;
        }
        if ([self.showType isEqualToString:@"reload"]) {
            cell.productDeleteBtn.enabled = NO;
            cell.productDeleteBtn.hidden = YES;
            cell.productEidtBtn.hidden = YES;
            cell.productEidtBtn.enabled = NO;
        }
        //|| [self.btnType isEqualToString:@"thisCheck"] || [self.btnType isEqualToString:@"checkAll"]
        if ([self.btnType isEqualToString:@"edit"] ) {
            cell.productEidtBtn.enabled = YES;
            cell.productEidtBtn.hidden = NO;
            cell.productDeleteBtn.enabled = YES;
            cell.productDeleteBtn.hidden = NO;
        }
//        else if ([self.btnType isEqualToString:@"canceledit"]){
//            cell.productDeleteBtn.enabled = NO;
//            cell.productDeleteBtn.hidden = YES;
//            cell.productEidtBtn.hidden = YES;
//            cell.productEidtBtn.enabled = NO;
//        }else if ([self.btnType isEqualToString:@"save"]){
//            cell.productDeleteBtn.enabled = NO;
//            cell.productDeleteBtn.hidden = YES;
//            cell.productEidtBtn.hidden = YES;
//            cell.productEidtBtn.enabled = NO;
//        }
        else{
            cell.productDeleteBtn.enabled = NO;
            cell.productDeleteBtn.hidden = YES;
            cell.productEidtBtn.hidden = YES;
            cell.productEidtBtn.enabled = NO;
        }
        cell.productEidtBtn.tag = indexPath.row;
        cell.productDeleteBtn.tag = indexPath.row;
        [cell.productEidtBtn addTarget:self action:@selector(exceptionHandlingProductEidtAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.productDeleteBtn addTarget:self action:@selector(exceptionHandlingProductDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _rightPictureBtn.frame = CGRectMake(0, SCH - 86, SCW, 36);
    [self.saveAlertView closeView];
}


@end
